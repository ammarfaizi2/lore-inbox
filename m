Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbVLVVkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbVLVVkB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbVLVVkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:40:01 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:7076 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030306AbVLVVkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:40:00 -0500
Date: Thu, 22 Dec 2005 22:39:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/10] mutex subsystem, -V5
Message-ID: <20051222213902.GA32433@elte.hu>
References: <20051222153717.GA6090@elte.hu> <Pine.LNX.4.64.0512221134150.26663@localhost.localdomain> <Pine.LNX.4.64.0512220941320.4827@g5.osdl.org> <Pine.LNX.4.62.0512221003540.7992@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512221003540.7992@schroedinger.engr.sgi.com>
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


* Christoph Lameter <clameter@engr.sgi.com> wrote:

> Large NUMA systems with lots of lock contention benefit if the one 
> trying to lock backs off for awhile. This is first of all a 
> modification of the contention path. However, one could also want to 
> locally block multiple lock attempts coming from the same node in 
> order to reduce contention on the NUMA interlink. See also my HBO 
> proposal 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111696945030791&w=2
> 
> I would like some more flexible way of dealing with locks in general. 
> The code for the MUTEXes seems to lock us into a specific way of 
> realizing locks again.

yeah, but we should be careful where to put it: the perfect place for 
most of these features and experiments is in the _generic_ code, not in 
arch-level code! Look at how we are doing it with spinlocks. It used to 
be a nightmare that every arch had to implement preempt support, or 
spinlock debugging support, and they ended up not implementing these 
features at all, or only doing it partially.

i definitely do not say that _everything_ should be generalized. That 
would be micromanaging things. But i definitely think there's an 
unhealthy amount of _under_ generalization in current Linux 
architectures, and i dont want the mutex subsystem to fall into that 
trap.

also, lets face it, even most of the lowlevel details do have some 
generic trends in them. And that's not an accident: it's because 
everything is controlled by the laws of physics, which tend to be pretty 
generic and work the same way, no matter which CPU architecture we are 
on. Yes, there can be oddball architectures, but all in one there's a 
good reason why we are able to have 90% of the kernel in generic code.

even lowlevel things such as mutexes can be described generally. We need 
roughly 3 states to implement them. We need ops to transit from one 
state to another, and to figure out whether that transition succeeded.  
Now there are CPUs where we can do almost arbitrary math operations 
cheaply, and can test for sign and zero. For those CPUs the decision is 
easy: we use the best math, which results in the best code. For other 
CPUs we might have to use lesser state transitions, with more 
side-effects. Certainly an architecture should have a say in determining 
which transitions are the best ones, but the generic code wants to be 
able to control the _state_ of the mutex.

What if we want to have a fourth state? [i dont think we want one, but 
it could happen] What would you prefer - if there were clear rules about 
what the arch level ops do, or if an architecture defined its rules in 
assembly, basically hardcoding it and making it impossible to change 
without changing the assembly? I went for ops that are generic and 
describe the math, not the implementation.

and look at the end result: we have a 400 lines of mutex.c (half of 
which is comments) that covers 100% of the architectures, in almost the 
most optimal way. [with only a few openings left that could reduce an 8 
instruction fastpath to a 6 instruction fastpath.] Lets not give that up 
and make it once again a hard to change thing.

	Ingo
