Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVCCXzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVCCXzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVCCXxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:53:05 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262735AbVCCXWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:17 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][12/26] IB/mthca: mem-free interrupt handling
In-Reply-To: <2005331520.nW52EhJhFo4sAhLI@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.KR3jHRDWtXI3rzl6@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0738 (UTC) FILETIME=[95C48BA0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update interrupt handling code to handle mem-free mode.  While we're
at it, improve the Tavor interrupt handling to avoid an extra MMIO
read of the event cause register.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:12:56.152732681 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:12:57.857362663 -0800
@@ -171,6 +171,7 @@
 	struct mthca_alloc alloc;
 	void __iomem      *clr_int;
 	u32                clr_mask;
+	u32                arm_mask;
 	struct mthca_eq    eq[MTHCA_NUM_EQ];
 	u64                icm_virt;
 	struct page       *icm_page;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-03-03 14:12:57.462448386 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_eq.c	2005-03-03 14:12:57.859362229 -0800
@@ -165,19 +165,46 @@
 		MTHCA_ASYNC_EVENT_MASK;
 }
 
-static inline void set_eq_ci(struct mthca_dev *dev, struct mthca_eq *eq, u32 ci)
+static inline void tavor_set_eq_ci(struct mthca_dev *dev, struct mthca_eq *eq, u32 ci)
 {
 	u32 doorbell[2];
 
 	doorbell[0] = cpu_to_be32(MTHCA_EQ_DB_SET_CI | eq->eqn);
 	doorbell[1] = cpu_to_be32(ci & (eq->nent - 1));
 
+	/*
+	 * This barrier makes sure that all updates to ownership bits
+	 * done by set_eqe_hw() hit memory before the consumer index
+	 * is updated.  set_eq_ci() allows the HCA to possibly write
+	 * more EQ entries, and we want to avoid the exceedingly
+	 * unlikely possibility of the HCA writing an entry and then
+	 * having set_eqe_hw() overwrite the owner field.
+	 */
+	wmb();
 	mthca_write64(doorbell,
 		      dev->kar + MTHCA_EQ_DOORBELL,
 		      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 }
 
-static inline void eq_req_not(struct mthca_dev *dev, int eqn)
+static inline void arbel_set_eq_ci(struct mthca_dev *dev, struct mthca_eq *eq, u32 ci)
+{
+	/* See comment in tavor_set_eq_ci() above. */
+	wmb();
+	__raw_writel(cpu_to_be32(ci), dev->eq_regs.arbel.eq_set_ci_base +
+		     eq->eqn * 8);
+	/* We still want ordering, just not swabbing, so add a barrier */
+	mb();
+}
+
+static inline void set_eq_ci(struct mthca_dev *dev, struct mthca_eq *eq, u32 ci)
+{
+	if (dev->hca_type == ARBEL_NATIVE)
+		arbel_set_eq_ci(dev, eq, ci);
+	else
+		tavor_set_eq_ci(dev, eq, ci);
+}
+
+static inline void tavor_eq_req_not(struct mthca_dev *dev, int eqn)
 {
 	u32 doorbell[2];
 
@@ -189,16 +216,23 @@
 		      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 }
 
+static inline void arbel_eq_req_not(struct mthca_dev *dev, u32 eqn_mask)
+{
+	writel(eqn_mask, dev->eq_regs.arbel.eq_arm);
+}
+
 static inline void disarm_cq(struct mthca_dev *dev, int eqn, int cqn)
 {
-	u32 doorbell[2];
+	if (dev->hca_type != ARBEL_NATIVE) {
+		u32 doorbell[2];
 
-	doorbell[0] = cpu_to_be32(MTHCA_EQ_DB_DISARM_CQ | eqn);
-	doorbell[1] = cpu_to_be32(cqn);
+		doorbell[0] = cpu_to_be32(MTHCA_EQ_DB_DISARM_CQ | eqn);
+		doorbell[1] = cpu_to_be32(cqn);
 
-	mthca_write64(doorbell,
-		      dev->kar + MTHCA_EQ_DOORBELL,
-		      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+		mthca_write64(doorbell,
+			      dev->kar + MTHCA_EQ_DOORBELL,
+			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+	}
 }
 
 static inline struct mthca_eqe *get_eqe(struct mthca_eq *eq, u32 entry)
@@ -233,7 +267,7 @@
 	ib_dispatch_event(&record);
 }
 
-static void mthca_eq_int(struct mthca_dev *dev, struct mthca_eq *eq)
+static int mthca_eq_int(struct mthca_dev *dev, struct mthca_eq *eq)
 {
 	struct mthca_eqe *eqe;
 	int disarm_cqn;
@@ -334,60 +368,93 @@
 		++eq->cons_index;
 		eqes_found = 1;
 
-		if (set_ci) {
-			wmb(); /* see comment below */
+		if (unlikely(set_ci)) {
+			/*
+			 * Conditional on hca_type is OK here because
+			 * this is a rare case, not the fast path.
+			 */
 			set_eq_ci(dev, eq, eq->cons_index);
 			set_ci = 0;
 		}
 	}
 
 	/*
-	 * This barrier makes sure that all updates to
-	 * ownership bits done by set_eqe_hw() hit memory
-	 * before the consumer index is updated.  set_eq_ci()
-	 * allows the HCA to possibly write more EQ entries,
-	 * and we want to avoid the exceedingly unlikely
-	 * possibility of the HCA writing an entry and then
-	 * having set_eqe_hw() overwrite the owner field.
+	 * Rely on caller to set consumer index so that we don't have
+	 * to test hca_type in our interrupt handling fast path.
 	 */
-	if (likely(eqes_found)) {
-		wmb();
-		set_eq_ci(dev, eq, eq->cons_index);
-	}
-	eq_req_not(dev, eq->eqn);
+	return eqes_found;
 }
 
-static irqreturn_t mthca_interrupt(int irq, void *dev_ptr, struct pt_regs *regs)
+static irqreturn_t mthca_tavor_interrupt(int irq, void *dev_ptr, struct pt_regs *regs)
 {
 	struct mthca_dev *dev = dev_ptr;
 	u32 ecr;
-	int work = 0;
 	int i;
 
 	if (dev->eq_table.clr_mask)
 		writel(dev->eq_table.clr_mask, dev->eq_table.clr_int);
 
-	if ((ecr = readl(dev->eq_regs.tavor.ecr_base + 4)) != 0) {
-		work = 1;
-
+	ecr = readl(dev->eq_regs.tavor.ecr_base + 4);
+	if (ecr) {
 		writel(ecr, dev->eq_regs.tavor.ecr_base +
 		       MTHCA_ECR_CLR_BASE - MTHCA_ECR_BASE + 4);
 
 		for (i = 0; i < MTHCA_NUM_EQ; ++i)
-			if (ecr & dev->eq_table.eq[i].ecr_mask)
-				mthca_eq_int(dev, &dev->eq_table.eq[i]);
+			if (ecr & dev->eq_table.eq[i].eqn_mask &&
+			    mthca_eq_int(dev, &dev->eq_table.eq[i])) {
+				tavor_set_eq_ci(dev, &dev->eq_table.eq[i],
+						dev->eq_table.eq[i].cons_index);
+				tavor_eq_req_not(dev, dev->eq_table.eq[i].eqn);
+			}
 	}
 
-	return IRQ_RETVAL(work);
+	return IRQ_RETVAL(ecr);
 }
 
-static irqreturn_t mthca_msi_x_interrupt(int irq, void *eq_ptr,
+static irqreturn_t mthca_tavor_msi_x_interrupt(int irq, void *eq_ptr,
 					 struct pt_regs *regs)
 {
 	struct mthca_eq  *eq  = eq_ptr;
 	struct mthca_dev *dev = eq->dev;
 
 	mthca_eq_int(dev, eq);
+	tavor_set_eq_ci(dev, eq, eq->cons_index);
+	tavor_eq_req_not(dev, eq->eqn);
+
+	/* MSI-X vectors always belong to us */
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mthca_arbel_interrupt(int irq, void *dev_ptr, struct pt_regs *regs)
+{
+	struct mthca_dev *dev = dev_ptr;
+	int work = 0;
+	int i;
+
+	if (dev->eq_table.clr_mask)
+		writel(dev->eq_table.clr_mask, dev->eq_table.clr_int);
+
+	for (i = 0; i < MTHCA_NUM_EQ; ++i)
+		if (mthca_eq_int(dev, &dev->eq_table.eq[i])) {
+			work = 1;
+			arbel_set_eq_ci(dev, &dev->eq_table.eq[i],
+					dev->eq_table.eq[i].cons_index);
+		}
+
+	arbel_eq_req_not(dev, dev->eq_table.arm_mask);
+
+	return IRQ_RETVAL(work);
+}
+
+static irqreturn_t mthca_arbel_msi_x_interrupt(int irq, void *eq_ptr,
+					       struct pt_regs *regs)
+{
+	struct mthca_eq  *eq  = eq_ptr;
+	struct mthca_dev *dev = eq->dev;
+
+	mthca_eq_int(dev, eq);
+	arbel_set_eq_ci(dev, eq, eq->cons_index);
+	arbel_eq_req_not(dev, eq->eqn_mask);
 
 	/* MSI-X vectors always belong to us */
 	return IRQ_HANDLED;
@@ -496,10 +563,10 @@
 	kfree(dma_list);
 	kfree(mailbox);
 
-	eq->ecr_mask   = swab32(1 << eq->eqn);
+	eq->eqn_mask   = swab32(1 << eq->eqn);
 	eq->cons_index = 0;
 
-	eq_req_not(dev, eq->eqn);
+	dev->eq_table.arm_mask |= eq->eqn_mask;
 
 	mthca_dbg(dev, "Allocated EQ %d with %d entries\n",
 		  eq->eqn, nent);
@@ -551,6 +618,8 @@
 		mthca_warn(dev, "HW2SW_EQ returned status 0x%02x\n",
 			   status);
 
+	dev->eq_table.arm_mask &= ~eq->eqn_mask;
+
 	if (0) {
 		mthca_dbg(dev, "Dumping EQ context %02x:\n", eq->eqn);
 		for (i = 0; i < sizeof (struct mthca_eq_context) / 4; ++i) {
@@ -562,7 +631,6 @@
 		}
 	}
 
-
 	mthca_free_mr(dev, &eq->mr);
 	for (i = 0; i < npages; ++i)
 		pci_free_consistent(dev->pdev, PAGE_SIZE,
@@ -780,6 +848,8 @@
 			(dev->eq_table.inta_pin < 31 ? 4 : 0);
 	}
 
+	dev->eq_table.arm_mask = 0;
+
 	intr = (dev->mthca_flags & MTHCA_FLAG_MSI) ?
 		128 : dev->eq_table.inta_pin;
 
@@ -810,15 +880,20 @@
 
 		for (i = 0; i < MTHCA_NUM_EQ; ++i) {
 			err = request_irq(dev->eq_table.eq[i].msi_x_vector,
-					  mthca_msi_x_interrupt, 0,
-					  eq_name[i], dev->eq_table.eq + i);
+					  dev->hca_type == ARBEL_NATIVE ?
+					  mthca_arbel_msi_x_interrupt :
+					  mthca_tavor_msi_x_interrupt,
+					  0, eq_name[i], dev->eq_table.eq + i);
 			if (err)
 				goto err_out_cmd;
 			dev->eq_table.eq[i].have_irq = 1;
 		}
 	} else {
-		err = request_irq(dev->pdev->irq, mthca_interrupt, SA_SHIRQ,
-				  DRV_NAME, dev);
+		err = request_irq(dev->pdev->irq,
+				  dev->hca_type == ARBEL_NATIVE ?
+				  mthca_arbel_interrupt :
+				  mthca_tavor_interrupt,
+				  SA_SHIRQ, DRV_NAME, dev);
 		if (err)
 			goto err_out_cmd;
 		dev->eq_table.have_irq = 1;
@@ -842,6 +917,12 @@
 		mthca_warn(dev, "MAP_EQ for cmd EQ %d returned status 0x%02x\n",
 			   dev->eq_table.eq[MTHCA_EQ_CMD].eqn, status);
 
+	for (i = 0; i < MTHCA_EQ_CMD; ++i)
+		if (dev->hca_type == ARBEL_NATIVE)
+			arbel_eq_req_not(dev, dev->eq_table.eq[i].eqn_mask);
+		else
+			tavor_eq_req_not(dev, dev->eq_table.eq[i].eqn);
+
 	return 0;
 
 err_out_cmd:
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:12:56.772598129 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:12:57.858362446 -0800
@@ -608,13 +608,6 @@
 		goto err_mr_table_free;
 	}
 
-	if (dev->hca_type == ARBEL_NATIVE) {
-		mthca_warn(dev, "Sorry, native MT25208 mode support is not done, "
-			   "aborting.\n");
-		err = -ENODEV;
-		goto err_pd_free;
-	}
-
 	err = mthca_init_eq_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
@@ -638,8 +631,16 @@
 			mthca_err(dev, "BIOS or ACPI interrupt routing problem?\n");
 
 		goto err_cmd_poll;
-	} else
-		mthca_dbg(dev, "NOP command IRQ test passed\n");
+	}
+
+	mthca_dbg(dev, "NOP command IRQ test passed\n");
+
+	if (dev->hca_type == ARBEL_NATIVE) {
+		mthca_warn(dev, "Sorry, native MT25208 mode support is not complete, "
+			   "aborting.\n");
+		err = -ENODEV;
+		goto err_cmd_poll;
+	}
 
 	err = mthca_init_cq_table(dev);
 	if (err) {
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:12:56.153732464 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:12:57.858362446 -0800
@@ -70,7 +70,7 @@
 struct mthca_eq {
 	struct mthca_dev      *dev;
 	int                    eqn;
-	u32                    ecr_mask;
+	u32                    eqn_mask;
 	u32                    cons_index;
 	u16                    msi_x_vector;
 	u16                    msi_x_entry;

