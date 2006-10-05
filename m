Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWJESYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWJESYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWJESXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:23:47 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:7639 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1751267AbWJESXA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:23:00 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 7/10] VIOC: New Network Device Driver
Date: Thu, 5 Oct 2006 11:07:59 -0700
User-Agent: KMail/1.5.1
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051107.59678.misha@fabric7.com>
X-OriginalArrivalTime: 05 Oct 2006 18:22:43.0484 (UTC) FILETIME=[3FD875C0:01C6E8AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding VIOC device driver. Interrupt handler.

Signed-off-by: Misha Tomushev  <misha@fabric7.com>

diff -uprN linux-2.6.17/drivers/net/vioc/vioc_irq.c 
linux-2.6.17.vioc/drivers/net/vioc/vioc_irq.c
--- linux-2.6.17/drivers/net/vioc/vioc_irq.c	1969-12-31 16:00:00.000000000 
-0800
+++ linux-2.6.17.vioc/drivers/net/vioc/vioc_irq.c	2006-10-04 
10:37:56.000000000 -0700
@@ -0,0 +1,538 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/if_vlan.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/pci.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/uaccess.h>
+#include <asm/apic.h>
+
+#include "f7/vnic_hw_registers.h"
+#include "f7/vnic_defs.h"
+#include "vioc_vnic.h"
+
+#define VIOC_INTERRUPTS_CNT    19	/* 16 Rx + 1 Tx + 1 BMC + 1 Error */
+#define VIOC_INTERRUPTS_CNT_PIN_IRQ    4	/* 2 Rx + 1 Tx + 1 BMC */
+
+#define VIOC_SLVAR(x) x spinlock_t vioc_driver_lock = SPIN_LOCK_UNLOCKED
+#define VIOC_CLI spin_lock_irq(&vioc_driver_lock)
+#define VIOC_STI spin_unlock_irq(&vioc_driver_lock)
+#define IRQRETURN return IRQ_HANDLED
+#define TX_IRQ_IDX			16
+#define BMC_IRQ_IDX			17
+#define ERR_IRQ_IDX			18
+#define HANDLER_TASKLET		1
+#define HANDLER_DIRECT		2
+#define HANDLER_TASKQ		3
+#define VIOC_RX0_PCI_FUNC   0
+#define VIOC_TX_PCI_FUNC    1
+#define VIOC_BMC_PCI_FUNC   2
+#define VIOC_RX1_PCI_FUNC   3
+#define VIOC_IRQ_NONE       (u16) -1
+#define VIOC_ID_NONE        -1
+#define VIOC_IVEC_NONE      -1
+#define VIOC_INTR_NONE      -1
+
+
+struct vioc_msix_entry {
+	u16 vector;
+	u16 entry;
+};
+
+struct vioc_intreq {
+	char name[VIOC_NAME_LEN];
+	void (*intrFuncp) (void *);
+	void *intrFuncparm;
+	 irqreturn_t(*hthandler) (int, void *, struct pt_regs *);
+	unsigned int irq;
+	unsigned int vec;
+	unsigned int intr_base;
+	unsigned int intr_offset;
+	unsigned int timeout_value;
+	unsigned int pkt_counter;
+	unsigned int rxc_mask;
+	struct work_struct taskq;
+	struct tasklet_struct tasklet;
+};
+
+struct viocdev_intreq {
+	int vioc_id;
+	struct pci_dev *pci_dev;
+	void *vioc_virt;
+	unsigned long long vioc_phy;
+	void *ioapic_virt;
+	unsigned long long ioapic_phy;
+	struct vioc_intreq intreq[VIOC_INTERRUPTS_CNT];
+	struct vioc_msix_entry irqs[VIOC_INTERRUPTS_CNT];
+};
+
+/* GLOBAL VIOC Interrupt table/structure */
+struct viocdev_intreq vioc_interrupts[VIOC_MAX_VIOCS];
+
+VIOC_SLVAR();
+
+static irqreturn_t taskq_handler(int i, void *p, struct pt_regs *r)
+{
+	int intr_id = VIOC_IRQ_PARAM_INTR_ID(p);
+	int vioc_id = VIOC_IRQ_PARAM_VIOC_ID(p);
+
+	schedule_work(&vioc_interrupts[vioc_id].intreq[intr_id].taskq);
+	IRQRETURN;
+}
+
+static irqreturn_t tasklet_handler(int i, void *p, struct pt_regs *r)
+{
+	int intr_id = VIOC_IRQ_PARAM_INTR_ID(p);
+	int vioc_id = VIOC_IRQ_PARAM_VIOC_ID(p);
+
+	tasklet_schedule(&vioc_interrupts[vioc_id].intreq[intr_id].tasklet);
+	IRQRETURN;
+}
+
+static irqreturn_t direct_handler(int i, void *p, struct pt_regs *r)
+{
+	int intr_id = VIOC_IRQ_PARAM_INTR_ID(p);
+	int vioc_id = VIOC_IRQ_PARAM_VIOC_ID(p);
+
+	vioc_interrupts[vioc_id].intreq[intr_id].
+	    intrFuncp(vioc_interrupts[vioc_id].intreq[intr_id].intrFuncparm);
+	IRQRETURN;
+}
+
+static int vioc_enable_msix(u32 viocdev_idx)
+{
+	struct vioc_device *viocdev = vioc_viocdev(viocdev_idx);
+	int ret;
+
+#if defined(CONFIG_MSIX_MOD)
+	ret = pci_enable_msix(viocdev->pdev,
+			      (struct msix_entry *)
+			      &vioc_interrupts[viocdev_idx].irqs,
+			      VIOC_INTERRUPTS_CNT);
+	if (ret == 0) {
+		dev_err(&viocdev->pdev->dev, "MSI-X OK\n");
+		return VIOC_INTERRUPTS_CNT;
+	} else {
+		dev_err(&viocdev->pdev->dev,
+		       "Enabling MSIX failed (%d) VIOC %d, use PIN-IRQ\n", ret,
+		       viocdev_idx);
+		pci_disable_msix(viocdev->pdev);
+		ret = pci_request_regions(viocdev->pdev, VIOC_DRV_MODULE_NAME);
+		if (ret != 0) {
+			dev_err(&viocdev->pdev->dev, "vioc%d: Cannot obtain PCI resources\n",
+			       viocdev_idx);
+			return 0;
+		}
+		return VIOC_INTERRUPTS_CNT_PIN_IRQ;
+	}
+#else
+	ret = pci_request_regions(viocdev->pdev, VIOC_DRV_MODULE_NAME);
+	if (ret != 0) {
+		dev_err(&viocdev->pdev->dev, "vioc%d: Cannot obtain PCI resources\n",
+		       viocdev_idx);
+		return 0;
+	}
+	return VIOC_INTERRUPTS_CNT_PIN_IRQ;
+#endif
+}
+
+static void vioc_irq_remove(int viocdev_idx, int irq)
+{
+	int intr_id;
+
+	if (viocdev_idx >= VIOC_MAX_VIOCS)
+		return;
+
+	for (intr_id = 0; intr_id < VIOC_INTERRUPTS_CNT; intr_id++) {
+		if (vioc_interrupts[viocdev_idx].intreq[intr_id].irq == irq) {
+			if (vioc_interrupts[viocdev_idx].intreq[intr_id].irq !=
+			    VIOC_IRQ_NONE) {
+				free_irq(vioc_interrupts[viocdev_idx].
+					 intreq[intr_id].irq,
+					 vioc_interrupts[viocdev_idx].
+					 intreq[intr_id].intrFuncparm);
+			}
+			vioc_interrupts[viocdev_idx].intreq[intr_id].irq =
+			    VIOC_IRQ_NONE;
+			vioc_interrupts[viocdev_idx].irqs[intr_id].vector =
+			    VIOC_IRQ_NONE;
+		}
+	}
+}
+
+void vioc_free_irqs(u32 viocdev_idx)
+{
+	u32 i;
+
+	for (i = 0; i < VIOC_INTERRUPTS_CNT; i++) {
+		if (vioc_interrupts[viocdev_idx].irqs[i].vector !=
+		    VIOC_IRQ_NONE) {
+			vioc_irq_remove(viocdev_idx,
+					vioc_interrupts[viocdev_idx].irqs[i].
+					vector);
+		}
+	}
+}
+
+void vioc_irq_exit(void)
+{
+	int vioc_id;
+
+	for (vioc_id = 0; vioc_id < VIOC_MAX_VIOCS; vioc_id++)
+		vioc_free_irqs(vioc_id);
+}
+
+int vioc_irq_init(void)
+{
+	int intr_id, vioc_id;
+
+	/* Zero out whole vioc_interrupts array */
+	memset(&vioc_interrupts, 0, sizeof(vioc_interrupts));
+
+	for (vioc_id = 0; vioc_id < VIOC_MAX_VIOCS; vioc_id++) {
+		vioc_interrupts[vioc_id].vioc_id = VIOC_ID_NONE;
+		for (intr_id = 0; intr_id < VIOC_INTERRUPTS_CNT; intr_id++) {
+			vioc_interrupts[vioc_id].intreq[intr_id].irq =
+			    VIOC_IRQ_NONE;
+			vioc_interrupts[vioc_id].irqs[intr_id].vector =
+			    VIOC_IRQ_NONE;
+			vioc_interrupts[vioc_id].irqs[intr_id].entry = intr_id;
+		}
+	}
+	return 0;
+}
+
+int get_pci_pin_irq(struct pci_dev *dev_in, int func)
+{
+	struct pci_dev *dev = NULL;
+	unsigned int slot, fn, devfn;
+
+	slot = PCI_SLOT(dev_in->devfn);
+	fn = PCI_FUNC(dev_in->devfn);
+	devfn = dev_in->devfn;
+
+	devfn = PCI_DEVFN(slot, func);
+	/* Find pci_dev structure of the requested function */
+	dev = pci_find_slot(dev_in->bus->number, devfn);
+	if (dev) {
+		return dev->irq;
+	} else {
+		return VIOC_IRQ_NONE;
+	}
+}
+
+static int vioc_irq_install(struct pci_dev *vioc_pci_dev,
+			    void (*routine) (void *),
+			    int vioc_id,
+			    int intr_id,
+			    int irq,
+			    int intr_handler_type,
+			    int intr_param, char *intr_name)
+{
+	int ret;
+	void *intr_func_param = (void *)
+	    VIOC_IRQ_PARAM_SET(vioc_id, intr_id, intr_param);
+
+	/*
+	 * Find IRQ of requested interrupt: For now, search the
+	 * vioc_interrupts[] table that was initialized with proper
+	 * IRQs during viocdev_htirq_init() In the final product, the
+	 * IRQ will be obtained from the pci_dev structure of the VIOC
+	 * device.
+	 */
+
+	if (vioc_id >= VIOC_MAX_VIOCS)
+		return -ENODEV;
+
+	if (intr_id >= VIOC_INTERRUPTS_CNT) {
+		dev_err(&vioc_pci_dev->dev,
+		       "%s: INTR ID (%d) out of range for Interrupt IRQ %d, name %s\n",
+		       __FUNCTION__, intr_id, irq, intr_name);
+		return -EINVAL;
+	}
+	vioc_interrupts[vioc_id].vioc_id = vioc_id;
+
+	if (vioc_interrupts[vioc_id].intreq[intr_id].irq != VIOC_IRQ_NONE) {
+		free_irq(vioc_interrupts[vioc_id].
+			 intreq[intr_id].irq,
+			 vioc_interrupts[vioc_id].intreq[intr_id].intrFuncparm);
+		vioc_interrupts[vioc_id].intreq[intr_id].irq = VIOC_IRQ_NONE;
+	}
+
+	vioc_set_intr_func_param(vioc_id, intr_id, intr_param);
+	INIT_WORK(&vioc_interrupts[vioc_id].intreq[intr_id].taskq, routine,
+		  intr_func_param);
+
+	vioc_interrupts[vioc_id].intreq[intr_id].irq = irq;
+	vioc_interrupts[vioc_id].intreq[intr_id].name[VIOC_NAME_LEN - 1] = '\0';
+
+	vioc_interrupts[vioc_id].intreq[intr_id].timeout_value = 100;
+	vioc_interrupts[vioc_id].intreq[intr_id].pkt_counter = 1;
+	vioc_interrupts[vioc_id].intreq[intr_id].vec = VIOC_IVEC_NONE;
+	vioc_interrupts[vioc_id].intreq[intr_id].intrFuncp = routine;
+
+	/* Init work_struct used to schedule task from INTR handler code */
+
+	/* Init tasklet_struct used to run "tasklet" from INTR handler code */
+	vioc_interrupts[vioc_id].intreq[intr_id].tasklet.next = NULL;
+	vioc_interrupts[vioc_id].intreq[intr_id].tasklet.state = 0;
+	atomic_set(&vioc_interrupts[vioc_id].intreq[intr_id].tasklet.count, 0);
+	vioc_interrupts[vioc_id].intreq[intr_id].tasklet.func =
+	    (void (*)(unsigned long))routine;
+
+	snprintf(&vioc_interrupts[vioc_id].intreq[intr_id].name[0],
+		 VIOC_NAME_LEN, "%s_%02x", intr_name, vioc_id);
+	vioc_interrupts[vioc_id].intreq[intr_id].name[VIOC_NAME_LEN - 1] = '\0';
+
+	if (intr_handler_type == HANDLER_TASKLET)
+		vioc_interrupts[vioc_id].intreq[intr_id].hthandler =
+		    tasklet_handler;
+	else if (intr_handler_type == HANDLER_TASKQ)
+		vioc_interrupts[vioc_id].intreq[intr_id].hthandler =
+		    taskq_handler;
+	else if (intr_handler_type == HANDLER_DIRECT)
+		vioc_interrupts[vioc_id].intreq[intr_id].hthandler =
+		    direct_handler;
+	else {
+		dev_err(&vioc_pci_dev->dev,
+		       "%s: Interrupt handler type for name %s unknown\n",
+		       __FUNCTION__, intr_name);
+		return -EINVAL;
+	}
+
+	ret = request_irq(vioc_interrupts[vioc_id].intreq[intr_id].irq,
+			  vioc_interrupts[vioc_id].intreq[intr_id].hthandler,
+			  SA_INTERRUPT,
+			  vioc_interrupts[vioc_id].intreq[intr_id].name,
+			  vioc_interrupts[vioc_id].intreq[intr_id].
+			  intrFuncparm);
+	if (ret) {
+		dev_err(&vioc_pci_dev->dev, "%s: request_irq() -> %d\n", __FUNCTION__, 
ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int vioc_set_intr_func_param(int viocdev_idx, int intr_idx, int intr_param)
+{
+	struct vioc_device *viocdev = vioc_viocdev(viocdev_idx);
+
+	void *intr_func_param = (void *)
+	    VIOC_IRQ_PARAM_SET(viocdev_idx, intr_idx, intr_param);
+
+	if (viocdev_idx >= VIOC_MAX_VIOCS) {
+		dev_err(&viocdev->pdev->dev, "%s: VIOC ID (%d) is out of range\n",
+		       __FUNCTION__, viocdev_idx);
+		return -ENODEV;
+	}
+
+	if (intr_idx >= VIOC_INTERRUPTS_CNT) {
+		dev_err(&viocdev->pdev->dev, "%s: INTR ID (%d) is out of range\n",
+		       __FUNCTION__, intr_idx);
+		return -EINVAL;
+	}
+
+	vioc_interrupts[viocdev_idx].intreq[intr_idx].intrFuncparm =
+	    intr_func_param;
+	vioc_interrupts[viocdev_idx].intreq[intr_idx].taskq.data =
+	    intr_func_param;
+	vioc_interrupts[viocdev_idx].intreq[intr_idx].tasklet.data =
+	    (unsigned long)intr_func_param;
+	return 0;
+}
+
+/*
+ * Function returns number of Rx IRQs.
+ * When PIN IRQ is used, 2 Rx IRQs are supported.
+ * With MSI-X 16 Rx IRQs.
+ */
+
+int vioc_request_irqs(u32 viocdev_idx)
+{
+	struct vioc_device *viocdev = vioc_viocdev(viocdev_idx);
+	int ret;
+	int total_num_irqs;
+	int intr_idx;
+	char name_buf[64];
+
+	/* Check for MSI-X, install either 2 or 16 Rx IRQs */
+	total_num_irqs = vioc_enable_msix(viocdev_idx);
+	viocdev->num_irqs = total_num_irqs;
+
+	switch (total_num_irqs) {
+
+	case VIOC_INTERRUPTS_CNT_PIN_IRQ:
+		vioc_interrupts[viocdev_idx].irqs[2].vector =
+		    get_pci_pin_irq(viocdev->pdev, VIOC_TX_PCI_FUNC);
+		vioc_interrupts[viocdev_idx].irqs[3].vector =
+		    get_pci_pin_irq(viocdev->pdev, VIOC_BMC_PCI_FUNC);
+
+		intr_idx = 0;
+		vioc_interrupts[viocdev_idx].irqs[intr_idx].vector =
+		    get_pci_pin_irq(viocdev->pdev, VIOC_RX0_PCI_FUNC);
+		sprintf(name_buf, "rx%02d_intr", intr_idx);
+		ret = vioc_irq_install(viocdev->pdev,
+				       vioc_rxc_interrupt,
+				       viocdev_idx,
+				       intr_idx,
+				       vioc_interrupts[viocdev_idx].
+				       irqs[intr_idx].vector, HANDLER_DIRECT,
+				       intr_idx, name_buf);
+		if (ret) {
+			dev_err(&viocdev->pdev->dev, "vioc%d: RX IRQ %02d not installed\n",
+			       viocdev_idx, intr_idx);
+			return 0;
+		}
+
+		intr_idx = 1;
+		vioc_interrupts[viocdev_idx].irqs[intr_idx].vector =
+		    get_pci_pin_irq(viocdev->pdev, VIOC_RX1_PCI_FUNC);
+		sprintf(name_buf, "rx%02d_intr", intr_idx);
+		ret = vioc_irq_install(viocdev->pdev,
+				       vioc_rxc_interrupt,
+				       viocdev_idx,
+				       intr_idx,
+				       vioc_interrupts[viocdev_idx].
+				       irqs[intr_idx].vector, HANDLER_DIRECT,
+				       intr_idx, name_buf);
+		if (ret) {
+			dev_err(&viocdev->pdev->dev, "vioc%d: RX IRQ %02d not installed\n",
+			       viocdev_idx, intr_idx);
+			return 0;
+		}
+
+		intr_idx = TX_IRQ_IDX;
+		vioc_interrupts[viocdev_idx].irqs[intr_idx].vector =
+		    get_pci_pin_irq(viocdev->pdev, VIOC_TX_PCI_FUNC);
+		ret = vioc_irq_install(viocdev->pdev,
+				       vioc_tx_interrupt,
+				       viocdev_idx,
+				       intr_idx,
+				       vioc_interrupts[viocdev_idx].
+				       irqs[intr_idx].vector, HANDLER_TASKLET,
+				       intr_idx, "tx_intr");
+		if (ret) {
+			dev_err(&viocdev->pdev->dev, "vioc%d: TX IRQ not installed\n",
+			       viocdev_idx);
+			return 0;
+		}
+
+		intr_idx = BMC_IRQ_IDX;
+		vioc_interrupts[viocdev_idx].irqs[intr_idx].vector =
+		    get_pci_pin_irq(viocdev->pdev, VIOC_BMC_PCI_FUNC);
+		ret = vioc_irq_install(viocdev->pdev,
+				       vioc_bmc_interrupt,
+				       viocdev_idx,
+				       intr_idx,
+				       vioc_interrupts[viocdev_idx].
+				       irqs[intr_idx].vector, HANDLER_TASKQ,
+				       intr_idx, "bmc_intr");
+		if (ret) {
+			dev_err(&viocdev->pdev->dev, "vioc%d: BMC IRQ not installed\n",
+			       viocdev_idx);
+			return 0;
+		}
+
+		return 2;
+
+	case VIOC_INTERRUPTS_CNT:
+
+		for (intr_idx = 0; intr_idx < 16; intr_idx++) {
+			sprintf(name_buf, "rx%02d_intr", intr_idx);
+			ret = vioc_irq_install(viocdev->pdev,
+					       vioc_rxc_interrupt,
+					       viocdev_idx,
+					       intr_idx,
+					       vioc_interrupts[viocdev_idx].
+					       irqs[intr_idx].vector,
+					       HANDLER_DIRECT, intr_idx,
+					       name_buf);
+			if (ret) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: RX IRQ %02d not installed\n",
+				       viocdev_idx, intr_idx);
+				return 0;
+			}
+		}
+
+		intr_idx = TX_IRQ_IDX;
+		ret = vioc_irq_install(viocdev->pdev,
+				       vioc_tx_interrupt,
+				       viocdev_idx,
+				       intr_idx,
+				       vioc_interrupts[viocdev_idx].
+				       irqs[intr_idx].vector, HANDLER_TASKLET,
+				       intr_idx, "tx_intr");
+		if (ret) {
+			dev_err(&viocdev->pdev->dev, "vioc%d: TX IRQ not installed\n",
+			       viocdev_idx);
+			return 0;
+		}
+
+		intr_idx = BMC_IRQ_IDX;
+		ret = vioc_irq_install(viocdev->pdev,
+				       vioc_bmc_interrupt,
+				       viocdev_idx,
+				       intr_idx,
+				       vioc_interrupts[viocdev_idx].
+				       irqs[intr_idx].vector, HANDLER_TASKQ,
+				       intr_idx, "bmc_intr");
+		if (ret) {
+			dev_err(&viocdev->pdev->dev, "vioc%d: BMC IRQ not installed\n",
+			       viocdev_idx);
+			return 0;
+		}
+
+		return 16;
+
+	default:
+
+		return 0;
+	}
+
+	return 0;
+}
+


-- 
Misha Tomushev
misha@fabric7.com


