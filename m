Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTDIEFL (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTDIEFL (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:05:11 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:33946 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262706AbTDIEFI (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:05:08 -0400
To: "Shawn Starr" <spstarr@sh0n.net>
Cc: "'Andrew Morton'" <akpm@digeo.com>, <rml@tech9.net>,
       <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T info
References: <003001c2fe3d$6eab1080$030aa8c0@unknown>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 08 Apr 2003 21:16:33 -0700
In-Reply-To: <003001c2fe3d$6eab1080$030aa8c0@unknown>
Message-ID: <524r58nw4e.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Apr 2003 04:16:36.0649 (UTC) FILETIME=[CFC4F190:01C2FE4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am completely convinced that the patch you are using (which I
believe is the same as the one Andrew calls
"tty-shutdown-race-fix.patch") is the problem.  What happens is that
release_dev() in tty_io.c calls cancel_delayed_work(), which calls
del_timer_sync() without decrementing nr_queued for keventd_wq.

When flush_scheduled_work() gets called it sleeps on the work_done
waitqueue.  The only place work_done gets woken up is in
run_workqueue, and it only happens if
atomic_dec_and_test(&cwq->nr_queued) decrements nr_queued to 0.
But after calling cancel_delayed_work(), that can never happen (we
deleted the timer that was going to add the work that we're waiting
for).

It seems to me that the implementation of cancel_delayed_work() is
not quite right.  We need to decrement nr_queued if we actually
stopped the work from being added to the workqueue.

Andrew, I've never seen a reply from you about this, can you tell me
if I'm missing something here?

By the way, I assume that the process below is the one that's hung:

    bash          D C04CDC68 4233453816  8524      1                8387 (L-TLB)
    Call Trace:
     [<c010cd75>] do_IRQ+0x235/0x370
     [<c01394a5>] flush_workqueue+0x305/0x450
     [<c010ac18>] common_interrupt+0x18/0x20
     [<c011de30>] default_wake_function+0x0/0x20
     [<c011de30>] default_wake_function+0x0/0x20
     [<c0257a44>] release_dev+0x6a4/0x860
     [<c01566ab>] zap_pmd_range+0x4b/0x70
     [<c0258204>] tty_release+0x94/0x1b0
     [<c016dd7c>] __fput+0xac/0x100
     [<c0258170>] tty_release+0x0/0x1b0

It would seem to be stuck in the flush_workqueue() called from
release_dev(), just as I would expect.

Shawn, can you try the patch below instead of Andrew's ttyfix2?

 - Roland

===== drivers/char/tty_io.c 1.72 vs edited =====
--- 1.72/drivers/char/tty_io.c	Thu Apr  3 10:20:22 2003
+++ edited/drivers/char/tty_io.c	Tue Apr  8 20:23:44 2003
@@ -1286,8 +1286,15 @@
 	}
 	
 	/*
-	 * Make sure that the tty's task queue isn't activated. 
+	 * Prevent flush_to_ldisc() from rescheduling the work for later.  Then
+	 * kill any delayed work.
 	 */
+	clear_bit(TTY_DONT_FLIP, &tty->flags);
+	cancel_delayed_work(&tty->flip.work);
+
+	/*
+	 * Wait for ->hangup_work and ->flip.work handlers to terminate
+ 	 */
 	flush_scheduled_work();
 
 	/* 
===== include/linux/workqueue.h 1.4 vs edited =====
--- 1.4/include/linux/workqueue.h	Mon Nov  4 13:12:06 2002
+++ edited/include/linux/workqueue.h	Tue Apr  8 20:42:41 2003
@@ -63,5 +63,12 @@
 
 extern void init_workqueues(void);
 
+/*
+ * Kill off a pending schedule_delayed_work().  Note that the work callback
+ * function may still be running on return from cancel_delayed_work().  Run
+ * flush_scheduled_work() to wait on it.
+ */
+extern int cancel_delayed_work(struct work_struct *work);
+
 #endif
 
===== kernel/workqueue.c 1.6 vs edited =====
--- 1.6/kernel/workqueue.c	Tue Feb 11 14:57:54 2003
+++ edited/kernel/workqueue.c	Tue Apr  8 20:27:50 2003
@@ -125,6 +125,24 @@
 	return ret;
 }
 
+int cancel_delayed_work(struct work_struct *work) {
+	struct cpu_workqueue_struct *cwq = work->wq_data;
+	int ret;
+
+	ret = del_timer_sync(&work->timer);
+	if (ret) {
+		/*
+		 * Wake up 'work done' waiters (flush) if we just
+		 * removed the last thing on the workqueue.
+		 */
+		if (atomic_dec_and_test(&cwq->nr_queued))
+			wake_up(&cwq->work_done);
+
+	}
+
+	return ret;
+}
+
 static inline void run_workqueue(struct cpu_workqueue_struct *cwq)
 {
 	unsigned long flags;
@@ -378,5 +396,5 @@
 
 EXPORT_SYMBOL(schedule_work);
 EXPORT_SYMBOL(schedule_delayed_work);
+EXPORT_SYMBOL(cancel_delayed_work);
 EXPORT_SYMBOL(flush_scheduled_work);
-
