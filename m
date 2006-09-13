Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWIMTY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWIMTY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWIMTY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:24:56 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:17617 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750908AbWIMTYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:24:55 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.18-rc6-mm2: rmmod ohci_hcd oopses on HPC 6325
Date: Wed, 13 Sep 2006 21:24:22 +0200
User-Agent: KMail/1.9.1
Cc: Pete Zaitcev <zaitcev@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0609131441080.6684-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609131441080.6684-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609132124.23630.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 13 September 2006 20:44, Alan Stern wrote:
> On Wed, 13 Sep 2006, Rafael J. Wysocki wrote:
> 
> > 'rmmod ohci_hcd' causes the following oops to appear on my HPC 6325 every
> > time (happens also on -rc6-mm1, does not happen on -rc7):
> > 
> > Unable to handle kernel NULL pointer dereference at 0000000000000274 RIP:
> >  [<ffffffff8822c185>] :ohci_hcd:ohci_hub_status_data+0x25/0x27b
> > PGD 35ca9067 PUD 369a4067 PMD 0
> 
> > Call Trace:
> >  [<ffffffff8818e03f>] :usbcore:usb_hcd_poll_rh_status+0x40/0x13b
> >  [<ffffffff8822c01b>] :ohci_hcd:ohci_irq+0xcb/0x210
> >  [<ffffffff8818e78b>] :usbcore:usb_hcd_irq+0x2f/0x5f
> >  [<ffffffff8020ef13>] handle_IRQ_event+0x33/0x66
> >  [<ffffffff802af5f8>] handle_fasteoi_irq+0x9d/0xe3
> >  [<ffffffff80267c85>] do_IRQ+0x104/0x11f
> >  [<ffffffff80259621>] ret_from_intr+0x0/0xa
> > DWARF2 unwinder stuck at ret_from_intr+0x0/0xa
> > 
> > Leftover inexact backtrace:
> > 
> >  <IRQ>  <EOI>  [<ffffffff802ee4ac>] sysfs_hash_and_remove+0x9/0x137
> >  [<ffffffff802eed13>] sysfs_remove_file+0x10/0x12
> >  [<ffffffff8038baf7>] class_device_remove_file+0x12/0x14
> >  [<ffffffff8822aa02>] :ohci_hcd:ohci_stop+0xf5/0x17b
> >  [<ffffffff8818d9d2>] :usbcore:usb_remove_hcd+0xdc/0x114
> >  [<ffffffff8040f8eb>] klist_release+0x0/0x82
> >  [<ffffffff88197f45>] :usbcore:usb_hcd_pci_remove+0x1e/0x7d
> >  [<ffffffff803204d8>] pci_device_remove+0x25/0x3c
> >  [<ffffffff8038b1b5>] __device_release_driver+0x80/0x9c
> >  [<ffffffff8038b617>] driver_detach+0xac/0xee
> >  [<ffffffff8038ad92>] bus_remove_driver+0x75/0x98
> >  [<ffffffff8038b696>] driver_unregister+0x15/0x21
> >  [<ffffffff80320686>] pci_unregister_driver+0x13/0x8e
> >  [<ffffffff8822cd1c>] :ohci_hcd:ohci_hcd_pci_cleanup+0x10/0x12
> >  [<ffffffff8029b281>] sys_delete_module+0x1b5/0x1e6
> >  [<ffffffff8025910e>] system_call+0x7e/0x83
> > 
> > 
> > Code: 8a 98 74 02 00 00 e8 d6 3b 03 f8 48 89 45 d0 41 8b 84 24 e4
> > RIP  [<ffffffff8822c185>] :ohci_hcd:ohci_hub_status_data+0x25/0x27b
> >  RSP <ffffffff805c7e18>
> > CR2: 0000000000000274
> >  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
> > 
> > where
> > 
> > (gdb) l *ohci_hub_status_data+0x25
> > 0x4185 is in ohci_hub_status_data (drivers/usb/host/ohci-hub.c:316).
> > 311             struct ohci_hcd *ohci = hcd_to_ohci (hcd);
> > 312             int             i, changed = 0, length = 1;
> > 313             int             can_suspend;
> > 314             unsigned long   flags;
> > 315
> > 316             can_suspend = device_may_wakeup(&hcd->self.root_hub->dev);
> > 317             spin_lock_irqsave (&ohci->lock, flags);
> > 318
> > 319             /* handle autosuspended root:  finish resuming before
> > 320              * letting khubd or root hub timer see state changes.
> > 
> > I guess it may be related to the suspend issues?
> 
> No, this is completely separate.  The suspend issue involved ehci-hcd, not 
> ohci-hcd.

Well, on my box it's ohci-hcd too.

> This problem has already been identified by Pete Zaitcev in this thread:
> 
> 	http://marc.theaimsgroup.com/?t=115769512800001&r=1&w=2

Ah, thanks.

> Perhaps Pete has an updated patch to fix the problem.  If not, I could 
> write one.

For now I can use the original Pete's patch, but it would be nice to have a
fix in -mm. ;-)

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
