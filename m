Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVGaS2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVGaS2w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVGaS1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:27:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261853AbVGaSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:25:19 -0400
Date: Sun, 31 Jul 2005 11:25:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Manuel Lauss <mano@roarinelk.homelinux.net>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stelian Pop <stelian@popies.net>
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <42EC9410.8080107@roarinelk.homelinux.net>
Message-ID: <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org> <42EC9410.8080107@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Jul 2005, Manuel Lauss wrote:
> 
> something broke the sonypi driver a bit after -mm2:
> I can no longer set bluetooth-power for instance, and it logs these
> messages:
> 
> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 605)
> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 607)
> sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 594)
> 
> setting/getting brightness, getting battery/ac status still work.
> 
> 
> The ioports assignments have changed a bit between -mm2 and -mm3:

The diff shows:

	-/proc/ioports on -mm2:
	+/proc/ioports on -mm3:
	 0000-001f : dma1
	 0020-0021 : pic1
	 0040-0043 : timer0
	@@ -25,13 +25,13 @@
	 0540-055f : 0000:00:1f.3
	    0540-054f : i801-smbus
	 0cf8-0cff : PCI conf1
	-1080-109f : Sony Programable I/O Device
	+1000-1fff : PCI CardBus #03
	+   1080-109f : Sony Programable I/O Device
	+2000-2fff : PCI CardBus #03
	 c000-cfff : PCI Bus #01
	    c800-c8ff : 0000:01:00.0
	      c800-c8ff : radeonfb
	 d000-dfff : PCI Bus #02
	-   d000-d1ff : PCI CardBus #03
	-   d400-d5ff : PCI CardBus #03
	    dc00-dc3f : 0000:02:03.0
	      dc00-dc3f : e1000
	 e000-e03f : 0000:00:1f.5

ie the difference is that the PCI cardbus resources have been moved from 
inside PCI Bus #2 to outside of it, and as a side effect the sonypi
device just happened to be allocated inside the Cardbus IO space.

Now, this is really unlucky. There are two issues here:

 - the -mm2 iomap just _looks_ better. I can't tell what the exact
   difference is, but it looks like one of the PCI resource allocation
   patches got reverted or re-applied.

   However, I'm almost positive that this is the Intel transparent bridge 
   thing, and it doesn't really matter where the CardBus resources got 
   allocated. So the _real_ breakage is probably due to a totally
   unrelated issue:

 - The SonyPI driver just allocates IO regions in random areas. It's got a 
   list of places to try allocating in, and the 1080 area just happens to 
   be the first on the list, and since it's not used by anything else, it 
   succeeds (never mind that it's on totally the wrong bus).

and I think the real bug here is the SonyPI driver.

It should either use an IO port in the legacy motherboard resource area
(ie allocate itself somewhere in IO ports 0x100-0x3ff), _or_ it should 
play well as a PCI device, and actually try to work with the PCI IO port 
allocation layer.

So instead of just saying "I want port 1080" (which may be on some other 
bus entirely), it _could_ (and should) do something like

	/*
	 * Use "device resource 6" for this: it's traditionally
	 * the PCI ROM resource, but we don't have a ROM, so we take it
	 * over for our special IO region.
	 */
	struct resource *res = dev->resource + 6;
	int ret;

	res->flags = IORESOURCE_IO;
	ret = pci_bus_alloc_resource(dev->bus,	/* bus */
			res, 			/* resource */
			SONYPI_TYPE2_REGION_SIZE, /* size */,
			SONYPI_TYPE2_REGION_SIZE, /* alignment */,
			PCIBIOS_MIN_IO,		/* Min starting pos */
			IORESOURCE_IO,		/* IO type */
			pcibios_align_resource,	/* Standard alignment */
			dev);
	if (ret < 0)
		return -ENODEV;

	.. use port "res->start" ..

which should do the right thing.

Stelian? The above is untested, but it should give roughly the right 
behaviour - you might need to tweak it a bit, but I think it should be a 
lot better than just picking random IO ports out of your hat and seeing if 
they are already used by something else...

		Linus
