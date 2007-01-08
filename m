Return-Path: <linux-kernel-owner+w=401wt.eu-S1751574AbXAHPBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbXAHPBt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbXAHPBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:01:49 -0500
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:37535
	"EHLO vs166246.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbXAHPBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:01:48 -0500
Content-Disposition: inline
From: Michael Buesch <mb@bu3sch.de>
To: jgarzik@pobox.com
Subject: Fwd: [PATCH] intel-rng workarounds (take 2)
Date: Mon, 8 Jan 2007 15:59:33 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200701081559.33846.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jan Beulich" <jbeulich@novell.com>

Add a load option to intel-rng to allow skipping the FWH detection,
necessary in case the BIOS has locked read-only the firmware hub space.
Also prevent any attempt to write to firmware space if it cannot be
write enabled (apparently caused hangs on some systems not having an
FWH and thus also not having a respective RNG).

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Michael Buesch <mb@bu3sch.de>

--- linux-2.6.20-rc4/drivers/char/hw_random/intel-rng.c	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.20-rc4-intel-rng-skip-fhw-detect/drivers/char/hw_random/intel-rng.c	2007-01-08 10:51:06.000000000 +0100
@@ -143,6 +143,11 @@ static const struct pci_device_id pci_tb
 };
 MODULE_DEVICE_TABLE(pci, pci_tbl);
 
+static __initdata int no_fwh_detect;
+module_param(no_fwh_detect, int, 0);
+MODULE_PARM_DESC(no_fwh_detect, "Skip FWH detection:\n"
+                                " positive value - skip if FWH space locked read-only\n"
+                                " negative value - skip always");
 
 static inline u8 hwstatus_get(void __iomem *mem)
 {
@@ -240,6 +245,11 @@ static int __init mod_init(void)
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
@@ -252,6 +262,23 @@ static int __init mod_init(void)
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
@@ -280,8 +307,7 @@ static int __init mod_init(void)
 		pci_write_config_byte(dev,
 		                      fwh_dec_en1_off,
 		                      fwh_dec_en1_val | FWH_F8_EN_MASK);
-	if (!(bios_cntl_val &
-	      (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK)))
+	if (!(bios_cntl_val & BIOS_CNTL_WRITE_ENABLE_MASK))
 		pci_write_config_byte(dev,
 		                      bios_cntl_off,
 		                      bios_cntl_val | BIOS_CNTL_WRITE_ENABLE_MASK);
@@ -315,6 +341,8 @@ static int __init mod_init(void)
 		goto out;
 	}
 
+fwh_done:
+
 	err = -ENOMEM;
 	mem = ioremap(INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
 	if (!mem)





-------------------------------------------------------

-- 
Greetings Michael.
