Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269155AbUJKQTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269155AbUJKQTC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUJKQQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:16:49 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:58081 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S269043AbUJKQPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:15:21 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Totally broken PCI PM calls
Date: Mon, 11 Oct 2004 09:15:33 -0700
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Paul Mackerras <paulus@samba.org>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410102126220.3897@ppc970.osdl.org> <1097470524.3249.34.camel@gaston>
In-Reply-To: <1097470524.3249.34.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410110915.33331.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 October 2004 9:55 pm, Benjamin Herrenschmidt wrote:
> 
> Well... it doesn't work on paul's laptop, but anyway, ok, let's go for
> the struct thing and forget about this for 2.6.9.

PM hasn't worked for me on 2.6 with most hardware, about since
the "new PMcore" kicked in, so it's hard for me to judge progress
except at the level of unit tests.  Where I see two steps forward,
one step back ... on a good day.

The root cause of many of these problem is that there's
a confusion between system-wide sleep states and the
device-specific power states from which they're built.
They _should_ be using two distinct data types.  Not one
integer/enum type ... especially not one int/enum type
that's got multiple conflicting "legacy" interpretations!

Something else to remember:  the design center should
be (or at least include!) "partially suspended" systems,
where most hardware is in a low power mode unless it's
needed.  That's not something the current PM framework
does well; it gets confused on system suspend later on,
if it finds devices it didnt' suspend.


> Now paul and I are trying to figure out what to put in that struct and
> what kind of information actually make any sense. It's not trivial. We
> have to deal with several things.

In USB-land, we've identified a need for a state name.  Each different
bus can have different states, and device-specific power states are
also common.  Sysfs should show those device-specific states.

Doesn't seem like anything else is needed ... so long as the power
management interactions get (re)factored sanely!  However, each
bus or device could use container_of() to access any additional state
information ... including linkage to other hardware, or for PCI the
actual number of the state.


> We have the system state (cause of the request if you prefer),

The system state shouldn't matter to a device-specific suspend
routine ... AT ALL.

I like the model that what gets passed to drivers is more of a
local policy update than anything else.  Within the bounds of
that policy, the driver can pick many device power states.
When the system is going to power itself off, it can pass a
device power policy that's rather inflexible.


> that is 
> "idle" (we mostly don't implement that one yet but it's useful to make
> "room" for it, handhelds wants that badly),

In USB-land, we've been discussing "idle" as something orthogonal
to the PM states.  Not clear on all the details yet, but I'd vote against
anything that tries to make "driver doing nothing" a power state,
or doesn't have a way to idle drivers.

Drivers can be "idle" without entering low power states, and can
use wakeup events to enter/exit low power states without being
fully idle. (Hardware allowing.)  That's an example of a policy that
drivers should be able to choose without affecting PMcore.

I've sent separate posts about how to add wakeup support to the
PM framework ... that omission should have been a great big
red (or is it chartreuse?) warning flag that the PM framework was
lacking some very basic functionality.


> "suspend to ram" and  "suspend to disk".

Those aren't device power states at all!!  They're system sleep
states (or transitions).   And by the way, "suspend to disk" is
an odd model for systems without disks, or swap ... which oddly
enough tend to be ones that really need good PM, and which
(like HH.org) need the "partially suspended" system model
to work well.


> But what about user /sysfs originated requests ? (that is random numbers
> the user whacks in /sys/devices/...../power) what are their semantics ?

Sysfs should only read/write the names of the states that particular
device can support.  Plus probably some generic requests for policies
that the sleep framework would hand to individual drivers.


> Also, do we carry around a "suggested" D state for what it means ? it's
> really an obscure PCI concept. However, as you can see with the hacks
> in drivers like radeonfb, ....

I can't think of PCI D-states as obscure, they're the core of its PM support.
PCI drivers need to use them to implement power policies.

Without looking at that code, I'll just say that while many PCI drivers
can probably offload the decision making to some PCI core code
("use D1 or D2 when idle if available; D3hot otherwise"), not all
can do that. 
 

> > The more the merrier. Care to come up with a solution of your own?
> > 
> > And no, I'm not interested in the type "let's fix one driver" kind of 
> > thing. That's what we've had for the last year or more, and the fact is, 
> > my laptop _never_ suspended during that time. So I really think it needs a 
> > _proper_ solution.
> 
> Agreed.

Right, and let's not make something that only works for PC-class hardware
or only for system-wide suspend operations ...

- Dave


