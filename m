Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVLTTtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVLTTtf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVLTTte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:49:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19085 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750953AbVLTTte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:49:34 -0500
Date: Tue, 20 Dec 2005 14:49:32 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
 add-atomic-call-func-x86_64.patch
In-reply-to: <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Message-id: <Pine.LNX.4.64.0512201438490.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051219013507.GE27658@elte.hu>
 <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain>
 <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
 <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain>
 <43A81132.8040703@yahoo.com.au>
 <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Linus Torvalds wrote:

> 
> 
> On Tue, 20 Dec 2005, Nicolas Pitre wrote:
> >
> > Sure, and we're now more costly than the current implementation with irq 
> > disabling.
> 
> Do the timing. It may be more instructions, but I think it was you 
> yourself that timed the current thing at 23 cycles, no?

Yes.  And with my hand-optimized assembly version using 
(the equivalent of) preempt_disable/preempt_enable I get 20 cycles over 
14 instructions.  If I let gcc do it using the standard macros it gets 
worse.

The irq disabling implementation spends 23 cycles over 8 instructions.

The mutex swp-based implementation spends 8 cycles over 4 instructions.

If we make the preempt_disable/enable implementation out of line that'll 
reduce the .text size bloat, but it'LL add more cycles due to the 
additional two branches plus preserve of the return address making it 
above 23 cycles for sure.

> Special registers are almost always slower than nicely cached accesses 
> (and they all basically will be).

Sure, but do the numbers above tell you anything else?  It seems pretty 
obvious to me that simple mutexes are a real gain.  Suffice for the 
implementation to let architecture do their best to lock the mutex and 
fall back to generic code when there is contention (just like we already 
do for semaphores).


Nicolas
