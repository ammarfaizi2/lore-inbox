Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946571AbWKAFuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946571AbWKAFuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946540AbWKAFnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:43:51 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:15580 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946524AbWKAFne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:43:34 -0500
Message-Id: <20061101054343.623157000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:26 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jan Beulich <jbeulich@novell.com>,
       Metathronius Galabant <m.galabant@googlemail.com>,
       Michael Buesch <mb@bu3sch.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 46/61] fix Intel RNG detection
Content-Disposition: inline; filename=fix-intel-rng-detection.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jan Beulich <jbeulich@novell.com>

[PATCH] fix Intel RNG detection

Previously, since determination whether there was an Intel random number
generator was based on a single bit, on systems with a matching bridge
device but without a firmware hub, there was a 50% chance that the code
would incorrectly decide that the system had an RNG.  This patch adds
detection of the firmware hub to better qualify the existence of an RNG.

There is one issue with the patch: I was unable to determine the LPC
equivalent for the PCI bridge 8086:2430 (since the old code didn't care
about which of the many devices provided by the ICH/ESB it was chose to use
the PCI bridge device, but the FWH settings live in the LPC device, so the
device list needed to be changed).

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/char/hw_random/intel-rng.c |  186 +++++++++++++++++++++++++++++++++++--
 1 file changed, 177 insertions(+), 9 deletions(-)

--- linux-2.6.18.1.orig/drivers/char/hw_random/intel-rng.c
+++ linux-2.6.18.1/drivers/char/hw_random/intel-rng.c
@@ -50,6 +50,43 @@
 #define INTEL_RNG_ADDR_LEN			3
 
 /*
+ * LPC bridge PCI config space registers
+ */
+#define FWH_DEC_EN1_REG_OLD			0xe3
+#define FWH_DEC_EN1_REG_NEW			0xd9 /* high byte of 16-bit register */
+#define FWH_F8_EN_MASK				0x80
+
+#define BIOS_CNTL_REG_OLD			0x4e
+#define BIOS_CNTL_REG_NEW			0xdc
+#define BIOS_CNTL_WRITE_ENABLE_MASK		0x01
+#define BIOS_CNTL_LOCK_ENABLE_MASK		0x02
+
+/*
+ * Magic address at which Intel Firmware Hubs get accessed
+ */
+#define INTEL_FWH_ADDR				0xffff0000
+#define INTEL_FWH_ADDR_LEN			2
+
+/*
+ * Intel Firmware Hub command codes (write to any address inside the device)
+ */
+#define INTEL_FWH_RESET_CMD			0xff /* aka READ_ARRAY */
+#define INTEL_FWH_READ_ID_CMD			0x90
+
+/*
+ * Intel Firmware Hub Read ID command result addresses
+ */
+#define INTEL_FWH_MANUFACTURER_CODE_ADDRESS	0x000000
+#define INTEL_FWH_DEVICE_CODE_ADDRESS		0x000001
+
+/*
+ * Intel Firmware Hub Read ID command result values
+ */
+#define INTEL_FWH_MANUFACTURER_CODE		0x89
+#define INTEL_FWH_DEVICE_CODE_8M		0xac
+#define INTEL_FWH_DEVICE_CODE_4M		0xad
+
+/*
  * Data for PCI driver interface
  *
  * This data only exists for exporting the supported
@@ -58,12 +95,50 @@
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
+	{ 0x8086, 0x27bd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* GxM DH */
+/* BA, CA, DB, Ex, 6300, Fx, 631x/632x, Gx
+	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
+	{ 0x8086, 0x2440, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* BA */
+	{ 0x8086, 0x2480, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* CA */
+	{ 0x8086, 0x24c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* DB */
+	{ 0x8086, 0x24d0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* Ex */
+	{ 0x8086, 0x25a1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 6300 */
+	{ 0x8086, 0x2640, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* Fx */
+	{ 0x8086, 0x2670, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x2671, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x2672, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x2673, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x2674, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x2675, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x2676, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x2677, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x2678, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x2679, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x267a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x267b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x267c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x267d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x267e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x267f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* 631x/632x */
+	{ 0x8086, 0x27b8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* Gx */
+/* E
+	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, */
+	{ 0x8086, 0x2450, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, /* E  */
 	{ 0, },	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, pci_tbl);
@@ -138,22 +213,115 @@ static struct hwrng intel_rng = {
 };
 
 
+#ifdef CONFIG_SMP
+static char __initdata waitflag;
+
+static void __init intel_init_wait(void *unused)
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
+	unsigned long flags;
+	u8 bios_cntl_off, fwh_dec_en1_off;
+	u8 bios_cntl_val = 0xff, fwh_dec_en1_val = 0xff;
+	u8 hw_status, mfc, dvc;
+
+	for (i = 0; !dev && pci_tbl[i].vendor; ++i)
+		dev = pci_get_device(pci_tbl[i].vendor, pci_tbl[i].device, NULL);
 
-	if (!pci_dev_present(pci_tbl))
+	if (!dev)
 		goto out; /* Device not found. */
 
+	/* Check for Intel 82802 */
+	if (dev->device < 0x2640) {
+		fwh_dec_en1_off = FWH_DEC_EN1_REG_OLD;
+		bios_cntl_off = BIOS_CNTL_REG_OLD;
+	} else {
+		fwh_dec_en1_off = FWH_DEC_EN1_REG_NEW;
+		bios_cntl_off = BIOS_CNTL_REG_NEW;
+	}
+
+	pci_read_config_byte(dev, fwh_dec_en1_off, &fwh_dec_en1_val);
+	pci_read_config_byte(dev, bios_cntl_off, &bios_cntl_val);
+
+	mem = ioremap_nocache(INTEL_FWH_ADDR, INTEL_FWH_ADDR_LEN);
+	if (mem == NULL) {
+		pci_dev_put(dev);
+		err = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * Since the BIOS code/data is going to disappear from its normal
+	 * location with the Read ID command, all activity on the system
+	 * must be stopped until the state is back to normal.
+	 */
+#ifdef CONFIG_SMP
+	set_mb(waitflag, 1);
+	if (smp_call_function(intel_init_wait, NULL, 1, 0) != 0) {
+		set_mb(waitflag, 0);
+		pci_dev_put(dev);
+		printk(KERN_ERR PFX "cannot run on all processors\n");
+		err = -EAGAIN;
+		goto err_unmap;
+	}
+#endif
+	local_irq_save(flags);
+
+	if (!(fwh_dec_en1_val & FWH_F8_EN_MASK))
+		pci_write_config_byte(dev,
+		                      fwh_dec_en1_off,
+		                      fwh_dec_en1_val | FWH_F8_EN_MASK);
+	if (!(bios_cntl_val &
+	      (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK)))
+		pci_write_config_byte(dev,
+		                      bios_cntl_off,
+		                      bios_cntl_val | BIOS_CNTL_WRITE_ENABLE_MASK);
+
+	writeb(INTEL_FWH_RESET_CMD, mem);
+	writeb(INTEL_FWH_READ_ID_CMD, mem);
+	mfc = readb(mem + INTEL_FWH_MANUFACTURER_CODE_ADDRESS);
+	dvc = readb(mem + INTEL_FWH_DEVICE_CODE_ADDRESS);
+	writeb(INTEL_FWH_RESET_CMD, mem);
+
+	if (!(bios_cntl_val &
+	      (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK)))
+		pci_write_config_byte(dev, bios_cntl_off, bios_cntl_val);
+	if (!(fwh_dec_en1_val & FWH_F8_EN_MASK))
+		pci_write_config_byte(dev, fwh_dec_en1_off, fwh_dec_en1_val);
+
+	local_irq_restore(flags);
+#ifdef CONFIG_SMP
+	/* Tell other CPUs to resume. */
+	set_mb(waitflag, 0);
+#endif
+
+	iounmap(mem);
+	pci_dev_put(dev);
+
+	if (mfc != INTEL_FWH_MANUFACTURER_CODE ||
+	    (dvc != INTEL_FWH_DEVICE_CODE_8M &&
+	     dvc != INTEL_FWH_DEVICE_CODE_4M)) {
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

--
