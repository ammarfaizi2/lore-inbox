Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVAQHeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVAQHeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 02:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVAQHeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 02:34:05 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:8069 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262719AbVAQHd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 02:33:56 -0500
Date: Sun, 16 Jan 2005 23:33:45 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, mingo@elte.hu, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
Message-ID: <20050117073345.GA3616@taniwha.stupidest.org>
References: <20050117055044.GA3514@taniwha.stupidest.org> <20050116230922.7274f9a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116230922.7274f9a2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 11:09:22PM -0800, Andrew Morton wrote:

> If you replace the last line with
>
> 	BUILD_LOCK_OPS(write, rwlock_t, rwlock_is_locked);
>
> does it help?

Paul noticed that too so I came up with the patch below.

If it makes sense I can do the other architectures (I'm not sure == 0
is correct everywhere).  This is pretty much what I'm using now
without problems (it's either correct or it's almost correct and the
rwlock_is_write_locked hasn't thus far stuffed anything this boot).


---
Fix how we check for read and write rwlock_t locks.

Signed-off-by: Chris Wedgwood <cw@f00f.org>

===== include/asm-i386/spinlock.h 1.16 vs edited =====
--- 1.16/include/asm-i386/spinlock.h	2005-01-07 21:43:58 -08:00
+++ edited/include/asm-i386/spinlock.h	2005-01-16 23:23:50 -08:00
@@ -187,6 +187,7 @@ typedef struct {
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
 #define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
+#define rwlock_is_write_locked(x) ((x)->lock == 0)
 
 /*
  * On x86, we implement read-write locks as a 32-bit counter
===== kernel/spinlock.c 1.4 vs edited =====
--- 1.4/kernel/spinlock.c	2005-01-14 16:00:00 -08:00
+++ edited/kernel/spinlock.c	2005-01-16 23:25:11 -08:00
@@ -247,8 +247,8 @@ EXPORT_SYMBOL(_##op##_lock_bh)
  *         _[spin|read|write]_lock_bh()
  */
 BUILD_LOCK_OPS(spin, spinlock_t, spin_is_locked);
-BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_locked);
-BUILD_LOCK_OPS(write, rwlock_t, spin_is_locked);
+BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_write_locked);
+BUILD_LOCK_OPS(write, rwlock_t, rwlock_is_locked);
 
 #endif /* CONFIG_PREEMPT */
 
