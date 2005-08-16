Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVHPITE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVHPITE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 04:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbVHPITE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 04:19:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:42884 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965140AbVHPITD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 04:19:03 -0400
Date: Tue, 16 Aug 2005 01:16:22 -0700
From: Greg KH <greg@kroah.com>
To: Michael E Brown <Michael_E_Brown@dell.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Douglas_Warzecha@dell.com, Matt_Domsch@dell.com
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050816081622.GA22625@kroah.com>
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com> <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com> <1124161828.10755.87.camel@soltek.michaels-house.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124161828.10755.87.camel@soltek.michaels-house.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 10:10:28PM -0500, Michael E Brown wrote:
> To take a concrete example, I suggested to Doug to mention fan status. I
> get the feeling that you possibly think that this would be better
> integrated into lmsensors, or something like that.

Yes it should.  That way you get the benifit of all userspace
applications that already use the lmsensors library without having to be
rewritten in order to support your new library.

> That really isn't the case, as lmsensors is really geared towards
> bit-banging lm81 (for example) chips to get fan status.

Not true at all.  It is geared toward providing a common userspace
interface for all sensor information in the system.  Now if it provides
this in a good and easy to use way is another story...

But anyway, there is a standard way to export fan speed and temperature
information from the kernel, the hwmon interface (see -mm for examples
and documentation, and the i2c stuff in mainline today.)

> In our case, we have a standardized BIOS interface to get this info,
> and that standardized method involves SMI and not bit-banging
> interfaces. Once this driver is accepted into the kernel, we can go
> and add support in the _userspace_ lmsensors libs to poll fan and temp
> using this driver.

No, export this data properly through sysfs like all other temperature
and sensor data is.  Don't create a new one, no matter how much you
would like to keep from changing kernel code in the future for new
hardware.

> For example, we already have at least one buggy implementation of this
> exact stack in the kernel as the i8k driver. The i8k driver was reverse-
> engineered and works, but it does not follow the spec at all, and so is
> subject to major breakage if the BIOS changes. With dcdbase + libsmbios,
> we can write this _correctly_, and in such a way that it follows the
> spec and will not break on BIOS updates.

No, fix the i8k driver as you have access to the specs.  It was there
first.

> What you are asking us to do is just not feasible on many levels. First,
> just from the number of functions we would have to implement. We would
> have to implement about 60 new sysfs files, with at least 120 separate
> functions for read/write.

No problem at all, we can create that with only 2 read/write functions.
See the i2c code for details.

> Each function would have to take into account the specific calling
> requirements of that specific function.

Again, no different from any other sensor driver.

> Then, we would have to implement all of the bugfixes and
> platform-specific workarounds in the kernel for each of those
> functions for each Dell platform.

Yup.

> Each time another function is added to BIOS, we would have to go out
> and patch everybody's kernel to support the new function.

Yup.  I suggest you complain to the bios people about this horrible way
to design hardware then :)

> Besides the fact that this is just not a good design, there just isn't
> the manpower to maintain all of these in the kernel along with the
> requisite testing for each update, not to mention the lag between when
> we have to submit something and when it would show up in a vendor
> kernel.

And the lag for your userspace library would not be the same?

thanks,

greg k-h
