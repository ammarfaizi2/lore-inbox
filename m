Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWGKXXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWGKXXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWGKXXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:23:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:7336 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932234AbWGKXW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:22:58 -0400
Date: Tue, 11 Jul 2006 16:18:44 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Implement class_device_update_dev() function
Message-ID: <20060711231844.GE18973@kroah.com>
References: <1152226792.29643.8.camel@localhost> <20060706235745.GA13548@kroah.com> <1152258152.3693.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152258152.3693.8.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 09:42:32AM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > > for the Bluetooth subsystem integration into the driver model it is
> > > required that we can update the device of a class device at any time.
> > 
> > You can?  Ick.
> > 
> > That messes with my "get rid of struct class_device" plans a bit...
> 
> this must not be a class device, but at the moment TTY, network and
> input are still class devices. The Bluetooth subsystem moved away from
> using class devices.
> 
> > > For the RFCOMM TTY device for example we create the TTY device and only
> > > when it got opened we create the Bluetooth connection. Once this new
> > > connection has been created we have a device to attach to the class
> > > device of the TTY.
> > > 
> > > I came up with the attached patch and it worked fine with the Bluetooth
> > > RFCOMM layer.
> > 
> > But userspace should also find out about this change, and this patch
> > prevents that from happening.  What about just tearing down the class
> > device and creating a new one?  That way userspace knows about the new
> > linkage properly, and any device naming and permission issues can be
> > handled anew?
> 
> This won't work for Bluetooth. We create the TTY and its class device
> with tty_register_device() and then the device node is present. Then at
> some point later we open that device and the Bluetooth connection gets
> established. Only when the connection has been established we know the
> device that represents it. So tearing down the class device and creating
> a new one will screw up the application that is using this device node.

So to start with, you have a class device with no attached "struct
device"?  And then after opening the device node, you want to create the
symlink?

> Would reissuing the uevent of the class device help here?

Not really, because as you state, we aren't changing the class device
itself, and throwing another uevent for it would probably just confuse
userspace :)

thanks,

greg k-h
