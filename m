Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWBHHKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWBHHKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbWBHHKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:10:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:61083 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161047AbWBHHKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:10:41 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] sn3 iomem annotations and fixes
Cc: pfg@sgi.com
Message-Id: <E1F6jTN-0002Xx-0K@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138791546 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/sn/ioc3.c    |   18 +++++++++---------
 include/linux/ioc3.h |    2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

d656101009d76000b8fc0998a33d592100334d52
diff --git a/drivers/sn/ioc3.c b/drivers/sn/ioc3.c
index c70ae81..12357e1 100644
--- a/drivers/sn/ioc3.c
+++ b/drivers/sn/ioc3.c
@@ -38,10 +38,10 @@ static inline unsigned mcr_pack(unsigned
 
 static int nic_wait(struct ioc3_driver_data *idd)
 {
-	volatile unsigned mcr;
+	unsigned mcr;
 
         do {
-                mcr = (volatile unsigned)idd->vma->mcr;
+                mcr = readl(&idd->vma->mcr);
         } while (!(mcr & 2));
 
         return mcr & 1;
@@ -53,7 +53,7 @@ static int nic_reset(struct ioc3_driver_
 	unsigned long flags;
 
 	local_irq_save(flags);
-	idd->vma->mcr = mcr_pack(500, 65);
+	writel(mcr_pack(500, 65), &idd->vma->mcr);
 	presence = nic_wait(idd);
 	local_irq_restore(flags);
 
@@ -68,7 +68,7 @@ static inline int nic_read_bit(struct io
 	unsigned long flags;
 
 	local_irq_save(flags);
-	idd->vma->mcr = mcr_pack(6, 13);
+	writel(mcr_pack(6, 13), &idd->vma->mcr);
 	result = nic_wait(idd);
 	local_irq_restore(flags);
 
@@ -80,9 +80,9 @@ static inline int nic_read_bit(struct io
 static inline void nic_write_bit(struct ioc3_driver_data *idd, int bit)
 {
 	if (bit)
-		idd->vma->mcr = mcr_pack(6, 110);
+		writel(mcr_pack(6, 110), &idd->vma->mcr);
 	else
-		idd->vma->mcr = mcr_pack(80, 30);
+		writel(mcr_pack(80, 30), &idd->vma->mcr);
 
 	nic_wait(idd);
 }
@@ -337,7 +337,7 @@ static void probe_nic(struct ioc3_driver
         int save = 0, loops = 3;
         unsigned long first, addr;
 
-        idd->vma->gpcr_s = GPCR_MLAN_EN;
+        writel(GPCR_MLAN_EN, &idd->vma->gpcr_s);
 
         while(loops>0) {
                 idd->nic_part[0] = 0;
@@ -408,7 +408,7 @@ static irqreturn_t ioc3_intr_io(int irq,
 
 	read_lock_irqsave(&ioc3_submodules_lock, flags);
 
-	if(idd->dual_irq && idd->vma->eisr) {
+	if(idd->dual_irq && readb(&idd->vma->eisr)) {
 		/* send Ethernet IRQ to the driver */
 		if(ioc3_ethernet && idd->active[ioc3_ethernet->id] &&
 						ioc3_ethernet->intr) {
@@ -682,7 +682,7 @@ static int ioc3_probe(struct pci_dev *pd
 	idd->id = ioc3_counter++;
 	up_write(&ioc3_devices_rwsem);
 
-	idd->gpdr_shadow = idd->vma->gpdr;
+	idd->gpdr_shadow = readl(&idd->vma->gpdr);
 
 	/* Read IOC3 NIC contents */
 	probe_nic(idd);
diff --git a/include/linux/ioc3.h b/include/linux/ioc3.h
index e7906a7..da7c09e 100644
--- a/include/linux/ioc3.h
+++ b/include/linux/ioc3.h
@@ -27,7 +27,7 @@ struct ioc3_driver_data {
 	int id;				/* IOC3 sequence number */
 	/* PCI mapping */
 	unsigned long pma;		/* physical address */
-	struct __iomem ioc3 *vma;	/* pointer to registers */
+	struct ioc3 __iomem *vma;	/* pointer to registers */
 	struct pci_dev *pdev;		/* PCI device */
 	/* IRQ stuff */
 	int dual_irq;			/* set if separate IRQs are used */
-- 
0.99.9.GIT

