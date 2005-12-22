Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbVLVSYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbVLVSYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVLVSYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:24:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:12526 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030235AbVLVSYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:24:42 -0500
Date: Thu, 22 Dec 2005 13:24:41 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-reply-to: <1135272780.12761.10.camel@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Andi Kleen <ak@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512221321480.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222114147.GA18878@elte.hu>
 <20051222115329.GA30964@infradead.org>
 <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain>
 <1135272780.12761.10.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Steven Rostedt wrote:

> On Thu, 2005-12-22 at 10:34 -0500, Nicolas Pitre wrote:
> 
> > > Actually just havign asm/mutex.h implement the faspath per-arch and get
> > > rid of all the oddball atomic.h additions would be even better.  While
> > > this means we need per-arch code it also means the code is a lot easier
> > > understandable, and we don't add odd public APIs.
> > 
> > I'm with Christoph here.  Please preserve my 
> > arch_mutex_fast_lock/arch_mutex_fast_unlock helpers.  I did it that way 
> > because the most important thing they bring is flexibility where it is 
> > needed i.e. in architecture specific implementations.  And done that way 
> > the architecture specific part is well abstracted with the minimum 
> > semantics allowing flexibility in the implementation.
> > 
> > I insist on that because, even if ARM currently relies on the atomic 
> > swap behavior, on ARMv6 at least this can be improved even further, but 
> > a special implementation which is neither a fully qualified atomic 
> > decrement nor an atomic swap is needed.  That's why I insist that you 
> > should keep my arch_mutex_fast_lock and friends (rename them if you 
> > wish) and remove __ARCH_WANT_XCHG_BASED_ATOMICS entirely.
> > 
> 
> Not sure how well this is accepted, but would it be acceptable to have
> the mutex_lock and friends covered with the (weak) attribute?
> 
> ie.
> 
> void fastcall __sched __attribute__((weak)) mutex_lock(struct mutex *lock)
> 
> Then let the archs override them if they wish?

Actually, my next request would be for architectures to actually inline 
the fast path if they see benefit.  On ARM, given the tight fast path 
allowed by mutexes, it is indeed beneficial to inline them (the last 
patch of my latest serie does just that).  So weak symbols are not 
really useful in that case.


Nicolas
