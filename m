Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUFKDb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUFKDb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 23:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbUFKDb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 23:31:26 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24894 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S263743AbUFKDbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 23:31:23 -0400
Date: Thu, 10 Jun 2004 21:21:09 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [linux-usb-devel] Behavior of serial usb driver when unplugged
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Message-id: <00cf01c44f63$24255700$6401a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.hfqlta4.vgmer8@ifi.uio.no> <fa.ddnp9ml.1i4qprn@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that the fix to send tty_hangup when the USB-to-serial adapter is
disconnected really should go in (there was about a 2-line patch posted a
while ago to add this). The application I'm working on required this patch
in order to detect that the USB serial port it's talking to has been
disconnected from the machine - otherwise the behavior you get is rather
silly, if you're blocked on a read it never returns after the device was
unplugged, and writes return -ENODEV; basically if you don't write anything
there is no way whatsoever to detect that the port is gone. It sounds like
the poster's application is another where the current behavior of the USB
serial driver makes things a real pain..


----- Original Message ----- 
From: "Greg KH" <greg@kroah.com>
Newsgroups: fa.linux.kernel
To: "Byron Stanoszek" <gandalf@winds.org>
Cc: <linux-usb-devel@lists.sourceforge.net>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, June 09, 2004 1:32 PM
Subject: Re: [linux-usb-devel] Behavior of serial usb driver when unplugged


> On Tue, Jun 08, 2004 at 11:49:51AM -0400, Byron Stanoszek wrote:
> > Hi all,
> >
> > I'm currently using Linux (2.6.7-rc3) in an embedded system with a
8-port
> > Sealevel SeaLink 2802 USB device. This is a 8-port RS-232/422 device
that
> > allocates /dev/ttyUSB0 through /dev/ttyUSB7 when plugged in.
> >
> > If I have a process talking to one of the ports, e.g. 'cat <
/dev/ttyUSB0',
> > and
> > I unplug the USB hub, all ports except ttyUSB0 unregister properly.
>
> That's because userspace still has that port open.
>
> > Without killing the 'cat' process, plugging the hub back in will make it
> > allocate /dev/ttyUSB1 through /dev/ttyUSB8, thereby offsetting each USB
> > port# by 1.
>
> Yup, glad it's all working properly for you.
>
> > When killing the 'cat' process at this point, the kernel reports:
> >
> > drivers/usb/serial/ftdi_sio.c: error from flowcontrol urb
> > drivers/usb/serial/ftdi_sio.c: Error from DTR LOW urb
> > drivers/usb/serial/ftdi_sio.c: Error from RTS LOW urb
> >
> > and then unregisters /dev/ttyUSB0.
>
> Nice.
>
> > Is there a way to allow "hotplug" of a USB device to reuse /dev/ttyUSB0
> > regardless if an application still has that particular tty open?
>
> Nope.  Why would you want to do such a thing?
>
> > If not, is there a way I could make the serial subsystem can send an
> > EIO errno or some other notification when the serial device is
> > disconnected?
>
> It's been discussed that the tty_hangup() should be done for the port
> when this happens.  I haven't messed with it to test it out, as no one
> has complained in the 5+ years of usb-serial drivers being in the kernel
> :)
>
> Also, you could use something like udev to make the name always show up
> the same for the device node no matter if it was called ttyUSB0 or
> ttyUSB1, which might solve some of your problems (but not others it
> sounds like.)
>
> thanks,
>
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

