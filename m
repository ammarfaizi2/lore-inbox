Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbSKTFJa>; Wed, 20 Nov 2002 00:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbSKTFJa>; Wed, 20 Nov 2002 00:09:30 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:46230 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265791AbSKTFJ2>; Wed, 20 Nov 2002 00:09:28 -0500
Date: Tue, 19 Nov 2002 21:16:26 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH(2.5.48): Eliminate pcidev.driver_data
Message-ID: <20021119211626.A2389@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch eliminates pcidev.driver_data, in favor of
pcidev.dev.driver_data, thereby shrinking pcidev by four bytes.

	In the future, I hope this patch will make it simpler to have
a facility where drivers can ask the generic device layer to do the
kmalloc of their private memory area, but that's another patch.

	Applying this patch now will help discourage anyone from
building drivers that rely on having two different private pointers
in struct pci_dev and struct device.

	I oringally posted this patch against 2.5.44 along with a
separate patch that changed the few device drivers that directly
referenced pcidev.dev to use pci_{get,set}_drvdata().  The latter
patches got into 2.5.45 via Jeff Garzik.  At 2.5.45, I reposted this
patch and Greg Kroah-Hartman said that he would submit it to you in
"the next round of pci cleanups I'm going to be sending to Linus", but
it seems to have fallen through the cracks since then.  This patch has
been posted to lkml twice before and nobody has stated any objections
to this patch.

	Although I do not make much use of 2.5.48 due to the modules
problems, I have been running with this patch since 2.5.44 with no
problems.

	Please apply.  Thanks in advance.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci.diff"

--- linux-2.5.48/include/linux/pci.h	2002-11-17 20:29:45.000000000 -0800
+++ linux/include/linux/pci.h	2002-11-19 21:13:04.000000000 -0800
@@ -344,7 +344,6 @@
 	u8		rom_base_reg;	/* which config register controls the ROM */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
-	void		*driver_data;	/* data private to the driver */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
@@ -770,12 +769,12 @@
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

--ZPt4rx8FFjLCG7dd--
