Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVLAF5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVLAF5u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 00:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVLAF5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 00:57:50 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:17029 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932075AbVLAF5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 00:57:49 -0500
Message-ID: <438E90DD.3010007@us.ibm.com>
Date: Wed, 30 Nov 2005 21:57:49 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: Linux Technology Center, IBM
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris McDermott <lcm@us.ibm.com>, Luvella McFadden <luvella@us.ibm.com>,
       AJ Johnson <blujuice@us.ibm.com>, Kevin Stansell <kstansel@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have an IBM x346 with some Adaptec 7902 SCSI controllers; one has HostRAID
enabled in a RAID array, and the other does not.  Upon bootup, the aic79xx
driver will grab both controllers even though I'd prefer that Adaptec's a320raid
driver grab the HostRAID controller.  (When attached to the RAID array, the
aic79xx driver presents each drive in the array as a separate SCSI device.)  If
HostRAID is turned on, the PCI class code is 0x0104 (RAID) and if it's turned
off, the class code is 0x0100 (SCSI).

Unfortunately, there currently is no provision in the aic79xx driver to ignore
RAID controllers--if the PCI device/vendor IDs match, the driver takes the
controller.  The attached patch modifies the PCI probe function to ignore RAID
controllers and a module parameter "attach_HostRAID" to toggle this behavior.
If one passes "attach_HostRAID=1" to insmod, the driver will take RAID
controllers; "attach_HostRAID=0", it won't.  The default is to set it to zero.

The patch should apply cleanly against 2.6.14 and I've verified that it works
correctly on a x346 and a x226, both of which have a 7902b.  I'd appreciate a
few more eyes to look over it, and if there aren't any objections I'd like to
submit this for inclusion in mainline.

--Darrick

--------------------------
Signed-Off-By: Darrick Wong <djwong@us.ibm.com>

diff -Naurp orig/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
linux-2.6.14.3/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
--- orig/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2005-11-24 14:10:21.000000000 -0800
+++ linux-2.6.14.3/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2005-11-29
16:54:30.000000000 -0800
@@ -43,6 +43,12 @@
 #include "aic79xx_inline.h"
 #include "aic79xx_pci.h"

+static int attach_HostRAID = 0;
+module_param_named(attach_HostRAID, attach_HostRAID, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(attach_HostRAID, "\n"
+        "\tEnable(1) or disable(0) attaching to HostRAID enabled host "
+        "adapters.\n\tDefault: 0");
+
 static int	ahd_linux_pci_dev_probe(struct pci_dev *pdev,
 					const struct pci_device_id *ent);
 static int	ahd_linux_pci_reserve_io_regions(struct ahd_softc *ahd,
@@ -132,6 +138,14 @@ ahd_linux_pci_dev_probe(struct pci_dev *
 	char		*name;
 	int		 error;

+	/* Ignore hostraid controllers unless the override is on. */
+ 	if (pdev->class == (PCI_CLASS_STORAGE_RAID << 8) && !attach_HostRAID) {
+		printk(KERN_INFO "aic79xx: will not attach to HostRAID enabled"
+			" device %s unless attach_HostRAID parameter is set\n",
+			pci_name(pdev));
+		return -ENODEV;
+	}
+
 	pci = pdev;
 	entry = ahd_find_pci_device(pci);
 	if (entry == NULL)
