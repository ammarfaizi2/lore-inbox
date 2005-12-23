Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbVLWE7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbVLWE7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 23:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbVLWE7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 23:59:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34601 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030434AbVLWE7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 23:59:13 -0500
Date: Thu, 22 Dec 2005 23:59:12 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, -V6
In-reply-to: <20051222230438.GA13302@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@infradead.org>
Message-id: <Pine.LNX.4.64.0512222355130.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222230438.GA13302@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2005, Ingo Molnar wrote:

> this is verion -V6 of the generic mutex subsystem.

Here's a patch to fix a few minor things: some comments were wrong, some 
were irrelevant, another was duplicated.  Also remove a bogus "return 0".

Index: linux-2.6/include/asm-generic/mutex-dec.h
===================================================================
--- linux-2.6.orig/include/asm-generic/mutex-dec.h
+++ linux-2.6/include/asm-generic/mutex-dec.h
@@ -1,7 +1,7 @@
 /*
  * asm-generic/mutex-dec.h
  *
- * Generic wrappers for the mutex fastpath based on an xchg() implementation
+ * Generic wrappers for the mutex fastpath based on atomic increment/decrement
  *
  */
 #ifndef _ASM_GENERIC_MUTEX_DEC_H
@@ -46,7 +46,7 @@ __mutex_fastpath_lock_retval(atomic_t *c
 /**
  *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
  *  @count: pointer of type atomic_t
- *  @fn: function to call if the original value was not 1
+ *  @fn: function to call if the original value was not 0
  *
  * try to promote the mutex from 0 to 1. if it wasn't 0, call <function>
  * In the failure case, this function is allowed to either set the value to
Index: linux-2.6/include/asm-generic/mutex-xchg.h
===================================================================
--- linux-2.6.orig/include/asm-generic/mutex-xchg.h
+++ linux-2.6/include/asm-generic/mutex-xchg.h
@@ -51,7 +51,7 @@ __mutex_fastpath_lock_retval(atomic_t *c
 /**
  *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
  *  @count: pointer of type atomic_t
- *  @fn: function to call if the original value was not 1
+ *  @fn: function to call if the original value was not 0
  *
  * try to promote the mutex from 0 to 1. if it wasn't 0, call <function>
  * In the failure case, this function is allowed to either set the value to
Index: linux-2.6/include/asm-i386/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-i386/mutex.h
+++ linux-2.6/include/asm-i386/mutex.h
@@ -61,7 +61,7 @@ __mutex_fastpath_lock_retval(atomic_t *c
 /**
  *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
  *  @count: pointer of type atomic_t
- *  @fn: function to call if the original value was not 1
+ *  @fn: function to call if the original value was not 0
  *
  * try to promote the mutex from 0 to 1. if it wasn't 0, call <function>
  * In the failure case, this function is allowed to either set the value to
Index: linux-2.6/kernel/mutex.c
===================================================================
--- linux-2.6.orig/kernel/mutex.c
+++ linux-2.6/kernel/mutex.c
@@ -344,10 +344,6 @@ static inline void __mutex_unlock_nonato
 static __sched void FASTCALL(__mutex_lock_noinline(atomic_t *lock_count));
 
 /*
- * Some architectures do not have fast dec_and_test atomic primitives,
- * for them we are providing an atomic_xchg() based mutex implementation,
- * if they enable CONFIG_MUTEX_XCHG_ALGORITHM.
- *
  * The locking fastpath is the 1->0 transition from 'unlocked' into
  * 'locked' state:
  */
@@ -356,11 +352,6 @@ static inline void __mutex_lock_atomic(s
 	__mutex_fastpath_lock(&lock->count, __mutex_lock_noinline);
 }
 
-/*
- * We put the slowpath into a separate function. This reduces
- * register pressure in the fastpath, and also enables the
- * atomic_[inc/dec]_call_if_[negative|nonpositive]() primitives.
- */
 static void fastcall __sched __mutex_lock_noinline(atomic_t *lock_count)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
@@ -380,7 +371,6 @@ static inline int __mutex_lock_interrupt
 {
 	return __mutex_fastpath_lock_retval
 			(&lock->count, __mutex_lock_interruptible_noinline);
-	return 0;
 }
 
 static int fastcall __sched
