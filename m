Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVL1Q3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVL1Q3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 11:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVL1Q3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 11:29:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50284 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964840AbVL1Q3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 11:29:49 -0500
Date: Wed, 28 Dec 2005 11:29:48 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 1/3] mutex subsystem: trylock
In-reply-to: <20051228081348.GA6910@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512281101510.3309@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
 <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain>
 <20051227115129.GB23587@elte.hu>
 <Pine.LNX.4.64.0512271439380.3309@localhost.localdomain>
 <20051228074857.GA4600@elte.hu> <20051228081348.GA6910@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2005, Ingo Molnar wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > * Nicolas Pitre <nico@cam.org> wrote:
> > 
> > > > here we go to great trouble trying to avoid the 'slowpath', while we 
> > > > unconditionally force the next unlock into the slowpath! So we have 
> > > > not won anything. (on a cycle count basis it's probably even a net 
> > > > loss)
> > > 
> > > I disagree.  [...elaborate analysis of the code ...]
> > 
> > you are right, it should work fine, and should be optimal. I'll add 
> > your xchg variant to mutex-xchg.h.
> 
> the patch below adds it, and it boots fine on x86 with mutex.c hacked to 
> include asm-generic/mutex-xchg.h.

Here's an additional patch to fix some comments, and to add a small 
optimization.

Index: linux-2.6/include/asm-generic/mutex-xchg.h
===================================================================
--- linux-2.6.orig/include/asm-generic/mutex-xchg.h
+++ linux-2.6/include/asm-generic/mutex-xchg.h
@@ -75,9 +75,14 @@ do {									\
  *  @count: pointer of type atomic_t
  *  @fn: spinlock based trylock implementation
  *
- * We call the spinlock based generic variant, because atomic_xchg() is
- * too destructive to provide a simpler trylock implementation than the
- * spinlock based one.
+ * Change the count from 1 to a value lower than 1, and return 0 (failure)
+ * if it wasn't 1 originally, or return 1 (success) otherwise. This function
+ * MUST leave the value lower than 1 even when the "1" assertion wasn't true.
+ * Additionally, if the value was < 0 originally, this function must not leave
+ * it to 0 on failure.
+ *
+ * If the architecture has no effective trylock variant, it should call the
+ * <fn> spinlock-based trylock variant unconditionally.
  */
 static inline int
 __mutex_fastpath_trylock(atomic_t *count, int (*fn)(atomic_t *))
@@ -90,12 +95,13 @@ __mutex_fastpath_trylock(atomic_t *count
 		 * state. If while doing so we get back a prev value of 1
 		 * then we just own it.
 		 *
-		 * [ In the rare case of the mutex going to 1 and then to 0
-		 *   in this few-instructions window, this has the potential
-		 *   to trigger the slowpath for the owner's unlock path, but
-		 *   that's not a problem in practice. ]
+		 * [ In the rare case of the mutex going to 1, to 0, to -1
+		 *   and then back to 0 in this few-instructions window,
+		 *   this has the potential to trigger the slowpath for the
+		 *   owner's unlock path needlessly, but that's not a problem
+		 *   in practice. ]
 		 */
-		prev = atomic_xchg(count, -1);
+		prev = atomic_xchg(count, prev);
 		if (prev < 0)
 			prev = 0;
 	}
