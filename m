Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVF1RMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVF1RMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVF1RMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:12:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:57303 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262151AbVF1Q7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:59:37 -0400
Message-ID: <42C181F5.6090606@pobox.com>
Date: Tue, 28 Jun 2005 12:59:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x libata updates
Content-Type: multipart/mixed;
 boundary="------------050202000002060706090002"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050202000002060706090002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

please pull from branch 'upstream-20050628-1' of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the changes described in the attachment.


--------------050202000002060706090002
Content-Type: text/plain;
 name="libata-dev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev.txt"



 Documentation/DocBook/libata.tmpl |   96 ++++++++++++++++++++++++++++++++++++--
 drivers/scsi/ahci.c               |   22 +-------
 drivers/scsi/libata-core.c        |    6 +-
 3 files changed, 101 insertions(+), 23 deletions(-)


Edward Falk:
  Minor libata documentation patch

Jeff Garzik:
  libata: update DMA blacklist

Tejun Heo:
  libata: ahci: remove ata_port_start/stop() calls
  libata: lengthen COMMRESET delay



diff --git a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
--- a/Documentation/DocBook/libata.tmpl
+++ b/Documentation/DocBook/libata.tmpl
@@ -84,6 +84,14 @@ void (*port_disable) (struct ata_port *)
 	Called from ata_bus_probe() and ata_bus_reset() error paths,
 	as well as when unregistering from the SCSI module (rmmod, hot
 	unplug).
+	This function should do whatever needs to be done to take the
+	port out of use.  In most cases, ata_port_disable() can be used
+	as this hook.
+	</para>
+	<para>
+	Called from ata_bus_probe() on a failed probe.
+	Called from ata_bus_reset() on a failed bus reset.
+	Called from ata_scsi_release().
 	</para>
 
 	</sect2>
@@ -98,6 +106,13 @@ void (*dev_config) (struct ata_port *, s
 	found.  Typically used to apply device-specific fixups prior to
 	issue of SET FEATURES - XFER MODE, and prior to operation.
 	</para>
+	<para>
+	Called by ata_device_add() after ata_dev_identify() determines
+	a device is present.
+	</para>
+	<para>
+	This entry may be specified as NULL in ata_port_operations.
+	</para>
 
 	</sect2>
 
@@ -135,6 +150,8 @@ void (*tf_read) (struct ata_port *ap, st
 	registers / DMA buffers.  ->tf_read() is called to read the
 	hardware registers / DMA buffers, to obtain the current set of
 	taskfile register values.
+	Most drivers for taskfile-based hardware (PIO or MMIO) use
+	ata_tf_load() and ata_tf_read() for these hooks.
 	</para>
 
 	</sect2>
@@ -147,6 +164,8 @@ void (*exec_command)(struct ata_port *ap
 	<para>
 	causes an ATA command, previously loaded with
 	->tf_load(), to be initiated in hardware.
+	Most drivers for taskfile-based hardware use ata_exec_command()
+	for this hook.
 	</para>
 
 	</sect2>
@@ -161,6 +180,10 @@ Allow low-level driver to filter ATA PAC
 indicating whether or not it is OK to use DMA for the supplied PACKET
 command.
 	</para>
+	<para>
+	This hook may be specified as NULL, in which case libata will
+	assume that atapi dma can be supported.
+	</para>
 
 	</sect2>
 
@@ -175,6 +198,14 @@ u8   (*check_err)(struct ata_port *ap);
 	Reads the Status/AltStatus/Error ATA shadow register from
 	hardware.  On some hardware, reading the Status register has
 	the side effect of clearing the interrupt condition.
+	Most drivers for taskfile-based hardware use
+	ata_check_status() for this hook.
+	</para>
+	<para>
+	Note that because this is called from ata_device_add(), at
+	least a dummy function that clears device interrupts must be
+	provided for all drivers, even if the controller doesn't
+	actually have a taskfile status register.
 	</para>
 
 	</sect2>
@@ -188,7 +219,13 @@ void (*dev_select)(struct ata_port *ap, 
 	Issues the low-level hardware command(s) that causes one of N
 	hardware devices to be considered 'selected' (active and
 	available for use) on the ATA bus.  This generally has no
-meaning on FIS-based devices.
+	meaning on FIS-based devices.
+	</para>
+	<para>
+	Most drivers for taskfile-based hardware use
+	ata_std_dev_select() for this hook.  Controllers which do not
+	support second drives on a port (such as SATA contollers) will
+	use ata_noop_dev_select().
 	</para>
 
 	</sect2>
@@ -204,6 +241,8 @@ void (*phy_reset) (struct ata_port *ap);
 	for device presence (PATA and SATA), typically a soft reset
 	(SRST) will be performed.  Drivers typically use the helper
 	functions ata_bus_reset() or sata_phy_reset() for this hook.
+	Many SATA drivers use sata_phy_reset() or call it from within
+	their own phy_reset() functions.
 	</para>
 
 	</sect2>
@@ -227,6 +266,25 @@ PCI IDE DMA Status register.
 These hooks are typically either no-ops, or simply not implemented, in
 FIS-based drivers.
 	</para>
+	<para>
+Most legacy IDE drivers use ata_bmdma_setup() for the bmdma_setup()
+hook.  ata_bmdma_setup() will write the pointer to the PRD table to
+the IDE PRD Table Address register, enable DMA in the DMA Command
+register, and call exec_command() to begin the transfer.
+	</para>
+	<para>
+Most legacy IDE drivers use ata_bmdma_start() for the bmdma_start()
+hook.  ata_bmdma_start() will write the ATA_DMA_START flag to the DMA
+Command register.
+	</para>
+	<para>
+Many legacy IDE drivers use ata_bmdma_stop() for the bmdma_stop()
+hook.  ata_bmdma_stop() clears the ATA_DMA_START flag in the DMA
+command register.
+	</para>
+	<para>
+Many legacy IDE drivers use ata_bmdma_status() as the bmdma_status() hook.
+	</para>
 
 	</sect2>
 
@@ -250,6 +308,10 @@ int (*qc_issue) (struct ata_queued_cmd *
 	helper function ata_qc_issue_prot() for taskfile protocol-based
 	dispatch.  More advanced drivers implement their own ->qc_issue.
 	</para>
+	<para>
+	ata_qc_issue_prot() calls ->tf_load(), ->bmdma_setup(), and
+	->bmdma_start() as necessary to initiate a transfer.
+	</para>
 
 	</sect2>
 
@@ -279,6 +341,21 @@ void (*irq_clear) (struct ata_port *);
 	before the interrupt handler is registered, to be sure hardware
 	is quiet.
 	</para>
+	<para>
+	The second argument, dev_instance, should be cast to a pointer
+	to struct ata_host_set.
+	</para>
+	<para>
+	Most legacy IDE drivers use ata_interrupt() for the
+	irq_handler hook, which scans all ports in the host_set,
+	determines which queued command was active (if any), and calls
+	ata_host_intr(ap,qc).
+	</para>
+	<para>
+	Most legacy IDE drivers use ata_bmdma_irq_clear() for the
+	irq_clear() hook, which simply clears the interrupt and error
+	flags in the DMA status register.
+	</para>
 
 	</sect2>
 
@@ -292,6 +369,7 @@ void (*scr_write) (struct ata_port *ap, 
 	<para>
 	Read and write standard SATA phy registers.  Currently only used
 	if ->phy_reset hook called the sata_phy_reset() helper function.
+	sc_reg is one of SCR_STATUS, SCR_CONTROL, SCR_ERROR, or SCR_ACTIVE.
 	</para>
 
 	</sect2>
@@ -307,17 +385,29 @@ void (*host_stop) (struct ata_host_set *
 	->port_start() is called just after the data structures for each
 	port are initialized.  Typically this is used to alloc per-port
 	DMA buffers / tables / rings, enable DMA engines, and similar
-	tasks.  
+	tasks.  Some drivers also use this entry point as a chance to
+	allocate driver-private memory for ap->private_data.
+	</para>
+	<para>
+	Many drivers use ata_port_start() as this hook or call
+	it from their own port_start() hooks.  ata_port_start()
+	allocates space for a legacy IDE PRD table and returns.
 	</para>
 	<para>
 	->port_stop() is called after ->host_stop().  It's sole function
 	is to release DMA/memory resources, now that they are no longer
-	actively being used.
+	actively being used.  Many drivers also free driver-private
+	data from port at this time.
+	</para>
+	<para>
+	Many drivers use ata_port_stop() as this hook, which frees the
+	PRD table.
 	</para>
 	<para>
 	->host_stop() is called after all ->port_stop() calls
 have completed.  The hook must finalize hardware shutdown, release DMA
 and other resources, etc.
+	This hook may be specified as NULL, in which case it is not called.
 	</para>
 
 	</sect2>
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -304,26 +304,19 @@ static int ahci_port_start(struct ata_po
 	struct device *dev = ap->host_set->dev;
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
 	struct ahci_port_priv *pp;
-	int rc;
 	void *mem, *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
 	dma_addr_t mem_dma;
 
-	rc = ata_port_start(ap);
-	if (rc)
-		return rc;
-
 	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
-	if (!pp) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
+	if (!pp)
+		return -ENOMEM;
 	memset(pp, 0, sizeof(*pp));
 
 	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
 	if (!mem) {
-		rc = -ENOMEM;
-		goto err_out_kfree;
+		kfree(pp);
+		return -ENOMEM;
 	}
 	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
 
@@ -373,12 +366,6 @@ static int ahci_port_start(struct ata_po
 	readl(port_mmio + PORT_CMD); /* flush */
 
 	return 0;
-
-err_out_kfree:
-	kfree(pp);
-err_out:
-	ata_port_stop(ap);
-	return rc;
 }
 
 
@@ -404,7 +391,6 @@ static void ahci_port_stop(struct ata_po
 	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
 			  pp->cmd_slot, pp->cmd_slot_dma);
 	kfree(pp);
-	ata_port_stop(ap);
 }
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1408,7 +1408,9 @@ void __sata_phy_reset(struct ata_port *a
 	if (ap->flags & ATA_FLAG_SATA_RESET) {
 		/* issue phy wake/reset */
 		scr_write_flush(ap, SCR_CONTROL, 0x301);
-		udelay(400);			/* FIXME: a guess */
+		/* Couldn't find anything in SATA I/II specs, but
+		 * AHCI-1.1 10.4.2 says at least 1 ms. */
+		mdelay(1);
 	}
 	scr_write_flush(ap, SCR_CONTROL, 0x300); /* phy wake/clear reset */
 
@@ -1920,6 +1922,7 @@ static const char * ata_dma_blacklist []
 	"HITACHI CDR-8335",
 	"HITACHI CDR-8435",
 	"Toshiba CD-ROM XM-6202B",
+	"TOSHIBA CD-ROM XM-1702BC",
 	"CD-532E-A",
 	"E-IDE CD-ROM CR-840",
 	"CD-ROM Drive/F5A",
@@ -1927,7 +1930,6 @@ static const char * ata_dma_blacklist []
 	"SAMSUNG CD-ROM SC-148C",
 	"SAMSUNG CD-ROM SC",
 	"SanDisk SDP3B-64",
-	"SAMSUNG CD-ROM SN-124",
 	"ATAPI CD-ROM DRIVE 40X MAXIMUM",
 	"_NEC DV5800A",
 };

--------------050202000002060706090002--
