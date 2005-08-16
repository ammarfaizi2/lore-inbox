Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbVHPF7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVHPF7p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVHPF7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:59:45 -0400
Received: from kent.litech.org ([72.9.242.215]:30476 "EHLO kent.litech.org")
	by vger.kernel.org with ESMTP id S965121AbVHPF7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:59:44 -0400
Date: Tue, 16 Aug 2005 01:59:40 -0400
From: Nathan Lutchansky <lutchann@litech.org>
To: Michael E Brown <Michael_E_Brown@dell.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Douglas_Warzecha@Dell.com, Matt_Domsch@Dell.com
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050816055940.GJ24959@litech.org>
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com> <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com> <1124161828.10755.87.camel@soltek.michaels-house.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124161828.10755.87.camel@soltek.michaels-house.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 10:10:28PM -0500, Michael E Brown wrote:
> On Mon, 2005-08-15 at 21:29 -0400, Kyle Moffett wrote:
> > On Aug 15, 2005, at 18:58:56, Michael_E_Brown@Dell.com wrote:
> > >> Why can't you just implement the system management actions in
> > >> the kernel driver?  This is tantamount to a binary SMI hook to
> > >> userspace.  What functionality does this provide on a dell
> > >> system from an administrator's point of view?
> > 
> > >     The second alternative is not entirely feasible. We have over 60
> > > SMI functions, and we would have to write a kernel-mode wrapper for
> > > each and every one. I hope you agree that code that doesn't exist is
> > > less buggy than code that is, and that code that is in userspace is a
> > > whole lot less likely to cause a kernel crash than code that is in
> > > the kernel.

Where is this list of SMI functions?  I looked through your library
documentation and it wasn't clear.  Is this it?

http://linux.dell.com/libsmbios/main/namespacesmbios.html#a156a6

> > I think the second alternative is actually feasible and preferable. The
> > point of the kernel is to provide safe and secure access to two things:
> >    1) Hardware through an abstraction layer
> >    2) Software services (like IP stack) that are not feasible to do in
> >       userspace.
[...]
> Sorry, but I think you mis-understand the whole point behind this
> driver. This _is_ an abstraction.

Not really.  You've just created a little interface so you can diddle
hardware directly from userspace.  That's about as far from a proper
abstraction as you can get.

There appears to be no validation of any of the data that your library
attempts to poke into the hardware.  Is it possible to crash or
irrepairably confuse the hardware from userspace using this interface?
If so, you're circumventing one of the basic functions of the
kernel/application separation.

> In our case, we have a whole bunch of unrelated SMI calls to the BIOS
> that have absolutely nothing in common except that they use the SMI
> calling method. We have abstracted down to the lowest common denominator
> of what we can put into the kernel to enable our whole managment stack.

Being that Linux isn't a microkernel, that's not the way we go about
things.  If we were trying to move as much as possible to userspace,
every USB driver would be implemented as a library talking to usbfs, and
ACPI tables would be interpreted by a little app run at boot.

Your interface between userspace and the kernel needs to expose to
userspace only the functionality it provides while hiding the details of
actually twiddling the hardware.  Preferably, the sysfs files you need
can be structured so that the same type of management interface can be
implemented by other vendors and it will look roughly the same to
userspace.  (Creating standard interfaces to similar but different
hardware is what sysfs is all about.)

> To take a concrete example, I suggested to Doug to mention fan status. I
> get the feeling that you possibly think that this would be better
> integrated into lmsensors, or something like that. That really isn't the
> case, as lmsensors is really geared towards bit-banging lm81 (for
> example) chips to get fan status. In our case, we have a standardized
> BIOS interface to get this info, and that standardized method involves
> SMI and not bit-banging interfaces. Once this driver is accepted into
> the kernel, we can go and add support in the _userspace_ lmsensors libs
> to poll fan and temp using this driver.

Actually, that's what the new hwmon class is for.  Your kernel driver
should provide access to the (raw) fan status values through hwmon
files, and the lm_sensors library will read it from there just like
every other fan sensor device.

If the hwmon class doesn't provide the functionality you need for this,
bring it up for discussion here, rather than going off and inventing
your own proprietary interface.

> What you are asking us to do is just not feasible on many levels. First,
> just from the number of functions we would have to implement. We would
> have to implement about 60 new sysfs files, with at least 120 separate
> functions for read/write.

   lutchann@faboo ~ $ find /sys -type f | wc -l
   1561
   lutchann@faboo ~ $

Adding 60 more files isn't going to horribly bloat sysfs, and your
implementation cost is probably lower than adding functions to your
library.

> Each function would have to take into account
> the specific calling requirements of that specific function. Then, we
> would have to implement all of the bugfixes and platform-specific
> workarounds in the kernel for each of those functions for each Dell
> platform.

That's kind of the point of sysfs--exposing system and hardware knobs
and gauges in a safe manner.  Again, if you're not able to validate what
userspace gives you before stuffing it into the hardware, you need to
rethink your interface.

> Each time another function is added to BIOS, we would have to
> go out and patch everybody's kernel to support the new function.

How is this different from requiring everyone to download a new version
of your library?

> there just isn't
> the manpower to maintain all of these in the kernel along with the
> requisite testing for each update,

I suspect that saying, "I don't have time to do this properly so please
merge this anyway" is not a very good way to get your patch accepted.

> not to mention the lag between when
> we have to submit something and when it would show up in a vendor
> kernel.

Maybe this could be helped by working more closely with vendors to get
your changes integrated into their kernel packages?

> > >  We are trying to keep our kernel bloat down. We don't really think  
> > > that
> > > customers of IBM or HP really want their Red Hat kernels loaded  
> > > down with
> > > a bunch of Dell-only code.
> > 
> > That's what kconfig is for.  My G4 Powerbook doesn't have support for
> > hardware found in my G4 desktop any more than an IBM box should be  
> > forced
> > to have support for Dell hardware, yet all platforms work fine from the
> > same kernel tree.
> 
> Vendor kernels? Red Hat and SuSE (to pick two) ship, basically, one i386
> kernel (granted, with UP/SMP/bigmem flavors), and we would like to make
> it easy for them to enable this by default.

That's why we have modules.  Red Hat and SuSE ship support for a lot
more network cards, for example, than most people own, but that doesn't
mean they're all compiled into the kernel all the time.

I really like what you're trying to do here, but please rethink your
kernel API.  It makes much more sense to have a standard interface for
providing system management functions than for each vendor to create
their own proprietary libraries.  -Nathan
