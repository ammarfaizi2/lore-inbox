Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSJ0JCP>; Sun, 27 Oct 2002 04:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262323AbSJ0JCP>; Sun, 27 Oct 2002 04:02:15 -0500
Received: from h-66-166-207-249.SNVACAID.covad.net ([66.166.207.249]:39843
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262322AbSJ0JCM>; Sun, 27 Oct 2002 04:02:12 -0500
Date: Sun, 27 Oct 2002 01:08:23 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mj@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.44/include/linux/pci.h - eliminate pci_dev.driver_data
Message-ID: <20021027010823.A305@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Martin,

	In 2.5.44 (don't know when it first appeared), the generic
struct device has a "void *driver_data" field.  The following patch
eliminates pci_dev.driver_data, using pci_dev.dev.driver_data instead.

	The immediate benefits are small but pretty clear:

	1. Shrinks all struct pci_dev's by 4 (or 8) bytes.
	2. Shrinks include/linux/pci.h by 1 line.
	3. Avoids potential bugs by programmers getting conufsed between
	   the two.
	4. Prevents anyone from writing drivers that use both pointers
	   separately, which would make it harder to make this change
	   in the future.  This is a reason to make the change now.

	Only six driver files in 2.5.44 attempted to reference
pci_dev.driver_data directly, and I have submitted patches
to make them use pci_{get,set}_drvdata to their maintainers
(cc'ed to linux-kernel).

	I am sending this email from a machine running this patch.

	By the way, there is an additional future benefit that I
envision.  In the future, I would like to add an optional
device_driver.devpriv_size field that could eliminate some initial
memory allocation, error branch and memory deallocation in about a
hundred drivers (well, at least after allocation of network, SCSI, USB
interfaces is done by filling in a pointer to a structure rather than
having a routine that does its own kmalloc).

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci.diff"

--- linux-2.5.44/include/linux/pci.h	2002-10-18 21:01:53.000000000 -0700
+++ linux/include/linux/pci.h	2002-10-27 01:05:49.000000000 -0800
@@ -344,7 +344,6 @@
 	u8		rom_base_reg;	/* which config register controls the ROM */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
-	void		*driver_data;	/* data private to the driver */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
@@ -758,12 +757,12 @@
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

--17pEHd4RhPHOinZp--
