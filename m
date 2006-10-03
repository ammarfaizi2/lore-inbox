Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWJDAwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWJDAwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWJDAwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:52:54 -0400
Received: from mail0.lsil.com ([147.145.40.20]:62963 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1161051AbWJDAwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:52:53 -0400
Subject: [Patch 3/6] megaraid_sas: function pointer for disable interrupt
From: Sumant Patro <sumantp@lsil.com>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org,
       Neela.Kolli@lsil.com, Bo.Yang@lsil.com
Content-Type: multipart/mixed; boundary="=-QEdawKcXdRQGpJndMAA2"
Date: Tue, 03 Oct 2006 12:52:12 -0700
Message-Id: <1159905132.5618.23.camel@dumbo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QEdawKcXdRQGpJndMAA2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Resubmitting.

This patch adds function pointer to invoke disable interrupt for 
xscale and ppc IOP based controllers. Removes old implementation that checks
for controller type in megasas_disable_intr.

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c 2006-10-02 11:07:59.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c 2006-10-02 11:09:33.000000000 -0700
@@ -135,6 +135,19 @@ megasas_enable_intr_xscale(struct megasa
 }
 
 /**
+ * megasas_disable_intr_xscale -Disables interrupt
+ * @regs:   MFI register set
+ */
+static inline void
+megasas_disable_intr_xscale(struct megasas_register_set __iomem * regs)
+{
+ u32 mask = 0x1f; 
+ writel(mask, &regs->outbound_intr_mask);
+ /* Dummy readl to force pci flush */
+ readl(&regs->outbound_intr_mask);
+}
+
+/**
  * megasas_read_fw_status_reg_xscale - returns the current FW status value
  * @regs:   MFI register set
  */
@@ -185,6 +198,7 @@ static struct megasas_instance_template 
 
 	.fire_cmd = megasas_fire_cmd_xscale,
 	.enable_intr = megasas_enable_intr_xscale,
+	.disable_intr = megasas_disable_intr_xscale,
 	.clear_intr = megasas_clear_intr_xscale,
 	.read_fw_status_reg = megasas_read_fw_status_reg_xscale,
 };
@@ -215,6 +229,19 @@ megasas_enable_intr_ppc(struct megasas_r
 }
 
 /**
+ * megasas_disable_intr_ppc -	Disable interrupt
+ * @regs:			MFI register set
+ */
+static inline void
+megasas_disable_intr_ppc(struct megasas_register_set __iomem * regs)
+{
+	u32 mask = 0xFFFFFFFF; 
+	writel(mask, &regs->outbound_intr_mask);
+	/* Dummy readl to force pci flush */
+	readl(&regs->outbound_intr_mask);
+}
+
+/**
  * megasas_read_fw_status_reg_ppc - returns the current FW status value
  * @regs:			MFI register set
  */
@@ -265,6 +292,7 @@ static struct megasas_instance_template 
 	
 	.fire_cmd = megasas_fire_cmd_ppc,
 	.enable_intr = megasas_enable_intr_ppc,
+	.disable_intr = megasas_disable_intr_ppc,
 	.clear_intr = megasas_clear_intr_ppc,
 	.read_fw_status_reg = megasas_read_fw_status_reg_ppc,
 };
@@ -275,25 +303,6 @@ static struct megasas_instance_template 
 */
 
 /**
- * megasas_disable_intr -	Disables interrupts
- * @regs:			MFI register set
- */
-static inline void
-megasas_disable_intr(struct megasas_instance *instance)
-{
-	u32 mask = 0x1f; 
-	struct megasas_register_set __iomem *regs = instance->reg_set;
-
-	if(instance->pdev->device == PCI_DEVICE_ID_LSI_SAS1078R)
-		mask = 0xffffffff;
-
-	writel(mask, &regs->outbound_intr_mask);
-
-	/* Dummy readl to force pci flush */
-	readl(&regs->outbound_intr_mask);
-}
-
-/**
  * megasas_issue_polled -	Issues a polling command
  * @instance:			Adapter soft state
  * @cmd:			Command packet to be issued 
@@ -1293,7 +1302,7 @@ megasas_transition_to_ready(struct megas
 			/*
 			 * Bring it to READY state; assuming max wait 10 secs
 			 */
-			megasas_disable_intr(instance);
+			instance->instancet->disable_intr(instance->reg_set);
 			writel(MFI_RESET_FLAGS, &instance->reg_set->inbound_doorbell);
 
 			max_wait = 10;
@@ -1799,7 +1808,7 @@ static int megasas_init_mfi(struct megas
 	/*
 	 * disable the intr before firing the init frame to FW
 	 */
-	megasas_disable_intr(instance);
+	instance->instancet->disable_intr(instance->reg_set);
 
 	/*
 	 * Issue the init frame in polled mode
@@ -2279,7 +2288,7 @@ megasas_probe_one(struct pci_dev *pdev, 
 	megasas_mgmt_info.max_index--;
 
 	pci_set_drvdata(pdev, NULL);
-	megasas_disable_intr(instance);
+	instance->instancet->disable_intr(instance->reg_set);
 	free_irq(instance->pdev->irq, instance);
 
 	megasas_release_mfi(instance);
@@ -2409,7 +2418,7 @@ static void megasas_detach_one(struct pc
 
 	pci_set_drvdata(instance->pdev, NULL);
 
-	megasas_disable_intr(instance);
+	instance->instancet->disable_intr(instance->reg_set);
 
 	free_irq(instance->pdev->irq, instance);
 
diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:07:59.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:09:33.000000000 -0700
@@ -1049,6 +1049,7 @@ struct megasas_evt_detail {
 	void (*fire_cmd)(dma_addr_t ,u32 ,struct megasas_register_set __iomem *);
 
  void (*enable_intr)(struct megasas_register_set __iomem *) ;
+ void (*disable_intr)(struct megasas_register_set __iomem *);
 
 	int (*clear_intr)(struct megasas_register_set __iomem *);
 


--=-QEdawKcXdRQGpJndMAA2
Content-Disposition: attachment; filename=disable_int-p3.patch
Content-Type: text/x-patch; name=disable_int-p3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c	2006-10-02 11:07:59.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2006-10-02 11:09:33.000000000 -0700
@@ -135,6 +135,19 @@ megasas_enable_intr_xscale(struct megasa
 }
 
 /**
+ * megasas_disable_intr_xscale -Disables interrupt
+ * @regs:			MFI register set
+ */
+static inline void
+megasas_disable_intr_xscale(struct megasas_register_set __iomem * regs)
+{
+	u32 mask = 0x1f; 
+	writel(mask, &regs->outbound_intr_mask);
+	/* Dummy readl to force pci flush */
+	readl(&regs->outbound_intr_mask);
+}
+
+/**
  * megasas_read_fw_status_reg_xscale - returns the current FW status value
  * @regs:			MFI register set
  */
@@ -185,6 +198,7 @@ static struct megasas_instance_template 
 
 	.fire_cmd = megasas_fire_cmd_xscale,
 	.enable_intr = megasas_enable_intr_xscale,
+	.disable_intr = megasas_disable_intr_xscale,
 	.clear_intr = megasas_clear_intr_xscale,
 	.read_fw_status_reg = megasas_read_fw_status_reg_xscale,
 };
@@ -215,6 +229,19 @@ megasas_enable_intr_ppc(struct megasas_r
 }
 
 /**
+ * megasas_disable_intr_ppc -	Disable interrupt
+ * @regs:			MFI register set
+ */
+static inline void
+megasas_disable_intr_ppc(struct megasas_register_set __iomem * regs)
+{
+	u32 mask = 0xFFFFFFFF; 
+	writel(mask, &regs->outbound_intr_mask);
+	/* Dummy readl to force pci flush */
+	readl(&regs->outbound_intr_mask);
+}
+
+/**
  * megasas_read_fw_status_reg_ppc - returns the current FW status value
  * @regs:			MFI register set
  */
@@ -265,6 +292,7 @@ static struct megasas_instance_template 
 	
 	.fire_cmd = megasas_fire_cmd_ppc,
 	.enable_intr = megasas_enable_intr_ppc,
+	.disable_intr = megasas_disable_intr_ppc,
 	.clear_intr = megasas_clear_intr_ppc,
 	.read_fw_status_reg = megasas_read_fw_status_reg_ppc,
 };
@@ -275,25 +303,6 @@ static struct megasas_instance_template 
 */
 
 /**
- * megasas_disable_intr -	Disables interrupts
- * @regs:			MFI register set
- */
-static inline void
-megasas_disable_intr(struct megasas_instance *instance)
-{
-	u32 mask = 0x1f; 
-	struct megasas_register_set __iomem *regs = instance->reg_set;
-
-	if(instance->pdev->device == PCI_DEVICE_ID_LSI_SAS1078R)
-		mask = 0xffffffff;
-
-	writel(mask, &regs->outbound_intr_mask);
-
-	/* Dummy readl to force pci flush */
-	readl(&regs->outbound_intr_mask);
-}
-
-/**
  * megasas_issue_polled -	Issues a polling command
  * @instance:			Adapter soft state
  * @cmd:			Command packet to be issued 
@@ -1293,7 +1302,7 @@ megasas_transition_to_ready(struct megas
 			/*
 			 * Bring it to READY state; assuming max wait 10 secs
 			 */
-			megasas_disable_intr(instance);
+			instance->instancet->disable_intr(instance->reg_set);
 			writel(MFI_RESET_FLAGS, &instance->reg_set->inbound_doorbell);
 
 			max_wait = 10;
@@ -1799,7 +1808,7 @@ static int megasas_init_mfi(struct megas
 	/*
 	 * disable the intr before firing the init frame to FW
 	 */
-	megasas_disable_intr(instance);
+	instance->instancet->disable_intr(instance->reg_set);
 
 	/*
 	 * Issue the init frame in polled mode
@@ -2279,7 +2288,7 @@ megasas_probe_one(struct pci_dev *pdev, 
 	megasas_mgmt_info.max_index--;
 
 	pci_set_drvdata(pdev, NULL);
-	megasas_disable_intr(instance);
+	instance->instancet->disable_intr(instance->reg_set);
 	free_irq(instance->pdev->irq, instance);
 
 	megasas_release_mfi(instance);
@@ -2409,7 +2418,7 @@ static void megasas_detach_one(struct pc
 
 	pci_set_drvdata(instance->pdev, NULL);
 
-	megasas_disable_intr(instance);
+	instance->instancet->disable_intr(instance->reg_set);
 
 	free_irq(instance->pdev->irq, instance);
 
diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:07:59.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:09:33.000000000 -0700
@@ -1049,6 +1049,7 @@ struct megasas_evt_detail {
 	void (*fire_cmd)(dma_addr_t ,u32 ,struct megasas_register_set __iomem *);
 
 	void (*enable_intr)(struct megasas_register_set __iomem *) ;
+	void (*disable_intr)(struct megasas_register_set __iomem *);
 
 	int (*clear_intr)(struct megasas_register_set __iomem *);
 

--=-QEdawKcXdRQGpJndMAA2--

