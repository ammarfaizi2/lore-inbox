Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268802AbUJPTtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268802AbUJPTtb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268836AbUJPTlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:41:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21960 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268803AbUJPTjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:39:06 -0400
Date: Fri, 8 Oct 2004 16:19:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH/RFC: usbcore wakeup updates (3/4)
Message-ID: <20041008141953.GA2547@openzaurus.ucw.cz>
References: <200410041407.47500.david-b@pacbell.net> <200410070835.53261.david-b@pacbell.net> <20041007211921.GE1447@elf.ucw.cz> <200410071758.48625.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410071758.48625.david-b@pacbell.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Though I don't see anything obviously broken about
> (for example) using sysfs to force some devices into
> PCI_D3hot state ... or with maintaining compatibility
> with today's PCI API, which talks in terms of power state.

Nothing is wrong with user telling us to go to specific state. But it is about the
only case where explicit PCI state is neccessary (AFAICS).

>  - The sysfs code needs to handle suspending a _tree_ not
>    just a single device ... it'll have children if the device is a
>    bus adapter (HCD), bridge (hub), or just the floor of a stack
>    of virtualized drivers (usb-storage hotplugging SCSI hosts and
>    disks on the fly, network adapters, etc).  This needs to do
>    bottom-up-suspend and top-down-resume -- but it doesn't.
>    (And USB has some workarounds, but they may need to cross
>    from USB into other driver stacks ...)

I believe nigel has patches...

>  - Semantics of _(IDENTIFIER).  I think those need to include
>    driver-specific values, and that means ripping out code that
>    "knows" otherwise.  That includes in PMcore code.  And
>    what makes most sense to me there involves two different
>    sets of state identifiers, identified as meaningful strings not
>    cryptic digits:  (a) a handful of generic states like "idle",
>    "lowpower", "on", and "off", plus (b) device-specific states
>    that might borrow from the bus (PCI_D1, PCI_D3hot, etc)
>    but which can be customized to match the hardware.

I do not think that having both generic and specific states at same interface is
nice... Perhaps we could make it exclusive? If generic state "ON" is same as "PCI_D0",
just forget about "PCI_D0" and always use "ON"...
But these are small details.

> > I'm not sure we want to move to anything complicated than simple enum.
> 
> I'm pretty sure we should.  If for no other reason than to force
> all the drivers to change.  They disagree about what _IDENTIFIER
> means because enums are basically un-typechecked integers,
> and that's unlikely to change.

Well, I am not sure we want "flag day" for drivers.
If we introduce enums than kill all the sparse warnings, we can
get there, too...

> But also, since a typed struct pointer can support lots of other
> policy structures, including things analagous to "cpufreq"
> governors.  A set of drivers can agree (maybe because they
> share the same bus, or are otherwise related) that the
> pointer gets container_of() treatment to morph to something
> packaginging much more interesting power policies than a
> simple PCI bus needs.  Like for example suspending four
> devices, on different busses, together -- or not at all.  Or
> understanding that when these devices all suspend, one
> of the power supplies (or clocks) can be disabled.

I don't see how this could work. Who would call the governors?
Core? Driver? How would you associate drivers with governors?

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

