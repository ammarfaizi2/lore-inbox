Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWENX4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWENX4b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 19:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWENX4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 19:56:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:50609 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751413AbWENX4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 19:56:31 -0400
Subject: Re: [linux-pm] Re: [PATCH/rfc] schedule /sys/device/.../power for
	removal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200605141048.08424.david-b@pacbell.net>
References: <20060512100544.GA29010@elf.ucw.cz>
	 <200605120652.55658.david-b@pacbell.net>
	 <1147566116.21291.25.camel@localhost.localdomain>
	 <200605141048.08424.david-b@pacbell.net>
Content-Type: text/plain
Date: Mon, 15 May 2006 09:56:15 +1000
Message-Id: <1147650975.21291.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My disagreement is with the assumption that none of those states
> will ever map directly to bus states.  (For those busses which define
> them; not all do, but PCI does.)  Or perhaps with the assumption
> that the driver must not name its states after the bus states they
> use, even in common scenarios without one-to-many confusions.

I'm not saying hey won't map on bus states ever... I'm saying they
sometimes will or not, it's not a 1:1 relationchip, thus they are not
_directly_ related. This is why there is the whole issue of describing
the power state dependency that I talked about later in my mail.

> Well certainly if the device doesn't implement PCI_D1 in hardware, then
> that name shouldn't be used for a driver state.  But if it has only one
> driver state that uses PCI_D2, why rule out calling that state PCI_D2?

Because "PCI_D2" Means nothing from a device function point of view
imho. "Clock stopped" would make much more sense (provided it's what the
device does when in D2 mode, there is a definitive lack of consistency
three as D states have never been properly defined except for D3 cold :)

> Lots of PCI drivers don't even try to subdivide the PCI states, so every
> driver state directly corresponds to one PCI state.

Which is mostly bogus, and probably due to driver writers not even
bothering looking at what the device is actually doing when put into a
given Dx state... I suppose a lot of dumb devices also only really
handle D0 and some kind of Dx (where X can be 1...3 and that are about
equivalent).

> The PCI state semantics are well enough defined

No they are not. Historically, they were pretty much undefined.
Recently, Intel/PCISIG updated the PCI PM specification (that I suspect
pretty much no device vendor read) that provides _some_ clues as to what
states might actually mean, mostly that their semantic is essentially
specific to a given class (which is as good as being undefined as far as
the generic code is concerned). The only "sure" thing is that D0 is full
on and D3 is the max power management... In addition, there is this
optional mecanism for a device to report it's power consumption in the
various states, but that's pretty much it.

The only thing that has (finally) been properly defined are the bus
states (B0...B3).

Thus I still think that the PCI D state is an implementation detail to
be known by the driver only and doesn't have anything to do with a user
interface.

> , but as I recall you want
> device-specific details going beyond what the spec covers.  That is a
> rather different issue.

No, I want some reasonably defined semantics.

> > However, it's whatever 
> > functional states that device/driver supports that shall be exposed.
> > Those can be "idle" and "suspended" for example, or there could be
> > several levels of "suspended".
> 
> And it would be less confusing to name those "suspended" levels with
> names that make sense on multiple levels, like "PCI_D2" etc, than to
> needlessly proliferate other names for those states.

I disagree there....

> > Now of course, there is the problem that while such descriptive names
> > might have a sense to a user (and even then, only in one language,
> > english) they aren't very useful to some automated power management
> > mecanism.
> 
> Depends on the mechanism, surely.  And "PCI_D2" is already in that
> language-neutral "doesn't get translation" category anyway.  Regardless,
> userspace tools should just compare tokens.

etc...

> > That's the whole problem that needs solving, possibly by exposing as
> > much as the state dependencies as possible, along eventually with
> > informations such as can the device automatically trigger a transition
> > out of this state, eventually informations relative to max power
> > consumed in this state 
> 
> I consider all those issues orthogonal to the issues addressed by
> the /sys/devices/.../power/state files:  (a) reporting the power
> state the driver is currently maintaining, and (b) changing that
> to another state supported by that driver.

And handling the dependencies...

Ben.


