Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286413AbSBODSN>; Thu, 14 Feb 2002 22:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286447AbSBODSC>; Thu, 14 Feb 2002 22:18:02 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:28155
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S286413AbSBODR4>; Thu, 14 Feb 2002 22:17:56 -0500
Date: Thu, 14 Feb 2002 19:18:09 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Michael Cohen <me@ohdarn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-mjc2 & Rmap12f [PATCH]
Message-ID: <20020215031809.GA15362@matchmail.com>
Mail-Followup-To: Michael Cohen <me@ohdarn.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 11:58:28PM -0500, Michael Cohen wrote:
> The latest version of the -mjc branch has been released.  It is
> available at:
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/mjc/linux-2.4/patch-2.4.18-pre9-mjc2.bz2
> --------------------------------------------------------------
> [ A great deal of patches have been removed, in interest of keeping this
> branch as close to the standard 2.4 series as possible.]
> [ I am now using bitkeeper, and my bk tree is available at
> bk://ohdarn.net/linux-mjc.  it is cloned from linus's 2.4 tree so
> please, please, please clone from him and pull from me. ]
> 
> 
> 2.4.18-pre9-ac3				(Alan Cox et al)
> Reverse Mapping VM Patch #12e		(Rik van Riel)

Here's rmap12f:

I'm not sure I murged mm/bootmem.c correctly, can someone take a look?

diff -ur 2.4.18-pre9-mjc2/Makefile 2.4.18-pre9-mjc2-rmap12f/Makefile
--- 2.4.18-pre9-mjc2/Makefile	Thu Feb 14 19:09:54 2002
+++ 2.4.18-pre9-mjc2-rmap12f/Makefile	Thu Feb 14 19:08:52 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 18
-EXTRAVERSION = -pre9-mjc2
+EXTRAVERSION = -pre9-mjc2-rmap12f
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -ur 2.4.18-pre9-mjc2/fs/buffer.c 2.4.18-pre9-mjc2-rmap12f/fs/buffer.c
--- 2.4.18-pre9-mjc2/fs/buffer.c	Thu Feb 14 19:09:58 2002
+++ 2.4.18-pre9-mjc2-rmap12f/fs/buffer.c	Thu Feb 14 18:58:12 2002
@@ -2991,6 +2991,7 @@
 
 		spin_lock(&lru_list_lock);
 		if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
+			run_task_queue(&tq_disk);
 			interruptible_sleep_on(&bdflush_wait);
 		}
 	}
diff -ur 2.4.18-pre9-mjc2/include/linux/mmzone.h 2.4.18-pre9-mjc2-rmap12f/include/linux/mmzone.h
--- 2.4.18-pre9-mjc2/include/linux/mmzone.h	Thu Feb 14 19:10:01 2002
+++ 2.4.18-pre9-mjc2-rmap12f/include/linux/mmzone.h	Thu Feb 14 18:58:12 2002
@@ -161,6 +161,21 @@
 
 extern pg_data_t contig_page_data;
 
+/**
+ * for_each_pgdat - helper macro to iterate over all nodes
+ * @pgdat - pg_data_t * variable
+ *
+ * Meant to help with common loops of the form
+ * pgdat = pgdat_list;
+ * while(pgdat) {
+ * 	...
+ * 	pgdat = pgdat->node_next;
+ * }
+ */
+#define for_each_pgdat(pgdat) \
+		for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+
+
 /*
  * next_zone - helper magic for for_each_zone()
  * Thanks to William Lee Irwin III for this piece of ingenuity.
diff -ur 2.4.18-pre9-mjc2/kernel/ksyms.c 2.4.18-pre9-mjc2-rmap12f/kernel/ksyms.c
--- 2.4.18-pre9-mjc2/kernel/ksyms.c	Thu Feb 14 19:10:02 2002
+++ 2.4.18-pre9-mjc2-rmap12f/kernel/ksyms.c	Thu Feb 14 19:01:03 2002
@@ -251,6 +251,7 @@
 EXPORT_SYMBOL(__pollwait);
 EXPORT_SYMBOL(poll_freewait);
 EXPORT_SYMBOL(ROOT_DEV);
+EXPORT_SYMBOL(__find_get_page);
 EXPORT_SYMBOL(find_get_page);
 EXPORT_SYMBOL(find_lock_page);
 EXPORT_SYMBOL(grab_cache_page);
diff -ur 2.4.18-pre9-mjc2/mm/bootmem.c 2.4.18-pre9-mjc2-rmap12f/mm/bootmem.c
--- 2.4.18-pre9-mjc2/mm/bootmem.c	Thu Feb 14 19:10:02 2002
+++ 2.4.18-pre9-mjc2-rmap12f/mm/bootmem.c	Thu Feb 14 19:08:16 2002
@@ -897,13 +897,11 @@
 	pg_data_t *pgdat = pgdat_list;
 	void *ptr;
 
-	while (pgdat) {
+	for_each_pgdat(pgdat) {
 		ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal);
 
 		if(ptr)
 			return ptr;
-
-		pgdat = pgdat->node_next;
 	}
 
 	printk(KERN_ALERT "bootmem alloc of %lu bytes failed!\n", size);
diff -ur 2.4.18-pre9-mjc2/mm/page_alloc.c 2.4.18-pre9-mjc2-rmap12f/mm/page_alloc.c
--- 2.4.18-pre9-mjc2/mm/page_alloc.c	Thu Feb 14 19:10:02 2002
+++ 2.4.18-pre9-mjc2-rmap12f/mm/page_alloc.c	Thu Feb 14 18:58:12 2002
@@ -627,14 +627,11 @@
 {
 	unsigned int sum;
 	zone_t *zone;
-	pg_data_t *pgdat = pgdat_list;
 
 	sum = 0;
-	while (pgdat) {
-		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++)
-			sum += zone->free_pages;
-		pgdat = pgdat->node_next;
-	}
+	for_each_zone(zone)
+		sum += zone->free_pages;
+	
 	return sum;
 }
 
@@ -643,10 +640,10 @@
  */
 unsigned int nr_free_buffer_pages (void)
 {
-	pg_data_t *pgdat = pgdat_list;
+	pg_data_t *pgdat;
 	unsigned int sum = 0;
 
-	do {
+	for_each_pgdat(pgdat) {
 		zonelist_t *zonelist = pgdat->node_zonelists + (GFP_USER & GFP_ZONEMASK);
 		zone_t **zonep = zonelist->zones;
 		zone_t *zone;
@@ -657,8 +654,7 @@
 			sum += zone->inactive_dirty_pages;
 		}
 
-		pgdat = pgdat->node_next;
-	} while (pgdat);
+	}
 
 	return sum;
 }
@@ -666,13 +662,12 @@
 #if CONFIG_HIGHMEM
 unsigned int nr_free_highpages (void)
 {
-	pg_data_t *pgdat = pgdat_list;
+	pg_data_t *pgdat;
 	unsigned int pages = 0;
 
-	while (pgdat) {
+	for_each_pgdat(pgdat)
 		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
-		pgdat = pgdat->node_next;
-	}
+
 	return pages;
 }
 #endif
diff -ur 2.4.18-pre9-mjc2/mm/vmscan.c 2.4.18-pre9-mjc2-rmap12f/mm/vmscan.c
--- 2.4.18-pre9-mjc2/mm/vmscan.c	Thu Feb 14 19:10:02 2002
+++ 2.4.18-pre9-mjc2-rmap12f/mm/vmscan.c	Thu Feb 14 18:58:12 2002
@@ -652,6 +652,10 @@
 
 	refill_freelist();
 
+	/* Start IO when needed. */
+	if (free_plenty(ALL_ZONES) > 0 || free_low(ANY_ZONE) > 0)
+		run_task_queue(&tq_disk);
+
 	/*
 	 * Hmm.. Cache shrink failed - time to kill something?
 	 * Mhwahahhaha! This is the part I really like. Giggle.
