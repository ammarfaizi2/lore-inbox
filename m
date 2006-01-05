Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWAEWDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWAEWDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWAEWDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:03:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14290 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932244AbWAEWD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:03:28 -0500
Date: Thu, 5 Jan 2006 23:03:05 +0100
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
Message-ID: <20060105220305.GA8372@elte.hu>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <Pine.LNX.4.64.0601042133230.27409@localhost.localdomain> <Pine.LNX.4.64.0601041847330.3279@g5.osdl.org> <20060105144016.GB16816@elte.hu> <Pine.LNX.4.64.0601050810240.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601050810240.3169@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Thu, 5 Jan 2006, Ingo Molnar wrote:
> > 
> > the patch below adds the barriers to the asm-generic mutex routines, so 
> > it's not like i'm lazy ;), but i really think this is unnecessary.  
> > Adding this patch would add a second, unnecessary barrier for all the 
> > arches that have barrier-less atomic ops.
> > 
> > it also makes sense: the moment you are interested in the 'previous 
> > value' of the atomic counter in an atomic fashion, you very likely want 
> > to use it for a critical section. (e.g. all the put-the-resource ops 
> > that use atomic_dec_test() rely on this implicit barrier.)
> 
> Ok, fair enough. However, that still leaves the question of which way 
> the barrier works. Traditionally, we have only cared about one thing: 
> that all preceding writes have finished, because the 
> "atomic_dec_return" thing is used as a _reference_counter_, and we're 
> going to release the thing.

yeah, i think you are right. Here's a detailed analysis of why you are 
right about atomic_dec_return():

there are 8 types of instruction reordering that can happen at the 
beginning and at the end of a critical section. Firstly, here's the 
programmed order of instructions:

     pre-read
     pre-write
     [critical-START]
     critial-read
     critical-write
     [critical-END]
     post-read
     post-write

the following reorderings are possible:

 a pre-read   crossing forwards into (and over) the critical section: OK
 a pre-write  crossing forwards into (and over) the critical section: OK
 a critical-read  crossing backwards across critical-START: BAD
 a critical-write crossing backwards across critical-START: BAD
 a critical-read  crossing forwards  across critical-END:   BAD
 a critical-write crossing forwards  across critical-END:   BAD
 a post-read  crossing backwards into (and over) the critical section: OK
 a post-write crossing backwards into (and over) the critical section: OK

so critical-START needs to be a read and a write barrier for reads and 
writes happening after it. I.e. it's a memory barrier that only lets 
instruction reordering in a forward direction, not in a backwards 
direction.

critical-END needs to be a read and write barrier that only lets 
instructions into the critical section in a backwards direction - and 
it's a full memory barrier otherwise.

AFAICS, currently we dont have such a 'half-conductor / diode' memory 
barrier primitive: smp_mb() is a full barrier for both directions. But 
lets assume they existed, and lets call them smp_mb_forwards() and 
smp_mb_backwards().

furthermore, the locking and unlocking instruction must not cross into 
the critical section, so the lock sequence must be at least:

	lock
	smp_rmb_for_lock_forwards()
	smp_mb_backwards()
	... critical section ...
	smp_mb_forwards()
	smp_wmb_for_lock_backwards()
	unlock

and yet another requirement is that two subsequent critical sections for 
the same lock must not reorder the 'lock' and 'unlock' instructions:

	smp_mb_forwards()
	unlock
	... unlocked code ...
	lock
	smp_mb_backwards()

i.e. 'lock' and 'unlock' must not switch places. So the most relaxed 
list of requirements would be:

	smp_wmb_for_lock_backwards()
	lock
	smp_wmb_for_lock_forwards()
	smp_mb_backwards()
	... critical section ...
	smp_mb_forwards()
	smp_wmb_for_lock_backwards()
	unlock

i also think this is the 'absolute minimum memory ordering requirement' 
for critical sections: relaxing this any further is not possible without 
breaking critical sections.

i doubt many (in fact, any) CPUs are capable of expressing it in such a 
finegrained way. With our existing primitives, probably the closest one 
would be:

	lock
	smp_mb();
	...
	smp_mb();
	unlock

as long as the CPU always executes the lock and unlock stores (which go 
to the same address) in program order. (is there any CPU doesnt do 
that?)

in that sense, both atomic_dec_return() and atomic_inc_return() are in 
indeed incorrect (for the use of mutexes) e.g. on ppc64. They are both 
done via:

	eioio
	... atomic-dec ...
	isync

eioio is a stronger than smp_wmb() - it is a barrier for system memory 
and IO space memory writes. isync is a read barrier - it throws away all 
speculative register contents. So it is roughly equivalent to:

	smp_wmb();
	... atomic-dec ...
	smp_rmb();

this fulfills the requirement of the critical section not leaking out of 
the lock sequence itself, but (if i got the ppc64 semantics right) it 
doesnt protect a write within the critical section to cross out over the 
smp_rmb(), and to get reordered with the atomic-dec - violating the 
critical section rules.

some other architectures are safe by accident, e.g. Alpha's 
atomic_dec_return() does:

	smp_mb();
	... atomic-dec ...
	smp_mb();

which is overkill, full read and write barrier on both sides.

Sparc64's atomic_dec_return() does yet another thing:

	membar StoreLoad | LoadLoad
	... atomic-load ...
	... atomic-conditional-store ...
	membar StoreLoad | StoreStore

AFAICS this violates the requirements: a load from within the critical 
section may go before the atomic-conditional-store, and may thus be 
executed before the critical section acquires the lock.

on MIPS, atomic_dec_return() does what is equivalent to:

	... atomic-dec ...
	smp_mb();

which is fine for a lock sequence, but atomic_inc_return() is not 
adequate for an unlock sequence:

	... atomic-inc ...
	smp_mb();

because this allows reads and writes within the critical section to 
reorder with the atomic-inc instructions.

to sum it up: atomic_dec/inc_return() alone is not enough to implement 
critical sections, on a number of architectures. atomic_xchg() seems to 
have similar problems too.

the patch below adds the smp_mb() barriers to the generic headers, which 
should now fulfill all the ordering requirements, on every architecture.  
It only relies on one property of the atomic primitives: that they wont 
get reordered with respect to themselves, so an atomic_inc_ret() and an 
atomic_dec_ret() cannot switch place.

Can you see any hole in this reasoning?

	Ingo

Index: linux/include/asm-generic/mutex-dec.h
===================================================================
--- linux.orig/include/asm-generic/mutex-dec.h
+++ linux/include/asm-generic/mutex-dec.h
@@ -21,6 +21,8 @@
 do {									\
 	if (unlikely(atomic_dec_return(count) < 0))			\
 		fail_fn(count);						\
+	else								\
+		smp_mb();						\
 } while (0)
 
 /**
@@ -38,8 +40,10 @@ __mutex_fastpath_lock_retval(atomic_t *c
 {
 	if (unlikely(atomic_dec_return(count) < 0))
 		return fail_fn(count);
-	else
+	else {
+		smp_mb();
 		return 0;
+	}
 }
 
 /**
@@ -57,6 +61,7 @@ __mutex_fastpath_lock_retval(atomic_t *c
  */
 #define __mutex_fastpath_unlock(count, fail_fn)				\
 do {									\
+	smp_mb();							\
 	if (unlikely(atomic_inc_return(count) <= 0))			\
 		fail_fn(count);						\
 } while (0)
@@ -92,8 +97,10 @@ __mutex_fastpath_trylock(atomic_t *count
 	 * the mutex state would be.
 	 */
 #ifdef __HAVE_ARCH_CMPXCHG
-	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
+	if (likely(atomic_cmpxchg(count, 1, 0)) == 1) {
+		smp_mb();
 		return 1;
+	}
 	return 0;
 #else
 	return fail_fn(count);
Index: linux/include/asm-generic/mutex-xchg.h
===================================================================
--- linux.orig/include/asm-generic/mutex-xchg.h
+++ linux/include/asm-generic/mutex-xchg.h
@@ -26,6 +26,8 @@
 do {									\
 	if (unlikely(atomic_xchg(count, 0) != 1))			\
 		fail_fn(count);						\
+	else								\
+		smp_mb();						\
 } while (0)
 
 
@@ -44,8 +46,10 @@ __mutex_fastpath_lock_retval(atomic_t *c
 {
 	if (unlikely(atomic_xchg(count, 0) != 1))
 		return fail_fn(count);
-	else
+	else {
+		smp_mb();
 		return 0;
+	}
 }
 
 /**
@@ -62,6 +66,7 @@ __mutex_fastpath_lock_retval(atomic_t *c
  */
 #define __mutex_fastpath_unlock(count, fail_fn)				\
 do {									\
+	smp_mb();							\
 	if (unlikely(atomic_xchg(count, 1) != 0))			\
 		fail_fn(count);						\
 } while (0)
@@ -104,6 +109,7 @@ __mutex_fastpath_trylock(atomic_t *count
 		if (prev < 0)
 			prev = 0;
 	}
+	smp_mb();
 
 	return prev;
 }
