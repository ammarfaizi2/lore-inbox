Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbSJDA4D>; Thu, 3 Oct 2002 20:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261417AbSJDA4D>; Thu, 3 Oct 2002 20:56:03 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:20732 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S261405AbSJDA4A>; Thu, 3 Oct 2002 20:56:00 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15772.59494.694761.451243@wombat.chubb.wattle.id.au>
Date: Fri, 4 Oct 2002 11:01:26 +1000
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] Large Block device patch part 3/4
In-Reply-To: <Pine.LNX.4.33.0210031323590.23619-100000@penguin.transmeta.com>
References: <15772.42409.841005.571964@wombat.chubb.wattle.id.au>
	<Pine.LNX.4.33.0210031323590.23619-100000@penguin.transmeta.com>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I've removed all traces of the GCC 64-bit div/mod helpers.

Here's the patch (pullable as before from
bk://gelato.unsw.edu.au:2023)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.678   -> 1.679  
#	 drivers/md/Makefile	1.6     -> 1.7    
#	  drivers/md/raid5.c	1.51    -> 1.52   
#	     drivers/md/md.c	1.114   -> 1.115  
#	  drivers/md/raid0.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	peterc@gelato.unsw.edu.au	1.679
#   Get rid of need for GCC _udivdi3 and _umoddi3 helper functions 
# -- use sector_div more aggressively.
# --------------------------------------------
#
diff -Nru a/drivers/md/Makefile b/drivers/md/Makefile
--- a/drivers/md/Makefile	Fri Oct  4 10:59:14 2002
+++ b/drivers/md/Makefile	Fri Oct  4 10:59:14 2002
@@ -20,15 +20,3 @@
 
 include $(TOPDIR)/Rules.make
 
-# I can't get around the need for 64-bit division in raid[0-5]
-ifdef CONFIG_LBD
-
-LIBGCC:= $(shell ${CC} ${CFLAGS} -print-libgcc-file-name)
-
-md.o: md.c _udivdi3.o _umoddi3.o
-	$(CC) $(c_flags) -c -o md-tmp.o md.c
-	$(LD) -r  -o md.o md-tmp.o _udivdi3.o _umoddi3.o
-
-_udivdi3.o _umoddi3.o: $(LIBGCC)
-	$(AR) x $(LIBGCC) $@
-endif
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Fri Oct  4 10:59:14 2002
+++ b/drivers/md/md.c	Fri Oct  4 10:59:14 2002
@@ -3480,12 +3480,6 @@
 }
 #endif
 
-#ifdef CONFIG_LBD
-extern u64 __udivdi3(u64, u64);
-extern u64 __umoddi3(u64, u64);
-EXPORT_SYMBOL(__udivdi3);
-EXPORT_SYMBOL(__umoddi3);
-#endif
 EXPORT_SYMBOL(md_size);
 EXPORT_SYMBOL(register_md_personality);
 EXPORT_SYMBOL(unregister_md_personality);
diff -Nru a/drivers/md/raid0.c b/drivers/md/raid0.c
--- a/drivers/md/raid0.c	Fri Oct  4 10:59:14 2002
+++ b/drivers/md/raid0.c	Fri Oct  4 10:59:14 2002
@@ -144,7 +144,7 @@
 
 		zone->nb_dev = c;
 		zone->size = (smallest->size - current_offset) * c;
-		printk("raid0: zone->nb_dev: %d, size: %ld\n",zone->nb_dev,zone->size);
+		printk("raid0: zone->nb_dev: %d, size: %llu\n",zone->nb_dev, (unsigned long long)zone->size);
 
 		if (!conf->smallest || (zone->size < conf->smallest->size))
 			conf->smallest = zone;
@@ -180,9 +180,15 @@
 		goto out_free_conf;
 
 	printk("raid0 : md_size is %llu blocks.\n", (unsigned long long)md_size[mdidx(mddev)]);
-	printk("raid0 : conf->smallest->size is %ld blocks.\n", conf->smallest->size);
-	nb_zone = md_size[mdidx(mddev)]/conf->smallest->size +
-		(md_size[mdidx(mddev)] % conf->smallest->size ? 1 : 0);
+	printk("raid0 : conf->smallest->size is %llu blocks.\n", (unsigned long long)conf->smallest->size);
+	{
+#if __GNUC__ < 3
+		volatile
+#endif
+		sector_t s = md_size[mdidx(mddev)];
+		int round = sector_div(s, (unsigned long)conf->smallest->size) ? 1 : 0;
+		nb_zone = s + round;
+	}
 	printk("raid0 : nb_zone is %d.\n", nb_zone);
 	conf->nr_zones = nb_zone;
 
@@ -277,10 +283,16 @@
 	chunk_size = mddev->chunk_size >> 10;
 	chunksize_bits = ffz(~chunk_size);
 	block = bio->bi_sector >> 1;
-	hash = conf->hash_table + block / conf->smallest->size;
+	
+
+	{
+		sector_t x = block;
+		sector_div(x, (unsigned long)conf->smallest->size);
+		hash = conf->hash_table + x;
+	}
 
 	/* Sanity check */
-	if (chunk_size < (block % chunk_size) + (bio->bi_size >> 10))
+	if (chunk_size < (block & (chunk_size - 1)) + (bio->bi_size >> 10))
 		goto bad_map;
  
 	if (!hash)
@@ -297,8 +309,18 @@
 		zone = hash->zone0;
     
 	sect_in_chunk = bio->bi_sector & ((chunk_size<<1) -1);
-	chunk = (block - zone->zone_offset) / (zone->nb_dev << chunksize_bits);
-	tmp_dev = zone->dev[(block >> chunksize_bits) % zone->nb_dev];
+
+
+	{
+		sector_t x =  block - zone->zone_offset;
+
+		sector_div(x, (zone->nb_dev << chunksize_bits));
+		chunk = x;
+		BUG_ON(x != (sector_t)chunk);
+
+		x = block >> chunksize_bits;
+		tmp_dev = zone->dev[sector_div(x, zone->nb_dev)];
+	}
 	rsect = (((chunk << chunksize_bits) + zone->dev_offset)<<1)
 		+ sect_in_chunk;
  
diff -Nru a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c	Fri Oct  4 10:59:14 2002
+++ b/drivers/md/raid5.c	Fri Oct  4 10:59:14 2002
@@ -30,13 +30,15 @@
 
 #define NR_STRIPES		256
 #define STRIPE_SIZE		PAGE_SIZE
+#define STRIPE_SHIFT		(PAGE_SHIFT - 9)
 #define STRIPE_SECTORS		(STRIPE_SIZE>>9)
 #define	IO_THRESHOLD		1
 #define HASH_PAGES		1
 #define HASH_PAGES_ORDER	0
 #define NR_HASH			(HASH_PAGES * PAGE_SIZE / sizeof(struct stripe_head *))
 #define HASH_MASK		(NR_HASH - 1)
-#define stripe_hash(conf, sect)	((conf)->stripe_hashtbl[((sect) / STRIPE_SECTORS) & HASH_MASK])
+
+#define stripe_hash(conf, sect)	((conf)->stripe_hashtbl[((sect) >> STRIPE_SHIFT) & HASH_MASK])
 
 /*
  * The following can be used to debug the driver
@@ -482,7 +484,7 @@
 			unsigned int data_disks, unsigned int * dd_idx,
 			unsigned int * pd_idx, raid5_conf_t *conf)
 {
-	sector_t stripe;
+	long stripe;
 	unsigned long chunk_number;
 	unsigned int chunk_offset;
 	sector_t new_sector;
@@ -493,8 +495,9 @@
 	/*
 	 * Compute the chunk number and the sector offset inside the chunk
 	 */
-	chunk_number = r_sector / sectors_per_chunk;
-	chunk_offset = r_sector % sectors_per_chunk;
+	chunk_offset = sector_div(r_sector, sectors_per_chunk);
+	chunk_number = r_sector;
+	BUG_ON(r_sector != chunk_number);
 
 	/*
 	 * Compute the stripe number
@@ -548,11 +551,16 @@
 	int raid_disks = conf->raid_disks, data_disks = raid_disks - 1;
 	sector_t new_sector = sh->sector, check;
 	int sectors_per_chunk = conf->chunk_size >> 9;
-	sector_t stripe = new_sector / sectors_per_chunk;
-	int chunk_offset = new_sector % sectors_per_chunk;
+	long stripe;
+	int chunk_offset;
 	int chunk_number, dummy1, dummy2, dd_idx = i;
 	sector_t r_sector;
 
+	chunk_offset = sector_div(new_sector, sectors_per_chunk);
+	stripe = new_sector;
+	BUG_ON(new_sector != stripe);
+
+	
 	switch (conf->algorithm) {
 		case ALGORITHM_LEFT_ASYMMETRIC:
 		case ALGORITHM_RIGHT_ASYMMETRIC:
@@ -570,7 +578,7 @@
 	}
 
 	chunk_number = stripe * data_disks + i;
-	r_sector = chunk_number * sectors_per_chunk + chunk_offset;
+	r_sector = (sector_t)chunk_number * sectors_per_chunk + chunk_offset;
 
 	check = raid5_compute_sector (r_sector, raid_disks, data_disks, &dummy1, &dummy2, conf);
 	if (check != sh->sector || dummy1 != dd_idx || dummy2 != sh->pd_idx) {
@@ -1285,8 +1293,9 @@
 	raid5_conf_t *conf = (raid5_conf_t *) mddev->private;
 	struct stripe_head *sh;
 	int sectors_per_chunk = conf->chunk_size >> 9;
-	unsigned long stripe = sector_nr/sectors_per_chunk;
-	int chunk_offset = sector_nr % sectors_per_chunk;
+	sector_t x;
+	unsigned long stripe;
+	int chunk_offset;
 	int dd_idx, pd_idx;
 	unsigned long first_sector;
 	int raid_disks = conf->raid_disks;
@@ -1295,6 +1304,11 @@
 	if (sector_nr >= mddev->size <<1)
 		/* just being told to finish up .. nothing to do */
 		return 0;
+
+	x = sector_nr;
+	chunk_offset = sector_div(x, sectors_per_chunk);
+	stripe = x;
+	BUG_ON(x != stripe);
 
 	first_sector = raid5_compute_sector(stripe*data_disks*sectors_per_chunk
 		+ chunk_offset, raid_disks, data_disks, &dd_idx, &pd_idx, conf);

