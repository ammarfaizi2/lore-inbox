Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264586AbUE0Omn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUE0Omn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbUE0Omn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:42:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12167
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264586AbUE0Oml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:42:41 -0400
Date: Thu, 27 May 2004 16:42:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527144237.GD3889@dualathlon.random>
References: <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040527124551.GA12194@elte.hu> <20040527135930.GC3889@dualathlon.random> <20040527140322.GA11966@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527140322.GA11966@devserv.devel.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 04:03:22PM +0200, Arjan van de Ven wrote:
> In theory you are absolutely right, problem is the current macro..... it's
> SO much easier to have one stacksize everywhere (and cheaper too) for
> this... (and it hasn't been a problem so far, esp since the softirq's have

I see the problem, but then why don't we wait to implement it right, to
allow 8k irq-stacks before merging into mainline?

grep for "~s 4k" (i.e. the word "4[kK]" in the subject) on l-k and
you'll see there's more than just nvidia. one user reported not being
able to boot at all with 4k stacks since 2.6.6 doesn't have a stack
overflow in the oops, so I hope he tested w/ and w/o 4KSTACKS option
enabled to be able to claim what broke his machine is the 4KSTACKS
option. (his oops doesn't reveal a stack overflow, the thread_info is at
0xf000 and the esp is at 0xffxx)

Making it a config option, is a sort of proof that you agree it can
break something, or you wouldn't make it a config option in the first
place. What's the point of making it a configuration option if it cannot
break anything and if it's not risky? Making it a config option is not
good, because then some developer may develop leaving 4KSTACKS disabled,
and then his kernel code might break on the users with 4KSTACKS enabled
(it's not much different from PREEMPT).  Amittedly code that overflows
4k is likely to be not legitimate but not all code is good (the most
common error is to allocate big strutures locally on the stack with
local vars), and if developers are able to notice the overflow on their
own testing it's better.

Clearly it's more relaxed to merge something knowing with a config
option you can choose if to use 4k or 8k stacks, but I'm not sure if
it's the right thing to do for the long term. If we go 4k stacks, then
I'd prefer that you drop the 4KSTACKS option and force people to reduce
the stack usage in their code, and secondly that we fixup the irqstack
to be 8k.

Plus the allocation errors you had, could be just 2.6 vm issues with
order > 0 allocations, we never had issues with 8k stacks in 2.4, so
using the 4k stacks may just hide the real problem. archs like x86-64
have to use order > 0 allocations for kernel stack, no way around it, so
order > 0 must work reliably regardless of whatever code we change in
x86.

> On x86_64 you have the PDA for current so that's not a problem, and
> you can do the bigger stacks easily but for x86 you don't...

yep.
