Return-Path: <linux-kernel-owner+w=401wt.eu-S1750955AbXAIDOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbXAIDOt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 22:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbXAIDOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 22:14:48 -0500
Received: from emerald.lightlink.com ([205.232.34.14]:8369 "EHLO
	emerald.lightlink.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbXAIDOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 22:14:48 -0500
Date: Mon, 8 Jan 2007 22:11:29 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 2.6.20-rc4] i2c/pci: fix sis96x smbus quirk once and for all
Message-ID: <20070109031129.GA27550@jupiter.solarsys.private>
References: <20061219041315.GE6993@stusta.de> <20070105095233.4ce72e7e.khali@linux-fr.org> <20070107154441.GB22558@jupiter.solarsys.private> <20070108121055.d25c8ffa.khali@linux-fr.org> <20070109030226.GA2408@jupiter.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109030226.GA2408@jupiter.solarsys.private>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The sis96x SMBus PCI device depends on two different quirks to run
in a specific order.  Apart from being fragile, this was found to
actually break on (at least) recent FC4, FC5, and FC6 kernels.  This
patch fixes the quirks so that they work without relying on the
compiler and/or linker to put them in any specific order.

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/015962.html
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=189719

I tested this patch.  Please apply.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

---
 drivers/pci/quirks.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- linux-2.6.orig/drivers/pci/quirks.c
+++ linux-2.6/drivers/pci/quirks.c
@@ -1117,10 +1117,11 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_I
 static void quirk_sis_96x_smbus(struct pci_dev *dev)
 {
 	u8 val = 0;
-	printk(KERN_INFO "Enabling SiS 96x SMBus.\n");
-	pci_read_config_byte(dev, 0x77, &val);
-	pci_write_config_byte(dev, 0x77, val & ~0x10);
 	pci_read_config_byte(dev, 0x77, &val);
+	if (val & 0x10) {
+		printk(KERN_INFO "Enabling SiS 96x SMBus.\n");
+		pci_write_config_byte(dev, 0x77, val & ~0x10);
+	}
 }
 
 /*
@@ -1152,11 +1153,12 @@ static void quirk_sis_503(struct pci_dev
 	printk(KERN_WARNING "Uncovering SIS%x that hid as a SIS503 (compatible=%d)\n", devid, sis_96x_compatible);
 
 	/*
-	 * Ok, it now shows up as a 96x.. The 96x quirks are after
-	 * the 503 quirk in the quirk table, so they'll automatically
-	 * run and enable things like the SMBus device
+	 * Ok, it now shows up as a 96x.. run the 96x quirk by
+	 * hand in case it has already been processed.
+	 * (depends on link order, which is apparently not guaranteed)
 	 */
 	dev->device = devid;
+	quirk_sis_96x_smbus(dev);
 }
 
 static void __init quirk_sis_96x_compatible(struct pci_dev *dev)
-- 
Mark M. Hoffman
mhoffman@lightlink.com

