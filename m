Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTHSTsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTHSTrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:47:51 -0400
Received: from web14911.mail.yahoo.com ([216.136.225.249]:14700 "HELO
	web14911.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261300AbTHSTpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:45:05 -0400
Message-ID: <20030819194503.10122.qmail@web14911.mail.yahoo.com>
Date: Tue, 19 Aug 2003 12:45:03 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Standard driver call to enable/disable PCI ROM
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I needed to enable a PCI ROM and read a few things
from it, and then disable it again. It might be worth
adding a standard PCI API in 2.6 for this.

Here's the code I used...

static void * __init aty128_map_ROM(struct pci_dev
                   *dev, const struct aty128fb_par
*par)
{
   void *rom;
   struct resource *r =
      &dev->resource[PCI_ROM_RESOURCE];
                                                      
   /* assign address if it doesn't have one */
   if (r->start == 0)
      pci_assign_resource(dev,
                                    PCI_ROM_RESOURCE);
                                                      
   /* enable if needed */
   if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
      pci_write_config_dword(dev,
                     dev->rom_base_reg, r->start | 
                     PCI_ROM_ADDRESS_ENABLE);
      r->flags |= PCI_ROM_ADDRESS_ENABLE;
   }
   rom = ioremap(r->start, r->end - r->start + 1);
   if (!rom) {
     printk(KERN_ERR "aty128fb: ROM failed to map\n");
     return NULL;
   }
   /* Very simple test to make sure it appeared */
   if (readb(rom) != 0x55) {
      printk(KERN_ERR "aty128fb: Invalid ROM
            signature %x should be 0x55\n",
readb(rom));          
      aty128_unmap_ROM(dev, rom);
      return NULL;
   }
   return rom;
}
                                            
static void __init aty128_unmap_ROM(struct pci_dev
                                             *dev,
void * rom)
{
   /* leave it disabled and unassigned */
   struct resource *r =
         &dev->resource[PCI_ROM_RESOURCE];
                                            
   iounmap(rom);
                                            
   r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
   r->end -= r->start;
   r->start = 0;
   /* This will disable and set address to unassigned
*/
   pci_write_config_dword(dev, dev->rom_base_reg, 0);
   release_resource(r);
}


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
