Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275173AbRJBPSd>; Tue, 2 Oct 2001 11:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275178AbRJBPSX>; Tue, 2 Oct 2001 11:18:23 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:9232 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S275173AbRJBPSM>; Tue, 2 Oct 2001 11:18:12 -0400
X-Mailer: exmh version 2.3+CL 01/14/2001 with nmh-1.0.4
To: trond.myklebust@fys.uio.no
cc: Ian.Grant@cl.cam.ac.uk, linux-kernel@vger.kernel.org
Subject: 2.4.10 build failure - atomic_dec_and_lock export
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Oct 2001 16:18:40 +0100
From: Ian Grant <Ian.Grant@cl.cam.ac.uk>
Message-Id: <E15oRJg-00005z-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond,

2.4.10 won't link with CONFIG_SMP and i386 CPU selected. I believe the problem 
lies in in the #ifndef atomic_dec_and_lock in lib/dec_and_lock.c. As far as I 
can see this symbol is always defined because it's exported.

The following patch works for me, but I barely understand the kernel build 
machinery(*) so please don't use this without checking it carefully.

Ian

* e.g. I cannot understand why this symbol isn't versioned in the object file.

--- linux/lib/dec_and_lock.c.orig	Tue Oct  2 15:47:44 2001
+++ linux/lib/dec_and_lock.c	Tue Oct  2 16:07:01 2001
@@ -1,3 +1,4 @@
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
@@ -26,7 +27,8 @@
  * store-conditional approach, for example.
  */
 
-#ifndef atomic_dec_and_lock
+#ifdef CONFIG_SMP
+#ifndef CONFIG_HAVE_DEC_LOCK
 int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	spin_lock(lock);
@@ -37,4 +39,5 @@
 }
 
 EXPORT_SYMBOL(atomic_dec_and_lock);
+#endif
 #endif

-- 
Ian Grant, Computer Lab., William Gates Building, JJ Thomson Ave., Cambridge
Phone: +44 1223 334420


