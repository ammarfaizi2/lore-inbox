Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUEQThj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUEQThj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUEQThj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:37:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41879 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262389AbUEQTgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:36:03 -0400
Message-ID: <40A91410.5040408@pobox.com>
Date: Mon, 17 May 2004 15:35:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: Len Brown <len.brown@intel.com>, Sergey Vlasov <vsu@altlinux.ru>,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: libata Promise driver regression 2.6.5->2.6.6
References: <A6974D8E5F98D511BB910002A50A6647615FB7A9@hdsmsx403.hd.intel.com> <1084820518.12349.347.camel@dhcppc4> <40A90EE2.3040507@wasp.net.au>
In-Reply-To: <40A90EE2.3040507@wasp.net.au>
Content-Type: multipart/mixed;
 boundary="------------080606060802080608090300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080606060802080608090300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Brad Campbell wrote:
> Err.. yeah, I'm not quite sure why but a make oldconfig on my 2.6.5 
> config did not enable apic.
> Rather than boot 2.6.5 noapic, I enabled apic on 2.6.6 and the dmesg 
> compares perfectly to the 2.6.5 one, right up until it tries to probe 
> the 9th disk where it proceeds to dma timeout and then cease to listen 
> to anything..


Although it does sound like a non-libata problem, would you be willing 
to do a quick test, to verify that?

The attached patch, against kernel 2.6.5, updates libata to the code 
that is found in kernel 2.6.6.

If this backported libata works for you in 2.6.5, we should be able to 
eliminate libata as a problem source.  There _are_ other factors that 
may make that statement untrue, but it's a good indicator nonetheless.

	Jeff


P.S.  I only compile-tested the attached patch, did not actually see if 
it boots.  I just assume it does ;-)

--------------080606060802080608090300
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/ata_piix.c 1.12 vs edited =====
--- 1.12/drivers/scsi/ata_piix.c	Thu Mar 18 13:22:43 2004
+++ edited/drivers/scsi/ata_piix.c	Mon May 17 15:30:11 2004
@@ -28,17 +28,24 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"1.01"
+#define DRV_VERSION	"1.02"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
+	ICH5_PMR		= 0x90, /* port mapping register */
 	ICH5_PCS		= 0x92,	/* port control and status */
 
 	PIIX_FLAG_CHECKINTR	= (1 << 29), /* make sure PCI INTx enabled */
 	PIIX_FLAG_COMBINED	= (1 << 30), /* combined mode possible */
 
-	PIIX_COMB_PRI		= (1 << 0), /* combined mode, PATA primary */
-	PIIX_COMB_SEC		= (1 << 1), /* combined mode, PATA secondary */
+	/* combined mode.  if set, PATA is channel 0.
+	 * if clear, PATA is channel 1.
+	 */
+	PIIX_COMB_PATA_P0	= (1 << 1),
+	PIIX_COMB		= (1 << 2), /* combined mode enabled? */
+
+	PIIX_PORT_PRESENT	= (1 << 0),
+	PIIX_PORT_ENABLED	= (1 << 4),
 
 	PIIX_80C_PRI		= (1 << 5) | (1 << 4),
 	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
@@ -53,7 +60,6 @@
 
 static void piix_pata_phy_reset(struct ata_port *ap);
 static void piix_sata_phy_reset(struct ata_port *ap);
-static void piix_sata_port_disable(struct ata_port *ap);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev,
 			      unsigned int pio);
 static void piix_set_udmamode (struct ata_port *ap, struct ata_device *adev,
@@ -137,7 +143,7 @@
 };
 
 static struct ata_port_operations piix_sata_ops = {
-	.port_disable		= piix_sata_port_disable,
+	.port_disable		= ata_port_disable,
 	.set_piomode		= piix_set_piomode,
 	.set_udmamode		= piix_set_udmamode,
 
@@ -259,54 +265,48 @@
 }
 
 /**
- *	piix_pcs_probe - Probe SATA port configuration and status register
- *	@ap: Port to probe
- *	@have_port: (output) Non-zero if SATA port is enabled
- *	@have_device: (output) Non-zero if SATA phy indicates device present
+ *	piix_sata_probe - Probe PCI device for present SATA devices
+ *	@pdev: PCI device to probe
  *
  *	Reads SATA PCI device's PCI config register Port Configuration
  *	and Status (PCS) to determine port and device availability.
  *
  *	LOCKING:
  *	None (inherited from caller).
- */
-static void piix_pcs_probe (struct ata_port *ap, unsigned int *have_port,
-			    unsigned int *have_device)
-{
-	struct pci_dev *pdev = ap->host_set->pdev;
-	u16 pcs;
-
-	pci_read_config_word(pdev, ICH5_PCS, &pcs);
-
-	/* is SATA port enabled? */
-	if (pcs & (1 << ap->port_no)) {
-		*have_port = 1;
-
-		if (pcs & (1 << (ap->port_no + 4)))
-			*have_device = 1;
-	}
-}
-
-/**
- *	piix_pcs_disable - Disable SATA port
- *	@ap: Port to disable
- *
- *	Disable SATA phy for specified port.
  *
- *	LOCKING:
- *	None (inherited from caller).
+ *	RETURNS:
+ *	Non-zero if device detected, zero otherwise.
  */
-static void piix_pcs_disable (struct ata_port *ap)
+static int piix_sata_probe (struct ata_port *ap)
 {
 	struct pci_dev *pdev = ap->host_set->pdev;
-	u16 pcs;
+	int combined = (ap->flags & ATA_FLAG_SLAVE_POSS);
+	int orig_mask, mask, i;
+	u8 pcs;
+
+	mask = (PIIX_PORT_PRESENT << ap->port_no) |
+	       (PIIX_PORT_ENABLED << ap->port_no);
+
+	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
+	orig_mask = (int) pcs & 0xff;
+
+	/* TODO: this is vaguely wrong for ICH6 combined mode,
+	 * where only two of the four SATA ports are mapped
+	 * onto a single ATA channel.  It is also vaguely inaccurate
+	 * for ICH5, which has only two ports.  However, this is ok,
+	 * as further device presence detection code will handle
+	 * any false positives produced here.
+	 */
 
-	pci_read_config_word(pdev, ICH5_PCS, &pcs);
+	for (i = 0; i < 4; i++) {
+		mask = (PIIX_PORT_PRESENT << i) | (PIIX_PORT_ENABLED << i);
 
-	if (pcs & (1 << ap->port_no)) {
-		pcs &= ~(1 << ap->port_no);
-		pci_write_config_word(pdev, ICH5_PCS, pcs);
+		if ((orig_mask & mask) == mask)
+			if (combined || (i == ap->port_no))
+				return 1;
 	}
+
+	return 0;
 }
 
 /**
@@ -321,8 +321,6 @@
 
 static void piix_sata_phy_reset(struct ata_port *ap)
 {
-	unsigned int have_port = 0, have_dev = 0;
-
 	if (!pci_test_config_bits(ap->host_set->pdev,
 				  &piix_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
@@ -330,21 +328,9 @@
 		return;
 	}
 
-	piix_pcs_probe(ap, &have_port, &have_dev);
-
-	/* if port not enabled, exit */
-	if (!have_port) {
+	if (!piix_sata_probe(ap)) {
 		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: SATA port disabled. ignoring.\n",
-		       ap->id);
-		return;
-	}
-
-	/* if port enabled but no device, disable port and exit */
-	if (!have_dev) {
-		piix_sata_port_disable(ap);
-		printk(KERN_INFO "ata%u: SATA port has no device. disabling.\n",
-		       ap->id);
+		printk(KERN_INFO "ata%u: SATA port has no device.\n", ap->id);
 		return;
 	}
 
@@ -356,22 +342,6 @@
 }
 
 /**
- *	piix_sata_port_disable - Disable SATA port
- *	@ap: Port to disable.
- *
- *	Disable SATA port.
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void piix_sata_port_disable(struct ata_port *ap)
-{
-	ata_port_disable(ap);
-	piix_pcs_disable(ap);
-}
-
-/**
  *	piix_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
  *	@adev: um
@@ -493,31 +463,6 @@
 	}
 }
 
-/**
- *	piix_probe_combined - Determine if PATA and SATA are combined
- *	@pdev: PCI device to examine
- *	@mask: (output) zero, %PIIX_COMB_PRI or %PIIX_COMB_SEC
- *
- *	Determine if BIOS has secretly stuffed a PATA port into our
- *	otherwise-beautiful SATA PCI device.
- *
- *	LOCKING:
- *	Inherited from PCI layer (may sleep).
- */
-static void piix_probe_combined (struct pci_dev *pdev, unsigned int *mask)
-{
-	u8 tmp;
-
-	pci_read_config_byte(pdev, 0x90, &tmp); /* combined mode reg */
-	tmp &= 0x6; 	/* interesting bits 2:1, PATA primary/secondary */
-
-	/* backwards from what one might expect */
-	if (tmp == 0x4)	/* bits 10x */
-		*mask |= PIIX_COMB_SEC;
-	if (tmp == 0x6)	/* bits 11x */
-		*mask |= PIIX_COMB_PRI;
-}
-
 /* move to PCI layer, integrate w/ MSI stuff */
 static void pci_enable_intx(struct pci_dev *pdev)
 {
@@ -550,7 +495,7 @@
 	static int printed_version;
 	struct ata_port_info *port_info[2];
 	unsigned int combined = 0, n_ports = 1;
-	unsigned int pata_comb = 0, sata_comb = 0;
+	unsigned int pata_chan = 0, sata_chan = 0;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -561,8 +506,19 @@
 
 	port_info[0] = &piix_port_info[ent->driver_data];
 	port_info[1] = NULL;
-	if (port_info[0]->host_flags & PIIX_FLAG_COMBINED)
-		piix_probe_combined(pdev, &combined);
+
+	if (port_info[0]->host_flags & PIIX_FLAG_COMBINED) {
+		u8 tmp;
+		pci_read_config_byte(pdev, ICH5_PMR, &tmp);
+
+		if (tmp & PIIX_COMB) {
+			combined = 1;
+			if (tmp & PIIX_COMB_PATA_P0)
+				sata_chan = 1;
+			else
+				pata_chan = 1;
+		}
+	}
 
 	/* On ICH5, some BIOSen disable the interrupt using the
 	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.
@@ -573,15 +529,10 @@
 	if (port_info[0]->host_flags & PIIX_FLAG_CHECKINTR)
 		pci_enable_intx(pdev);
 
-	if (combined & PIIX_COMB_PRI)
-		sata_comb = 1;
-	else if (combined & PIIX_COMB_SEC)
-		pata_comb = 1;
-
-	if (pata_comb || sata_comb) {
-		port_info[sata_comb] = &piix_port_info[ent->driver_data];
-		port_info[sata_comb]->host_flags |= ATA_FLAG_SLAVE_POSS; /* sigh */
-		port_info[pata_comb] = &piix_port_info[ich5_pata]; /*ich5-specific*/
+	if (combined) {
+		port_info[sata_chan] = &piix_port_info[ent->driver_data];
+		port_info[sata_chan]->host_flags |= ATA_FLAG_SLAVE_POSS;
+		port_info[pata_chan] = &piix_port_info[ich5_pata];
 		n_ports++;
 
 		printk(KERN_WARNING DRV_NAME ": combined mode detected\n");
===== drivers/scsi/libata-core.c 1.30 vs edited =====
--- 1.30/drivers/scsi/libata-core.c	Thu Mar 18 17:55:43 2004
+++ edited/drivers/scsi/libata-core.c	Mon May 17 15:30:11 2004
@@ -118,7 +118,7 @@
 static void msleep(unsigned long msecs)
 {
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(msecs_to_jiffies(msecs));
+	schedule_timeout(msecs_to_jiffies(msecs) + 1);
 }
 
 /**
@@ -439,6 +439,81 @@
        	return readb((void *) ap->ioaddr.status_addr);
 }
 
+/**
+ *	ata_prot_to_cmd - determine which read/write opcodes to use
+ *	@protocol: ATA_PROT_xxx taskfile protocol
+ *	@lba48: true is lba48 is present
+ *
+ *	Given necessary input, determine which read/write commands
+ *	to use to transfer data.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static int ata_prot_to_cmd(int protocol, int lba48)
+{
+	int rcmd = 0, wcmd = 0;
+
+	switch (protocol) {
+	case ATA_PROT_PIO:
+		if (lba48) {
+			rcmd = ATA_CMD_PIO_READ_EXT;
+			wcmd = ATA_CMD_PIO_WRITE_EXT;
+		} else {
+			rcmd = ATA_CMD_PIO_READ;
+			wcmd = ATA_CMD_PIO_WRITE;
+		}
+		break;
+
+	case ATA_PROT_DMA:
+		if (lba48) {
+			rcmd = ATA_CMD_READ_EXT;
+			wcmd = ATA_CMD_WRITE_EXT;
+		} else {
+			rcmd = ATA_CMD_READ;
+			wcmd = ATA_CMD_WRITE;
+		}
+		break;
+
+	default:
+		return -1;
+	}
+
+	return rcmd | (wcmd << 8);
+}
+
+/**
+ *	ata_dev_set_protocol - set taskfile protocol and r/w commands
+ *	@dev: device to examine and configure
+ *
+ *	Examine the device configuration, after we have
+ *	read the identify-device page and configured the
+ *	data transfer mode.  Set internal state related to
+ *	the ATA taskfile protocol (pio, pio mult, dma, etc.)
+ *	and calculate the proper read/write commands to use.
+ *
+ *	LOCKING:
+ *	caller.
+ */
+static void ata_dev_set_protocol(struct ata_device *dev)
+{
+	int pio = (dev->flags & ATA_DFLAG_PIO);
+	int lba48 = (dev->flags & ATA_DFLAG_LBA48);
+	int proto, cmd;
+
+	if (pio)
+		proto = dev->xfer_protocol = ATA_PROT_PIO;
+	else
+		proto = dev->xfer_protocol = ATA_PROT_DMA;
+
+	cmd = ata_prot_to_cmd(proto, lba48);
+	if (cmd < 0)
+		BUG();
+
+	dev->read_cmd = cmd & 0xff;
+	dev->write_cmd = (cmd >> 8) & 0xff;
+}
+
 static const char * udma_str[] = {
 	"UDMA/16",
 	"UDMA/25",
@@ -478,12 +553,21 @@
 }
 
 /**
- *	ata_pio_devchk -
- *	@ap:
- *	@device:
+ *	ata_pio_devchk - PATA device presence detection
+ *	@ap: ATA channel to examine
+ *	@device: Device to examine (starting at zero)
  *
- *	LOCKING:
+ *	This technique was originally described in
+ *	Hale Landis's ATADRVR (www.ata-atapi.com), and
+ *	later found its way into the ATA/ATAPI spec.
  *
+ *	Write a pattern to the ATA shadow registers,
+ *	and if a device is present, it will respond by
+ *	correctly storing and echoing back the
+ *	ATA shadow register contents.
+ *
+ *	LOCKING:
+ *	caller.
  */
 
 static unsigned int ata_pio_devchk(struct ata_port *ap,
@@ -513,12 +597,21 @@
 }
 
 /**
- *	ata_mmio_devchk -
- *	@ap:
- *	@device:
+ *	ata_mmio_devchk - PATA device presence detection
+ *	@ap: ATA channel to examine
+ *	@device: Device to examine (starting at zero)
  *
- *	LOCKING:
+ *	This technique was originally described in
+ *	Hale Landis's ATADRVR (www.ata-atapi.com), and
+ *	later found its way into the ATA/ATAPI spec.
  *
+ *	Write a pattern to the ATA shadow registers,
+ *	and if a device is present, it will respond by
+ *	correctly storing and echoing back the
+ *	ATA shadow register contents.
+ *
+ *	LOCKING:
+ *	caller.
  */
 
 static unsigned int ata_mmio_devchk(struct ata_port *ap,
@@ -548,12 +641,16 @@
 }
 
 /**
- *	ata_dev_devchk -
- *	@ap:
- *	@device:
+ *	ata_dev_devchk - PATA device presence detection
+ *	@ap: ATA channel to examine
+ *	@device: Device to examine (starting at zero)
  *
- *	LOCKING:
+ *	Dispatch ATA device presence detection, depending
+ *	on whether we are using PIO or MMIO to talk to the
+ *	ATA shadow registers.
  *
+ *	LOCKING:
+ *	caller.
  */
 
 static unsigned int ata_dev_devchk(struct ata_port *ap,
@@ -604,16 +701,24 @@
 }
 
 /**
- *	ata_dev_try_classify -
- *	@ap:
- *	@device:
+ *	ata_dev_try_classify - Parse returned ATA device signature
+ *	@ap: ATA channel to examine
+ *	@device: Device to examine (starting at zero)
  *
- *	LOCKING:
+ *	After an event -- SRST, E.D.D., or SATA COMRESET -- occurs,
+ *	an ATA/ATAPI-defined set of values is placed in the ATA
+ *	shadow registers, indicating the results of device detection
+ *	and diagnostics.
  *
+ *	Select the ATA device, and read the values from the ATA shadow
+ *	registers.  Then parse according to the Error register value,
+ *	and the spec-defined values examined by ata_dev_classify().
+ *
+ *	LOCKING:
+ *	caller.
  */
 
-static u8 ata_dev_try_classify(struct ata_port *ap, unsigned int device,
-			       unsigned int maybe_have_dev)
+static u8 ata_dev_try_classify(struct ata_port *ap, unsigned int device)
 {
 	struct ata_device *dev = &ap->device[device];
 	struct ata_taskfile tf;
@@ -650,44 +755,51 @@
 }
 
 /**
- *	ata_dev_id_string -
- *	@dev:
- *	@s:
- *	@ofs:
- *	@len:
+ *	ata_dev_id_string - Convert IDENTIFY DEVICE page into string
+ *	@dev: Device whose IDENTIFY DEVICE results we will examine
+ *	@s: string into which data is output
+ *	@ofs: offset into identify device page
+ *	@len: length of string to return
  *
- *	LOCKING:
- *
- *	RETURNS:
+ *	The strings in the IDENTIFY DEVICE page are broken up into
+ *	16-bit chunks.  Run through the string, and output each
+ *	8-bit chunk linearly, regardless of platform.
  *
+ *	LOCKING:
+ *	caller.
  */
 
-unsigned int ata_dev_id_string(struct ata_device *dev, unsigned char *s,
-			       unsigned int ofs, unsigned int len)
+void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+		       unsigned int ofs, unsigned int len)
 {
-	unsigned int c, ret = 0;
+	unsigned int c;
 
 	while (len > 0) {
 		c = dev->id[ofs] >> 8;
 		*s = c;
 		s++;
 
-		ret = c = dev->id[ofs] & 0xff;
+		c = dev->id[ofs] & 0xff;
 		*s = c;
 		s++;
 
 		ofs++;
 		len -= 2;
 	}
-
-	return ret;
 }
 
 /**
- *	ata_dev_parse_strings -
- *	@dev:
+ *	ata_dev_parse_strings - Store useful IDENTIFY DEVICE page strings
+ *	@dev: Device whose IDENTIFY DEVICE page info we use
+ *
+ *	We store 'vendor' and 'product' strings read from the device,
+ *	for later use in the SCSI simulator's INQUIRY data.
+ *
+ *	Set these strings here, in the case of 'product', using
+ *	data read from the ATA IDENTIFY DEVICE page.
  *
  *	LOCKING:
+ *	caller.
  */
 
 static void ata_dev_parse_strings(struct ata_device *dev)
@@ -700,12 +812,16 @@
 }
 
 /**
- *	__ata_dev_select -
- *	@ap:
- *	@device:
+ *	__ata_dev_select - Select device 0/1 on ATA bus
+ *	@ap: ATA channel to manipulate
+ *	@device: ATA device (numbered from zero) to select
  *
- *	LOCKING:
+ *	Use the method defined in the ATA specification to
+ *	make either device 0, or device 1, active on the
+ *	ATA channel.
  *
+ *	LOCKING:
+ *	caller.
  */
 
 static void __ata_dev_select (struct ata_port *ap, unsigned int device)
@@ -726,16 +842,22 @@
 }
 
 /**
- *	ata_dev_select -
- *	@ap:
- *	@device:
- *	@wait:
- *	@can_sleep:
+ *	ata_dev_select - Select device 0/1 on ATA bus
+ *	@ap: ATA channel to manipulate
+ *	@device: ATA device (numbered from zero) to select
+ *	@wait: non-zero to wait for Status register BSY bit to clear
+ *	@can_sleep: non-zero if context allows sleeping
+ *
+ *	Use the method defined in the ATA specification to
+ *	make either device 0, or device 1, active on the
+ *	ATA channel.
+ *
+ *	This is a high-level version of __ata_dev_select(),
+ *	which additionally provides the services of inserting
+ *	the proper pauses and status polling, where needed.
  *
  *	LOCKING:
- *
- *	RETURNS:
- *
+ *	caller.
  */
 
 void ata_dev_select(struct ata_port *ap, unsigned int device,
@@ -757,10 +879,14 @@
 }
 
 /**
- *	ata_dump_id -
- *	@dev:
+ *	ata_dump_id - IDENTIFY DEVICE info debugging output
+ *	@dev: Device whose IDENTIFY DEVICE page we will dump
+ *
+ *	Dump selected 16-bit words from a detected device's
+ *	IDENTIFY PAGE page.
  *
  *	LOCKING:
+ *	caller.
  */
 
 static inline void ata_dump_id(struct ata_device *dev)
@@ -843,7 +969,7 @@
 retry:
 	ata_tf_init(ap, &tf, device);
 	tf.ctl |= ATA_NIEN;
-	tf.protocol = ATA_PROT_PIO_READ;
+	tf.protocol = ATA_PROT_PIO;
 
 	if (dev->class == ATA_DEV_ATA) {
 		tf.command = ATA_CMD_ID_ATA;
@@ -1129,7 +1255,7 @@
  */
 static void ata_set_mode(struct ata_port *ap)
 {
-	unsigned int force_pio;
+	unsigned int force_pio, i;
 
 	ata_host_set_pio(ap);
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
@@ -1148,19 +1274,21 @@
 	if (force_pio) {
 		ata_dev_set_pio(ap, 0);
 		ata_dev_set_pio(ap, 1);
-
-		if (ap->flags & ATA_FLAG_PORT_DISABLED)
-			return;
 	} else {
 		ata_dev_set_udma(ap, 0);
 		ata_dev_set_udma(ap, 1);
-
-		if (ap->flags & ATA_FLAG_PORT_DISABLED)
-			return;
 	}
 
+	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+		return;
+
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
+
+	for (i = 0; i < 2; i++) {
+		struct ata_device *dev = &ap->device[i];
+		ata_dev_set_protocol(dev);
+	}
 }
 
 /**
@@ -1386,9 +1514,9 @@
 	/*
 	 * determine by signature whether we have ATA or ATAPI devices
 	 */
-	err = ata_dev_try_classify(ap, 0, dev0);
+	err = ata_dev_try_classify(ap, 0);
 	if ((slave_possible) && (err != 0x81))
-		ata_dev_try_classify(ap, 1, dev1);
+		ata_dev_try_classify(ap, 1);
 
 	/* re-enable interrupts */
 	ata_irq_on(ap);
@@ -1725,6 +1853,7 @@
 	int dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
 	struct scatterlist *sg = qc->sg;
 	unsigned int have_sg = (qc->flags & ATA_QCFLAG_SG);
+	dma_addr_t dma_address;
 
 	assert(sg == &qc->sgent);
 	assert(qc->n_elem == 1);
@@ -1736,12 +1865,15 @@
 	if (!have_sg)
 		return 0;
 
-	sg_dma_address(sg) = pci_map_single(ap->host_set->pdev,
-					 cmd->request_buffer,
-					 cmd->request_bufflen, dir);
+	dma_address = pci_map_single(ap->host_set->pdev, cmd->request_buffer,
+				     cmd->request_bufflen, dir);
+	if (pci_dma_mapping_error(dma_address))
+		return -1;
+
+	sg_dma_address(sg) = dma_address;
 
 	DPRINTK("mapped buffer of %d bytes for %s\n", cmd->request_bufflen,
-		qc->flags & ATA_QCFLAG_WRITE ? "write" : "read");
+		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
 	return 0;
 }
@@ -1842,8 +1974,7 @@
 {
 	struct ata_port *ap = qc->ap;
 
-	assert((qc->tf.protocol == ATA_PROT_PIO_READ) ||
-	       (qc->tf.protocol == ATA_PROT_PIO_WRITE));
+	assert(qc->tf.protocol == ATA_PROT_PIO);
 
 	qc->flags |= ATA_QCFLAG_POLL;
 	qc->tf.ctl |= ATA_NIEN;	/* disable interrupts */
@@ -1963,12 +2094,12 @@
 		}
 
 	DPRINTK("data %s, drv_stat 0x%X\n",
-		qc->flags & ATA_QCFLAG_WRITE ? "write" : "read",
+		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read",
 		status);
 
 	/* do the actual data transfer */
 	/* FIXME: mmio-ize */
-	if (qc->flags & ATA_QCFLAG_WRITE)
+	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		outsl(ap->ioaddr.data_addr, buf, ATA_SECT_DWORDS);
 	else
 		insl(ap->ioaddr.data_addr, buf, ATA_SECT_DWORDS);
@@ -2033,8 +2164,7 @@
 	qc->scsidone = scsi_finish_command;
 
 	switch (qc->tf.protocol) {
-	case ATA_PROT_DMA_READ:
-	case ATA_PROT_DMA_WRITE:
+	case ATA_PROT_DMA:
 		if (ap->flags & ATA_FLAG_MMIO) {
 			void *mmio = (void *) ap->ioaddr.bmdma_addr;
 			host_stat = readb(mmio + ATA_DMA_STATUS);
@@ -2115,6 +2245,7 @@
 		qc->scsicmd = NULL;
 		qc->ap = ap;
 		qc->dev = dev;
+		qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 		INIT_LIST_HEAD(&qc->node);
 		init_MUTEX_LOCKED(&qc->sem);
 
@@ -2258,7 +2389,7 @@
 void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned int rw = (qc->flags & ATA_QCFLAG_WRITE);
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
 	u8 host_stat, dmactl;
 	void *mmio = (void *) ap->ioaddr.bmdma_addr;
 
@@ -2307,7 +2438,7 @@
 void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned int rw = (qc->flags & ATA_QCFLAG_WRITE);
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
 	u8 host_stat, dmactl;
 
 	/* load PRD table addr. */
@@ -2402,8 +2533,7 @@
 	unsigned int handled = 0;
 
 	switch (qc->tf.protocol) {
-	case ATA_PROT_DMA_READ:
-	case ATA_PROT_DMA_WRITE:
+	case ATA_PROT_DMA:
 		if (ap->flags & ATA_FLAG_MMIO) {
 			void *mmio = (void *) ap->ioaddr.bmdma_addr;
 			host_stat = readb(mmio + ATA_DMA_STATUS);
@@ -2629,7 +2759,7 @@
                         flush_signals(current);
                         
                 if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
                                                         
 
                 if ((timeout < 0) || (ap->time_to_die))
@@ -2810,6 +2940,7 @@
 	host->unique_id = ata_unique_id++;
 	host->max_cmd_len = 12;
 	scsi_set_device(host, &ent->pdev->dev);
+	scsi_assign_lock(host, &host_set->lock);
 
 	ap->flags = ATA_FLAG_PORT_DISABLED;
 	ap->id = host->unique_id;
===== drivers/scsi/libata-scsi.c 1.9 vs edited =====
--- 1.9/drivers/scsi/libata-scsi.c	Sat Mar 27 18:08:37 2004
+++ edited/drivers/scsi/libata-scsi.c	Mon May 17 15:30:11 2004
@@ -32,17 +32,29 @@
 
 #include "libata.h"
 
+typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, u8 *scsicmd);
+static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
+			      struct scsi_cmnd *cmd,
+			      void (*done)(struct scsi_cmnd *));
+
 
 /**
- *	ata_std_bios_param - generic bios head/sector/cylinder calculator
- *	    used by sd. Most BIOSes nowadays expect a XXX/255/16  (CHS) 
- *	    mapping. Some situations may arise where the disk is not 
- *	    bootable if this is not used.
+ *	ata_std_bios_param - generic bios head/sector/cylinder calculator used by sd.
+ *	@sdev: SCSI device for which BIOS geometry is to be determined
+ *	@bdev: block device associated with @sdev
+ *	@capacity: capacity of SCSI device
+ *	@geom: location to which geometry will be output
+ *
+ *	Generic bios head/sector/cylinder calculator
+ *	used by sd. Most BIOSes nowadays expect a XXX/255/16  (CHS) 
+ *	mapping. Some situations may arise where the disk is not 
+ *	bootable if this is not used.
  *
  *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
  *
  *	RETURNS:
- *
+ *	Zero.
  */
 int ata_std_bios_param(struct scsi_device *sdev, struct block_device *bdev,
 		       sector_t capacity, int geom[]) 
@@ -56,6 +68,27 @@
 }
 
 
+/**
+ *	ata_scsi_qc_new - acquire new ata_queued_cmd reference
+ *	@ap: ATA port to which the new command is attached
+ *	@dev: ATA device to which the new command is attached
+ *	@cmd: SCSI command that originated this ATA command
+ *	@done: SCSI command completion function
+ *
+ *	Obtain a reference to an unused ata_queued_cmd structure,
+ *	which is the basic libata structure representing a single
+ *	ATA command sent to the hardware.
+ *
+ *	If a command was available, fill in the SCSI-specific
+ *	portions of the structure with information on the
+ *	current command.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Command allocated, or %NULL if none available.
+ */
 struct ata_queued_cmd *ata_scsi_qc_new(struct ata_port *ap,
 				       struct ata_device *dev,
 				       struct scsi_cmnd *cmd,
@@ -84,11 +117,18 @@
 }
 
 /**
- *	ata_to_sense_error -
- *	@qc:
- *	@cmd:
+ *	ata_to_sense_error - convert ATA error to SCSI error
+ *	@qc: Command that we are erroring out
+ *
+ *	Converts an ATA error into a SCSI error.
+ *
+ *	Right now, this routine is laughably primitive.  We
+ *	don't even examine what ATA told us, we just look at
+ *	the command data direction, and return a fatal SCSI
+ *	sense error based on that.
  *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
  */
 
 void ata_to_sense_error(struct ata_queued_cmd *qc)
@@ -102,7 +142,7 @@
 	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
 
 	/* additional-sense-code[-qualifier] */
-	if ((qc->flags & ATA_QCFLAG_WRITE) == 0) {
+	if (cmd->sc_data_direction == SCSI_DATA_READ) {
 		cmd->sense_buffer[12] = 0x11; /* "unrecovered read error" */
 		cmd->sense_buffer[13] = 0x04;
 	} else {
@@ -112,11 +152,15 @@
 }
 
 /**
- *	ata_scsi_slave_config -
- *	@sdev:
+ *	ata_scsi_slave_config - Set SCSI device attributes
+ *	@sdev: SCSI device to examine
  *
- *	LOCKING:
+ *	This is called before we actually start reading
+ *	and writing to the device, to configure certain
+ *	SCSI mid-layer behaviors.
  *
+ *	LOCKING:
+ *	Defined by SCSI layer.  We don't really care.
  */
 
 int ata_scsi_slave_config(struct scsi_device *sdev)
@@ -155,68 +199,47 @@
 }
 
 /**
- *	ata_scsi_rw_xlat -
- *	@qc:
- *	@scsicmd:
- *	@cmd_size:
+ *	ata_scsi_rw_xlat - Translate SCSI r/w command into an ATA one
+ *	@qc: Storage for translated ATA taskfile
+ *	@scsicmd: SCSI command to translate
+ *
+ *	Converts any of six SCSI read/write commands into the
+ *	ATA counterpart, including starting sector (LBA),
+ *	sector count, and taking into account the device's LBA48
+ *	support.
+ *
+ *	Commands %READ_6, %READ_10, %READ_16, %WRITE_6, %WRITE_10, and
+ *	%WRITE_16 are currently supported.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
  *	RETURNS:
- *
+ *	Zero on success, non-zero on error.
  */
 
-static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, u8 *scsicmd,
-				   unsigned int cmd_size)
+static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
 	struct ata_taskfile *tf = &qc->tf;
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
-	unsigned int dma = qc->flags & ATA_QCFLAG_DMA;
 
-	qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->hob_nsect = 0;
 	tf->hob_lbal = 0;
 	tf->hob_lbam = 0;
 	tf->hob_lbah = 0;
+	tf->protocol = qc->dev->xfer_protocol;
+	tf->device |= ATA_LBA;
 
 	if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
 	    scsicmd[0] == READ_16) {
-		if (likely(dma)) {
-			if (lba48)
-				tf->command = ATA_CMD_READ_EXT;
-			else
-				tf->command = ATA_CMD_READ;
-			tf->protocol = ATA_PROT_DMA_READ;
-		} else {
-			if (lba48)
-				tf->command = ATA_CMD_PIO_READ_EXT;
-			else
-				tf->command = ATA_CMD_PIO_READ;
-			tf->protocol = ATA_PROT_PIO_READ;
-		}
-		qc->flags &= ~ATA_QCFLAG_WRITE;
-		VPRINTK("reading\n");
+		tf->command = qc->dev->read_cmd;
 	} else {
-		if (likely(dma)) {
-			if (lba48)
-				tf->command = ATA_CMD_WRITE_EXT;
-			else
-				tf->command = ATA_CMD_WRITE;
-			tf->protocol = ATA_PROT_DMA_WRITE;
-		} else {
-			if (lba48)
-				tf->command = ATA_CMD_PIO_WRITE_EXT;
-			else
-				tf->command = ATA_CMD_PIO_WRITE;
-			tf->protocol = ATA_PROT_PIO_WRITE;
-		}
-		qc->flags |= ATA_QCFLAG_WRITE;
-		VPRINTK("writing\n");
+		tf->command = qc->dev->write_cmd;
+		tf->flags |= ATA_TFLAG_WRITE;
 	}
 
-	if (cmd_size == 10) {
+	if (scsicmd[0] == READ_10 || scsicmd[0] == WRITE_10) {
 		if (lba48) {
 			tf->hob_nsect = scsicmd[7];
 			tf->hob_lbal = scsicmd[2];
@@ -234,7 +257,6 @@
 
 			qc->nsect = scsicmd[8];
 		}
-		tf->device |= ATA_LBA;
 
 		tf->nsect = scsicmd[8];
 		tf->lbal = scsicmd[5];
@@ -245,19 +267,17 @@
 		return 0;
 	}
 
-	if (cmd_size == 6) {
+	if (scsicmd[0] == READ_6 || scsicmd[0] == WRITE_6) {
 		qc->nsect = tf->nsect = scsicmd[4];
 		tf->lbal = scsicmd[3];
 		tf->lbam = scsicmd[2];
 		tf->lbah = scsicmd[1] & 0x1f; /* mask out reserved bits */
 
-		tf->device |= ATA_LBA;
-
 		VPRINTK("six-byte command\n");
 		return 0;
 	}
 
-	if (cmd_size == 16) {
+	if (scsicmd[0] == READ_16 || scsicmd[0] == WRITE_16) {
 		/* rule out impossible LBAs and sector counts */
 		if (scsicmd[2] || scsicmd[3] || scsicmd[10] || scsicmd[11])
 			return 1;
@@ -281,7 +301,6 @@
 
 			qc->nsect = scsicmd[13];
 		}
-		tf->device |= ATA_LBA;
 
 		tf->nsect = scsicmd[13];
 		tf->lbal = scsicmd[9];
@@ -297,20 +316,27 @@
 }
 
 /**
- *	ata_scsi_rw_queue -
- *	@ap:
- *	@dev:
- *	@cmd:
- *	@done:
- *	@cmd_size:
+ *	ata_scsi_translate - Translate then issue SCSI command to ATA device
+ *	@ap: ATA port to which the command is addressed
+ *	@dev: ATA device to which the command is addressed
+ *	@cmd: SCSI command to execute
+ *	@done: SCSI command completion function
+ *
+ *	Our ->queuecommand() function has decided that the SCSI
+ *	command issued can be directly translated into an ATA
+ *	command, rather than handled internally.
+ *
+ *	This function sets up an ata_queued_cmd structure for the
+ *	SCSI command, and sends that ata_queued_cmd to the hardware.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_scsi_rw_queue(struct ata_port *ap, struct ata_device *dev,
-		      struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
-		      unsigned int cmd_size)
+static void ata_scsi_translate(struct ata_port *ap, struct ata_device *dev,
+			      struct scsi_cmnd *cmd,
+			      void (*done)(struct scsi_cmnd *),
+			      ata_xlat_func_t xlat_func)
 {
 	struct ata_queued_cmd *qc;
 	u8 *scsicmd = cmd->cmnd;
@@ -327,9 +353,11 @@
 	if (!qc)
 		return;
 
-	qc->flags |= ATA_QCFLAG_SG;	/* data is present; dma-map it */
+	if (cmd->sc_data_direction == SCSI_DATA_READ ||
+	    cmd->sc_data_direction == SCSI_DATA_WRITE)
+		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
 
-	if (ata_scsi_rw_xlat(qc, scsicmd, cmd_size))
+	if (xlat_func(qc, scsicmd))
 		goto err_out;
 
 	/* select device, send command to hardware */
@@ -353,7 +381,6 @@
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
- *	FIXME: kmap inside spin_lock_irqsave ok?
  *
  *	RETURNS:
  *	Length of response buffer.
@@ -368,7 +395,7 @@
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		buf = kmap(sg->page) + sg->offset;
+		buf = kmap_atomic(sg->page, KM_USER0) + sg->offset;
 		buflen = sg->length;
 	} else {
 		buf = cmd->request_buffer;
@@ -396,7 +423,7 @@
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		kunmap(sg->page);
+		kunmap_atomic(sg->page, KM_USER0);
 	}
 }
 
@@ -596,30 +623,6 @@
 }
 
 /**
- *	ata_scsiop_sync_cache - Simulate SYNCHRONIZE CACHE command
- *	@args: Port / device / SCSI command of interest.
- *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *	@buflen: Response buffer length.
- *
- *	Initiates flush of device's cache.
- *
- *	TODO:
- *	Actually do this :)
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-unsigned int ata_scsiop_sync_cache(struct ata_scsi_args *args, u8 *rbuf,
-				  unsigned int buflen)
-{
-	VPRINTK("ENTER\n");
-
-	/* FIXME */
-	return 1;
-}
-
-/**
  *	ata_msense_push - Push data onto MODE SENSE data output buffer
  *	@ptr_io: (input/output) Location to store more output data
  *	@last: End of output data buffer
@@ -649,9 +652,9 @@
 
 /**
  *	ata_msense_caching - Simulate MODE SENSE caching info page
- *	@dev:
- *	@ptr_io:
- *	@last:
+ *	@dev: Device associated with this MODE SENSE command
+ *	@ptr_io: (input/output) Location to store more output data
+ *	@last: End of output data buffer
  *
  *	Generate a caching info page, which conditionally indicates
  *	write caching to the SCSI layer, depending on device
@@ -674,9 +677,9 @@
 
 /**
  *	ata_msense_ctl_mode - Simulate MODE SENSE control mode page
- *	@dev:
- *	@ptr_io:
- *	@last:
+ *	@dev: Device associated with this MODE SENSE command
+ *	@ptr_io: (input/output) Location to store more output data
+ *	@last: End of output data buffer
  *
  *	Generate a generic MODE SENSE control mode page.
  *
@@ -834,11 +837,15 @@
 }
 
 /**
- *	ata_scsi_badcmd -
- *	@cmd:
- *	@done:
- *	@asc:
- *	@ascq:
+ *	ata_scsi_badcmd - End a SCSI request with an error
+ *	@cmd: SCSI request to be handled
+ *	@done: SCSI command completion function
+ *	@asc: SCSI-defined additional sense code
+ *	@ascq: SCSI-defined additional sense code qualifier
+ *
+ *	Helper function that completes a SCSI command with
+ *	%SAM_STAT_CHECK_CONDITION, with a sense key %ILLEGAL_REQUEST
+ *	and the specified additional sense codes.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
@@ -912,7 +919,7 @@
 
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
-		qc->flags |= ATA_QCFLAG_WRITE;
+		qc->tf.flags |= ATA_TFLAG_WRITE;
 		DPRINTK("direction: write\n");
 	}
 
@@ -967,6 +974,99 @@
 }
 
 /**
+ *	ata_scsi_find_dev - lookup ata_device from scsi_cmnd
+ *	@ap: ATA port to which the device is attached
+ *	@cmd: SCSI command to be sent to the device
+ *
+ *	Given various information provided in struct scsi_cmnd,
+ *	map that onto an ATA bus, and using that mapping
+ *	determine which ata_device is associated with the
+ *	SCSI command to be sent.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Associated ATA device, or %NULL if not found.
+ */
+
+static inline struct ata_device *
+ata_scsi_find_dev(struct ata_port *ap, struct scsi_cmnd *cmd)
+{
+	struct ata_device *dev;
+
+	/* skip commands not addressed to targets we simulate */
+	if (likely(cmd->device->id < ATA_MAX_DEVICES))
+		dev = &ap->device[cmd->device->id];
+	else
+		return NULL;
+
+	if (unlikely((cmd->device->channel != 0) ||
+		     (cmd->device->lun != 0)))
+		return NULL;
+
+	if (unlikely(!ata_dev_present(dev)))
+		return NULL;
+
+#ifndef ATA_ENABLE_ATAPI
+	if (unlikely(dev->class == ATA_DEV_ATAPI))
+		return NULL;
+#endif
+
+	return dev;
+}
+
+/**
+ *	ata_get_xlat_func - check if SCSI to ATA translation is possible
+ *	@cmd: SCSI command opcode to consider
+ *
+ *	Look up the SCSI command given, and determine whether the
+ *	SCSI command is to be translated or simulated.
+ *
+ *	RETURNS:
+ *	Pointer to translation function if possible, %NULL if not.
+ */
+
+static inline ata_xlat_func_t ata_get_xlat_func(u8 cmd)
+{
+	switch (cmd) {
+	case READ_6:
+	case READ_10:
+	case READ_16:
+
+	case WRITE_6:
+	case WRITE_10:
+	case WRITE_16:
+		return ata_scsi_rw_xlat;
+	}
+
+	return NULL;
+}
+
+/**
+ *	ata_scsi_dump_cdb - dump SCSI command contents to dmesg
+ *	@ap: ATA port to which the command was being sent
+ *	@cmd: SCSI command to dump
+ *
+ *	Prints the contents of a SCSI command via printk().
+ */
+
+static inline void ata_scsi_dump_cdb(struct ata_port *ap,
+				     struct scsi_cmnd *cmd)
+{
+#ifdef ATA_DEBUG
+	u8 *scsicmd = cmd->cmnd;
+
+	DPRINTK("CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
+		ap->id,
+		cmd->device->channel, cmd->device->id, cmd->device->lun,
+		scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
+		scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
+		scsicmd[8]);
+#endif
+}
+
+/**
  *	ata_scsi_queuecmd - Issue SCSI cdb to libata-managed device
  *	@cmd: SCSI command to be sent
  *	@done: Completion function, called when command is complete
@@ -987,83 +1087,54 @@
 
 int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 {
-	u8 *scsicmd = cmd->cmnd;
 	struct ata_port *ap;
 	struct ata_device *dev;
-	struct ata_scsi_args args;
-	const unsigned int atapi_support =
-#ifdef ATA_ENABLE_ATAPI
-					   1;
-#else
-					   0;
-#endif
-
-	/* Note: spin_lock_irqsave is held by caller... */
-	spin_unlock(cmd->device->host->host_lock);
 
 	ap = (struct ata_port *) &cmd->device->host->hostdata[0];
 
-	DPRINTK("CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
-		ap->id,
-		cmd->device->channel, cmd->device->id, cmd->device->lun,
-		scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
-		scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
-		scsicmd[8]);
+	ata_scsi_dump_cdb(ap, cmd);
 
-	/* skip commands not addressed to targets we care about */
-	if ((cmd->device->channel != 0) || (cmd->device->lun != 0) ||
-	    (cmd->device->id >= ATA_MAX_DEVICES)) {
-		cmd->result = (DID_BAD_TARGET << 16); /* FIXME: correct? */
-		done(cmd);
-		goto out;
-	}
-
-	spin_lock(&ap->host_set->lock);
-
-	dev = &ap->device[cmd->device->id];
-
-	if (!ata_dev_present(dev)) {
-		DPRINTK("no device\n");
-		cmd->result = (DID_BAD_TARGET << 16); /* FIXME: correct? */
+	dev = ata_scsi_find_dev(ap, cmd);
+	if (unlikely(!dev)) {
+		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
 		goto out_unlock;
 	}
 
-	if (dev->class == ATA_DEV_ATAPI) {
-		if (atapi_support)
-			atapi_scsi_queuecmd(ap, dev, cmd, done);
-		else {
-			cmd->result = (DID_BAD_TARGET << 16); /* correct? */
-			done(cmd);
-		}
-		goto out_unlock;
-	}
+	if (dev->class == ATA_DEV_ATA) {
+		ata_xlat_func_t xlat_func = ata_get_xlat_func(cmd->cmnd[0]);
 
-	/* fast path */
-	switch(scsicmd[0]) {
-		case READ_6:
-		case WRITE_6:
-			ata_scsi_rw_queue(ap, dev, cmd, done, 6);
-			goto out_unlock;
-
-		case READ_10:
-		case WRITE_10:
-			ata_scsi_rw_queue(ap, dev, cmd, done, 10);
-			goto out_unlock;
-
-		case READ_16:
-		case WRITE_16:
-			ata_scsi_rw_queue(ap, dev, cmd, done, 16);
-			goto out_unlock;
+		if (xlat_func)
+			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
+		else
+			ata_scsi_simulate(ap, dev, cmd, done);
+	} else
+		atapi_scsi_queuecmd(ap, dev, cmd, done);
 
-		default:
-			/* do nothing */
-			break;
-	}
+out_unlock:
+	return 0;
+}
 
-	/*
-	 * slow path
-	 */
+/**
+ *	ata_scsi_simulate - simulate SCSI command on ATA device
+ *	@ap: Port to which ATA device is attached.
+ *	@dev: Target device for CDB.
+ *	@cmd: SCSI command being sent to device.
+ *	@done: SCSI command completion function.
+ *
+ *	Interprets and directly executes a select list of SCSI commands
+ *	that can be handled internally.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
+			      struct scsi_cmnd *cmd,
+			      void (*done)(struct scsi_cmnd *))
+{
+	struct ata_scsi_args args;
+	u8 *scsicmd = cmd->cmnd;
 
 	args.ap = ap;
 	args.dev = dev;
@@ -1102,13 +1173,6 @@
 			ata_bad_cdb(cmd, done);
 			break;
 
-		case SYNCHRONIZE_CACHE:
-			if ((dev->flags & ATA_DFLAG_WCACHE) == 0)
-				ata_bad_scsiop(cmd, done);
-			else
-				ata_scsi_rbuf_fill(&args, ata_scsiop_sync_cache);
-			break;
-
 		case READ_CAPACITY:
 			ata_scsi_rbuf_fill(&args, ata_scsiop_read_cap);
 			break;
@@ -1132,11 +1196,5 @@
 			ata_bad_scsiop(cmd, done);
 			break;
 	}
-
-out_unlock:
-	spin_unlock(&ap->host_set->lock);
-out:
-	spin_lock(cmd->device->host->host_lock);
-	return 0;
 }
 
===== drivers/scsi/libata.h 1.7 vs edited =====
--- 1.7/drivers/scsi/libata.h	Tue Mar 16 02:35:49 2004
+++ edited/drivers/scsi/libata.h	Mon May 17 15:30:11 2004
@@ -37,8 +37,8 @@
 
 
 /* libata-core.c */
-extern unsigned int ata_dev_id_string(struct ata_device *dev, unsigned char *s,
-                               unsigned int ofs, unsigned int len);
+extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+			      unsigned int ofs, unsigned int len);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
@@ -50,9 +50,6 @@
 
 /* libata-scsi.c */
 extern void ata_to_sense_error(struct ata_queued_cmd *qc);
-extern void ata_scsi_rw_queue(struct ata_port *ap, struct ata_device *dev,
-		      struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
-		      unsigned int cmd_size);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
===== drivers/scsi/sata_promise.c 1.29 vs edited =====
--- 1.29/drivers/scsi/sata_promise.c	Thu Mar 18 17:55:44 2004
+++ edited/drivers/scsi/sata_promise.c	Mon May 17 15:30:11 2004
@@ -28,13 +28,14 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/sched.h>
 #include "scsi.h"
 #include "hosts.h"
 #include <linux/libata.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"0.91"
+#define DRV_VERSION	"0.92"
 
 
 enum {
@@ -45,10 +46,13 @@
 	PDC_INT_SEQMASK		= 0x40,	/* Mask of asserted SEQ INTs */
 	PDC_TBG_MODE		= 0x41,	/* TBG mode */
 	PDC_FLASH_CTL		= 0x44, /* Flash control register */
-	PDC_CTLSTAT		= 0x60,	/* IDE control and status register */
+	PDC_PCI_CTL		= 0x48, /* PCI control and status register */
+	PDC_GLOBAL_CTL		= 0x48, /* Global control/status (per port) */
+	PDC_CTLSTAT		= 0x60,	/* IDE control and status (per port) */
 	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
 	PDC_SLEW_CTL		= 0x470, /* slew rate control reg */
 	PDC_HDMA_CTLSTAT	= 0x12C, /* Host DMA control / status */
+
 	PDC_20621_SEQCTL	= 0x400,
 	PDC_20621_SEQMASK	= 0x480,
 	PDC_20621_GENERAL_CTL	= 0x484,
@@ -73,12 +77,19 @@
 
 	PDC_CHIP0_OFS		= 0xC0000, /* offset of chip #0 */
 
+	PDC_20621_ERR_MASK	= (1<<19) | (1<<20) | (1<<21) | (1<<22) |
+				  (1<<23),
+	PDC_ERR_MASK		= (1<<19) | (1<<20) | (1<<21) | (1<<22) |
+				  (1<<8) | (1<<9) | (1<<10),
+
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
 	board_20621		= 2,	/* FastTrak S150 SX4 */
 
+	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
+
 	PDC_FLAG_20621		= (1 << 30), /* we have a 20621 */
-	PDC_HDMA_RESET		= (1 << 11), /* HDMA reset */
+	PDC_RESET		= (1 << 11), /* HDMA reset */
 
 	PDC_MAX_HDMA		= 32,
 	PDC_HDMA_Q_MASK		= (PDC_MAX_HDMA - 1),
@@ -154,13 +165,14 @@
 static void pdc_20621_phy_reset (struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
+static void pdc_phy_reset(struct ata_port *ap);
 static void pdc_fill_sg(struct ata_queued_cmd *qc);
 static void pdc20621_fill_sg(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc20621_host_stop(struct ata_host_set *host_set);
 static inline void pdc_dma_complete (struct ata_port *ap,
-                                     struct ata_queued_cmd *qc);
+                                     struct ata_queued_cmd *qc, int have_err);
 static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe);
 static int pdc20621_detect_dimm(struct ata_probe_ent *pe);
 static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe, 
@@ -199,7 +211,7 @@
 	.tf_read		= ata_tf_read_mmio,
 	.check_status		= ata_check_status_mmio,
 	.exec_command		= pdc_exec_command_mmio,
-	.phy_reset		= sata_phy_reset,
+	.phy_reset		= pdc_phy_reset,
 	.bmdma_start            = pdc_dma_start,
 	.fill_sg		= pdc_fill_sg,
 	.eng_timeout		= pdc_eng_timeout,
@@ -351,6 +363,34 @@
         ata_bus_reset(ap);
 }
 
+static void pdc_reset_port(struct ata_port *ap)
+{
+	void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT;
+	unsigned int i;
+	u32 tmp;
+
+	for (i = 11; i > 0; i--) {
+		tmp = readl(mmio);
+		if (tmp & PDC_RESET)
+			break;
+
+		udelay(100);
+
+		tmp |= PDC_RESET;
+		writel(tmp, mmio);
+	}
+
+	tmp &= ~PDC_RESET;
+	writel(tmp, mmio);
+	readl(mmio);	/* flush */
+}
+
+static void pdc_phy_reset(struct ata_port *ap)
+{
+	pdc_reset_port(ap);
+	sata_phy_reset(ap);
+}
+
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)
@@ -390,12 +430,11 @@
 	 * and seq id (byte 2)
 	 */
 	switch (tf->protocol) {
-	case ATA_PROT_DMA_READ:
-		buf32[0] = cpu_to_le32(PDC_PKT_READ);
-		break;
-
-	case ATA_PROT_DMA_WRITE:
-		buf32[0] = 0;
+	case ATA_PROT_DMA:
+		if (!(tf->flags & ATA_TFLAG_WRITE))
+			buf32[0] = cpu_to_le32(PDC_PKT_READ);
+		else
+			buf32[0] = 0;
 		break;
 
 	case ATA_PROT_NODATA:
@@ -554,7 +593,7 @@
 	/*
 	 * Set up ATA packet
 	 */
-	if (tf->protocol == ATA_PROT_DMA_READ)
+	if ((tf->protocol == ATA_PROT_DMA) && (!(tf->flags & ATA_TFLAG_WRITE)))
 		buf[i++] = PDC_PKT_READ;
 	else if (tf->protocol == ATA_PROT_NODATA)
 		buf[i++] = PDC_PKT_NODATA;
@@ -606,7 +645,7 @@
 	/*
 	 * Set up Host DMA packet
 	 */
-	if (tf->protocol == ATA_PROT_DMA_READ)
+	if ((tf->protocol == ATA_PROT_DMA) && (!(tf->flags & ATA_TFLAG_WRITE)))
 		tmp = PDC_PKT_READ;
 	else
 		tmp = 0;
@@ -768,7 +807,7 @@
 	struct ata_host_set *host_set = ap->host_set;
 	unsigned int port_no = ap->port_no;
 	void *mmio = host_set->mmio_base;
-	unsigned int rw = (qc->flags & ATA_QCFLAG_WRITE);
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
 	u8 seq = (u8) (port_no + 1);
 	unsigned int doing_hdma = 0, port_ofs;
 
@@ -821,13 +860,14 @@
 
 	VPRINTK("ENTER\n");
 
-	switch (qc->tf.protocol) {
-	case ATA_PROT_DMA_READ:
+	if ((qc->tf.protocol == ATA_PROT_DMA) &&	/* read */
+	    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+
 		/* step two - DMA from DIMM to host */
 		if (doing_hdma) {
 			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
-			pdc_dma_complete(ap, qc);
+			pdc_dma_complete(ap, qc, 0);
 			pdc20621_pop_hdma(qc);
 		}
 
@@ -843,9 +883,9 @@
 					   port_ofs + PDC_DIMM_HOST_PKT);
 		}
 		handled = 1;
-		break;
 
-	case ATA_PROT_DMA_WRITE:
+	} else if (qc->tf.protocol == ATA_PROT_DMA) {	/* write */
+
 		/* step one - DMA from host to DIMM */
 		if (doing_hdma) {
 			u8 seq = (u8) (port_no + 1);
@@ -864,25 +904,24 @@
 		else {
 			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
-			pdc_dma_complete(ap, qc);
+			pdc_dma_complete(ap, qc, 0);
 			pdc20621_pop_hdma(qc);
 		}
 		handled = 1;
-		break;
 
-	case ATA_PROT_NODATA:   /* command completion, but no data xfer */
+	/* command completion, but no data xfer */
+	} else if (qc->tf.protocol == ATA_PROT_NODATA) {
+
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
 		ata_qc_complete(qc, status, 0);
 		handled = 1;
-		break;
 
-        default:
-                ap->stats.idle_irq++;
-                break;
-        }
+	} else {
+		ap->stats.idle_irq++;
+	}
 
-        return handled;
+	return handled;
 }
 
 static irqreturn_t pdc20621_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
@@ -918,7 +957,7 @@
 		return IRQ_NONE;
 	}
 
-        spin_lock_irq(&host_set->lock);
+        spin_lock(&host_set->lock);
 
         for (i = 1; i < 9; i++) {
 		port_no = i - 1;
@@ -940,7 +979,7 @@
 		}
 	}
 
-        spin_unlock_irq(&host_set->lock);
+        spin_unlock(&host_set->lock);
 
 	VPRINTK("mask == 0x%x\n", mask);
 
@@ -969,11 +1008,14 @@
 }
 
 static inline void pdc_dma_complete (struct ata_port *ap,
-                                     struct ata_queued_cmd *qc)
+                                     struct ata_queued_cmd *qc,
+				     int have_err)
 {
+	u8 err_bit = have_err ? ATA_ERR : 0;
+
 	/* get drive status; clear intr; complete txn */
 	ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
-			ata_wait_idle(ap), 0);
+			ata_wait_idle(ap) | err_bit, 0);
 }
 
 static void pdc_eng_timeout(struct ata_port *ap)
@@ -999,8 +1041,7 @@
 	qc->scsidone = scsi_finish_command;
 
 	switch (qc->tf.protocol) {
-	case ATA_PROT_DMA_READ:
-	case ATA_PROT_DMA_WRITE:
+	case ATA_PROT_DMA:
 		printk(KERN_ERR "ata%u: DMA timeout\n", ap->id);
 		ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
 			        ata_wait_idle(ap) | ATA_ERR, 0);
@@ -1033,18 +1074,27 @@
                                           struct ata_queued_cmd *qc)
 {
 	u8 status;
-	unsigned int handled = 0;
+	unsigned int handled = 0, have_err = 0;
+	u32 tmp;
+	void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_GLOBAL_CTL;
+
+	tmp = readl(mmio);
+	if (tmp & PDC_ERR_MASK) {
+		have_err = 1;
+		pdc_reset_port(ap);
+	}
 
 	switch (qc->tf.protocol) {
-	case ATA_PROT_DMA_READ:
-	case ATA_PROT_DMA_WRITE:
-		pdc_dma_complete(ap, qc);
+	case ATA_PROT_DMA:
+		pdc_dma_complete(ap, qc, have_err);
 		handled = 1;
 		break;
 
 	case ATA_PROT_NODATA:   /* command completion, but no data xfer */
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
+		if (have_err)
+			status |= ATA_ERR;
 		ata_qc_complete(qc, status, 0);
 		handled = 1;
 		break;
@@ -1088,7 +1138,7 @@
 		return IRQ_NONE;
 	}
 
-        spin_lock_irq(&host_set->lock);
+        spin_lock(&host_set->lock);
 
         for (i = 0; i < host_set->n_ports; i++) {
 		VPRINTK("port %u\n", i);
@@ -1103,7 +1153,7 @@
 		}
 	}
 
-        spin_unlock_irq(&host_set->lock);
+        spin_unlock(&host_set->lock);
 
 	VPRINTK("EXIT\n");
 
@@ -1130,16 +1180,14 @@
 
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	if ((tf->protocol != ATA_PROT_DMA_READ) &&
-	    (tf->protocol != ATA_PROT_DMA_WRITE))
+	if (tf->protocol == ATA_PROT_PIO)
 		ata_tf_load_mmio(ap, tf);
 }
 
 
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	if ((tf->protocol != ATA_PROT_DMA_READ) &&
-	    (tf->protocol != ATA_PROT_DMA_WRITE))
+	if (tf->protocol == ATA_PROT_PIO)
 		ata_exec_command_mmio(ap, tf);
 }
 
@@ -1592,14 +1640,14 @@
 	 * Reset Host DMA
 	 */
 	tmp = readl(mmio + PDC_HDMA_CTLSTAT);
-	tmp |= PDC_HDMA_RESET;
+	tmp |= PDC_RESET;
 	writel(tmp, mmio + PDC_HDMA_CTLSTAT);
 	readl(mmio + PDC_HDMA_CTLSTAT);		/* flush */
 
 	udelay(10);
 
 	tmp = readl(mmio + PDC_HDMA_CTLSTAT);
-	tmp &= ~PDC_HDMA_RESET;
+	tmp &= ~PDC_RESET;
 	writel(tmp, mmio + PDC_HDMA_CTLSTAT);
 	readl(mmio + PDC_HDMA_CTLSTAT);		/* flush */
 }
@@ -1610,14 +1658,18 @@
 	u32 tmp;
 
 	if (chip_id == board_20621)
-		return;
+		BUG();
 
-	/* change FIFO_SHD to 8 dwords. Promise driver does this...
-	 * dunno why.
+	/*
+	 * Except for the hotplug stuff, this is voodoo from the
+	 * Promise driver.  Label this entire section
+	 * "TODO: figure out why we do this"
 	 */
+
+	/* change FIFO_SHD to 8 dwords, enable BMR_BURST */
 	tmp = readl(mmio + PDC_FLASH_CTL);
-	if ((tmp & (1 << 16)) == 0)
-		writel(tmp | (1 << 16), mmio + PDC_FLASH_CTL);
+	tmp |= 0x12000;	/* bit 16 (fifo 8 dw) and 13 (bmr burst?) */
+	writel(tmp, mmio + PDC_FLASH_CTL);
 
 	/* clear plug/unplug flags for all ports */
 	tmp = readl(mmio + PDC_SATA_PLUG_CSR);
@@ -1627,13 +1679,17 @@
 	tmp = readl(mmio + PDC_SATA_PLUG_CSR);
 	writel(tmp | 0xff0000, mmio + PDC_SATA_PLUG_CSR);
 
-	/* reduce TBG clock to 133 Mhz. FIXME: why? */
+	/* reduce TBG clock to 133 Mhz. */
 	tmp = readl(mmio + PDC_TBG_MODE);
 	tmp &= ~0x30000; /* clear bit 17, 16*/
 	tmp |= 0x10000;  /* set bit 17:16 = 0:1 */
 	writel(tmp, mmio + PDC_TBG_MODE);
 
-	/* adjust slew rate control register. FIXME: why? */
+	readl(mmio + PDC_TBG_MODE);	/* flush */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(msecs_to_jiffies(10));
+
+	/* adjust slew rate control register. */
 	tmp = readl(mmio + PDC_SLEW_CTL);
 	tmp &= 0xFFFFF03F; /* clear bit 11 ~ 6 */
 	tmp  |= 0x00000900; /* set bit 11-9 = 100b , bit 8-6 = 100 */
===== drivers/scsi/sata_vsc.c 1.6 vs edited =====
--- 1.6/drivers/scsi/sata_vsc.c	Fri Mar 19 03:19:21 2004
+++ edited/drivers/scsi/sata_vsc.c	Mon May 17 15:30:11 2004
@@ -44,6 +44,8 @@
 #define VSC_SATA_TF_CTL_OFFSET		0x29
 
 /* DMA base */
+#define VSC_SATA_UP_DESCRIPTOR_OFFSET	0x64
+#define VSC_SATA_UP_DATA_BUFFER_OFFSET	0x6C
 #define VSC_SATA_DMA_CMD_OFFSET		0x70
 
 /* SCRs base */
@@ -234,6 +236,8 @@
 	port->ctl_addr		= base + VSC_SATA_TF_CTL_OFFSET;
 	port->bmdma_addr	= base + VSC_SATA_DMA_CMD_OFFSET;
 	port->scr_addr		= base + VSC_SATA_SCR_STATUS_OFFSET;
+	writel(0, base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
+	writel(0, base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
 }
 
 
===== include/linux/ata.h 1.2 vs edited =====
--- 1.2/include/linux/ata.h	Fri Feb 13 13:07:30 2004
+++ edited/include/linux/ata.h	Mon May 17 15:29:45 2004
@@ -102,16 +102,6 @@
 	ATA_REG_DEVSEL		= ATA_REG_DEVICE,
 	ATA_REG_IRQ		= ATA_REG_NSECT,
 
-	/* ATA taskfile protocols */
-	ATA_PROT_UNKNOWN	= 0,
-	ATA_PROT_NODATA		= 1,
-	ATA_PROT_PIO_READ	= 2,
-	ATA_PROT_PIO_WRITE	= 3,
-	ATA_PROT_DMA_READ	= 4,
-	ATA_PROT_DMA_WRITE	= 5,
-	ATA_PROT_ATAPI		= 6,
-	ATA_PROT_ATAPI_DMA	= 7,
-
 	/* ATA device commands */
 	ATA_CMD_EDD		= 0x90,	/* execute device diagnostic */
 	ATA_CMD_ID_ATA		= 0xEC,
@@ -156,13 +146,54 @@
 	SCR_CONTROL		= 2,
 	SCR_ACTIVE		= 3,
 	SCR_NOTIFICATION	= 4,
+
+	/* struct ata_taskfile flags */
+	ATA_TFLAG_LBA48		= (1 << 0), /* enable 48-bit LBA and "HOB" */
+	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
+	ATA_TFLAG_DEVICE	= (1 << 2), /* enable r/w to device reg */
+	ATA_TFLAG_WRITE		= (1 << 3), /* data dir: host->dev==1 (write) */
+};
+
+enum ata_tf_protocols {
+	/* ATA taskfile protocols */
+	ATA_PROT_UNKNOWN,	/* unknown/invalid */
+	ATA_PROT_NODATA,	/* no data */
+	ATA_PROT_PIO,		/* PIO single sector */
+	ATA_PROT_PIO_MULT,	/* PIO multiple sector */
+	ATA_PROT_DMA,		/* DMA */
+	ATA_PROT_ATAPI,		/* packet command */
+	ATA_PROT_ATAPI_DMA,	/* packet command with special DMA sauce */
 };
 
 /* core structures */
+
 struct ata_prd {
 	u32			addr;
 	u32			flags_len;
 } __attribute__((packed));
+
+struct ata_taskfile {
+	unsigned long		flags;		/* ATA_TFLAG_xxx */
+	u8			protocol;	/* ATA_PROT_xxx */
+
+	u8			ctl;		/* control reg */
+
+	u8			hob_feature;	/* additional data */
+	u8			hob_nsect;	/* to support LBA48 */
+	u8			hob_lbal;
+	u8			hob_lbam;
+	u8			hob_lbah;
+
+	u8			feature;
+	u8			nsect;
+	u8			lbal;
+	u8			lbam;
+	u8			lbah;
+
+	u8			device;
+
+	u8			command;	/* IO operation */
+};
 
 #define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
 #define ata_id_has_lba48(dev)	((dev)->id[83] & (1 << 10))
===== include/linux/libata.h 1.15 vs edited =====
--- 1.15/include/linux/libata.h	Thu Mar 18 06:27:31 2004
+++ edited/include/linux/libata.h	Mon May 17 15:29:45 2004
@@ -107,12 +107,6 @@
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 
-	/* struct ata_taskfile flags */
-	ATA_TFLAG_LBA48		= (1 << 0),
-	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
-	ATA_TFLAG_DEVICE	= (1 << 2), /* enable r/w to device reg */
-
-	ATA_QCFLAG_WRITE	= (1 << 0), /* read==0, write==1 */
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_DMA		= (1 << 2), /* data delivered via DMA */
 	ATA_QCFLAG_ATAPI	= (1 << 3), /* is ATAPI packet command? */
@@ -223,29 +217,6 @@
 	struct ata_port *	ports[0];
 };
 
-struct ata_taskfile {
-	unsigned long		flags;		/* ATA_TFLAG_xxx */
-	u8			protocol;	/* ATA_PROT_xxx */
-
-	u8			ctl;		/* control reg */
-
-	u8			hob_feature;	/* additional data */
-	u8			hob_nsect;	/* to support LBA48 */
-	u8			hob_lbal;
-	u8			hob_lbam;
-	u8			hob_lbah;
-
-	u8			feature;
-	u8			nsect;
-	u8			lbal;
-	u8			lbam;
-	u8			lbah;
-
-	u8			device;
-
-	u8			command;	/* IO operation */
-};
-
 struct ata_queued_cmd {
 	struct ata_port		*ap;
 	struct ata_device	*dev;
@@ -293,6 +264,11 @@
 						 * ATAPI7 spec size, 40 ASCII
 						 * characters
 						 */
+
+	/* cache info about current transfer mode */
+	u8			xfer_protocol;	/* taskfile xfer protocol */
+	u8			read_cmd;	/* opcode to use on read */
+	u8			write_cmd;	/* opcode to use on write */
 };
 
 struct ata_engine {
@@ -408,7 +384,6 @@
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern int ata_scsi_release(struct Scsi_Host *host);
-extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 /*
  * Default driver ops implementations
@@ -433,6 +408,7 @@
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
+extern int ata_scsi_slave_config(struct scsi_device *sdev);
 
 
 static inline unsigned long msecs_to_jiffies(unsigned long msecs)

--------------080606060802080608090300--

