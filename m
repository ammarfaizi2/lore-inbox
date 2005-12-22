Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVLVPeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVLVPeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVLVPeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:34:20 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13110 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751107AbVLVPeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:34:20 -0500
Date: Thu, 22 Dec 2005 10:34:18 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-reply-to: <20051222115329.GA30964@infradead.org>
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
Message-id: <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222114147.GA18878@elte.hu>
 <20051222115329.GA30964@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Christoph Hellwig wrote:

> On Thu, Dec 22, 2005 at 12:41:47PM +0100, Ingo Molnar wrote:
> > this is the -V4 of the mutex subsystem patch-queue. It consists of the 
> > following patches:
> > 
> >   add-atomic-xchg.patch
> >   add-atomic-call-func-i386.patch
> >   add-atomic-call-func-x86_64.patch
> >   add-atomic-call-wrappers-rest.patch
> >   mutex-core.patch
> >   mutex-switch-arm-to-xchg.patch
> >   mutex-debug.patch
> >   mutex-debug-more.patch
> >   xfs-mutex-namespace-collision-fix.patch
> > 
> > the patches are against Linus' latest GIT tree, and they should work 
> > fine on every Linux architecture.
> > 
> > Changes since -V3:
> > 
> > - imlemented an atomic_xchg() based mutex implementation. It integrated
> >   pretty nicely into the generic code, and most of the code is still
> >   shared.
> > 
> > - added __ARCH_WANT_XCHG_BASED_ATOMICS: if an architecture defines 
> >   this then the generic mutex code will switch to the atomic_xchg() 
> >   implementation.
> > 
> >   This should be conceptually equivalent to the variant Nicolas Pitre 
> >   posted - Nicolas, could you check out this one? It's much easier to 
> >   provide this in the generic implementation, and the code ends up 
> >   looking cleaner.
> > 
> > - eliminated ARCH_IMPLEMENTS_MUTEX_FASTPATH: there's no need for 
> >   architectures to override the generic code anymore, with the 
> >   introduction of __ARCH_WANT_XCHG_BASED_ATOMICS.
> > 
> > - ARM: enable __ARCH_WANT_XCHG_BASED_ATOMICS.
> 
> I must admit I really really hat __ARCH_ stuff if we can avoid it.
> An <asm/mutex.h> that usually includes two asm-generic variants is probably
> a much better choice.
> 
> Actually just havign asm/mutex.h implement the faspath per-arch and get
> rid of all the oddball atomic.h additions would be even better.  While
> this means we need per-arch code it also means the code is a lot easier
> understandable, and we don't add odd public APIs.

I'm with Christoph here.  Please preserve my 
arch_mutex_fast_lock/arch_mutex_fast_unlock helpers.  I did it that way 
because the most important thing they bring is flexibility where it is 
needed i.e. in architecture specific implementations.  And done that way 
the architecture specific part is well abstracted with the minimum 
semantics allowing flexibility in the implementation.

I insist on that because, even if ARM currently relies on the atomic 
swap behavior, on ARMv6 at least this can be improved even further, but 
a special implementation which is neither a fully qualified atomic 
decrement nor an atomic swap is needed.  That's why I insist that you 
should keep my arch_mutex_fast_lock and friends (rename them if you 
wish) and remove __ARCH_WANT_XCHG_BASED_ATOMICS entirely.


Nicolas
