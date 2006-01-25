Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWAYUAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWAYUAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWAYUAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:00:37 -0500
Received: from mail0.lsil.com ([147.145.40.20]:32979 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751189AbWAYUAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:00:35 -0500
Subject: [PATCH 2/3] megaraid_sas: new template defined to represent each
	type of controllers
From: Sumant Patro <sumantp@lsil.com>
To: hch@lst.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Cc: sreenib@lsil.com, Neela.kolli@lsil.com, Bo.Yang@lsil.com,
       hdoelfel@lsil.com
Content-Type: multipart/mixed; boundary="=-2Xv0qK6G+rDM37l5dFNE"
Date: Wed, 25 Jan 2006 12:02:40 -0800
Message-Id: <1138219360.6383.11.camel@dhcp80-31.lsil.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2Xv0qK6G+rDM37l5dFNE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello All,

	This patch defines a new template to represent each type of controllers
(identified by the processor used). The template has members that is set
with appropriate values during driver initialisation. This change is
done to support new controllers with minimal change to existing code. In
future, for a new controller support, a template will be declared and
its members initialised appropriately.
	
	Patch is made against scsi-misc-2.6 tree.

	Please review it and all comments are appreciated.

Thanks,

Sumant Patro


Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas
linux2.6/Documentation/scsi/ChangeLog.megaraid_sas
--- linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas	2006-01-19
17:55:48.000000000 -0800
+++ linux2.6/Documentation/scsi/ChangeLog.megaraid_sas	2006-01-23
14:17:55.000000000 -0800
@@ -1,3 +1,12 @@
+1 Release Date    : Mon Jan 23 14:09:01 PST 2006 - Sumant Patro
<Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.02
+3 Older Version   : 00.00.02.01 
+
+i.	New template defined to represent each family of controllers
(identified by processor used). 
+	The template will have defintions that will be initialised to
appropritae values for a specific family of controllers. The template
definition has four function pointers. During driver initialisation the
function pointers will be set based on the controller family type. This
change is done to support new controllers that has different processors
and thus different register set.
+
+		-Sumant Patro <Sumant.Patro@lsil.com>
+
 1 Release Date    : Mon Dec 19 14:36:26 PST 2005 - Sumant Patro
<Sumant.Patro@lsil.com>
 2 Current Version : 00.00.02.00-rc4 
 3 Older Version   : 00.00.02.01 
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c
linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c	2006-01-19
17:55:23.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2006-01-23
15:57:02.000000000 -0800
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_sas.c
- * Version	: v00.00.02.01
+ * Version	: v00.00.02.02
  *
  * Authors:
  * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
@@ -55,13 +55,13 @@ static struct pci_device_id megasas_pci_
 
 	{
 	 PCI_VENDOR_ID_LSI_LOGIC,
-	 PCI_DEVICE_ID_LSI_SAS1064R,
+	 PCI_DEVICE_ID_LSI_SAS1064R, // xscale IOP
 	 PCI_ANY_ID,
 	 PCI_ANY_ID,
 	 },
 	{
 	 PCI_VENDOR_ID_DELL,
-	 PCI_DEVICE_ID_DELL_PERC5,
+	 PCI_DEVICE_ID_DELL_PERC5, // xscale IOP
 	 PCI_ANY_ID,
 	 PCI_ANY_ID,
 	 },
@@ -119,12 +119,18 @@ megasas_return_cmd(struct megasas_instan
 	spin_unlock_irqrestore(&instance->cmd_pool_lock, flags);
 }
 
+
+/**
+*	The following functions are defined for xscale 
+*	(deviceid : 1064R, PERC5) controllers
+*/
+
 /**
- * megasas_enable_intr -	Enables interrupts
+ * megasas_enable_intr_xscale -	Enables interrupts
  * @regs:			MFI register set
  */
 static inline void
-megasas_enable_intr(struct megasas_register_set __iomem * regs)
+megasas_enable_intr_xscale(struct megasas_register_set __iomem * regs)
 {
 	writel(1, &(regs)->outbound_intr_mask);
 
@@ -133,13 +139,73 @@ megasas_enable_intr(struct megasas_regis
 }
 
 /**
+ * megasas_read_fw_status_reg_xscale - returns the current FW status
value
+ * @regs:			MFI register set
+ */
+static u32
+megasas_read_fw_status_reg_xscale(struct megasas_register_set __iomem *
regs)
+{
+	return readl(&(regs)->outbound_msg_0);
+}
+/**
+ * megasas_clear_interrupt_xscale -	Check & clear interrupt
+ * @regs:				MFI register set
+ */
+static int 
+megasas_clear_intr_xscale(struct megasas_register_set __iomem * regs)
+{
+	u32 status;
+	/*
+	 * Check if it is our interrupt
+	 */
+	status = readl(&regs->outbound_intr_status);
+
+	if (!(status & MFI_OB_INTR_STATUS_MASK)) {
+		return 1;
+	}
+
+	/*
+	 * Clear the interrupt by writing back the same value
+	 */
+	writel(status, &regs->outbound_intr_status);
+
+	return 0;
+}
+
+/**
+ * megasas_fire_cmd_xscale -	Sends command to the FW
+ * @frame_phys_addr :		Physical address of cmd
+ * @frame_count :		Number of frames for the command
+ * @regs :			MFI register set
+ */
+static inline void 
+megasas_fire_cmd_xscale(dma_addr_t frame_phys_addr,u32 frame_count,
struct megasas_register_set __iomem *regs)
+{
+	writel((frame_phys_addr >> 3)|(frame_count),
+	       &(regs)->inbound_queue_port);
+}
+
+static struct megasas_instance_template
megasas_instance_template_xscale = {
+
+	.fire_cmd = megasas_fire_cmd_xscale,
+	.enable_intr = megasas_enable_intr_xscale,
+	.clear_intr = megasas_clear_intr_xscale,
+	.read_fw_status_reg = megasas_read_fw_status_reg_xscale,
+};
+
+/**
+*	This is the end of set of functions & definitions specific 
+*	to xscale (deviceid : 1064R, PERC5) controllers
+*/
+
+/**
  * megasas_disable_intr -	Disables interrupts
  * @regs:			MFI register set
  */
 static inline void
 megasas_disable_intr(struct megasas_register_set __iomem * regs)
 {
-	u32 mask = readl(&regs->outbound_intr_mask) & (~0x00000001);
+	u32 mask = 0x1f; 
 	writel(mask, &regs->outbound_intr_mask);
 
 	/* Dummy readl to force pci flush */
@@ -167,8 +233,7 @@ megasas_issue_polled(struct megasas_inst
 	/*
 	 * Issue the frame using inbound queue port
 	 */
-	writel(cmd->frame_phys_addr >> 3,
-	       &instance->reg_set->inbound_queue_port);
+	instance->instancet->fire_cmd(cmd->frame_phys_addr ,0,instance-
>reg_set);
 
 	/*
 	 * Wait for cmd_status to change
@@ -198,8 +263,7 @@ megasas_issue_blocked_cmd(struct megasas
 {
 	cmd->cmd_status = ENODATA;
 
-	writel(cmd->frame_phys_addr >> 3,
-	       &instance->reg_set->inbound_queue_port);
+	instance->instancet->fire_cmd(cmd->frame_phys_addr ,0,instance-
>reg_set);
 
 	wait_event(instance->int_cmd_wait_q, (cmd->cmd_status != ENODATA));
 
@@ -242,8 +306,7 @@ megasas_issue_blocked_abort_cmd(struct m
 	cmd->sync_cmd = 1;
 	cmd->cmd_status = 0xFF;
 
-	writel(cmd->frame_phys_addr >> 3,
-	       &instance->reg_set->inbound_queue_port);
+	instance->instancet->fire_cmd(cmd->frame_phys_addr ,0,instance-
>reg_set);
 
 	/*
 	 * Wait for this cmd to complete
@@ -633,8 +696,7 @@ megasas_queue_command(struct scsi_cmnd *
 	instance->fw_outstanding++;
 	spin_unlock_irqrestore(&instance->instance_lock, flags);
 
-	writel(((cmd->frame_phys_addr >> 3) | (cmd->frame_count - 1)),
-	       &instance->reg_set->inbound_queue_port);
+	instance->instancet->fire_cmd(cmd->frame_phys_addr ,cmd-
>frame_count-1,instance->reg_set);
 
 	return 0;
 
@@ -1045,7 +1107,6 @@ megasas_complete_cmd(struct megasas_inst
 static inline int
 megasas_deplete_reply_queue(struct megasas_instance *instance, u8
alt_status)
 {
-	u32 status;
 	u32 producer;
 	u32 consumer;
 	u32 context;
@@ -1053,17 +1114,10 @@ megasas_deplete_reply_queue(struct megas
 
 	/*
 	 * Check if it is our interrupt
+	 * Clear the interrupt 
 	 */
-	status = readl(&instance->reg_set->outbound_intr_status);
-
-	if (!(status & MFI_OB_INTR_STATUS_MASK)) {
+	if(instance->instancet->clear_intr(instance->reg_set))
 		return IRQ_NONE;
-	}
-
-	/*
-	 * Clear the interrupt by writing back the same value
-	 */
-	writel(status, &instance->reg_set->outbound_intr_status);
 
 	producer = *instance->producer;
 	consumer = *instance->consumer;
@@ -1097,7 +1151,7 @@ static irqreturn_t megasas_isr(int irq, 
 
 /**
  * megasas_transition_to_ready -	Move the FW to READY state
- * @reg_set:				MFI register set
+ * @instance:				Adapter soft state
  *
  * During the initialization, FW passes can potentially be in any one
of
  * several possible states. If the FW in operational, waiting-for-
handshake
@@ -1105,14 +1159,14 @@ static irqreturn_t megasas_isr(int irq, 
  * has to wait for the ready state.
  */
 static int
-megasas_transition_to_ready(struct megasas_register_set __iomem *
reg_set)
+megasas_transition_to_ready(struct megasas_instance* instance)
 {
 	int i;
 	u8 max_wait;
 	u32 fw_state;
 	u32 cur_state;
 
-	fw_state = readl(&reg_set->outbound_msg_0) & MFI_STATE_MASK;
+	fw_state = instance->instancet->read_fw_status_reg(instance->reg_set)
& MFI_STATE_MASK;
 
 	while (fw_state != MFI_STATE_READY) {
 
@@ -1130,7 +1184,7 @@ megasas_transition_to_ready(struct megas
 			 * Set the CLR bit in inbound doorbell
 			 */
 			writel(MFI_INIT_CLEAR_HANDSHAKE,
-			       &reg_set->inbound_doorbell);
+				&instance->reg_set->inbound_doorbell);
 
 			max_wait = 2;
 			cur_state = MFI_STATE_WAIT_HANDSHAKE;
@@ -1140,8 +1194,8 @@ megasas_transition_to_ready(struct megas
 			/*
 			 * Bring it to READY state; assuming max wait 2 secs
 			 */
-			megasas_disable_intr(reg_set);
-			writel(MFI_INIT_READY, &reg_set->inbound_doorbell);
+			megasas_disable_intr(instance->reg_set);
+			writel(MFI_INIT_READY, &instance->reg_set->inbound_doorbell);
 
 			max_wait = 10;
 			cur_state = MFI_STATE_OPERATIONAL;
@@ -1190,8 +1244,8 @@ megasas_transition_to_ready(struct megas
 		 * The cur_state should not last for more than max_wait secs
 		 */
 		for (i = 0; i < (max_wait * 1000); i++) {
-			fw_state = MFI_STATE_MASK &
-			    readl(&reg_set->outbound_msg_0);
+			fw_state = instance->instancet->read_fw_status_reg(instance-
>reg_set) &  
+					MFI_STATE_MASK ;
 
 			if (fw_state == cur_state) {
 				msleep(1);
@@ -1553,18 +1607,20 @@ static int megasas_init_mfi(struct megas
 
 	reg_set = instance->reg_set;
 
+	instance->instancet = &megasas_instance_template_xscale;
+
 	/*
 	 * We expect the FW state to be READY
 	 */
-	if (megasas_transition_to_ready(instance->reg_set))
+	if (megasas_transition_to_ready(instance))
 		goto fail_ready_state;
 
 	/*
 	 * Get various operational parameters from status register
 	 */
-	instance->max_fw_cmds = readl(&reg_set->outbound_msg_0) & 0x00FFFF;
-	instance->max_num_sge = (readl(&reg_set->outbound_msg_0) & 0xFF0000)
>>
-	    0x10;
+	instance->max_fw_cmds = instance->instancet->read_fw_status_reg
(reg_set) & 0x00FFFF;
+	instance->max_num_sge = (instance->instancet->read_fw_status_reg
(reg_set) & 0xFF0000) >> 
+					0x10;
 	/*
 	 * Create a pool of commands
 	 */
@@ -1873,8 +1929,7 @@ megasas_register_aen(struct megasas_inst
 	/*
 	 * Issue the aen registration frame
 	 */
-	writel(cmd->frame_phys_addr >> 3,
-	       &instance->reg_set->inbound_queue_port);
+	instance->instancet->fire_cmd(cmd->frame_phys_addr ,0,instance-
>reg_set);
 
 	return 0;
 }
@@ -2063,7 +2118,7 @@ megasas_probe_one(struct pci_dev *pdev, 
 		goto fail_irq;
 	}
 
-	megasas_enable_intr(instance->reg_set);
+	instance->instancet->enable_intr(instance->reg_set);
 
 	/*
 	 * Store instance in PCI softstate
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h
linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h	2006-01-19
17:55:23.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-01-23
14:11:04.000000000 -0800
@@ -18,9 +18,9 @@
 /**
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"00.00.02.01"
-#define MEGASAS_RELDATE				"Dec 19, 2005"
-#define MEGASAS_EXT_VERSION			"Mon Dec 19 14:36:26 PST 2005"
+#define MEGASAS_VERSION				"00.00.02.02"
+#define MEGASAS_RELDATE				"Jan 23, 2006"
+#define MEGASAS_EXT_VERSION			"Mon Jan 23 14:09:01 PST 2006"
 /*
  * =====================================
  * MegaRAID SAS MFI firmware definitions
@@ -1012,6 +1012,16 @@ struct megasas_evt_detail {
 
 } __attribute__ ((packed));
 
+ struct megasas_instance_template {
+	void (*fire_cmd)(dma_addr_t ,u32 ,struct megasas_register_set __iomem
*);
+
+	void (*enable_intr)(struct megasas_register_set __iomem *) ;
+
+	int (*clear_intr)(struct megasas_register_set __iomem *);
+
+	u32 (*read_fw_status_reg)(struct megasas_register_set __iomem *);
+ };
+
 struct megasas_instance {
 
 	u32 *producer;
@@ -1055,6 +1065,8 @@ struct megasas_instance {
 	u32 fw_outstanding;
 	u32 hw_crit_error;
 	spinlock_t instance_lock;
+
+	struct megasas_instance_template *instancet;
 };
 
 #define MEGASAS_IS_LOGICAL(scp)						\


--=-2Xv0qK6G+rDM37l5dFNE
Content-Disposition: attachment; filename=patch2.patch
Content-Type: text/x-patch; name=patch2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas linux2.6/Documentation/scsi/ChangeLog.megaraid_sas
--- linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas	2006-01-19 17:55:48.000000000 -0800
+++ linux2.6/Documentation/scsi/ChangeLog.megaraid_sas	2006-01-23 14:17:55.000000000 -0800
@@ -1,3 +1,12 @@
+1 Release Date    : Mon Jan 23 14:09:01 PST 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.02
+3 Older Version   : 00.00.02.01 
+
+i.	New template defined to represent each family of controllers (identified by processor used). 
+	The template will have defintions that will be initialised to appropritae values for a specific family of controllers. The template definition has four function pointers. During driver initialisation the function pointers will be set based on the controller family type. This change is done to support new controllers that has different processors and thus different register set.
+
+		-Sumant Patro <Sumant.Patro@lsil.com>
+
 1 Release Date    : Mon Dec 19 14:36:26 PST 2005 - Sumant Patro <Sumant.Patro@lsil.com>
 2 Current Version : 00.00.02.00-rc4 
 3 Older Version   : 00.00.02.01 
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c	2006-01-19 17:55:23.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2006-01-23 15:57:02.000000000 -0800
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_sas.c
- * Version	: v00.00.02.01
+ * Version	: v00.00.02.02
  *
  * Authors:
  * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
@@ -55,13 +55,13 @@ static struct pci_device_id megasas_pci_
 
 	{
 	 PCI_VENDOR_ID_LSI_LOGIC,
-	 PCI_DEVICE_ID_LSI_SAS1064R,
+	 PCI_DEVICE_ID_LSI_SAS1064R, // xscale IOP
 	 PCI_ANY_ID,
 	 PCI_ANY_ID,
 	 },
 	{
 	 PCI_VENDOR_ID_DELL,
-	 PCI_DEVICE_ID_DELL_PERC5,
+	 PCI_DEVICE_ID_DELL_PERC5, // xscale IOP
 	 PCI_ANY_ID,
 	 PCI_ANY_ID,
 	 },
@@ -119,12 +119,18 @@ megasas_return_cmd(struct megasas_instan
 	spin_unlock_irqrestore(&instance->cmd_pool_lock, flags);
 }
 
+
+/**
+*	The following functions are defined for xscale 
+*	(deviceid : 1064R, PERC5) controllers
+*/
+
 /**
- * megasas_enable_intr -	Enables interrupts
+ * megasas_enable_intr_xscale -	Enables interrupts
  * @regs:			MFI register set
  */
 static inline void
-megasas_enable_intr(struct megasas_register_set __iomem * regs)
+megasas_enable_intr_xscale(struct megasas_register_set __iomem * regs)
 {
 	writel(1, &(regs)->outbound_intr_mask);
 
@@ -133,13 +139,73 @@ megasas_enable_intr(struct megasas_regis
 }
 
 /**
+ * megasas_read_fw_status_reg_xscale - returns the current FW status value
+ * @regs:			MFI register set
+ */
+static u32
+megasas_read_fw_status_reg_xscale(struct megasas_register_set __iomem * regs)
+{
+	return readl(&(regs)->outbound_msg_0);
+}
+/**
+ * megasas_clear_interrupt_xscale -	Check & clear interrupt
+ * @regs:				MFI register set
+ */
+static int 
+megasas_clear_intr_xscale(struct megasas_register_set __iomem * regs)
+{
+	u32 status;
+	/*
+	 * Check if it is our interrupt
+	 */
+	status = readl(&regs->outbound_intr_status);
+
+	if (!(status & MFI_OB_INTR_STATUS_MASK)) {
+		return 1;
+	}
+
+	/*
+	 * Clear the interrupt by writing back the same value
+	 */
+	writel(status, &regs->outbound_intr_status);
+
+	return 0;
+}
+
+/**
+ * megasas_fire_cmd_xscale -	Sends command to the FW
+ * @frame_phys_addr :		Physical address of cmd
+ * @frame_count :		Number of frames for the command
+ * @regs :			MFI register set
+ */
+static inline void 
+megasas_fire_cmd_xscale(dma_addr_t frame_phys_addr,u32 frame_count, struct megasas_register_set __iomem *regs)
+{
+	writel((frame_phys_addr >> 3)|(frame_count),
+	       &(regs)->inbound_queue_port);
+}
+
+static struct megasas_instance_template megasas_instance_template_xscale = {
+
+	.fire_cmd = megasas_fire_cmd_xscale,
+	.enable_intr = megasas_enable_intr_xscale,
+	.clear_intr = megasas_clear_intr_xscale,
+	.read_fw_status_reg = megasas_read_fw_status_reg_xscale,
+};
+
+/**
+*	This is the end of set of functions & definitions specific 
+*	to xscale (deviceid : 1064R, PERC5) controllers
+*/
+
+/**
  * megasas_disable_intr -	Disables interrupts
  * @regs:			MFI register set
  */
 static inline void
 megasas_disable_intr(struct megasas_register_set __iomem * regs)
 {
-	u32 mask = readl(&regs->outbound_intr_mask) & (~0x00000001);
+	u32 mask = 0x1f; 
 	writel(mask, &regs->outbound_intr_mask);
 
 	/* Dummy readl to force pci flush */
@@ -167,8 +233,7 @@ megasas_issue_polled(struct megasas_inst
 	/*
 	 * Issue the frame using inbound queue port
 	 */
-	writel(cmd->frame_phys_addr >> 3,
-	       &instance->reg_set->inbound_queue_port);
+	instance->instancet->fire_cmd(cmd->frame_phys_addr ,0,instance->reg_set);
 
 	/*
 	 * Wait for cmd_status to change
@@ -198,8 +263,7 @@ megasas_issue_blocked_cmd(struct megasas
 {
 	cmd->cmd_status = ENODATA;
 
-	writel(cmd->frame_phys_addr >> 3,
-	       &instance->reg_set->inbound_queue_port);
+	instance->instancet->fire_cmd(cmd->frame_phys_addr ,0,instance->reg_set);
 
 	wait_event(instance->int_cmd_wait_q, (cmd->cmd_status != ENODATA));
 
@@ -242,8 +306,7 @@ megasas_issue_blocked_abort_cmd(struct m
 	cmd->sync_cmd = 1;
 	cmd->cmd_status = 0xFF;
 
-	writel(cmd->frame_phys_addr >> 3,
-	       &instance->reg_set->inbound_queue_port);
+	instance->instancet->fire_cmd(cmd->frame_phys_addr ,0,instance->reg_set);
 
 	/*
 	 * Wait for this cmd to complete
@@ -633,8 +696,7 @@ megasas_queue_command(struct scsi_cmnd *
 	instance->fw_outstanding++;
 	spin_unlock_irqrestore(&instance->instance_lock, flags);
 
-	writel(((cmd->frame_phys_addr >> 3) | (cmd->frame_count - 1)),
-	       &instance->reg_set->inbound_queue_port);
+	instance->instancet->fire_cmd(cmd->frame_phys_addr ,cmd->frame_count-1,instance->reg_set);
 
 	return 0;
 
@@ -1045,7 +1107,6 @@ megasas_complete_cmd(struct megasas_inst
 static inline int
 megasas_deplete_reply_queue(struct megasas_instance *instance, u8 alt_status)
 {
-	u32 status;
 	u32 producer;
 	u32 consumer;
 	u32 context;
@@ -1053,17 +1114,10 @@ megasas_deplete_reply_queue(struct megas
 
 	/*
 	 * Check if it is our interrupt
+	 * Clear the interrupt 
 	 */
-	status = readl(&instance->reg_set->outbound_intr_status);
-
-	if (!(status & MFI_OB_INTR_STATUS_MASK)) {
+	if(instance->instancet->clear_intr(instance->reg_set))
 		return IRQ_NONE;
-	}
-
-	/*
-	 * Clear the interrupt by writing back the same value
-	 */
-	writel(status, &instance->reg_set->outbound_intr_status);
 
 	producer = *instance->producer;
 	consumer = *instance->consumer;
@@ -1097,7 +1151,7 @@ static irqreturn_t megasas_isr(int irq, 
 
 /**
  * megasas_transition_to_ready -	Move the FW to READY state
- * @reg_set:				MFI register set
+ * @instance:				Adapter soft state
  *
  * During the initialization, FW passes can potentially be in any one of
  * several possible states. If the FW in operational, waiting-for-handshake
@@ -1105,14 +1159,14 @@ static irqreturn_t megasas_isr(int irq, 
  * has to wait for the ready state.
  */
 static int
-megasas_transition_to_ready(struct megasas_register_set __iomem * reg_set)
+megasas_transition_to_ready(struct megasas_instance* instance)
 {
 	int i;
 	u8 max_wait;
 	u32 fw_state;
 	u32 cur_state;
 
-	fw_state = readl(&reg_set->outbound_msg_0) & MFI_STATE_MASK;
+	fw_state = instance->instancet->read_fw_status_reg(instance->reg_set) & MFI_STATE_MASK;
 
 	while (fw_state != MFI_STATE_READY) {
 
@@ -1130,7 +1184,7 @@ megasas_transition_to_ready(struct megas
 			 * Set the CLR bit in inbound doorbell
 			 */
 			writel(MFI_INIT_CLEAR_HANDSHAKE,
-			       &reg_set->inbound_doorbell);
+				&instance->reg_set->inbound_doorbell);
 
 			max_wait = 2;
 			cur_state = MFI_STATE_WAIT_HANDSHAKE;
@@ -1140,8 +1194,8 @@ megasas_transition_to_ready(struct megas
 			/*
 			 * Bring it to READY state; assuming max wait 2 secs
 			 */
-			megasas_disable_intr(reg_set);
-			writel(MFI_INIT_READY, &reg_set->inbound_doorbell);
+			megasas_disable_intr(instance->reg_set);
+			writel(MFI_INIT_READY, &instance->reg_set->inbound_doorbell);
 
 			max_wait = 10;
 			cur_state = MFI_STATE_OPERATIONAL;
@@ -1190,8 +1244,8 @@ megasas_transition_to_ready(struct megas
 		 * The cur_state should not last for more than max_wait secs
 		 */
 		for (i = 0; i < (max_wait * 1000); i++) {
-			fw_state = MFI_STATE_MASK &
-			    readl(&reg_set->outbound_msg_0);
+			fw_state = instance->instancet->read_fw_status_reg(instance->reg_set) &  
+					MFI_STATE_MASK ;
 
 			if (fw_state == cur_state) {
 				msleep(1);
@@ -1553,18 +1607,20 @@ static int megasas_init_mfi(struct megas
 
 	reg_set = instance->reg_set;
 
+	instance->instancet = &megasas_instance_template_xscale;
+
 	/*
 	 * We expect the FW state to be READY
 	 */
-	if (megasas_transition_to_ready(instance->reg_set))
+	if (megasas_transition_to_ready(instance))
 		goto fail_ready_state;
 
 	/*
 	 * Get various operational parameters from status register
 	 */
-	instance->max_fw_cmds = readl(&reg_set->outbound_msg_0) & 0x00FFFF;
-	instance->max_num_sge = (readl(&reg_set->outbound_msg_0) & 0xFF0000) >>
-	    0x10;
+	instance->max_fw_cmds = instance->instancet->read_fw_status_reg(reg_set) & 0x00FFFF;
+	instance->max_num_sge = (instance->instancet->read_fw_status_reg(reg_set) & 0xFF0000) >> 
+					0x10;
 	/*
 	 * Create a pool of commands
 	 */
@@ -1873,8 +1929,7 @@ megasas_register_aen(struct megasas_inst
 	/*
 	 * Issue the aen registration frame
 	 */
-	writel(cmd->frame_phys_addr >> 3,
-	       &instance->reg_set->inbound_queue_port);
+	instance->instancet->fire_cmd(cmd->frame_phys_addr ,0,instance->reg_set);
 
 	return 0;
 }
@@ -2063,7 +2118,7 @@ megasas_probe_one(struct pci_dev *pdev, 
 		goto fail_irq;
 	}
 
-	megasas_enable_intr(instance->reg_set);
+	instance->instancet->enable_intr(instance->reg_set);
 
 	/*
 	 * Store instance in PCI softstate
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h	2006-01-19 17:55:23.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-01-23 14:11:04.000000000 -0800
@@ -18,9 +18,9 @@
 /**
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"00.00.02.01"
-#define MEGASAS_RELDATE				"Dec 19, 2005"
-#define MEGASAS_EXT_VERSION			"Mon Dec 19 14:36:26 PST 2005"
+#define MEGASAS_VERSION				"00.00.02.02"
+#define MEGASAS_RELDATE				"Jan 23, 2006"
+#define MEGASAS_EXT_VERSION			"Mon Jan 23 14:09:01 PST 2006"
 /*
  * =====================================
  * MegaRAID SAS MFI firmware definitions
@@ -1012,6 +1012,16 @@ struct megasas_evt_detail {
 
 } __attribute__ ((packed));
 
+ struct megasas_instance_template {
+	void (*fire_cmd)(dma_addr_t ,u32 ,struct megasas_register_set __iomem *);
+
+	void (*enable_intr)(struct megasas_register_set __iomem *) ;
+
+	int (*clear_intr)(struct megasas_register_set __iomem *);
+
+	u32 (*read_fw_status_reg)(struct megasas_register_set __iomem *);
+ };
+
 struct megasas_instance {
 
 	u32 *producer;
@@ -1055,6 +1065,8 @@ struct megasas_instance {
 	u32 fw_outstanding;
 	u32 hw_crit_error;
 	spinlock_t instance_lock;
+
+	struct megasas_instance_template *instancet;
 };
 
 #define MEGASAS_IS_LOGICAL(scp)						\

--=-2Xv0qK6G+rDM37l5dFNE--

