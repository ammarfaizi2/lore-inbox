Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUH1QZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUH1QZV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUH1QV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:21:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22150 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267413AbUH1QPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:15:16 -0400
Date: Sat, 28 Aug 2004 17:15:10 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040828161510.GC16196@parcelfarce.linux.theplanet.co.uk>
References: <20040826155803.GN16196@parcelfarce.linux.theplanet.co.uk> <20040826195459.70018.qmail@web14925.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826195459.70018.qmail@web14925.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:54:59PM -0700, Jon Smirl wrote:
> New version that uses the PCI data structure to get the size. It's
> against 2.6.9-rc1-mm1, but that kernel is DOA on my machine.
> 
> I was confused about the type 0 versus other types and see that this
> code doesn't need to know the ROM type.

A few more bugfixes:

 - I was confused, it was hex 18, not decimal 16
 - Its/it's again ;-)
 - Only return the bits of the ROM that are in PCI format
 - Remove the actual resource, not some strange static one
 - Delete the static one that wasn't really used.

BTW, what do you think to moving all the ROM code from pci-sysfs.c to a
new file rom.c?  There's not much sense to the ROM accessing code being
mixed in with the sysfs code like this.  After all, we might choose to
expose the ROM in some other way in the future.

diff -u edited/drivers/pci/pci-sysfs.c vpd-2.6/drivers/pci/pci-sysfs.c
--- edited/drivers/pci/pci-sysfs.c	Thu Aug 26 15:21:02 2004
+++ vpd-2.6/drivers/pci/pci-sysfs.c	27 Aug 2004 19:33:37 -0000
@@ -262,8 +262,8 @@
 			break;
 		if (readb(image + 1) != 0xAA)
 			break;
-		/* get the PCI data structure and check it's signature */
-		pds = image + readw(image + 16);
+		/* get the PCI data structure and check its signature */
+		pds = image + readw(image + 24);
 		if (readb(pds) != 'P')
 			break;
 		if (readb(pds + 1) != 'C')
@@ -277,8 +277,7 @@
 		image += readw(pds + 16) * 512;
 	} while (!last_image);
 
-	if (image != rom)
-		*size = min((size_t)(image - rom), *size); /* make sure we didn't include an adjacent ROM */
+	*size = image - rom;
 
 	return rom;
 }
@@ -340,8 +342,6 @@
 		pci_disable_rom(pdev);
 }
 
-static struct bin_attribute rom_attr;
-
 /**
  * pci_remove_rom - disable the ROM and remove its sysfs attribute
  * @dev: pointer to pci device struct
@@ -353,7 +353,7 @@
 	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 	
 	if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
-		sysfs_remove_bin_file(&pdev->dev.kobj, &rom_attr);
+		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
 	if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW | IORESOURCE_ROM_COPY)))
 		pci_disable_rom(pdev);
 }


-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
