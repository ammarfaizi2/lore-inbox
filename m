Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWEDXvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWEDXvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 19:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWEDXvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 19:51:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13492 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751485AbWEDXvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 19:51:41 -0400
Date: Thu, 4 May 2006 18:51:37 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, pfg@sgi.com, jeremy@sgi.com, jes@sgi.com
Subject: Re: [PATCH] SGI IOC4: Detect IO card variant
In-Reply-To: <20060503192626.1bc3af56.akpm@osdl.org>
Message-ID: <20060504183015.U88573@chenjesu.americas.sgi.com>
References: <20060503171758.H59683@chenjesu.americas.sgi.com>
 <20060503192626.1bc3af56.akpm@osdl.org>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are three different IO cards which an SGI IOC4 controller may find
itself on.  One of these variants does not bring out the IDE and serial
signals, so we need to disable attaching the corresponding IOC4 subdrivers
to such cards.

Cleans up message clutter emitted during device probing.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

---
If my prior patch to move PCI IDs from the qla1280 and sata_vsc drivers
to pci_ids.h is taken (2006-05-04, "Move various PCI IDs to header file"),
this should replace sgi-ioc4-detect-variant.patch in the -mm tree.

 drivers/ide/pci/sgiioc4.c    |    6 ++++
 drivers/serial/ioc4_serial.c |    9 ++++++
 drivers/sn/ioc4.c            |   64 +++++++++++++++++++++++++++++++++++++++---- include/linux/ioc4.h         |    5 +++
 4 files changed, 79 insertions(+), 5 deletions(-)
---
diff --git a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
index 43b96e2..2271f0e 100644
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -717,6 +717,12 @@ static ide_pci_device_t sgiioc4_chipsets
 int
 ioc4_ide_attach_one(struct ioc4_driver_data *idd)
 {
+	/* PCI-RT does not bring out IDE connection.
+	 * Do not attach to this particular IOC4.
+	 */
+	if (idd->idd_variant == IOC4_VARIANT_PCI_RT)
+		return 0;
+
 	return pci_init_sgiioc4(idd->idd_pdev,
 				&sgiioc4_chipsets[idd->idd_pci_id->driver_data]);
 }
diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
index c620209..717e47b 100644
--- a/drivers/serial/ioc4_serial.c
+++ b/drivers/serial/ioc4_serial.c
@@ -2646,7 +2646,10 @@ static int ioc4_serial_remove_one(struct
 	struct ioc4_port *port;
 	struct ioc4_soft *soft;
 
+	/* If serial driver did not attach, don't try to detach */
 	control = idd->idd_serial_data;
+	if (!control)
+		return 0;
 
 	for (port_num = 0; port_num < IOC4_NUM_SERIAL_PORTS; port_num++) {
 		for (port_type = UART_PORT_MIN;
@@ -2778,6 +2781,12 @@ ioc4_serial_attach_one(struct ioc4_drive
 	DPRINT_CONFIG(("%s (0x%p, 0x%p)\n", __FUNCTION__, idd->idd_pdev,
 							idd->idd_pci_id));
 
+	/* PCI-RT does not bring out serial connections.
+	 * Do not attach to this particular IOC4.
+	 */
+	if (idd->idd_variant == IOC4_VARIANT_PCI_RT)
+		return 0;
+
 	/* request serial registers */
 	tmp_addr1 = idd->idd_bar0 + IOC4_SERIAL_OFFSET;
 
diff --git a/drivers/sn/ioc4.c b/drivers/sn/ioc4.c
index cdeff90..40f9755 100644
--- a/drivers/sn/ioc4.c
+++ b/drivers/sn/ioc4.c
@@ -160,9 +160,6 @@ ioc4_clock_calibrate(struct ioc4_driver_
 	writel(0, &idd->idd_misc_regs->int_out.raw);
 	mmiowb();
 
-	printk(KERN_INFO
-	       "%s: Calibrating PCI bus speed "
-	       "for pci_dev %s ... ", __FUNCTION__, pci_name(idd->idd_pdev));
 	/* Set up square wave */
 	int_out.raw = 0;
 	int_out.fields.count = IOC4_CALIBRATE_COUNT;
@@ -206,11 +203,16 @@ ioc4_clock_calibrate(struct ioc4_driver_
 	/* Bounds check the result. */
 	if (period > IOC4_CALIBRATE_LOW_LIMIT ||
 	    period < IOC4_CALIBRATE_HIGH_LIMIT) {
-		printk("failed. Assuming PCI clock ticks are %d ns.\n",
+		printk(KERN_INFO
+		       "IOC4 %s: Clock calibration failed.  Assuming"
+		       "PCI clock is %d ns.\n",
+		       pci_name(idd->idd_pdev),
 		       IOC4_CALIBRATE_DEFAULT / IOC4_EXTINT_COUNT_DIVISOR);
 		period = IOC4_CALIBRATE_DEFAULT;
 	} else {
-		printk("succeeded. PCI clock ticks are %ld ns.\n",
+		printk(KERN_DEBUG
+		       "IOC4 %s: PCI clock is %ld ns.\n",
+		       pci_name(idd->idd_pdev),
 		       period / IOC4_EXTINT_COUNT_DIVISOR);
 	}
 
@@ -222,6 +224,51 @@ ioc4_clock_calibrate(struct ioc4_driver_
 	idd->count_period = period;
 }
 
+/* There are three variants of IOC4 cards: IO9, IO10, and PCI-RT.
+ * Each brings out different combinations of IOC4 signals, thus.
+ * the IOC4 subdrivers need to know to which we're attached.
+ *
+ * We look for the presence of a SCSI (IO9) or SATA (IO10) controller
+ * on the same PCI bus at slot number 3 to differentiate IO9 from IO10.
+ * If neither is present, it's a PCI-RT.
+ */
+static unsigned int
+ioc4_variant(struct ioc4_driver_data *idd)
+{
+	struct pci_dev *pdev = NULL;
+	int found = 0;
+
+	/* IO9: Look for a QLogic ISP 12160 at the same bus and slot 3. */
+	do {
+		pdev = pci_get_device(PCI_VENDOR_ID_QLOGIC,
+				      PCI_DEVICE_ID_QLOGIC_ISP12160, pdev);
+		if (pdev &&
+		    idd->idd_pdev->bus->number == pdev->bus->number &&
+		    3 == PCI_SLOT(pdev->devfn))
+			found = 1;
+		pci_dev_put(pdev);
+	} while (pdev && !found);
+	if (NULL != pdev)
+		return IOC4_VARIANT_IO9;
+
+	/* IO10: Look for a Vitesse VSC 7174 at the same bus and slot 3. */
+	pdev = NULL;
+	do {
+		pdev = pci_get_device(PCI_VENDOR_ID_VITESSE,
+				      PCI_DEVICE_ID_VITESSE_VSC7174, pdev);
+		if (pdev &&
+		    idd->idd_pdev->bus->number == pdev->bus->number &&
+		    3 == PCI_SLOT(pdev->devfn))
+			found = 1;
+		pci_dev_put(pdev);
+	} while (pdev && !found);
+	if (NULL != pdev)
+		return IOC4_VARIANT_IO10;
+
+	/* PCI-RT: No SCSI/SATA controller will be present */
+	return IOC4_VARIANT_PCI_RT;
+}
+
 /* Adds a new instance of an IOC4 card */
 static int
 ioc4_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
@@ -286,6 +333,13 @@ ioc4_probe(struct pci_dev *pdev, const s
 
 	/* Failsafe portion of per-IOC4 initialization */
 
+	/* Detect card variant */
+	idd->idd_variant = ioc4_variant(idd);
+	printk(KERN_INFO "IOC4 %s: %s card detected.\n", pci_name(pdev),
+	       idd->idd_variant == IOC4_VARIANT_IO9 ? "IO9" :
+	       idd->idd_variant == IOC4_VARIANT_PCI_RT ? "PCI-RT" :
+	       idd->idd_variant == IOC4_VARIANT_IO10 ? "IO10" : "unknown");
+
 	/* Initialize IOC4 */
 	pci_read_config_dword(idd->idd_pdev, PCI_COMMAND, &pcmd);
 	pci_write_config_dword(idd->idd_pdev, PCI_COMMAND,
diff --git a/include/linux/ioc4.h b/include/linux/ioc4.h
index 3dd18b7..de73a32 100644
--- a/include/linux/ioc4.h
+++ b/include/linux/ioc4.h
@@ -147,6 +147,10 @@ struct ioc4_misc_regs {
 #define IOC4_GPCR_EDGE_6 0x40
 #define IOC4_GPCR_EDGE_7 0x80
 
+#define IOC4_VARIANT_IO9	0x0900
+#define IOC4_VARIANT_PCI_RT	0x0901
+#define IOC4_VARIANT_IO10	0x1000
+
 /* One of these per IOC4 */
 struct ioc4_driver_data {
 	struct list_head idd_list;
@@ -156,6 +160,7 @@ struct ioc4_driver_data {
 	struct __iomem ioc4_misc_regs *idd_misc_regs;
 	unsigned long count_period;
 	void *idd_serial_data;
+	unsigned int idd_variant;
 };
 
 /* One per submodule */
