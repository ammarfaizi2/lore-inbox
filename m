Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWG0Iat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWG0Iat (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWG0Iat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:30:49 -0400
Received: from mailgate.terastack.com ([195.173.195.66]:45832 "EHLO
	uk-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S932285AbWG0Ias convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:30:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-usb-devel] 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Date: Thu, 27 Jul 2006 09:29:41 +0100
Message-ID: <89E85E0168AD994693B574C80EDB9C270464D07C@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Thread-Index: Acand9OMaf/E5WpaSF2WJYOxlxI5jgCBejZwAG1a/tABiMepMA==
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Andrew Morton" <akpm@osdl.org>, "Alan Stern" <stern@rowland.harvard.edu>
Cc: <david-b@pacbell.net>, <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Fri, 14 Jul 2006 14:50:16 -0400 (EDT)
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > > On Fri, 14 Jul 2006, Andrew Morton wrote:
> > > 
> > > > On Fri, 14 Jul 2006 16:54:25 +0100
> > > > "Andy Chittenden" <AChittenden@bluearc.com> wrote:
> > > 
> > > > > > So I guess there's something awry with the USB 
> > controller driver?
> > > > > > 
> > > > > 
> > > > > Is there any other info that someone wants to track 
> > this down? Or has
> > > > > someone got a fix?
> > > 
> > > It's hard to come up with a fix without knowing what's 
> > wrong.  The current 
> > > development version of that subroutine is essentially the 
> > same as the 
> > > version in 2.6.17.
> > > 
> > > If you want to pin down the problem more precisely, try 
> > adding a whole 
> > > bunch of printk() statements to the 
> > quirk_usb_handoff_ohci() function in
> > > drivers/usb/host/pci-quirks.c.
> > > 
> > 
> > Andy, please add the below, work out what line it gets stuck 
> > at and then
> > let us know?  Thanks.
> 
> Well I did that and the kernel got a lot further! It ran 
> through the pci_init stuff without a hitch and then hung just 
> after this line was output:
> 
> ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) 
> Driver (PCI)
> 
> So I littered drivers/usb/host/ohci-pci.c with similar 
> debugging and the last line it printed was from (marked with --->):
> 
> static int __init ohci_hcd_pci_init (void)
> {
>     int ret;
>         printk (KERN_DEBUG "%s: " DRIVER_INFO " (PCI)\n", hcd_name);
>         if (usb_disabled())
>                 return -ENODEV;
> 
>         D();
> 
>         pr_debug ("%s: block sizes: ed %Zd td %Zd\n", hcd_name,
>                 sizeof (struct ed), sizeof (struct td));
> --->         D();
> 
>         ret = pci_register_driver (&ohci_pci_driver);
>         D();
>         return ret;
> 
> }
> 
> IE it never returned from pci_register_driver.
> 
> A bit more sprinkling of debugging showed it got to 
> drivers/base/bus.c (bus_add_driver()):
> 
>         D();
> 
>                 driver_attach(drv);
>         D();
> 
> It never returned from driver_attach().
> 
> More debugging in drivers/base/dd.c showed the last output to 
> be (marked with --->):
> 
> static int __driver_attach(struct device * dev, void * data)
> {
>         struct device_driver * drv = data;
> 
>         /*
>          * Lock device and try to bind to it. We drop the error
>          * here and always return 0, because we need to keep trying
>          * to bind to devices and some drivers will return an error
>          * simply if it didn't support the device.
>          *
>          * driver_probe_device() will spit a warning if there
>          * is an error.
>          */
> 
> --->        D();
> 
>         if (dev->parent)        /* Needed for USB */
>                 down(&dev->parent->sem);
>         D();
> 
> IE it never returned from down.
> 
> So why did putting in the initial lot of debug alter where 
> the kernel hung? And what's next?
> 
> NB a reminder: 2.6.16 boots up fine on this machine.

Any progress? FWIW I did notice a pause at:

Booting processor 1/2 APIC 0x1

on 2.6.17 - the pause isn't present on 2.6.16.

-- 
Andy, BlueArc Engineering
