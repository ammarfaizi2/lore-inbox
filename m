Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVL2EGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVL2EGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 23:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVL2EGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 23:06:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25559 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965007AbVL2EGy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 23:06:54 -0500
Date: Wed, 28 Dec 2005 23:06:53 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 1/3] mutex subsystem: trylock
In-reply-to: <20051227131501.GA29134@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0512282222400.3309@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
 <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain>
 <1135685158.2926.22.camel@laptopd505.fenrus.org>
 <20051227131501.GA29134@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, Ingo Molnar wrote:

> 
> * Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > > + * 1) if the exclusive store fails we fail, and
> > > + *
> > > + * 2) if the decremented value is not zero we don't even attempt the store.
> > 
> > 
> > btw I really think that 1) is wrong. trylock should do everything it 
> > can to get the semaphore short of sleeping. Just because some 
> > cacheline got written to (which might even be shared!) in the middle 
> > of the atomic op is not a good enough reason to fail the trylock imho. 
> > Going into the slowpath.. fine. But here it's a quality of 
> > implementation issue; you COULD get the semaphore without sleeping (at 
> > least probably, you'd have to retry to know for sure) but because 
> > something wrote to the same cacheline as the lock... no. that's just 
> > not good enough.. sorry.
> 
> point. I solved this in my tree by calling the generic trylock <fn> if 
> there's an __ex_flag failure in the ARMv6 case. Should be rare (and thus 
> the call is under unlikely()), and should thus still enable the fast 
> implementation.

I'd solve it like this instead (on top of your latest patches):

Index: linux-2.6/include/asm-arm/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-arm/mutex.h
+++ linux-2.6/include/asm-arm/mutex.h
@@ -110,12 +110,7 @@ do {									\
 
 /*
  * For __mutex_fastpath_trylock we use another construct which could be
- * described as an "incomplete atomic decrement" or a "single value cmpxchg"
- * since it has two modes of failure:
- *
- * 1) if the exclusive store fails we fail, and
- *
- * 2) if the decremented value is not zero we don't even attempt the store.
+ * described as a "single value cmpxchg".
  *
  * This provides the needed trylock semantics like cmpxchg would, but it is
  * lighter and less generic than a true cmpxchg implementation.
@@ -123,27 +118,22 @@ do {									\
 static inline int
 __mutex_fastpath_trylock(atomic_t *count, int (*fn_name)(atomic_t *))
 {
-	int __ex_flag, __res;
+	int __ex_flag, __res, __orig;
 
 	__asm__ (
 
-		"ldrex		%0, [%2]	\n"
-		"subs		%0, %0, #1	\n"
-		"strexeq	%1, %0, [%2]	\n"
+		"1: ldrex	%0, [%3]	\n"
+		"subs		%1, %0, #1	\n"
+		"strexeq	%2, %1, [%3]	\n"
+		"movlt		%0, #0		\n"
+		"cmpeq		%2, #0		\n"
+		"bgt		1b		\n"
 
-		: "=&r" (__res), "=&r" (__ex_flag)
+		: "=&r" (__orig), "=&r" (__res), "=&r" (__ex_flag)
 		: "r" (&count->counter)
 		: "cc", "memory" );
 
-	/*
-	 * We must not return a synthetic 'failure' if the conditional
-	 * did not succeed - drop back into the generic slowpath if
-	 * this happens (should be rare):
-	 */
-	if (unlikely(__ex_flag))
-		return fn_name(count);
-
-	return __res == 0;
+	return __orig;
 }
 
 #endif


Nicolas
