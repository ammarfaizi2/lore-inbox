Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWHBT6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWHBT6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWHBT6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:58:42 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:2948 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932200AbWHBT6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:58:42 -0400
Message-Id: <200608021958.k72JwLjB005997@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/4] UML - timer cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Aug 2006 15:58:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

set_interval returns an error instead of panicing if setitimer fails.
Some of its callers now check the return.

enable_timer is largely tt-mode-specific, so it is marked as such, and
the only skas-mode caller is made to call set-interval instead.

user_time_init was a no-value-added wrapper around set_interval, so it
is gone.

Since set_interval is now called from kernel code, callers no longer
pass ITIMER_* to it.  Instead, they pass a flag which is converted
into ITIMER_REAL or ITIMER_VIRTUAL.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/time.c	2006-08-02 15:53:39.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/time.c	2006-08-02 15:53:41.000000000 -0400
@@ -17,20 +17,25 @@
 #include "kern_constants.h"
 #include "os.h"
 
-static void set_interval(int timer_type)
+int set_interval(int is_virtual)
 {
 	int usec = 1000000/hz();
+	int timer_type = is_virtual ? ITIMER_VIRTUAL : ITIMER_REAL;
 	struct itimerval interval = ((struct itimerval) { { 0, usec },
 							  { 0, usec } });
 
 	if(setitimer(timer_type, &interval, NULL) == -1)
-		panic("setitimer failed - errno = %d\n", errno);
+		return -errno;
+
+	return 0;
 }
 
+#ifdef CONFIG_MODE_TT
 void enable_timer(void)
 {
-	set_interval(ITIMER_VIRTUAL);
+	set_interval(1);
 }
+#endif
 
 void disable_timer(void)
 {
@@ -74,7 +79,7 @@ void uml_idle_timer(void)
 
 	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
 		    SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
-	set_interval(ITIMER_REAL);
+	set_interval(0);
 }
 #endif
 
@@ -94,8 +99,3 @@ void idle_sleep(int secs)
 	ts.tv_nsec = 0;
 	nanosleep(&ts, NULL);
 }
-
-void user_time_init(void)
-{
-	set_interval(ITIMER_VIRTUAL);
-}
Index: linux-2.6.18-rc2-mm1/arch/um/include/os.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/include/os.h	2006-08-02 15:53:09.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/include/os.h	2006-08-02 15:53:41.000000000 -0400
@@ -276,9 +276,11 @@ extern int setjmp_wrapper(void (*proc)(v
 
 extern void switch_timers(int to_real);
 extern void idle_sleep(int secs);
+extern int set_interval(int is_virtual);
+#ifdef CONFIG_MODE_TT
 extern void enable_timer(void);
+#endif
 extern void disable_timer(void);
-extern void user_time_init(void);
 extern void uml_idle_timer(void);
 extern unsigned long long os_nsecs(void);
 
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/skas/process.c	2006-08-02 15:53:39.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/skas/process.c	2006-08-02 15:53:41.000000000 -0400
@@ -155,11 +155,15 @@ extern int __syscall_stub_start;
 static int userspace_tramp(void *stack)
 {
 	void *addr;
+	int err;
 
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
 	init_new_thread_signals();
-	enable_timer();
+	err = set_interval(1);
+	if(err)
+		panic("userspace_tramp - setting timer failed, errno = %d\n",
+		      err);
 
 	if(!proc_mm){
 		/* This has a pte, but it can't be mapped in with the usual
Index: linux-2.6.18-rc2-mm1/arch/um/kernel/time.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/kernel/time.c	2006-08-02 15:53:09.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/kernel/time.c	2006-08-02 15:53:41.000000000 -0400
@@ -113,12 +113,15 @@ static void register_timer(void)
 
 	err = request_irq(TIMER_IRQ, um_timer, IRQF_DISABLED, "timer", NULL);
 	if(err != 0)
-		printk(KERN_ERR "timer_init : request_irq failed - "
+		printk(KERN_ERR "register_timer : request_irq failed - "
 		       "errno = %d\n", -err);
 
 	timer_irq_inited = 1;
 
-	user_time_init();
+	err = set_interval(1);
+	if(err != 0)
+		printk(KERN_ERR "register_timer : set_interval failed - "
+		       "errno = %d\n", -err);
 }
 
 extern void (*late_time_init)(void);

