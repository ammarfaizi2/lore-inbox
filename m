Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRADVkb>; Thu, 4 Jan 2001 16:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRADVkV>; Thu, 4 Jan 2001 16:40:21 -0500
Received: from nrg.org ([216.101.165.106]:21028 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129370AbRADVkE>;
	Thu, 4 Jan 2001 16:40:04 -0500
Date: Thu, 4 Jan 2001 13:39:57 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Andi Kleen <ak@suse.de>
cc: Daniel Phillips <phillips@innominate.de>,
        ludovic fernandez <ludovic.fernandez@sun.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <20010104091118.A18973@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.05.10101041329410.4778-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Andi Kleen wrote:
> On Thu, Jan 04, 2001 at 08:35:02AM +0100, Daniel Phillips wrote:
> > A more ambitious way to proceed is to change spinlocks so they can sleep
> > (not in interrupts of course).  There would not be any extra overhead
> 
> Imagine what happens when a non sleeping spinlock in a interrupt waits 
> for a "sleeping spinlock" somewhere else...
> I'm not sure if this is a good idea. Sleeping locks everywhere would
> imply scheduled interrupts, which are nasty. 

Yes, you have to make sure that you never call a sleeping lock
while holding a spinlock.  And you can't call a sleeping lock from
interrupt handlers in the current model.  But this is easy to avoid.

> I think a better way to proceed would be to make semaphores a bit more 
> intelligent and turn them into something like adaptive spinlocks and use
> them more where appropiate (currently using semaphores usually causes
> lots of context switches where some could probably be avoided). Problem
> is that for some cases like your producer-consumer pattern (which has been
> used previously in unreleased kernel code BTW) it would be a pessimization
> to spin, so such adaptive locks would probably need a different name.

Experience has shown that adaptive spinlocks are not worth the extra
overhead (if you mean the type that spin for a short time
and then decide to sleep).  It is better to use spin_lock_irqsave()
(which, by definition, disables kernel preemption without the need
to set a no-preempt flag) to protect regions where the lock is held
for a maximum of around 100us, and to use a sleeping mutex lock for
longer regions.  This is what I'm working towards.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
