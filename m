Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWHHDtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWHHDtK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWHHDtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:49:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65419 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932460AbWHHDtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:49:08 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4 Intermittent failures to detect sata disks
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Aug 2006 13:48:54 +1000
Message-ID: <7959.1155008934@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem has been occurring since at least 2.6.18-rc2.  Standard
2.6.18-rc4 kernel plus two debug patches below.  Running on a Dell
SC1425, dual Xeons with HT, using an i386 kernel.  The boot command
line has '6' in it so the system is in a continual soft reboot cycle.
Sooner or later a reboot will fail to detect the sata disks.

It is peculiar that adding the kdb patch makes this bug much more
likely to trip.  kdb goes nowhere near piix or sata code, but it does
slightly change the virtual memory usage and the boot timings.

Normal output:

[    7.218030] piix_init: pci_module_init
[    7.262935] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
[    7.325412] ata_pci_init_one: ENTER
[    7.367178] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
[    7.455909] ata_device_add: ENTER
[    7.495571] ata_host_add: ENTER
[    7.533250] ata_port_start: prd alloc, virt f7bd0000, dma 37bd0000
[    7.607247] ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
[    7.692639] __ata_port_freeze: ata1 port frozen
[    7.746856] ata_host_add: ENTER
[    7.784509] ata_port_start: prd alloc, virt f7bcc000, dma 37bcc000
[    7.858428] ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
[    7.943821] __ata_port_freeze: ata2 port frozen
[    7.998044] ata_device_add: probe begin
[    8.043954] scsi0 : ata_piix
[    8.078510] ata_port_schedule_eh: port EH scheduled
[    8.078516] ata_scsi_error: ENTER
[    8.078520] ata_port_flush_task: ENTER
[    8.221382] ata_port_flush_task: flush #1
[    8.269389] ata_eh_autopsy: ENTER
[    8.309064] ata_eh_recover: ENTER
[    8.348746] ata_eh_prep_resume: ENTER
[    8.392581] ata_eh_prep_resume: EXIT
[    8.435384] __ata_port_freeze: ata1 port frozen
[    8.489617] piix_sata_prereset: ata1: ENTER, pcs=0x33 base=0
[    8.557363] piix_sata_prereset: ata1: LEAVE, pcs=0x33 present=0x1
[    8.783122] ata1.00: ATA-6, max UDMA/100, 156250000 sectors: LBA 
[    8.856011] ata1.00: ata1: dev 0 multi count 8
[    8.910091] ata1.00: configured for UDMA/100
[    8.974462] scsi1 : ata_piix
[    9.163794] ata2.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
[    9.255442] ata2.00: ata2: dev 0 multi count 8
[    9.309866] ata2.00: configured for UDMA/133
[    9.361057]   Vendor: ATA       Model: WDC WD800JD-75JN  Rev: 06.0
[    9.441466]   Type:   Direct-Access                      ANSI SCSI revision: 05
[    9.529520]   Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
[    9.609854]   Type:   Direct-Access                      ANSI SCSI revision: 05

Failure output:

[    7.217428] piix_init: pci_module_init
[    7.262373] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
[    7.324860] ata_pci_init_one: ENTER
[    7.366626] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
[    7.455360] ata_device_add: ENTER
[    7.495021] ata_host_add: ENTER
[    7.532673] ata_port_start: prd alloc, virt f761f000, dma 3761f000
[    7.606592] ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
[    7.691986] __ata_port_freeze: ata1 port frozen
[    7.746206] ata_host_add: ENTER
[    7.783833] ata_port_start: prd alloc, virt f761b000, dma 3761b000
[    7.857784] ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
[    7.943174] __ata_port_freeze: ata2 port frozen
[    7.997401] ata_device_add: probe begin
[    8.043309] scsi0 : ata_piix
[    8.077850] ata_port_schedule_eh: port EH scheduled
[    8.077855] ata_scsi_error: ENTER
[    8.077858] ata_port_flush_task: ENTER
[    8.220733] ata_port_flush_task: flush #1
[    8.268736] ata_eh_autopsy: ENTER
[    8.308410] ata_eh_recover: ENTER
[    8.348094] ata_eh_prep_resume: ENTER
[    8.391934] ata_eh_prep_resume: EXIT
[    8.434732] __ata_port_freeze: ata1 port frozen
[    8.488962] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[    8.555676] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
[    8.627540] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
repeat ...
[   22.348237] ata1: SATA port has no device.
[   22.410732] scsi1 : ata_piix
[   22.445316] ata2: SATA port has no device.
[   22.496324] serio: i8042 AUX port at 0x60,0x64 irq 12
[   22.556827] serio: i8042 KBD port at 0x60,0x64 irq 1
[   22.616356] mice: PS/2 mouse device common for all mice
[   22.678995] TCP bic registered
[   22.715573] NET: Registered protocol family 1
[   22.716840] input: AT Translated Set 2 keyboard as /class/input/input0
[   22.845835] Starting balanced_irq
[   22.885503] Using IPI No-Shortcut mode
[   22.930429] ACPI: (supports<6>Time: tsc clocksource has been installed.
[   23.009745]  S0 S4 S5)
[   23.038785] VFS: Cannot open root device "sda10" or unknown-block(0,0)
[   23.116846] Please append a correct "root=" boot option
[   23.179382] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

Debug patches: The first one fixes a compile bug when DPRINTK is turned
on and should be in the kernel anyway.  The second one does limitted
ata tracing and also retries the disk probe.  Sometimes a retry will
find the disk, more often it will not.

---
 drivers/scsi/ata_piix.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/scsi/ata_piix.c
===================================================================
--- linux.orig/drivers/scsi/ata_piix.c
+++ linux/drivers/scsi/ata_piix.c
@@ -567,8 +567,8 @@ static int piix_sata_prereset(struct ata
 			present = 1;
 	}
 
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
-		ap->id, pcs, present_mask);
+	DPRINTK("ata%u: LEAVE, pcs=0x%x present=0x%x\n",
+		ap->id, pcs, present);
 
 	if (!present) {
 		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");

---
 drivers/scsi/ata_piix.c |    6 ++++++
 include/linux/libata.h  |    4 ++++
 2 files changed, 10 insertions(+)

Index: linux/drivers/scsi/ata_piix.c
===================================================================
--- linux.orig/drivers/scsi/ata_piix.c
+++ linux/drivers/scsi/ata_piix.c
@@ -529,6 +529,7 @@ static void piix_pata_error_handler(stru
 	ata_bmdma_drive_eh(ap, piix_pata_prereset, ata_std_softreset, NULL,
 			   ata_std_postreset);
 }
+int ata_debug = 1;
 
 /**
  *	piix_sata_prereset - prereset for SATA host controller
@@ -555,6 +556,8 @@ static int piix_sata_prereset(struct ata
 	int port, i;
 	u16 pcs;
 
+	int count = 100;
+repeat:
 	pci_read_config_word(pdev, ICH5_PCS, &pcs);
 	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
 
@@ -569,6 +572,9 @@ static int piix_sata_prereset(struct ata
 
 	DPRINTK("ata%u: LEAVE, pcs=0x%x present=0x%x\n",
 		ap->id, pcs, present);
+	if (pcs == 0 && --count)
+		goto repeat;
+	ata_debug = 0;
 
 	if (!present) {
 		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
Index: linux/include/linux/libata.h
===================================================================
--- linux.orig/include/linux/libata.h
+++ linux/include/linux/libata.h
@@ -61,6 +61,10 @@
 #define VPRINTK(fmt, args...)
 #endif	/* ATA_DEBUG */
 
+extern int ata_debug;
+#undef DPRINTK
+#define DPRINTK(fmt, args...) if (ata_debug) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+
 #define BPRINTK(fmt, args...) if (ap->flags & ATA_FLAG_DEBUGMSG) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
 
 /* NEW: debug levels */

