Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTJPOGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTJPOGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:06:46 -0400
Received: from dp.samba.org ([66.70.73.150]:55738 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262955AbTJPOGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:06:42 -0400
Date: Fri, 17 Oct 2003 00:04:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, kakadu_croc@yahoo.com,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test7-mm1
Message-ID: <20031016140400.GA17357@krispykreme>
References: <20031015032215.58d832c1.akpm@osdl.org> <20031015123444.46223.qmail@web40904.mail.yahoo.com> <20031015102810.4017950f.akpm@osdl.org> <20031015174047.GE971@phunnypharm.org> <20031015105359.31c016c3.akpm@osdl.org> <20031016022547.GA615@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016022547.GA615@phunnypharm.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Anton had a ppc64 patch which implemented the preempt_count beancounting
> > without actually implementing premption.  So might_sleep() does the right
> > thing.
> 
> I might have to dig that out and try to make use of it. Thanks for the
> pointer.

Here is the patch with the ppc64 bits in it. (I already have
might_sleep() littered in asm-ppc64/semaphore.h and asm-ppc64/uaccess.h)

Its a bit old but it seems to dump valid warnings.

Anton


Sleep with spinlock debugging.


 foo-anton/arch/ppc64/Kconfig          |    7 +++++++
 foo-anton/include/asm-ppc64/hardirq.h |    2 +-
 foo-anton/include/linux/preempt.h     |   17 +++++++++++------
 foo-anton/kernel/fork.c               |    2 +-
 foo-anton/kernel/sched.c              |    2 +-
 5 files changed, 21 insertions(+), 9 deletions(-)

diff -puN arch/ppc64/Kconfig~spinlock_sleep arch/ppc64/Kconfig
--- foo/arch/ppc64/Kconfig~spinlock_sleep	2003-10-10 00:23:32.000000000 -0500
+++ foo-anton/arch/ppc64/Kconfig	2003-10-10 00:23:32.000000000 -0500
@@ -385,6 +385,13 @@ config DEBUG_PAGEALLOC
 	  This results in a large slowdown, but helps to find certain types
 	  of memory corruptions.
 
+config DEBUG_SPINLOCK_SLEEP
+	bool "Sleep-inside-spinlock checking"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, various routines which may sleep will become very
+	  noisy if they are called with a spinlock held.
+
 endmenu
 
 source "security/Kconfig"
diff -puN include/asm-ppc64/hardirq.h~spinlock_sleep include/asm-ppc64/hardirq.h
--- foo/include/asm-ppc64/hardirq.h~spinlock_sleep	2003-10-10 00:23:32.000000000 -0500
+++ foo-anton/include/asm-ppc64/hardirq.h	2003-10-10 00:23:32.000000000 -0500
@@ -82,7 +82,7 @@ typedef struct {
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#ifdef CONFIG_PREEMPT
+#if defined(CONFIG_PREEMPT) || defined(CONFIG_DEBUG_SPINLOCK_SLEEP)
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
diff -puN include/linux/preempt.h~spinlock_sleep include/linux/preempt.h
--- foo/include/linux/preempt.h~spinlock_sleep	2003-10-10 00:23:32.000000000 -0500
+++ foo-anton/include/linux/preempt.h	2003-10-10 00:23:32.000000000 -0500
@@ -24,6 +24,17 @@ do { \
 
 extern void preempt_schedule(void);
 
+#define preempt_check_resched() \
+do { \
+	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
+		preempt_schedule(); \
+} while (0)
+#else
+#define preempt_check_resched()		do { } while (0)
+#endif
+
+#if defined(CONFIG_PREEMPT) || defined(CONFIG_DEBUG_SPINLOCK_SLEEP)
+
 #define preempt_disable() \
 do { \
 	inc_preempt_count(); \
@@ -36,12 +47,6 @@ do { \
 	barrier(); \
 } while (0)
 
-#define preempt_check_resched() \
-do { \
-	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
-		preempt_schedule(); \
-} while (0)
-
 #define preempt_enable() \
 do { \
 	preempt_enable_no_resched(); \
diff -puN kernel/fork.c~spinlock_sleep kernel/fork.c
--- foo/kernel/fork.c~spinlock_sleep	2003-10-10 00:23:32.000000000 -0500
+++ foo-anton/kernel/fork.c	2003-10-10 00:23:32.000000000 -0500
@@ -850,7 +850,7 @@ struct task_struct *copy_process(unsigne
 	if (p->binfmt && !try_module_get(p->binfmt->module))
 		goto bad_fork_cleanup_put_domain;
 
-#ifdef CONFIG_PREEMPT
+#if defined(CONFIG_PREEMPT) || defined(CONFIG_DEBUG_SPINLOCK_SLEEP)
 	/*
 	 * schedule_tail drops this_rq()->lock so we compensate with a count
 	 * of 1.  Also, we want to start with kernel preemption disabled.
diff -puN kernel/sched.c~spinlock_sleep kernel/sched.c
--- foo/kernel/sched.c~spinlock_sleep	2003-10-10 00:23:32.000000000 -0500
+++ foo-anton/kernel/sched.c	2003-10-10 00:23:32.000000000 -0500
@@ -2533,7 +2533,7 @@ void __init init_idle(task_t *idle, int 
 	local_irq_restore(flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
-#ifdef CONFIG_PREEMPT
+#if defined(CONFIG_PREEMPT) || defined(CONFIG_DEBUG_SPINLOCK_SLEEP)
 	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
 #else
 	idle->thread_info->preempt_count = 0;

_
