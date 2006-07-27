Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWG0LWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWG0LWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWG0LWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:22:37 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:19331 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751274AbWG0LWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:22:36 -0400
Message-Id: <44C8BE63.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 27 Jul 2006 13:23:47 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix Intel RNG detection
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, since determination whether there was an Intel random
number generator was based on a single bit, on systems with a matching
bridge device but without a firmware hub, there was a 50% chance that
the code would incorrectly decide that the system had an RNG. This
patch adds detection of the firmware hub to better qualify the
existence of an RNG.

There is one issue with the patch: I was unable to determine the LPC
equivalent for the PCI bridge 8086:2430 (since the old code didn't
care about which of the many devices provided by the ICH/ESB it was
chose to use the PCI bridge device, but the FWH settings live in the
LPC device, so the device list needed to be changed).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
/home/jbeulich/tmp/linux-2.6.18-rc2/drivers/char/hw_random/intel-rng.c	2006-07-27
08:50:19.000000000 +0200
+++
2.6.18-rc2-intel-rng/drivers/char/hw_random/intel-rng.c	2006-07-27
11:01:10.439631816 +0200
@@ -58,12 +58,50 @@
  * want to register another driver on the same PCI id.
  */
 static const struct pci_device_id pci_tbl[] = {
-	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
-	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
-	{ 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
-	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
-	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
-	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+/* AA
+	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
+	{ 0x8086, 0x2410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* AA */
+/* AB
+	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
+	{ 0x8086, 0x2420, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* AB */
+/* ??
+	{ 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
+/* BAM, CAM, DBM, FBM, GxM
+	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
+	{ 0x8086, 0x244c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* BAM */
+	{ 0x8086, 0x248c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* CAM */
+	{ 0x8086, 0x24cc, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* DBM */
+	{ 0x8086, 0x2641, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* FBM */
+	{ 0x8086, 0x27b9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* GxM */
+	{ 0x8086, 0x27bd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* GxM DH
*/
+/* BA, CA, DB, Ex, 6300, Fx, 631x/632x, Gx
+	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
+	{ 0x8086, 0x2440, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* BA */
+	{ 0x8086, 0x2480, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* CA */
+	{ 0x8086, 0x24c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* DB */
+	{ 0x8086, 0x24d0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* Ex */
+	{ 0x8086, 0x25a1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 6300
*/
+	{ 0x8086, 0x2640, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* Fx */
+	{ 0x8086, 0x2670, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x2671, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x2672, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x2673, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x2674, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x2675, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x2676, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x2677, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x2678, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x2679, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x267a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x267b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x267c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x267d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x267e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x267f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /*
631x/632x */
+	{ 0x8086, 0x27b8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* Gx */
+/* E
+	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
+	{ 0x8086, 0x2450, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* E  */
 	{ 0, },	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, pci_tbl);
@@ -138,22 +176,102 @@ static struct hwrng intel_rng = {
 };
 
 
+#ifdef CONFIG_SMP
+static volatile char __initdata waitflag;
+
+static void __init intel_init_wait (void *unused)
+{
+	while (waitflag)
+		cpu_relax();
+}
+#endif
+
 static int __init mod_init(void)
 {
 	int err = -ENODEV;
+	unsigned i;
+	struct pci_dev *dev = NULL;
 	void __iomem *mem;
-	u8 hw_status;
-
-	if (!pci_dev_present(pci_tbl))
+	unsigned long flags;
+	u8 bios_cntl_off, fwh_dec_en1_off;
+	u8 bios_cntl_val = 0xff, fwh_dec_en1_val = 0xff;
+	u8 hw_status, mfg, dvc;
+
+	for (i = 0; !dev && pci_tbl[i].vendor; ++i)
+		dev = pci_get_device(pci_tbl[i].vendor,
pci_tbl[i].device, NULL);
+		
+	if (!dev)
 		goto out; /* Device not found. */
 
+	/* Check for Intel 82802 */
+	if (dev->device < 0x2640) {
+		fwh_dec_en1_off = 0xe3;
+		bios_cntl_off = 0x4e;
+	}
+	else {
+		fwh_dec_en1_off = 0xd9; /* high byte of 16-bit register
*/
+		bios_cntl_off = 0xdc;
+	}
+
+	pci_read_config_byte(dev, fwh_dec_en1_off, &fwh_dec_en1_val);
+	pci_read_config_byte(dev, bios_cntl_off, &bios_cntl_val);
+
+	mem = ioremap_nocache(0xffff0000, 2);
+	if (mem == NULL) {
+		pci_dev_put(dev);
+		err = -EBUSY;
+		goto out;
+	}
+
+#ifdef CONFIG_SMP
+	waitflag = 1;
+	if (smp_call_function(intel_init_wait, NULL, 1, 0) != 0) {
+		waitflag = 0;
+		pci_dev_put(dev);
+		printk(KERN_ERR PFX "cannot run on all processors\n");
+		err = -EAGAIN;
+		goto err_unmap;
+	}
+#else
+#define waitflag err
+#endif
+	local_irq_save(flags);
+
+	if (!(fwh_dec_en1_val & 0x80))
+		pci_write_config_byte(dev, fwh_dec_en1_off,
fwh_dec_en1_val | 0x80);
+	if (!(bios_cntl_val & 0x03))
+		pci_write_config_byte(dev, bios_cntl_off, bios_cntl_val
| 0x01);
+
+	writeb(0xff, mem);
+	writeb(0x90, mem);
+	mfg = readb(mem + 0);
+	dvc = readb(mem + 1);
+	writeb(0xff, mem);
+
+	if (!(bios_cntl_val & 0x03))
+		pci_write_config_byte(dev, bios_cntl_off,
bios_cntl_val);
+	if (!(fwh_dec_en1_val & 0x80))
+		pci_write_config_byte(dev, fwh_dec_en1_off,
fwh_dec_en1_val);
+
+	local_irq_restore(flags);
+	waitflag = 0;
+
+	iounmap(mem);
+	pci_dev_put(dev);
+
+	if (mfg != 0x89 || (dvc & ~0x01) != 0xac) {
+		printk(KERN_ERR PFX "FWH not detected\n");
+		err = -ENODEV;
+		goto out;
+	}
+
 	err = -ENOMEM;
 	mem = ioremap(INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
 	if (!mem)
 		goto out;
 	intel_rng.priv = (unsigned long)mem;
 
-	/* Check for Intel 82802 */
+	/* Check for Random Number Generator */
 	err = -ENODEV;
 	hw_status = hwstatus_get(mem);
 	if ((hw_status & INTEL_RNG_PRESENT) == 0)


