Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbVHPV3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbVHPV3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVHPV3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:29:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:38634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932735AbVHPV3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:29:12 -0400
Date: Tue, 16 Aug 2005 13:37:06 -0700
From: Greg KH <greg@kroah.com>
To: Michael E Brown <Michael_E_Brown@dell.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Douglas_Warzecha@dell.com, Matt_Domsch@dell.com
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050816203706.GA27198@kroah.com>
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com> <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com> <1124161828.10755.87.camel@soltek.michaels-house.net> <20050816081622.GA22625@kroah.com> <1124199265.10755.310.camel@soltek.michaels-house.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124199265.10755.310.camel@soltek.michaels-house.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 08:34:24AM -0500, Michael E Brown wrote:
> On Tue, 2005-08-16 at 01:16 -0700, Greg KH wrote:
> > On Mon, Aug 15, 2005 at 10:10:28PM -0500, Michael E Brown wrote:
> > > To take a concrete example, I suggested to Doug to mention fan status. I
> > > get the feeling that you possibly think that this would be better
> > > integrated into lmsensors, or something like that.
> > 
> > Yes it should.  That way you get the benifit of all userspace
> > applications that already use the lmsensors library without having to be
> > rewritten in order to support your new library.
> 
> Little did I know when I first mentioned it how big of a mistake it
> would be to mention the sensor functions. *sigh*
> 
> The dcdbas driver allows access to all of the Dell SMIs. Sensors are
> only one instance of SMI code (only two functions, in fact, if I am
> reading this spec correctly). The other (roughly) 58 functions have
> nothing to do with sensors. The presence of the dcdbas driver would not
> stop anybody from writing another driver to provide a hwmon interface to
> just the sensors pieces. 

Great, I await your /drivers/hwmon driver submission :)

> This isn't like a PCI device where there can be only one driver.

Oh, like fbdev and drm liking to control the same exact pci device?
Don't use pci as a good example of one driver per device...

> > > That really isn't the case, as lmsensors is really geared towards
> > > bit-banging lm81 (for example) chips to get fan status.
> > 
> > Not true at all.  It is geared toward providing a common userspace
> > interface for all sensor information in the system.  Now if it provides
> > this in a good and easy to use way is another story...
> > 
> > But anyway, there is a standard way to export fan speed and temperature
> > information from the kernel, the hwmon interface (see -mm for examples
> > and documentation, and the i2c stuff in mainline today.)
> 
> I don't really know a bunch about lmsensors. I just downloaded it and
> started poking around. I would have thought, though, that they would
> provide an easy way to provide a userspace library method of extending
> for new sensors. I suppose I was wrong here as I don't see such
> functionality on first glance.

It's there, just ignore all the 2.4 kernel code in their tree.  They
even provide a lot of documentation on how to do this.

> > > In our case, we have a standardized BIOS interface to get this info,
> > > and that standardized method involves SMI and not bit-banging
> > > interfaces. Once this driver is accepted into the kernel, we can go
> > > and add support in the _userspace_ lmsensors libs to poll fan and temp
> > > using this driver.
> > 
> > No, export this data properly through sysfs like all other temperature
> > and sensor data is.  Don't create a new one, no matter how much you
> > would like to keep from changing kernel code in the future for new
> > hardware.
> 
> This driver is not trying to create a new way to do sensor and monitor
> data. This just happens to be a side effect of the main use case.

But it's probably a main use case for a lot of users daily experience,
right?

> > > For example, we already have at least one buggy implementation of this
> > > exact stack in the kernel as the i8k driver. The i8k driver was reverse-
> > > engineered and works, but it does not follow the spec at all, and so is
> > > subject to major breakage if the BIOS changes. With dcdbase + libsmbios,
> > > we can write this _correctly_, and in such a way that it follows the
> > > spec and will not break on BIOS updates.
> > 
> > No, fix the i8k driver as you have access to the specs.  It was there
> > first.
> 
> Ok.

On second thought, after looking at that code, forget it, just do
something new with the proper hwmon interface instead.

> > > What you are asking us to do is just not feasible on many levels. First,
> > > just from the number of functions we would have to implement. We would
> > > have to implement about 60 new sysfs files, with at least 120 separate
> > > functions for read/write.
> > 
> > No problem at all, we can create that with only 2 read/write functions.
> > See the i2c code for details.
> 
> file/line#? I did a quick search and didn't see anything special.

the lm90.c driver as an example.  Look at the usage of
SENSOR_DEVICE_ATTR().

> My main point here is that each SMI call would require it's own kernel-
> space parsing of parameter and return values, as each call has different
> argument passing requirements.

Yes, no objection there.  Just like every other kernel driver.

> > > Each function would have to take into account the specific calling
> > > requirements of that specific function.
> > 
> > Again, no different from any other sensor driver.
> 
> Again, this driver is not a sensor driver. 

You provide sensor data, hence...

> > > Then, we would have to implement all of the bugfixes and
> > > platform-specific workarounds in the kernel for each of those
> > > functions for each Dell platform.
> > 
> > Yup.
> > 
> > > Each time another function is added to BIOS, we would have to go out
> > > and patch everybody's kernel to support the new function.
> > 
> > Yup.  I suggest you complain to the bios people about this horrible way
> > to design hardware then :)
> 
> You have a smiley there, but you know very well that even the most well-
> intentioned BIOS folk make errors in design or implementation from time
> to time. Once it is in BIOS, there really isn't much choice but try to
> work around it. 

I agree, the majority of issues with drivers is working around buggy
hardware and bios implementations.

> > > Besides the fact that this is just not a good design, there just isn't
> > > the manpower to maintain all of these in the kernel along with the
> > > requisite testing for each update, not to mention the lag between when
> > > we have to submit something and when it would show up in a vendor
> > > kernel.
> > 
> > And the lag for your userspace library would not be the same?
> 
> For some odd reason, our customers have less concerns with updating a
> userspace library. 

For a library like this, they should be just as concerned, as you have a
direct hook into their hardware, with the ability to break it just as
easily as a kernel update.

thanks,

greg k-h
