Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUHJU2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUHJU2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267711AbUHJU2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:28:55 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:3231 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267709AbUHJU20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:28:26 -0400
From: David Brownell <david-b@pacbell.net>
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] Fix Device Power Management States
Date: Tue, 10 Aug 2004 12:18:25 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, "" <benh@kernel.crashing.org>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408101218.25752.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, some of these proposals seem to relate to stuff OTHER than the
device power management states.  While I suspect it might be a very
handy thing to add methods to quiesce drivers (drivers have to have
that anyway) the semantics need to be properly nailed down.


On Monday 09 August 2004 3:43 am, Patrick Mochel wrote:

> The 2nd argument to ->pm_save() and ->pm_power() is determined by mapping
> an enumerated system power state to a static array of 'struct pm_state'
> pointers, that is in dev->power.pm_system. The pointers in that array
> point to entries in dev->power.pm_supports, which is an array of all the
> device power states that device supports. Please see include/linux/pm.h in
> the patch below. These arrays should be initialized by the bus, though
> they can be fixed up by the individual drivers, should they have a
> different set of states they support, or given user policy.

This sounds exactly like what I suggested a week or two ago... though
in the context of suspend/resume calls.  I don't remember whether I
mentioned the notion of having "new style" suspend calls with those
parameters, and having the glue code smart enough to call "old style"
ones, but I think Pavel mentioned that in this thread.  API migration is
a significant issue ... unless this is planning for a temporary 2.7 fork?  :)


> The actual value of the 'struct pm_state' instances is driver-specific,
> though again, the bus drivers should provide the set of power states valid
> for that bus. For example:
> 
> 
> struct pm_state {
>         char    * name;
>         u32     state;
> };

Even the same struct.  But the point of the "u32" would be for
bus-specific information, and I'd expected that these would
be used with suspend states specific to busses, devices,
and maybe even drivers.   I might even agree that the u32
shouldn't be included (it's certainly error prone).

And as a definitional thing:  two states are equal iff they are
the same pointer, NOT if the string names are the same.

So instead of:
 
> #define decl_state(n, s) \
>         struct pm_state pm_state_##n = {        \
>                 .name   = __stringify(n),       \
>                 .state  = s,                    \
>         }

Defining a macro for something this simple is overkill...

> drivers/pci/ should do:
> 
> decl_state(d0, PCI_PM_CAP_PME_D0);
> EXPORT_SYMBOL(pm_state_d0);
> 
> ...

While that might actually work OK for PCI, since it's only
got four power states (D3hot != D3cold), a single u32
is NOT enough to provide additional device power state
Instead there could be:

struct mybus_pm_state {
	struct pm_state	standard
	... custom PM state associated with it
};

  
> 
> This provides a meaningful tag to each state that is completely local to
> the bus, but can be handled easily by the core.

The core should only be passing these around, not even looking at
the tags.  The "system suspend" logic would know about a handful
of standard states ... architecture, board, bus, and driver-specific
code should be able to map those (along the lines Pavel suggested).


> To handle runtime power management, a set of sysfs files will be created,
> inclding 'current' and 'supports'. The latter will display all the
> possible states the device supports, as specified its ->power.pm_supports
> array, in an attractive string format. 'current' will display the current
> power state, as an ASCII string. Writing to this file will look up the
> state requested in ->pm_supports, and if found, translate that into the
> device-specific power state and suspend the device.

I like that idea.  Though I also catch myself wanting to distinguish
two different notions of "current":  (a)  current policy applied to
the device from external sources, not unlike the cpufreq governor;
(b) current state produced by that policy.

So for example a power-aware driver might have a default governor
that enters and exit low power states based on usage patterns ... but
if some external policy were applied -- maybe like STR -- it would no
longer be OK to exit the low power state automatically. Unless some
wakeup events were enabled, and hmm that's not yet part of the
device PM framework either ... :)

- Dave
