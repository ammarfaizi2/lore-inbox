Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbRBOLk2>; Thu, 15 Feb 2001 06:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBOLkT>; Thu, 15 Feb 2001 06:40:19 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:22176 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129189AbRBOLkI>; Thu, 15 Feb 2001 06:40:08 -0500
Message-ID: <3A8BC242.2C62DAA1@uow.edu.au>
Date: Thu, 15 Feb 2001 22:49:22 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: David Hinds <dhinds@sonic.net>,
        Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network driver updates
In-Reply-To: <Pine.LNX.3.96.1010214020707.28011E-100000@mandrakesoft.mandrakesoft.com> <3A8A7159.AF0E6180@colorfullife.com> <3A8A8937.A77BA18D@uow.edu.au> <20010214093859.B20503@sonic.net> <3A8AC6B6.9790FF9C@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> David Hinds wrote:
> >
> > Say the driver is linked into the kernel.  Hot plug drivers should not
> > all complain about not finding their hardware.
> >
> 
> That's handled by pci_module_init(), check <linux/pci.h>:
> if CONFIG_HOTPLUG is enabled, then pci_module_init() never returns with
> -ENODEV.
> 
> Which means that eisa cards will never be probed in a hotplug enabled
> kernel.
> 
> And loading the current 3c59x.c into a non CONFIG_HOTPLUG non EISA
> kernel results in a disconnected driver:
> it's _not_ registered as a pci driver, pci_module_init() calls
> pci_unregister_driver().

That's what we want to happen, isn't it?  If it's not a hotplug
kernel and the hardware isn't there at boot time, don't register
the PCI driver.  But still scan for EISA devices.  That's what
the patch I sent yesterday does.  Here it is:

static int __init vortex_init (void)
{
    int pci_rc, eisa_rc;

    pci_rc = pci_module_init(&vortex_driver);
    eisa_rc = vortex_eisa_init();

    if (pci_rc == 0)
        vortex_have_pci = 1;
    if (eisa_rc > 0)
        vortex_have_eisa = 1;

    return (vortex_have_pci + vortex_have_eisa) ? 0 : -ENODEV;
}

Really, vortex_have_pci should be called
vortex_have_pci_or_hotplug_and_dont_have_pci.

Look.  When the driver's init_module() method is called
there are four combinations which must be catered for
(ignoring EISA):

CONFIG_HOTPLUG=n, MODULE=false
	If the hardware isn't there, don't register
        the pci_driver.  It can't _do_ anything.

CONFIG_HOTPLUG=n, MODULE=true
	If the hardware isn't there, barf.  modprobe will
        remove the driver again.

CONFIG_HOTPLUG=y, MODULE=false
        If the hardware isn't there, register the pci
        driver, because the hardware may appear later

CONFIG_HOTPLUG=y, MODULE=true
        If the hardware isn't there, barf. modprobe will remove
        the driver.  Later, when the hardware is inserted, another
        modprobe will succeed.

This is what yesterday's patch implements.

Now, the thing I don't understand about David's design is the
final one.  What 3c575_cb does is:

CONFIG_HOTPLUG=y, MODULE=true
         If the hardware isn't there, register the driver and
         hang around.

Why?


BTW: How come CONFIG_PCMCIA requires CONFIG_HOTPLUG?  Doesn't
it make sense to be able to have glued-in Cardbus devices?


-
