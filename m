Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVKZXCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVKZXCe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 18:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVKZXCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 18:02:34 -0500
Received: from web36911.mail.mud.yahoo.com ([209.191.85.79]:19060 "HELO
	web36911.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750773AbVKZXCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 18:02:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NnaxUCSqYOHWF6uUcokaW+MRZUStxfpiNSR5gCA/m/WytSV9DmhRxwDvEPkStrdDoC9zmr8iTNhGlWPv6aA5QTWA3ZW53U9Nv+XFHhG4djxLbqYnOkt5t09eYqOhhmk1JJnyZth9MwOBCkOiVCpoaTsm9YCb5wjeTowJbLxakj4=  ;
Message-ID: <20051126230233.28402.qmail@web36911.mail.mud.yahoo.com>
Date: Sat, 26 Nov 2005 23:02:33 +0000 (GMT)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: pxa27x_udc -- support for usb gadget for pxa27x?
To: Pavel Machek <pavel@ucw.cz>
Cc: Richard Purdie <rpurdie@rpsys.net>, David Vrabel <dvrabel@cantab.net>,
       lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       dkrivoschokov@dev.rtsoft.ru
In-Reply-To: <20051126210840.GE17663@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > > Ultimately, it would be nice to have the Zaurus detect whether a usb
> > > > host or client was present (using gpio 41 maybe?) and then activate the
> > > > host (ohci) or client (pxa27x_udc) driver as appropriate.
> > > 
> > > Unfortunately, that would make ohci unfunctional for me. I have normal
> > > usb device cable, connected to "USB gender changer" -- basically two
> > > female connectors -- so that I can plug USB network card into that.
> > > 
> > 
> > Just a thought. How about a sysfs entry which you can use to jam the device into either slave
> or
> > host mode?
> 
> Yes, that would do the trick. Auto sense is probably good solution,
> too, it is just that it should have /sys override or something like
> that.
> 
> 							Pavel

That is what I was thinking. Do you have an OTG device in your sysfs tree in which you could add
this?

I have been working on a platform which also has OTG and I have been thinking how to handle OTG in
a generic way.

A while back I started work on an OTG subsystem as there doesn’t seem to be any standard way of
implementing OTG controller driver in the kernel. The only example I could find was the TI OMAP
which has all the OTG stuff in the driver for the external transceiver (plus it also seemed to
have 3 or 4 OTG state machines). The idea of the subsystem is to break the OTG driver into its
constituent parts:

USB Host driver : This is already is the kernel and shouldn’t require any alteration.

USB Device driver: Again, the OTG subsystem should use the current framework.

USB Logic driver: This is the part of the OTG hardware that connects the slave or the host the
physical connector plus clock control etc.

USB Transceiver: This driver generates the special signals the OTG protocol uses as well as
detecting the signals that will cause a change of state in the state machine.

USB state machine:  Some hardware has the state machine build into them, some don’t, and some have
an incomplete implementation. This driver will implement in software what is lacking in the
hardware state machine.

This flexible subsystem should allow you to combine any USB master, USB device, USB OTG logic and
transceiver (be it internal as part of the OTG block or an external transceiver). This is only in
the early stages of development and I would need to talk to the USB guys first to see what I have
missed (I need to have another look at the otg_transceiver struct again). What would be great to
see in sysfs is something like:

/sys/devices/platform/otg1
|--host (symbolic link to device)
|--gadget (symbolic link to device)
|--otg_logic (symbolic link to device)
|--transceiver (symbolic link to device)
`--force_mode

Just an idea!

Mark

> Thanks, Sharp!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
