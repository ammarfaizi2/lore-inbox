Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWARHHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWARHHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWARHHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:07:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:32655 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030272AbWARHH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:07:28 -0500
Date: Wed, 18 Jan 2006 08:07:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Lynch <ntl@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060118070734.GB24378@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060115230557.0f07a55c.akpm@osdl.org> <200601170000.58134.michael@ellerman.id.au> <20060116153748.GA25866@sergelap.austin.ibm.com> <20060116215252.GA10538@cs.umn.edu> <20060116170907.60149236.akpm@osdl.org> <20060117081749.GA10135@elte.hu> <20060117165244.GA23254@cs.umn.edu> <20060117165555.GA24562@cs.umn.edu> <20060118064050.GQ2846@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118064050.GQ2846@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Lynch <ntl@pobox.com> wrote:

> Dave C Boutcher wrote:
> > On Tue, Jan 17, 2006 at 10:52:44AM -0600, Dave C Boutcher wrote:
> > > Well, it turns out that I've been running with CONFIG_DEBUG_MUTEXES all
> > > along...so no noise.  My console output is a little different that
> > > Serge's, so I think this is timing related.  Also note that I'm dying in
> > > the timer interrupt...
> > 
> > duh... here's the backtrace
> > 0:mon> t
> > [c000000000577890] c0000000000034b4 decrementer_common+0xb4/0x100
> > --- Exception: 901 (Decrementer) at c0000000004627ec
> > .__mutex_lock_interruptible_slowpath+0x3bc/0x4c4
> > [c000000000577c60] c000000000075064 .__lock_cpu_hotplug+0x44/0xa8
> > [c000000000577ce0] c000000000075600 .register_cpu_notifier+0x24/0x68
> > [c000000000577d70] c00000000052cd7c .do_init_bootmem+0x68c/0xab0
> > [c000000000577e50] c000000000522c84 .setup_arch+0x21c/0x2c0
> > [c000000000577ef0] c00000000051a538 .start_kernel+0x40/0x280
> > [c000000000577f90] c000000000008574 .hmt_init+0x0/0x8c
> 
> The mutex debug code (debug_spin_unlock in kernel/mutex-debug.h) is 
> doing a local_irq_enable way before we're ready.
> 
> BTW: I couldn't build powerpc without mutex debugging until I changed 
> the SYNC_ON_SMP in include/asm-powerpc/mutex.h:__mutex_fastpath_unlock 
> to ISYNC_ON_SMP.
> 
> With that change, I was able to boot semi-successfully with mutex 
> debugging off -- the system got hung up when udev started, apparently 
> (or maybe I was too impatient).

ugh! Does the patch below get you a working system with DEBUG_MUTEXES=n?

	Ingo

--

revert the ppc64 mutex fastpath assembly optimizations for now.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----
 include/asm-powerpc/mutex.h |   85 ++------------------------------------------
 1 files changed, 5 insertions(+), 80 deletions(-)

Index: linux/include/asm-powerpc/mutex.h
===================================================================
--- linux.orig/include/asm-powerpc/mutex.h
+++ linux/include/asm-powerpc/mutex.h
@@ -1,84 +1,9 @@
 /*
- * include/asm-powerpc/mutex.h
+ * Pull in the generic implementation for the mutex fastpath.
  *
- * PowerPC optimized mutex locking primitives
- *
- * Please look into asm-generic/mutex-xchg.h for a formal definition.
- * Copyright (C) 2006 Joel Schopp <jschopp@austin.ibm.com>, IBM
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
  */
-#ifndef _ASM_MUTEX_H
-#define _ASM_MUTEX_H
-#define __mutex_fastpath_lock(count, fail_fn)\
-do{					\
-	int tmp;			\
-	__asm__ __volatile__(		\
-"1:	lwarx		%0,0,%1\n"	\
-"	addic		%0,%0,-1\n"	\
-"	stwcx.		%0,0,%1\n"	\
-"	bne-		1b\n"		\
-	ISYNC_ON_SMP			\
-	: "=&r" (tmp)			\
-	: "r" (&(count)->counter)	\
-	: "cr0", "memory");		\
-	if (unlikely(tmp < 0))		\
-		fail_fn(count);		\
-} while (0)
-
-#define __mutex_fastpath_unlock(count, fail_fn)\
-do{					\
-	int tmp;			\
-	__asm__ __volatile__(SYNC_ON_SMP\
-"1:	lwarx		%0,0,%1\n"	\
-"	addic		%0,%0,1\n"	\
-"	stwcx.		%0,0,%1\n"	\
-"	bne-		1b\n"		\
-	: "=&r" (tmp)			\
-	: "r" (&(count)->counter)	\
-	: "cr0", "memory");		\
-	if (unlikely(tmp <= 0))		\
-		fail_fn(count);		\
-} while (0)
-
-
-static inline int
-__mutex_fastpath_trylock(atomic_t* count, int (*fail_fn)(atomic_t*))
-{
-	int tmp;
-	__asm__ __volatile__(
-"1:	lwarx		%0,0,%1\n"
-"	cmpwi		0,%0,1\n"
-"	bne-		2f\n"
-"	addic		%0,%0,-1\n"
-"	stwcx.		%0,0,%1\n"
-"	bne-		1b\n"
-"	isync\n"
-"2:"
-	: "=&r" (tmp)
-	: "r" (&(count)->counter)
-	: "cr0", "memory");
-
-	return (int)tmp;
-
-}
-
-#define __mutex_slowpath_needs_to_unlock()		1
 
-static inline int
-__mutex_fastpath_lock_retval(atomic_t* count, int (*fail_fn)(atomic_t *))
-{
-	int tmp;
-	__asm__ __volatile__(
-"1:	lwarx		%0,0,%1\n"
-"	addic		%0,%0,-1\n"
-"	stwcx.		%0,0,%1\n"
-"	bne-		1b\n"
-"	isync		\n"
-	: "=&r" (tmp)
-	: "r" (&(count)->counter)
-	: "cr0", "memory");
-	if (unlikely(tmp < 0))
-		return fail_fn(count);
-	else
-		return 0;
-}
-#endif
+#include <asm-generic/mutex-dec.h>
