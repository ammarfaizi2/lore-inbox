Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbRFPUqp>; Sat, 16 Jun 2001 16:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264655AbRFPUq0>; Sat, 16 Jun 2001 16:46:26 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:40921 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264654AbRFPUqV>;
	Sat, 16 Jun 2001 16:46:21 -0400
Message-ID: <3B2BC57F.408A9B18@mandrakesoft.com>
Date: Sat, 16 Jun 2001 16:45:51 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: pci_disable_device() vs. arch
In-Reply-To: <3B2BBC3C.BEC4B313@mandrakesoft.com> <20010616203231.20775@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> 
> >What arch-specific things need to be done?
> 
> I can control the gmac cell's clock. Actually, I can do the same
> with the firewire clock (the firewire cell is in the same ASIC)
> and with the firewire cable power.
> 
> >arch-specific pcibios_disable_device may be a good idea... but in this
> >case it sounds like you need to put #ifdef CONFIG_ALL_PPC code in
> >sungem.c instead, if the power-down code is specific to gmacs.
> 
> Well... I did that in gmac.c. With the arrival of sungem, I had in
> mind to avoid clobbering sungem with such things, and since we
> already have arch hook for pci_enable_device(), which I use to turn
> ON the chip, I though about doing the same with pci_disable_device().
> 
> (Note that I do turn it ON temporarily during PCI probe so that
> the pci_dev entry exist in the kernel).
> 
> It's mostly a mater of taste, I prefered avoiding calling arch
> specific routines if possible in a "generic" driver. Note that I
> will probably have to do some anyway as I need some arch calls
> to control the PHY reset as well.

Its not clutter -- what you are doing is hiding pieces of the driver
from the driver maintainer.  pcibios_enable_device should not be
cluttered up with such mess, too.

I point out that I recently fixed a bug where Via interrupts were being
assigned incorrectly.  If I had not done a global grep for Via
irq-related code, I would have missed the spot where the PPC code was
doing a kludge for one of the four on-board Via devices, hardcoding the
USB irq number to 11.


> >Although some drivers already do this, you really need an inactivity
> >timer instead of unconditionally powering-down the hardware on
> >dev->stop().  dhcp and other applications will often bounce the
> >interface...
> 
> In that case, it's not a power down, it's just a clock control.
> Which appear to be reather safe to toggle quickly.
> 
> >For power-down specifically, you should use pci-set-power-state not
> >pci-disable-device.  pci_disable_device is the opposite of
> >pci_enable_device.  pci_enable_device not only wakes up the device, but
> >also assigns resources.  Which implies that pci-disable-device is
> >allowed to un-assign resources.  There shouldn't be a problem with a net
> >device doing that per se, but you should be aware of the implications.
> 
> I'm aware of this. Actually, pci_disable_device() doesn't de-assign
> any resource, but well... I guess there should be nothing wrong about
> resources beeing un-assigned and/or re-assigned when the driver is
> rmmod'ed or insmod'ed back.

Correct.  If your driver uses the API correctly, then when/if we want to
mess around with hotplug resource assignment, we can un-assign resources
as we like.  Since there aren't too many users of pci_disable_device so
far, I want to make sure early adopters get it right.


> I agree pci_set_power_state() would be a better choice, but it would
> require some arch hooks as well since this is done done via normal PCI
> power management.
> 
> Since I'll have to implement the suspend() and resume() callbacks
> as well, maybe  we can agree on an arch hook for pci_set_power_state().
> Actually, I beleive instead of an arch callback, I'd rather see a
> function pointer in the pci_bus structure of the parent bridge. Our
> arch would then put the proper code for it in the pci_bus associated
> with that side of UniNorth. (UniNorth has 3 host bridges).
> 
> That said, a pcibios_disable_device() hook would be logical, since
> there's already one in pcibios_enable_device().

Can you give a -specific- example of arch code that is -not- sungem
related, but needs to occur when one powers-down a sungem MAC?

If the PM code is related to sungem, it belongs in sungem.
So far I don't see a need for arch-specific hooks anywhere...

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
