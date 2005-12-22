Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVLVBTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVLVBTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 20:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVLVBTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 20:19:33 -0500
Received: from waste.org ([64.81.244.121]:34946 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S965014AbVLVBTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 20:19:33 -0500
Date: Wed, 21 Dec 2005 19:16:37 -0600
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 3/3] mutex subsystem: move the core to the new atomic helpers
Message-ID: <20051222011637.GA1639@waste.org>
References: <20051221155411.GA7243@elte.hu> <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain> <20051221231218.GA6747@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221231218.GA6747@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 12:12:18AM +0100, Ingo Molnar wrote:
> 
> * Nicolas Pitre <nico@cam.org> wrote:
> 
> > This patch moves the core mutex code over to the atomic helpers from 
> > previous patch.  There is no change for i386 and x86_64, except for 
> > the forced unlock state that is now done outside the spinlock (doing 
> > so doesn't matter since another CPU could have locked the mutex right 
> > away even if it was unlocked inside the spinlock).  This however 
> > brings great improvements on ARM for example.
> 
> i'm wondering how much difference it makes on ARM - could you show us 
> the before and after disassembly of the fastpath, to see the 
> improvement?
> 
> your patches look OK to me, only one small detail sticks out: i'd 
> suggest to rename the atomic_*_contended macros to be arch_mutex_*_..., 
> i dont think any other code can make use of it. Also, it would be nice 
> to see the actual ARM patches as well, which make use of the new 
> infrastructure.

I'm personally a little worried about the recent proliferation of
atomic_*.

My take on atomic_* functions has always been: a "sensible" arch [1]
implements the functionality in a single atomic instruction and this
simply exposes that instruction at the C level which otherwise lacks
appropriate semantics.

So functions like atomic_dec_call_if_negative seem a) excessively
special purpose b) not fundamental in the
ought-to-be-a-single-instruction sense c) a bit out of place in the in
the atomic_* set. These might even encourage people to roll their own
special-purpose locking primitives and we have way too many of those
already.

[1] In Linus' famous sense of what an ideal architecture should look like

-- 
Mathematics is the supreme nostalgia of our time.
