Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbRAHVom>; Mon, 8 Jan 2001 16:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132702AbRAHVoX>; Mon, 8 Jan 2001 16:44:23 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:22535 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131434AbRAHVoQ>; Mon, 8 Jan 2001 16:44:16 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200101082144.WAA15690@green.mif.pg.gda.pl>
Subject: [PATCH] partition endianness fixes
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
Date: Mon, 8 Jan 2001 22:44:17 +0100 (CET)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch fixes in 2.4(-ac*) :
- endiannes problems with BSD/SOLARIS disklabel (in msdos a partition)
  and OSF partition support on big-endian mashines,
- SOLARIS disklabel support on 64-bit machines (it was silently assumed
  in the on-disk structures that "long" is 32 bit...)

Regards

diff -ur linux-2.4.0-ac3/fs/partitions/msdos.c linux/fs/partitions/msdos.c
--- linux-2.4.0-ac3/fs/partitions/msdos.c	Mon Nov 13 23:10:28 2000
+++ linux/fs/partitions/msdos.c	Mon Jan  8 00:22:07 2001
@@ -200,13 +200,14 @@
 	if(!(bh = get_partition_table_block(hd, minor, 0)))
 		return;
 	v = (struct solaris_x86_vtoc *)(bh->b_data + 512);
-	if(v->v_sanity != SOLARIS_X86_VTOC_SANE) {
+	if(le32_to_cpu(v->v_sanity) != SOLARIS_X86_VTOC_SANE) {
 		brelse(bh);
 		return;
 	}
 	printk(" %s: <solaris:", disk_name(hd, minor, buf));
-	if(v->v_version != 1) {
-		printk("  cannot handle version %ld vtoc>\n", v->v_version);
+	if(le32_to_cpu(v->v_version) != 1) {
+		printk("  cannot handle version %d vtoc>\n",
+			le32_to_cpu(v->v_version));
 		brelse(bh);
 		return;
 	}
@@ -220,7 +221,8 @@
 		 * one but add_gd_partition starts relative to sector
 		 * zero of the disk.  Therefore, must add the offset
 		 * of the current partition */
-		add_gd_partition(hd, current_minor, s->s_start+offset, s->s_size);
+		add_gd_partition(hd, current_minor, le32_to_cpu(s->s_start)+offset,
+				 le32_to_cpu(s->s_size));
 		current_minor++;
 	}
 	brelse(bh);
@@ -237,21 +239,22 @@
 	for (lin_p = hd->part + 1 + minor;
 	     lin_p - hd->part - minor < current_minor; lin_p++) {
 			/* no relationship -> try again */
-		if (lin_p->start_sect + lin_p->nr_sects <= bsd_p->p_offset ||
-		    lin_p->start_sect >= bsd_p->p_offset + bsd_p->p_size)
+		if (lin_p->start_sect + lin_p->nr_sects <= le32_to_cpu(bsd_p->p_offset) ||
+		    lin_p->start_sect >= le32_to_cpu(bsd_p->p_offset) + le32_to_cpu(bsd_p->p_size))
 			continue;	
 			/* equal -> no need to add */
-		if (lin_p->start_sect == bsd_p->p_offset && 
-			lin_p->nr_sects == bsd_p->p_size) 
+		if (lin_p->start_sect == le32_to_cpu(bsd_p->p_offset) && 
+			lin_p->nr_sects == le32_to_cpu(bsd_p->p_size)) 
 			return;
 			/* bsd living within dos partition */
-		if (lin_p->start_sect <= bsd_p->p_offset && lin_p->start_sect 
-			+ lin_p->nr_sects >= bsd_p->p_offset + bsd_p->p_size) {
+		if (lin_p->start_sect <= le32_to_cpu(bsd_p->p_offset) && lin_p->start_sect 
+			+ lin_p->nr_sects >= le32_to_cpu(bsd_p->p_offset) + le32_to_cpu(bsd_p->p_size)) {
 #ifdef DEBUG_BSD_DISKLABEL
 			printk("w: %d %ld+%ld,%d+%d", 
 				lin_p - hd->part, 
 				lin_p->start_sect, lin_p->nr_sects, 
-				bsd_p->p_offset, bsd_p->p_size);
+				le32_to_cpu(bsd_p->p_offset),
+				le32_to_cpu(bsd_p->p_size));
 #endif
 			break;
 		}
@@ -259,14 +262,15 @@
 #ifdef DEBUG_BSD_DISKLABEL
 		printk("???: %d %ld+%ld,%d+%d",
 			lin_p - hd->part, lin_p->start_sect, lin_p->nr_sects,
-			bsd_p->p_offset, bsd_p->p_size);
+			le32_to_cpu(bsd_p->p_offset), le32_to_cpu(bsd_p->p_size));
 #endif
 		printk("???");
 		return;
 	} /* if the bsd partition is not currently known to linux, we end
 	   * up here 
 	   */
-	add_gd_partition(hd, current_minor, bsd_p->p_offset, bsd_p->p_size);
+	add_gd_partition(hd, current_minor, le32_to_cpu(bsd_p->p_offset),
+			 le32_to_cpu(bsd_p->p_size));
 	current_minor++;
 }
 
@@ -285,7 +289,7 @@
 	if (!(bh = get_partition_table_block(hd, minor, 0)))
 		return;
 	l = (struct bsd_disklabel *) (bh->b_data+512);
-	if (l->d_magic != BSD_DISKMAGIC) {
+	if (le32_to_cpu(l->d_magic) != BSD_DISKMAGIC) {
 		brelse(bh);
 		return;
 	}
@@ -295,8 +299,8 @@
 
 	max_partitions = ((type == OPENBSD_PARTITION) ? OPENBSD_MAXPARTITIONS
 			                              : BSD_MAXPARTITIONS);
-	if (l->d_npartitions < max_partitions)
-		max_partitions = l->d_npartitions;
+	if (le16_to_cpu(l->d_npartitions) < max_partitions)
+		max_partitions = le16_to_cpu(l->d_npartitions);
 	for (p = l->d_partitions; p - l->d_partitions <  max_partitions; p++) {
 		if ((current_minor & mask) >= (4 + hd->max_p))
 			break;
diff -ur linux-2.4.0-ac3/fs/partitions/osf.c linux/fs/partitions/osf.c
--- linux-2.4.0-ac3/fs/partitions/osf.c	Thu Feb 17 00:42:06 2000
+++ linux/fs/partitions/osf.c	Mon Jan  8 21:24:54 2001
@@ -62,21 +62,21 @@
 	}
 	label = (struct disklabel *) (bh->b_data+64);
 	partition = label->d_partitions;
-	if (label->d_magic != DISKLABELMAGIC) {
+	if (le32_to_cpu(label->d_magic) != DISKLABELMAGIC) {
 		brelse(bh);
 		return 0;
 	}
-	if (label->d_magic2 != DISKLABELMAGIC) {
+	if (le32_to_cpu(label->d_magic2) != DISKLABELMAGIC) {
 		brelse(bh);
 		return 0;
 	}
-	for (i = 0 ; i < label->d_npartitions; i++, partition++) {
+	for (i = 0 ; i < le16_to_cpu(label->d_npartitions); i++, partition++) {
 		if ((current_minor & mask) == 0)
 		        break;
-		if (partition->p_size)
+		if (le32_to_cpu(partition->p_size))
 			add_gd_partition(hd, current_minor,
-				first_sector+partition->p_offset,
-				partition->p_size);
+				first_sector+le32_to_cpu(partition->p_offset),
+				le32_to_cpu(partition->p_size));
 		current_minor++;
 	}
 	printk("\n");
diff -ur linux-2.4.0-ac3/include/linux/genhd.h linux/include/linux/genhd.h
--- linux-2.4.0-ac3/include/linux/genhd.h	Sun Jan  7 23:27:25 2001
+++ linux/include/linux/genhd.h	Mon Jan  8 21:22:06 2001
@@ -83,21 +83,21 @@
 struct solaris_x86_slice {
 	ushort	s_tag;			/* ID tag of partition */
 	ushort	s_flag;			/* permision flags */
-	daddr_t s_start;		/* start sector no of partition */
-	long	s_size;			/* # of blocks in partition */
+	unsigned int s_start;		/* start sector no of partition */
+	unsigned int s_size;		/* # of blocks in partition */
 };
 
 struct solaris_x86_vtoc {
-		unsigned long v_bootinfo[3];	/* info needed by mboot (unsupported) */
-	unsigned long v_sanity;		/* to verify vtoc sanity */
-	unsigned long v_version;	/* layout version */
+	unsigned int v_bootinfo[3];	/* info needed by mboot (unsupported) */
+	unsigned int v_sanity;		/* to verify vtoc sanity */
+	unsigned int v_version;		/* layout version */
 	char	v_volume[8];		/* volume name */
 	ushort	v_sectorsz;		/* sector size in bytes */
 	ushort	v_nparts;		/* number of partitions */
-	unsigned long v_reserved[10];	/* free space */
+	unsigned int v_reserved[10];	/* free space */
 	struct solaris_x86_slice
 		v_slice[SOLARIS_X86_NUMSLICE]; /* slice headers */
-	time_t	timestamp[SOLARIS_X86_NUMSLICE]; /* timestamp (unsupported) */
+	unsigned int timestamp[SOLARIS_X86_NUMSLICE]; /* timestamp (unsupported) */
 	char	v_asciilabel[128];	/* for compatibility */
 };
 


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
