Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264650AbRFPUHI>; Sat, 16 Jun 2001 16:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264651AbRFPUHB>; Sat, 16 Jun 2001 16:07:01 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:16089 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264650AbRFPUGu>;
	Sat, 16 Jun 2001 16:06:50 -0400
Message-ID: <3B2BBC3C.BEC4B313@mandrakesoft.com>
Date: Sat, 16 Jun 2001 16:06:20 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: pci_disable_device() vs. arch
In-Reply-To: <15147.35421.866268.67790@pizda.ninka.net> <20010616195331.26754@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> 
> Hi !
> 
> Would it make sense to add a
> 
> pcibios_disable_device(pci_dev*) called from the end of
> pci_disable_device() ?
> 
> I'm adding a call to it to sungem along with other pmac stuffs
> so that the chip can be properly power down (actually it's not
> really powered down but unclocked) after module removal.
> Of course, the arch code must be able to catch it in order to
> play with the various UniNorth control bits.

What arch-specific things need to be done?

arch-specific pcibios_disable_device may be a good idea... but in this
case it sounds like you need to put #ifdef CONFIG_ALL_PPC code in
sungem.c instead, if the power-down code is specific to gmacs.


> Note that my current gmac driver does shut the chip down when
> the interface is down, which makes it a bit more useful for
> laptops as most users currently compile the driver in the kernel.

Although some drivers already do this, you really need an inactivity
timer instead of unconditionally powering-down the hardware on
dev->stop().  dhcp and other applications will often bounce the
interface...


> I have nothing about changing the policy if you prefer so that
> users will now have to rmmod the driver once done with the
> interface to save power.

For power-down specifically, you should use pci-set-power-state not
pci-disable-device.  pci_disable_device is the opposite of
pci_enable_device.  pci_enable_device not only wakes up the device, but
also assigns resources.  Which implies that pci-disable-device is
allowed to un-assign resources.  There shouldn't be a problem with a net
device doing that per se, but you should be aware of the implications.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
