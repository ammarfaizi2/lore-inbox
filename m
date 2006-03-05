Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWCEEQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWCEEQc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 23:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWCEEQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 23:16:32 -0500
Received: from havoc.gtf.org ([69.61.125.42]:65174 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750825AbWCEEQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 23:16:29 -0500
Date: Sat, 4 Mar 2006 23:16:25 -0500
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH, WIP] libata iomap usage
Message-ID: <20060305041625.GA13500@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In case anybody is interested, here is the work-in-progress patch
that enables usage of the ioread/iowrite functions from lib/iomap.
This kills a -ton- of duplicate code from libata, illustrating why
I requested this interface so long ago.

It is a WIP because this patch covers the EASY part: coverting the
libata routines to use ioread/iowrite, and killing all those nasty
warnings in every build (top libata complaint).

The HARD part is building the infrastructure that maps the various
PCI BARs and ioports required for each low-level driver.  grep for
'ioport_map_regions' and 'pci_map_bars' the beginning of this work.
We have to do iomap and request region for the following combinations:

1) 1 mmio region in a PCI BAR (easy; done in current upstream)
2) 5-6 ioports in PCI BARs
3) 4 legacy ioports, 1 PCI BAR
4) a mixture of #2 and #3, depending on runtime config
5) #4, with the added complication of PCI quirks reserving regions 
   for us, requiring the ugly ____request_resource() hack

At various points in time, Linus, Al Viro and myself have all done
the easy part, and motivation disappeared before attempting the
hard part.  :)

This time I've gotten a little farther, let's see how long I last...


 drivers/scsi/ahci.c         |   15 -
 drivers/scsi/libata-bmdma.c |  293 +++------------------------
 drivers/scsi/libata-core.c  |  467 +++++++++++++++-----------------------------
 drivers/scsi/pdc_adma.c     |    4 
 drivers/scsi/sata_mv.c      |   13 -
 drivers/scsi/sata_nv.c      |   67 +-----
 drivers/scsi/sata_promise.c |   40 +--
 drivers/scsi/sata_qstor.c   |    9 
 drivers/scsi/sata_sil.c     |   19 -
 drivers/scsi/sata_sil24.c   |   25 +-
 drivers/scsi/sata_sis.c     |    8 
 drivers/scsi/sata_svw.c     |    6 
 drivers/scsi/sata_sx4.c     |   16 -
 drivers/scsi/sata_via.c     |    8 
 drivers/scsi/sata_vsc.c     |   17 -
 include/linux/libata.h      |   56 ++---
 16 files changed, 318 insertions(+), 745 deletions(-)

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1c2ab3d..d9c0ad1 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -305,16 +305,12 @@ static struct pci_driver ahci_pci_driver
 };
 
 
-static inline unsigned long ahci_port_base_ul (unsigned long base, unsigned int port)
+static inline void __iomem *ahci_port_base (void __iomem *base,
+					    unsigned int port)
 {
 	return base + 0x100 + (port * 0x80);
 }
 
-static inline void __iomem *ahci_port_base (void __iomem *base, unsigned int port)
-{
-	return (void __iomem *) ahci_port_base_ul((unsigned long)base, port);
-}
-
 static int ahci_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -823,11 +819,11 @@ static unsigned int ahci_qc_issue(struct
 	return 0;
 }
 
-static void ahci_setup_port(struct ata_ioports *port, unsigned long base,
+static void ahci_setup_port(struct ata_ioports *port, void __iomem *base,
 			    unsigned int port_idx)
 {
 	VPRINTK("ENTER, base==0x%lx, port_idx %u\n", base, port_idx);
-	base = ahci_port_base_ul(base, port_idx);
+	base = ahci_port_base(base, port_idx);
 	VPRINTK("base now==0x%lx\n", base);
 
 	port->cmd_addr		= base;
@@ -926,8 +922,7 @@ static int ahci_host_init(struct ata_pro
 		port_mmio = ahci_port_base(mmio, i);
 		VPRINTK("mmio %p  port_mmio %p\n", mmio, port_mmio);
 
-		ahci_setup_port(&probe_ent->port[i],
-				(unsigned long) mmio, i);
+		ahci_setup_port(&probe_ent->port[i], mmio, i);
 
 		/* make sure port is not active */
 		tmp = readl(port_mmio + PORT_CMD);
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index a93336a..08ca07a 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -40,7 +40,7 @@
 #include "libata.h"
 
 /**
- *	ata_tf_load_pio - send taskfile registers to host controller
+ *	ata_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
  *
@@ -50,81 +50,23 @@
  *	Inherited from caller.
  */
 
-static void ata_tf_load_pio(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
-
-	if (tf->ctl != ap->last_ctl) {
-		outb(tf->ctl, ioaddr->ctl_addr);
-		ap->last_ctl = tf->ctl;
-		ata_wait_idle(ap);
-	}
-
-	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		outb(tf->hob_feature, ioaddr->feature_addr);
-		outb(tf->hob_nsect, ioaddr->nsect_addr);
-		outb(tf->hob_lbal, ioaddr->lbal_addr);
-		outb(tf->hob_lbam, ioaddr->lbam_addr);
-		outb(tf->hob_lbah, ioaddr->lbah_addr);
-		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->hob_feature,
-			tf->hob_nsect,
-			tf->hob_lbal,
-			tf->hob_lbam,
-			tf->hob_lbah);
-	}
-
-	if (is_addr) {
-		outb(tf->feature, ioaddr->feature_addr);
-		outb(tf->nsect, ioaddr->nsect_addr);
-		outb(tf->lbal, ioaddr->lbal_addr);
-		outb(tf->lbam, ioaddr->lbam_addr);
-		outb(tf->lbah, ioaddr->lbah_addr);
-		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
-			tf->feature,
-			tf->nsect,
-			tf->lbal,
-			tf->lbam,
-			tf->lbah);
-	}
-
-	if (tf->flags & ATA_TFLAG_DEVICE) {
-		outb(tf->device, ioaddr->device_addr);
-		VPRINTK("device 0x%X\n", tf->device);
-	}
-
-	ata_wait_idle(ap);
-}
-
-/**
- *	ata_tf_load_mmio - send taskfile registers to host controller
- *	@ap: Port to which output is sent
- *	@tf: ATA taskfile register set
- *
- *	Outputs ATA taskfile to standard ATA host controller using MMIO.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
+void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
 	if (tf->ctl != ap->last_ctl) {
-		writeb(tf->ctl, (void __iomem *) ap->ioaddr.ctl_addr);
+		iowrite8(tf->ctl, ioaddr->ctl_addr);
 		ap->last_ctl = tf->ctl;
 		ata_wait_idle(ap);
 	}
 
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writeb(tf->hob_feature, (void __iomem *) ioaddr->feature_addr);
-		writeb(tf->hob_nsect, (void __iomem *) ioaddr->nsect_addr);
-		writeb(tf->hob_lbal, (void __iomem *) ioaddr->lbal_addr);
-		writeb(tf->hob_lbam, (void __iomem *) ioaddr->lbam_addr);
-		writeb(tf->hob_lbah, (void __iomem *) ioaddr->lbah_addr);
+		iowrite8(tf->hob_feature, ioaddr->feature_addr);
+		iowrite8(tf->hob_nsect, ioaddr->nsect_addr);
+		iowrite8(tf->hob_lbal, ioaddr->lbal_addr);
+		iowrite8(tf->hob_lbam, ioaddr->lbam_addr);
+		iowrite8(tf->hob_lbah, ioaddr->lbah_addr);
 		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
 			tf->hob_feature,
 			tf->hob_nsect,
@@ -134,11 +76,11 @@ static void ata_tf_load_mmio(struct ata_
 	}
 
 	if (is_addr) {
-		writeb(tf->feature, (void __iomem *) ioaddr->feature_addr);
-		writeb(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
-		writeb(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
-		writeb(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
-		writeb(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
+		iowrite8(tf->feature, ioaddr->feature_addr);
+		iowrite8(tf->nsect, ioaddr->nsect_addr);
+		iowrite8(tf->lbal, ioaddr->lbal_addr);
+		iowrite8(tf->lbam, ioaddr->lbam_addr);
+		iowrite8(tf->lbah, ioaddr->lbah_addr);
 		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
 			tf->feature,
 			tf->nsect,
@@ -148,45 +90,15 @@ static void ata_tf_load_mmio(struct ata_
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE) {
-		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
+		iowrite8(tf->device, ioaddr->device_addr);
 		VPRINTK("device 0x%X\n", tf->device);
 	}
 
 	ata_wait_idle(ap);
 }
 
-
 /**
- *	ata_tf_load - send taskfile registers to host controller
- *	@ap: Port to which output is sent
- *	@tf: ATA taskfile register set
- *
- *	Outputs ATA taskfile to standard ATA host controller using MMIO
- *	or PIO as indicated by the ATA_FLAG_MMIO flag.
- *	Writes the control, feature, nsect, lbal, lbam, and lbah registers.
- *	Optionally (ATA_TFLAG_LBA48) writes hob_feature, hob_nsect,
- *	hob_lbal, hob_lbam, and hob_lbah.
- *
- *	This function waits for idle (!BUSY and !DRQ) after writing
- *	registers.  If the control register has a new value, this
- *	function also waits for idle after writing control and before
- *	writing the remaining registers.
- *
- *	May be used as the tf_load() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	if (ap->flags & ATA_FLAG_MMIO)
-		ata_tf_load_mmio(ap, tf);
-	else
-		ata_tf_load_pio(ap, tf);
-}
-
-/**
- *	ata_exec_command_pio - issue ATA command to host controller
+ *	ata_exec_command - issue ATA command to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
  *
@@ -197,57 +109,17 @@ void ata_tf_load(struct ata_port *ap, co
  *	spin_lock_irqsave(host_set lock)
  */
 
-static void ata_exec_command_pio(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
-
-       	outb(tf->command, ap->ioaddr.command_addr);
-	ata_pause(ap);
-}
-
-
-/**
- *	ata_exec_command_mmio - issue ATA command to host controller
- *	@ap: port to which command is being issued
- *	@tf: ATA taskfile register set
- *
- *	Issues MMIO write to ATA command register, with proper
- *	synchronization with interrupt handler / other threads.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
+void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
 
-       	writeb(tf->command, (void __iomem *) ap->ioaddr.command_addr);
+	iowrite8(tf->command, ap->ioaddr.command_addr);
 	ata_pause(ap);
 }
 
 
 /**
- *	ata_exec_command - issue ATA command to host controller
- *	@ap: port to which command is being issued
- *	@tf: ATA taskfile register set
- *
- *	Issues PIO/MMIO write to ATA command register, with proper
- *	synchronization with interrupt handler / other threads.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	if (ap->flags & ATA_FLAG_MMIO)
-		ata_exec_command_mmio(ap, tf);
-	else
-		ata_exec_command_pio(ap, tf);
-}
-
-/**
- *	ata_tf_read_pio - input device's ATA taskfile shadow registers
+ *	ata_tf_read - input device's ATA taskfile shadow registers
  *	@ap: Port from which input is read
  *	@tf: ATA taskfile register set for storing input
  *
@@ -258,120 +130,28 @@ void ata_exec_command(struct ata_port *a
  *	Inherited from caller.
  */
 
-static void ata_tf_read_pio(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	tf->command = ata_check_status(ap);
-	tf->feature = inb(ioaddr->error_addr);
-	tf->nsect = inb(ioaddr->nsect_addr);
-	tf->lbal = inb(ioaddr->lbal_addr);
-	tf->lbam = inb(ioaddr->lbam_addr);
-	tf->lbah = inb(ioaddr->lbah_addr);
-	tf->device = inb(ioaddr->device_addr);
-
-	if (tf->flags & ATA_TFLAG_LBA48) {
-		outb(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
-		tf->hob_feature = inb(ioaddr->error_addr);
-		tf->hob_nsect = inb(ioaddr->nsect_addr);
-		tf->hob_lbal = inb(ioaddr->lbal_addr);
-		tf->hob_lbam = inb(ioaddr->lbam_addr);
-		tf->hob_lbah = inb(ioaddr->lbah_addr);
-	}
-}
-
-/**
- *	ata_tf_read_mmio - input device's ATA taskfile shadow registers
- *	@ap: Port from which input is read
- *	@tf: ATA taskfile register set for storing input
- *
- *	Reads ATA taskfile registers for currently-selected device
- *	into @tf via MMIO.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_tf_read_mmio(struct ata_port *ap, struct ata_taskfile *tf)
+void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	tf->command = ata_check_status(ap);
-	tf->feature = readb((void __iomem *)ioaddr->error_addr);
-	tf->nsect = readb((void __iomem *)ioaddr->nsect_addr);
-	tf->lbal = readb((void __iomem *)ioaddr->lbal_addr);
-	tf->lbam = readb((void __iomem *)ioaddr->lbam_addr);
-	tf->lbah = readb((void __iomem *)ioaddr->lbah_addr);
-	tf->device = readb((void __iomem *)ioaddr->device_addr);
+	tf->feature = ioread8(ioaddr->error_addr);
+	tf->nsect = ioread8(ioaddr->nsect_addr);
+	tf->lbal = ioread8(ioaddr->lbal_addr);
+	tf->lbam = ioread8(ioaddr->lbam_addr);
+	tf->lbah = ioread8(ioaddr->lbah_addr);
+	tf->device = ioread8(ioaddr->device_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		writeb(tf->ctl | ATA_HOB, (void __iomem *) ap->ioaddr.ctl_addr);
-		tf->hob_feature = readb((void __iomem *)ioaddr->error_addr);
-		tf->hob_nsect = readb((void __iomem *)ioaddr->nsect_addr);
-		tf->hob_lbal = readb((void __iomem *)ioaddr->lbal_addr);
-		tf->hob_lbam = readb((void __iomem *)ioaddr->lbam_addr);
-		tf->hob_lbah = readb((void __iomem *)ioaddr->lbah_addr);
+		iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
+		tf->hob_feature = ioread8(ioaddr->error_addr);
+		tf->hob_nsect = ioread8(ioaddr->nsect_addr);
+		tf->hob_lbal = ioread8(ioaddr->lbal_addr);
+		tf->hob_lbam = ioread8(ioaddr->lbam_addr);
+		tf->hob_lbah = ioread8(ioaddr->lbah_addr);
 	}
 }
 
-
-/**
- *	ata_tf_read - input device's ATA taskfile shadow registers
- *	@ap: Port from which input is read
- *	@tf: ATA taskfile register set for storing input
- *
- *	Reads ATA taskfile registers for currently-selected device
- *	into @tf.
- *
- *	Reads nsect, lbal, lbam, lbah, and device.  If ATA_TFLAG_LBA48
- *	is set, also reads the hob registers.
- *
- *	May be used as the tf_read() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	if (ap->flags & ATA_FLAG_MMIO)
-		ata_tf_read_mmio(ap, tf);
-	else
-		ata_tf_read_pio(ap, tf);
-}
-
-/**
- *	ata_check_status_pio - Read device status reg & clear interrupt
- *	@ap: port where the device is
- *
- *	Reads ATA taskfile status register for currently-selected device
- *	and return its value. This also clears pending interrupts
- *      from this device
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-static u8 ata_check_status_pio(struct ata_port *ap)
-{
-	return inb(ap->ioaddr.status_addr);
-}
-
-/**
- *	ata_check_status_mmio - Read device status reg & clear interrupt
- *	@ap: port where the device is
- *
- *	Reads ATA taskfile status register for currently-selected device
- *	via MMIO and return its value. This also clears pending interrupts
- *      from this device
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-static u8 ata_check_status_mmio(struct ata_port *ap)
-{
-       	return readb((void __iomem *) ap->ioaddr.status_addr);
-}
-
-
 /**
  *	ata_check_status - Read device status reg & clear interrupt
  *	@ap: port where the device is
@@ -380,19 +160,14 @@ static u8 ata_check_status_mmio(struct a
  *	and return its value. This also clears pending interrupts
  *      from this device
  *
- *	May be used as the check_status() entry in ata_port_operations.
- *
  *	LOCKING:
  *	Inherited from caller.
  */
 u8 ata_check_status(struct ata_port *ap)
 {
-	if (ap->flags & ATA_FLAG_MMIO)
-		return ata_check_status_mmio(ap);
-	return ata_check_status_pio(ap);
+	return ioread8(ap->ioaddr.status_addr);
 }
 
-
 /**
  *	ata_altstatus - Read device alternate status reg
  *	@ap: port where the device is
@@ -411,9 +186,7 @@ u8 ata_altstatus(struct ata_port *ap)
 	if (ap->ops->check_altstatus)
 		return ap->ops->check_altstatus(ap);
 
-	if (ap->flags & ATA_FLAG_MMIO)
-		return readb((void __iomem *)ap->ioaddr.altstatus_addr);
-	return inb(ap->ioaddr.altstatus_addr);
+	return ioread8(ap->ioaddr.altstatus_addr);
 }
 
 #ifdef CONFIG_PCI
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b710fc4..f0a5b49 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -286,51 +286,7 @@ out:
 }
 
 /**
- *	ata_pio_devchk - PATA device presence detection
- *	@ap: ATA channel to examine
- *	@device: Device to examine (starting at zero)
- *
- *	This technique was originally described in
- *	Hale Landis's ATADRVR (www.ata-atapi.com), and
- *	later found its way into the ATA/ATAPI spec.
- *
- *	Write a pattern to the ATA shadow registers,
- *	and if a device is present, it will respond by
- *	correctly storing and echoing back the
- *	ATA shadow register contents.
- *
- *	LOCKING:
- *	caller.
- */
-
-static unsigned int ata_pio_devchk(struct ata_port *ap,
-				   unsigned int device)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 nsect, lbal;
-
-	ap->ops->dev_select(ap, device);
-
-	outb(0x55, ioaddr->nsect_addr);
-	outb(0xaa, ioaddr->lbal_addr);
-
-	outb(0xaa, ioaddr->nsect_addr);
-	outb(0x55, ioaddr->lbal_addr);
-
-	outb(0x55, ioaddr->nsect_addr);
-	outb(0xaa, ioaddr->lbal_addr);
-
-	nsect = inb(ioaddr->nsect_addr);
-	lbal = inb(ioaddr->lbal_addr);
-
-	if ((nsect == 0x55) && (lbal == 0xaa))
-		return 1;	/* we found a device */
-
-	return 0;		/* nothing found */
-}
-
-/**
- *	ata_mmio_devchk - PATA device presence detection
+ *	ata_devchk - PATA device presence detection
  *	@ap: ATA channel to examine
  *	@device: Device to examine (starting at zero)
  *
@@ -347,25 +303,24 @@ static unsigned int ata_pio_devchk(struc
  *	caller.
  */
 
-static unsigned int ata_mmio_devchk(struct ata_port *ap,
-				    unsigned int device)
+static unsigned int ata_devchk(struct ata_port *ap, unsigned int device)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u8 nsect, lbal;
 
 	ap->ops->dev_select(ap, device);
 
-	writeb(0x55, (void __iomem *) ioaddr->nsect_addr);
-	writeb(0xaa, (void __iomem *) ioaddr->lbal_addr);
+	iowrite8(0x55, ioaddr->nsect_addr);
+	iowrite8(0xaa, ioaddr->lbal_addr);
 
-	writeb(0xaa, (void __iomem *) ioaddr->nsect_addr);
-	writeb(0x55, (void __iomem *) ioaddr->lbal_addr);
+	iowrite8(0xaa, ioaddr->nsect_addr);
+	iowrite8(0x55, ioaddr->lbal_addr);
 
-	writeb(0x55, (void __iomem *) ioaddr->nsect_addr);
-	writeb(0xaa, (void __iomem *) ioaddr->lbal_addr);
+	iowrite8(0x55, ioaddr->nsect_addr);
+	iowrite8(0xaa, ioaddr->lbal_addr);
 
-	nsect = readb((void __iomem *) ioaddr->nsect_addr);
-	lbal = readb((void __iomem *) ioaddr->lbal_addr);
+	nsect = ioread8(ioaddr->nsect_addr);
+	lbal = ioread8(ioaddr->lbal_addr);
 
 	if ((nsect == 0x55) && (lbal == 0xaa))
 		return 1;	/* we found a device */
@@ -374,27 +329,6 @@ static unsigned int ata_mmio_devchk(stru
 }
 
 /**
- *	ata_devchk - PATA device presence detection
- *	@ap: ATA channel to examine
- *	@device: Device to examine (starting at zero)
- *
- *	Dispatch ATA device presence detection, depending
- *	on whether we are using PIO or MMIO to talk to the
- *	ATA shadow registers.
- *
- *	LOCKING:
- *	caller.
- */
-
-static unsigned int ata_devchk(struct ata_port *ap,
-				    unsigned int device)
-{
-	if (ap->flags & ATA_FLAG_MMIO)
-		return ata_mmio_devchk(ap, device);
-	return ata_pio_devchk(ap, device);
-}
-
-/**
  *	ata_dev_classify - determine device type based on ATA-spec signature
  *	@tf: ATA taskfile register set for device to be identified
  *
@@ -608,11 +542,7 @@ void ata_std_dev_select (struct ata_port
 	else
 		tmp = ATA_DEVICE_OBS | ATA_DEV1;
 
-	if (ap->flags & ATA_FLAG_MMIO) {
-		writeb(tmp, (void __iomem *) ap->ioaddr.device_addr);
-	} else {
-		outb(tmp, ap->ioaddr.device_addr);
-	}
+	iowrite8(tmp, ap->ioaddr.device_addr);
 	ata_pause(ap);		/* needed; also flushes, for mmio */
 }
 
@@ -1795,13 +1725,8 @@ static void ata_bus_post_reset(struct at
 		u8 nsect, lbal;
 
 		ap->ops->dev_select(ap, 1);
-		if (ap->flags & ATA_FLAG_MMIO) {
-			nsect = readb((void __iomem *) ioaddr->nsect_addr);
-			lbal = readb((void __iomem *) ioaddr->lbal_addr);
-		} else {
-			nsect = inb(ioaddr->nsect_addr);
-			lbal = inb(ioaddr->lbal_addr);
-		}
+		nsect = ioread8(ioaddr->nsect_addr);
+		lbal = ioread8(ioaddr->lbal_addr);
 		if ((nsect == 1) && (lbal == 1))
 			break;
 		if (time_after(jiffies, timeout)) {
@@ -1868,19 +1793,11 @@ static unsigned int ata_bus_softreset(st
 	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
 
 	/* software reset.  causes dev0 to be selected */
-	if (ap->flags & ATA_FLAG_MMIO) {
-		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-		udelay(20);	/* FIXME: flush */
-		writeb(ap->ctl | ATA_SRST, (void __iomem *) ioaddr->ctl_addr);
-		udelay(20);	/* FIXME: flush */
-		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-	} else {
-		outb(ap->ctl, ioaddr->ctl_addr);
-		udelay(10);
-		outb(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
-		udelay(10);
-		outb(ap->ctl, ioaddr->ctl_addr);
-	}
+	iowrite8(ap->ctl, ioaddr->ctl_addr);
+	udelay(20);	/* FIXME: flush */
+	iowrite8(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
+	udelay(20);	/* FIXME: flush */
+	iowrite8(ap->ctl, ioaddr->ctl_addr);
 
 	/* spec mandates ">= 2ms" before checking status.
 	 * We wait 150ms, because that was the magic delay used for
@@ -1948,10 +1865,7 @@ void ata_bus_reset(struct ata_port *ap)
 		rc = ata_bus_softreset(ap, devmask);
 	else if ((ap->flags & ATA_FLAG_SATA_RESET) == 0) {
 		/* set up device control */
-		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-		else
-			outb(ap->ctl, ioaddr->ctl_addr);
+		iowrite8(ap->ctl, ioaddr->ctl_addr);
 		rc = ata_bus_edd(ap);
 	}
 
@@ -1982,10 +1896,7 @@ void ata_bus_reset(struct ata_port *ap)
 
 	if (ap->flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST)) {
 		/* set up device control for ATA_FLAG_SATA_RESET */
-		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-		else
-			outb(ap->ctl, ioaddr->ctl_addr);
+		iowrite8(ap->ctl, ioaddr->ctl_addr);
 	}
 
 	DPRINTK("EXIT\n");
@@ -2198,12 +2109,8 @@ void ata_std_postreset(struct ata_port *
 	}
 
 	/* set up device control */
-	if (ap->ioaddr.ctl_addr) {
-		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, (void __iomem *) ap->ioaddr.ctl_addr);
-		else
-			outb(ap->ctl, ap->ioaddr.ctl_addr);
-	}
+	if (ap->ioaddr.ctl_addr)
+		iowrite8(ap->ctl, ap->ioaddr.ctl_addr);
 
 	DPRINTK("EXIT\n");
 }
@@ -3086,52 +2993,7 @@ void swap_buf_le16(u16 *buf, unsigned in
 }
 
 /**
- *	ata_mmio_data_xfer - Transfer data by MMIO
- *	@ap: port to read/write
- *	@buf: data buffer
- *	@buflen: buffer length
- *	@write_data: read/write
- *
- *	Transfer data from/to the device data register by MMIO.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_mmio_data_xfer(struct ata_port *ap, unsigned char *buf,
-			       unsigned int buflen, int write_data)
-{
-	unsigned int i;
-	unsigned int words = buflen >> 1;
-	u16 *buf16 = (u16 *) buf;
-	void __iomem *mmio = (void __iomem *)ap->ioaddr.data_addr;
-
-	/* Transfer multiple of 2 bytes */
-	if (write_data) {
-		for (i = 0; i < words; i++)
-			writew(le16_to_cpu(buf16[i]), mmio);
-	} else {
-		for (i = 0; i < words; i++)
-			buf16[i] = cpu_to_le16(readw(mmio));
-	}
-
-	/* Transfer trailing 1 byte, if any. */
-	if (unlikely(buflen & 0x01)) {
-		u16 align_buf[1] = { 0 };
-		unsigned char *trailing_buf = buf + buflen - 1;
-
-		if (write_data) {
-			memcpy(align_buf, trailing_buf, 1);
-			writew(le16_to_cpu(align_buf[0]), mmio);
-		} else {
-			align_buf[0] = cpu_to_le16(readw(mmio));
-			memcpy(trailing_buf, align_buf, 1);
-		}
-	}
-}
-
-/**
- *	ata_pio_data_xfer - Transfer data by PIO
+ *	__ata_data_xfer - Transfer data by PIO
  *	@ap: port to read/write
  *	@buf: data buffer
  *	@buflen: buffer length
@@ -3143,16 +3005,16 @@ static void ata_mmio_data_xfer(struct at
  *	Inherited from caller.
  */
 
-static void ata_pio_data_xfer(struct ata_port *ap, unsigned char *buf,
-			      unsigned int buflen, int write_data)
+static void __ata_data_xfer(struct ata_port *ap, unsigned char *buf,
+			    unsigned int buflen, int write_data)
 {
 	unsigned int words = buflen >> 1;
 
 	/* Transfer multiple of 2 bytes */
 	if (write_data)
-		outsw(ap->ioaddr.data_addr, buf, words);
+		iowrite16_rep(ap->ioaddr.data_addr, buf, words);
 	else
-		insw(ap->ioaddr.data_addr, buf, words);
+		ioread16_rep(ap->ioaddr.data_addr, buf, words);
 
 	/* Transfer trailing 1 byte, if any. */
 	if (unlikely(buflen & 0x01)) {
@@ -3161,9 +3023,9 @@ static void ata_pio_data_xfer(struct ata
 
 		if (write_data) {
 			memcpy(align_buf, trailing_buf, 1);
-			outw(le16_to_cpu(align_buf[0]), ap->ioaddr.data_addr);
+			iowrite16(le16_to_cpu(align_buf[0]), ap->ioaddr.data_addr);
 		} else {
-			align_buf[0] = cpu_to_le16(inw(ap->ioaddr.data_addr));
+			align_buf[0] = cpu_to_le16(ioread16(ap->ioaddr.data_addr));
 			memcpy(trailing_buf, align_buf, 1);
 		}
 	}
@@ -3189,17 +3051,10 @@ static void ata_data_xfer(struct ata_por
 	if (unlikely(ap->flags & ATA_FLAG_IRQ_MASK)) {
 		unsigned long flags;
 		local_irq_save(flags);
-		if (ap->flags & ATA_FLAG_MMIO)
-			ata_mmio_data_xfer(ap, buf, buflen, do_write);
-		else
-			ata_pio_data_xfer(ap, buf, buflen, do_write);
+		__ata_data_xfer(ap, buf, buflen, do_write);
 		local_irq_restore(flags);
-	} else {
-		if (ap->flags & ATA_FLAG_MMIO)
-			ata_mmio_data_xfer(ap, buf, buflen, do_write);
-		else
-			ata_pio_data_xfer(ap, buf, buflen, do_write);
-	}
+	} else
+		__ata_data_xfer(ap, buf, buflen, do_write);
 }
 
 /**
@@ -3830,52 +3685,51 @@ unsigned int ata_qc_issue_prot(struct at
 }
 
 /**
- *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction
+ *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction (PIO)
  *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-static void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc)
+void ata_bmdma_setup (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
 	u8 dmactl;
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 
 	/* load PRD table addr. */
 	mb();	/* make sure PRD table writes are visible to controller */
-	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
+	iowrite32(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
 
 	/* specify data direction, triple-check start bit is clear */
-	dmactl = readb(mmio + ATA_DMA_CMD);
+	dmactl = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
 	if (!rw)
 		dmactl |= ATA_DMA_WR;
-	writeb(dmactl, mmio + ATA_DMA_CMD);
+	iowrite8(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	/* issue r/w command */
 	ap->ops->exec_command(ap, &qc->tf);
 }
 
 /**
- *	ata_bmdma_start_mmio - Start a PCI IDE BMDMA transaction
+ *	ata_bmdma_start - Start a PCI IDE BMDMA transaction (PIO)
  *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-static void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
+void ata_bmdma_start (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 	u8 dmactl;
 
 	/* start host DMA transaction */
-	dmactl = readb(mmio + ATA_DMA_CMD);
-	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
+	dmactl = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	iowrite8(dmactl | ATA_DMA_START,
+		 ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	/* Strictly, one may wish to issue a readb() here, to
 	 * flush the mmio write.  However, control also passes
@@ -3890,95 +3744,6 @@ static void ata_bmdma_start_mmio (struct
 	 */
 }
 
-/**
- *	ata_bmdma_setup_pio - Set up PCI IDE BMDMA transaction (PIO)
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 dmactl;
-
-	/* load PRD table addr. */
-	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
-
-	/* specify data direction, triple-check start bit is clear */
-	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
-	if (!rw)
-		dmactl |= ATA_DMA_WR;
-	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-
-	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
-}
-
-/**
- *	ata_bmdma_start_pio - Start a PCI IDE BMDMA transaction (PIO)
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	u8 dmactl;
-
-	/* start host DMA transaction */
-	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	outb(dmactl | ATA_DMA_START,
-	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-}
-
-
-/**
- *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	Writes the ATA_DMA_START flag to the DMA command register.
- *
- *	May be used as the bmdma_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-void ata_bmdma_start(struct ata_queued_cmd *qc)
-{
-	if (qc->ap->flags & ATA_FLAG_MMIO)
-		ata_bmdma_start_mmio(qc);
-	else
-		ata_bmdma_start_pio(qc);
-}
-
-
-/**
- *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	Writes address of PRD table to device's PRD Table Address
- *	register, sets the DMA control register, and calls
- *	ops->exec_command() to start the transfer.
- *
- *	May be used as the bmdma_setup() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-void ata_bmdma_setup(struct ata_queued_cmd *qc)
-{
-	if (qc->ap->flags & ATA_FLAG_MMIO)
-		ata_bmdma_setup_mmio(qc);
-	else
-		ata_bmdma_setup_pio(qc);
-}
-
 
 /**
  *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
@@ -3994,14 +3759,8 @@ void ata_bmdma_setup(struct ata_queued_c
 
 void ata_bmdma_irq_clear(struct ata_port *ap)
 {
-    if (ap->flags & ATA_FLAG_MMIO) {
-        void __iomem *mmio = ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
-        writeb(readb(mmio), mmio);
-    } else {
-        unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
-        outb(inb(addr), addr);
-    }
-
+	void __iomem *mmio = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
+	iowrite8(ioread8(mmio), mmio);
 }
 
 
@@ -4019,13 +3778,7 @@ void ata_bmdma_irq_clear(struct ata_port
 
 u8 ata_bmdma_status(struct ata_port *ap)
 {
-	u8 host_stat;
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-		host_stat = readb(mmio + ATA_DMA_STATUS);
-	} else
-		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	return host_stat;
+	return ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 }
 
 
@@ -4044,17 +3797,11 @@ u8 ata_bmdma_status(struct ata_port *ap)
 void ata_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+	void __iomem *mmio = ap->ioaddr.bmdma_addr;
 
-		/* clear start/stop bit */
-		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
-			mmio + ATA_DMA_CMD);
-	} else {
-		/* clear start/stop bit */
-		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
-			ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	}
+	/* clear start/stop bit */
+	iowrite8(ioread8(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
+		 mmio + ATA_DMA_CMD);
 
 	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
 	ata_altstatus(ap);        /* dummy read */
@@ -4591,8 +4338,8 @@ int ata_device_add(const struct ata_prob
 				(ap->pio_mask << ATA_SHIFT_PIO);
 
 		/* print per-port info to dmesg */
-		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
-				 "bmdma 0x%lX irq %lu\n",
+		printk(KERN_INFO "ata%u: %cATA max %s cmd %p ctl %p "
+				 "bmdma %p irq %lu\n",
 			ap->id,
 			ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
 			ata_mode_string(xfer_mode_mask),
@@ -4842,6 +4589,118 @@ int pci_test_config_bits(struct pci_dev 
 	return (tmp == bits->val) ? 1 : 0;
 }
 
+struct ioport_map {
+	unsigned long		port;
+	unsigned long		size;
+	void __iomem		*addr;
+};
+
+struct pci_map {
+	void __iomem		*addr[DEVICE_COUNT_RESOURCE];
+	unsigned int		bar_mask;
+
+	struct ioport_map	ioports[DEVICE_COUNT_RESOURCE];
+};
+
+void ioport_unmap_regions(struct ioport_map *ports)
+{
+	int i;
+
+	for (i = 0; ; i++) {
+		if (!ports[i].port || !ports[i].size)
+			break;
+		if (!ports[i].addr)
+			continue;
+		ioport_unmap(ports[i].addr);
+		release_region(ports[i].port, ports[i].size);
+	}
+}
+
+int ioport_map_regions(struct ioport_map *ports, const char *res_name)
+{
+	int i, rc;
+
+	for (i = 0; ; i++) {
+		void __iomem *mem;
+
+		if (!ports[i].port || !ports[i].size)
+			break;
+
+		if (!request_region(ports[i].port, ports[i].size, res_name)) {
+			rc = -EBUSY;
+			goto err_out;
+		}
+
+		mem = ioport_map(ports[i].port, ports[i].size);
+		if (!mem) {
+			release_region(ports[i].port, ports[i].size);
+			rc = -ENOMEM;
+			goto err_out;
+		}
+
+		ports[i].addr = mem;
+	}
+
+	return 0;
+
+err_out:
+	ioport_unmap_regions(ports);
+	return rc;
+}
+
+void pci_unmap_bars(struct pci_dev *pdev, struct pci_map *map)
+{
+	int i;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
+		if ((map->bar_mask & (1 << i)) && (map->addr[i]))
+			pci_iounmap(pdev, map->addr[i]);
+
+	pci_release_regions(pdev);
+
+	ioport_unmap_regions(map->ioports);
+}
+
+int pci_map_bars(struct pci_dev *pdev, struct pci_map *map,
+		 const char *res_name)
+{
+	int rc, i;
+
+	rc = ioport_map_regions(map->ioports, res_name);
+	if (rc)
+		return rc;
+
+	rc = pci_request_regions(pdev, res_name);
+	if (rc) {
+		ioport_unmap_regions(map->ioports);
+		return rc;
+	}
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		void __iomem *mem;
+
+		if (!(map->bar_mask & (1 << i)))
+			continue;
+		if (!pci_resource_start(pdev, i) ||
+		    !pci_resource_len(pdev, i))
+			continue;
+
+		mem = pci_iomap(pdev, i, 0);
+		if (!mem) {
+			rc = -ENOMEM;
+			goto err_out;
+		}
+
+		map->addr[i] = mem;
+	}
+
+	return 0;
+
+err_out:
+	pci_unmap_bars(pdev, map);
+	return rc;
+}
+
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	pci_save_state(pdev);
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 5f33cc9..83545f7 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -524,7 +524,7 @@ static irqreturn_t adma_intr(int irq, vo
 	return IRQ_RETVAL(handled);
 }
 
-static void adma_ata_setup_port(struct ata_ioports *port, unsigned long base)
+static void adma_ata_setup_port(struct ata_ioports *port, void __iomem *base)
 {
 	port->cmd_addr		=
 	port->data_addr		= base + 0x000;
@@ -696,7 +696,7 @@ static int adma_ata_init_one(struct pci_
 
 	for (port_no = 0; port_no < probe_ent->n_ports; ++port_no) {
 		adma_ata_setup_port(&probe_ent->port[port_no],
-			ADMA_ATA_REGS((unsigned long)mmio_base, port_no));
+			ADMA_ATA_REGS(mmio_base, port_no));
 	}
 
 	pci_set_master(pdev);
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index aceaf56..70b5fb2 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1383,8 +1383,7 @@ static void mv_host_intr(struct ata_host
 		} else if ((DEV_IRQ << hard_port) & hc_irq_cause) {
 			/* received ATA IRQ; read the status reg to clear INTRQ
 			 */
-			ata_status = readb((void __iomem *)
-					   ap->ioaddr.status_addr);
+			ata_status = readb(ap->ioaddr.status_addr);
 			handled++;
 		}
 
@@ -1977,10 +1976,10 @@ comreset_retry:
 			break;
 	}
 
-	tf.lbah = readb((void __iomem *) ap->ioaddr.lbah_addr);
-	tf.lbam = readb((void __iomem *) ap->ioaddr.lbam_addr);
-	tf.lbal = readb((void __iomem *) ap->ioaddr.lbal_addr);
-	tf.nsect = readb((void __iomem *) ap->ioaddr.nsect_addr);
+	tf.lbah = readb(ap->ioaddr.lbah_addr);
+	tf.lbam = readb(ap->ioaddr.lbam_addr);
+	tf.lbal = readb(ap->ioaddr.lbal_addr);
+	tf.nsect = readb(ap->ioaddr.nsect_addr);
 
 	dev->class = ata_dev_classify(&tf);
 	if (!ata_dev_present(dev)) {
@@ -2045,7 +2044,7 @@ static void mv_eng_timeout(struct ata_po
  */
 static void mv_port_init(struct ata_ioports *port,  void __iomem *port_mmio)
 {
-	unsigned long shd_base = (unsigned long) port_mmio + SHD_BLK_OFS;
+	void __iomem *shd_base = port_mmio + SHD_BLK_OFS;
 	unsigned serr_ofs;
 
 	/* PIO related setup
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index caffadc..2cabdc9 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -175,8 +175,6 @@ static const struct pci_device_id nv_pci
 	{ 0, } /* terminate list */
 };
 
-#define NV_HOST_FLAGS_SCR_MMIO	0x00000001
-
 struct nv_host_desc
 {
 	enum nv_host_type	host_type;
@@ -333,30 +331,18 @@ static irqreturn_t nv_interrupt (int irq
 
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
-	struct ata_host_set *host_set = ap->host_set;
-	struct nv_host *host = host_set->private_data;
-
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		return readl((void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
-	else
-		return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	return ioread32(ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
-	struct ata_host_set *host_set = ap->host_set;
-	struct nv_host *host = host_set->private_data;
-
 	if (sc_reg > SCR_CONTROL)
 		return;
 
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		writel(val, (void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
-	else
-		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void nv_host_stop (struct ata_host_set *host_set)
@@ -380,6 +366,7 @@ static int nv_init_one (struct pci_dev *
 	struct nv_host *host;
 	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
+	void __iomem *base;
 	int pci_dev_busy = 0;
 	int rc;
 	u32 bar;
@@ -427,31 +414,16 @@ static int nv_init_one (struct pci_dev *
 
 	probe_ent->private_data = host;
 
-	if (pci_resource_flags(pdev, 5) & IORESOURCE_MEM)
-		host->host_flags |= NV_HOST_FLAGS_SCR_MMIO;
-
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
-		unsigned long base;
-
-		probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
-		if (probe_ent->mmio_base == NULL) {
-			rc = -EIO;
-			goto err_out_free_host;
-		}
+	probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
+	if (probe_ent->mmio_base == NULL) {
+		rc = -EIO;
+		goto err_out_free_host;
+	}
 
-		base = (unsigned long)probe_ent->mmio_base;
+	base = probe_ent->mmio_base;
 
-		probe_ent->port[0].scr_addr =
-			base + NV_PORT0_SCR_REG_OFFSET;
-		probe_ent->port[1].scr_addr =
-			base + NV_PORT1_SCR_REG_OFFSET;
-	} else {
-
-		probe_ent->port[0].scr_addr =
-			pci_resource_start(pdev, 5) | NV_PORT0_SCR_REG_OFFSET;
-		probe_ent->port[1].scr_addr =
-			pci_resource_start(pdev, 5) | NV_PORT1_SCR_REG_OFFSET;
-	}
+	probe_ent->port[0].scr_addr = base + NV_PORT0_SCR_REG_OFFSET;
+	probe_ent->port[1].scr_addr = base + NV_PORT1_SCR_REG_OFFSET;
 
 	pci_set_master(pdev);
 
@@ -468,8 +440,7 @@ static int nv_init_one (struct pci_dev *
 	return 0;
 
 err_out_iounmap:
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		pci_iounmap(pdev, probe_ent->mmio_base);
+	pci_iounmap(pdev, probe_ent->mmio_base);
 err_out_free_host:
 	kfree(host);
 err_out_free_ent:
@@ -487,34 +458,34 @@ static void nv_enable_hotplug(struct ata
 {
 	u8 intr_mask;
 
-	outb(NV_INT_STATUS_HOTPLUG,
+	iowrite8(NV_INT_STATUS_HOTPLUG,
 		probe_ent->port[0].scr_addr + NV_INT_STATUS);
 
-	intr_mask = inb(probe_ent->port[0].scr_addr + NV_INT_ENABLE);
+	intr_mask = ioread8(probe_ent->port[0].scr_addr + NV_INT_ENABLE);
 	intr_mask |= NV_INT_ENABLE_HOTPLUG;
 
-	outb(intr_mask, probe_ent->port[0].scr_addr + NV_INT_ENABLE);
+	iowrite8(intr_mask, probe_ent->port[0].scr_addr + NV_INT_ENABLE);
 }
 
 static void nv_disable_hotplug(struct ata_host_set *host_set)
 {
 	u8 intr_mask;
 
-	intr_mask = inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
+	intr_mask = ioread8(host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
 
 	intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
 
-	outb(intr_mask, host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
+	iowrite8(intr_mask, host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
 }
 
 static int nv_check_hotplug(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
-	intr_status = inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
+	intr_status = ioread8(host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
 
 	// Clear interrupt status.
-	outb(0xff, host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
+	iowrite8(0xff, host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
 
 	if (intr_status & NV_INT_STATUS_HOTPLUG) {
 		if (intr_status & NV_INT_STATUS_PDEV_ADDED)
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 84cb394..3577d71 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -339,7 +339,7 @@ static void pdc_host_stop(struct ata_hos
 
 static void pdc_reset_port(struct ata_port *ap)
 {
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT;
+	void __iomem *mmio = ap->ioaddr.cmd_addr + PDC_CTLSTAT;
 	unsigned int i;
 	u32 tmp;
 
@@ -380,7 +380,7 @@ static u32 pdc_sata_scr_read (struct ata
 {
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
-	return readl((void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
+	return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 
@@ -389,7 +389,7 @@ static void pdc_sata_scr_write (struct a
 {
 	if (sc_reg > SCR_CONTROL)
 		return;
-	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
+	writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void pdc_qc_prep(struct ata_queued_cmd *qc)
@@ -462,7 +462,7 @@ static inline unsigned int pdc_host_intr
 {
 	unsigned int handled = 0;
 	u32 tmp;
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_GLOBAL_CTL;
+	void __iomem *mmio = ap->ioaddr.cmd_addr + PDC_GLOBAL_CTL;
 
 	tmp = readl(mmio);
 	if (tmp & PDC_ERR_MASK) {
@@ -565,8 +565,8 @@ static inline void pdc_packet_start(stru
 
 	pp->pkt[2] = seq;
 	wmb();			/* flush PRD, pkt writes */
-	writel(pp->pkt_dma, (void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
-	readl((void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT); /* flush */
+	writel(pp->pkt_dma, ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
+	readl(ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT); /* flush */
 }
 
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
@@ -604,7 +604,7 @@ static void pdc_exec_command_mmio(struct
 }
 
 
-static void pdc_ata_setup_port(struct ata_ioports *port, unsigned long base)
+static void pdc_ata_setup_port(struct ata_ioports *port, void __iomem *base)
 {
 	port->cmd_addr		= base;
 	port->data_addr		= base;
@@ -669,7 +669,6 @@ static int pdc_ata_init_one (struct pci_
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	struct pdc_host_priv *hp;
-	unsigned long base;
 	void __iomem *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
@@ -713,7 +712,6 @@ static int pdc_ata_init_one (struct pci_
 		rc = -ENOMEM;
 		goto err_out_free_ent;
 	}
-	base = (unsigned long) mmio_base;
 
 	hp = kzalloc(sizeof(*hp), GFP_KERNEL);
 	if (hp == NULL) {
@@ -736,11 +734,11 @@ static int pdc_ata_init_one (struct pci_
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->mmio_base = mmio_base;
 
-	pdc_ata_setup_port(&probe_ent->port[0], base + 0x200);
-	pdc_ata_setup_port(&probe_ent->port[1], base + 0x280);
+	pdc_ata_setup_port(&probe_ent->port[0], mmio_base + 0x200);
+	pdc_ata_setup_port(&probe_ent->port[1], mmio_base + 0x280);
 
-	probe_ent->port[0].scr_addr = base + 0x400;
-	probe_ent->port[1].scr_addr = base + 0x500;
+	probe_ent->port[0].scr_addr = mmio_base + 0x400;
+	probe_ent->port[1].scr_addr = mmio_base + 0x500;
 
 	/* notice 4-port boards */
 	switch (board_idx) {
@@ -751,11 +749,11 @@ static int pdc_ata_init_one (struct pci_
 	case board_20319:
        		probe_ent->n_ports = 4;
 
-		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
-		pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
+		pdc_ata_setup_port(&probe_ent->port[2], mmio_base + 0x300);
+		pdc_ata_setup_port(&probe_ent->port[3], mmio_base + 0x380);
 
-		probe_ent->port[2].scr_addr = base + 0x600;
-		probe_ent->port[3].scr_addr = base + 0x700;
+		probe_ent->port[2].scr_addr = mmio_base + 0x600;
+		probe_ent->port[3].scr_addr = mmio_base + 0x700;
 		break;
 	case board_2057x:
 		/* Override hotplug offset for SATAII150 */
@@ -770,11 +768,11 @@ static int pdc_ata_init_one (struct pci_
 	case board_20619:
 		probe_ent->n_ports = 4;
 
-		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
-		pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
+		pdc_ata_setup_port(&probe_ent->port[2], mmio_base + 0x300);
+		pdc_ata_setup_port(&probe_ent->port[3], mmio_base + 0x380);
 
-		probe_ent->port[2].scr_addr = base + 0x600;
-		probe_ent->port[3].scr_addr = base + 0x700;
+		probe_ent->port[2].scr_addr = mmio_base + 0x600;
+		probe_ent->port[3].scr_addr = mmio_base + 0x700;
 		break;
 	default:
 		BUG();
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 9602f43..e2a438c 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -258,14 +258,14 @@ static u32 qs_scr_read (struct ata_port 
 {
 	if (sc_reg > SCR_CONTROL)
 		return ~0U;
-	return readl((void __iomem *)(ap->ioaddr.scr_addr + (sc_reg * 8)));
+	return readl(ap->ioaddr.scr_addr + (sc_reg * 8));
 }
 
 static void qs_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	if (sc_reg > SCR_CONTROL)
 		return;
-	writel(val, (void __iomem *)(ap->ioaddr.scr_addr + (sc_reg * 8)));
+	writel(val, ap->ioaddr.scr_addr + (sc_reg * 8));
 }
 
 static unsigned int qs_fill_sg(struct ata_queued_cmd *qc)
@@ -472,7 +472,7 @@ static irqreturn_t qs_intr(int irq, void
 	return IRQ_RETVAL(handled);
 }
 
-static void qs_ata_setup_port(struct ata_ioports *port, unsigned long base)
+static void qs_ata_setup_port(struct ata_ioports *port, void __iomem *base)
 {
 	port->cmd_addr		=
 	port->data_addr		= base + 0x400;
@@ -686,8 +686,7 @@ static int qs_ata_init_one(struct pci_de
 	probe_ent->n_ports	= QS_PORTS;
 
 	for (port_no = 0; port_no < probe_ent->n_ports; ++port_no) {
-		unsigned long chan = (unsigned long)mmio_base +
-							(port_no * 0x4000);
+		void __iomem *chan = mmio_base + (port_no * 0x4000);
 		qs_ata_setup_port(&probe_ent->port[port_no], chan);
 	}
 
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index cdf800e..cf2d653 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -287,9 +287,9 @@ static void sil_post_set_mode (struct at
 	readl(addr);	/* flush */
 }
 
-static inline unsigned long sil_scr_addr(struct ata_port *ap, unsigned int sc_reg)
+static inline void __iomem *sil_scr_addr(struct ata_port *ap, unsigned int sc_reg)
 {
-	unsigned long offset = ap->ioaddr.scr_addr;
+	void __iomem *offset = ap->ioaddr.scr_addr;
 
 	switch (sc_reg) {
 	case SCR_STATUS:
@@ -308,7 +308,7 @@ static inline unsigned long sil_scr_addr
 
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
-	void __iomem *mmio = (void __iomem *) sil_scr_addr(ap, sc_reg);
+	void __iomem *mmio = sil_scr_addr(ap, sc_reg);
 	if (mmio)
 		return readl(mmio);
 	return 0xffffffffU;
@@ -316,7 +316,7 @@ static u32 sil_scr_read (struct ata_port
 
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
-	void *mmio = (void __iomem *) sil_scr_addr(ap, sc_reg);
+	void __iomem *mmio = sil_scr_addr(ap, sc_reg);
 	if (mmio)
 		writel(val, mmio);
 }
@@ -386,7 +386,6 @@ static int sil_init_one (struct pci_dev 
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
-	unsigned long base;
 	void __iomem *mmio_base;
 	int rc;
 	unsigned int i;
@@ -445,14 +444,12 @@ static int sil_init_one (struct pci_dev 
 
 	probe_ent->mmio_base = mmio_base;
 
-	base = (unsigned long) mmio_base;
-
 	for (i = 0; i < probe_ent->n_ports; i++) {
-		probe_ent->port[i].cmd_addr = base + sil_port[i].tf;
+		probe_ent->port[i].cmd_addr = mmio_base + sil_port[i].tf;
 		probe_ent->port[i].altstatus_addr =
-		probe_ent->port[i].ctl_addr = base + sil_port[i].ctl;
-		probe_ent->port[i].bmdma_addr = base + sil_port[i].bmdma;
-		probe_ent->port[i].scr_addr = base + sil_port[i].scr;
+		probe_ent->port[i].ctl_addr = mmio_base + sil_port[i].ctl;
+		probe_ent->port[i].bmdma_addr = mmio_base + sil_port[i].bmdma;
+		probe_ent->port[i].scr_addr = mmio_base + sil_port[i].scr;
 		ata_std_ports(&probe_ent->port[i]);
 	}
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 5c5822e..00ac8db 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -369,7 +369,7 @@ static struct ata_port_info sil24_port_i
 
 static void sil24_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
-	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	void __iomem *port = ap->ioaddr.cmd_addr;
 
 	if (dev->cdb_len == 16)
 		writel(PORT_CS_CDB16, port + PORT_CTRL_STAT);
@@ -380,7 +380,7 @@ static void sil24_dev_config(struct ata_
 static inline void sil24_update_tf(struct ata_port *ap)
 {
 	struct sil24_port_priv *pp = ap->private_data;
-	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	void __iomem *port = ap->ioaddr.cmd_addr;
 	struct sil24_prb __iomem *prb = port;
 	u8 fis[6 * 4];
 
@@ -403,7 +403,7 @@ static int sil24_scr_map[] = {
 
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg)
 {
-	void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
+	void __iomem *scr_addr = ap->ioaddr.scr_addr;
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
 		void __iomem *addr;
 		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
@@ -414,7 +414,7 @@ static u32 sil24_scr_read(struct ata_por
 
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 {
-	void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
+	void __iomem *scr_addr = ap->ioaddr.scr_addr;
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
 		void __iomem *addr;
 		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
@@ -431,7 +431,7 @@ static void sil24_tf_read(struct ata_por
 static int sil24_softreset(struct ata_port *ap, int verbose,
 			   unsigned int *class)
 {
-	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	void __iomem *port = ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
@@ -570,7 +570,7 @@ static void sil24_qc_prep(struct ata_que
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	void __iomem *port = ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
 	dma_addr_t paddr = pp->cmd_block_dma + qc->tag * sizeof(*pp->cmd_block);
 
@@ -603,7 +603,7 @@ static int __sil24_restart_controller(vo
 
 static void sil24_restart_controller(struct ata_port *ap)
 {
-	if (__sil24_restart_controller((void __iomem *)ap->ioaddr.cmd_addr))
+	if (__sil24_restart_controller(ap->ioaddr.cmd_addr))
 		printk(KERN_ERR DRV_NAME
 		       " ata%u: failed to restart controller\n", ap->id);
 }
@@ -638,7 +638,7 @@ static void sil24_reset_controller(struc
 {
 	printk(KERN_NOTICE DRV_NAME
 	       " ata%u: resetting controller...\n", ap->id);
-	if (__sil24_reset_controller((void __iomem *)ap->ioaddr.cmd_addr))
+	if (__sil24_reset_controller(ap->ioaddr.cmd_addr))
                 printk(KERN_ERR DRV_NAME
                        " ata%u: failed to reset controller\n", ap->id);
 }
@@ -660,7 +660,7 @@ static void sil24_error_intr(struct ata_
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	struct sil24_port_priv *pp = ap->private_data;
-	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	void __iomem *port = ap->ioaddr.cmd_addr;
 	u32 irq_stat, cmd_err, sstatus, serror;
 	unsigned int err_mask;
 
@@ -717,7 +717,7 @@ static void sil24_error_intr(struct ata_
 static inline void sil24_host_intr(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
-	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	void __iomem *port = ap->ioaddr.cmd_addr;
 	u32 slot_stat;
 
 	slot_stat = readl(port + PORT_SLOT_STAT);
@@ -934,12 +934,11 @@ static int sil24_init_one(struct pci_dev
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
 		void __iomem *port = port_base + i * PORT_REGS_SIZE;
-		unsigned long portu = (unsigned long)port;
 		u32 tmp;
 		int cnt;
 
-		probe_ent->port[i].cmd_addr = portu + PORT_PRB;
-		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
+		probe_ent->port[i].cmd_addr = port + PORT_PRB;
+		probe_ent->port[i].scr_addr = port + PORT_SCONTROL;
 
 		ata_std_ports(&probe_ent->port[i]);
 
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 7fd45f8..2970eee 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -207,10 +207,10 @@ static u32 sis_scr_read (struct ata_port
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
 
-	val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	val = ioread32(ap->ioaddr.scr_addr + (sc_reg * 4));
 
 	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
-		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
+		val2 = ioread32(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
 
 	return val | val2;
 }
@@ -228,9 +228,9 @@ static void sis_scr_write (struct ata_po
 	if (ap->flags & SIS_FLAG_CFGSCR)
 		sis_scr_cfg_write(ap, sc_reg, val);
 	else {
-		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+		iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 		if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
-			outl(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
+			iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
 	}
 }
 
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 4aaccd5..f04b2f4 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -330,7 +330,7 @@ static const struct ata_port_operations 
 	.host_stop		= ata_pci_host_stop,
 };
 
-static void k2_sata_setup_port(struct ata_ioports *port, unsigned long base)
+static void k2_sata_setup_port(struct ata_ioports *port, void __iomem *base)
 {
 	port->cmd_addr		= base + K2_SATA_TF_CMD_OFFSET;
 	port->data_addr		= base + K2_SATA_TF_DATA_OFFSET;
@@ -354,7 +354,6 @@ static int k2_sata_init_one (struct pci_
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
-	unsigned long base;
 	void __iomem *mmio_base;
 	int pci_dev_busy = 0;
 	int rc;
@@ -406,7 +405,6 @@ static int k2_sata_init_one (struct pci_
 		rc = -ENOMEM;
 		goto err_out_free_ent;
 	}
-	base = (unsigned long) mmio_base;
 
 	/* Clear a magic bit in SCR1 according to Darwin, those help
 	 * some funky seagate drives (though so far, those were already
@@ -439,7 +437,7 @@ static int k2_sata_init_one (struct pci_
 	/* All ports are on the same function. Multi-function device is no
 	 * longer available. This should not be seen in any system. */
 	for (i = 0; i < ent->driver_data; i++)
-		k2_sata_setup_port(&probe_ent->port[i], base + i * K2_SATA_PORT_OFFSET);
+		k2_sata_setup_port(&probe_ent->port[i], mmio_base + i * K2_SATA_PORT_OFFSET);
 
 	pci_set_master(pdev);
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 9f8a768..4f4d5ca 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -669,8 +669,8 @@ static void pdc20621_packet_start(struct
 		readl(mmio + PDC_20621_SEQCTL + (seq * 4));	/* flush */
 
 		writel(port_ofs + PDC_DIMM_ATA_PKT,
-		       (void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
-		readl((void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
+		       ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
+		readl(ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
 		VPRINTK("submitted ofs 0x%x (%u), seq %u\n",
 			port_ofs + PDC_DIMM_ATA_PKT,
 			port_ofs + PDC_DIMM_ATA_PKT,
@@ -748,8 +748,8 @@ static inline unsigned int pdc20621_host
 			writel(0x00000001, mmio + PDC_20621_SEQCTL + (seq * 4));
 			readl(mmio + PDC_20621_SEQCTL + (seq * 4));
 			writel(port_ofs + PDC_DIMM_ATA_PKT,
-			       (void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
-			readl((void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
+			       ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
+			readl(ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
 		}
 
 		/* step two - execute ATA command */
@@ -905,7 +905,7 @@ static void pdc_exec_command_mmio(struct
 }
 
 
-static void pdc_sata_setup_port(struct ata_ioports *port, unsigned long base)
+static void pdc_sata_setup_port(struct ata_ioports *port, void __iomem *base)
 {
 	port->cmd_addr		= base;
 	port->data_addr		= base;
@@ -1366,8 +1366,7 @@ static int pdc_sata_init_one (struct pci
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
-	unsigned long base;
-	void __iomem *mmio_base;
+	void __iomem *mmio_base, *base;
 	void __iomem *dimm_mmio = NULL;
 	struct pdc_host_priv *hpriv = NULL;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
@@ -1408,12 +1407,11 @@ static int pdc_sata_init_one (struct pci
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = pci_iomap(pdev, 3, 0);
+	base = mmio_base = pci_iomap(pdev, 3, 0);
 	if (mmio_base == NULL) {
 		rc = -ENOMEM;
 		goto err_out_free_ent;
 	}
-	base = (unsigned long) mmio_base;
 
 	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index ff65a0b..188c2d6 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -159,14 +159,14 @@ static u32 svia_scr_read (struct ata_por
 {
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
-	return inl(ap->ioaddr.scr_addr + (4 * sc_reg));
+	return ioread32(ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	if (sc_reg > SCR_CONTROL)
 		return;
-	outl(val, ap->ioaddr.scr_addr + (4 * sc_reg));
+	iowrite32(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
 static const unsigned int svia_bar_sizes[] = {
@@ -177,12 +177,12 @@ static const unsigned int vt6421_bar_siz
 	16, 16, 16, 16, 32, 128
 };
 
-static unsigned long svia_scr_addr(unsigned long addr, unsigned int port)
+static void __iomem *svia_scr_addr(void __iomem *addr, unsigned int port)
 {
 	return addr + (port * 128);
 }
 
-static unsigned long vt6421_scr_addr(unsigned long addr, unsigned int port)
+static void __iomem *vt6421_scr_addr(void __iomem *addr, unsigned int port)
 {
 	return addr + (port * 64);
 }
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index b574379..3978499 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -99,7 +99,7 @@ static u32 vsc_sata_scr_read (struct ata
 {
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
-	return readl((void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
+	return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 
@@ -108,7 +108,7 @@ static void vsc_sata_scr_write (struct a
 {
 	if (sc_reg > SCR_CONTROL)
 		return;
-	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
+	writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 
@@ -290,7 +290,8 @@ static const struct ata_port_operations 
 	.host_stop		= ata_pci_host_stop,
 };
 
-static void __devinit vsc_sata_setup_port(struct ata_ioports *port, unsigned long base)
+static void __devinit vsc_sata_setup_port(struct ata_ioports *port,
+					  void __iomem *base)
 {
 	port->cmd_addr		= base + VSC_SATA_TF_CMD_OFFSET;
 	port->data_addr		= base + VSC_SATA_TF_DATA_OFFSET;
@@ -316,7 +317,6 @@ static int __devinit vsc_sata_init_one (
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
-	unsigned long base;
 	int pci_dev_busy = 0;
 	void __iomem *mmio_base;
 	int rc;
@@ -366,7 +366,6 @@ static int __devinit vsc_sata_init_one (
 		rc = -ENOMEM;
 		goto err_out_free_ent;
 	}
-	base = (unsigned long) mmio_base;
 
 	/*
 	 * Due to a bug in the chip, the default cache line size can't be used
@@ -390,10 +389,10 @@ static int __devinit vsc_sata_init_one (
 	probe_ent->udma_mask = 0x7f;
 
 	/* We have 4 ports per PCI function */
-	vsc_sata_setup_port(&probe_ent->port[0], base + 1 * VSC_SATA_PORT_OFFSET);
-	vsc_sata_setup_port(&probe_ent->port[1], base + 2 * VSC_SATA_PORT_OFFSET);
-	vsc_sata_setup_port(&probe_ent->port[2], base + 3 * VSC_SATA_PORT_OFFSET);
-	vsc_sata_setup_port(&probe_ent->port[3], base + 4 * VSC_SATA_PORT_OFFSET);
+	vsc_sata_setup_port(&probe_ent->port[0], mmio_base + 1 * VSC_SATA_PORT_OFFSET);
+	vsc_sata_setup_port(&probe_ent->port[1], mmio_base + 2 * VSC_SATA_PORT_OFFSET);
+	vsc_sata_setup_port(&probe_ent->port[2], mmio_base + 3 * VSC_SATA_PORT_OFFSET);
+	vsc_sata_setup_port(&probe_ent->port[3], mmio_base + 4 * VSC_SATA_PORT_OFFSET);
 
 	pci_set_master(pdev);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 86a504f..3e346e9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -239,21 +239,21 @@ typedef int (*ata_reset_fn_t)(struct ata
 typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *);
 
 struct ata_ioports {
-	unsigned long		cmd_addr;
-	unsigned long		data_addr;
-	unsigned long		error_addr;
-	unsigned long		feature_addr;
-	unsigned long		nsect_addr;
-	unsigned long		lbal_addr;
-	unsigned long		lbam_addr;
-	unsigned long		lbah_addr;
-	unsigned long		device_addr;
-	unsigned long		status_addr;
-	unsigned long		command_addr;
-	unsigned long		altstatus_addr;
-	unsigned long		ctl_addr;
-	unsigned long		bmdma_addr;
-	unsigned long		scr_addr;
+	void __iomem		*cmd_addr;
+	void __iomem		*data_addr;
+	void __iomem		*error_addr;
+	void __iomem		*feature_addr;
+	void __iomem		*nsect_addr;
+	void __iomem		*lbal_addr;
+	void __iomem		*lbam_addr;
+	void __iomem		*lbah_addr;
+	void __iomem		*device_addr;
+	void __iomem		*status_addr;
+	void __iomem		*command_addr;
+	void __iomem		*altstatus_addr;
+	void __iomem		*ctl_addr;
+	void __iomem		*bmdma_addr;
+	void __iomem		*scr_addr;
 };
 
 struct ata_probe_ent {
@@ -718,9 +718,9 @@ static inline u8 ata_wait_idle(struct at
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
 	if (status & (ATA_BUSY | ATA_DRQ)) {
-		unsigned long l = ap->ioaddr.status_addr;
+		void __iomem *l = ap->ioaddr.status_addr;
 		if (ata_msg_warn(ap))
-			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
+			printk(KERN_WARNING "ATA: abnormal status 0x%X on port %p\n",
 				status, l);
 	}
 
@@ -801,10 +801,7 @@ static inline u8 ata_irq_on(struct ata_p
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
-	if (ap->flags & ATA_FLAG_MMIO)
-		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-	else
-		outb(ap->ctl, ioaddr->ctl_addr);
+	iowrite8(ap->ctl, ioaddr->ctl_addr);
 	tmp = ata_wait_idle(ap);
 
 	ap->ops->irq_clear(ap);
@@ -835,20 +832,11 @@ static inline u8 ata_irq_ack(struct ata_
 			printk(KERN_ERR "abnormal status 0x%X\n", status);
 
 	/* get controller status; clear intr, err bits */
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-		host_stat = readb(mmio + ATA_DMA_STATUS);
-		writeb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-		       mmio + ATA_DMA_STATUS);
-
-		post_stat = readb(mmio + ATA_DMA_STATUS);
-	} else {
-		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-		outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-		     ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	host_stat = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	iowrite8(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
+		 ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 
-		post_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	}
+	post_stat = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 
 	if (ata_msg_intr(ap))
 		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
