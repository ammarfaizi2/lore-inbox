Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKQDcR>; Thu, 16 Nov 2000 22:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQKQDb6>; Thu, 16 Nov 2000 22:31:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:29147 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129145AbQKQDby>; Thu, 16 Nov 2000 22:31:54 -0500
Importance: Normal
Subject: Re: test11-pre6
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFF5BA802C.5845C1FB-ON8825699A.00106748@LocalDomain>
From: "Ying Chen/Almaden/IBM" <ying@almaden.ibm.com>
Date: Thu, 16 Nov 2000 19:02:25 -0800
X-MIMETrack: Serialize by Router on D03NM042/03/M/IBM(Release 5.0.5 |September 22, 2000) at
 11/16/2000 07:01:52 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

You forgot about wakeup_bdflush(1) stuff.

Here is the patch again (against test10).
===============================================================
There are several places where schedule() is called after wakeup_bdflush(1)
is called. This is completely unnecessary, since wakeup_bdflush(1) already
gave up the control, and when the control is returned to the calling thread
who called wakeup_bdflush(1), it should just go on. Calling schedule()
after wakeup_bdflush(1) will make the calling thread give up control again.
This is a problem for some of those latency sensitive benchmarks (like SPEC
SFS) and applications.

============
diff -ruN mm.orig/highmem.c mm.opt/highmem.c
--- mm.orig/highmem.c   Wed Oct 18 14:25:46 2000
+++ mm.opt/highmem.c    Fri Nov 10 17:51:39 2000
@@ -310,8 +310,6 @@
    bh = kmem_cache_alloc(bh_cachep, SLAB_BUFFER);
    if (!bh) {
        wakeup_bdflush(1);  /* Sets task->state to TASK_RUNNING */
-       current->policy |= SCHED_YIELD;
-       schedule();
        goto repeat_bh;
    }
    /*
@@ -324,8 +322,6 @@
    page = alloc_page(GFP_BUFFER);
    if (!page) {
        wakeup_bdflush(1);  /* Sets task->state to TASK_RUNNING */
-       current->policy |= SCHED_YIELD;
-       schedule();
        goto repeat_page;
    }
    set_bh_page(bh, page, 0);
diff -ruN fs.orig/buffer.c fs.opt/buffer.c
--- fs.orig/buffer.c    Thu Oct 12 14:19:32 2000
+++ fs.opt/buffer.c Fri Nov 10 20:05:44 2000
@@ -707,11 +707,8 @@
  */
 static void refill_freelist(int size)
 {
-   if (!grow_buffers(size)) {
+   if (!grow_buffers(size))
        wakeup_bdflush(1);  /* Sets task->state to TASK_RUNNING */
-       current->policy |= SCHED_YIELD;
-       schedule();
-   }
 }

 void init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void
*private)
==============================


Ying Chen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
