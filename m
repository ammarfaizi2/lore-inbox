Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271347AbRHZRgs>; Sun, 26 Aug 2001 13:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271364AbRHZRgi>; Sun, 26 Aug 2001 13:36:38 -0400
Received: from ns2.cih.com ([204.69.206.3]:54536 "HELO cih.com")
	by vger.kernel.org with SMTP id <S271347AbRHZRg2>;
	Sun, 26 Aug 2001 13:36:28 -0400
Date: Sun, 26 Aug 2001 10:37:39 -0700 (PDT)
From: "Craig I. Hagan" <hagan@cih.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: <pcg@goof.com>, Rik van Riel <riel@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826172310Z16216-32383+1477@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.30.0108261037050.31849-100000@svr.cih.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> live load (you're a brave man) but let's try a bringing the -ac max-readahead
> patch across and try it in 2.4.9.

here it is, pardon the fuzz in some spots (where i just left it alone)

diff -ur linux-clean/drivers/md/md.c linux/drivers/md/md.c
--- linux-clean/drivers/md/md.c	Fri May 25 09:48:49 2001
+++ linux/drivers/md/md.c	Fri Jun 15 02:30:48 2001
@@ -3291,7 +3291,7 @@
 	/*
 	 * Tune reconstruction:
 	 */
-	window = MAX_READAHEAD*(PAGE_SIZE/512);
+	window = vm_max_readahead*(PAGE_SIZE/512);
 	printk(KERN_INFO "md: using %dk window, over a total of %d blocks.\n",window/2,max_sectors/2);

 	atomic_set(&mddev->recovery_active, 0);
diff -ur linux-clean/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-clean/include/linux/blkdev.h	Fri May 25 18:01:40 2001
+++ linux/include/linux/blkdev.h	Fri Jun 15 02:23:22 2001
@@ -183,10 +183,6 @@

 #define PageAlignSize(size) (((size) + PAGE_SIZE -1) & PAGE_MASK)

-/* read-ahead in pages.. */
-#define MAX_READAHEAD	31
-#define MIN_READAHEAD	3
-
 #define blkdev_entry_to_request(entry) list_entry((entry), struct request, queue)
 #define blkdev_entry_next_request(entry) blkdev_entry_to_request((entry)->next)
 #define blkdev_entry_prev_request(entry) blkdev_entry_to_request((entry)->prev)
diff -ur linux-clean/include/linux/mm.h linux/include/linux/mm.h
--- linux-clean/include/linux/mm.h	Fri Jun 15 02:20:24 2001
+++ linux/include/linux/mm.h	Fri Jun 15 02:26:12 2001
@@ -105,6 +105,10 @@
 #define VM_SequentialReadHint(v)	((v)->vm_flags & VM_SEQ_READ)
 #define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)

+/* read ahead limits */
+extern int vm_min_readahead;
+extern int vm_max_readahead;
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff -ur linux-clean/include/linux/raid/md_k.h linux/include/linux/raid/md_k.h
--- linux-clean/include/linux/raid/md_k.h	Sun May 20 12:11:39 2001
+++ linux/include/linux/raid/md_k.h	Fri Jun 15 02:31:24 2001
@@ -89,7 +89,7 @@
 /*
  * default readahead
  */
-#define MD_READAHEAD	MAX_READAHEAD
+#define MD_READAHEAD	vm_max_readahead

 static inline int disk_faulty(mdp_disk_t * d)
 {
diff -ur linux-clean/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-clean/include/linux/sysctl.h	Fri May 25 18:01:27 2001
+++ linux/include/linux/sysctl.h	Fri Jun 15 02:24:33 2001
@@ -134,7 +134,9 @@
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
+	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
+        VM_MIN_READAHEAD=12,    /* Min file readahead */
+        VM_MAX_READAHEAD=13     /* Max file readahead */
 };


diff -ur linux-clean/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-clean/kernel/sysctl.c	Thu Apr 12 12:20:31 2001
+++ linux/kernel/sysctl.c	Fri Jun 15 02:28:02 2001
@@ -270,6 +270,10 @@
 	 &pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster",
 	 &page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_MIN_READAHEAD, "min-readahead",
+	&vm_min_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_MAX_READAHEAD, "max-readahead",
+	&vm_max_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };

Only in linux/kernel: sysctl.c~
diff -ur linux-clean/mm/filemap.c linux/mm/filemap.c
--- linux-clean/mm/filemap.c	Thu Aug 16 13:12:07 2001
+++ linux/mm/filemap.c	Fri Aug 24 14:08:20 2001
@@ -45,6 +45,12 @@
 unsigned int page_hash_bits;
 struct page **page_hash_table;

+int vm_max_readahead = 31;
+int vm_min_readahead = 3;
+EXPORT_SYMBOL(vm_max_readahead);
+EXPORT_SYMBOL(vm_min_readahead);
+
+
 spinlock_t __cacheline_aligned pagecache_lock = SPIN_LOCK_UNLOCKED;
 /*
  * NOTE: to avoid deadlocking you must never acquire the pagecache_lock with
@@ -870,7 +876,7 @@
 static inline int get_max_readahead(struct inode * inode)
 {
 	if (!inode->i_dev || !max_readahead[MAJOR(inode->i_dev)])
-		return MAX_READAHEAD;
+		return vm_max_readahead;
 	return max_readahead[MAJOR(inode->i_dev)][MINOR(inode->i_dev)];
 }

@@ -1044,8 +1050,8 @@
 		if (filp->f_ramax < needed)
 			filp->f_ramax = needed;

-		if (reada_ok && filp->f_ramax < MIN_READAHEAD)
-				filp->f_ramax = MIN_READAHEAD;
+		if (reada_ok && filp->f_ramax < vm_min_readahead)
+				filp->f_ramax = vm_min_readahead;
 		if (filp->f_ramax > max_readahead)
 			filp->f_ramax = max_readahead;
 	}
--- linux-clean/drivers/ide/ide-probe.c	Sun Mar 18 09:25:02 2001
+++ linux/drivers/ide/ide-probe.c	Fri Jun 15 03:09:49 2001
@@ -779,7 +779,7 @@
 		/* IDE can do up to 128K per request. */
 		*max_sect++ = 255;
 #endif
-		*max_ra++ = MAX_READAHEAD;
+		*max_ra++ = vm_max_readahead;
 	}

 	for (unit = 0; unit < units; ++unit)

