Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTJSBU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 21:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTJSBU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 21:20:57 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:6030 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261957AbTJSBUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 21:20:49 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6.0-test8 __might_sleep warnings on boot
References: <87he26p6pq.fsf@love-shack.home.digitalvampire.org>
	<20031018161439.484915f8.akpm@osdl.org>
	<87d6cuozm7.fsf@love-shack.home.digitalvampire.org>
	<20031018172140.4968e273.akpm@osdl.org>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@digitalvampire.org>
Date: 18 Oct 2003 18:19:36 -0700
In-Reply-To: <20031018172140.4968e273.akpm@osdl.org>
Message-ID: <878yniowgn.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> And ditto.  (Except declarations go in .h files, not in .c
    Andrew> files).

    Andrew> Sigh.  We may as well use this approach I guess.

We could go back to waiting 5 minutes after boot before printing
might_sleep warnings ;)

Here's a patch that

- fixes the early might_sleep warnings by not printing them until
  system_running is set.
- adds a declaration of system_running to linux/kernel.h.
- gets rid of declarations of system_running in kernel/kmod.c and
  kernel/sys.c.

 - Roland

diff -Nurp linux-2.6.0-test8.orig/include/linux/kernel.h linux-2.6.0-test8/include/linux/kernel.h
--- linux-2.6.0-test8.orig/include/linux/kernel.h	Fri Oct 17 14:42:52 2003
+++ linux-2.6.0-test8/include/linux/kernel.h	Sat Oct 18 17:56:27 2003
@@ -101,6 +101,7 @@ static inline void console_verbose(void)
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_on_oops;
+extern int system_running;
 
 extern int tainted;
 extern const char *print_tainted(void);
diff -Nurp linux-2.6.0-test8.orig/kernel/kmod.c linux-2.6.0-test8/kernel/kmod.c
--- linux-2.6.0-test8.orig/kernel/kmod.c	Fri Oct 17 14:43:00 2003
+++ linux-2.6.0-test8/kernel/kmod.c	Sat Oct 18 17:58:27 2003
@@ -36,7 +36,7 @@
 #include <linux/kernel.h>
 #include <asm/uaccess.h>
 
-extern int max_threads, system_running;
+extern int max_threads;
 
 #ifdef CONFIG_KMOD
 
diff -Nurp linux-2.6.0-test8.orig/kernel/sched.c linux-2.6.0-test8/kernel/sched.c
--- linux-2.6.0-test8.orig/kernel/sched.c	Fri Oct 17 14:43:24 2003
+++ linux-2.6.0-test8/kernel/sched.c	Sat Oct 18 17:54:43 2003
@@ -2847,8 +2847,10 @@ void __might_sleep(char *file, int line)
 {
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
-
-	if (in_atomic() || irqs_disabled()) {
+	/* Don't print warnings until system_running is set.  This avoids
+	   spurious warnings during boot before local_irq_enable() and
+	   init_idle(). */
+	if (system_running && (in_atomic() || irqs_disabled())) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;
diff -Nurp linux-2.6.0-test8.orig/kernel/sys.c linux-2.6.0-test8/kernel/sys.c
--- linux-2.6.0-test8.orig/kernel/sys.c	Fri Oct 17 14:42:54 2003
+++ linux-2.6.0-test8/kernel/sys.c	Sat Oct 18 17:58:18 2003
@@ -78,8 +78,6 @@ EXPORT_SYMBOL(fs_overflowgid);
 int C_A_D = 1;
 int cad_pid = 1;
 
-extern int system_running;
-
 /*
  *	Notifier list for kernel code which wants to be called
  *	at shutdown. This is used to stop any idling DMA operations
