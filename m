Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbSK3Bfp>; Fri, 29 Nov 2002 20:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbSK3Bfp>; Fri, 29 Nov 2002 20:35:45 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:28293 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267199AbSK3Bfo>; Fri, 29 Nov 2002 20:35:44 -0500
Date: Fri, 29 Nov 2002 17:42:41 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Patch/resubmit(2.5.50): Eliminate pci_dev.driver_data
Message-ID: <20021129174241.A333@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	This is the third time I'm posting this patch.  The only
comments anyone has made about it were from Greg Kroah-Hartmann, which
were in favor of integrating it.  Can we please get this integrated
already?  I want to try some more changes to pci.h and I'd rather keep
the patches separate.

	To review, this patch deletes pci_dev.driver_data, using the
existing pci_dev.device.driver_data field instead, thereby shrinking
struct pci_dev by four bytes on 32-bit machines.  The few device
drivers that attempted to directly reference pci_dev.driver_data were
fixed in a patch of mine that Jeff Garzik got into 2.5.45.  Also,
making this change should help with memory allocation improvements in
the future, although that's a separate issue.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci.diff"

--- linux-2.5.50/include/linux/pci.h	2002-11-27 14:35:59.000000000 -0800
+++ linux/include/linux/pci.h	2002-11-23 06:41:41.000000000 -0800
@@ -344,7 +344,6 @@
 	u8		rom_base_reg;	/* which config register controls the ROM */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
-	void		*driver_data;	/* data private to the driver */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
@@ -483,7 +482,7 @@
 	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
-
+	unsigned int		alloc_regions : 1;
 	struct device_driver	driver;
 };
 
@@ -753,12 +752,12 @@
  */
 static inline void *pci_get_drvdata (struct pci_dev *pdev)
 {
-	return pdev->driver_data;
+	return pdev->dev.driver_data;
 }
 
 static inline void pci_set_drvdata (struct pci_dev *pdev, void *data)
 {
-	pdev->driver_data = data;
+	pdev->dev.driver_data = data;
 }
 
 /*

--tThc/1wpZn/ma/RB--
