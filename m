Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWITGCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWITGCP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 02:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWITGCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 02:02:15 -0400
Received: from web36712.mail.mud.yahoo.com ([209.191.85.46]:41108 "HELO
	web36712.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750756AbWITGCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 02:02:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OjWfrsw7BbqznaS86iBrfNe4pxZoLnzcXpFp8OEa11YPpElfNDdrEKTGqSIaMjqHX7pSWs06oYngCFbwrpWnRM+jF4G5G5JYoU4IX2WDj10biDQ+MMnw7H+ofxOVZhdiBl2xRa800jHFJFNvmPWLYXFOK2m9arbpqKETZZECBDE=  ;
Message-ID: <20060920060212.7327.qmail@web36712.mail.mud.yahoo.com>
Date: Tue, 19 Sep 2006 23:02:11 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: [PATCH 1/2] [MMC] Driver for TI FlashMedia card reader - source
To: linux-kernel@vger.kernel.org
Cc: drzeus-list@drzeus.cx, rmk+lkml@arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for TI Flash Media card reader. At present, only MMC/SD
cards are supported.

Signed-off-by: Alex Dubov <oakad@yahoo.com>
---
 MAINTAINERS              |    5 
 drivers/misc/tifm_7xx1.c |  419 ++++++++++++++++++++++
 drivers/misc/tifm_core.c |  276 ++++++++++++++
 drivers/mmc/tifm_sd.c    |  876 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/tifm.h     |  158 ++++++++
 5 files changed, 1734 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25cd707..1a366e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2821,6 +2821,11 @@ M:	nagar@watson.ibm.com
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+TI FLASH MEDIA INTERFACE DRIVER
+P:      Alex Dubov
+M:      oakad@yahoo.com
+S:      Maintained
+
 TI PARALLEL LINK CABLE DRIVER
 P:     Romain Lievin
 M:     roms@lpg.ticalc.org
diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
new file mode 100644
index 0000000..4200b4c
--- /dev/null
+++ b/drivers/misc/tifm_7xx1.c
@@ -0,0 +1,419 @@
+/*
+ *  tifm_7xx1.c - TI FlashMedia driver
+ *
+ *  Copyright (C) 2006 Alex Dubov <oakad@yahoo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/tifm.h>
+#include <linux/interrupt.h>
+
+#define DRIVER_NAME "tifm_7xx1"
+#define DRIVER_VERSION "0.6"
+
+static void tifm_7xx1_eject(struct tifm_adapter *fm, struct tifm_dev *sock)
+{
+	int cnt;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fm->lock, flags);
+	if (!fm->inhibit_new_cards) {
+		for (cnt = 0; cnt < fm->max_sockets; cnt++) {
+			if (fm->sockets[cnt] == sock) {
+				fm->remove_mask |= (1 << cnt);
+				queue_work(fm->wq, &fm->media_remover);
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&fm->lock, flags);
+}
+
+static void tifm_7xx1_remove_media(void *adapter)
+{
+	struct tifm_adapter *fm = (struct tifm_adapter*)adapter;
+	unsigned long flags;
+	int cnt;
+	struct tifm_dev *sock;
+
+	if (!class_device_get(&fm->cdev))
+		return;
+	spin_lock_irqsave(&fm->lock, flags);
+	for (cnt = 0; cnt < fm->max_sockets; cnt++) {
+		if (fm->sockets[cnt] && (fm->remove_mask & (1 << cnt))) {
+			printk(KERN_INFO DRIVER_NAME
+			       ": demand removing card from socket %d\n", cnt);
+			sock = fm->sockets[cnt];
+			fm->sockets[cnt] = 0;
+			fm->remove_mask &= ~(1 << cnt);
+
+			writel(0x0e00, sock->addr + SOCK_CONTROL);
+
+			writel((TIFM_IRQ_FIFOMASK | TIFM_IRQ_CARDMASK) << cnt,
+				fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
+			writel((TIFM_IRQ_FIFOMASK | TIFM_IRQ_CARDMASK) << cnt,
+				fm->addr + FM_SET_INTERRUPT_ENABLE);
+
+			spin_unlock_irqrestore(&fm->lock, flags);
+			device_unregister(&sock->dev);
+			spin_lock_irqsave(&fm->lock, flags);
+		}
+	}
+	spin_unlock_irqrestore(&fm->lock, flags);
+	class_device_put(&fm->cdev);
+}
+
+static irqreturn_t tifm_7xx1_isr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct tifm_adapter *fm = (struct tifm_adapter*)dev_id;
+
+	unsigned int irq_status;
+	unsigned int sock_irq_status, cnt;
+
+	spin_lock(&fm->lock);
+	irq_status = readl(fm->addr + FM_INTERRUPT_STATUS);
+	if (irq_status == 0 || irq_status == (~0)) {
+		spin_unlock(&fm->lock);
+		return IRQ_NONE;
+	}
+
+	if (irq_status & TIFM_IRQ_ENABLE) {
+		writel(TIFM_IRQ_ENABLE, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
+
+		for (cnt = 0; cnt <  fm->max_sockets; cnt++) {
+			sock_irq_status = (irq_status >> cnt)
+					  & (TIFM_IRQ_FIFOMASK | TIFM_IRQ_CARDMASK);
+
+			if (fm->sockets[cnt]) {
+				if (sock_irq_status && fm->sockets[cnt]->signal_irq)
+					sock_irq_status = fm->sockets[cnt]
+							  ->signal_irq(fm->sockets[cnt],
+								       sock_irq_status);
+
+				if (irq_status & (1 << cnt))
+					fm->remove_mask |= 1 << cnt;
+			} else {
+				if (irq_status & (1 << cnt))
+					fm->insert_mask |= 1 << cnt;
+			}
+		}
+	}
+	writel(irq_status, fm->addr + FM_INTERRUPT_STATUS);
+
+	if (!fm->inhibit_new_cards) {
+		if (!fm->remove_mask && !fm->insert_mask)
+			writel(TIFM_IRQ_ENABLE, fm->addr + FM_SET_INTERRUPT_ENABLE);
+		else {
+			queue_work(fm->wq, &fm->media_remover);
+			queue_work(fm->wq, &fm->media_inserter);
+		}
+	}
+
+	spin_unlock(&fm->lock);
+	return IRQ_HANDLED;
+}
+
+static tifm_media_id tifm_7xx1_toggle_sock_power(char *sock_addr, int is_x2)
+{
+	unsigned int s_state;
+	int cnt;
+
+	writel(0x0e00, sock_addr + SOCK_CONTROL);
+
+	for (cnt = 0; cnt < 100; cnt++) {
+		if (!(TIFM_SOCK_STATE_POWERED & readl(sock_addr + SOCK_PRESENT_STATE)))
+			break;
+		msleep(10);
+	}
+
+	s_state = readl(sock_addr + SOCK_PRESENT_STATE);
+	if (!(TIFM_SOCK_STATE_OCCUPIED & s_state))
+		return FM_NULL;
+
+	if (is_x2) {
+		writel((s_state & 7) | 0x0c00, sock_addr + SOCK_CONTROL);
+	} else {
+		// SmartMedia cards need extra 40 msec
+		if (1 == ((readl(sock_addr + SOCK_PRESENT_STATE) >> 4) & 7))
+			msleep(40);
+		writel(readl(sock_addr + SOCK_CONTROL) | TIFM_CTRL_LED,
+		       sock_addr + SOCK_CONTROL);
+		msleep(10);
+		writel((s_state & 0x7) | 0x0c00 | TIFM_CTRL_LED, sock_addr + SOCK_CONTROL);
+	}
+	
+	for (cnt = 0; cnt < 100; cnt++) {
+		if ((TIFM_SOCK_STATE_POWERED & readl(sock_addr + SOCK_PRESENT_STATE)))
+			break;
+		msleep(10);
+	}
+
+	if (!is_x2)
+		writel(readl(sock_addr + SOCK_CONTROL) & (~TIFM_CTRL_LED),
+		       sock_addr + SOCK_CONTROL);
+
+	return (readl(sock_addr + SOCK_PRESENT_STATE) >> 4) & 7;
+}
+
+inline static char* tifm_7xx1_sock_addr(char *base_addr, unsigned int sock_num)
+{
+	return base_addr + ((sock_num + 1) << 10);
+}
+ 
+static void tifm_7xx1_insert_media(void *adapter)
+{
+	struct tifm_adapter *fm = (struct tifm_adapter*)adapter;
+	unsigned long flags;
+	tifm_media_id media_id;
+	char *card_name = "xx";
+	int cnt, ok_to_register;
+	unsigned int insert_mask;
+	struct tifm_dev *new_sock = 0;
+
+	if (!class_device_get(&fm->cdev))
+		return;
+	spin_lock_irqsave(&fm->lock, flags);
+	insert_mask = fm->insert_mask;
+	fm->insert_mask = 0;
+	if (fm->inhibit_new_cards) {
+		spin_unlock_irqrestore(&fm->lock, flags);
+		class_device_put(&fm->cdev);
+		return;
+	}
+	spin_unlock_irqrestore(&fm->lock, flags);
+
+	for (cnt = 0; cnt < fm->max_sockets; cnt++) {
+		if (!(insert_mask & (1 << cnt)))
+			continue;
+		
+		media_id = tifm_7xx1_toggle_sock_power(tifm_7xx1_sock_addr(fm->addr, cnt),
+						       fm->max_sockets == 2);
+		if (media_id) {
+			ok_to_register = 0;
+			if ((new_sock = tifm_alloc_device(fm, cnt))) {
+				new_sock->addr = tifm_7xx1_sock_addr(fm->addr, cnt);
+				new_sock->media_id = media_id;
+				switch (media_id) {
+					case 1:
+						card_name = "xd";
+						break;
+					case 2:
+						card_name = "ms";
+						break;
+					case 3:
+						card_name = "sd";
+						break;
+					default:
+						break;
+				}
+				snprintf(new_sock->dev.bus_id, BUS_ID_SIZE,
+					 "tifm_%s%u:%u", card_name, fm->id, cnt);
+				printk(KERN_INFO DRIVER_NAME
+				       ": %s card detected in socket %d\n", card_name, cnt);
+				spin_lock_irqsave(&fm->lock, flags);
+				if (!fm->sockets[cnt]) {
+					fm->sockets[cnt] = new_sock;
+					ok_to_register = 1;
+				}
+				spin_unlock_irqrestore(&fm->lock, flags);
+				if (!ok_to_register || device_register(&new_sock->dev)) {
+					spin_lock_irqsave(&fm->lock, flags);
+					fm->sockets[cnt] = 0;
+					spin_unlock_irqrestore(&fm->lock, flags);
+					tifm_free_device(&new_sock->dev);
+				}
+			}
+		}
+		writel((TIFM_IRQ_FIFOMASK | TIFM_IRQ_CARDMASK) << cnt,
+		       fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
+		writel((TIFM_IRQ_FIFOMASK | TIFM_IRQ_CARDMASK) << cnt,
+		       fm->addr + FM_SET_INTERRUPT_ENABLE);
+	}
+
+	writel(TIFM_IRQ_ENABLE, fm->addr + FM_SET_INTERRUPT_ENABLE);
+	class_device_put(&fm->cdev);
+}
+
+static int tifm_7xx1_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	struct tifm_adapter *fm = pci_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fm->lock, flags);
+	fm->inhibit_new_cards = 1;
+	fm->remove_mask = 0xf;
+	fm->insert_mask = 0;
+	writel(TIFM_IRQ_ENABLE, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
+	spin_unlock_irqrestore(&fm->lock, flags);
+	flush_workqueue(fm->wq);
+
+	tifm_7xx1_remove_media(fm);
+	
+	pci_set_power_state(dev, PCI_D3hot);
+        pci_disable_device(dev);
+        pci_save_state(dev);
+	return 0;
+}
+
+static int tifm_7xx1_resume(struct pci_dev *dev)
+{
+	struct tifm_adapter *fm = pci_get_drvdata(dev);
+	unsigned long flags;
+
+	pci_restore_state(dev);
+        pci_enable_device(dev);
+        pci_set_power_state(dev, PCI_D0);
+        pci_set_master(dev);
+
+	spin_lock_irqsave(&fm->lock, flags);
+	fm->inhibit_new_cards = 0;
+	writel(TIFM_IRQ_SETALL, fm->addr + FM_INTERRUPT_STATUS);
+	writel(TIFM_IRQ_SETALL, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
+	writel(TIFM_IRQ_ENABLE | TIFM_IRQ_SETALLSOCK, fm->addr + FM_SET_INTERRUPT_ENABLE);
+	fm->insert_mask = 0xf;
+	spin_unlock_irqrestore(&fm->lock, flags);
+	return 0;
+}
+
+static int tifm_7xx1_probe(struct pci_dev *dev, const struct pci_device_id *dev_id)
+{
+	struct tifm_adapter *fm;
+	int pci_dev_busy = 0;
+	int rc;
+
+	if ((rc = pci_set_dma_mask(dev, DMA_32BIT_MASK)))
+		return rc;
+	if ((rc = pci_enable_device(dev)))
+		return rc;
+
+	pci_set_master(dev);
+
+	rc = pci_request_regions(dev, DRIVER_NAME);
+	if (rc) {
+		pci_dev_busy = 1;
+		goto err_out;
+	}
+
+	pci_intx(dev, 1);
+
+	if (!(fm = tifm_alloc_adapter())) {
+		rc = -ENOMEM;
+		goto err_out_int;
+	}
+
+	fm->dev = &dev->dev;
+	fm->max_sockets = (dev->device == 0x803B) ? 2 : 4;
+	fm->sockets = kzalloc(sizeof(struct tifm_dev*) * fm->max_sockets, GFP_KERNEL);
+	if (!fm->sockets)
+		goto err_out_free;
+
+	INIT_WORK(&fm->media_inserter, tifm_7xx1_insert_media, (void*)fm);
+	INIT_WORK(&fm->media_remover, tifm_7xx1_remove_media, (void*)fm);
+	fm->eject = tifm_7xx1_eject;
+	pci_set_drvdata(dev, fm);
+
+	fm->addr = ioremap(pci_resource_start(dev, 0), pci_resource_len(dev, 0));
+	if (!fm->addr)
+		goto err_out_free;
+
+	rc = request_irq(dev->irq, tifm_7xx1_isr, SA_SHIRQ, DRIVER_NAME, fm);
+	if (rc)
+		goto err_out_unmap;
+
+	rc = tifm_add_adapter(fm);
+	if (rc)
+		goto err_out_irq;
+
+	writel(TIFM_IRQ_SETALL, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
+	writel(TIFM_IRQ_ENABLE | TIFM_IRQ_SETALLSOCK, fm->addr + FM_SET_INTERRUPT_ENABLE);
+
+	fm->insert_mask = 0xf;
+	
+	return 0;
+
+err_out_irq:
+	free_irq(dev->irq, fm);
+err_out_unmap:
+	iounmap(fm->addr);
+err_out_free:
+	pci_set_drvdata(dev, NULL);
+	tifm_free_adapter(fm);
+err_out_int:
+	pci_intx(dev, 0);
+	pci_release_regions(dev);
+err_out:
+	if (!pci_dev_busy)
+		pci_disable_device(dev);
+	return rc;
+}
+
+static void tifm_7xx1_remove(struct pci_dev *dev)
+{
+	struct tifm_adapter *fm = pci_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fm->lock, flags);
+	fm->inhibit_new_cards = 1;
+	fm->remove_mask = 0xf;
+	fm->insert_mask = 0;
+	writel(TIFM_IRQ_ENABLE, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
+	spin_unlock_irqrestore(&fm->lock, flags);
+
+	flush_workqueue(fm->wq);
+
+	tifm_7xx1_remove_media(fm);
+
+	writel(TIFM_IRQ_SETALL, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
+	free_irq(dev->irq, fm);
+
+	tifm_remove_adapter(fm);
+	
+	pci_set_drvdata(dev, 0);
+
+	iounmap(fm->addr);
+	pci_intx(dev, 0);
+	pci_release_regions(dev);
+
+	pci_disable_device(dev);
+	tifm_free_adapter(fm);
+}
+
+static struct pci_device_id tifm_7xx1_pci_tbl [] = {
+	{ PCI_VENDOR_ID_TI, 0x8033, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  0 }, /* xx21 - the one I have */
+        { PCI_VENDOR_ID_TI, 0x803B, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  0 }, /* xx12 - should be also supported */
+	{ }
+};
+
+static struct pci_driver tifm_7xx1_driver = {
+	.name = DRIVER_NAME,
+	.id_table = tifm_7xx1_pci_tbl,
+	.probe = tifm_7xx1_probe,
+	.remove = tifm_7xx1_remove,
+	.suspend = tifm_7xx1_suspend,
+	.resume = tifm_7xx1_resume,
+};
+
+static int __init tifm_7xx1_init(void)
+{
+	return pci_register_driver(&tifm_7xx1_driver);
+}
+
+static void __exit tifm_7xx1_exit(void)
+{
+	pci_unregister_driver(&tifm_7xx1_driver);
+}
+
+MODULE_AUTHOR("Alex Dubov");
+MODULE_DESCRIPTION("TI FlashMedia host driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, tifm_7xx1_pci_tbl);
+MODULE_VERSION(DRIVER_VERSION);
+
+module_init(tifm_7xx1_init);
+module_exit(tifm_7xx1_exit);
diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
new file mode 100644
index 0000000..e478e6b
--- /dev/null
+++ b/drivers/misc/tifm_core.c
@@ -0,0 +1,276 @@
+/*
+ *  tifm_core.c - TI FlashMedia driver
+ *
+ *  Copyright (C) 2006 Alex Dubov <oakad@yahoo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/idr.h>
+
+#include <linux/tifm.h>
+
+#define DRIVER_NAME "tifm_core"
+#define DRIVER_VERSION "0.6"
+
+static DEFINE_IDR(tifm_adapter_idr);
+static DEFINE_SPINLOCK(tifm_adapter_lock);
+
+static tifm_media_id* tifm_device_match(tifm_media_id *ids, struct tifm_dev *dev)
+{
+	while (*ids) {
+		if (dev->media_id == *ids)
+			return ids;
+		ids++;
+	}
+	return 0;
+}
+
+static int tifm_match(struct device *dev, struct device_driver *drv)
+{
+	struct tifm_dev *fm_dev = container_of(dev, struct tifm_dev, dev);
+	struct tifm_driver *fm_drv = container_of(drv, struct tifm_driver, driver);
+
+	if (!fm_drv->id_table)
+		return -EINVAL;
+	if (tifm_device_match(fm_drv->id_table, fm_dev))
+		return 1;
+	return -ENODEV;
+}
+
+static int tifm_uevent(struct device *dev, char **envp, int num_envp,
+		       char *buffer, int buffer_size)
+{
+	struct tifm_dev *fm_dev;
+	int i = 0;
+	int length = 0;
+	const char *card_type_name[] = {"INV", "SM", "MS", "SD"};
+
+	if (!dev || !(fm_dev = container_of(dev, struct tifm_dev, dev)))
+		return -ENODEV;
+	if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+			   "TIFM_CARD_TYPE=%s", card_type_name[fm_dev->media_id]))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static struct bus_type tifm_bus_type = {
+	.name    = "tifm",
+	.match   = tifm_match,
+	.uevent  = tifm_uevent,
+};
+
+static void tifm_free(struct class_device *cdev)
+{
+	struct tifm_adapter *fm = container_of(cdev, struct tifm_adapter, cdev);
+
+	if (fm->sockets)
+		kfree(fm->sockets);
+	if (fm->wq)
+		destroy_workqueue(fm->wq);
+	kfree(fm);
+}
+
+static struct class tifm_adapter_class = {
+	.name    = "tifm_adapter",
+	.release = tifm_free
+};
+
+struct tifm_adapter* tifm_alloc_adapter(void)
+{
+	struct tifm_adapter *fm = kzalloc(sizeof(struct tifm_adapter), GFP_KERNEL);
+
+	if (fm) {
+		fm->cdev.class = &tifm_adapter_class; 
+		spin_lock_init(&fm->lock);
+		class_device_initialize(&fm->cdev);
+	}
+	return fm;
+}
+EXPORT_SYMBOL(tifm_alloc_adapter);
+
+void tifm_free_adapter(struct tifm_adapter *fm)
+{
+	class_device_put(&fm->cdev);
+}
+EXPORT_SYMBOL(tifm_free_adapter);
+
+int tifm_add_adapter(struct tifm_adapter *fm)
+{
+	int rc;
+
+	if (!idr_pre_get(&tifm_adapter_idr, GFP_KERNEL))
+		return -ENOMEM;
+
+	spin_lock(&tifm_adapter_lock);
+	rc = idr_get_new(&tifm_adapter_idr, fm, &fm->id);
+	spin_unlock(&tifm_adapter_lock);
+	if (!rc) {
+		snprintf(fm->cdev.class_id, BUS_ID_SIZE, "tifm%u", fm->id);
+		strncpy(fm->wq_name, fm->cdev.class_id, KOBJ_NAME_LEN);
+
+		fm->wq = create_singlethread_workqueue(fm->wq_name);
+		if (fm->wq)
+			return class_device_add(&fm->cdev);
+				
+		spin_lock(&tifm_adapter_lock);
+		idr_remove(&tifm_adapter_idr, fm->id);
+		spin_unlock(&tifm_adapter_lock);
+		rc = -ENOMEM;
+	}
+	return rc;
+}
+EXPORT_SYMBOL(tifm_add_adapter);
+
+void tifm_remove_adapter(struct tifm_adapter *fm)
+{
+	class_device_del(&fm->cdev);
+
+	spin_lock(&tifm_adapter_lock);
+	idr_remove(&tifm_adapter_idr, fm->id);
+	spin_unlock(&tifm_adapter_lock);
+}
+EXPORT_SYMBOL(tifm_remove_adapter);
+
+
+void tifm_free_device(struct device *dev)
+{
+	struct tifm_dev *fm_dev = container_of(dev, struct tifm_dev, dev);
+	if (fm_dev->wq)
+		destroy_workqueue(fm_dev->wq);
+	kfree(fm_dev);
+}
+EXPORT_SYMBOL(tifm_free_device);
+
+struct tifm_dev* tifm_alloc_device(struct tifm_adapter *fm, unsigned int id)
+{
+	struct tifm_dev *dev = kzalloc(sizeof(struct tifm_dev), GFP_KERNEL);
+	
+	if (dev) {
+		spin_lock_init(&dev->lock);
+		snprintf(dev->wq_name, KOBJ_NAME_LEN, "tifm%u:%u", fm->id, id);
+		dev->wq = create_singlethread_workqueue(dev->wq_name);
+		if (!dev->wq) {
+			kfree(dev);
+			return 0;
+		}
+		dev->dev.parent = fm->dev;
+		dev->dev.bus = &tifm_bus_type;
+		dev->dev.release = tifm_free_device;
+	}
+	return dev;
+}
+EXPORT_SYMBOL(tifm_alloc_device);
+
+void tifm_eject(struct tifm_dev *sock)
+{
+	struct tifm_adapter *fm = (struct tifm_adapter*)dev_get_drvdata(sock->dev.parent);
+	fm->eject(fm, sock);
+}
+EXPORT_SYMBOL(tifm_eject);
+
+int tifm_map_sg(struct tifm_dev *sock, struct scatterlist *sg, int nents,
+		int direction)
+{
+	return pci_map_sg(to_pci_dev(sock->dev.parent), sg, nents, direction);
+}
+EXPORT_SYMBOL(tifm_map_sg);
+
+void tifm_unmap_sg(struct tifm_dev *sock, struct scatterlist *sg, int nents,
+		   int direction)
+{
+	pci_unmap_sg(to_pci_dev(sock->dev.parent), sg, nents, direction);
+}
+EXPORT_SYMBOL(tifm_unmap_sg);
+
+static int tifm_device_probe(struct device *dev)
+{
+	struct tifm_driver *drv = container_of(dev->driver, struct tifm_driver, driver);
+	struct tifm_dev *fm_dev = container_of(dev, struct tifm_dev, dev);
+	int rc = 0;
+	const tifm_media_id *id;
+
+	get_device(dev);
+	if (!fm_dev->drv && drv->probe && drv->id_table) {
+		rc = -ENODEV;
+		id = tifm_device_match(drv->id_table, fm_dev);
+		if (id)
+			rc = drv->probe(fm_dev);
+		if (rc >= 0) {
+			rc = 0;
+			fm_dev->drv = drv;
+		}
+	}
+	if (rc)
+		put_device(dev);
+	return rc;
+}
+
+static int tifm_device_remove(struct device *dev)
+{
+	struct tifm_dev *fm_dev = container_of(dev, struct tifm_dev, dev);
+	struct tifm_driver *drv = fm_dev->drv;
+
+	if (drv) {
+		if (drv->remove) drv->remove(fm_dev);
+		fm_dev->drv = 0;
+	}
+
+	put_device(dev);
+	return 0;
+}
+
+int tifm_register_driver(struct tifm_driver *drv)
+{
+	drv->driver.bus = &tifm_bus_type;
+	drv->driver.probe = tifm_device_probe;
+	drv->driver.remove = tifm_device_remove;
+	
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL(tifm_register_driver);
+
+void tifm_unregister_driver(struct tifm_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL(tifm_unregister_driver);
+
+static int __init tifm_init(void)
+{
+	int rc = bus_register(&tifm_bus_type);
+
+	if (!rc) {
+		rc = class_register(&tifm_adapter_class);
+		if (rc)
+			bus_unregister(&tifm_bus_type);
+	}
+
+	return rc;
+}
+
+static void __exit tifm_exit(void)
+{
+	class_unregister(&tifm_adapter_class);
+	bus_unregister(&tifm_bus_type);
+}
+
+subsys_initcall(tifm_init);
+module_exit(tifm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alex Dubov");
+MODULE_DESCRIPTION("TI FlashMedia core driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRIVER_VERSION);
diff --git a/drivers/mmc/tifm_sd.c b/drivers/mmc/tifm_sd.c
new file mode 100644
index 0000000..61564cf
--- /dev/null
+++ b/drivers/mmc/tifm_sd.c
@@ -0,0 +1,876 @@
+/*
+ *  tifm_sd.c - TI FlashMedia driver
+ *
+ *  Copyright (C) 2006 Alex Dubov <oakad@yahoo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+
+#include <linux/tifm.h>
+#include <linux/mmc/protocol.h>
+#include <linux/mmc/host.h>
+#include <linux/highmem.h>
+
+#define DRIVER_NAME "tifm_sd"
+#define DRIVER_VERSION "0.6"
+
+static int no_dma = 0;
+static int fixed_timeout = 0;
+module_param(no_dma, bool, 0644);
+module_param(fixed_timeout, bool, 0644);
+
+/* Constants here are mostly from OMAP5912 datasheet */
+#define TIFM_MMCSD_RESET      0x0002
+#define TIFM_MMCSD_CLKMASK    0x03ff
+#define TIFM_MMCSD_POWER      0x0800
+#define TIFM_MMCSD_4BBUS      0x8000
+#define TIFM_MMCSD_RXDE       0x8000   /* rx dma enable */
+#define TIFM_MMCSD_TXDE       0x0080   /* tx dma enable */
+#define TIFM_MMCSD_BUFINT     0x0c00   /* set bits: AE, AF */
+#define TIFM_MMCSD_DPE        0x0020   /* data timeout counted in kilocycles */
+#define TIFM_MMCSD_INAB       0x0080   /* abort / initialize command */
+#define TIFM_MMCSD_READ       0x8000
+
+#define TIFM_MMCSD_DATAMASK   0x001d   /* set bits: EOFB, BRS, CB, EOC */
+#define TIFM_MMCSD_ERRMASK    0x41e0   /* set bits: CERR, CCRC, CTO, DCRC, DTO */
+#define TIFM_MMCSD_EOC        0x0001   /* end of command phase  */
+#define TIFM_MMCSD_CB         0x0004   /* card enter busy state */
+#define TIFM_MMCSD_BRS        0x0008   /* block received/sent   */
+#define TIFM_MMCSD_EOFB       0x0010   /* card exit busy state  */
+#define TIFM_MMCSD_DTO        0x0020   /* data time-out         */
+#define TIFM_MMCSD_DCRC       0x0040   /* data crc error        */
+#define TIFM_MMCSD_CTO        0x0080   /* command time-out      */
+#define TIFM_MMCSD_CCRC       0x0100   /* command crc error     */
+#define TIFM_MMCSD_AF         0x0400   /* fifo almost full      */
+#define TIFM_MMCSD_AE         0x0800   /* fifo almost empty     */
+#define TIFM_MMCSD_CERR       0x4000   /* card status error     */
+
+#define TIFM_MMCSD_FIFO_SIZE  0x0020
+
+#define TIFM_MMCSD_RSP_R0     0x0000
+#define TIFM_MMCSD_RSP_R1     0x0100
+#define TIFM_MMCSD_RSP_R2     0x0200
+#define TIFM_MMCSD_RSP_R3     0x0300
+#define TIFM_MMCSD_RSP_R4     0x0400
+#define TIFM_MMCSD_RSP_R5     0x0500
+#define TIFM_MMCSD_RSP_R6     0x0600
+
+#define TIFM_MMCSD_RSP_BUSY   0x0800
+
+#define TIFM_MMCSD_CMD_BC     0x0000
+#define TIFM_MMCSD_CMD_BCR    0x1000
+#define TIFM_MMCSD_CMD_AC     0x2000
+#define TIFM_MMCSD_CMD_ADTC   0x3000
+
+typedef enum {
+	IDLE = 0,
+	CMD,    /* main command ended                   */
+	BRS,    /* block transfer finished              */
+	SCMD,   /* stop command ended                   */
+	CARD,   /* card left busy state                 */
+	FIFO,   /* FIFO operation completed (uncertain) */
+	READY
+} card_state_t;
+
+enum {
+	FIFO_RDY   = 0x0001,     /* hardware dependent value */
+	HOST_REG   = 0x0002,
+	EJECT      = 0x0004,
+	EJECT_DONE = 0x0008,
+	CARD_BUSY  = 0x0010,
+	OPENDRAIN  = 0x0040,     /* hardware dependent value */
+	CARD_EVENT = 0x0100,     /* hardware dependent value */
+	CARD_RO    = 0x0200,     /* hardware dependent value */
+	FIFO_EVENT = 0x10000 };  /* hardware dependent value */
+
+struct tifm_sd {
+	struct tifm_dev     *dev;
+
+	unsigned int        flags;
+	card_state_t        state;
+	unsigned int        clk_freq;
+	unsigned int        clk_div;
+	unsigned long       timeout_jiffies; // software timeout - 2 sec
+
+	struct mmc_request    *req;
+	struct work_struct    cmd_handler;
+	struct work_struct    abort_handler;
+	wait_queue_head_t     can_eject;
+
+	size_t                written_blocks;
+	char                  *buffer;
+	size_t                buffer_size; 
+	size_t                buffer_pos;
+
+};
+
+static inline int tifm_sd_transfer_data(struct tifm_dev *sock, struct tifm_sd *host,
+					unsigned int host_status)
+{
+	struct mmc_command *cmd = host->req->cmd;
+	unsigned int t_val = 0, cnt = 0;
+
+	if (host_status & TIFM_MMCSD_BRS) {
+		/* in non-dma rx mode BRS fires when fifo is still not empty */
+		if (host->buffer && (cmd->data->flags & MMC_DATA_READ)) {
+			while (host->buffer_size > host->buffer_pos) {
+				t_val = readl(sock->addr + SOCK_MMCSD_DATA);
+				host->buffer[host->buffer_pos++] = t_val & 0xff;
+				host->buffer[host->buffer_pos++] = (t_val >> 8) & 0xff;
+			}
+		}
+		return 1;
+	} else if (host->buffer) {
+		if ((cmd->data->flags & MMC_DATA_READ) && (host_status & TIFM_MMCSD_AF)) {
+			for (cnt = 0; cnt < TIFM_MMCSD_FIFO_SIZE; cnt++) {
+				t_val = readl(sock->addr + SOCK_MMCSD_DATA);
+				if (host->buffer_size > host->buffer_pos) {
+					host->buffer[host->buffer_pos++] = t_val & 0xff;
+					host->buffer[host->buffer_pos++] = (t_val >> 8) & 0xff;
+				}
+			}
+		} else if ((cmd->data->flags & MMC_DATA_WRITE)
+			   && (host_status & TIFM_MMCSD_AE)) {
+			for(cnt = 0; cnt < TIFM_MMCSD_FIFO_SIZE; cnt++) {
+				if (host->buffer_size > host->buffer_pos) {
+					t_val = host->buffer[host->buffer_pos++] & 0x00ff;
+					t_val |= ((host->buffer[host->buffer_pos++]) << 8)
+						 & 0xff00;
+					writel(t_val, sock->addr + SOCK_MMCSD_DATA);
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+static inline unsigned int tifm_sd_op_flags(struct mmc_command *cmd)
+{
+	unsigned int rc = 0;
+
+	switch (mmc_resp_type(cmd)) {
+		case MMC_RSP_NONE:
+			rc |= TIFM_MMCSD_RSP_R0;
+			break;
+		case MMC_RSP_R1B:
+			rc |= TIFM_MMCSD_RSP_BUSY; // deliberate fall-through
+		case MMC_RSP_R1:
+			rc |= TIFM_MMCSD_RSP_R1;
+			break;
+		case MMC_RSP_R2:
+			rc |= TIFM_MMCSD_RSP_R2;
+			break;
+		case MMC_RSP_R3:
+			rc |= TIFM_MMCSD_RSP_R3;
+			break;
+		case MMC_RSP_R6:
+			rc |= TIFM_MMCSD_RSP_R6;
+			break;
+		default:
+			BUG();
+	}
+
+	switch (mmc_cmd_type(cmd)) {
+		case MMC_CMD_BC:
+			rc |= TIFM_MMCSD_CMD_BC;
+			break;
+		case MMC_CMD_BCR:
+			rc |= TIFM_MMCSD_CMD_BCR;
+			break;
+		case MMC_CMD_AC:
+			rc |= TIFM_MMCSD_CMD_AC;
+			break;
+		case MMC_CMD_ADTC:
+			rc |= TIFM_MMCSD_CMD_ADTC;
+			break;
+		default:
+			BUG();
+	}
+	return rc;
+}
+
+static void tifm_sd_exec(struct tifm_sd *host, struct mmc_command *cmd)
+{
+	struct tifm_dev *sock = host->dev;
+	unsigned int cmd_mask = tifm_sd_op_flags(cmd) | (host->flags & OPENDRAIN);
+
+	if (cmd->data && (cmd->data->flags & MMC_DATA_READ))
+		cmd_mask |= TIFM_MMCSD_READ;
+
+	dev_dbg(&sock->dev, "executing opcode 0x%x, arg: 0x%x, mask: 0x%x\n", cmd->opcode,
+		cmd->arg, cmd_mask);
+
+	writel((cmd->arg >> 16) & 0xffff, sock->addr + SOCK_MMCSD_ARG_HIGH);
+	writel(cmd->arg & 0xffff, sock->addr + SOCK_MMCSD_ARG_LOW);
+	writel(cmd->opcode | cmd_mask, sock->addr + SOCK_MMCSD_COMMAND);
+}
+
+static inline void tifm_sd_fetch_resp(struct mmc_command *cmd, struct tifm_dev *sock)
+{
+	cmd->resp[0] = (readl(sock->addr + SOCK_MMCSD_RESPONSE + 0x1c) << 16)
+		       | readl(sock->addr + SOCK_MMCSD_RESPONSE + 0x18);
+	cmd->resp[1] = (readl(sock->addr + SOCK_MMCSD_RESPONSE + 0x14) << 16)
+		       | readl(sock->addr + SOCK_MMCSD_RESPONSE + 0x10);
+	cmd->resp[2] = (readl(sock->addr + SOCK_MMCSD_RESPONSE + 0x0c) << 16)
+		       | readl(sock->addr + SOCK_MMCSD_RESPONSE + 0x08);
+	cmd->resp[3] = (readl(sock->addr + SOCK_MMCSD_RESPONSE + 0x04) << 16)
+		       | readl(sock->addr + SOCK_MMCSD_RESPONSE + 0x00);
+}
+
+static inline void tifm_sd_process_cmd(struct tifm_dev *sock, struct tifm_sd *host,
+				       unsigned int host_status)
+{
+	struct mmc_command *cmd = host->req->cmd;
+
+change_state:
+	switch (host->state) {
+		case IDLE:
+			return;
+		case CMD:
+			if (host_status & TIFM_MMCSD_EOC) {
+				tifm_sd_fetch_resp(cmd, sock);
+				if (cmd->data) {
+					host->state = BRS;
+				} else
+					host->state = READY;
+				goto change_state;
+			}
+			break;
+		case BRS:
+			if (tifm_sd_transfer_data(sock, host, host_status)) {
+				if (!host->req->stop) {
+					if (cmd->data->flags & MMC_DATA_WRITE) {
+						host->state = CARD;
+					} else {
+						host->state = host->buffer ? READY : FIFO;
+					}
+					goto change_state;
+				}
+				tifm_sd_exec(host, host->req->stop);
+				host->state = SCMD;
+			}
+			break;
+		case SCMD:
+			if (host_status & TIFM_MMCSD_EOC) {
+				tifm_sd_fetch_resp(host->req->stop, sock);
+				if (cmd->error) {
+					host->state = READY;
+				} else if (cmd->data->flags & MMC_DATA_WRITE) {
+					host->state = CARD;
+				} else {
+					host->state = host->buffer ? READY : FIFO;
+				}
+				goto change_state;
+			}
+			break;
+		case CARD:
+			if (!(host->flags & CARD_BUSY)
+			    && (host->written_blocks == cmd->data->blocks)) {
+				host->state = host->buffer ? READY : FIFO;
+				goto change_state;
+			}
+			break;
+		case FIFO:
+			if (host->flags & FIFO_RDY) {
+				host->state = READY;
+				host->flags &= ~FIFO_RDY;
+				goto change_state;
+			}
+			break;
+		case READY:
+			queue_work(sock->wq, &host->cmd_handler);
+			return;
+	}
+
+	queue_delayed_work(sock->wq, &host->abort_handler, host->timeout_jiffies);
+}
+
+/* Called from interrupt handler */
+static unsigned int tifm_sd_signal_irq(struct tifm_dev *sock, unsigned int sock_irq_status)
+{
+	struct tifm_sd *host;
+	unsigned int host_status = 0, fifo_status = 0;
+	int error_code = 0;
+
+	spin_lock(&sock->lock);
+	host = mmc_priv((struct mmc_host*)tifm_get_drvdata(sock));
+	cancel_delayed_work(&host->abort_handler);
+
+	if (sock_irq_status & FIFO_EVENT) {
+		fifo_status = readl(sock->addr + SOCK_DMA_FIFO_STATUS);
+		writel(fifo_status, sock->addr + SOCK_DMA_FIFO_STATUS);
+
+		host->flags |= fifo_status & FIFO_RDY;
+	}
+
+	if (sock_irq_status & CARD_EVENT) {
+		host_status = readl(sock->addr + SOCK_MMCSD_STATUS);
+		writel(host_status, sock->addr + SOCK_MMCSD_STATUS);
+		
+		if (!(host->flags & HOST_REG))
+			queue_work(sock->wq, &host->cmd_handler);
+		if (!host->req)
+			goto done;
+
+		if (host_status & TIFM_MMCSD_ERRMASK) {
+			if (host_status & TIFM_MMCSD_CERR)
+				error_code = MMC_ERR_FAILED;
+			else if (host_status & (TIFM_MMCSD_CTO | TIFM_MMCSD_DTO))
+				error_code = MMC_ERR_TIMEOUT;
+			else if (host_status & (TIFM_MMCSD_CCRC | TIFM_MMCSD_DCRC))
+				error_code = MMC_ERR_BADCRC;
+
+			writel(TIFM_FIFO_INT_SETALL,
+			       sock->addr + SOCK_DMA_FIFO_INT_ENABLE_CLEAR);
+			writel(TIFM_DMA_RESET, sock->addr + SOCK_DMA_CONTROL);
+
+			if (host->req->stop) {
+				if (host->state == SCMD) {
+					host->req->stop->error = error_code;
+				} else if(host->state == BRS) {
+					host->req->cmd->error = error_code;
+					tifm_sd_exec(host, host->req->stop);
+					queue_delayed_work(sock->wq, &host->abort_handler,
+							   host->timeout_jiffies);
+					host->state = SCMD;
+					goto done;
+				} else {
+					host->req->cmd->error = error_code;
+				}
+			} else {
+				host->req->cmd->error = error_code;
+			}
+			host->state = READY;
+		}
+
+		if (host_status & TIFM_MMCSD_CB)
+			host->flags |= CARD_BUSY;
+		if ((host_status & TIFM_MMCSD_EOFB) && (host->flags & CARD_BUSY)) { 
+			host->written_blocks++;
+			host->flags &= ~CARD_BUSY;
+		}
+        }
+
+	if (host->req)
+		tifm_sd_process_cmd(sock, host, host_status);
+done:
+	dev_dbg(&sock->dev, "host_status %x, fifo_status %x\n", host_status, fifo_status);
+	spin_unlock(&sock->lock);
+	return sock_irq_status;
+}
+
+static inline void tifm_sd_prepare_data(struct tifm_sd *card, struct mmc_command *cmd)
+{
+	struct tifm_dev *sock = card->dev;
+	unsigned int dest_cnt;
+	
+	/* DMA style IO */
+
+	writel(TIFM_FIFO_INT_SETALL, sock->addr + SOCK_DMA_FIFO_INT_ENABLE_CLEAR);
+	writel(cmd->data->blksz_bits - 2, sock->addr + SOCK_FIFO_PAGE_SIZE);
+	writel(TIFM_FIFO_ENABLE, sock->addr + SOCK_FIFO_CONTROL);
+	writel(TIFM_FIFO_INTMASK, sock->addr + SOCK_DMA_FIFO_INT_ENABLE_SET);
+	
+	dest_cnt = (cmd->data->blocks) << 8;
+	
+	writel(sg_dma_address(cmd->data->sg), sock->addr + SOCK_DMA_ADDRESS);
+
+	writel(cmd->data->blocks - 1, sock->addr + SOCK_MMCSD_NUM_BLOCKS);
+	writel((1 << cmd->data->blksz_bits) - 1, sock->addr + SOCK_MMCSD_BLOCK_LEN);
+	
+	if (cmd->data->flags & MMC_DATA_WRITE) {
+		writel(TIFM_MMCSD_TXDE, sock->addr + SOCK_MMCSD_BUFFER_CONFIG);
+		writel(dest_cnt | TIFM_DMA_TX | TIFM_DMA_EN, sock->addr + SOCK_DMA_CONTROL);
+	} else {
+		writel(TIFM_MMCSD_RXDE, sock->addr + SOCK_MMCSD_BUFFER_CONFIG);
+		writel(dest_cnt | TIFM_DMA_EN, sock->addr + SOCK_DMA_CONTROL);
+	}
+}
+
+static inline void tifm_sd_set_data_timeout(struct tifm_sd *host, struct mmc_data *data)
+{
+	struct tifm_dev *sock = host->dev;
+	unsigned int data_timeout = data->timeout_clks;
+
+	if (fixed_timeout)
+		return;
+
+	data_timeout += data->timeout_ns / ((1000000000 / host->clk_freq) * host->clk_div);
+	data_timeout *= 10; // call it fudge factor for now	
+	
+	if (data_timeout < 0xffff) {
+		writel((~TIFM_MMCSD_DPE) & readl(sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG),
+		       sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG);
+		writel(data_timeout, sock->addr + SOCK_MMCSD_DATA_TO);
+	} else {
+		writel(TIFM_MMCSD_DPE | readl(sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG),
+		       sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG);
+		data_timeout = (data_timeout >> 10) + 1;
+		if(data_timeout > 0xffff) data_timeout = 0; // set to unlimited
+		writel(data_timeout, sock->addr + SOCK_MMCSD_DATA_TO);
+	}
+}
+
+
+static void tifm_sd_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct tifm_sd *host = mmc_priv(mmc);
+	struct tifm_dev *sock = host->dev;
+	unsigned long flags;
+	int sg_count = 0;
+	struct mmc_data *r_data = mrq->cmd->data;
+
+	spin_lock_irqsave(&sock->lock, flags);
+	if (host->flags & EJECT) {
+		spin_unlock_irqrestore(&sock->lock, flags);
+		goto err_out;
+	}
+
+	if (host->req) {
+		printk(KERN_ERR DRIVER_NAME ": unfinished request detected\n");
+		spin_unlock_irqrestore(&sock->lock, flags);
+		goto err_out;
+	}
+
+	if (r_data) {
+		tifm_sd_set_data_timeout(host, r_data);
+
+		sg_count = tifm_map_sg(sock, r_data->sg, r_data->sg_len,
+				       mrq->cmd->flags & MMC_DATA_WRITE
+				       ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
+		if (sg_count != 1) {
+			printk(KERN_ERR DRIVER_NAME ": scatterlist map failed\n");
+			spin_unlock_irqrestore(&sock->lock, flags);
+			goto err_out;
+		}
+
+		host->written_blocks = 0;
+		host->flags &= ~CARD_BUSY;
+		tifm_sd_prepare_data(host, mrq->cmd);
+	}
+
+	host->req = mrq;
+	host->state = CMD;
+	queue_delayed_work(sock->wq, &host->abort_handler, host->timeout_jiffies);
+	writel(TIFM_CTRL_LED | readl(sock->addr + SOCK_CONTROL), sock->addr + SOCK_CONTROL);
+	tifm_sd_exec(host, mrq->cmd);
+	spin_unlock_irqrestore(&sock->lock, flags);
+	return;
+
+err_out:
+	if (sg_count > 0)
+		tifm_unmap_sg(sock, r_data->sg, r_data->sg_len,
+			      (r_data->flags & MMC_DATA_WRITE)
+			      ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
+
+	mrq->cmd->error = MMC_ERR_TIMEOUT;
+	mmc_request_done(mmc, mrq);
+}
+
+static void tifm_sd_end_cmd(void *data)
+{
+	struct tifm_sd *host = (struct tifm_sd*)data;
+	struct tifm_dev *sock = host->dev;
+	struct mmc_host *mmc = tifm_get_drvdata(sock);
+	struct mmc_request *mrq;
+	struct mmc_data *r_data = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sock->lock, flags);
+
+	mrq = host->req;
+	host->req = 0;
+	host->state = IDLE;
+
+	if (!mrq) {
+		printk(KERN_ERR DRIVER_NAME ": no request to complete?\n");
+		spin_unlock_irqrestore(&sock->lock, flags);
+		return;
+	}
+
+	if ((r_data = mrq->cmd->data)) {
+		if (r_data->flags & MMC_DATA_WRITE) {
+			r_data->bytes_xfered = host->written_blocks << r_data->blksz_bits;
+		} else {
+			r_data->bytes_xfered = r_data->blocks
+					       - readl(sock->addr + SOCK_MMCSD_NUM_BLOCKS) - 1;
+			r_data->bytes_xfered <<= r_data->blksz_bits;
+			r_data->bytes_xfered += (1 << r_data->blksz_bits)
+						- readl(sock->addr + SOCK_MMCSD_BLOCK_LEN) + 1;
+		}
+		tifm_unmap_sg(sock, r_data->sg, r_data->sg_len,
+			      (r_data->flags & MMC_DATA_WRITE)
+			      ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
+	}
+
+	writel((~TIFM_CTRL_LED) & readl(sock->addr + SOCK_CONTROL), sock->addr + SOCK_CONTROL);
+
+	spin_unlock_irqrestore(&sock->lock, flags);
+	mmc_request_done(mmc, mrq);
+}
+
+static void tifm_sd_request_nodma(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct tifm_sd *host = mmc_priv(mmc);
+	struct tifm_dev *sock = host->dev;
+	unsigned long flags;
+	struct mmc_data *r_data = mrq->cmd->data;
+	char *t_buffer = 0;
+
+	if (r_data) {
+		t_buffer = kmap(r_data->sg->page);
+		if (!t_buffer) {
+			printk(KERN_ERR DRIVER_NAME ": kmap failed\n");
+			goto err_out;
+		}
+	}
+	
+	spin_lock_irqsave(&sock->lock, flags);
+	if (host->flags & EJECT) {
+		spin_unlock_irqrestore(&sock->lock, flags);
+		goto err_out;
+	}
+
+	if (host->req) {
+		printk(KERN_ERR DRIVER_NAME ": unfinished request detected\n");
+		spin_unlock_irqrestore(&sock->lock, flags);
+		goto err_out;
+	}
+
+	if (r_data) {
+		tifm_sd_set_data_timeout(host, r_data);
+
+		host->buffer = t_buffer + r_data->sg->offset;
+		host->buffer_size = mrq->cmd->data->blocks << mrq->cmd->data->blksz_bits;
+
+		writel(TIFM_MMCSD_BUFINT | readl(sock->addr + SOCK_MMCSD_INT_ENABLE),
+		       sock->addr + SOCK_MMCSD_INT_ENABLE);
+		writel(((TIFM_MMCSD_FIFO_SIZE - 1) << 8) | (TIFM_MMCSD_FIFO_SIZE - 1),
+		       sock->addr + SOCK_MMCSD_BUFFER_CONFIG);
+
+		host->written_blocks = 0;
+		host->flags &= ~CARD_BUSY;
+		host->buffer_pos = 0;
+		writel(r_data->blocks - 1, sock->addr + SOCK_MMCSD_NUM_BLOCKS);
+		writel((1 << r_data->blksz_bits) - 1, sock->addr + SOCK_MMCSD_BLOCK_LEN); 
+	}
+
+	host->req = mrq;
+	host->state = CMD;
+	queue_delayed_work(sock->wq, &host->abort_handler, host->timeout_jiffies);
+	writel(TIFM_CTRL_LED | readl(sock->addr + SOCK_CONTROL), sock->addr + SOCK_CONTROL);
+	tifm_sd_exec(host, mrq->cmd);
+	spin_unlock_irqrestore(&sock->lock, flags);
+	return;
+
+err_out:
+	if (t_buffer)
+		kunmap(r_data->sg->page);
+
+	mrq->cmd->error = MMC_ERR_TIMEOUT;
+	mmc_request_done(mmc, mrq);
+}
+
+static void tifm_sd_end_cmd_nodma(void *data)
+{
+	struct tifm_sd *host = (struct tifm_sd*)data;
+	struct tifm_dev *sock = host->dev;
+	struct mmc_host *mmc = tifm_get_drvdata(sock);
+	struct mmc_request *mrq;
+	struct mmc_data *r_data = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sock->lock, flags);
+
+	mrq = host->req;
+	host->req = 0;
+	host->state = IDLE;
+
+	if (!mrq) {
+		printk(KERN_ERR DRIVER_NAME ": no request to complete?\n");
+		spin_unlock_irqrestore(&sock->lock, flags);
+		return;
+	}
+
+	if ((r_data = mrq->cmd->data)) {
+		writel((~TIFM_MMCSD_BUFINT) & readl(sock->addr + SOCK_MMCSD_INT_ENABLE),
+		       sock->addr + SOCK_MMCSD_INT_ENABLE);
+
+		if (r_data->flags & MMC_DATA_WRITE) {
+			r_data->bytes_xfered = host->written_blocks << r_data->blksz_bits;
+		} else {
+			r_data->bytes_xfered = r_data->blocks
+					       - readl(sock->addr + SOCK_MMCSD_NUM_BLOCKS) - 1;
+			r_data->bytes_xfered <<= r_data->blksz_bits;
+			r_data->bytes_xfered += (1 << r_data->blksz_bits)
+						- readl(sock->addr + SOCK_MMCSD_BLOCK_LEN) + 1;
+		}
+		host->buffer = 0;
+		host->buffer_pos = 0;
+		host->buffer_size = 0;
+	}
+
+	writel((~TIFM_CTRL_LED) & readl(sock->addr + SOCK_CONTROL), sock->addr + SOCK_CONTROL);
+
+	spin_unlock_irqrestore(&sock->lock, flags);
+	
+        if (r_data)
+		kunmap(r_data->sg->page);
+
+	mmc_request_done(mmc, mrq);
+}
+
+static void tifm_sd_abort(void *data)
+{
+	printk(KERN_ERR DRIVER_NAME ": card failed to respond for a long period of time");
+	tifm_eject(((struct tifm_sd*)data)->dev);
+}
+
+static void tifm_sd_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct tifm_sd *host = mmc_priv(mmc);
+	struct tifm_dev *sock = host->dev;
+	unsigned int clk_div1, clk_div2;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sock->lock, flags);
+		
+	dev_dbg(&sock->dev, "Setting bus width %d, power %d\n", ios->bus_width,
+		ios->power_mode);
+	if (ios->bus_width == MMC_BUS_WIDTH_4) {
+		writel(TIFM_MMCSD_4BBUS | readl(sock->addr + SOCK_MMCSD_CONFIG),
+		       sock->addr + SOCK_MMCSD_CONFIG);
+	} else {
+		writel((~TIFM_MMCSD_4BBUS) & readl(sock->addr + SOCK_MMCSD_CONFIG),
+		       sock->addr + SOCK_MMCSD_CONFIG);
+	}
+
+	if (ios->clock) {
+		if (!(clk_div1 = 20000000 / ios->clock))
+			clk_div1 = 1;
+		if (!(clk_div2 = 24000000 / ios->clock))
+			clk_div2 = 1;
+		if ((20000000 / clk_div1) > ios->clock)
+			clk_div1++;
+		if ((24000000 / clk_div2) > ios->clock)
+			clk_div2++;
+		if ((20000000 / clk_div1) > (24000000 / clk_div2)) {
+			host->clk_freq = 20000000;
+			host->clk_div = clk_div1;
+			writel((~TIFM_CTRL_FAST_CLK) & readl(sock->addr + SOCK_CONTROL),
+			       sock->addr + SOCK_CONTROL);
+		} else {
+			host->clk_freq = 24000000;
+			host->clk_div = clk_div2;
+			writel(TIFM_CTRL_FAST_CLK | readl(sock->addr + SOCK_CONTROL),
+			       sock->addr + SOCK_CONTROL);
+		}
+	} else {
+		host->clk_div = 0;
+	}
+	host->clk_div &= TIFM_MMCSD_CLKMASK;
+	writel(host->clk_div | ((~TIFM_MMCSD_CLKMASK) & readl(sock->addr + SOCK_MMCSD_CONFIG)),
+	       sock->addr + SOCK_MMCSD_CONFIG);
+
+	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
+		host->flags |= OPENDRAIN;
+	else
+		host->flags &= ~OPENDRAIN;
+
+	/* chip_select : maybe later */
+	//vdd
+	//power is set before probe / after remove
+	//I believe, power_off when already marked for eject is sufficient to allow removal.
+	if ((host->flags & EJECT) && ios->power_mode == MMC_POWER_OFF) {
+		host->flags |= EJECT_DONE;
+		wake_up_all(&host->can_eject);
+	}
+	
+	spin_unlock_irqrestore(&sock->lock, flags);
+}
+
+static int tifm_sd_ro(struct mmc_host *mmc)
+{
+	int rc;
+	struct tifm_sd *host = mmc_priv(mmc);
+	struct tifm_dev *sock = host->dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sock->lock, flags);
+	
+	host->flags |= (CARD_RO & readl(sock->addr + SOCK_PRESENT_STATE));
+	rc = (host->flags & CARD_RO) ? 1 : 0;
+	
+	spin_unlock_irqrestore(&sock->lock, flags);
+	return rc;
+}
+
+static struct mmc_host_ops tifm_sd_ops = {
+	.request = tifm_sd_request,
+	.set_ios = tifm_sd_ios,
+	.get_ro  = tifm_sd_ro
+};
+
+static void tifm_sd_register_host(void *data)
+{
+	struct tifm_sd *host = (struct tifm_sd*)data;
+	struct tifm_dev *sock = host->dev;
+	struct mmc_host *mmc = tifm_get_drvdata(sock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sock->lock, flags);
+	host->flags |= HOST_REG;
+	PREPARE_WORK(&host->cmd_handler, no_dma ? tifm_sd_end_cmd_nodma : tifm_sd_end_cmd,
+		     data);
+	spin_unlock_irqrestore(&sock->lock, flags);
+	dev_dbg(&sock->dev, "adding host\n");
+	mmc_add_host(mmc);
+}
+
+static int tifm_sd_probe(struct tifm_dev *sock)
+{
+	struct mmc_host *mmc;
+	struct tifm_sd *host;
+	int rc = -EIO;
+
+	if (!(TIFM_SOCK_STATE_OCCUPIED & readl(sock->addr + SOCK_PRESENT_STATE))) {
+		printk(KERN_WARNING DRIVER_NAME ": card gone, unexpectedly\n");
+		return rc;
+	}
+
+	mmc = mmc_alloc_host(sizeof(struct tifm_sd), &sock->dev);
+	if (!mmc)
+		return -ENOMEM;
+
+	host = mmc_priv(mmc);
+	host->dev = sock;
+	host->clk_div = 61;
+	init_waitqueue_head(&host->can_eject);
+	INIT_WORK(&host->cmd_handler, tifm_sd_register_host, (void*)host);
+	INIT_WORK(&host->abort_handler, tifm_sd_abort, (void*)host);
+
+	tifm_set_drvdata(sock, mmc);
+	sock->signal_irq = tifm_sd_signal_irq;
+
+	host->clk_freq = 20000000;
+	host->timeout_jiffies = msecs_to_jiffies(1000);
+
+	tifm_sd_ops.request = no_dma ? tifm_sd_request_nodma : tifm_sd_request;
+	mmc->ops = &tifm_sd_ops;
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc->caps = MMC_CAP_4_BIT_DATA;
+	mmc->f_min = 20000000 / 60;
+	mmc->f_max = 24000000;
+	mmc->max_hw_segs = 1;
+	mmc->max_phys_segs = 1;
+	mmc->max_sectors = 127;
+	mmc->max_seg_size = mmc->max_sectors << 11; //2k maximum hw block length
+
+	writel(0, sock->addr + SOCK_MMCSD_INT_ENABLE);
+	writel(TIFM_MMCSD_RESET, sock->addr + SOCK_MMCSD_SYSTEM_CONTROL);
+	writel(host->clk_div | TIFM_MMCSD_POWER, sock->addr + SOCK_MMCSD_CONFIG);
+
+	for(rc = 0; rc < 50; rc++) {
+		/* Wait for reset ack */
+		if (1 & readl(sock->addr + SOCK_MMCSD_SYSTEM_STATUS)) {
+			rc = 0;
+			break;
+		}
+		msleep(10);
+        }
+
+	if (rc) {
+		printk(KERN_ERR DRIVER_NAME ": card not ready - probe failed\n");
+		mmc_free_host(mmc);
+		return -ENODEV;
+	}
+
+	writel(0, sock->addr + SOCK_MMCSD_NUM_BLOCKS);
+	writel(host->clk_div | TIFM_MMCSD_POWER, sock->addr + SOCK_MMCSD_CONFIG);
+	writel(TIFM_MMCSD_RXDE, sock->addr + SOCK_MMCSD_BUFFER_CONFIG);
+	writel(TIFM_MMCSD_DATAMASK | TIFM_MMCSD_ERRMASK, sock->addr + SOCK_MMCSD_INT_ENABLE);
+
+	writel(64, sock->addr + SOCK_MMCSD_COMMAND_TO); // command timeout 64 clocks for now
+	writel(TIFM_MMCSD_INAB, sock->addr + SOCK_MMCSD_COMMAND);
+	writel(host->clk_div | TIFM_MMCSD_POWER, sock->addr + SOCK_MMCSD_CONFIG);
+	
+	queue_delayed_work(sock->wq, &host->abort_handler, host->timeout_jiffies);
+
+	return 0;
+}
+
+static inline int tifm_sd_host_is_down(struct tifm_dev *sock)
+{
+	struct mmc_host *mmc = tifm_get_drvdata(sock);
+	struct tifm_sd *host = mmc_priv(mmc);
+	unsigned long flags;
+	int rc = 0;
+
+	spin_lock_irqsave(&sock->lock, flags);
+	rc = (host->flags & EJECT_DONE);
+	spin_unlock_irqrestore(&sock->lock, flags);
+	return rc;
+}
+
+static void tifm_sd_remove(struct tifm_dev *sock)
+{
+	struct mmc_host *mmc = tifm_get_drvdata(sock);
+	struct tifm_sd *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sock->lock, flags);
+	host->flags |= EJECT;
+	if (host->req)
+		queue_work(sock->wq, &host->cmd_handler);
+	spin_unlock_irqrestore(&sock->lock, flags);
+	wait_event_timeout(host->can_eject, tifm_sd_host_is_down(sock), host->timeout_jiffies);
+
+	if (host->flags & HOST_REG)
+		mmc_remove_host(mmc);
+
+	/* The meaning of the bit majority in this constant is unknown. */
+	writel(0xfff8 & readl(sock->addr + SOCK_CONTROL), sock->addr + SOCK_CONTROL);
+	writel(0, sock->addr + SOCK_MMCSD_INT_ENABLE);
+	writel(TIFM_FIFO_INT_SETALL, sock->addr + SOCK_DMA_FIFO_INT_ENABLE_CLEAR);
+	writel(0, sock->addr + SOCK_DMA_FIFO_INT_ENABLE_SET);
+
+	tifm_set_drvdata(sock, 0);
+	mmc_free_host(mmc);
+}
+
+static tifm_media_id tifm_sd_id_tbl[] = {
+	FM_SD, 0
+};
+
+static struct tifm_driver tifm_sd_driver = {
+	.driver = {
+		.name  = DRIVER_NAME,
+		.owner = THIS_MODULE
+	},
+	.id_table = tifm_sd_id_tbl,
+	.probe    = tifm_sd_probe,
+	.remove   = tifm_sd_remove
+};
+
+static int __init tifm_sd_init(void)
+{
+	return tifm_register_driver(&tifm_sd_driver);
+}
+
+static void __exit tifm_sd_exit(void)
+{
+	tifm_unregister_driver(&tifm_sd_driver);
+}
+
+MODULE_AUTHOR("Alex Dubov");
+MODULE_DESCRIPTION("TI FlashMedia SD driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(tifm, tifm_sd_id_tbl);
+MODULE_VERSION(DRIVER_VERSION);
+
+module_init(tifm_sd_init);
+module_exit(tifm_sd_exit);
diff --git a/include/linux/tifm.h b/include/linux/tifm.h
new file mode 100644
index 0000000..fec70ae
--- /dev/null
+++ b/include/linux/tifm.h
@@ -0,0 +1,158 @@
+/*
+ *  tifm.h - TI FlashMedia driver
+ *
+ *  Copyright (C) 2006 Alex Dubov <oakad@yahoo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef _TIFM_H
+#define _TIFM_H
+
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+
+/* Host registers (relative to pci base address): */
+enum { 
+	FM_SET_INTERRUPT_ENABLE   = 0x008,
+	FM_CLEAR_INTERRUPT_ENABLE = 0x00c,
+	FM_INTERRUPT_STATUS       = 0x014 };
+
+/* Socket registers (relative to socket base address): */
+enum {
+	SOCK_CONTROL                   = 0x004,
+	SOCK_PRESENT_STATE             = 0x008,
+	SOCK_DMA_ADDRESS               = 0x00c,
+	SOCK_DMA_CONTROL               = 0x010,
+	SOCK_DMA_FIFO_INT_ENABLE_SET   = 0x014,
+	SOCK_DMA_FIFO_INT_ENABLE_CLEAR = 0x018,
+	SOCK_DMA_FIFO_STATUS           = 0x020,
+	SOCK_FIFO_CONTROL              = 0x024,
+	SOCK_FIFO_PAGE_SIZE            = 0x028,
+	SOCK_MMCSD_COMMAND             = 0x104,
+	SOCK_MMCSD_ARG_LOW             = 0x108,
+	SOCK_MMCSD_ARG_HIGH            = 0x10c,
+	SOCK_MMCSD_CONFIG              = 0x110,
+	SOCK_MMCSD_STATUS              = 0x114,
+	SOCK_MMCSD_INT_ENABLE          = 0x118,
+	SOCK_MMCSD_COMMAND_TO          = 0x11c,
+	SOCK_MMCSD_DATA_TO             = 0x120,
+	SOCK_MMCSD_DATA                = 0x124,
+	SOCK_MMCSD_BLOCK_LEN           = 0x128,
+	SOCK_MMCSD_NUM_BLOCKS          = 0x12c,
+	SOCK_MMCSD_BUFFER_CONFIG       = 0x130,
+	SOCK_MMCSD_SPI_CONFIG          = 0x134,
+	SOCK_MMCSD_SDIO_MODE_CONFIG    = 0x138,
+	SOCK_MMCSD_RESPONSE            = 0x144,
+	SOCK_MMCSD_SDIO_SR             = 0x164,
+	SOCK_MMCSD_SYSTEM_CONTROL      = 0x168,
+	SOCK_MMCSD_SYSTEM_STATUS       = 0x16c,
+	SOCK_MS_COMMAND                = 0x184,
+	SOCK_MS_DATA                   = 0x188,
+	SOCK_MS_STATUS                 = 0x18c,
+	SOCK_MS_SYSTEM                 = 0x190,
+	SOCK_FIFO_ACCESS               = 0x200 };
+
+
+#define TIFM_IRQ_ENABLE           0x80000000
+#define TIFM_IRQ_SOCKMASK         0x00000001
+#define TIFM_IRQ_CARDMASK         0x00000100
+#define TIFM_IRQ_FIFOMASK         0x00010000
+#define TIFM_IRQ_SETALL           0xffffffff
+#define TIFM_IRQ_SETALLSOCK       0x0000000f
+
+#define TIFM_CTRL_LED             0x00000040
+#define TIFM_CTRL_FAST_CLK        0x00000100
+
+#define TIFM_SOCK_STATE_OCCUPIED  0x00000008
+#define TIFM_SOCK_STATE_POWERED   0x00000080
+
+#define TIFM_FIFO_ENABLE          0x00000001 /* Meaning of this constant is unverified */
+#define TIFM_FIFO_INT_SETALL      0x0000ffff
+#define TIFM_FIFO_INTMASK         0x00000005 /* Meaning of this constant is unverified */
+
+#define TIFM_DMA_RESET            0x00000002 /* Meaning of this constant is unverified */
+#define TIFM_DMA_TX               0x00008000 /* Meaning of this constant is unverified */
+#define TIFM_DMA_EN               0x00000001 /* Meaning of this constant is unverified */
+
+typedef enum {FM_NULL = 0, FM_XD = 0x01, FM_MS = 0x02, FM_SD = 0x03} tifm_media_id;
+
+struct tifm_driver;
+struct tifm_dev {
+	char __iomem            *addr;
+	spinlock_t              lock;
+	tifm_media_id           media_id;
+	char                    wq_name[KOBJ_NAME_LEN];
+	struct workqueue_struct *wq;
+
+	unsigned int            (*signal_irq)(struct tifm_dev *sock,
+					      unsigned int sock_irq_status);
+
+	struct tifm_driver      *drv;
+	struct device           dev;
+};
+
+struct tifm_driver {
+	tifm_media_id        *id_table;	
+	int                  (*probe)(struct tifm_dev *dev);
+	void                 (*remove)(struct tifm_dev *dev);
+	
+	struct device_driver driver;
+};
+
+struct tifm_adapter {
+	char __iomem            *addr;
+	unsigned int            irq_status;
+	unsigned int            insert_mask;
+	unsigned int            remove_mask;
+	spinlock_t              lock;
+	unsigned int            id;
+	unsigned int            max_sockets;
+	char                    wq_name[KOBJ_NAME_LEN];
+	unsigned int            inhibit_new_cards;
+	struct workqueue_struct *wq;
+	struct work_struct      media_inserter;
+	struct work_struct      media_remover;
+	struct tifm_dev         **sockets;
+	struct class_device     cdev;
+	struct device           *dev;
+
+	void                    (*eject)(struct tifm_adapter *fm, struct tifm_dev *sock);
+};
+
+struct tifm_adapter* tifm_alloc_adapter(void);
+void tifm_free_device(struct device *dev);
+void tifm_free_adapter(struct tifm_adapter *fm);
+int tifm_add_adapter(struct tifm_adapter *fm);
+void tifm_remove_adapter(struct tifm_adapter *fm);
+struct tifm_dev* tifm_alloc_device(struct tifm_adapter *fm, unsigned int id);
+int tifm_register_driver(struct tifm_driver *drv);
+void tifm_unregister_driver(struct tifm_driver *drv);
+void tifm_eject(struct tifm_dev *sock);
+int tifm_map_sg(struct tifm_dev *sock, struct scatterlist *sg, int nents,
+		int direction);
+void tifm_unmap_sg(struct tifm_dev *sock, struct scatterlist *sg, int nents,
+		   int direction);
+
+
+static inline void* tifm_get_drvdata(struct tifm_dev *dev)
+{
+        return dev_get_drvdata(&dev->dev);
+}
+
+static inline void tifm_set_drvdata(struct tifm_dev *dev, void *data)
+{
+	dev_set_drvdata(&dev->dev, data);
+}
+
+struct tifm_device_id {
+	tifm_media_id media_id;
+};
+
+#endif
-- 
1.4.2.1



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
