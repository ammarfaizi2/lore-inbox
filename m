Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932773AbWF2VhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbWF2VhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbWF2VhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:37:01 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:23264 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932757AbWF2Vgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:36:37 -0400
Message-Id: <200606292136.k5TLaY7N010817@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 6/9] UML - Remove unneeded time definitions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jun 2006 17:36:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove um_time() and um_stime() syscalls since they are identical to
system-wide ones.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Index: linux-2.6.17/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/time_kern.c	2006-06-29 11:45:07.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/time_kern.c	2006-06-29 11:45:07.000000000 -0400
@@ -142,16 +142,6 @@ irqreturn_t um_timer(int irq, void *dev,
 	return IRQ_HANDLED;
 }
 
-long um_time(int __user *tloc)
-{
-	long ret = get_time() / NSEC_PER_SEC;
-
-	if((tloc != NULL) && put_user(ret, tloc))
-		return -EFAULT;
-
-	return ret;
-}
-
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long long nsecs = get_time();
@@ -180,18 +170,6 @@ static inline void set_time(unsigned lon
 	clock_was_set();
 }
 
-long um_stime(int __user *tptr)
-{
-	int value;
-
-	if (get_user(value, tptr))
-                return -EFAULT;
-
-	set_time((unsigned long long) value * NSEC_PER_SEC);
-
-	return 0;
-}
-
 int do_settimeofday(struct timespec *tv)
 {
 	set_time((unsigned long long) tv->tv_sec * NSEC_PER_SEC + tv->tv_nsec);
Index: linux-2.6.17/arch/um/sys-i386/sys_call_table.S
===================================================================
--- linux-2.6.17.orig/arch/um/sys-i386/sys_call_table.S	2006-06-29 11:39:24.000000000 -0400
+++ linux-2.6.17/arch/um/sys-i386/sys_call_table.S	2006-06-29 11:45:07.000000000 -0400
@@ -7,8 +7,6 @@
 #define sys_vm86old sys_ni_syscall
 #define sys_vm86 sys_ni_syscall
 
-#define sys_stime um_stime
-#define sys_time um_time
 #define old_mmap old_mmap_i386
 
 #include "../../i386/kernel/syscall_table.S"
Index: linux-2.6.17/arch/um/sys-x86_64/syscall_table.c
===================================================================
--- linux-2.6.17.orig/arch/um/sys-x86_64/syscall_table.c	2006-06-29 11:39:24.000000000 -0400
+++ linux-2.6.17/arch/um/sys-x86_64/syscall_table.c	2006-06-29 11:45:07.000000000 -0400
@@ -20,12 +20,6 @@
 /*#define sys_set_thread_area sys_ni_syscall
 #define sys_get_thread_area sys_ni_syscall*/
 
-/* For __NR_time. The x86-64 name hopefully will change from sys_time64 to
- * sys_time (since the current situation is bogus). I've sent a patch to cleanup
- * this. Remove below the obsoleted line. */
-#define sys_time64 um_time
-#define sys_time um_time
-
 /* On UML we call it this way ("old" means it's not mmap2) */
 #define sys_mmap old_mmap
 /* On x86-64 sys_uname is actually sys_newuname plus a compatibility trick.

