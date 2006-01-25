Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWAYUD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWAYUD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWAYUD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:03:57 -0500
Received: from mail0.lsil.com ([147.145.40.20]:724 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932157AbWAYUDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:03:52 -0500
Subject: [PATCH 3/3] megaraid_sas: support for 1078 type controller added
From: Sumant Patro <sumantp@lsil.com>
To: hch@lst.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Cc: sreenib@lsil.com, Neela.kolli@lsil.com, Bo.Yang@lsil.com,
       hdoelfel@lsil.com
Content-Type: multipart/mixed; boundary="=-Nqkb7Ou7sdhSnM74s38y"
Date: Wed, 25 Jan 2006 12:05:59 -0800
Message-Id: <1138219559.6383.17.camel@dhcp80-31.lsil.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Nqkb7Ou7sdhSnM74s38y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello All,

	This patch adds support for 1078 type controller (device id : 0x62).
Patch is made against the latest git snapshot of scsi-misc-2.6 tree.

	Please review it and all comments are appreciated.

Thanks,

Sumant Patro

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas
linux2.6/Documentation/scsi/ChangeLog.megaraid_sas
--- linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas	2006-01-23
15:08:40.000000000 -0800
+++ linux2.6/Documentation/scsi/ChangeLog.megaraid_sas	2006-01-23
15:53:46.000000000 -0800
@@ -1,3 +1,11 @@
+1 Release Date    : Mon Jan 23 15:16:30 PST 2006 - Sumant Patro
<Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.02
+3 Older Version   : 00.00.02.01 
+
+i.	Support for 1078 type (ppc IOP) controller, device id : 0x62 added.
During initialisation, depending on the device id, the template members
are intialised with function pointers specfic to the ppc or xscale
controllers.  
+
+		-Sumant Patro <Sumant.Patro@lsil.com>
+		
 1 Release Date    : Mon Jan 23 14:09:01 PST 2006 - Sumant Patro
<Sumant.Patro@lsil.com>
 2 Current Version : 00.00.02.02
 3 Older Version   : 00.00.02.01 
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c
linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c	2006-01-23
15:41:00.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2006-01-23
15:41:49.000000000 -0800
@@ -60,6 +60,12 @@ static struct pci_device_id megasas_pci_
 	 PCI_ANY_ID,
 	 },
 	{
+	 PCI_VENDOR_ID_LSI_LOGIC,
+	 PCI_DEVICE_ID_LSI_SAS1078R, // ppc IOP
+	 PCI_ANY_ID,
+	 PCI_ANY_ID,
+	},
+	{
 	 PCI_VENDOR_ID_DELL,
 	 PCI_DEVICE_ID_DELL_PERC5, // xscale IOP
 	 PCI_ANY_ID,
@@ -199,6 +205,86 @@ static struct megasas_instance_template 
 */
 
 /**
+*	The following functions are defined for ppc (deviceid : 0x62) 
+* 	controllers
+*/
+
+/**
+ * megasas_enable_intr_ppc -	Enables interrupts
+ * @regs:			MFI register set
+ */
+static inline void
+megasas_enable_intr_ppc(struct megasas_register_set __iomem * regs)
+{
+	writel(0xFFFFFFFF, &(regs)->outbound_doorbell_clear);
+    
+	writel(~0x80000004, &(regs)->outbound_intr_mask);
+
+	/* Dummy readl to force pci flush */
+	readl(&regs->outbound_intr_mask);
+}
+
+/**
+ * megasas_read_fw_status_reg_ppc - returns the current FW status value
+ * @regs:			MFI register set
+ */
+static u32
+megasas_read_fw_status_reg_ppc(struct megasas_register_set __iomem *
regs)
+{
+	return readl(&(regs)->outbound_scratch_pad);
+}
+
+/**
+ * megasas_clear_interrupt_ppc -	Check & clear interrupt
+ * @regs:				MFI register set
+ */
+static int 
+megasas_clear_intr_ppc(struct megasas_register_set __iomem * regs)
+{
+	u32 status;
+	/*
+	 * Check if it is our interrupt
+	 */
+	status = readl(&regs->outbound_intr_status);
+
+	if (!(status & MFI_REPLY_1078_MESSAGE_INTERRUPT)) {
+		return 1;
+	}
+
+	/*
+	 * Clear the interrupt by writing back the same value
+	 */
+	writel(status, &regs->outbound_doorbell_clear);
+
+	return 0;
+}
+/**
+ * megasas_fire_cmd_ppc -	Sends command to the FW
+ * @frame_phys_addr :		Physical address of cmd
+ * @frame_count :		Number of frames for the command
+ * @regs :			MFI register set
+ */
+static inline void 
+megasas_fire_cmd_ppc(dma_addr_t frame_phys_addr, u32 frame_count,
struct megasas_register_set __iomem *regs)
+{
+	writel((frame_phys_addr | (frame_count<<1))|1, 
+			&(regs)->inbound_queue_port);
+}
+
+static struct megasas_instance_template megasas_instance_template_ppc =
{
+	
+	.fire_cmd = megasas_fire_cmd_ppc,
+	.enable_intr = megasas_enable_intr_ppc,
+	.clear_intr = megasas_clear_intr_ppc,
+	.read_fw_status_reg = megasas_read_fw_status_reg_ppc,
+};
+
+/**
+*	This is the end of set of functions & definitions
+* 	specific to ppc (deviceid : 0x62) controllers
+*/
+
+/**
  * megasas_disable_intr -	Disables interrupts
  * @regs:			MFI register set
  */
@@ -1607,7 +1693,17 @@ static int megasas_init_mfi(struct megas
 
 	reg_set = instance->reg_set;
 
-	instance->instancet = &megasas_instance_template_xscale;
+	switch(instance->pdev->device)
+	{
+		case PCI_DEVICE_ID_LSI_SAS1078R:	
+			instance->instancet = &megasas_instance_template_ppc;
+			break;
+		case PCI_DEVICE_ID_LSI_SAS1064R:
+		case PCI_DEVICE_ID_DELL_PERC5:
+		default:
+			instance->instancet = &megasas_instance_template_xscale;
+			break;
+	}
 
 	/*
 	 * We expect the FW state to be READY
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h
linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h	2006-01-23
15:40:11.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-01-23
15:42:12.000000000 -0800
@@ -20,7 +20,7 @@
  */
 #define MEGASAS_VERSION				"00.00.02.02"
 #define MEGASAS_RELDATE				"Jan 23, 2006"
-#define MEGASAS_EXT_VERSION			"Mon Jan 23 14:09:01 PST 2006"
+#define MEGASAS_EXT_VERSION			"Mon Jan 23 15:16:30 PST 2006"
 /*
  * =====================================
  * MegaRAID SAS MFI firmware definitions
@@ -553,31 +553,46 @@ struct megasas_ctrl_info {
 #define MFI_OB_INTR_STATUS_MASK			0x00000002
 #define MFI_POLL_TIMEOUT_SECS			10
 
+#define MFI_REPLY_1078_MESSAGE_INTERRUPT	0x80000000
+#define PCI_DEVICE_ID_LSI_SAS1078R		0x00000062
+ 
 struct megasas_register_set {
+	u32 	reserved_0[4];			/*0000h*/
 
-	u32 reserved_0[4];	/*0000h */
+	u32 	inbound_msg_0;			/*0010h*/
+	u32 	inbound_msg_1;			/*0014h*/
+	u32 	outbound_msg_0;			/*0018h*/
+	u32 	outbound_msg_1;			/*001Ch*/
 
-	u32 inbound_msg_0;	/*0010h */
-	u32 inbound_msg_1;	/*0014h */
-	u32 outbound_msg_0;	/*0018h */
-	u32 outbound_msg_1;	/*001Ch */
+	u32 	inbound_doorbell;		/*0020h*/
+	u32 	inbound_intr_status;		/*0024h*/
+	u32 	inbound_intr_mask;		/*0028h*/
 
-	u32 inbound_doorbell;	/*0020h */
-	u32 inbound_intr_status;	/*0024h */
-	u32 inbound_intr_mask;	/*0028h */
+	u32 	outbound_doorbell;		/*002Ch*/
+	u32 	outbound_intr_status;		/*0030h*/
+	u32 	outbound_intr_mask;		/*0034h*/
 
-	u32 outbound_doorbell;	/*002Ch */
-	u32 outbound_intr_status;	/*0030h */
-	u32 outbound_intr_mask;	/*0034h */
+	u32 	reserved_1[2];			/*0038h*/
 
-	u32 reserved_1[2];	/*0038h */
+	u32 	inbound_queue_port;		/*0040h*/
+	u32 	outbound_queue_port;		/*0044h*/
 
-	u32 inbound_queue_port;	/*0040h */
-	u32 outbound_queue_port;	/*0044h */
+	u32 	reserved_2[22];			/*0048h*/
 
-	u32 reserved_2;		/*004Ch */
+	u32 	outbound_doorbell_clear;	/*00A0h*/
 
-	u32 index_registers[1004];	/*0050h */
+	u32 	reserved_3[3];			/*00A4h*/
+
+	u32 	outbound_scratch_pad ;		/*00B0h*/
+
+	u32 	reserved_4[3];			/*00B4h*/
+
+	u32 	inbound_low_queue_port ;	/*00C0h*/
+
+	u32 	inbound_high_queue_port ;	/*00C4h*/
+
+	u32 	reserved_5;			/*00C8h*/
+	u32 	index_registers[820];		/*00CCh*/
 
 } __attribute__ ((packed));
 




--=-Nqkb7Ou7sdhSnM74s38y
Content-Disposition: attachment; filename=patch3.patch
Content-Type: text/x-patch; name=patch3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas linux2.6/Documentation/scsi/ChangeLog.megaraid_sas
--- linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas	2006-01-23 15:08:40.000000000 -0800
+++ linux2.6/Documentation/scsi/ChangeLog.megaraid_sas	2006-01-23 15:53:46.000000000 -0800
@@ -1,3 +1,11 @@
+1 Release Date    : Mon Jan 23 15:16:30 PST 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.02
+3 Older Version   : 00.00.02.01 
+
+i.	Support for 1078 type (ppc IOP) controller, device id : 0x62 added. During initialisation, depending on the device id, the template members are intialised with function pointers specfic to the ppc or xscale controllers.  
+
+		-Sumant Patro <Sumant.Patro@lsil.com>
+		
 1 Release Date    : Mon Jan 23 14:09:01 PST 2006 - Sumant Patro <Sumant.Patro@lsil.com>
 2 Current Version : 00.00.02.02
 3 Older Version   : 00.00.02.01 
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c	2006-01-23 15:41:00.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2006-01-23 15:41:49.000000000 -0800
@@ -60,6 +60,12 @@ static struct pci_device_id megasas_pci_
 	 PCI_ANY_ID,
 	 },
 	{
+	 PCI_VENDOR_ID_LSI_LOGIC,
+	 PCI_DEVICE_ID_LSI_SAS1078R, // ppc IOP
+	 PCI_ANY_ID,
+	 PCI_ANY_ID,
+	},
+	{
 	 PCI_VENDOR_ID_DELL,
 	 PCI_DEVICE_ID_DELL_PERC5, // xscale IOP
 	 PCI_ANY_ID,
@@ -199,6 +205,86 @@ static struct megasas_instance_template 
 */
 
 /**
+*	The following functions are defined for ppc (deviceid : 0x62) 
+* 	controllers
+*/
+
+/**
+ * megasas_enable_intr_ppc -	Enables interrupts
+ * @regs:			MFI register set
+ */
+static inline void
+megasas_enable_intr_ppc(struct megasas_register_set __iomem * regs)
+{
+	writel(0xFFFFFFFF, &(regs)->outbound_doorbell_clear);
+    
+	writel(~0x80000004, &(regs)->outbound_intr_mask);
+
+	/* Dummy readl to force pci flush */
+	readl(&regs->outbound_intr_mask);
+}
+
+/**
+ * megasas_read_fw_status_reg_ppc - returns the current FW status value
+ * @regs:			MFI register set
+ */
+static u32
+megasas_read_fw_status_reg_ppc(struct megasas_register_set __iomem * regs)
+{
+	return readl(&(regs)->outbound_scratch_pad);
+}
+
+/**
+ * megasas_clear_interrupt_ppc -	Check & clear interrupt
+ * @regs:				MFI register set
+ */
+static int 
+megasas_clear_intr_ppc(struct megasas_register_set __iomem * regs)
+{
+	u32 status;
+	/*
+	 * Check if it is our interrupt
+	 */
+	status = readl(&regs->outbound_intr_status);
+
+	if (!(status & MFI_REPLY_1078_MESSAGE_INTERRUPT)) {
+		return 1;
+	}
+
+	/*
+	 * Clear the interrupt by writing back the same value
+	 */
+	writel(status, &regs->outbound_doorbell_clear);
+
+	return 0;
+}
+/**
+ * megasas_fire_cmd_ppc -	Sends command to the FW
+ * @frame_phys_addr :		Physical address of cmd
+ * @frame_count :		Number of frames for the command
+ * @regs :			MFI register set
+ */
+static inline void 
+megasas_fire_cmd_ppc(dma_addr_t frame_phys_addr, u32 frame_count, struct megasas_register_set __iomem *regs)
+{
+	writel((frame_phys_addr | (frame_count<<1))|1, 
+			&(regs)->inbound_queue_port);
+}
+
+static struct megasas_instance_template megasas_instance_template_ppc = {
+	
+	.fire_cmd = megasas_fire_cmd_ppc,
+	.enable_intr = megasas_enable_intr_ppc,
+	.clear_intr = megasas_clear_intr_ppc,
+	.read_fw_status_reg = megasas_read_fw_status_reg_ppc,
+};
+
+/**
+*	This is the end of set of functions & definitions
+* 	specific to ppc (deviceid : 0x62) controllers
+*/
+
+/**
  * megasas_disable_intr -	Disables interrupts
  * @regs:			MFI register set
  */
@@ -1607,7 +1693,17 @@ static int megasas_init_mfi(struct megas
 
 	reg_set = instance->reg_set;
 
-	instance->instancet = &megasas_instance_template_xscale;
+	switch(instance->pdev->device)
+	{
+		case PCI_DEVICE_ID_LSI_SAS1078R:	
+			instance->instancet = &megasas_instance_template_ppc;
+			break;
+		case PCI_DEVICE_ID_LSI_SAS1064R:
+		case PCI_DEVICE_ID_DELL_PERC5:
+		default:
+			instance->instancet = &megasas_instance_template_xscale;
+			break;
+	}
 
 	/*
 	 * We expect the FW state to be READY
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h	2006-01-23 15:40:11.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-01-23 15:42:12.000000000 -0800
@@ -20,7 +20,7 @@
  */
 #define MEGASAS_VERSION				"00.00.02.02"
 #define MEGASAS_RELDATE				"Jan 23, 2006"
-#define MEGASAS_EXT_VERSION			"Mon Jan 23 14:09:01 PST 2006"
+#define MEGASAS_EXT_VERSION			"Mon Jan 23 15:16:30 PST 2006"
 /*
  * =====================================
  * MegaRAID SAS MFI firmware definitions
@@ -553,31 +553,46 @@ struct megasas_ctrl_info {
 #define MFI_OB_INTR_STATUS_MASK			0x00000002
 #define MFI_POLL_TIMEOUT_SECS			10
 
+#define MFI_REPLY_1078_MESSAGE_INTERRUPT	0x80000000
+#define PCI_DEVICE_ID_LSI_SAS1078R		0x00000062
+ 
 struct megasas_register_set {
+	u32 	reserved_0[4];			/*0000h*/
 
-	u32 reserved_0[4];	/*0000h */
+	u32 	inbound_msg_0;			/*0010h*/
+	u32 	inbound_msg_1;			/*0014h*/
+	u32 	outbound_msg_0;			/*0018h*/
+	u32 	outbound_msg_1;			/*001Ch*/
 
-	u32 inbound_msg_0;	/*0010h */
-	u32 inbound_msg_1;	/*0014h */
-	u32 outbound_msg_0;	/*0018h */
-	u32 outbound_msg_1;	/*001Ch */
+	u32 	inbound_doorbell;		/*0020h*/
+	u32 	inbound_intr_status;		/*0024h*/
+	u32 	inbound_intr_mask;		/*0028h*/
 
-	u32 inbound_doorbell;	/*0020h */
-	u32 inbound_intr_status;	/*0024h */
-	u32 inbound_intr_mask;	/*0028h */
+	u32 	outbound_doorbell;		/*002Ch*/
+	u32 	outbound_intr_status;		/*0030h*/
+	u32 	outbound_intr_mask;		/*0034h*/
 
-	u32 outbound_doorbell;	/*002Ch */
-	u32 outbound_intr_status;	/*0030h */
-	u32 outbound_intr_mask;	/*0034h */
+	u32 	reserved_1[2];			/*0038h*/
 
-	u32 reserved_1[2];	/*0038h */
+	u32 	inbound_queue_port;		/*0040h*/
+	u32 	outbound_queue_port;		/*0044h*/
 
-	u32 inbound_queue_port;	/*0040h */
-	u32 outbound_queue_port;	/*0044h */
+	u32 	reserved_2[22];			/*0048h*/
 
-	u32 reserved_2;		/*004Ch */
+	u32 	outbound_doorbell_clear;	/*00A0h*/
 
-	u32 index_registers[1004];	/*0050h */
+	u32 	reserved_3[3];			/*00A4h*/
+
+	u32 	outbound_scratch_pad ;		/*00B0h*/
+
+	u32 	reserved_4[3];			/*00B4h*/
+
+	u32 	inbound_low_queue_port ;	/*00C0h*/
+
+	u32 	inbound_high_queue_port ;	/*00C4h*/
+
+	u32 	reserved_5;			/*00C8h*/
+	u32 	index_registers[820];		/*00CCh*/
 
 } __attribute__ ((packed));
 

--=-Nqkb7Ou7sdhSnM74s38y--

