Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWAQVB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWAQVB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWAQVB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:01:57 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19124 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964837AbWAQVB4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:01:56 -0500
Subject: PATCH: (For review) Teach libata to tune master/slave seperately
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 21:01:18 +0000
Message-Id: <1137531678.14135.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This also adds a filter hook which allows drives to veto modes by drive
specific detail. This is preferable to the more obvious 'have the driver
change the speed itself' approach because we have a combination of
constraints some known by the driver and some (such as PHY limits) by
the core code. We don't want drivers overriding constraints due to lack
of knowledge and setting unsafe/invalid modes.

The core logic is unchanged, it's merely had a re-order and the mode
decision is made twice instead of once only. Another important change in
the re-order which makes driver writers life much easier for PATA is
that both drive speeds decisions are made *before* the driver is called.

This is essential to your sanity when programming the many controllers
that do not use the device select bit to switch between address setup
times.

Tested in my patches for a while and seems to work for the combinations
I have. Introduces no new bugs I've found but obviously piix secondary
slave doesn't reliably work with or without this change because of the
current piix driver bug.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/scsi/libata-core.c linux-2.6.16-rc1/drivers/scsi/libata-core.c
--- linux.vanilla-2.6.16-rc1/drivers/scsi/libata-core.c	2006-01-17 15:52:54.000000000 +0000
+++ linux-2.6.16-rc1/drivers/scsi/libata-core.c	2006-01-17 16:40:44.000000000 +0000
@@ -68,9 +68,10 @@
 static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
-static unsigned int ata_get_mode_mask(const struct ata_port *ap, int shift);
+static unsigned int ata_get_mode_mask(const struct ata_port *ap, struct ata_device *adev, int shift);
 static int fgb(u32 bitmap);
 static int ata_choose_xfer_mode(const struct ata_port *ap,
+				struct ata_device *adev,
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out);
 static void __ata_qc_complete(struct ata_queued_cmd *qc);
@@ -1783,16 +1829,19 @@
 		ap->id, dev->devno, xfer_mode_str[idx]);
 }
 
-static int ata_host_set_pio(struct ata_port *ap)
+static int ata_host_set_pio(struct ata_port *ap, struct ata_device *adev)
 {
 	unsigned int mask;
-	int x, i;
+	int x;
 	u8 base, xfer_mode;
 
-	mask = ata_get_mode_mask(ap, ATA_SHIFT_PIO);
+	if (!ata_dev_present(adev))
+		return 0;
+
+	mask = ata_get_mode_mask(ap, adev, ATA_SHIFT_PIO);
 	x = fgb(mask);
 	if (x < 0) {
-		printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
+		printk(KERN_WARNING "ata%u: no PIO support for device %d.\n", ap->id, adev->devno);
 		return -1;
 	}
 
@@ -1802,34 +1851,24 @@
 	DPRINTK("base 0x%x xfer_mode 0x%x mask 0x%x x %d\n",
 		(int)base, (int)xfer_mode, mask, x);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
-		if (ata_dev_present(dev)) {
-			dev->pio_mode = xfer_mode;
-			dev->xfer_mode = xfer_mode;
-			dev->xfer_shift = ATA_SHIFT_PIO;
-			if (ap->ops->set_piomode)
-				ap->ops->set_piomode(ap, dev);
-		}
-	}
+	adev->pio_mode = xfer_mode;
+	adev->xfer_mode = xfer_mode;
+	adev->xfer_shift = ATA_SHIFT_PIO;
+	if (ap->ops->set_piomode)
+		ap->ops->set_piomode(ap, adev);
 
 	return 0;
 }
 
-static void ata_host_set_dma(struct ata_port *ap, u8 xfer_mode,
-			    unsigned int xfer_shift)
+static void ata_host_set_dma(struct ata_port *ap, struct ata_device *adev, 
+			     u8 xfer_mode, unsigned int xfer_shift)
 {
-	int i;
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
-		if (ata_dev_present(dev)) {
-			dev->dma_mode = xfer_mode;
-			dev->xfer_mode = xfer_mode;
-			dev->xfer_shift = xfer_shift;
-			if (ap->ops->set_dmamode)
-				ap->ops->set_dmamode(ap, dev);
-		}
+	if (ata_dev_present(adev)) {
+		adev->dma_mode = xfer_mode;
+		adev->xfer_mode = xfer_mode;
+		adev->xfer_shift = xfer_shift;
+		if (ap->ops->set_dmamode)
+			ap->ops->set_dmamode(ap, adev);
 	}
 }
 
@@ -1845,28 +1884,45 @@
  */
 static void ata_set_mode(struct ata_port *ap)
 {
-	unsigned int xfer_shift;
-	u8 xfer_mode;
+	unsigned int xfer_shift[ATA_MAX_DEVICES];
+	u8 xfer_mode[ATA_MAX_DEVICES];
 	int rc;
+	int i;
 
-	/* step 1: always set host PIO timings */
-	rc = ata_host_set_pio(ap);
-	if (rc)
-		goto err_out;
+	/* We need to set timings individually for each device */
 
-	/* step 2: choose the best data xfer mode */
-	xfer_mode = xfer_shift = 0;
-	rc = ata_choose_xfer_mode(ap, &xfer_mode, &xfer_shift);
-	if (rc)
-		goto err_out;
+	/* Compute the timings first so that when we ask the device to do
+	   speed configuration it can see all the intended device state in 
+	   full */
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *adev = &ap->device[i];
+		/* Choose the best data xfer mode */
+		xfer_mode[i] = xfer_shift[i] = 0;
+		rc = ata_choose_xfer_mode(ap, adev, &xfer_mode[i], &xfer_shift[i]);
+		if (rc)
+			goto err_out;
+
+	}
+	
+	/* Now set the mode tables we have computed */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *adev = &ap->device[i];
+		/* step 1: always set host PIO timings */
+		rc = ata_host_set_pio(ap, adev);
+		if (rc)
+			goto err_out;
 
-	/* step 3: if that xfer mode isn't PIO, set host DMA timings */
-	if (xfer_shift != ATA_SHIFT_PIO)
-		ata_host_set_dma(ap, xfer_mode, xfer_shift);
-
-	/* step 4: update devices' xfer mode */
-	ata_dev_set_mode(ap, &ap->device[0]);
-	ata_dev_set_mode(ap, &ap->device[1]);
+		/* step 2: if that xfer mode isn't PIO, set host DMA timings */
+		if (xfer_shift[i] != ATA_SHIFT_PIO)
+			ata_host_set_dma(ap, adev, xfer_mode[i], xfer_shift[i]);
+
+                /* In some cases the DMA mode will cause the driver to 
+                   update the pio mode to match chip limits. */
+                   
+		/* step 3: update devices' xfer mode */
+		ata_dev_set_mode(ap, adev);
+	}
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
@@ -2215,76 +2271,45 @@
 	return 0;
 }
 
-static unsigned int ata_get_mode_mask(const struct ata_port *ap, int shift)
+static unsigned int ata_get_mode_mask(const struct ata_port *ap, struct ata_device *adev, int shift)
 {
-	const struct ata_device *master, *slave;
 	unsigned int mask;
 
-	master = &ap->device[0];
-	slave = &ap->device[1];
-
-	assert (ata_dev_present(master) || ata_dev_present(slave));
+	if (!ata_dev_present(adev))
+		return 0xFF;	/* Drive isn't limiting anything */
 
 	if (shift == ATA_SHIFT_UDMA) {
 		mask = ap->udma_mask;
-		if (ata_dev_present(master)) {
-			mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
-			if (ata_dma_blacklisted(master)) {
-				mask = 0;
-				ata_pr_blacklisted(ap, master);
-			}
-		}
-		if (ata_dev_present(slave)) {
-			mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
-			if (ata_dma_blacklisted(slave)) {
-				mask = 0;
-				ata_pr_blacklisted(ap, slave);
-			}
+		mask &= (adev->id[ATA_ID_UDMA_MODES] & 0xff);
+		if (ata_dma_blacklisted(adev)) {
+			mask = 0;
+			ata_pr_blacklisted(ap, adev);
 		}
 	}
 	else if (shift == ATA_SHIFT_MWDMA) {
 		mask = ap->mwdma_mask;
-		if (ata_dev_present(master)) {
-			mask &= (master->id[ATA_ID_MWDMA_MODES] & 0x07);
-			if (ata_dma_blacklisted(master)) {
-				mask = 0;
-				ata_pr_blacklisted(ap, master);
-			}
-		}
-		if (ata_dev_present(slave)) {
-			mask &= (slave->id[ATA_ID_MWDMA_MODES] & 0x07);
-			if (ata_dma_blacklisted(slave)) {
-				mask = 0;
-				ata_pr_blacklisted(ap, slave);
-			}
+		mask &= (adev->id[ATA_ID_MWDMA_MODES] & 0x07);
+		if (ata_dma_blacklisted(adev)) {
+			mask = 0;
+			ata_pr_blacklisted(ap, adev);
 		}
 	}
 	else if (shift == ATA_SHIFT_PIO) {
+		u16 tmp_mode = ata_pio_modes(adev);
 		mask = ap->pio_mask;
-		if (ata_dev_present(master)) {
-			/* spec doesn't return explicit support for
-			 * PIO0-2, so we fake it
-			 */
-			u16 tmp_mode = master->id[ATA_ID_PIO_MODES] & 0x03;
-			tmp_mode <<= 3;
-			tmp_mode |= 0x7;
-			mask &= tmp_mode;
-		}
-		if (ata_dev_present(slave)) {
-			/* spec doesn't return explicit support for
-			 * PIO0-2, so we fake it
-			 */
-			u16 tmp_mode = slave->id[ATA_ID_PIO_MODES] & 0x03;
-			tmp_mode <<= 3;
-			tmp_mode |= 0x7;
-			mask &= tmp_mode;
-		}
+		mask &= tmp_mode;
 	}
 	else {
 		mask = 0xffffffff; /* shut up compiler warning */
 		BUG();
 	}
 
+	/*
+	 *	Allow the controller to see the proposed mode and
+	 *	device data to do any custom filtering rules.
+	 */
+	if(ap->ops->mode_filter)
+		mask = ap->ops->mode_filter(ap, adev, mask, shift);
 	return mask;
 }
 
@@ -2304,6 +2329,7 @@
 /**
  *	ata_choose_xfer_mode - attempt to find best transfer mode
  *	@ap: Port for which an xfer mode will be selected
+ *	@adev: ATA device for which xfer mode is being selected
  *	@xfer_mode_out: (output) SET FEATURES - XFER MODE code
  *	@xfer_shift_out: (output) bit shift that selects this mode
  *
@@ -2318,6 +2344,7 @@
  */
 
 static int ata_choose_xfer_mode(const struct ata_port *ap,
+				struct ata_device *adev,
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out)
 {
@@ -2326,7 +2353,7 @@
 
 	for (i = 0; i < ARRAY_SIZE(xfer_mode_classes); i++) {
 		shift = xfer_mode_classes[i].shift;
-		mask = ata_get_mode_mask(ap, shift);
+		mask = ata_get_mode_mask(ap, adev, shift);
 
 		x = fgb(mask);
 		if (x >= 0) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/include/linux/libata.h linux-2.6.16-rc1/include/linux/libata.h
--- linux.vanilla-2.6.16-rc1/include/linux/libata.h	2006-01-17 15:52:55.000000000 +0000
+++ linux-2.6.16-rc1/include/linux/libata.h	2006-01-17 16:46:07.000000000 +0000
@@ -366,6 +371,7 @@
 
 	void (*set_piomode) (struct ata_port *, struct ata_device *);
 	void (*set_dmamode) (struct ata_port *, struct ata_device *);
+	unsigned int (*mode_filter) (const struct ata_port *, struct ata_device *, unsigned int, int);
 
 	void (*tf_load) (struct ata_port *ap, const struct ata_taskfile *tf);
 	void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);

