Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbUBYCni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 21:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbUBYCni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 21:43:38 -0500
Received: from ns.suse.de ([195.135.220.2]:35541 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262385AbUBYCnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 21:43:32 -0500
Subject: Re: [FIX] CONFIG_REGPARM breaks non-asmlinkage syscalls
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1077653339.6776.329.camel@nb.suse.de>
References: <1077653339.6776.329.camel@nb.suse.de>
Content-Type: multipart/mixed; boundary="=-ZMd//5vhTNKeai/V7n94"
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1077677050.3177.34.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 25 Feb 2004 03:44:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZMd//5vhTNKeai/V7n94
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

> with CONFIG_REGPARM=y, syscalls must be declared asmlinkage or else
> calling them will fail. [...]

here are a couple more cases where the prototypes and definitions don't
match. I found them with a fixed gcc.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

--=-ZMd//5vhTNKeai/V7n94
Content-Disposition: attachment; filename=regparm-fix2.diff
Content-Type: text/x-patch; name=regparm-fix2.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.3/arch/i386/kernel/semaphore.c
===================================================================
--- linux-2.6.3.orig/arch/i386/kernel/semaphore.c
+++ linux-2.6.3/arch/i386/kernel/semaphore.c
@@ -48,12 +48,14 @@
  *    we cannot lose wakeup events.
  */
 
-void __up(struct semaphore *sem)
+asmlinkage void
+__up(struct semaphore *sem)
 {
 	wake_up(&sem->wait);
 }
 
-void __down(struct semaphore * sem)
+asmlinkage void
+__down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -90,7 +92,8 @@ void __down(struct semaphore * sem)
 	tsk->state = TASK_RUNNING;
 }
 
-int __down_interruptible(struct semaphore * sem)
+asmlinkage int
+__down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -153,7 +156,8 @@ int __down_interruptible(struct semaphor
  * single "cmpxchg" without failure cases,
  * but then it wouldn't work on a 386.
  */
-int __down_trylock(struct semaphore * sem)
+asmlinkage int
+__down_trylock(struct semaphore * sem)
 {
 	int sleepers;
 	unsigned long flags;
Index: linux-2.6.3/drivers/isdn/hysdn/hysdn_defs.h
===================================================================
--- linux-2.6.3.orig/drivers/isdn/hysdn/hysdn_defs.h
+++ linux-2.6.3/drivers/isdn/hysdn/hysdn_defs.h
@@ -235,7 +235,6 @@ extern hysdn_card *card_root;	/* pointer
 /*************************/
 /* im/exported functions */
 /*************************/
-extern int printk(const char *fmt,...);
 extern char *hysdn_getrev(const char *);
 
 /* hysdn_procconf.c */
Index: linux-2.6.3/kernel/exit.c
===================================================================
--- linux-2.6.3.orig/kernel/exit.c
+++ linux-2.6.3/kernel/exit.c
@@ -748,7 +748,7 @@ static void exit_notify(struct task_stru
 
 }
 
-NORET_TYPE void do_exit(long code)
+asmlinkage NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
 
Index: linux-2.6.3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.3.orig/kernel/power/swsusp.c
+++ linux-2.6.3/kernel/power/swsusp.c
@@ -72,7 +72,7 @@ extern long sys_sync(void);
 
 unsigned char software_suspend_enabled = 0;
 
-extern void do_magic(int resume);
+asmlinkage extern void do_magic(int resume);
 
 #define NORESUME		1
 #define RESUME_SPECIFIED	2
@@ -584,7 +584,7 @@ static void suspend_power_down(void)
  * Magic happens here
  */
 
-void do_magic_resume_1(void)
+asmlinkage void do_magic_resume_1(void)
 {
 	barrier();
 	mb();
@@ -597,7 +597,7 @@ void do_magic_resume_1(void)
 			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
 }
 
-void do_magic_resume_2(void)
+asmlinkage void do_magic_resume_2(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	BUG_ON (pagedir_order_check != pagedir_order);
@@ -641,7 +641,7 @@ void do_magic_resume_2(void)
 
  */
 
-void do_magic_suspend_1(void)
+asmlinkage void do_magic_suspend_1(void)
 {
 	mb();
 	barrier();
@@ -649,7 +649,7 @@ void do_magic_suspend_1(void)
 	spin_lock_irq(&suspend_pagedir_lock);
 }
 
-void do_magic_suspend_2(void)
+asmlinkage void do_magic_suspend_2(void)
 {
 	int is_problem;
 	read_swapfiles();

--=-ZMd//5vhTNKeai/V7n94--

