Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbRFPUde>; Sat, 16 Jun 2001 16:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbRFPUdY>; Sat, 16 Jun 2001 16:33:24 -0400
Received: from smtp-rt-9.wanadoo.fr ([193.252.19.55]:38792 "EHLO
	alisier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264653AbRFPUdQ>; Sat, 16 Jun 2001 16:33:16 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: pci_disable_device() vs. arch
Date: Sat, 16 Jun 2001 22:32:31 +0200
Message-Id: <20010616203231.20775@smtp.wanadoo.fr>
In-Reply-To: <3B2BBC3C.BEC4B313@mandrakesoft.com>
In-Reply-To: <3B2BBC3C.BEC4B313@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What arch-specific things need to be done?

I can control the gmac cell's clock. Actually, I can do the same
with the firewire clock (the firewire cell is in the same ASIC)
and with the firewire cable power.

>arch-specific pcibios_disable_device may be a good idea... but in this
>case it sounds like you need to put #ifdef CONFIG_ALL_PPC code in
>sungem.c instead, if the power-down code is specific to gmacs.

Well... I did that in gmac.c. With the arrival of sungem, I had in
mind to avoid clobbering sungem with such things, and since we
already have arch hook for pci_enable_device(), which I use to turn
ON the chip, I though about doing the same with pci_disable_device().

(Note that I do turn it ON temporarily during PCI probe so that
the pci_dev entry exist in the kernel).

It's mostly a mater of taste, I prefered avoiding calling arch
specific routines if possible in a "generic" driver. Note that I
will probably have to do some anyway as I need some arch calls
to control the PHY reset as well.

>Although some drivers already do this, you really need an inactivity
>timer instead of unconditionally powering-down the hardware on
>dev->stop().  dhcp and other applications will often bounce the
>interface...

In that case, it's not a power down, it's just a clock control. 
Which appear to be reather safe to toggle quickly. 

>For power-down specifically, you should use pci-set-power-state not
>pci-disable-device.  pci_disable_device is the opposite of
>pci_enable_device.  pci_enable_device not only wakes up the device, but
>also assigns resources.  Which implies that pci-disable-device is
>allowed to un-assign resources.  There shouldn't be a problem with a net
>device doing that per se, but you should be aware of the implications.

I'm aware of this. Actually, pci_disable_device() doesn't de-assign
any resource, but well... I guess there should be nothing wrong about
resources beeing un-assigned and/or re-assigned when the driver is
rmmod'ed or insmod'ed back.

I agree pci_set_power_state() would be a better choice, but it would
require some arch hooks as well since this is done done via normal PCI
power management.

Since I'll have to implement the suspend() and resume() callbacks
as well, maybe  we can agree on an arch hook for pci_set_power_state().
Actually, I beleive instead of an arch callback, I'd rather see a
function pointer in the pci_bus structure of the parent bridge. Our
arch would then put the proper code for it in the pci_bus associated
with that side of UniNorth. (UniNorth has 3 host bridges).

That said, a pcibios_disable_device() hook would be logical, since
there's already one in pcibios_enable_device().

Ben.


