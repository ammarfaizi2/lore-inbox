Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbWANGqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbWANGqf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 01:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbWANGqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 01:46:20 -0500
Received: from xenotime.net ([66.160.160.81]:22933 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932778AbWANGqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 01:46:12 -0500
Date: Fri, 13 Jan 2006 22:45:57 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ide <linux-ide@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [PATCH 4/4] additional libata parameters
Message-Id: <20060113224557.1fd8257e.rdunlap@xenotime.net>
In-Reply-To: <20060113224503.5e8a71fb.rdunlap@xenotime.net>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
	<20060113224414.20509944.rdunlap@xenotime.net>
	<20060113224503.5e8a71fb.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add and use 'noacpi' parameter for libata-acpi.
Add and use 'printk' parameter for libata (parts).
Update Documentation/kernel-parameters.txt, including atapi_enabled.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 Documentation/kernel-parameters.txt |   13 +++++++++++++
 drivers/scsi/libata-acpi.c          |   12 ++++++++++++
 drivers/scsi/libata-core.c          |   10 ++++++++++
 drivers/scsi/libata.h               |    2 ++
 4 files changed, 37 insertions(+)

--- linux-2615-g9.orig/drivers/scsi/libata-core.c
+++ linux-2615-g9/drivers/scsi/libata-core.c
@@ -82,6 +82,14 @@ int atapi_enabled = 0;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
 
+int noacpi = 0;
+module_param(noacpi, int, 0444);
+MODULE_PARM_DESC(noacpi, "Disables use of ACPI in suspend/resume when set");
+
+int libata_printk = ATA_MSG_DRV;
+module_param_named(printk, libata_printk, int, 0644);
+MODULE_PARM_DESC(printk, "Set libata printk flags"); /* in linux/libata.h */
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -4492,6 +4500,8 @@ int ata_device_add(const struct ata_prob
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
 				(ap->pio_mask << ATA_SHIFT_PIO);
 
+		ap->msg_enable = libata_printk;
+
 		/* print per-port info to dmesg */
 		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
 				 "bmdma 0x%lX irq %lu\n",
--- linux-2615-g9.orig/Documentation/kernel-parameters.txt
+++ linux-2615-g9/Documentation/kernel-parameters.txt
@@ -41,6 +41,7 @@ restrictions referred to are that the re
 	ISAPNP	ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
 	JOY	Appropriate joystick support is enabled.
+	LIBATA	libata driver is enabled.
 	LP	Printer support is enabled.
 	LOOP	Loopback device support is enabled.
 	M68k	M68k architecture is enabled.
@@ -242,6 +243,9 @@ running once the system is up.
 
 	ataflop=	[HW,M68k]
 
+	atapi_enabled=	[LIBATA] Enable discovery & support of ATAPI devices
+			Format: <value> (0=off, 1=on)
+
 	atarimouse=	[HW,MOUSE] Atari Mouse
 
 	atascsi=	[HW,SCSI] Atari SCSI
@@ -968,6 +972,10 @@ running once the system is up.
 			emulation library even if a 387 maths coprocessor
 			is present.
 
+	noacpi=		[LIBATA] Disables use of ACPI in libata suspend/resume
+			when set.
+			Format: <int>
+
 	noalign		[KNL,ARM]
 
 	noapic		[SMP,APIC] Tells the kernel to not make use of any
@@ -1212,6 +1220,11 @@ running once the system is up.
 			autoconfiguration.
 			Ranges are in pairs (memory base and size).
 
+	printk=		[LIBATA] Set libata printk level (mask).
+			The values are defined in include/linux/libata.h.
+			The default value is 1 (ATA_MSG_DRV).
+			Format: <int>
+
 	profile=	[KNL] Enable kernel profiling via /proc/profile
 			Format: [schedule,]<number>
 			Param: "schedule" - profile schedule points.
--- linux-2615-g9.orig/drivers/scsi/libata-acpi.c
+++ linux-2615-g9/drivers/scsi/libata-acpi.c
@@ -212,6 +212,9 @@ int ata_acpi_push_id(struct ata_port *ap
 	struct acpi_object_list		input;
 	union acpi_object 		in_params[1];
 
+	if (noacpi)
+		return 0;
+
 	if (ata_msg_probe(ap))
 		printk(KERN_DEBUG
 			"%s: ap->id: %d, ix = %d, port#: %d, hard_port#: %d\n",
@@ -319,6 +322,9 @@ int do_drive_get_GTF(struct ata_port *ap
 	*gtf_length = 0;
 	*gtf_address = 0UL;
 
+	if (noacpi)
+		return 0;
+
 	if (!ata_dev_present(atadev) ||
 	    (ap->flags & ATA_FLAG_PORT_DISABLED)) {
 		if (ata_msg_probe(ap))
@@ -493,6 +499,9 @@ int do_drive_set_taskfiles(struct ata_po
 			__FUNCTION__, ap->id,
 			ap->port_no, ap->hard_port_no);
 
+	if (noacpi)
+		return 0;
+
 	if (!ata_dev_present(atadev) ||
 	    (ap->flags & ATA_FLAG_PORT_DISABLED))
 		goto out;
@@ -540,6 +549,9 @@ int ata_acpi_exec_tfs(struct ata_port *a
 	if (ata_msg_probe(ap))
 		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
 
+	if (noacpi)
+		return 0;
+
 	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
 		printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
 			__FUNCTION__, ix);
--- linux-2615-g9.orig/drivers/scsi/libata.h
+++ linux-2615-g9/drivers/scsi/libata.h
@@ -41,6 +41,8 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
+extern int noacpi;
+extern int libata_printk;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);

---
