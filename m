Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWFDCQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWFDCQL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 22:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWFDCQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 22:16:11 -0400
Received: from [198.99.130.12] ([198.99.130.12]:41133 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751395AbWFDCQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 22:16:10 -0400
Message-Id: <200606040216.k542GDFU004832@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Blaisorblade <blaisorblade@yahoo.it>,
       "Christopher S. Aker" <caker@theshore.net>
Subject: [PATCH 2/6] UML - Fix wall_to_monotonic initialization
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Jun 2006 22:16:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize wall_to_monotonic correctly.  This fixes a problem where sleeps
lasted about one secone less than they should.
This also called for a bit of code restructuring, following a patch which
Blaisorblade had been keeping.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/os-Linux/time.c	2006-06-01 22:16:24.000000000 -0400
+++ linux-2.6.17-mm/arch/um/os-Linux/time.c	2006-06-02 17:47:11.000000000 -0400
@@ -81,20 +81,12 @@ void uml_idle_timer(void)
 	set_interval(ITIMER_REAL);
 }
 
-extern void ktime_get_ts(struct timespec *ts);
-#define do_posix_clock_monotonic_gettime(ts) ktime_get_ts(ts)
-
 void time_init(void)
 {
-	struct timespec now;
-
 	if(signal(SIGVTALRM, boot_timer_handler) == SIG_ERR)
 		panic("Couldn't set SIGVTALRM handler");
 	set_interval(ITIMER_VIRTUAL);
-
-	do_posix_clock_monotonic_gettime(&now);
-	wall_to_monotonic.tv_sec = -now.tv_sec;
-	wall_to_monotonic.tv_nsec = -now.tv_nsec;
+	time_init_kern();
 }
 
 unsigned long long os_nsecs(void)
Index: linux-2.6.17-mm/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.17-mm.orig/arch/um/include/kern_util.h	2006-06-02 17:00:00.000000000 -0400
+++ linux-2.6.17-mm/arch/um/include/kern_util.h	2006-06-02 17:46:49.000000000 -0400
@@ -120,20 +120,11 @@ extern int is_syscall(unsigned long addr
 extern void free_irq(unsigned int, void *);
 extern int cpu(void);
 
+extern void time_init_kern(void);
+
 /* Are we disallowed to sleep? Used to choose between GFP_KERNEL and GFP_ATOMIC. */
 extern int __cant_sleep(void);
 extern void segv_handler(int sig, union uml_pt_regs *regs);
 extern void sigio_handler(int sig, union uml_pt_regs *regs);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.17-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/kernel/time_kern.c	2006-06-02 16:34:55.000000000 -0400
+++ linux-2.6.17-mm/arch/um/kernel/time_kern.c	2006-06-02 17:46:49.000000000 -0400
@@ -84,6 +84,16 @@ void timer_irq(union uml_pt_regs *regs)
 	}
 }
 
+
+void time_init_kern(void)
+{
+	unsigned long long nsecs;
+
+	nsecs = os_nsecs();
+	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,
+				-nsecs % BILLION);
+}
+
 void do_boot_timer_handler(struct sigcontext * sc)
 {
 	struct pt_regs regs;

