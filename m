Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265871AbUFIT23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUFIT23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUFIT22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:28:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:18345 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265916AbUFIT1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:27:55 -0400
Date: Wed, 9 Jun 2004 12:26:56 -0700
From: Greg KH <greg@kroah.com>
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Behavior of serial usb driver when unplugged
Message-ID: <20040609192656.GA14786@kroah.com>
References: <Pine.LNX.4.60.0406081137030.9168@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0406081137030.9168@winds.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 11:49:51AM -0400, Byron Stanoszek wrote:
> Hi all,
> 
> I'm currently using Linux (2.6.7-rc3) in an embedded system with a 8-port
> Sealevel SeaLink 2802 USB device. This is a 8-port RS-232/422 device that
> allocates /dev/ttyUSB0 through /dev/ttyUSB7 when plugged in.
> 
> If I have a process talking to one of the ports, e.g. 'cat < /dev/ttyUSB0', 
> and
> I unplug the USB hub, all ports except ttyUSB0 unregister properly.

That's because userspace still has that port open.

> Without killing the 'cat' process, plugging the hub back in will make it
> allocate /dev/ttyUSB1 through /dev/ttyUSB8, thereby offsetting each USB 
> port# by 1.

Yup, glad it's all working properly for you.

> When killing the 'cat' process at this point, the kernel reports:
> 
> drivers/usb/serial/ftdi_sio.c: error from flowcontrol urb
> drivers/usb/serial/ftdi_sio.c: Error from DTR LOW urb
> drivers/usb/serial/ftdi_sio.c: Error from RTS LOW urb
> 
> and then unregisters /dev/ttyUSB0.

Nice.

> Is there a way to allow "hotplug" of a USB device to reuse /dev/ttyUSB0
> regardless if an application still has that particular tty open?

Nope.  Why would you want to do such a thing?

> If not, is there a way I could make the serial subsystem can send an
> EIO errno or some other notification when the serial device is
> disconnected?

It's been discussed that the tty_hangup() should be done for the port
when this happens.  I haven't messed with it to test it out, as no one
has complained in the 5+ years of usb-serial drivers being in the kernel
:)

Also, you could use something like udev to make the name always show up
the same for the device node no matter if it was called ttyUSB0 or
ttyUSB1, which might solve some of your problems (but not others it
sounds like.)

thanks,

greg k-h
