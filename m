Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUHDP6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUHDP6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267329AbUHDP6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:58:33 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:16086 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S267327AbUHDP6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:58:11 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jon Smirl <jonsmirl@yahoo.com>
Date: Wed, 4 Aug 2004 17:57:41 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] add PCI ROMs to sysfs
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <E12D1EA555A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Aug 04 at 23:08, Jon Smirl wrote:

> +   unsigned long start;
> +   loff_t i, size;
> +   char direct_access = dev->rom_info.rom ? 0 : 1;
> +   unsigned char *rom = NULL;

What about using 'rom' variable for non-direct access too?

      unsigned char *rom = dev->rom_info.rom;
      char direct_access = rom == NULL;
      
> +   struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
> +
> +   if (off > size)

You can do  'if (off >= size) ...' And well, where is size assigned at
all?

> +       return 0;
> +       
> +   if (direct_access) {
> +       /* assign the ROM an address if it doesn't have one */
> +       if (r->parent == NULL)
> +           pci_assign_resource(dev, PCI_ROM_RESOURCE);
> +       /* Enable ROM space decodes and do the reads */
> +       pci_enable_rom(dev);
> +       start = pci_resource_start(dev, PCI_ROM_RESOURCE);
> +       size = pci_resource_len(dev, PCI_ROM_RESOURCE);
> +       rom = ioremap(start, size);

Test for failure? Test for no ROM devices?

> +       
> +       printk("read_rom start %lx size %x\n", start, size);
> +       printk("rom bytes %02x %02x\n", rom, rom + 1);

readb(rom), readb(rom+1)?

> +   }
> +   if (off + count > size) {

Is off + count guaranteed to not overflow?

> +       size -= off;
> +       count = size;
> +   } else
> +       size = count;
> +
> +   i = 0;
> +   while (size > 0) {
> +       unsigned char val;
> +       if (direct_access)
> +           val = readb(rom + off);

Please read it with readl. At least on my Matrox G550 reading 64KB ROM with
byte accesses takes 1334ms, with 16bit accesses 840ms and with
32bit (or 64bit MMX) accesses 551ms. Straight (non-IO aware) memcpy 
takes 535ms. And put some conditional_schedule()s here, 550ms (or even
34ms for 4KB chunk) is IMHO too long.

> +       else
> +           val = *(dev->rom_info.rom + off);

If you made changes suggested at the beginning, you can do this instead:

              val = rom[off];

                                                Best regards,
                                                    Petr Vandrovec

