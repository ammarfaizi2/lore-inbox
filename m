Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVL1IOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVL1IOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 03:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVL1IOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 03:14:07 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:48818 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932503AbVL1IOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 03:14:06 -0500
Date: Wed, 28 Dec 2005 09:13:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 1/3] mutex subsystem: trylock
Message-ID: <20051228081348.GA6910@elte.hu>
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain> <20051227115129.GB23587@elte.hu> <Pine.LNX.4.64.0512271439380.3309@localhost.localdomain> <20051228074857.GA4600@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228074857.GA4600@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> * Nicolas Pitre <nico@cam.org> wrote:
> 
> > > here we go to great trouble trying to avoid the 'slowpath', while we 
> > > unconditionally force the next unlock into the slowpath! So we have 
> > > not won anything. (on a cycle count basis it's probably even a net 
> > > loss)
> > 
> > I disagree.  [...elaborate analysis of the code ...]
> 
> you are right, it should work fine, and should be optimal. I'll add 
> your xchg variant to mutex-xchg.h.

the patch below adds it, and it boots fine on x86 with mutex.c hacked to 
include asm-generic/mutex-xchg.h.

	Ingo

Index: linux/include/asm-generic/mutex-xchg.h
===================================================================
--- linux.orig/include/asm-generic/mutex-xchg.h
+++ linux/include/asm-generic/mutex-xchg.h
@@ -82,7 +82,25 @@ do {									\
 static inline int
 __mutex_fastpath_trylock(atomic_t *count, int (*fn)(atomic_t *))
 {
-	return fn(count);
+	int prev = atomic_xchg(count, 0);
+
+	if (unlikely(prev < 0)) {
+		/*
+		 * The lock was marked contended so we must restore that
+		 * state. If while doing so we get back a prev value of 1
+		 * then we just own it.
+		 *
+		 * [ In the rare case of the mutex going to 1 and then to 0
+		 *   in this few-instructions window, this has the potential
+		 *   to trigger the slowpath for the owner's unlock path, but
+		 *   that's not a problem in practice. ]
+		 */
+		prev = atomic_xchg(count, -1);
+		if (prev < 0)
+			prev = 0;
+	}
+
+	return prev;
 }
 
 #endif
