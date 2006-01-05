Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWAEOlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWAEOlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAEOlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:41:01 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:38034 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751371AbWAEOkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:40:33 -0500
Date: Thu, 5 Jan 2006 15:40:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nicolas Pitre <nico@cam.org>, Joel Schopp <jschopp@austin.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
Message-ID: <20060105144016.GB16816@elte.hu>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <Pine.LNX.4.64.0601042133230.27409@localhost.localdomain> <Pine.LNX.4.64.0601041847330.3279@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601041847330.3279@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Well, if the generic one generates _buggy_ code on ppc64, that means 
> that either the generic version is buggy, or one of the atomics that 
> it uses is buggily implemented on ppc64.
> 
> And I think it's the generic mutex stuff that is buggy. It seems to 
> assume memory barriers that aren't valid to assume.

in those headers i'm only using atomic_dec_return(), atomic_cmpxchg() 
and atomic_xchg() - all of which imply a barrier. It is 
atomic_inc/add/sub/dec() that doesnt default to an implied SMP barrier.

but it's certainly not documented too well. If atomic_dec_return() is 
not supposed to imply a barrier, then all the affected architectures 
(sparc64, ppc64, mips, alpha, etc.) are overdoing synchronization 
currently: they all have barriers for these primitives. [They also have 
an implicit barrier for atomic_dec_test() - which is being relied on for 
correctness - no kernel code adds an smp_mb__before_atomic_dec() barrier 
to around atomic_dec_test().]

the patch below adds the barriers to the asm-generic mutex routines, so 
it's not like i'm lazy ;), but i really think this is unnecessary.  
Adding this patch would add a second, unnecessary barrier for all the 
arches that have barrier-less atomic ops.

it also makes sense: the moment you are interested in the 'previous 
value' of the atomic counter in an atomic fashion, you very likely want 
to use it for a critical section. (e.g. all the put-the-resource ops 
that use atomic_dec_test() rely on this implicit barrier.)

	Ingo

Index: linux/include/asm-generic/mutex-dec.h
===================================================================
--- linux.orig/include/asm-generic/mutex-dec.h
+++ linux/include/asm-generic/mutex-dec.h
@@ -19,6 +19,7 @@
  */
 #define __mutex_fastpath_lock(count, fail_fn)				\
 do {									\
+	smp_mb__before_atomic_dec();					\
 	if (unlikely(atomic_dec_return(count) < 0))			\
 		fail_fn(count);						\
 } while (0)
@@ -36,6 +37,7 @@ do {									\
 static inline int
 __mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
 {
+	smp_mb__before_atomic_dec();
 	if (unlikely(atomic_dec_return(count) < 0))
 		return fail_fn(count);
 	else
@@ -59,6 +61,8 @@ __mutex_fastpath_lock_retval(atomic_t *c
 do {									\
 	if (unlikely(atomic_inc_return(count) <= 0))			\
 		fail_fn(count);						\
+	else								\
+		smp_mb__after_atomic_inc();				\
 } while (0)
 
 #define __mutex_slowpath_needs_to_unlock()		1
@@ -92,6 +96,7 @@ __mutex_fastpath_trylock(atomic_t *count
 	 * the mutex state would be.
 	 */
 #ifdef __HAVE_ARCH_CMPXCHG
+	smp_mb__before_atomic_dec();
 	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
 		return 1;
 	return 0;
Index: linux/include/asm-generic/mutex-xchg.h
===================================================================
--- linux.orig/include/asm-generic/mutex-xchg.h
+++ linux/include/asm-generic/mutex-xchg.h
@@ -24,6 +24,7 @@
  */
 #define __mutex_fastpath_lock(count, fail_fn)				\
 do {									\
+	smp_mb__before_atomic_dec();					\
 	if (unlikely(atomic_xchg(count, 0) != 1))			\
 		fail_fn(count);						\
 } while (0)
@@ -42,6 +43,7 @@ do {									\
 static inline int
 __mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
 {
+	smp_mb__before_atomic_dec();
 	if (unlikely(atomic_xchg(count, 0) != 1))
 		return fail_fn(count);
 	else
@@ -64,6 +66,8 @@ __mutex_fastpath_lock_retval(atomic_t *c
 do {									\
 	if (unlikely(atomic_xchg(count, 1) != 0))			\
 		fail_fn(count);						\
+	else								\
+		smp_mb__after_atomic_inc();				\
 } while (0)
 
 #define __mutex_slowpath_needs_to_unlock()		0
@@ -86,7 +90,10 @@ do {									\
 static inline int
 __mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
 {
-	int prev = atomic_xchg(count, 0);
+	int prev;
+
+	smp_mb__before_atomic_dec();
+	prev = atomic_xchg(count, 0);
 
 	if (unlikely(prev < 0)) {
 		/*
