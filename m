Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWENRsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWENRsN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 13:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWENRsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 13:48:12 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:27224 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750947AbWENRsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 13:48:12 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-pm] Re: [PATCH/rfc] schedule /sys/device/.../power for removal
Date: Sun, 14 May 2006 10:48:05 -0700
User-Agent: KMail/1.7.1
Cc: linux-pm@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20060512100544.GA29010@elf.ucw.cz> <200605120652.55658.david-b@pacbell.net> <1147566116.21291.25.camel@localhost.localdomain>
In-Reply-To: <1147566116.21291.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605141048.08424.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 May 2006 5:21 pm, Benjamin Herrenschmidt wrote:
> 
> > I think both Patrick Mochel and Alan Stern have sent patches at
> > various times to let individual drivers provide a list of named
> > states they support,  In some cases (like PCI) those lists could
> > be delegated to bus-specific code.
> 
> I've several times expressed my opinion there that it's not bus states
> that should be exposed by a driver but the actual states that the
> driver/device combination supports _regardless_ of what bus state they
> map to (if any). Bus states simply mean nothing at this point (Unless
> you are the bus driver).

I mostly agree ... you can have a pm-stupid driver for a given device,
or a very smart one, and they might need to expose different PM models
through any /sys/devices/.../power/state type files.

My disagreement is with the assumption that none of those states
will ever map directly to bus states.  (For those busses which define
them; not all do, but PCI does.)  Or perhaps with the assumption
that the driver must not name its states after the bus states they
use, even in common scenarios without one-to-many confusions.


> Of course we need both top-down and bottom-up 
> dependency mecanisms to handle state changes, but at the user level, a
> given PCI driver shouldn't expose something like "D1", "D2" and "D3"...
> those are PCI states that don't have a well defined semantics (and may
> not be all supported by the device/driver). 

Well certainly if the device doesn't implement PCI_D1 in hardware, then
that name shouldn't be used for a driver state.  But if it has only one
driver state that uses PCI_D2, why rule out calling that state PCI_D2?
Lots of PCI drivers don't even try to subdivide the PCI states, so every
driver state directly corresponds to one PCI state.

The PCI state semantics are well enough defined, but as I recall you want
device-specific details going beyond what the spec covers.  That is a
rather different issue.


> However, it's whatever 
> functional states that device/driver supports that shall be exposed.
> Those can be "idle" and "suspended" for example, or there could be
> several levels of "suspended".

And it would be less confusing to name those "suspended" levels with
names that make sense on multiple levels, like "PCI_D2" etc, than to
needlessly proliferate other names for those states.


> Now of course, there is the problem that while such descriptive names
> might have a sense to a user (and even then, only in one language,
> english) they aren't very useful to some automated power management
> mecanism.

Depends on the mechanism, surely.  And "PCI_D2" is already in that
language-neutral "doesn't get translation" category anyway.  Regardless,
userspace tools should just compare tokens.

 
> That's the whole problem that needs solving, possibly by exposing as
> much as the state dependencies as possible, along eventually with
> informations such as can the device automatically trigger a transition
> out of this state, eventually informations relative to max power
> consumed in this state 

I consider all those issues orthogonal to the issues addressed by
the /sys/devices/.../power/state files:  (a) reporting the power
state the driver is currently maintaining, and (b) changing that
to another state supported by that driver.

- Dave
