Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWDSAKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWDSAKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWDSAKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:10:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:38065 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750763AbWDSAKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:10:15 -0400
Date: Tue, 18 Apr 2006 17:04:38 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: class_device_create() and class_interfaces ?
Message-ID: <20060419000438.GA6522@kroah.com>
References: <adafykacur0.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adafykacur0.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 04:46:27PM -0700, Roland Dreier wrote:
> Hi Greg,
> 
> I'm trying to write some code that uses struct class_interface to do
> something when a class device appears.  However, if I follow the new
> world order of class_create() and class_device_create(), I seem to run
> into a problem.
> 
> Because class_device_create() allocates its own struct class_device
> memory, one can't use container_of() to get back to the original
> driver-specific device information.  The standard solution is to use
> class_set_devdata() to stash a pointer back.
> 
> However, if one has a class_interface registered for the class, then
> the class_interface.add() method gets called before class_device_create()
> even returns, so there's no chance to call class_set_devdata().  This
> means that the class_interface can't really do much with the class_device
> that it got, because it has no way to get to any interesting information
> about the real device.

Yes, you are correct.  class_interfaces are a pain :)

> The situation I'm thinking of is one device that implements multiple
> completely different functions -- for example an MPEG codec and a
> thermometer -- through the exact same registers etc.  So I want to
> have a core driver that manages real hardware access, and then
> separate MPEG codec and thermometer drivers.  The design I have in
> mind is that the MPEG and thermometer sub-drivers register class
> interfaces with the core driver, which creates a class device for each
> real hardware device it finds.  But the sub-drivers need some way of
> getting from the class device to a structure that lets them call back
> into the core driver.
> 
> I see several solutions:
> 
>  - Add a devdata parameter to class_device_create() so that devdata
>    can be set before class_interfaces are called.

I think we already have enough paramaters in that function call...

>  - Create a new class_device_create_with_devdata() function to do the
>    same thing without churning a bunch of existing drivers...
>  - Solve the core driver/sub-driver problem in a better way that
>    doesn't use class_devices or class_interfaces -- I'm open to
>    suggestions here.  I could implement my own registration handling
>    -- it's pretty trivial -- but duplicating what the driver model
>    already has seems silly.

I'm working toward getting rid of class_devices entirely.  What you can
do is use a struct device heirachy, right?  If so, take a look at this
patch:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/device-class.patch
which implements the start of this changeover.  So, if you were to do
this, you can just create a separate "bus" and drivers for these
different devices, and everything should bind just fine.

Yeah, it is hard to create a bus today, but I'm also working on making
that easier too.  You can always just use the platform device interface
now to mock something up to see how well it works out.

thanks,

greg k-h
