Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWDXVHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWDXVHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWDXVHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:07:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751256AbWDXVHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:07:21 -0400
Date: Mon, 24 Apr 2006 14:07:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Alan Cox <alan@redhat.com>, Stephen Hemminger <shemminger@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <1145911417.3116.69.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain> 
 <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>  <Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
  <1145908402.3116.63.camel@laptopd505.fenrus.org> 
 <20060424201646.GA23517@devserv.devel.redhat.com> <1145911417.3116.69.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, Arjan van de Ven wrote:
> 
> well... the corner case (as rmk described) is full starvation; even
> polling once per second is better than not polling at tall there.,..

I can confirm that even just polling once a second - or even less often - 
is a huge improvement.

A long time ago, I had a machine with a 3c509 card that would sometimes 
miss receive interrupts for some reason (it may actually have been a bug 
in the disable_irq/enable_irq thing on SMP, I forget - this is at least 
five years ago). 

The 3c509 driver had some five-second timeout thing, which meant that it 
would end up polling itself every five seconds regardless, and it made the 
difference between a machine that was totally undebuggable over a network, 
and one that actually worked surprisingly well (ie you could ssh into it, 
and things would work, but have these long pauses every once in a while, 
with burst of data).

Of course, the machine would have been totally useless for real work, but 
it made it _much_ easier to see what was going on when things went south.

So "limping along" when things don't work can be a huge time-saver from a 
debugging standpoint. So even if it's just that every registered SA_SHIRQ 
would get a heartbeat at least once every five seconds (and we'd limit it 
to SA_SHIRQ exactly because a driver that doesn't have that set may get 
confused if it gets extra interrupts), that might sound totally useless, 
but it might actually help somebody who otherwise might just make a pretty
useless "the machine hung" bug-report.

The fake interrupt could even print out a warning if somebody returns 
SA_HANDLED (since normally there _shouldn't_ have been any work to handle 
for it), and if that means that for somebody, things go from "the machine 
hung" to "the machine got very slow, and printed out 'fake interrupt for 
ide0 returned SA_HANDLED!'", that would potentially be a big debug aid.

We've had our ass saved quite a few times now by the irq storm detector 
("irq X: nobody cared" and friends), which has helped debug irqs that 
haven't been set up properly, that I'm convinced things like this might 
well make a huge deal.

Of course, "things like this" does not necessarily cover the above 
schenario. Maybe that is totally useless ;)

		Linus
