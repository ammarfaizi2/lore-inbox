Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRCPKVj>; Fri, 16 Mar 2001 05:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRCPKV3>; Fri, 16 Mar 2001 05:21:29 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:41234 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129854AbRCPKVT>; Fri, 16 Mar 2001 05:21:19 -0500
Date: Fri, 16 Mar 2001 05:36:12 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Reserved memory for highmem bouncing (fwd)
In-Reply-To: <Pine.LNX.4.21.0103160358230.4571-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0103160523370.5054-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, here it is. 

I would like to know if this makes a big difference on highmem (2GB or
more) machines with heavy IO workloads.

I don't have such a machine here to be able to test it. (it works with a
1GB machine, but it needs to be tested with lots of highmem to show the
improvement)


diff -Nur linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Fri Mar 16 13:01:09 2001
+++ linux/fs/buffer.c	Fri Mar 16 13:37:27 2001
@@ -2557,7 +2557,7 @@
    as all dirty buffers lives _only_ in the DIRTY lru list.
    As we never browse the LOCKED and CLEAN lru lists they are infact
    completly useless. */
-static int flush_dirty_buffers(int check_flushtime)
+int flush_dirty_buffers(int check_flushtime, int lowmem)
 {
 	struct buffer_head * bh, *next;
 	int flushed = 0, i;
@@ -2577,6 +2577,11 @@
 		if (buffer_locked(bh))
 			continue;
 
+#ifdef CONFIG_HIGHMEM
+		if (lowmem && PageHighMem(bh->b_page))
+			continue;
+#endif
+
 		if (check_flushtime) {
 			/* The dirty lru list is chronologically ordered so
 			   if the current bh is not yet timed out,
@@ -2616,7 +2621,7 @@
 		wake_up_process(bdflush_tsk);
 
 		if (block)
-			flush_dirty_buffers(0);
+			flush_dirty_buffers(0, 0);
 	}
 }
 
@@ -2635,7 +2640,7 @@
 	sync_inodes(0);
 	unlock_kernel();
 
-	flush_dirty_buffers(1);
+	flush_dirty_buffers(1, 0);
 	/* must really sync all the active I/O request to disk here */
 	run_task_queue(&tq_disk);
 	return 0;
@@ -2732,7 +2737,7 @@
 	for (;;) {
 		CHECK_EMERGENCY_SYNC
 
-		flushed = flush_dirty_buffers(0);
+		flushed = flush_dirty_buffers(0, 0);
 		if (free_shortage())
 			flushed += page_launder(GFP_KERNEL, 0);
 
diff -Nur linux.orig/include/linux/fs.h linux/include/linux/fs.h
--- linux.orig/include/linux/fs.h	Fri Mar 16 13:01:14 2001
+++ linux/include/linux/fs.h	Fri Mar 16 13:36:57 2001
@@ -1288,6 +1288,7 @@
 extern unsigned int get_hardblocksize(kdev_t);
 extern struct buffer_head * bread(kdev_t, int, int);
 extern void wakeup_bdflush(int wait);
+extern int flush_dirty_buffers(int, int);
 
 extern int brw_page(int, struct page *, kdev_t, int [], int);
 
diff -Nur linux.orig/mm/highmem.c linux/mm/highmem.c
--- linux.orig/mm/highmem.c	Fri Mar 16 13:01:13 2001
+++ linux/mm/highmem.c	Fri Mar 16 13:44:01 2001
@@ -21,6 +21,7 @@
 #include <linux/highmem.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/fs.h>
 
 /*
  * Virtual_count is not a pure "count".
@@ -280,9 +281,11 @@
 	if (page)
 		return page;
 	/*
-	 * No luck. First, kick the VM so it doesnt idle around while
-	 * we are using up our emergency rations.
+	 * No luck. First, try to flush some low memory buffers.
+	 * This will throttle highmem writes when low memory gets full.
 	 */
+	flush_dirty_buffers(0, 1);
+
 	wakeup_bdflush(0);
 
 	/*
@@ -317,9 +320,11 @@
 	if (bh)
 		return bh;
 	/*
-	 * No luck. First, kick the VM so it doesnt idle around while
-	 * we are using up our emergency rations.
+	 * No luck. First, try to flush some low memory buffers.
+	 * This will throttle highmem writes when low memory gets full.
 	 */
+	flush_dirty_buffers(0, 1);
+	
 	wakeup_bdflush(0);
 
 	/*

