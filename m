Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVCYU0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVCYU0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVCYU0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:26:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34057 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261777AbVCYUZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:25:13 -0500
Date: Fri, 25 Mar 2005 20:25:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Mundt <lethal@linux-sh.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Separate platform device name from platform device number
Message-ID: <20050325202508.A12715@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Kyle Moffett <mrmacman_g4@mac.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <1110414879646@kroah.com> <11104148792069@kroah.com> <20050325180136.GA4192@linux-sh.org> <20050325181014.GA13436@kroah.com> <20050325183534.GB4192@linux-sh.org> <5c0804da3486a6e735a46220d73c9637@mac.com> <20050325195826.GC4192@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050325195826.GC4192@linux-sh.org>; from lethal@linux-sh.org on Fri, Mar 25, 2005 at 09:58:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 09:58:26PM +0200, Paul Mundt wrote:
> On Fri, Mar 25, 2005 at 02:38:22PM -0500, Kyle Moffett wrote:
> > So how would you tell the difference between the following?
> > 	device = "foobar0"
> > 	id = -1
> > 	path = "/sys/devices/platform/foobar0"
> > versus
> > 	device = "foobar"
> > 	id = 0
> > 	path = "/sys/devices/platform/foobar0"
> > 
> Easy, we use the delimiter on anything ending with a number at the end of
> the device name.. so for device = "foobar0", this would end up as
> /sys/devices/platform/foobar0.0, whereas in the latter case this would
> end up as /sys/devices/platform/foobar0.

Eh?  How do you end up with "/sys/devices/platform/foobar0.0" for the
former case?  It has an ID of "-1", and not zero.  Your idea doesn't
make any sense.

> The first case is a corner case, and really shouldn't happen that much in
> practice outside of broken drivers.

It does happen today.  Firstly, the 8250 driver registers a device of
"serial8250" with id = -1 for the backwards-compatible devices.
Platforms can then register a platform device called "serial8250"
with zero or positive id numbers.

> > It's not as nice to add the extra period, but otherwise you end up with
> > a lot of _extra_ special cases in both the kernel _and_ applications,
> > which helps nobody.
> > 
> No you don't, it's pretty easy to figure out that if the end of the
> device name is a number that there will be a delimiter between that and
> the id. This should be the exception, not the rule.

Note that id = -1 means _no id_.  So, Kyle is quite correct to ask about
that case.

	device = "serial8250"
	id = -1
	=> /sys/devices/platform/serial8250

The "-1" means "do not add the ID".

but, under the old naming scenario, the following comes out to the same
sysfs path:

	device = "serial825"
	id = 0
	=> /sys/devices/platform/serial8250

and

	device = "serial8250"
	id = 0
	=> /sys/devices/platform/serial82500

is just too confusing.  Same problem with i82365 platform devices, etc.

> We don't go around changing /dev semantics everytime someone decides to
> call their device something silly, I don't see why platform devices
> should be treated differently, better to just fix the broken drivers..

It's not about something being called something silly.  It's about
the original concept of how to generate the path being down right
stupid.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
