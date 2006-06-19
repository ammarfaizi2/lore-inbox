Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWFSSjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWFSSjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWFSSjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:39:10 -0400
Received: from mx2.mail.ru ([194.67.23.122]:23067 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S964811AbWFSSjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:39:09 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.6.17: dmesg flooded with "ohci_hcd 0000:00:02.0: wakeup"
Date: Mon, 19 Jun 2006 22:39:04 +0400
User-Agent: KMail/1.9.3
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200606181919.51126.arvidjaar@mail.ru> <200606182129.15712.arvidjaar@mail.ru> <200606181116.20815.david-b@pacbell.net>
In-Reply-To: <200606181116.20815.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606192239.06208.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 18 June 2006 22:16, David Brownell wrote:
> On Sunday 18 June 2006 10:29 am, Andrey Borzenkov wrote:
> > On Sunday 18 June 2006 20:29, David Brownell wrote:
> > > An alternative (but post-boot) workaround _should_ be
> > >
> > >     echo disabled > /sys/bus/pci/devices/0000:00:02.0/power/wakeup
>
> Did that work?
>

No. But

	echo -n disabled > /sys/devices/pci0000:00/0000:00:02.0/usb1/power/wakeup

did.

Now I noticed that when I boot 2.6.16 hub has only 'Self Powered' attribite 
(0xc0) while in 2.6.17 it adds 'Remote Wakeup':

Bus 001 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
...
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup

It apparently makes OHCI believe controller can correctly do suspend/wakeup. 
The suspend does not come from upper layer - it is ohci_hub itself attempting 
to put controller in lower power mode:

ohci_hub_status_data (struct usb_hcd *hcd, char *buf)
{
...
        int             can_suspend = 
device_may_wakeup(&hcd->self.root_hub->dev);
...
#ifdef CONFIG_PM
        /* save power by suspending idle root hubs;
         * INTR_RD wakes us when there's work
         */
        if (can_suspend
                        && !changed
                        && !ohci->ed_rm_list
                        && ((OHCI_CTRL_HCFS | OHCI_SCHED_ENABLES)
                                        & ohci->hc_control)
                                == OHCI_USB_OPER
                        && time_after (jiffies, ohci->next_statechange)
                        && usb_trylock_device (hcd->self.root_hub) == 0
                        ) {
                ohci_vdbg (ohci, "autosuspend\n");
                (void) ohci_bus_suspend (hcd);
                usb_unlock_device (hcd->self.root_hub);
        }
#endif

can_suspend is true while it was apparently false in 2.6.16.

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFElu9JR6LMutpd94wRAv5rAJwO/NZ13duktsD0WsksmFqLtUZufACgkBCS
cOb6y1BG+RjecKtCcua9sNY=
=Rm8d
-----END PGP SIGNATURE-----
