Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbVLVQcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbVLVQcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVLVQcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:32:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21332 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965163AbVLVQcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:32:14 -0500
Date: Thu, 22 Dec 2005 11:32:13 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-reply-to: <20051222154012.GA6284@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222114147.GA18878@elte.hu>
 <20051222115329.GA30964@infradead.org>
 <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain>
 <20051222154012.GA6284@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Ingo Molnar wrote:

> 
> * Nicolas Pitre <nico@cam.org> wrote:
> 
> > [...] on ARMv6 at least this can be improved even further, but a 
> > special implementation which is neither a fully qualified atomic 
> > decrement nor an atomic swap is needed. [...]
> 
> i'm curious, how would this ARMv6 solution look like, and what would be 
> the advantages over the atomic swap based variant?

On ARMv6 (which can be SMP) the atomic swap instruction is much more 
costly than on former ARM versions.  It however has ll/sc instructions 
which allows it to implement a true atomic decrement, and the lock fast 
path would look like:

__mutex_lock:
1:	ldrex	r1, [r0]
	sub	r1, r1, #1
	strex	r2, r1, [r0]
	cmp	r2, #0
	bne	1b
	cmp	r1, #0
	moveq	pc, lr
	b	__mutex_lock_failed

With my ARMv6 implementation of arch_mutex_fast_lock() then it would 
become:

__mutex_lock:
	ldrex	r1, [r0]
	sub	r1, r1, #1
	strex	r2, r1, [r0]
	orrs	r0, r2, r1
	moveq	pc, lr
	b	__mutex_lock_failed

This code sequence is not possible with any of the standard atomic 
primitives. And the above would work even for the 
arch_mutex_fast_lock_retval() used for mutex_lock_interruptible.

Giving complete freedom to the architecture in implementing those could 
benefit architectures where disabling preemption while performing the 
lock instead of attempting any true atomic operation would be cheaper 
(Linus argued about that previously).  And if we are UP with preemption 
disabled then the lock could possibly be simplified even further if 
someone dare to.

But those implementation issues don't belong in the common core code at 
all IMHO.


Nicolas
