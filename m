Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVLUWo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVLUWo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVLUWo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:44:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32715 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964899AbVLUWo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:44:57 -0500
Date: Wed, 21 Dec 2005 17:44:56 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [patch 3/3] mutex subsystem: move the core to the new atomic helpers
In-reply-to: <20051221155411.GA7243@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051221155411.GA7243@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the core mutex code over to the atomic helpers from 
previous patch.  There is no change for i386 and x86_64, except for the 
forced unlock state that is now done outside the spinlock (doing so 
doesn't matter since another CPU could have locked the mutex right away 
even if it was unlocked inside the spinlock).  This however brings great 
improvements on ARM for example.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Index: linux-2.6/kernel/mutex.c
===================================================================
--- linux-2.6.orig/kernel/mutex.c
+++ linux-2.6/kernel/mutex.c
@@ -296,14 +296,6 @@ static inline void __mutex_unlock_nonato
 
 	debug_mutex_unlock(lock);
 
-	/*
-	 * Set it back to 'unlocked'. We'll have a waiter in flight
-	 * (if any), and if some other task comes around, let it
-	 * steal the lock. Waiters take care of themselves and stay
-	 * in flight until necessary.
-	 */
-	atomic_set(&lock->count, 1);
-
 	if (!list_empty(&lock->wait_list))
 		mutex_wakeup_waiter(lock __IP__);
 
@@ -329,7 +321,7 @@ static __sched void FASTCALL(__mutex_loc
  */
 static inline void __mutex_lock_atomic(struct mutex *lock)
 {
-	atomic_dec_call_if_negative(&lock->count, __mutex_lock_noinline);
+	atomic_lock_call_if_contended(&lock->count, __mutex_lock_noinline);
 }
 
 static fastcall __sched void __mutex_lock_noinline(atomic_t *lock_count)
@@ -359,13 +351,19 @@ static void __sched FASTCALL(__mutex_unl
  */
 static inline void __mutex_unlock_atomic(struct mutex *lock)
 {
-	atomic_inc_call_if_nonpositive(&lock->count, __mutex_unlock_noinline);
+	atomic_unlock_call_if_contended(&lock->count, __mutex_unlock_noinline);
 }
 
 static fastcall void __sched __mutex_unlock_noinline(atomic_t *lock_count)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
 
+	/*
+	 * We were called via atomic_unlock_call_if_contended() therefore
+	 * we need to call atomic_contended_unlock_fixup() which will set
+	 * it to unlocked (if it wasn't done already).
+	 */
+	atomic_contended_unlock_fixup(lock_count);
 	__mutex_unlock_nonatomic(lock);
 }
 
@@ -383,6 +381,13 @@ static inline void __mutex_lock(struct m
 
 static inline void __mutex_unlock(struct mutex *lock __IP_DECL__)
 {
+	/*
+	 * Set it back to 'unlocked'. We'll have a waiter in flight
+	 * (if any), and if some other task comes around, let it
+	 * steal the lock. Waiters take care of themselves and stay
+	 * in flight until necessary.
+	 */
+	atomic_set(&lock->count, 1);
 	__mutex_unlock_nonatomic(lock __IP__);
 }
 
