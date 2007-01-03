Return-Path: <linux-kernel-owner+w=401wt.eu-S1755048AbXACJRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbXACJRh (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 04:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbXACJRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 04:17:37 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:14057
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755045AbXACJRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 04:17:36 -0500
Message-Id: <459B8310.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 03 Jan 2007 09:18:56 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <jgarzik@pobox.com>
Cc: "Michael Buesch" <mb@bu3sch.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] intel-rng workarounds
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a load option to intel-rng to allow skipping the FWH detection,
necessary in case the BIOS has locked read-only the firmware hub space.
Also prevent any attempt to write to firmware space if it cannot be
write enabled (apparently caused hangs on some systems not having an
FWH and thus also not having a respective RNG).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.20-rc3/drivers/char/hw_random/intel-rng.c	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.20-rc3-intel-rng-skip-fhw-detect/drivers/char/hw_random/intel-rng.c	2006-11-29 09:09:21.000000000 +0100
@@ -143,6 +143,8 @@ static const struct pci_device_id pci_tb
 };
 MODULE_DEVICE_TABLE(pci, pci_tbl);
 
+static __initdata int no_fwh_detect;
+module_param(no_fwh_detect, int, 0);
 
 static inline u8 hwstatus_get(void __iomem *mem)
 {
@@ -240,6 +242,11 @@ static int __init mod_init(void)
 	if (!dev)
 		goto out; /* Device not found. */
 
+	if (no_fwh_detect < 0) {
+		pci_dev_put(dev);
+		goto fwh_done;
+	}
+
 	/* Check for Intel 82802 */
 	if (dev->device < 0x2640) {
 		fwh_dec_en1_off = FWH_DEC_EN1_REG_OLD;
@@ -252,6 +259,23 @@ static int __init mod_init(void)
 	pci_read_config_byte(dev, fwh_dec_en1_off, &fwh_dec_en1_val);
 	pci_read_config_byte(dev, bios_cntl_off, &bios_cntl_val);
 
+	if ((bios_cntl_val &
+	     (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK))
+	    == BIOS_CNTL_LOCK_ENABLE_MASK) {
+		static __initdata /*const*/ char warning[] =
+			KERN_WARNING PFX "Firmware space is locked read-only. If you can't or\n"
+			KERN_WARNING PFX "don't want to disable this in firmware setup, and if\n"
+			KERN_WARNING PFX "you are certain that your system has a functional\n"
+			KERN_WARNING PFX "RNG, try using the 'no_fwh_detect' option.\n";
+
+		pci_dev_put(dev);
+		if (no_fwh_detect)
+			goto fwh_done;
+		printk(warning);
+		err = -EBUSY;
+		goto out;
+	}
+
 	mem = ioremap_nocache(INTEL_FWH_ADDR, INTEL_FWH_ADDR_LEN);
 	if (mem == NULL) {
 		pci_dev_put(dev);
@@ -280,8 +304,7 @@ static int __init mod_init(void)
 		pci_write_config_byte(dev,
 		                      fwh_dec_en1_off,
 		                      fwh_dec_en1_val | FWH_F8_EN_MASK);
-	if (!(bios_cntl_val &
-	      (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK)))
+	if (!(bios_cntl_val & BIOS_CNTL_WRITE_ENABLE_MASK))
 		pci_write_config_byte(dev,
 		                      bios_cntl_off,
 		                      bios_cntl_val | BIOS_CNTL_WRITE_ENABLE_MASK);
@@ -315,6 +338,8 @@ static int __init mod_init(void)
 		goto out;
 	}
 
+fwh_done:
+
 	err = -ENOMEM;
 	mem = ioremap(INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
 	if (!mem)


