Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbULIPdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbULIPdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbULIPdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:33:13 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:3047 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261536AbULIPZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:25:12 -0500
Date: Thu, 9 Dec 2004 09:25:04 -0600 (CST)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, sailer@watson.ibm.com, leendert@watson.ibm.com,
       emilyr@us.ibm.com, toml@us.ibm.com, tpmdd-devel@lists.sourceforge.net
Subject: [PATCH 1/1] driver: Tpm hardware enablement 
Message-ID: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a device driver to enable new hardware.  The new hardware is
the TPM chip as described by specifications at trustedcomputinggroup.org.
The TPM chip will enable you to use hardware to securely store and protect
your keys and personal data.  To use the chip according to the 
specification, you will need the Trusted Software Stack (TSS) of which an 
implementation for Linux is available at: 
http://sourceforge.net/projects/trousers.

Thanks,
Kylene

Signed-off-by: Leendert van Doorn <leendert@watson.ibm.com>
Signed-off-by: Reiner Sailer <sailer@watson.ibm.com>
Signed-off-by: Dave Safford <safford@watson.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.9/drivers/char/Kconfig linux-2.6.9-tpm/drivers/char/Kconfig
--- linux-2.6.9/drivers/char/Kconfig	2004-10-18 16:53:07.000000000 -0500
+++ linux-2.6.9-tpm/drivers/char/Kconfig	2004-12-08 10:45:10.000000000 -0600
@@ -989,5 +989,20 @@ config MMTIMER
 	  The mmtimer device allows direct userspace access to the
 	  Altix system timer.
 
+config TCG_TPM
+	tristate "TPM Hardware Support"
+	depends on EXPERIMENTAL
+	---help---
+	  If you have a TPM security chip in your system, which
+	  implements the Trusted Computing Group's specification,
+	  say Yes and it will be accessible from within Linux. To 
+	  compile this driver as a module, choose M here; the module 
+	  will be called tpm. For more information see 
+	  www.trustedcomputinggroup.org. A implementation of the 
+	  Trusted Software Stack (TSS), the userspace enablement piece 
+	  of the specification, can be obtained at 
+	  http://sourceforge.net/projects/trousers
+	  If unsure, say N.
+
 endmenu
 
diff -uprN linux-2.6.9/drivers/char/Makefile linux-2.6.9-tpm/drivers/char/Makefile
--- linux-2.6.9/drivers/char/Makefile	2004-10-18 16:55:28.000000000 -0500
+++ linux-2.6.9-tpm/drivers/char/Makefile	2004-11-22 17:33:17.000000000 -0600
@@ -88,6 +88,7 @@ obj-$(CONFIG_PCMCIA) += pcmcia/
 obj-$(CONFIG_IPMI_HANDLER) += ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
+obj-$(CONFIG_TCG_TPM) += tpm.o
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
diff -uprN linux-2.6.9/drivers/char/tpm.c linux-2.6.9-tpm/drivers/char/tpm.c
--- linux-2.6.9/drivers/char/tpm.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9-tpm/drivers/char/tpm.c	2004-12-07 12:54:49.000000000 -0600
@@ -0,0 +1,964 @@
+/*
+ * Copyright (C) 2004 IBM Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd_devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org	 
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ * 
+ * Note, the ATMEL chip is not interrupt driven (only polling)
+ * and can have very long timeouts (minutes!). Hence the unusual
+ * calls to schedule.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/poll.h>
+#include <linux/spinlock.h>
+#include <linux/miscdevice.h>
+
+#define	TPM_MINOR			224	/* officially assigned */
+
+#define	TPM_BUFSIZE			2048
+
+/* PCI configuration addresses */
+#define	PCI_GEN_PMCON_1			0xA0
+#define	PCI_GEN1_DEC			0xE4
+#define	PCI_LPC_EN			0xE6
+#define	PCI_GEN2_DEC			0xEC
+
+/* TPM addresses */
+#define	TPM_ADDR			0x4E
+#define	TPM_DATA			0x4F
+
+/* National definitions */
+#define	TPM_NSC_BASE			0x360
+#define	TPM_NSC_IRQ			0x07
+
+#define	NSC_LDN_INDEX			0x07
+#define	NSC_SID_INDEX			0x20
+#define	NSC_LDC_INDEX			0x30
+#define	NSC_DIO_INDEX			0x60
+#define	NSC_CIO_INDEX			0x62
+#define	NSC_IRQ_INDEX			0x70
+#define	NSC_ITS_INDEX			0x71
+
+#define	NSC_STATUS			0x01
+#define	NSC_COMMAND			0x01
+#define	NSC_DATA			0x00
+
+/* status bits */
+#define	NSC_STATUS_OBF			0x01	/* output buffer full */
+#define	NSC_STATUS_IBF			0x02	/* input buffer full */
+#define	NSC_STATUS_F0			0x04	/* F0 */
+#define	NSC_STATUS_A2			0x08	/* A2 */
+#define	NSC_STATUS_RDY			0x10	/* ready to receive command */
+#define	NSC_STATUS_IBR			0x20	/* ready to receive data */
+
+/* command bits */
+#define	NSC_COMMAND_NORMAL		0x01	/* normal mode */
+#define	NSC_COMMAND_BURST		0x81	/* burst mode */
+#define	NSC_COMMAND_EOC			0x03
+#define	NSC_COMMAND_CANCEL		0x22
+
+/* Atmel definitions */
+#define	TPM_ATML_BASE			0x400
+
+/* write status bits */
+#define	ATML_STATUS_ABORT		0x01
+#define	ATML_STATUS_LASTBYTE		0x04
+
+/* read status bits */
+#define	ATML_STATUS_BUSY		0x01
+#define	ATML_STATUS_DATA_AVAIL		0x02
+#define	ATML_STATUS_REWRITE		0x04
+
+struct tpm_chip {
+	struct pci_dev *pci_dev;	/* PCI device stuff */
+	u16 base;		/* TPM base address */
+	u16 irq;		/* TPM irq address */
+
+	u8 *userspace_buffer;
+	atomic_t data_pending;
+	int num_opens;
+	struct timer_list user_read_timer;
+	struct timer_list tpm_timer;
+	struct semaphore user_mutex;
+	struct semaphore timer_mutex;
+	int tpm_time_expired;
+	struct list_head list;
+	struct miscdevice miscdev;
+
+	u8 req_complete_mask;
+	u8 req_complete_val;
+
+	int (*recv) (struct tpm_chip *, u8 *, size_t);
+	int (*send) (struct tpm_chip *, u8 *, size_t);
+	void (*cancel) (struct tpm_chip *);
+};
+
+static struct list_head tpm_chip_list;
+static spinlock_t driver_lock;
+static int dev_cnt;
+
+static void user_reader_timeout(unsigned long ptr)
+{
+	struct tpm_chip *chip = (struct tpm_chip *) ptr;
+
+	if (down_trylock(&chip->timer_mutex) == 0) {
+		atomic_set(&chip->data_pending, 0);
+		memset(chip->userspace_buffer, 0, TPM_BUFSIZE);
+		up(&chip->user_mutex);
+		up(&chip->timer_mutex);
+	}
+}
+
+static void tpm_time_expired(unsigned long ptr)
+{
+	int *exp = (int *) ptr;
+	*exp = 1;
+}
+
+static int rdx(int index)
+{
+	outb(index, TPM_ADDR);
+	return inb(TPM_DATA) & 0xFF;
+}
+
+static void wrx(int index, int value)
+{
+	outb(index, TPM_ADDR);
+	outb(value & 0xFF, TPM_DATA);
+}
+
+/*
+ * Initialize the LPC bus and enable the TPM ports
+ */
+static int lpc_bus_init(struct tpm_chip *chip)
+{
+	struct pci_dev *pci_dev = chip->pci_dev;
+	u32 lpcenable, tmp;
+	int is_lpcm = 0;
+
+	switch (pci_dev->vendor) {
+	case PCI_VENDOR_ID_INTEL:
+		switch (pci_dev->device) {
+		case PCI_DEVICE_ID_INTEL_82801CA_12:
+		case PCI_DEVICE_ID_INTEL_82801DB_12:
+			is_lpcm = 1;
+			break;
+		}
+		/* init ICH (enable LPC) */
+		pci_read_config_dword(pci_dev, PCI_GEN1_DEC, &lpcenable);
+		lpcenable |= 0x20000000;
+		pci_write_config_dword(pci_dev, PCI_GEN1_DEC, lpcenable);
+
+		if (is_lpcm) {
+			pci_read_config_dword(pci_dev,
+					      PCI_GEN1_DEC, &lpcenable);
+			if ((lpcenable & 0x20000000) == 0) {
+				dev_err(&chip->pci_dev->dev,
+					"cannot enable LPC\n");
+				return -ENODEV;
+			}
+		}
+
+		/* initialize TPM registers */
+		pci_read_config_dword(pci_dev, PCI_GEN2_DEC, &tmp);
+
+		if (!is_lpcm)
+			tmp = (tmp & 0xFFFF0000) | (chip->base & 0xFFF0);
+		else
+			tmp = (tmp & 0xFFFF0000) |
+			    (chip->base & 0xFFF0) | 0x00000001;
+
+		pci_write_config_dword(pci_dev, PCI_GEN2_DEC, tmp);
+
+		if (is_lpcm) {
+			pci_read_config_dword(pci_dev, PCI_GEN_PMCON_1,
+					      &tmp);
+			tmp |= 0x00000004;	/* enable CLKRUN */
+			pci_write_config_dword(pci_dev, PCI_GEN_PMCON_1,
+					       tmp);
+		}
+		outb(0x0D, TPM_ADDR);	/* unlock 4F */
+		outb(0x55, TPM_DATA);
+		outb(0x0A, TPM_ADDR);	/* int disable */
+		outb(0x00, TPM_DATA);
+		outb(0x08, TPM_ADDR);	/* base addr lo */
+		outb(chip->base & 0xFF, TPM_DATA);
+		outb(0x09, TPM_ADDR);	/* base addr hi */
+		outb((chip->base & 0xFF00) >> 8, TPM_DATA);
+		outb(0x0D, TPM_ADDR);	/* lock 4F */
+		outb(0xAA, TPM_DATA);
+		break;
+	case PCI_VENDOR_ID_AMD:
+		/* nothing yet */
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * Wait for a certain status to appear
+ */
+static int wait_for_stat(struct tpm_chip *chip, u8 mask, u8 val, u8 * data)
+{
+	int expired = 0;
+	struct timer_list status_timer =
+	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 10 * HZ,
+			      (unsigned long) &expired);
+
+	/* status immediately available check */
+	*data = inb(chip->base + 1);
+	if ((*data & mask) == val)
+		return 0;
+
+	/* wait for status */
+	add_timer(&status_timer);
+	do {
+		schedule();
+		*data = inb(chip->base + 1);
+		if ((*data & mask) == val) {
+			del_singleshot_timer_sync(&status_timer);
+			return 0;
+		}
+	} while (!expired);
+
+	return -EBUSY;
+}
+
+/*
+ * National (safekeeper) specific code
+ */
+static int tpm_nsc_init(struct tpm_chip *chip)
+{
+	chip->irq = TPM_NSC_IRQ;
+	chip->base = TPM_NSC_BASE;
+
+	if (lpc_bus_init(chip))
+		return -ENODEV;
+
+	/* verify that it is a National part (SID) */
+	if (rdx(NSC_SID_INDEX) != 0xEF) {
+		return -ENODEV;
+	}
+
+	dev_dbg(&chip->pci_dev->dev, "NSC TPM detected\n");
+	dev_dbg(&chip->pci_dev->dev,
+		"NSC LDN 0x%x, SID 0x%x, SRID 0x%x\n", rdx(0x07),
+		rdx(0x20), rdx(0x27));
+	dev_dbg(&chip->pci_dev->dev,
+		"NSC SIOCF1 0x%x SIOCF5 0x%x SIOCF6 0x%x SIOCF8 0x%x\n",
+		rdx(0x21), rdx(0x25), rdx(0x26), rdx(0x28));
+	dev_dbg(&chip->pci_dev->dev, "NSC IO Base0 0x%x\n",
+		(rdx(0x60) << 8) | rdx(0x61));
+	dev_dbg(&chip->pci_dev->dev, "NSC IO Base1 0x%x\n",
+		(rdx(0x62) << 8) | rdx(0x63));
+	dev_dbg(&chip->pci_dev->dev,
+		"NSC Interrupt number and wakeup 0x%x\n", rdx(0x70));
+	dev_dbg(&chip->pci_dev->dev, "NSC IRQ type select 0x%x\n",
+		rdx(0x71));
+	dev_dbg(&chip->pci_dev->dev,
+		"NSC DMA channel select0 0x%x, select1 0x%x\n", rdx(0x74),
+		rdx(0x75));
+	dev_dbg(&chip->pci_dev->dev,
+		"NSC Config "
+		"0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+		rdx(0xF0), rdx(0xF1), rdx(0xF2), rdx(0xF3), rdx(0xF4),
+		rdx(0xF5), rdx(0xF6), rdx(0xF7), rdx(0xF8), rdx(0xF9));
+
+	dev_info(&chip->pci_dev->dev,
+		 "NSC PC21100 TPM revision %d\n", rdx(0x27) & 0x1F);
+
+	if (rdx(NSC_LDC_INDEX) == 0)
+		dev_info(&chip->pci_dev->dev, ": NSC TPM not active\n");
+
+	/* select PM channel 1 */
+	wrx(NSC_LDN_INDEX, 0x12);
+	rdx(NSC_LDN_INDEX);
+
+	/* disable the DPM module */
+	wrx(NSC_LDC_INDEX, 0);
+	rdx(NSC_LDC_INDEX);
+
+	/* set the data register base addresses */
+	wrx(NSC_DIO_INDEX, chip->base >> 8);
+	wrx(NSC_DIO_INDEX + 1, chip->base);
+	rdx(NSC_DIO_INDEX);
+	rdx(NSC_DIO_INDEX + 1);
+
+	/* set the command register base addresses */
+	wrx(NSC_CIO_INDEX, (chip->base + 1) >> 8);
+	wrx(NSC_CIO_INDEX + 1, (chip->base + 1));
+	rdx(NSC_DIO_INDEX);
+	rdx(NSC_DIO_INDEX + 1);
+
+	/* set the interrupt number to be used for the host interface */
+	wrx(NSC_IRQ_INDEX, chip->irq);
+	wrx(NSC_ITS_INDEX, 0x00);
+	rdx(NSC_IRQ_INDEX);
+
+	/* enable the DPM module */
+	wrx(NSC_LDC_INDEX, 0x01);
+	rdx(NSC_LDC_INDEX);
+
+	return 0;
+}
+
+static int nsc_wait_for_ready(struct tpm_chip *chip)
+{
+	int status;
+	int expired = 0;
+	struct timer_list status_timer =
+	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 100,
+			      (unsigned long) &expired);
+
+	/* status immediately available check */
+	status = inb(chip->base + NSC_STATUS);
+	if (status & NSC_STATUS_OBF)
+		status = inb(chip->base + NSC_DATA);
+	if (status & NSC_STATUS_RDY)
+		return 0;
+
+	/* wait for status */
+	add_timer(&status_timer);
+	do {
+		schedule();
+		status = inb(chip->base + NSC_STATUS);
+		if (status & NSC_STATUS_OBF)
+			status = inb(chip->base + NSC_DATA);
+		if (status & NSC_STATUS_RDY) {
+			del_singleshot_timer_sync(&status_timer);
+			return 0;
+		}
+	} while (!expired);
+
+	dev_info(&chip->pci_dev->dev, "wait for ready failed\n");
+	return -EBUSY;
+}
+
+static int tpm_nsc_recv(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	u8 *buffer = buf;
+	u8 data, *p;
+	u32 size;
+	__be32 *native_size;
+
+	if (count < 6)
+		return -EIO;
+
+	if (wait_for_stat(chip, NSC_STATUS_F0, NSC_STATUS_F0, &data) < 0) {
+		dev_err(&chip->pci_dev->dev, "F0 timeout\n");
+		return -EIO;
+	}
+	if ((data = inb(chip->base + NSC_DATA)) != NSC_COMMAND_NORMAL) {
+		dev_err(&chip->pci_dev->dev,
+			"not in normal mode (0x%x)\n", data);
+		return -EIO;
+	}
+
+	/* read the whole packet */
+	for (p = buffer; p < &buffer[count]; p++) {
+		if (wait_for_stat(chip, NSC_STATUS_OBF,
+				  NSC_STATUS_OBF, &data) < 0) {
+			dev_err(&chip->pci_dev->dev,
+				"OBF timeout (while reading data)\n");
+			return -EIO;
+		}
+		if (data & NSC_STATUS_F0)
+			break;
+		*p = inb(chip->base + NSC_DATA);
+	}
+
+	if ((data & NSC_STATUS_F0) == 0) {
+		dev_err(&chip->pci_dev->dev, "F0 not set\n");
+		return -EIO;
+	}
+	if ((data = inb(chip->base + NSC_DATA)) != NSC_COMMAND_EOC) {
+		dev_err(&chip->pci_dev->dev,
+			"expected end of command(0x%x)\n", data);
+		return -EIO;
+	}
+
+	native_size = (__force __be32 *) (buf + 2);
+	size = be32_to_cpu(*native_size);
+
+	if (count < size)
+		return -EIO;
+
+	return size;
+}
+
+static int tpm_nsc_send(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	u8 data;
+	int i;
+
+	/*
+	 * If we hit the chip with back to back commands it locks up
+	 * and never set IBF. Hitting it with this "hammer" seems to
+	 * fix it. Not sure why this is needed, we followed the flow
+	 * chart in the manual to the letter.
+	 */
+	outb(NSC_COMMAND_CANCEL, chip->base + NSC_COMMAND);
+
+	if (nsc_wait_for_ready(chip) != 0)
+		return -EIO;
+
+	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
+		dev_err(&chip->pci_dev->dev, "IBF timeout\n");
+		return -EIO;
+	}
+
+	outb(NSC_COMMAND_NORMAL, chip->base + NSC_COMMAND);
+	if (wait_for_stat(chip, NSC_STATUS_IBR, NSC_STATUS_IBR, &data) < 0) {
+		dev_err(&chip->pci_dev->dev, "IBR timeout\n");
+		return -EIO;
+	}
+
+	for (i = 0; i < count; i++) {
+		if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
+			dev_err(&chip->pci_dev->dev,
+				"IBF timeout (while writing data)\n");
+			return -EIO;
+		}
+		outb(buf[i], chip->base + NSC_DATA);
+	}
+
+	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
+		dev_err(&chip->pci_dev->dev, "IBF timeout\n");
+		return -EIO;
+	}
+	outb(NSC_COMMAND_EOC, chip->base + NSC_COMMAND);
+
+	return count;
+}
+
+static void tpm_nsc_cancel(struct tpm_chip *chip)
+{
+	outb(NSC_COMMAND_CANCEL, chip->base + NSC_COMMAND);
+}
+
+/*
+ * Atmel specific code
+ */
+static int tpm_atml_init(struct tpm_chip *chip)
+{
+	u8 version[4];
+
+	chip->irq = 0;
+	chip->base = TPM_ATML_BASE;
+
+	if (lpc_bus_init(chip))
+		return -ENODEV;
+
+	/* verify that it is an Atmel part */
+	if (rdx(4) != 'A' || rdx(5) != 'T' || rdx(6) != 'M'
+	    || rdx(7) != 'L') {
+		return -ENODEV;
+	}
+
+	/* query chip for its version number */
+	if ((version[0] = rdx(0x00)) != 0xFF) {
+		version[1] = rdx(0x01);
+		version[2] = rdx(0x02);
+		version[3] = rdx(0x03);
+	} else {
+		dev_info(&chip->pci_dev->dev, "version query failed\n");
+		return -ENODEV;
+	}
+
+	dev_info(&chip->pci_dev->dev,
+		 "Atmel TPM version %d.%d.%d.%d\n", version[0], version[1],
+		 version[2], version[3]);
+
+	return 0;
+}
+
+static int tpm_atml_recv(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	u8 status, *hdr = buf;
+	u32 size;
+	int i;
+	__be32 *native_size;
+
+	/* start reading header */
+	if (count < 6)
+		return -EIO;
+
+	for (i = 0; i < 6; i++) {
+		status = inb(chip->base + 1);
+		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
+			dev_err(&chip->pci_dev->dev,
+				"error reading header\n");
+			return -EIO;
+		}
+		*buf++ = inb(chip->base);
+	}
+
+	/* size of the data received */
+	native_size = (__force __be32 *) (hdr + 2);
+	size = be32_to_cpu(*native_size);
+
+	if (count < size)
+		return -EIO;
+
+	/* read all the data available */
+	for (; i < size; i++) {
+		status = inb(chip->base + 1);
+		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
+			dev_err(&chip->pci_dev->dev,
+				"error reading data\n");
+			return -EIO;
+		}
+		*buf++ = inb(chip->base);
+	}
+
+	/* make sure data available is gone */
+	status = inb(chip->base + 1);
+	if (status & ATML_STATUS_DATA_AVAIL) {
+		dev_err(&chip->pci_dev->dev, "data available is stuck\n");
+		return -EIO;
+	}
+
+	return size;
+}
+
+static int tpm_atml_send(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	int i;
+
+	dev_dbg(&chip->pci_dev->dev, "tpm_atml_send: ");
+	for (i = 0; i < count; i++)
+		dev_dbg(&chip->pci_dev->dev, "0x%x(%d) ", buf[i], buf[i]);
+
+	for (i = 0; i < count; i++)
+		outb(buf[i], chip->base);
+
+	return count;
+}
+
+static void tpm_atml_cancel(struct tpm_chip *chip)
+{
+	outb(ATML_STATUS_ABORT, chip->base + 1);
+}
+
+/*
+ * Internal kernel interface to transmit TPM commands
+ */
+static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
+			    size_t bufsiz)
+{
+	ssize_t len;
+	u32 count;
+	__be32 *native_size;
+
+	native_size = (__force __be32 *) (buf + 2);
+	count = be32_to_cpu(*native_size);
+
+	if (count == 0)
+		return -ENODATA;
+	if (count > bufsiz) {
+		dev_err(&chip->pci_dev->dev,
+			"invalid count value %x %x \n", count, bufsiz);
+		return -E2BIG;
+	}
+
+	if ((len = chip->send(chip, (u8 *) buf, count)) < 0) {
+		dev_err(&chip->pci_dev->dev,
+			"tpm_transmit: tpm_send: error %d\n", len);
+		return len;
+	}
+
+	chip->tpm_time_expired = 0;
+	init_timer(&chip->tpm_timer);
+	chip->tpm_timer.function = tpm_time_expired;
+	chip->tpm_timer.expires = jiffies + 2 * 60 * HZ;
+	chip->tpm_timer.data = (unsigned long) &chip->tpm_time_expired;
+	add_timer(&chip->tpm_timer);
+
+	while (!chip->tpm_time_expired) {
+		u8 status = inb(chip->base + 1);
+		if ((status & chip->req_complete_mask) ==
+		    chip->req_complete_val) {
+			del_singleshot_timer_sync(&chip->tpm_timer);
+			break;
+		}
+		schedule();
+	}
+
+	if (!chip->tpm_time_expired)
+		len = chip->recv(chip, (u8 *) buf, bufsiz);
+	else {
+		chip->cancel(chip);
+		len = -EIO;
+		dev_err(&chip->pci_dev->dev, "Time expired\n");
+	}
+	if (len < 0)
+		dev_err(&chip->pci_dev->dev,
+			"tpm_transmit: tpm_recv: error %d\n", len);
+
+	return len;
+}
+
+/*
+ * Device file system interface to the TPM
+ */
+static int tpm_open(struct inode *inode, struct file *file)
+{
+	int rc = 0, minor = iminor(inode);
+	struct tpm_chip *chip = NULL, *pos;
+
+	spin_lock(&driver_lock);
+
+	list_for_each_entry(pos, &tpm_chip_list, list) {
+		if (pos->miscdev.minor == minor) {
+			chip = pos;
+			break;
+		}
+	}
+	if (chip == NULL) {
+		rc = -ENODEV;
+		goto err_out;
+	}
+
+	if (chip->num_opens) {
+		dev_dbg(&chip->pci_dev->dev,
+			"Another process owns this TPM\n");
+		rc = -EBUSY;
+		goto err_out;
+	}
+
+	chip->num_opens++;
+	pci_dev_get(chip->pci_dev);
+
+	spin_unlock(&driver_lock);
+
+	chip->userspace_buffer =
+	    kmalloc(TPM_BUFSIZE * sizeof(u8), GFP_KERNEL);
+	if (chip->userspace_buffer == NULL) {
+		chip->num_opens--;
+		pci_dev_put(chip->pci_dev);
+		return -ENOMEM;
+	}
+
+	atomic_set(&chip->data_pending, 0);
+
+	file->private_data = chip;
+	return 0;
+
+err_out:
+	spin_unlock(&driver_lock);
+	return rc;
+}
+
+static int tpm_release(struct inode *inode, struct file *file)
+{
+	struct tpm_chip *chip = file->private_data;
+
+	if (chip == NULL)
+		return -ENODEV;
+
+	spin_lock(&driver_lock);
+	chip->num_opens--;
+	if (chip->num_opens == 0) {
+		kfree(chip->userspace_buffer);
+		atomic_set(&chip->data_pending, 0);
+	}
+
+	pci_dev_put(chip->pci_dev);
+	file->private_data = NULL;
+	spin_unlock(&driver_lock);
+	return 0;
+}
+
+static ssize_t tpm_write(struct file *file, const char __user * buf,
+			 size_t size, loff_t * off)
+{
+	struct tpm_chip *chip = file->private_data;
+	int out_size;
+
+	if (chip == NULL)
+		return -ENODEV;
+
+	down(&chip->user_mutex);
+
+	if (copy_from_user(chip->userspace_buffer,
+			   (void __user *) buf, size)) {
+		up(&chip->user_mutex);
+		return -EFAULT;
+	}
+	out_size = tpm_transmit(chip, chip->userspace_buffer, TPM_BUFSIZE);
+
+	init_timer(&chip->user_read_timer);
+	chip->user_read_timer.function = user_reader_timeout;
+	chip->user_read_timer.data = (unsigned long) chip;
+	chip->user_read_timer.expires = jiffies + (60 * HZ);
+	add_timer(&chip->user_read_timer);
+
+	atomic_set(&chip->data_pending, out_size);
+
+	return size;
+}
+
+static ssize_t tpm_read(struct file *file, char __user * buf,
+			size_t size, loff_t * off)
+{
+	struct tpm_chip *chip = file->private_data;
+	int write_size;
+
+	if (chip == NULL)
+		return -ENODEV;
+
+	if (down_trylock(&chip->timer_mutex) != 0) {
+		dev_err(&chip->pci_dev->dev, "Timeout occured\n");
+		return -ETIME;
+	}
+
+	write_size = atomic_read(&chip->data_pending);
+	atomic_set(&chip->data_pending, 0);
+
+	if (write_size == 0) {
+		dev_err(&chip->pci_dev->dev, "No data pending\n");
+		up(&chip->timer_mutex);
+		return -ENODATA;
+	}
+
+	del_singleshot_timer_sync(&chip->user_read_timer);
+	up(&chip->timer_mutex);
+
+	if (write_size < 0)
+		goto out;
+
+	if (size < write_size)
+		write_size = size;
+
+	if (copy_to_user((void __user *) buf,
+			 chip->userspace_buffer, write_size)) {
+		write_size = -EFAULT;
+		goto out;
+	}
+
+out:
+	up(&chip->user_mutex);
+	return write_size;
+}
+
+static struct file_operations tpm_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.open = tpm_open,
+	.read = tpm_read,
+	.write = tpm_write,
+	.release = tpm_release,
+};
+
+static int __devinit tpm_probe(struct pci_dev *pci_dev,
+			       const struct pci_device_id *pci_id)
+{
+	char *devname = "tpm ";
+	int rc = 0;
+	struct tpm_chip *chip;
+
+	if (pci_enable_device(pci_dev))
+		return -EIO;
+
+	/* Driver specific per-device data */
+	chip = kmalloc(sizeof(*chip), GFP_KERNEL);
+	if (chip == NULL) {
+		rc = -ENOMEM;
+		goto out_disable;
+	}
+	memset(chip, 0, sizeof(struct tpm_chip));
+
+	init_MUTEX(&chip->user_mutex);
+	init_MUTEX(&chip->timer_mutex);
+	INIT_LIST_HEAD(&chip->list);
+
+	if (dev_cnt == 0)
+		chip->miscdev.minor = TPM_MINOR;
+	else
+		chip->miscdev.minor = MISC_DYNAMIC_MINOR;
+
+	devname[3] = (u8) (dev_cnt + '0');
+	chip->miscdev.name = devname;
+
+	chip->miscdev.dev = &(pci_dev->dev);
+	chip->miscdev.fops = &tpm_fops;
+	chip->pci_dev = pci_dev_get(pci_dev);
+
+	spin_lock(&driver_lock);
+
+	/* Determine chip type */
+	if (tpm_nsc_init(chip) == 0) {
+		chip->recv = tpm_nsc_recv;
+		chip->send = tpm_nsc_send;
+		chip->cancel = tpm_nsc_cancel;
+		chip->req_complete_mask = NSC_STATUS_OBF;
+		chip->req_complete_val = NSC_STATUS_OBF;
+	} else if (tpm_atml_init(chip) == 0) {
+		chip->recv = tpm_atml_recv;
+		chip->send = tpm_atml_send;
+		chip->cancel = tpm_atml_cancel;
+		chip->req_complete_mask =
+		    ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL;
+		chip->req_complete_val = ATML_STATUS_DATA_AVAIL;
+	} else {
+		rc = -ENODEV;
+		goto out_release;
+	}
+
+	if (misc_register(&chip->miscdev)) {
+		dev_err(&chip->pci_dev->dev,
+			"unable to misc_register %s, minor %d\n",
+			chip->miscdev.name, chip->miscdev.minor);
+		rc = -ENODEV;
+		goto out_release;
+	}
+
+	pci_set_drvdata(pci_dev, chip);
+
+	list_add(&chip->list, &tpm_chip_list);
+	spin_unlock(&driver_lock);
+
+	dev_cnt++;
+	return 0;
+
+	/* Error path */
+out_release:
+	spin_unlock(&driver_lock);
+	pci_dev_put(pci_dev);
+	kfree(chip);
+out_disable:
+	pci_disable_device(pci_dev);
+	return rc;
+}
+
+static void __devexit tpm_remove(struct pci_dev *pci_dev)
+{
+	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+
+	if (chip == NULL) {
+		dev_err(&pci_dev->dev, "No device data found\n");
+		return;
+	}
+
+	spin_lock(&driver_lock);
+
+	if (chip->num_opens != 0) {
+		dev_err(&chip->pci_dev->dev,
+			"Device still open (%d times) in userspace\n",
+			chip->num_opens);
+		spin_unlock(&driver_lock);
+		return;
+	}
+
+	list_del(&chip->list);
+
+	pci_set_drvdata(pci_dev, NULL);
+
+	misc_deregister(&chip->miscdev);
+	spin_unlock(&driver_lock);
+
+	pci_disable_device(pci_dev);
+
+	kfree(chip);
+	dev_cnt--;
+
+	pci_dev_put(pci_dev);
+}
+
+static u8 savestate[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 10,		/* blob length (in bytes) */
+	0, 0, 0, 152		/* TPM_ORD_SaveState */
+};
+
+/*
+ * We are about to suspend. Save the TPM state
+ * so that it can be restored.
+ */
+static int tpm_pm_suspend(struct pci_dev *pci_dev, u32 pm_state)
+{
+	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	chip->send(chip, savestate, sizeof(savestate));
+	return 0;
+}
+
+/*
+ * Resume from a power safe. The BIOS already restored
+ * the TPM state.
+ */
+static int tpm_pm_resume(struct pci_dev *pci_dev)
+{
+	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	spin_lock(&driver_lock);
+	lpc_bus_init(chip);
+	spin_unlock(&driver_lock);
+
+	return 0;
+}
+
+static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
+
+static struct pci_driver tpm_pci_driver = {
+	.name = "tpm",
+	.id_table = tpm_pci_tbl,
+	.probe = tpm_probe,
+	.remove = __devexit_p(tpm_remove),
+	.suspend = tpm_pm_suspend,
+	.resume = tpm_pm_resume,
+};
+
+static int __init init_tpm(void)
+{
+	INIT_LIST_HEAD(&tpm_chip_list);
+	spin_lock_init(&driver_lock);
+	return pci_register_driver(&tpm_pci_driver);
+}
+
+static void __exit cleanup_tpm(void)
+{
+	pci_unregister_driver(&tpm_pci_driver);
+}
+
+module_init(init_tpm);
+module_exit(cleanup_tpm);
+
+MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
+MODULE_DESCRIPTION("TPM Driver");
+MODULE_VERSION("2.0");
+MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9/include/linux/pci_ids.h linux-2.6.9-tpm/include/linux/pci_ids.h
--- linux-2.6.9/include/linux/pci_ids.h	2004-12-06 16:53:35.000000000 -0600
+++ linux-2.6.9-tpm/include/linux/pci_ids.h	2004-12-06 14:27:05.000000000 -0600
@@ -494,6 +494,7 @@
 #define PCI_DEVICE_ID_AMD_OPUS_7449	0x7449
 #	define PCI_DEVICE_ID_AMD_VIPER_7449	PCI_DEVICE_ID_AMD_OPUS_7449
 #define PCI_DEVICE_ID_AMD_8111_LAN	0x7462
+#define PCI_DEVICE_ID_AMD_8111_LPC	0x7468
 #define PCI_DEVICE_ID_AMD_8111_IDE	0x7469
 #define PCI_DEVICE_ID_AMD_8111_AUDIO	0x746d
 #define PCI_DEVICE_ID_AMD_8151_0	0x7454
diff -uprN linux-2.6.9/MAINTAINERS linux-2.6.9-tpm/MAINTAINERS
--- linux-2.6.9/MAINTAINERS	2004-10-18 16:54:37.000000000 -0500
+++ linux-2.6.9-tpm/MAINTAINERS	2004-12-07 12:39:10.000000000 -0600
@@ -2144,6 +2144,12 @@ L:	tlinux-users@tce.toshiba-dme.co.jp
 W:	http://www.buzzard.org.uk/toshiba/
 S:	Maintained
 
+TPM DRIVER
+P:	Kylene Hall
+M:	tpmdd-devel@lists.sourceforge.net
+L:	tpmdd-devel@lists.sourceforge.net
+S:	Maintained
+
 TRIDENT 4DWAVE/SIS 7018 PCI AUDIO CORE
 P:	Muli Ben-Yehuda
 M:	mulix@mulix.org
