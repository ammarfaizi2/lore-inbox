Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270093AbTHBSmm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 14:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270097AbTHBSmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 14:42:42 -0400
Received: from waste.org ([209.173.204.2]:28106 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270093AbTHBSme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 14:42:34 -0400
Date: Sat, 2 Aug 2003 13:42:27 -0500
From: Matt Mackall <mpm@selenic.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] random: SMP locking
Message-ID: <20030802184226.GJ22824@waste.org>
References: <20030802042445.GD22824@waste.org> <20030802040015.0fcafda2.akpm@osdl.org> <Pine.LNX.4.53.0308020832520.3473@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308020832520.3473@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 08:35:22AM -0400, Zwane Mwaikambo wrote:
> On Sat, 2 Aug 2003, Andrew Morton wrote:
>
> > Cannot perform userspace access while holding a lock - a pagefault could
> > occur, perform IO, schedule away and the same CPU tries to take the same
> > lock via a different process.
> 
> Perhaps might_sleep() in *_user, copy_* etc is in order?

I think it's been suggested before, but I threw a patch together for
i386 anyway.

This only checks in the non-__ versions, as those are occassionally
called inside things like kmap_atomic pairs which take a spinlock in
with highmem. It's all conditional on CONFIG_DEBUG_SPINLOCK_SLEEP
(which isn't quite the right name) so there's no overhead for normal
builds.

diff -urN -X dontdiff orig/arch/i386/lib/usercopy.c work/arch/i386/lib/usercopy.c
--- orig/arch/i386/lib/usercopy.c	2003-07-13 22:28:54.000000000 -0500
+++ work/arch/i386/lib/usercopy.c	2003-08-02 13:33:43.000000000 -0500
@@ -149,6 +149,7 @@
 unsigned long
 clear_user(void __user *to, unsigned long n)
 {
+	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
 		__do_clear_user(to, n);
 	return n;
@@ -188,6 +189,8 @@
 	unsigned long mask = -__addr_ok(s);
 	unsigned long res, tmp;
 
+	might_sleep();
+
 	__asm__ __volatile__(
 		"	testl %0, %0\n"
 		"	jz 3f\n"
diff -urN -X dontdiff orig/include/asm-i386/uaccess.h work/include/asm-i386/uaccess.h
--- orig/include/asm-i386/uaccess.h	2003-07-13 22:30:48.000000000 -0500
+++ work/include/asm-i386/uaccess.h	2003-08-02 13:15:42.000000000 -0500
@@ -260,6 +260,7 @@
 ({									\
 	long __pu_err = -EFAULT;					\
 	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
+	might_sleep();						\
 	if (access_ok(VERIFY_WRITE,__pu_addr,size))			\
 		__put_user_size((x),__pu_addr,(size),__pu_err,-EFAULT);	\
 	__pu_err;							\
@@ -469,6 +470,7 @@
 static inline unsigned long
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
 		n = __copy_to_user(to, from, n);
 	return n;
@@ -493,6 +495,7 @@
 static inline unsigned long
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	might_sleep();
 	if (access_ok(VERIFY_READ, from, n))
 		n = __copy_from_user(to, from, n);
 	else


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
