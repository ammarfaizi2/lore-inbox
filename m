Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbTFYSZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbTFYSZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:25:53 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:36836 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264918AbTFYSYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:24:32 -0400
Message-Id: <200306251838.h5PIcLsG021298@ginger.cmf.nrl.navy.mil>
To: linux-kernel@vger.kernel.org
cc: davem@redhat.com
Subject: [PATCH][2.4] backport of he driver cleanup from 2.5
Reply-To: chas3@users.sourceforge.net
Date: Wed, 25 Jun 2003 14:36:13 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and one tiny fix--you should be able to configure suni if
the he driver is built as a module.

[atm]: backport of he driver cleanup from 2.5

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1005  -> 1.1006 
#	    drivers/atm/he.c	1.1     -> 1.2    
#	drivers/atm/Config.in	1.6     -> 1.7    
#	    drivers/atm/he.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/25	chas@relax.cmf.nrl.navy.mil	1.1006
# backport of he from 2.5; allow suni when he is modular
# --------------------------------------------
#
diff -Nru a/drivers/atm/Config.in b/drivers/atm/Config.in
--- a/drivers/atm/Config.in	Wed Jun 25 14:35:48 2003
+++ b/drivers/atm/Config.in	Wed Jun 25 14:35:48 2003
@@ -94,7 +94,7 @@
 fi
 if [ "$CONFIG_PCI" = "y" ]; then
   tristate 'ForeRunner HE Series' CONFIG_ATM_HE
-  if [ "$CONFIG_ATM_HE" = "y" ]; then
+  if [ "$CONFIG_ATM_HE" != "n" ]; then
     bool 'Use S/UNI PHY driver' CONFIG_ATM_HE_USE_SUNI
   fi
 fi
diff -Nru a/drivers/atm/he.c b/drivers/atm/he.c
--- a/drivers/atm/he.c	Wed Jun 25 14:35:48 2003
+++ b/drivers/atm/he.c	Wed Jun 25 14:35:48 2003
@@ -51,7 +51,7 @@
 	4096 supported 'connections'
 	group 0 is used for all traffic
 	interrupt queue 0 is used for all interrupts
-	aal0 support for receive only
+	aal0 support (based on work from ulrich.u.muller@nokia.com)
 
  */
 
@@ -77,17 +77,8 @@
 #include <linux/atmdev.h>
 #include <linux/atm.h>
 #include <linux/sonet.h>
-#ifndef ATM_OC12_PCR
-#define ATM_OC12_PCR (622080000/1080*1040/8/53)
-#endif
-
-#ifdef BUS_INT_WAR
-void sn_add_polled_interrupt(int irq, int interval);
-void sn_delete_polled_interrupt(int irq);
-#endif
 
 #define USE_TASKLET
-#define USE_HE_FIND_VCC
 #undef USE_SCATTERGATHER
 #undef USE_CHECKSUM_HW			/* still confused about this */
 #define USE_RBPS
@@ -96,16 +87,30 @@
 #define USE_TPD_POOL
 /* #undef CONFIG_ATM_HE_USE_SUNI */
 
-/* 2.2 kernel support */
+/* compatibility */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,69)
+typedef void irqreturn_t;
+#define IRQ_NONE
+#define IRQ_HANDLED
+#define IRQ_RETVAL(x)
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,9)
+#define __devexit_p(func)		func
+#endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,43)
-#define dev_kfree_skb_irq(skb)		dev_kfree_skb(skb)
-#define dev_kfree_skb_any(skb)		dev_kfree_skb(skb)
-#undef USE_TASKLET
+#ifndef MODULE_LICENSE
+#define MODULE_LICENSE(x)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,18)
-#define set_current_state(x)		current->state = (x);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,3)
+#define pci_set_drvdata(pci_dev, data)	(pci_dev)->driver_data = (data)
+#define pci_get_drvdata(pci_dev)	(pci_dev)->driver_data
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,44)
+#define pci_pool_create(a, b, c, d, e)	pci_pool_create(a, b, c, d, e, SLAB_KERNEL)
 #endif
 
 #include "he.h"
@@ -114,16 +119,13 @@
 
 #include <linux/atm_he.h>
 
-#define hprintk(fmt,args...)	printk(DEV_LABEL "%d: " fmt, he_dev->number, args)
-#define hprintk1(fmt)		printk(DEV_LABEL "%d: " fmt, he_dev->number)
+#define hprintk(fmt,args...)	printk(KERN_ERR DEV_LABEL "%d: " fmt, he_dev->number , ##args)
 
 #undef DEBUG
 #ifdef DEBUG
-#define HPRINTK(fmt,args...)	hprintk(fmt,args)
-#define HPRINTK1(fmt)		hprintk1(fmt)
+#define HPRINTK(fmt,args...)	printk(KERN_DEBUG DEV_LABEL "%d: " fmt, he_dev->number , ##args)
 #else
-#define HPRINTK(fmt,args...)
-#define HPRINTK1(fmt,args...)
+#define HPRINTK(fmt,args...)	do { } while (0)
 #endif /* DEBUG */
 
 
@@ -131,10 +133,6 @@
 
 static char *version = "$Id: he.c,v 1.18 2003/05/06 22:57:15 chas Exp $";
 
-/* defines */
-#define ALIGN_ADDRESS(addr, alignment) \
-	((((unsigned long) (addr)) + (((unsigned long) (alignment)) - 1)) & ~(((unsigned long) (alignment)) - 1))
-
 /* declarations */
 
 static int he_open(struct atm_vcc *vcc, short vpi, int vci);
@@ -142,11 +140,7 @@
 static int he_send(struct atm_vcc *vcc, struct sk_buff *skb);
 static int he_sg_send(struct atm_vcc *vcc, unsigned long start, unsigned long size);
 static int he_ioctl(struct atm_dev *dev, unsigned int cmd, void *arg);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,69)
 static irqreturn_t he_irq_handler(int irq, void *dev_id, struct pt_regs *regs);
-#else
-static void he_irq_handler(int irq, void *dev_id, struct pt_regs *regs);
-#endif
 static void he_tasklet(unsigned long data);
 static int he_proc_read(struct atm_dev *dev,loff_t *pos,char *page);
 static int he_start(struct atm_dev *dev);
@@ -168,25 +162,18 @@
 
 static struct atmdev_ops he_ops =
 {
-   open:	he_open,
-   close:	he_close,	
-   ioctl:	he_ioctl,	
-   send:	he_send,
-   sg_send:	he_sg_send,	
-   phy_put:	he_phy_put,
-   phy_get:	he_phy_get,
-   proc_read:	he_proc_read,
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,1)
-   owner:	THIS_MODULE
-#endif
+	.open =		he_open,
+	.close =	he_close,	
+	.ioctl =	he_ioctl,	
+	.send =		he_send,
+	.sg_send =	he_sg_send,	
+	.phy_put =	he_phy_put,
+	.phy_get =	he_phy_get,
+	.proc_read =	he_proc_read,
+	.owner =	THIS_MODULE
 };
 
-/* see the comments in he.h about global_lock */
-
-#define HE_SPIN_LOCK(dev, flags)	spin_lock_irqsave(&(dev)->global_lock, flags)
-#define HE_SPIN_UNLOCK(dev, flags)	spin_unlock_irqrestore(&(dev)->global_lock, flags)
-
-#define he_writel(dev, val, reg)	do { writel(val, (dev)->membase + (reg)); wmb(); } while(0)
+#define he_writel(dev, val, reg)	do { writel(val, (dev)->membase + (reg)); wmb(); } while (0)
 #define he_readl(dev, reg)		readl((dev)->membase + (reg))
 
 /* section 2.12 connection memory access */
@@ -200,7 +187,7 @@
 	(void) he_readl(he_dev, CON_DAT);
 #endif
 	he_writel(he_dev, flags | CON_CTL_WRITE | CON_CTL_ADDR(addr), CON_CTL);
-	while(he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
+	while (he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
 }
 
 #define he_writel_rcm(dev, val, reg) 				\
@@ -216,7 +203,7 @@
 he_readl_internal(struct he_dev *he_dev, unsigned addr, unsigned flags)
 {
 	he_writel(he_dev, flags | CON_CTL_READ | CON_CTL_ADDR(addr), CON_CTL);
-	while(he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
+	while (he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
 	return he_readl(he_dev, CON_DAT);
 }
 
@@ -232,26 +219,26 @@
 
 /* figure 2.2 connection id */
 
-#define he_mkcid(dev, vpi, vci)		(((vpi<<(dev)->vcibits) | vci) & 0x1fff)
+#define he_mkcid(dev, vpi, vci)		(((vpi << (dev)->vcibits) | vci) & 0x1fff)
 
 /* 2.5.1 per connection transmit state registers */
 
 #define he_writel_tsr0(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 0)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 0)
 #define he_readl_tsr0(dev, cid) \
-		he_readl_tcm(dev, CONFIG_TSRA | (cid<<3) | 0)
+		he_readl_tcm(dev, CONFIG_TSRA | (cid << 3) | 0)
 
 #define he_writel_tsr1(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 1)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 1)
 
 #define he_writel_tsr2(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 2)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 2)
 
 #define he_writel_tsr3(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 3)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 3)
 
 #define he_writel_tsr4(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 4)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 4)
 
 	/* from page 2-20
 	 *
@@ -262,43 +249,43 @@
 	 */
 
 #define he_writel_tsr4_upper(dev, val, cid) \
-		he_writel_internal(dev, val, CONFIG_TSRA | (cid<<3) | 4, \
+		he_writel_internal(dev, val, CONFIG_TSRA | (cid << 3) | 4, \
 							CON_CTL_TCM \
 							| CON_BYTE_DISABLE_2 \
 							| CON_BYTE_DISABLE_1 \
 							| CON_BYTE_DISABLE_0)
 
 #define he_readl_tsr4(dev, cid) \
-		he_readl_tcm(dev, CONFIG_TSRA | (cid<<3) | 4)
+		he_readl_tcm(dev, CONFIG_TSRA | (cid << 3) | 4)
 
 #define he_writel_tsr5(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 5)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 5)
 
 #define he_writel_tsr6(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 6)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 6)
 
 #define he_writel_tsr7(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRA | (cid<<3) | 7)
+		he_writel_tcm(dev, val, CONFIG_TSRA | (cid << 3) | 7)
 
 
 #define he_writel_tsr8(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRB | (cid<<2) | 0)
+		he_writel_tcm(dev, val, CONFIG_TSRB | (cid << 2) | 0)
 
 #define he_writel_tsr9(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRB | (cid<<2) | 1)
+		he_writel_tcm(dev, val, CONFIG_TSRB | (cid << 2) | 1)
 
 #define he_writel_tsr10(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRB | (cid<<2) | 2)
+		he_writel_tcm(dev, val, CONFIG_TSRB | (cid << 2) | 2)
 
 #define he_writel_tsr11(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRB | (cid<<2) | 3)
+		he_writel_tcm(dev, val, CONFIG_TSRB | (cid << 2) | 3)
 
 
 #define he_writel_tsr12(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRC | (cid<<1) | 0)
+		he_writel_tcm(dev, val, CONFIG_TSRC | (cid << 1) | 0)
 
 #define he_writel_tsr13(dev, val, cid) \
-		he_writel_tcm(dev, val, CONFIG_TSRC | (cid<<1) | 1)
+		he_writel_tcm(dev, val, CONFIG_TSRC | (cid << 1) | 1)
 
 
 #define he_writel_tsr14(dev, val, cid) \
@@ -314,30 +301,30 @@
 /* 2.7.1 per connection receive state registers */
 
 #define he_writel_rsr0(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 0)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 0)
 #define he_readl_rsr0(dev, cid) \
-		he_readl_rcm(dev, 0x00000 | (cid<<3) | 0)
+		he_readl_rcm(dev, 0x00000 | (cid << 3) | 0)
 
 #define he_writel_rsr1(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 1)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 1)
 
 #define he_writel_rsr2(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 2)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 2)
 
 #define he_writel_rsr3(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 3)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 3)
 
 #define he_writel_rsr4(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 4)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 4)
 
 #define he_writel_rsr5(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 5)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 5)
 
 #define he_writel_rsr6(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 6)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 6)
 
 #define he_writel_rsr7(dev, val, cid) \
-		he_writel_rcm(dev, val, 0x00000 | (cid<<3) | 7)
+		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 7)
 
 static __inline__ struct atm_vcc*
 he_find_vcc(struct he_dev *he_dev, unsigned cid)
@@ -347,7 +334,7 @@
 	int vci;
 
 	vpi = cid >> he_dev->vcibits;
-	vci = cid & ((1<<he_dev->vcibits)-1);
+	vci = cid & ((1 << he_dev->vcibits) - 1);
 
 	for (vcc = he_dev->atm_dev->vccs; vcc; vcc = vcc->next)
 		if (vcc->vci == vci && vcc->vpi == vpi
@@ -359,49 +346,58 @@
 static int __devinit
 he_init_one(struct pci_dev *pci_dev, const struct pci_device_id *pci_ent)
 {
-	struct atm_dev *atm_dev;
-	struct he_dev *he_dev;
+	struct atm_dev *atm_dev = NULL;
+	struct he_dev *he_dev = NULL;
+	int err = 0;
 
 	printk(KERN_INFO "he: %s\n", version);
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,43)
-	if (pci_enable_device(pci_dev)) return -EIO;
-#endif
-	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0)
-	{
-		printk(KERN_WARNING "he: no suitable dma available\n");
+	if (pci_enable_device(pci_dev))
 		return -EIO;
+	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0) {
+		printk(KERN_WARNING "he: no suitable dma available\n");
+		err = -EIO;
+		goto init_one_failure;
 	}
 
 	atm_dev = atm_dev_register(DEV_LABEL, &he_ops, -1, 0);
-	if (!atm_dev) return -ENODEV;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)
+	if (!atm_dev) {
+		err = -ENODEV;
+		goto init_one_failure;
+	}
 	pci_set_drvdata(pci_dev, atm_dev);
-#else
-	pci_dev->driver_data = atm_dev;
-#endif
 
 	he_dev = (struct he_dev *) kmalloc(sizeof(struct he_dev),
 							GFP_KERNEL);
-	if (!he_dev) return -ENOMEM;
+	if (!he_dev) {
+		err = -ENOMEM;
+		goto init_one_failure;
+	}
 	memset(he_dev, 0, sizeof(struct he_dev));
 
 	he_dev->pci_dev = pci_dev;
 	he_dev->atm_dev = atm_dev;
 	he_dev->atm_dev->dev_data = he_dev;
 	HE_DEV(atm_dev) = he_dev;
-	he_dev->number = atm_dev->number;	/* was devs */
+	he_dev->number = atm_dev->number;
 	if (he_start(atm_dev)) {
-		atm_dev_deregister(atm_dev);
 		he_stop(he_dev);
-		kfree(he_dev);
-		return -ENODEV;
+		err = -ENODEV;
+		goto init_one_failure;
 	}
 	he_dev->next = NULL;
-	if (he_devs) he_dev->next = he_devs;
+	if (he_devs)
+		he_dev->next = he_devs;
 	he_devs = he_dev;
-
 	return 0;
+
+init_one_failure:
+	if (atm_dev)
+		atm_dev_deregister(atm_dev);
+	if (he_dev)
+		kfree(he_dev);
+	pci_disable_device(pci_dev);
+	return err;
 }
 
 static void __devexit
@@ -410,11 +406,7 @@
 	struct atm_dev *atm_dev;
 	struct he_dev *he_dev;
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)
 	atm_dev = pci_get_drvdata(pci_dev);
-#else
-	atm_dev = pci_dev->driver_data;
-#endif
 	he_dev = HE_DEV(atm_dev);
 
 	/* need to remove from he_devs */
@@ -423,129 +415,120 @@
 	atm_dev_deregister(atm_dev);
 	kfree(he_dev);
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)
 	pci_set_drvdata(pci_dev, NULL);
-#else
-	pci_dev->driver_data = NULL;
-#endif
+	pci_disable_device(pci_dev);
 }
 
 
 static unsigned
 rate_to_atmf(unsigned rate)		/* cps to atm forum format */
 {
-#define NONZERO (1<<14)
+#define NONZERO (1 << 14)
 
-        unsigned exp = 0;
+	unsigned exp = 0;
 
-        if (rate == 0) return(0);
+	if (rate == 0)
+		return 0;
 
-        rate <<= 9;
-        while (rate > 0x3ff)
-        {
-                ++exp;
-                rate >>= 1;
-        }
+	rate <<= 9;
+	while (rate > 0x3ff) {
+		++exp;
+		rate >>= 1;
+	}
 
-        return (NONZERO | (exp << 9) | (rate & 0x1ff));
+	return (NONZERO | (exp << 9) | (rate & 0x1ff));
 }
 
 static void __init
 he_init_rx_lbfp0(struct he_dev *he_dev)
 {
-        unsigned i, lbm_offset, lbufd_index, lbuf_addr, lbuf_count;
-        unsigned lbufs_per_row = he_dev->cells_per_row / he_dev->cells_per_lbuf;
-        unsigned lbuf_bufsize = he_dev->cells_per_lbuf * ATM_CELL_PAYLOAD;
-        unsigned row_offset = he_dev->r0_startrow * he_dev->bytes_per_row;
-        
+	unsigned i, lbm_offset, lbufd_index, lbuf_addr, lbuf_count;
+	unsigned lbufs_per_row = he_dev->cells_per_row / he_dev->cells_per_lbuf;
+	unsigned lbuf_bufsize = he_dev->cells_per_lbuf * ATM_CELL_PAYLOAD;
+	unsigned row_offset = he_dev->r0_startrow * he_dev->bytes_per_row;
+	
 	lbufd_index = 0;
-        lbm_offset = he_readl(he_dev, RCMLBM_BA);
+	lbm_offset = he_readl(he_dev, RCMLBM_BA);
 
 	he_writel(he_dev, lbufd_index, RLBF0_H);
 
-        for (i = 0, lbuf_count = 0; i < he_dev->r0_numbuffs; ++i)
-        {
+	for (i = 0, lbuf_count = 0; i < he_dev->r0_numbuffs; ++i) {
 		lbufd_index += 2;
-                lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
+		lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
 
 		he_writel_rcm(he_dev, lbuf_addr, lbm_offset);
 		he_writel_rcm(he_dev, lbufd_index, lbm_offset + 1);
 
-                if (++lbuf_count == lbufs_per_row)
-                {
-                        lbuf_count = 0;
-                        row_offset += he_dev->bytes_per_row;
-                }
+		if (++lbuf_count == lbufs_per_row) {
+			lbuf_count = 0;
+			row_offset += he_dev->bytes_per_row;
+		}
 		lbm_offset += 4;
-        }
-                
-        he_writel(he_dev, lbufd_index - 2, RLBF0_T);
+	}
+		
+	he_writel(he_dev, lbufd_index - 2, RLBF0_T);
 	he_writel(he_dev, he_dev->r0_numbuffs, RLBF0_C);
 }
 
 static void __init
 he_init_rx_lbfp1(struct he_dev *he_dev)
 {
-        unsigned i, lbm_offset, lbufd_index, lbuf_addr, lbuf_count;
-        unsigned lbufs_per_row = he_dev->cells_per_row / he_dev->cells_per_lbuf;
-        unsigned lbuf_bufsize = he_dev->cells_per_lbuf * ATM_CELL_PAYLOAD;
-        unsigned row_offset = he_dev->r1_startrow * he_dev->bytes_per_row;
-        
+	unsigned i, lbm_offset, lbufd_index, lbuf_addr, lbuf_count;
+	unsigned lbufs_per_row = he_dev->cells_per_row / he_dev->cells_per_lbuf;
+	unsigned lbuf_bufsize = he_dev->cells_per_lbuf * ATM_CELL_PAYLOAD;
+	unsigned row_offset = he_dev->r1_startrow * he_dev->bytes_per_row;
+	
 	lbufd_index = 1;
-        lbm_offset = he_readl(he_dev, RCMLBM_BA) + (2 * lbufd_index);
+	lbm_offset = he_readl(he_dev, RCMLBM_BA) + (2 * lbufd_index);
 
 	he_writel(he_dev, lbufd_index, RLBF1_H);
 
-        for (i = 0, lbuf_count = 0; i < he_dev->r1_numbuffs; ++i)
-        {
+	for (i = 0, lbuf_count = 0; i < he_dev->r1_numbuffs; ++i) {
 		lbufd_index += 2;
-                lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
+		lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
 
 		he_writel_rcm(he_dev, lbuf_addr, lbm_offset);
 		he_writel_rcm(he_dev, lbufd_index, lbm_offset + 1);
 
-                if (++lbuf_count == lbufs_per_row)
-                {
-                        lbuf_count = 0;
-                        row_offset += he_dev->bytes_per_row;
-                }
+		if (++lbuf_count == lbufs_per_row) {
+			lbuf_count = 0;
+			row_offset += he_dev->bytes_per_row;
+		}
 		lbm_offset += 4;
-        }
-                
-        he_writel(he_dev, lbufd_index - 2, RLBF1_T);
+	}
+		
+	he_writel(he_dev, lbufd_index - 2, RLBF1_T);
 	he_writel(he_dev, he_dev->r1_numbuffs, RLBF1_C);
 }
 
 static void __init
 he_init_tx_lbfp(struct he_dev *he_dev)
 {
-        unsigned i, lbm_offset, lbufd_index, lbuf_addr, lbuf_count;
-        unsigned lbufs_per_row = he_dev->cells_per_row / he_dev->cells_per_lbuf;
-        unsigned lbuf_bufsize = he_dev->cells_per_lbuf * ATM_CELL_PAYLOAD;
-        unsigned row_offset = he_dev->tx_startrow * he_dev->bytes_per_row;
-        
+	unsigned i, lbm_offset, lbufd_index, lbuf_addr, lbuf_count;
+	unsigned lbufs_per_row = he_dev->cells_per_row / he_dev->cells_per_lbuf;
+	unsigned lbuf_bufsize = he_dev->cells_per_lbuf * ATM_CELL_PAYLOAD;
+	unsigned row_offset = he_dev->tx_startrow * he_dev->bytes_per_row;
+	
 	lbufd_index = he_dev->r0_numbuffs + he_dev->r1_numbuffs;
-        lbm_offset = he_readl(he_dev, RCMLBM_BA) + (2 * lbufd_index);
+	lbm_offset = he_readl(he_dev, RCMLBM_BA) + (2 * lbufd_index);
 
 	he_writel(he_dev, lbufd_index, TLBF_H);
 
-        for (i = 0, lbuf_count = 0; i < he_dev->tx_numbuffs; ++i)
-        {
+	for (i = 0, lbuf_count = 0; i < he_dev->tx_numbuffs; ++i) {
 		lbufd_index += 1;
-                lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
+		lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
 
 		he_writel_rcm(he_dev, lbuf_addr, lbm_offset);
 		he_writel_rcm(he_dev, lbufd_index, lbm_offset + 1);
 
-                if (++lbuf_count == lbufs_per_row)
-                {
-                        lbuf_count = 0;
-                        row_offset += he_dev->bytes_per_row;
-                }
+		if (++lbuf_count == lbufs_per_row) {
+			lbuf_count = 0;
+			row_offset += he_dev->bytes_per_row;
+		}
 		lbm_offset += 2;
-        }
-                
-        he_writel(he_dev, lbufd_index - 1, TLBF_T);
+	}
+		
+	he_writel(he_dev, lbufd_index - 1, TLBF_T);
 }
 
 static int __init
@@ -553,9 +536,8 @@
 {
 	he_dev->tpdrq_base = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_TPDRQ_SIZE * sizeof(struct he_tpdrq), &he_dev->tpdrq_phys);
-	if (he_dev->tpdrq_base == NULL) 
-	{
-		hprintk1("failed to alloc tpdrq\n");
+	if (he_dev->tpdrq_base == NULL) {
+		hprintk("failed to alloc tpdrq\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->tpdrq_base, 0,
@@ -579,7 +561,7 @@
 
 	/* 5.1.7 cs block initialization */
 
-	for(reg = 0; reg < 0x20; ++reg)
+	for (reg = 0; reg < 0x20; ++reg)
 		he_writel_mbox(he_dev, 0x0, CS_STTIM0 + reg);
 
 	/* rate grid timer reload values */
@@ -588,8 +570,7 @@
 	rate = he_dev->atm_dev->link_rate;
 	delta = rate / 16 / 2;
 
-	for(reg = 0; reg < 0x10; ++reg)
-	{
+	for (reg = 0; reg < 0x10; ++reg) {
 		/* 2.4 internal transmit function
 		 *
 	 	 * we initialize the first row in the rate grid.
@@ -601,8 +582,7 @@
 		rate -= delta;
 	}
 
-	if (he_is622(he_dev))
-	{
+	if (he_is622(he_dev)) {
 		/* table 5.2 (4 cells per lbuf) */
 		he_writel_mbox(he_dev, 0x000800fa, CS_ERTHR0);
 		he_writel_mbox(he_dev, 0x000c33cb, CS_ERTHR1);
@@ -631,9 +611,7 @@
 		/* table 5.9 */
 		he_writel_mbox(he_dev, 0x5, CS_OTPPER);
 		he_writel_mbox(he_dev, 0x14, CS_OTWPER);
-	}
-	else
-	{
+	} else {
 		/* table 5.1 (4 cells per lbuf) */
 		he_writel_mbox(he_dev, 0x000400ea, CS_ERTHR0);
 		he_writel_mbox(he_dev, 0x00063388, CS_ERTHR1);
@@ -662,26 +640,29 @@
 		/* table 5.9 */
 		he_writel_mbox(he_dev, 0x6, CS_OTPPER);
 		he_writel_mbox(he_dev, 0x1e, CS_OTWPER);
-
 	}
 
 	he_writel_mbox(he_dev, 0x8, CS_OTTLIM);
 
-	for(reg = 0; reg < 0x8; ++reg)
+	for (reg = 0; reg < 0x8; ++reg)
 		he_writel_mbox(he_dev, 0x0, CS_HGRRT0 + reg);
 
 }
 
-static void __init
+static int __init
 he_init_cs_block_rcm(struct he_dev *he_dev)
 {
-	unsigned rategrid[16][16];
+	unsigned (*rategrid)[16][16];
 	unsigned rate, delta;
 	int i, j, reg;
 
 	unsigned rate_atmf, exp, man;
 	unsigned long long rate_cps;
-        int mult, buf, buf_limit = 4;
+	int mult, buf, buf_limit = 4;
+
+	rategrid = kmalloc( sizeof(unsigned) * 16 * 16, GFP_KERNEL);
+	if (!rategrid)
+		return -ENOMEM;
 
 	/* initialize rate grid group table */
 
@@ -711,18 +692,17 @@
 	 * in order to construct the rate to group table below
 	 */
 
-	for (j = 0; j < 16; j++)
-	{
-		rategrid[0][j] = rate;
+	for (j = 0; j < 16; j++) {
+		(*rategrid)[0][j] = rate;
 		rate -= delta;
 	}
 
 	for (i = 1; i < 16; i++)
 		for (j = 0; j < 16; j++)
 			if (i > 14)
-				rategrid[i][j] = rategrid[i - 1][j] / 4;
+				(*rategrid)[i][j] = (*rategrid)[i - 1][j] / 4;
 			else
-				rategrid[i][j] = rategrid[i - 1][j] / 2;
+				(*rategrid)[i][j] = (*rategrid)[i - 1][j] / 2;
 
 	/*
 	 * 2.4 transmit internal function
@@ -733,8 +713,7 @@
 	 */
 
 	rate_atmf = 0;
-	while (rate_atmf < 0x400)
-	{
+	while (rate_atmf < 0x400) {
 		man = (rate_atmf & 0x1f) << 4;
 		exp = rate_atmf >> 5;
 
@@ -744,12 +723,12 @@
 		*/
 		rate_cps = (unsigned long long) (1 << exp) * (man + 512) >> 9;
 
-		if (rate_cps < 10) rate_cps = 10;
-				/* 2.2.1 minimum payload rate is 10 cps */
+		if (rate_cps < 10)
+			rate_cps = 10;	/* 2.2.1 minimum payload rate is 10 cps */
 
 		for (i = 255; i > 0; i--)
-			if (rategrid[i/16][i%16] >= rate_cps) break;
-				/* pick nearest rate instead? */
+			if ((*rategrid)[i/16][i%16] >= rate_cps)
+				break;	 /* pick nearest rate instead? */
 
 		/*
 		 * each table entry is 16 bits: (rate grid index (8 bits)
@@ -758,28 +737,37 @@
 		 */
 
 #ifdef notdef
-                buf = rate_cps * he_dev->tx_numbuffs /
+		buf = rate_cps * he_dev->tx_numbuffs /
 				(he_dev->atm_dev->link_rate * 2);
 #else
 		/* this is pretty, but avoids _divdu3 and is mostly correct */
-                buf = 0;
-                mult = he_dev->atm_dev->link_rate / ATM_OC3_PCR;
-                if (rate_cps > (68 * mult)) buf = 1;
-                if (rate_cps > (136 * mult)) buf = 2;
-                if (rate_cps > (204 * mult)) buf = 3;
-                if (rate_cps > (272 * mult)) buf = 4;
+		mult = he_dev->atm_dev->link_rate / ATM_OC3_PCR;
+		if (rate_cps > (272 * mult))
+			buf = 4;
+		else if (rate_cps > (204 * mult))
+			buf = 3;
+		else if (rate_cps > (136 * mult))
+			buf = 2;
+		else if (rate_cps > (68 * mult))
+			buf = 1;
+		else
+			buf = 0;
 #endif
-                if (buf > buf_limit) buf = buf_limit;
-		reg = (reg<<16) | ((i<<8) | buf);
+		if (buf > buf_limit)
+			buf = buf_limit;
+		reg = (reg << 16) | ((i << 8) | buf);
 
 #define RTGTBL_OFFSET 0x400
 	  
 		if (rate_atmf & 0x1)
 			he_writel_rcm(he_dev, reg,
-				CONFIG_RCMABR + RTGTBL_OFFSET + (rate_atmf>>1));
+				CONFIG_RCMABR + RTGTBL_OFFSET + (rate_atmf >> 1));
 
 		++rate_atmf;
 	}
+
+	kfree(rategrid);
+	return 0;
 }
 
 static int __init
@@ -790,39 +778,31 @@
 #ifdef USE_RBPS
 	/* small buffer pool */
 #ifdef USE_RBPS_POOL
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,44)
-	he_dev->rbps_pool = pci_pool_create("rbps", he_dev->pci_dev,
-			CONFIG_RBPS_BUFSIZE, 8, 0, SLAB_KERNEL);
-#else
 	he_dev->rbps_pool = pci_pool_create("rbps", he_dev->pci_dev,
 			CONFIG_RBPS_BUFSIZE, 8, 0);
-#endif
-	if (he_dev->rbps_pool == NULL)
-	{
-		hprintk1("unable to create rbps pages\n");
+	if (he_dev->rbps_pool == NULL) {
+		hprintk("unable to create rbps pages\n");
 		return -ENOMEM;
 	}
 #else /* !USE_RBPS_POOL */
 	he_dev->rbps_pages = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_RBPS_SIZE * CONFIG_RBPS_BUFSIZE, &he_dev->rbps_pages_phys);
 	if (he_dev->rbps_pages == NULL) {
-		hprintk1("unable to create rbps page pool\n");
+		hprintk("unable to create rbps page pool\n");
 		return -ENOMEM;
 	}
 #endif /* USE_RBPS_POOL */
 
 	he_dev->rbps_base = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_RBPS_SIZE * sizeof(struct he_rbp), &he_dev->rbps_phys);
-	if (he_dev->rbps_base == NULL)
-	{
-		hprintk1("failed to alloc rbps\n");
+	if (he_dev->rbps_base == NULL) {
+		hprintk("failed to alloc rbps\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->rbps_base, 0, CONFIG_RBPS_SIZE * sizeof(struct he_rbp));
 	he_dev->rbps_virt = kmalloc(CONFIG_RBPS_SIZE * sizeof(struct he_virt), GFP_KERNEL);
 
-	for (i = 0; i < CONFIG_RBPS_SIZE; ++i)
-	{
+	for (i = 0; i < CONFIG_RBPS_SIZE; ++i) {
 		dma_addr_t dma_handle;
 		void *cpuaddr;
 
@@ -840,7 +820,7 @@
 		he_dev->rbps_base[i].phys = dma_handle;
 
 	}
-	he_dev->rbps_tail = &he_dev->rbps_base[CONFIG_RBPS_SIZE-1];
+	he_dev->rbps_tail = &he_dev->rbps_base[CONFIG_RBPS_SIZE - 1];
 
 	he_writel(he_dev, he_dev->rbps_phys, G0_RBPS_S + (group * 32));
 	he_writel(he_dev, RBPS_MASK(he_dev->rbps_tail),
@@ -849,7 +829,7 @@
 						G0_RBPS_BS + (group * 32));
 	he_writel(he_dev,
 			RBP_THRESH(CONFIG_RBPS_THRESH) |
-			RBP_QSIZE(CONFIG_RBPS_SIZE-1) |
+			RBP_QSIZE(CONFIG_RBPS_SIZE - 1) |
 			RBP_INT_ENB,
 						G0_RBPS_QI + (group * 32));
 #else /* !USE_RBPS */
@@ -862,40 +842,31 @@
 
 	/* large buffer pool */
 #ifdef USE_RBPL_POOL
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,44)
-	he_dev->rbpl_pool = pci_pool_create("rbpl", he_dev->pci_dev,
-			CONFIG_RBPL_BUFSIZE, 8, 0, SLAB_KERNEL);
-#else
 	he_dev->rbpl_pool = pci_pool_create("rbpl", he_dev->pci_dev,
 			CONFIG_RBPL_BUFSIZE, 8, 0);
-#endif
-	if (he_dev->rbpl_pool == NULL)
-	{
-		hprintk1("unable to create rbpl pool\n");
+	if (he_dev->rbpl_pool == NULL) {
+		hprintk("unable to create rbpl pool\n");
 		return -ENOMEM;
 	}
 #else /* !USE_RBPL_POOL */
 	he_dev->rbpl_pages = (void *) pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_RBPL_SIZE * CONFIG_RBPL_BUFSIZE, &he_dev->rbpl_pages_phys);
-	if (he_dev->rbpl_pages == NULL)
-	{
-		hprintk1("unable to create rbpl pages\n");
+	if (he_dev->rbpl_pages == NULL) {
+		hprintk("unable to create rbpl pages\n");
 		return -ENOMEM;
 	}
 #endif /* USE_RBPL_POOL */
 
 	he_dev->rbpl_base = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_RBPL_SIZE * sizeof(struct he_rbp), &he_dev->rbpl_phys);
-	if (he_dev->rbpl_base == NULL)
-	{
-		hprintk1("failed to alloc rbpl\n");
+	if (he_dev->rbpl_base == NULL) {
+		hprintk("failed to alloc rbpl\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->rbpl_base, 0, CONFIG_RBPL_SIZE * sizeof(struct he_rbp));
 	he_dev->rbpl_virt = kmalloc(CONFIG_RBPL_SIZE * sizeof(struct he_virt), GFP_KERNEL);
 
-	for (i = 0; i < CONFIG_RBPL_SIZE; ++i)
-	{
+	for (i = 0; i < CONFIG_RBPL_SIZE; ++i) {
 		dma_addr_t dma_handle;
 		void *cpuaddr;
 
@@ -911,9 +882,8 @@
 		he_dev->rbpl_virt[i].virt = cpuaddr;
 		he_dev->rbpl_base[i].status = RBP_LOANED | (i << RBP_INDEX_OFF);
 		he_dev->rbpl_base[i].phys = dma_handle;
-
 	}
-	he_dev->rbpl_tail = &he_dev->rbpl_base[CONFIG_RBPL_SIZE-1];
+	he_dev->rbpl_tail = &he_dev->rbpl_base[CONFIG_RBPL_SIZE - 1];
 
 	he_writel(he_dev, he_dev->rbpl_phys, G0_RBPL_S + (group * 32));
 	he_writel(he_dev, RBPL_MASK(he_dev->rbpl_tail),
@@ -922,7 +892,7 @@
 						G0_RBPL_BS + (group * 32));
 	he_writel(he_dev,
 			RBP_THRESH(CONFIG_RBPL_THRESH) |
-			RBP_QSIZE(CONFIG_RBPL_SIZE-1) |
+			RBP_QSIZE(CONFIG_RBPL_SIZE - 1) |
 			RBP_INT_ENB,
 						G0_RBPL_QI + (group * 32));
 
@@ -930,9 +900,8 @@
 
 	he_dev->rbrq_base = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_RBRQ_SIZE * sizeof(struct he_rbrq), &he_dev->rbrq_phys);
-	if (he_dev->rbrq_base == NULL)
-	{
-		hprintk1("failed to allocate rbrq\n");
+	if (he_dev->rbrq_base == NULL) {
+		hprintk("failed to allocate rbrq\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->rbrq_base, 0, CONFIG_RBRQ_SIZE * sizeof(struct he_rbrq));
@@ -941,15 +910,13 @@
 	he_writel(he_dev, he_dev->rbrq_phys, G0_RBRQ_ST + (group * 16));
 	he_writel(he_dev, 0, G0_RBRQ_H + (group * 16));
 	he_writel(he_dev,
-		RBRQ_THRESH(CONFIG_RBRQ_THRESH) | RBRQ_SIZE(CONFIG_RBRQ_SIZE-1),
+		RBRQ_THRESH(CONFIG_RBRQ_THRESH) | RBRQ_SIZE(CONFIG_RBRQ_SIZE - 1),
 						G0_RBRQ_Q + (group * 16));
-	if (irq_coalesce)
-	{
-		hprintk1("coalescing interrupts\n");
+	if (irq_coalesce) {
+		hprintk("coalescing interrupts\n");
 		he_writel(he_dev, RBRQ_TIME(768) | RBRQ_COUNT(7),
 						G0_RBRQ_I + (group * 16));
-	}
-	else
+	} else
 		he_writel(he_dev, RBRQ_TIME(0) | RBRQ_COUNT(1),
 						G0_RBRQ_I + (group * 16));
 
@@ -957,9 +924,8 @@
 
 	he_dev->tbrq_base = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq), &he_dev->tbrq_phys);
-	if (he_dev->tbrq_base == NULL)
-	{
-		hprintk1("failed to allocate tbrq\n");
+	if (he_dev->tbrq_base == NULL) {
+		hprintk("failed to allocate tbrq\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->tbrq_base, 0, CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq));
@@ -982,11 +948,10 @@
 	/* 2.9.3.5  tail offset for each interrupt queue is located after the
 		    end of the interrupt queue */
 
-        he_dev->irq_base = pci_alloc_consistent(he_dev->pci_dev,
+	he_dev->irq_base = pci_alloc_consistent(he_dev->pci_dev,
 			(CONFIG_IRQ_SIZE+1) * sizeof(struct he_irq), &he_dev->irq_phys);
-	if (he_dev->irq_base == NULL)
-	{
-		hprintk1("failed to allocate irq\n");
+	if (he_dev->irq_base == NULL) {
+		hprintk("failed to allocate irq\n");
 		return -ENOMEM;
 	}
 	he_dev->irq_tailoffset = (unsigned *)
@@ -995,7 +960,7 @@
 	he_dev->irq_head = he_dev->irq_base;
 	he_dev->irq_tail = he_dev->irq_base;
 
-	for(i=0; i < CONFIG_IRQ_SIZE; ++i)
+	for (i = 0; i < CONFIG_IRQ_SIZE; ++i)
 		he_dev->irq_base[i].isw = ITYPE_INVALID;
 
 	he_writel(he_dev, he_dev->irq_phys, IRQ0_BASE);
@@ -1027,27 +992,21 @@
 	he_writel(he_dev, 0x0, GRP_54_MAP);
 	he_writel(he_dev, 0x0, GRP_76_MAP);
 
-	if (request_irq(he_dev->pci_dev->irq, he_irq_handler, SA_INTERRUPT|SA_SHIRQ, DEV_LABEL, he_dev))
-	{
+	if (request_irq(he_dev->pci_dev->irq, he_irq_handler, SA_INTERRUPT|SA_SHIRQ, DEV_LABEL, he_dev)) {
 		hprintk("irq %d already in use\n", he_dev->pci_dev->irq);
 		return -EINVAL;
-        }   
+	}   
 
 	he_dev->irq = he_dev->pci_dev->irq;
 
-#ifdef BUS_INT_WAR
-        HPRINTK("sn_add_polled_interrupt(irq %d, 1)\n", he_dev->irq);
-        sn_add_polled_interrupt(he_dev->irq, 1);
-#endif
-
 	return 0;
 }
 
 static int __init
 he_start(struct atm_dev *dev)
 {
-        struct he_dev *he_dev;
-        struct pci_dev *pci_dev;
+	struct he_dev *he_dev;
+	struct pci_dev *pci_dev;
 
 	u16 command;
 	u32 gen_cntl_0, host_cntl, lb_swap;
@@ -1057,14 +1016,10 @@
 	unsigned int status, reg;
 	int i, group;
 
-        he_dev = HE_DEV(dev);
-        pci_dev = he_dev->pci_dev;
+	he_dev = HE_DEV(dev);
+	pci_dev = he_dev->pci_dev;
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,3)
 	he_dev->membase = pci_dev->resource[0].start;
-#else
-	he_dev->membase = pci_dev->base_address[0] & PCI_BASE_ADDRESS_MEM_MASK;
-#endif
 	HPRINTK("membase = 0x%lx  irq = %d.\n", he_dev->membase, pci_dev->irq);
 
 	/*
@@ -1072,47 +1027,40 @@
 	 */
 
 	/* 4.3 pci bus controller-specific initialization */
-	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0)
-	{
-		hprintk1("can't read GEN_CNTL_0\n");
+	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0) {
+		hprintk("can't read GEN_CNTL_0\n");
 		return -EINVAL;
 	}
 	gen_cntl_0 |= (MRL_ENB | MRM_ENB | IGNORE_TIMEOUT);
-	if (pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0) != 0)
-	{
-		hprintk1("can't write GEN_CNTL_0.\n");
+	if (pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0) != 0) {
+		hprintk("can't write GEN_CNTL_0.\n");
 		return -EINVAL;
 	}
 
-	if (pci_read_config_word(pci_dev, PCI_COMMAND, &command) != 0)
-	{
-		hprintk1("can't read PCI_COMMAND.\n");
+	if (pci_read_config_word(pci_dev, PCI_COMMAND, &command) != 0) {
+		hprintk("can't read PCI_COMMAND.\n");
 		return -EINVAL;
 	}
 
 	command |= (PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE);
-	if (pci_write_config_word(pci_dev, PCI_COMMAND, command) != 0)
-	{
-		hprintk1("can't enable memory.\n");
+	if (pci_write_config_word(pci_dev, PCI_COMMAND, command) != 0) {
+		hprintk("can't enable memory.\n");
 		return -EINVAL;
 	}
 
-	if (pci_read_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, &cache_size))
-	{
-		hprintk1("can't read cache line size?\n");
+	if (pci_read_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, &cache_size)) {
+		hprintk("can't read cache line size?\n");
 		return -EINVAL;
 	}
 
-	if (cache_size < 16)
-	{
+	if (cache_size < 16) {
 		cache_size = 16;
 		if (pci_write_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, cache_size))
 			hprintk("can't set cache line size to %d\n", cache_size);
 	}
 
-	if (pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER, &timer))
-	{
-		hprintk1("can't read latency timer?\n");
+	if (pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER, &timer)) {
+		hprintk("can't read latency timer?\n");
 		return -EINVAL;
 	}
 
@@ -1125,8 +1073,7 @@
 	 *
 	 */ 
 #define LAT_TIMER 209
-	if (timer < LAT_TIMER)
-	{
+	if (timer < LAT_TIMER) {
 		HPRINTK("latency timer was %d, setting to %d\n", timer, LAT_TIMER);
 		timer = LAT_TIMER;
 		if (pci_write_config_byte(pci_dev, PCI_LATENCY_TIMER, timer))
@@ -1134,19 +1081,18 @@
 	}
 
 	if (!(he_dev->membase = (unsigned long) ioremap(he_dev->membase, HE_REGMAP_SIZE))) {
-		hprintk1("can't set up page mapping\n");
+		hprintk("can't set up page mapping\n");
 		return -EINVAL;
 	}
-	      
+
 	/* 4.4 card reset */
 	he_writel(he_dev, 0x0, RESET_CNTL);
 	he_writel(he_dev, 0xff, RESET_CNTL);
 
 	udelay(16*1000);	/* 16 ms */
 	status = he_readl(he_dev, RESET_CNTL);
-	if ((status & BOARD_RST_STATUS) == 0)
-	{
-		hprintk1("reset failed\n");
+	if ((status & BOARD_RST_STATUS) == 0) {
+		hprintk("reset failed\n");
 		return -EINVAL;
 	}
 
@@ -1157,23 +1103,23 @@
 	else
 		gen_cntl_0 &= ~ENBL_64;
 
-	if (disable64 == 1)
-	{
-		hprintk1("disabling 64-bit pci bus transfers\n");
+	if (disable64 == 1) {
+		hprintk("disabling 64-bit pci bus transfers\n");
 		gen_cntl_0 &= ~ENBL_64;
 	}
 
-	if (gen_cntl_0 & ENBL_64) hprintk1("64-bit transfers enabled\n");
+	if (gen_cntl_0 & ENBL_64)
+		hprintk("64-bit transfers enabled\n");
 
 	pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0);
 
 	/* 4.7 read prom contents */
-	for(i=0; i<PROD_ID_LEN; ++i)
+	for (i = 0; i < PROD_ID_LEN; ++i)
 		he_dev->prod_id[i] = read_prom_byte(he_dev, PROD_ID + i);
 
 	he_dev->media = read_prom_byte(he_dev, MEDIA);
 
-	for(i=0; i<6; ++i)
+	for (i = 0; i < 6; ++i)
 		dev->esi[i] = read_prom_byte(he_dev, MAC_ADDR + i);
 
 	hprintk("%s%s, %x:%x:%x:%x:%x:%x\n",
@@ -1210,7 +1156,8 @@
 	he_writel(he_dev, lb_swap, LB_SWAP);
 
 	/* 4.10 initialize the interrupt queues */
-	if ((err = he_init_irq(he_dev)) != 0) return err;
+	if ((err = he_init_irq(he_dev)) != 0)
+		return err;
 
 #ifdef USE_TASKLET
 	tasklet_init(&he_dev->tasklet, he_tasklet, (unsigned long) he_dev);
@@ -1263,27 +1210,23 @@
 	he_dev->vcibits = CONFIG_DEFAULT_VCIBITS;
 	he_dev->vpibits = CONFIG_DEFAULT_VPIBITS;
 
-	if (nvpibits != -1 && nvcibits != -1 && nvpibits+nvcibits != HE_MAXCIDBITS)
-	{
+	if (nvpibits != -1 && nvcibits != -1 && nvpibits+nvcibits != HE_MAXCIDBITS) {
 		hprintk("nvpibits + nvcibits != %d\n", HE_MAXCIDBITS);
 		return -ENODEV;
 	}
 
-	if (nvpibits != -1)
-	{
+	if (nvpibits != -1) {
 		he_dev->vpibits = nvpibits;
 		he_dev->vcibits = HE_MAXCIDBITS - nvpibits;
 	}
 
-	if (nvcibits != -1)
-	{
+	if (nvcibits != -1) {
 		he_dev->vcibits = nvcibits;
 		he_dev->vpibits = HE_MAXCIDBITS - nvcibits;
 	}
 
 
-	if (he_is622(he_dev))
-	{
+	if (he_is622(he_dev)) {
 		he_dev->cells_per_row = 40;
 		he_dev->bytes_per_row = 2048;
 		he_dev->r0_numrows = 256;
@@ -1292,9 +1235,7 @@
 		he_dev->r0_startrow = 0;
 		he_dev->tx_startrow = 256;
 		he_dev->r1_startrow = 768;
-	}
-	else
-	{
+	} else {
 		he_dev->cells_per_row = 20;
 		he_dev->bytes_per_row = 1024;
 		he_dev->r0_numrows = 512;
@@ -1309,15 +1250,18 @@
 	he_dev->buffer_limit = 4;
 	he_dev->r0_numbuffs = he_dev->r0_numrows *
 				he_dev->cells_per_row / he_dev->cells_per_lbuf;
-	if (he_dev->r0_numbuffs > 2560) he_dev->r0_numbuffs = 2560;
+	if (he_dev->r0_numbuffs > 2560)
+		he_dev->r0_numbuffs = 2560;
 
 	he_dev->r1_numbuffs = he_dev->r1_numrows *
 				he_dev->cells_per_row / he_dev->cells_per_lbuf;
-	if (he_dev->r1_numbuffs > 2560) he_dev->r1_numbuffs = 2560;
+	if (he_dev->r1_numbuffs > 2560)
+		he_dev->r1_numbuffs = 2560;
 
 	he_dev->tx_numbuffs = he_dev->tx_numrows *
 				he_dev->cells_per_row / he_dev->cells_per_lbuf;
-	if (he_dev->tx_numbuffs > 5120) he_dev->tx_numbuffs = 5120;
+	if (he_dev->tx_numbuffs > 5120)
+		he_dev->tx_numbuffs = 5120;
 
 	/* 5.1.2 configure hardware dependent registers */
 
@@ -1355,15 +1299,15 @@
 	he_writel(he_dev, 0x0, TXAAL5_PROTO);
 
 	he_writel(he_dev, PHY_INT_ENB |
-		(he_is622(he_dev) ? PTMR_PRE(67-1) : PTMR_PRE(50-1)),
+		(he_is622(he_dev) ? PTMR_PRE(67 - 1) : PTMR_PRE(50 - 1)),
 								RH_CONFIG);
 
 	/* 5.1.3 initialize connection memory */
 
-	for(i=0; i < TCM_MEM_SIZE; ++i)
+	for (i = 0; i < TCM_MEM_SIZE; ++i)
 		he_writel_tcm(he_dev, 0, i);
 
-	for(i=0; i < RCM_MEM_SIZE; ++i)
+	for (i = 0; i < RCM_MEM_SIZE; ++i)
 		he_writel_rcm(he_dev, 0, i);
 
 	/*
@@ -1453,8 +1397,7 @@
 
 	/* 5.1.5 initialize intermediate receive queues */
 
-	if (he_is622(he_dev))
-	{
+	if (he_is622(he_dev)) {
 		he_writel(he_dev, 0x000f, G0_INMQ_S);
 		he_writel(he_dev, 0x200f, G0_INMQ_L);
 
@@ -1478,9 +1421,7 @@
 
 		he_writel(he_dev, 0x007f, G7_INMQ_S);
 		he_writel(he_dev, 0x207f, G7_INMQ_L);
-	}
-	else
-	{
+	} else {
 		he_writel(he_dev, 0x0000, G0_INMQ_S);
 		he_writel(he_dev, 0x0008, G0_INMQ_L);
 
@@ -1519,23 +1460,18 @@
 
 	/* 5.1.8 cs block connection memory initialization */
 	
-	he_init_cs_block_rcm(he_dev);
+	if (he_init_cs_block_rcm(he_dev) < 0)
+		return -ENOMEM;
 
 	/* 5.1.10 initialize host structures */
 
 	he_init_tpdrq(he_dev);
 
 #ifdef USE_TPD_POOL
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,44)
-	he_dev->tpd_pool = pci_pool_create("tpd", he_dev->pci_dev,
-		sizeof(struct he_tpd), TPD_ALIGNMENT, 0, SLAB_KERNEL);
-#else
 	he_dev->tpd_pool = pci_pool_create("tpd", he_dev->pci_dev,
 		sizeof(struct he_tpd), TPD_ALIGNMENT, 0);
-#endif
-	if (he_dev->tpd_pool == NULL)
-	{
-		hprintk1("unable to create tpd pci_pool\n");
+	if (he_dev->tpd_pool == NULL) {
+		hprintk("unable to create tpd pci_pool\n");
 		return -ENOMEM;         
 	}
 
@@ -1546,21 +1482,19 @@
 	if (!he_dev->tpd_base)
 		return -ENOMEM;
 
-	for(i = 0; i < CONFIG_NUMTPDS; ++i)
-	{
+	for (i = 0; i < CONFIG_NUMTPDS; ++i) {
 		he_dev->tpd_base[i].status = (i << TPD_ADDR_SHIFT);
 		he_dev->tpd_base[i].inuse = 0;
 	}
 		
 	he_dev->tpd_head = he_dev->tpd_base;
-	he_dev->tpd_end = &he_dev->tpd_base[CONFIG_NUMTPDS-1];
+	he_dev->tpd_end = &he_dev->tpd_base[CONFIG_NUMTPDS - 1];
 #endif
 
 	if (he_init_group(he_dev, 0) != 0)
 		return -ENOMEM;
 
-	for (group = 1; group < HE_NUM_GROUPS; ++group)
-	{
+	for (group = 1; group < HE_NUM_GROUPS; ++group) {
 		he_writel(he_dev, 0x0, G0_RBPS_S + (group * 32));
 		he_writel(he_dev, 0x0, G0_RBPS_T + (group * 32));
 		he_writel(he_dev, 0x0, G0_RBPS_QI + (group * 32));
@@ -1590,9 +1524,8 @@
 
 	he_dev->hsp = pci_alloc_consistent(he_dev->pci_dev,
 				sizeof(struct he_hsp), &he_dev->hsp_phys);
-	if (he_dev->hsp == NULL)
-	{
-		hprintk1("failed to allocate host status page\n");
+	if (he_dev->hsp == NULL) {
+		hprintk("failed to allocate host status page\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->hsp, 0, sizeof(struct he_hsp));
@@ -1606,8 +1539,7 @@
 		he_dev->atm_dev->phy->start(he_dev->atm_dev);
 #endif /* CONFIG_ATM_HE_USE_SUNI */
 
-	if (sdh)
-	{
+	if (sdh) {
 		/* this really should be in suni.c but for now... */
 
 		int val;
@@ -1627,20 +1559,7 @@
 	reg |= RX_ENABLE;
 	he_writel(he_dev, reg, RC_CONFIG);
 
-#ifndef USE_HE_FIND_VCC
-	he_dev->he_vcc_table = kmalloc(sizeof(struct he_vcc_table) * 
-			(1 << (he_dev->vcibits + he_dev->vpibits)), GFP_KERNEL);
-	if (he_dev->he_vcc_table == NULL)
-	{
-		hprintk1("failed to alloc he_vcc_table\n");
-		return -ENOMEM;
-	}
-	memset(he_dev->he_vcc_table, 0, sizeof(struct he_vcc_table) *
-				(1 << (he_dev->vcibits + he_dev->vpibits)));
-#endif
-
-	for (i = 0; i < HE_NUM_CS_STPER; ++i)
-	{
+	for (i = 0; i < HE_NUM_CS_STPER; ++i) {
 		he_dev->cs_stper[i].inuse = 0;
 		he_dev->cs_stper[i].pcr = -1;
 	}
@@ -1654,8 +1573,8 @@
 
 	he_dev->irq_peak = 0;
 	he_dev->rbrq_peak = 0;
-        he_dev->rbpl_peak = 0;
-        he_dev->tbrq_peak = 0;
+	he_dev->rbpl_peak = 0;
+	he_dev->tbrq_peak = 0;
 
 	HPRINTK("hell bent for leather!\n");
 
@@ -1673,8 +1592,7 @@
 
 	/* disable interrupts */
 
-	if (he_dev->membase)
-	{
+	if (he_dev->membase) {
 		pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0);
 		gen_cntl_0 &= ~(INT_PROC_ENBL | INIT_ENB);
 		pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0);
@@ -1700,12 +1618,7 @@
 #endif /* CONFIG_ATM_HE_USE_SUNI */
 
 	if (he_dev->irq)
-	{
-#ifdef BUS_INT_WAR
-		sn_delete_polled_interrupt(he_dev->irq);
-#endif
 		free_irq(he_dev->irq, he_dev);
-	}
 
 	if (he_dev->irq_base)
 		pci_free_consistent(he_dev->pci_dev, (CONFIG_IRQ_SIZE+1)
@@ -1715,11 +1628,9 @@
 		pci_free_consistent(he_dev->pci_dev, sizeof(struct he_hsp),
 						he_dev->hsp, he_dev->hsp_phys);
 
-	if (he_dev->rbpl_base)
-	{
+	if (he_dev->rbpl_base) {
 #ifdef USE_RBPL_POOL
-		for (i=0; i<CONFIG_RBPL_SIZE; ++i)
-		{
+		for (i = 0; i < CONFIG_RBPL_SIZE; ++i) {
 			void *cpuaddr = he_dev->rbpl_virt[i].virt;
 			dma_addr_t dma_handle = he_dev->rbpl_base[i].phys;
 
@@ -1739,11 +1650,9 @@
 #endif
 
 #ifdef USE_RBPS
-	if (he_dev->rbps_base)
-	{
+	if (he_dev->rbps_base) {
 #ifdef USE_RBPS_POOL
-		for (i=0; i<CONFIG_RBPS_SIZE; ++i)
-		{
+		for (i = 0; i < CONFIG_RBPS_SIZE; ++i) {
 			void *cpuaddr = he_dev->rbps_virt[i].virt;
 			dma_addr_t dma_handle = he_dev->rbps_base[i].phys;
 
@@ -1785,19 +1694,14 @@
 							he_dev->tpd_base, he_dev->tpd_base_phys);
 #endif
 
-#ifndef USE_HE_FIND_VCC
-	if (he_dev->he_vcc_table)
-		kfree(he_dev->he_vcc_table);
-#endif
-
-	if (he_dev->pci_dev)
-	{
+	if (he_dev->pci_dev) {
 		pci_read_config_word(he_dev->pci_dev, PCI_COMMAND, &command);
 		command &= ~(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 		pci_write_config_word(he_dev->pci_dev, PCI_COMMAND, command);
 	}
 	
-	if (he_dev->membase) iounmap((void *) he_dev->membase);
+	if (he_dev->membase)
+		iounmap((void *) he_dev->membase);
 }
 
 static struct he_tpd *
@@ -1821,8 +1725,7 @@
 #else
 	int i;
 
-	for(i = 0; i < CONFIG_NUMTPDS; ++i)
-	{
+	for (i = 0; i < CONFIG_NUMTPDS; ++i) {
 		++he_dev->tpd_head;
 		if (he_dev->tpd_head > he_dev->tpd_end) {
 			he_dev->tpd_head = he_dev->tpd_base;
@@ -1843,7 +1746,7 @@
 }
 
 #define AAL5_LEN(buf,len) 						\
-			((((unsigned char *)(buf))[(len)-6]<<8) |	\
+			((((unsigned char *)(buf))[(len)-6] << 8) |	\
 				(((unsigned char *)(buf))[(len)-5]))
 
 /* 2.10.1.2 receive
@@ -1853,7 +1756,7 @@
  */
 
 #define TCP_CKSUM(buf,len) 						\
-			((((unsigned char *)(buf))[(len)-2]<<8) |	\
+			((((unsigned char *)(buf))[(len)-2] << 8) |	\
 				(((unsigned char *)(buf))[(len-1)]))
 
 static int
@@ -1868,12 +1771,11 @@
 	struct sk_buff *skb;
 	struct atm_vcc *vcc = NULL;
 	struct he_vcc *he_vcc;
-	struct iovec *iov;
+	struct he_iovec *iov;
 	int pdus_assembled = 0;
 	int updated = 0;
 
-	while (he_dev->rbrq_head != rbrq_tail)
-	{
+	while (he_dev->rbrq_head != rbrq_tail) {
 		++updated;
 
 		HPRINTK("%p rbrq%d 0x%x len=%d cid=0x%x %s%s%s%s%s%s\n",
@@ -1898,15 +1800,11 @@
 		buf_len = RBRQ_BUFLEN(he_dev->rbrq_head) * 4;
 		cid = RBRQ_CID(he_dev->rbrq_head);
 
-#ifdef USE_HE_FIND_VCC
 		if (cid != lastcid)
 			vcc = he_find_vcc(he_dev, cid);
 		lastcid = cid;
-#else
-		vcc = HE_LOOKUP_VCC(he_dev, cid);
-#endif
-		if (vcc == NULL)
-		{
+
+		if (vcc == NULL) {
 			hprintk("vcc == NULL  (cid 0x%x)\n", cid);
 			if (!RBRQ_HBUF_ERR(he_dev->rbrq_head))
 					rbp->status &= ~RBP_LOANED;
@@ -1915,32 +1813,25 @@
 		}
 
 		he_vcc = HE_VCC(vcc);
-		if (he_vcc == NULL)
-		{
+		if (he_vcc == NULL) {
 			hprintk("he_vcc == NULL  (cid 0x%x)\n", cid);
 			if (!RBRQ_HBUF_ERR(he_dev->rbrq_head))
 					rbp->status &= ~RBP_LOANED;
 			goto next_rbrq_entry;
 		}
 
-		if (RBRQ_HBUF_ERR(he_dev->rbrq_head))
-		{
+		if (RBRQ_HBUF_ERR(he_dev->rbrq_head)) {
 			hprintk("HBUF_ERR!  (cid 0x%x)\n", cid);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-				++vcc->stats->rx_drop;
-#else
 				atomic_inc(&vcc->stats->rx_drop);
-#endif
 			goto return_host_buffers;
 		}
 
-		he_vcc->iov_tail->iov_base = (void *) RBRQ_ADDR(he_dev->rbrq_head);
+		he_vcc->iov_tail->iov_base = RBRQ_ADDR(he_dev->rbrq_head);
 		he_vcc->iov_tail->iov_len = buf_len;
 		he_vcc->pdu_len += buf_len;
 		++he_vcc->iov_tail;
 
-		if (RBRQ_CON_CLOSED(he_dev->rbrq_head))
-		{
+		if (RBRQ_CON_CLOSED(he_dev->rbrq_head)) {
 			lastcid = -1;
 			HPRINTK("wake_up rx_waitq  (cid 0x%x)\n", cid);
 			wake_up(&he_vcc->rx_waitq);
@@ -1948,59 +1839,42 @@
 		}
 
 #ifdef notdef
-		if (he_vcc->iov_tail - he_vcc->iov_head > 32)
-		{
+		if ((he_vcc->iov_tail - he_vcc->iov_head) > HE_MAXIOV) {
 			hprintk("iovec full!  cid 0x%x\n", cid);
 			goto return_host_buffers;
 		}
 #endif
-		if (!RBRQ_END_PDU(he_dev->rbrq_head)) goto next_rbrq_entry;
+		if (!RBRQ_END_PDU(he_dev->rbrq_head))
+			goto next_rbrq_entry;
 
 		if (RBRQ_LEN_ERR(he_dev->rbrq_head)
-				|| RBRQ_CRC_ERR(he_dev->rbrq_head))
-		{
+				|| RBRQ_CRC_ERR(he_dev->rbrq_head)) {
 			HPRINTK("%s%s (%d.%d)\n",
 				RBRQ_CRC_ERR(he_dev->rbrq_head)
 							? "CRC_ERR " : "",
 				RBRQ_LEN_ERR(he_dev->rbrq_head)
 							? "LEN_ERR" : "",
 							vcc->vpi, vcc->vci);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-			++vcc->stats->rx_err;
-#else
 			atomic_inc(&vcc->stats->rx_err);
-#endif
 			goto return_host_buffers;
 		}
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,15)
 		skb = atm_alloc_charge(vcc, he_vcc->pdu_len + rx_skb_reserve,
 							GFP_ATOMIC);
-#else
-		if (!atm_charge(vcc, atm_pdu2truesize(he_vcc->pdu_len + rx_skb_reserve)))
-			skb = NULL;
-		else
-		{
-			skb = alloc_skb(he_vcc->pdu_len + rx_skb_reserve, GFP_ATOMIC);
-			if (!skb) atm_return(vcc,
-				atm_pdu2truesize(he_vcc->pdu_len + rx_skb_reserve));
-		}
-#endif
-		if (!skb)
-		{
+		if (!skb) {
 			HPRINTK("charge failed (%d.%d)\n", vcc->vpi, vcc->vci);
 			goto return_host_buffers;
 		}
 
-		if (rx_skb_reserve > 0) skb_reserve(skb, rx_skb_reserve);
+		if (rx_skb_reserve > 0)
+			skb_reserve(skb, rx_skb_reserve);
 
 		do_gettimeofday(&skb->stamp);
 
-		for(iov = he_vcc->iov_head;
-				iov < he_vcc->iov_tail; ++iov)
-		{
+		for (iov = he_vcc->iov_head;
+				iov < he_vcc->iov_tail; ++iov) {
 #ifdef USE_RBPS
-			if ((u32)iov->iov_base & RBP_SMALLBUF)
+			if (iov->iov_base & RBP_SMALLBUF)
 				memcpy(skb_put(skb, iov->iov_len),
 					he_dev->rbps_virt[RBP_INDEX(iov->iov_base)].virt, iov->iov_len);
 			else
@@ -2009,8 +1883,7 @@
 					he_dev->rbpl_virt[RBP_INDEX(iov->iov_base)].virt, iov->iov_len);
 		}
 
-		switch(vcc->qos.aal)
-		{
+		switch (vcc->qos.aal) {
 			case ATM_AAL0:
 				/* 2.10.1.5 raw cell receive */
 				skb->len = ATM_AAL0_SDU;
@@ -2022,8 +1895,7 @@
 				skb->len = AAL5_LEN(skb->data, he_vcc->pdu_len);
 				skb->tail = skb->data + skb->len;
 #ifdef USE_CHECKSUM_HW
-				if (vcc->vpi == 0 && vcc->vci >= ATM_NOT_RSV_VCI) 
-				{
+				if (vcc->vpi == 0 && vcc->vci >= ATM_NOT_RSV_VCI) {
 					skb->ip_summed = CHECKSUM_HW;
 					skb->csum = TCP_CKSUM(skb->data,
 							he_vcc->pdu_len);
@@ -2042,20 +1914,15 @@
 #endif
 		vcc->push(vcc, skb);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-		++vcc->stats->rx;
-#else
 		atomic_inc(&vcc->stats->rx);
-#endif
 
 return_host_buffers:
 		++pdus_assembled;
 
-		for(iov = he_vcc->iov_head;
-				iov < he_vcc->iov_tail; ++iov)
-		{
+		for (iov = he_vcc->iov_head;
+				iov < he_vcc->iov_tail; ++iov) {
 #ifdef USE_RBPS
-			if ((u32)iov->iov_base & RBP_SMALLBUF)
+			if (iov->iov_base & RBP_SMALLBUF)
 				rbp = &he_dev->rbps_base[RBP_INDEX(iov->iov_base)];
 			else
 #endif
@@ -2074,9 +1941,9 @@
 
 	}
 
-	if (updated)
-	{
-		if (updated > he_dev->rbrq_peak) he_dev->rbrq_peak = updated;
+	if (updated) {
+		if (updated > he_dev->rbrq_peak)
+			he_dev->rbrq_peak = updated;
 
 		he_writel(he_dev, RBRQ_MASK(he_dev->rbrq_head),
 						G0_RBRQ_H + (group * 16));
@@ -2102,8 +1969,7 @@
 
 	/* 2.1.6 transmit buffer return queue */
 
-	while (he_dev->tbrq_head != tbrq_tail)
-	{
+	while (he_dev->tbrq_head != tbrq_tail) {
 		++updated;
 
 		HPRINTK("tbrq%d 0x%x%s%s\n",
@@ -2114,19 +1980,16 @@
 #ifdef USE_TPD_POOL
 		tpd = NULL;
 		p = &he_dev->outstanding_tpds;
-		while ((p = p->next) != &he_dev->outstanding_tpds)
-		{
+		while ((p = p->next) != &he_dev->outstanding_tpds) {
 			struct he_tpd *__tpd = list_entry(p, struct he_tpd, entry);
-			if (TPD_ADDR(__tpd->status) == TBRQ_TPD(he_dev->tbrq_head))
-			{
+			if (TPD_ADDR(__tpd->status) == TBRQ_TPD(he_dev->tbrq_head)) {
 				tpd = __tpd;
 				list_del(&__tpd->entry);
 				break;
 			}
 		}
 
-		if (tpd == NULL)
-		{
+		if (tpd == NULL) {
 			hprintk("unable to locate tpd for dma buffer %x\n",
 						TBRQ_TPD(he_dev->tbrq_head));
 			goto next_tbrq_entry;
@@ -2135,8 +1998,7 @@
 		tpd = &he_dev->tpd_base[ TPD_INDEX(TBRQ_TPD(he_dev->tbrq_head)) ];
 #endif
 
-		if (TBRQ_EOS(he_dev->tbrq_head))
-		{
+		if (TBRQ_EOS(he_dev->tbrq_head)) {
 			HPRINTK("wake_up(tx_waitq) cid 0x%x\n",
 				he_mkcid(he_dev, tpd->vcc->vpi, tpd->vcc->vci));
 			if (tpd->vcc)
@@ -2145,19 +2007,18 @@
 			goto next_tbrq_entry;
 		}
 
-		for(slot = 0; slot < TPD_MAXIOV; ++slot)
-		{
+		for (slot = 0; slot < TPD_MAXIOV; ++slot) {
 			if (tpd->iovec[slot].addr)
 				pci_unmap_single(he_dev->pci_dev,
 					tpd->iovec[slot].addr,
 					tpd->iovec[slot].len & TPD_LEN_MASK,
 							PCI_DMA_TODEVICE);
-			if (tpd->iovec[slot].len & TPD_LST) break;
+			if (tpd->iovec[slot].len & TPD_LST)
+				break;
 				
 		}
 
-		if (tpd->skb)	/* && !TBRQ_MULTIPLE(he_dev->tbrq_head) */
-		{
+		if (tpd->skb) {	/* && !TBRQ_MULTIPLE(he_dev->tbrq_head) */
 			if (tpd->vcc && tpd->vcc->pop)
 				tpd->vcc->pop(tpd->vcc, tpd->skb);
 			else
@@ -2166,7 +2027,8 @@
 
 next_tbrq_entry:
 #ifdef USE_TPD_POOL
-		if (tpd) pci_pool_free(he_dev->tpd_pool, tpd, TPD_ADDR(tpd->status));
+		if (tpd)
+			pci_pool_free(he_dev->tpd_pool, tpd, TPD_ADDR(tpd->status));
 #else
 		tpd->inuse = 0;
 #endif
@@ -2175,9 +2037,9 @@
 					TBRQ_MASK(++he_dev->tbrq_head));
 	}
 
-	if (updated)
-	{
-		if (updated > he_dev->tbrq_peak) he_dev->tbrq_peak = updated;
+	if (updated) {
+		if (updated > he_dev->tbrq_peak)
+			he_dev->tbrq_peak = updated;
 
 		he_writel(he_dev, TBRQ_MASK(he_dev->tbrq_head),
 						G0_TBRQ_H + (group * 16));
@@ -2198,8 +2060,7 @@
 	rbpl_head = (struct he_rbp *) ((unsigned long)he_dev->rbpl_base |
 					RBPL_MASK(he_readl(he_dev, G0_RBPL_S)));
 
-	for(;;)
-	{
+	for (;;) {
 		newtail = (struct he_rbp *) ((unsigned long)he_dev->rbpl_base |
 						RBPL_MASK(he_dev->rbpl_tail+1));
 
@@ -2210,13 +2071,12 @@
 		newtail->status |= RBP_LOANED;
 		he_dev->rbpl_tail = newtail;
 		++moved;
-
 	} 
 
 	if (moved) {
 		he_writel(he_dev, RBPL_MASK(he_dev->rbpl_tail), G0_RBPL_T);
 #ifdef CONFIG_IA64_SGI_SN2
-                (void) he_readl(he_dev, G0_RBPL_T);
+		(void) he_readl(he_dev, G0_RBPL_T);
 #endif
 	}
 }
@@ -2232,8 +2092,7 @@
 	rbps_head = (struct he_rbp *) ((unsigned long)he_dev->rbps_base |
 					RBPS_MASK(he_readl(he_dev, G0_RBPS_S)));
 
-	for(;;)
-	{
+	for (;;) {
 		newtail = (struct he_rbp *) ((unsigned long)he_dev->rbps_base |
 						RBPS_MASK(he_dev->rbps_tail+1));
 
@@ -2244,13 +2103,12 @@
 		newtail->status |= RBP_LOANED;
 		he_dev->rbps_tail = newtail;
 		++moved;
-
 	} 
 
 	if (moved) {
 		he_writel(he_dev, RBPS_MASK(he_dev->rbps_tail), G0_RBPS_T);
 #ifdef CONFIG_IA64_SGI_SN2
-                (void) he_readl(he_dev, G0_RBPS_T);
+		(void) he_readl(he_dev, G0_RBPS_T);
 #endif
 	}
 }
@@ -2266,23 +2124,21 @@
 
 	HPRINTK("tasklet (0x%lx)\n", data);
 #ifdef USE_TASKLET
-	HE_SPIN_LOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
 #endif
 
-	while(he_dev->irq_head != he_dev->irq_tail)
-	{
+	while (he_dev->irq_head != he_dev->irq_tail) {
 		++updated;
 
 		type = ITYPE_TYPE(he_dev->irq_head->isw);
 		group = ITYPE_GROUP(he_dev->irq_head->isw);
 
-		switch (type)
-		{
+		switch (type) {
 			case ITYPE_RBRQ_THRESH:
-				hprintk("rbrq%d threshold\n", group);
+				HPRINTK("rbrq%d threshold\n", group);
+				/* fall through */
 			case ITYPE_RBRQ_TIMER:
-				if (he_service_rbrq(he_dev, group))
-				{
+				if (he_service_rbrq(he_dev, group)) {
 					he_service_rbpl(he_dev, group);
 #ifdef USE_RBPS
 					he_service_rbps(he_dev, group);
@@ -2290,7 +2146,8 @@
 				}
 				break;
 			case ITYPE_TBRQ_THRESH:
-				hprintk("tbrq%d threshold\n", group);
+				HPRINTK("tbrq%d threshold\n", group);
+				/* fall through */
 			case ITYPE_TPD_COMPLETE:
 				he_service_tbrq(he_dev, group);
 				break;
@@ -2303,43 +2160,38 @@
 #endif /* USE_RBPS */
 				break;
 			case ITYPE_PHY:
+				HPRINTK("phy interrupt\n");
 #ifdef CONFIG_ATM_HE_USE_SUNI
-				HE_SPIN_UNLOCK(he_dev, flags);
+				spin_unlock_irqrestore(&he_dev->global_lock, flags);
 				if (he_dev->atm_dev->phy && he_dev->atm_dev->phy->interrupt)
 					he_dev->atm_dev->phy->interrupt(he_dev->atm_dev);
-				HE_SPIN_LOCK(he_dev, flags);
+				spin_lock_irqsave(&he_dev->global_lock, flags);
 #endif
-				HPRINTK1("phy interrupt\n");
 				break;
 			case ITYPE_OTHER:
-				switch (type|group)
-				{
+				switch (type|group) {
 					case ITYPE_PARITY:
-						hprintk1("parity error\n");
+						hprintk("parity error\n");
 						break;
 					case ITYPE_ABORT:
 						hprintk("abort 0x%x\n", he_readl(he_dev, ABORT_ADDR));
 						break;
 				}
 				break;
-			default:
-				if (he_dev->irq_head->isw == ITYPE_INVALID)
-				{
-					/* see 8.1.1 -- check all queues */
+			case ITYPE_TYPE(ITYPE_INVALID):
+				/* see 8.1.1 -- check all queues */
 
-					HPRINTK("isw not updated 0x%x\n",
-						he_dev->irq_head->isw);
+				HPRINTK("isw not updated 0x%x\n", he_dev->irq_head->isw);
 
-					he_service_rbrq(he_dev, 0);
-					he_service_rbpl(he_dev, 0);
+				he_service_rbrq(he_dev, 0);
+				he_service_rbpl(he_dev, 0);
 #ifdef USE_RBPS
-					he_service_rbps(he_dev, 0);
+				he_service_rbps(he_dev, 0);
 #endif /* USE_RBPS */
-					he_service_tbrq(he_dev, 0);
-				}
-				else
-					hprintk("bad isw = 0x%x?\n",
-						he_dev->irq_head->isw);
+				he_service_tbrq(he_dev, 0);
+				break;
+			default:
+				hprintk("bad isw 0x%x?\n", he_dev->irq_head->isw);
 		}
 
 		he_dev->irq_head->isw = ITYPE_INVALID;
@@ -2347,9 +2199,9 @@
 		he_dev->irq_head = (struct he_irq *) NEXT_ENTRY(he_dev->irq_base, he_dev->irq_head, IRQ_MASK);
 	}
 
-	if (updated)
-	{
-		if (updated > he_dev->irq_peak) he_dev->irq_peak = updated;
+	if (updated) {
+		if (updated > he_dev->irq_peak)
+			he_dev->irq_peak = updated;
 
 		he_writel(he_dev,
 			IRQ_SIZE(CONFIG_IRQ_SIZE) |
@@ -2358,15 +2210,11 @@
 		(void) he_readl(he_dev, INT_FIFO); /* 8.1.2 controller errata */
 	}
 #ifdef USE_TASKLET
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 #endif
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,69)
-static irq_return_t
-#else
-static void
-#endif
+static irqreturn_t
 he_irq_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long flags;
@@ -2374,20 +2222,15 @@
 	int handled = 0;
 
 	if (he_dev == NULL)
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,69)
 		return IRQ_NONE;
-#else
-		return;
-#endif
 
-	HE_SPIN_LOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
 
 	he_dev->irq_tail = (struct he_irq *) (((unsigned long)he_dev->irq_base) |
 						(*he_dev->irq_tailoffset << 2));
 
-	if (he_dev->irq_tail == he_dev->irq_head)
-	{
-		HPRINTK1("tailoffset not updated?\n");
+	if (he_dev->irq_tail == he_dev->irq_head) {
+		HPRINTK("tailoffset not updated?\n");
 		he_dev->irq_tail = (struct he_irq *) ((unsigned long)he_dev->irq_base |
 			((he_readl(he_dev, IRQ0_BASE) & IRQ_MASK) << 2));
 		(void) he_readl(he_dev, INT_FIFO);	/* 8.1.2 controller errata */
@@ -2395,11 +2238,10 @@
 
 #ifdef DEBUG
 	if (he_dev->irq_head == he_dev->irq_tail /* && !IRQ_PENDING */)
-		hprintk1("spurious (or shared) interrupt?\n");
+		hprintk("spurious (or shared) interrupt?\n");
 #endif
 
-	if (he_dev->irq_head != he_dev->irq_tail)
-	{
+	if (he_dev->irq_head != he_dev->irq_tail) {
 		handled = 1;
 #ifdef USE_TASKLET
 		tasklet_schedule(&he_dev->tasklet);
@@ -2412,12 +2254,8 @@
 		(void) he_readl(he_dev, INT_FIFO);
 #endif
 	}
-	HE_SPIN_UNLOCK(he_dev, flags);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,69)
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 	return IRQ_RETVAL(handled);
-#else
-	return;
-#endif
 
 }
 
@@ -2440,14 +2278,12 @@
 	 * head for every enqueue would be unnecessarily slow)
 	 */
 
-	if (new_tail == he_dev->tpdrq_head)
-	{
+	if (new_tail == he_dev->tpdrq_head) {
 		he_dev->tpdrq_head = (struct he_tpdrq *)
 			(((unsigned long)he_dev->tpdrq_base) |
 				TPDRQ_MASK(he_readl(he_dev, TPDRQ_B_H)));
 
-		if (new_tail == he_dev->tpdrq_head)
-		{
+		if (new_tail == he_dev->tpdrq_head) {
 			hprintk("tpdrq full (cid 0x%x)\n", cid);
 			/*
 			 * FIXME
@@ -2455,17 +2291,12 @@
 			 * after service_tbrq, service the backlog
 			 * for now, we just drop the pdu
 			 */
-			if (tpd->skb)
-			{
+			if (tpd->skb) {
 				if (tpd->vcc->pop)
 					tpd->vcc->pop(tpd->vcc, tpd->skb);
 				else
 					dev_kfree_skb_any(tpd->skb);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-				++tpd->vcc->stats->tx_err;
-#else
 				atomic_inc(&tpd->vcc->stats->tx_err);
-#endif
 			}
 #ifdef USE_TPD_POOL
 			pci_pool_free(he_dev->tpd_pool, tpd, TPD_ADDR(tpd->status));
@@ -2505,29 +2336,24 @@
 	unsigned cid, rsr0, rsr1, rsr4, tsr0, tsr0_aal, tsr4, period, reg, clock;
 
 	
-	if ((err = atm_find_ci(vcc, &vpi, &vci)))
-	{
+	if ((err = atm_find_ci(vcc, &vpi, &vci))) {
 		HPRINTK("atm_find_ci err = %d\n", err);
 		return err;
 	}
-	if (vci == ATM_VCI_UNSPEC || vpi == ATM_VPI_UNSPEC) return 0;
+	if (vci == ATM_VCI_UNSPEC || vpi == ATM_VPI_UNSPEC)
+		return 0;
 	vcc->vpi = vpi;
 	vcc->vci = vci;
 
 	HPRINTK("open vcc %p %d.%d\n", vcc, vpi, vci);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-	vcc->flags |= ATM_VF_ADDR;
-#else
 	set_bit(ATM_VF_ADDR, &vcc->flags);
-#endif
 
 	cid = he_mkcid(he_dev, vpi, vci);
 
 	he_vcc = (struct he_vcc *) kmalloc(sizeof(struct he_vcc), GFP_ATOMIC);
-	if (he_vcc == NULL)
-	{
-		hprintk1("unable to allocate he_vcc during open\n");
+	if (he_vcc == NULL) {
+		hprintk("unable to allocate he_vcc during open\n");
 		return -ENOMEM;
 	}
 
@@ -2535,30 +2361,23 @@
 	he_vcc->pdu_len = 0;
 	he_vcc->rc_index = -1;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-	init_waitqueue(&he_vcc->rx_waitq);
-	init_waitqueue(&he_vcc->tx_waitq);
-#else
 	init_waitqueue_head(&he_vcc->rx_waitq);
 	init_waitqueue_head(&he_vcc->tx_waitq);
-#endif
 
 	HE_VCC(vcc) = he_vcc;
 
-	if (vcc->qos.txtp.traffic_class != ATM_NONE)
-	{
+	if (vcc->qos.txtp.traffic_class != ATM_NONE) {
 		int pcr_goal;
 
-                pcr_goal = atm_pcr_goal(&vcc->qos.txtp);
-                if (pcr_goal == 0)
-                        pcr_goal = he_dev->atm_dev->link_rate;
-                if (pcr_goal < 0)	/* means round down, technically */
-                        pcr_goal = -pcr_goal;
+		pcr_goal = atm_pcr_goal(&vcc->qos.txtp);
+		if (pcr_goal == 0)
+			pcr_goal = he_dev->atm_dev->link_rate;
+		if (pcr_goal < 0)	/* means round down, technically */
+			pcr_goal = -pcr_goal;
 
 		HPRINTK("open tx cid 0x%x pcr_goal %d\n", cid, pcr_goal);
 
-		switch (vcc->qos.aal)
-		{
+		switch (vcc->qos.aal) {
 			case ATM_AAL5:
 				tsr0_aal = TSR0_AAL5;
 				tsr4 = TSR4_AAL5;
@@ -2572,19 +2391,17 @@
 				goto open_failed;
 		}
 
-		HE_SPIN_LOCK(he_dev, flags);
+		spin_lock_irqsave(&he_dev->global_lock, flags);
 		tsr0 = he_readl_tsr0(he_dev, cid);
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
-		if (TSR0_CONN_STATE(tsr0) != 0)
-		{
+		if (TSR0_CONN_STATE(tsr0) != 0) {
 			hprintk("cid 0x%x not idle (tsr0 = 0x%x)\n", cid, tsr0);
 			err = -EBUSY;
 			goto open_failed;
 		}
 
-		switch(vcc->qos.txtp.traffic_class)
-		{
+		switch (vcc->qos.txtp.traffic_class) {
 			case ATM_UBR:
 				/* 2.3.3.1 open connection ubr */
 
@@ -2603,18 +2420,17 @@
 					goto open_failed;
 				}
 
-				HE_SPIN_LOCK(he_dev, flags);			/* also protects he_dev->cs_stper[] */
+				spin_lock_irqsave(&he_dev->global_lock, flags);			/* also protects he_dev->cs_stper[] */
 
 				/* find an unused cs_stper register */
-				for(reg = 0; reg < HE_NUM_CS_STPER; ++reg)
+				for (reg = 0; reg < HE_NUM_CS_STPER; ++reg)
 					if (he_dev->cs_stper[reg].inuse == 0 || 
-						he_dev->cs_stper[reg].pcr == pcr_goal)
-					break;
+					    he_dev->cs_stper[reg].pcr == pcr_goal)
+							break;
 
-				if (reg == HE_NUM_CS_STPER)
-				{
+				if (reg == HE_NUM_CS_STPER) {
 					err = -EBUSY;
-					HE_SPIN_UNLOCK(he_dev, flags);
+					spin_unlock_irqrestore(&he_dev->global_lock, flags);
 					goto open_failed;
 				}
 
@@ -2632,7 +2448,7 @@
 
 				he_writel_mbox(he_dev, rate_to_atmf(period/2),
 							CS_STPER0 + reg);
-				HE_SPIN_UNLOCK(he_dev, flags);
+				spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 				tsr0 = TSR0_CBR | TSR0_GROUP(0) | tsr0_aal |
 							TSR0_RC_INDEX(reg);
@@ -2643,7 +2459,7 @@
 				goto open_failed;
 		}
 
-		HE_SPIN_LOCK(he_dev, flags);
+		spin_lock_irqsave(&he_dev->global_lock, flags);
 
 		he_writel_tsr0(he_dev, tsr0, cid);
 		he_writel_tsr4(he_dev, tsr4 | 1, cid);
@@ -2665,18 +2481,16 @@
 #ifdef CONFIG_IA64_SGI_SN2
 		(void) he_readl_tsr0(he_dev, cid);
 #endif
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 	}
 
-	if (vcc->qos.rxtp.traffic_class != ATM_NONE)
-	{
+	if (vcc->qos.rxtp.traffic_class != ATM_NONE) {
 		unsigned aal;
 
 		HPRINTK("open rx cid 0x%x (rx_waitq %p)\n", cid,
 		 				&HE_VCC(vcc)->rx_waitq);
 
-		switch (vcc->qos.aal)
-		{
+		switch (vcc->qos.aal) {
 			case ATM_AAL5:
 				aal = RSR0_AAL5;
 				break;
@@ -2688,12 +2502,11 @@
 				goto open_failed;
 		}
 
-		HE_SPIN_LOCK(he_dev, flags);
+		spin_lock_irqsave(&he_dev->global_lock, flags);
 
 		rsr0 = he_readl_rsr0(he_dev, cid);
-		if (rsr0 & RSR0_OPEN_CONN)
-		{
-			HE_SPIN_UNLOCK(he_dev, flags);
+		if (rsr0 & RSR0_OPEN_CONN) {
+			spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 			hprintk("cid 0x%x not idle (rsr0 = 0x%x)\n", cid, rsr0);
 			err = -EBUSY;
@@ -2711,45 +2524,32 @@
 				(RSR0_EPD_ENABLE|RSR0_PPD_ENABLE) : 0;
 
 #ifdef USE_CHECKSUM_HW
-		if (vpi == 0 && vci >= ATM_NOT_RSV_VCI) rsr0 |= RSR0_TCP_CKSUM;
+		if (vpi == 0 && vci >= ATM_NOT_RSV_VCI)
+			rsr0 |= RSR0_TCP_CKSUM;
 #endif
 
 		he_writel_rsr4(he_dev, rsr4, cid);
 		he_writel_rsr1(he_dev, rsr1, cid);
 		/* 5.1.11 last parameter initialized should be
-		          the open/closed indication in rsr0 */
+			  the open/closed indication in rsr0 */
 		he_writel_rsr0(he_dev,
 			rsr0 | RSR0_START_PDU | RSR0_OPEN_CONN | aal, cid);
 #ifdef CONFIG_IA64_SGI_SN2
 		(void) he_readl_rsr0(he_dev, cid);
 #endif
 
-		HE_SPIN_UNLOCK(he_dev, flags);
-
-#ifndef USE_HE_FIND_VCC
-		HE_LOOKUP_VCC(he_dev, cid) = vcc;
-#endif
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 	}
 
 open_failed:
 
-	if (err)
-	{
-		if (he_vcc) kfree(he_vcc);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-		vcc->flags &= ~ATM_VF_ADDR;
-#else
+	if (err) {
+		if (he_vcc)
+			kfree(he_vcc);
 		clear_bit(ATM_VF_ADDR, &vcc->flags);
-#endif
 	}
 	else
-	{
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-		vcc->flags |= ATM_VF_READY;
-#else
 		set_bit(ATM_VF_READY, &vcc->flags);
-#endif
-	}
 
 	return err;
 }
@@ -2758,11 +2558,7 @@
 he_close(struct atm_vcc *vcc)
 {
 	unsigned long flags;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,1)
 	DECLARE_WAITQUEUE(wait, current);
-#else
-	struct wait_queue wait = { current, NULL };
-#endif
 	struct he_dev *he_dev = HE_DEV(vcc->dev);
 	struct he_tpd *tpd;
 	unsigned cid;
@@ -2772,15 +2568,10 @@
 
 	HPRINTK("close vcc %p %d.%d\n", vcc, vcc->vpi, vcc->vci);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-	vcc->flags &= ~ATM_VF_READY;
-#else
 	clear_bit(ATM_VF_READY, &vcc->flags);
-#endif
 	cid = he_mkcid(he_dev, vcc->vpi, vcc->vci);
 
-	if (vcc->qos.rxtp.traffic_class != ATM_NONE)
-	{
+	if (vcc->qos.rxtp.traffic_class != ATM_NONE) {
 		int timeout;
 
 		HPRINTK("close rx cid 0x%x\n", cid);
@@ -2789,9 +2580,8 @@
 
 		/* wait for previous close (if any) to finish */
 
-		HE_SPIN_LOCK(he_dev, flags);
-		while(he_readl(he_dev, RCC_STAT) & RCC_BUSY)
-		{
+		spin_lock_irqsave(&he_dev->global_lock, flags);
+		while (he_readl(he_dev, RCC_STAT) & RCC_BUSY) {
 			HPRINTK("close cid 0x%x RCC_BUSY\n", cid);
 			udelay(250);
 		}
@@ -2804,7 +2594,7 @@
 		(void) he_readl_rsr0(he_dev, cid);
 #endif
 		he_writel_mbox(he_dev, cid, RXCON_CLOSE);
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 		timeout = schedule_timeout(30*HZ);
 
@@ -2814,15 +2604,11 @@
 		if (timeout == 0)
 			hprintk("close rx timeout cid 0x%x\n", cid);
 
-#ifndef USE_HE_FIND_VCC
-		HE_LOOKUP_VCC(he_dev, cid) = NULL;
-#endif
 		HPRINTK("close rx cid 0x%x complete\n", cid);
 
 	}
 
-	if (vcc->qos.txtp.traffic_class != ATM_NONE)
-	{
+	if (vcc->qos.txtp.traffic_class != ATM_NONE) {
 		volatile unsigned tsr4, tsr0;
 		int timeout;
 
@@ -2837,31 +2623,30 @@
 		 * TBRQ, the host issues the close command to the adapter.
 		 */
 
-		while (((tx_inuse = atomic_read(&vcc->sk->wmem_alloc)) > 0)
-							&& (retry < MAX_RETRY))
-		{
+		while (((tx_inuse = atomic_read(&vcc->sk->wmem_alloc)) > 0) &&
+		       (retry < MAX_RETRY)) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			(void) schedule_timeout(sleep);
 			set_current_state(TASK_RUNNING);
-			if (sleep < HZ) sleep = sleep * 2;
+			if (sleep < HZ)
+				sleep = sleep * 2;
 
 			++retry;
 		}
 
-		if (tx_inuse) hprintk("close tx cid 0x%x tx_inuse = %d\n",
-								cid, tx_inuse);
+		if (tx_inuse)
+			hprintk("close tx cid 0x%x tx_inuse = %d\n", cid, tx_inuse);
 
 		/* 2.3.1.1 generic close operations with flush */
 
-		HE_SPIN_LOCK(he_dev, flags);
+		spin_lock_irqsave(&he_dev->global_lock, flags);
 		he_writel_tsr4_upper(he_dev, TSR4_FLUSH_CONN, cid);
 					/* also clears TSR4_SESSION_ENDED */
 #ifdef CONFIG_IA64_SGI_SN2
 		(void) he_readl_tsr4(he_dev, cid);
 #endif
 
-		switch(vcc->qos.txtp.traffic_class)
-		{
+		switch (vcc->qos.txtp.traffic_class) {
 			case ATM_UBR:
 				he_writel_tsr1(he_dev, 
 					TSR1_MCR(rate_to_atmf(200000))
@@ -2872,10 +2657,8 @@
 				break;
 		}
 
-
 		tpd = __alloc_tpd(he_dev);
-		if (tpd == NULL)
-		{
+		if (tpd == NULL) {
 			hprintk("close tx he_alloc_tpd failed cid 0x%x\n", cid);
 			goto close_tx_incomplete;
 		}
@@ -2887,37 +2670,33 @@
 		add_wait_queue(&he_vcc->tx_waitq, &wait);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		__enqueue_tpd(he_dev, tpd, cid);
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 		timeout = schedule_timeout(30*HZ);
 
 		remove_wait_queue(&he_vcc->tx_waitq, &wait);
 		set_current_state(TASK_RUNNING);
 
-		if (timeout == 0)
-		{
+		spin_lock_irqsave(&he_dev->global_lock, flags);
+
+		if (timeout == 0) {
 			hprintk("close tx timeout cid 0x%x\n", cid);
 			goto close_tx_incomplete;
 		}
 
-		HE_SPIN_LOCK(he_dev, flags);
-		while (!((tsr4 = he_readl_tsr4(he_dev, cid))
-							& TSR4_SESSION_ENDED))
-		{
+		while (!((tsr4 = he_readl_tsr4(he_dev, cid)) & TSR4_SESSION_ENDED)) {
 			HPRINTK("close tx cid 0x%x !TSR4_SESSION_ENDED (tsr4 = 0x%x)\n", cid, tsr4);
 			udelay(250);
 		}
 
-		while (TSR0_CONN_STATE(tsr0 = he_readl_tsr0(he_dev, cid)) != 0)
-		{
+		while (TSR0_CONN_STATE(tsr0 = he_readl_tsr0(he_dev, cid)) != 0) {
 			HPRINTK("close tx cid 0x%x TSR0_CONN_STATE != 0 (tsr0 = 0x%x)\n", cid, tsr0);
 			udelay(250);
 		}
 
 close_tx_incomplete:
 
-		if (vcc->qos.txtp.traffic_class == ATM_CBR)
-		{
+		if (vcc->qos.txtp.traffic_class == ATM_CBR) {
 			int reg = he_vcc->rc_index;
 
 			HPRINTK("cs_stper reg = %d\n", reg);
@@ -2929,18 +2708,14 @@
 
 			he_dev->total_bw -= he_dev->cs_stper[reg].pcr;
 		}
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 		HPRINTK("close tx cid 0x%x complete\n", cid);
 	}
 
 	kfree(he_vcc);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-	vcc->flags &= ~ATM_VF_ADDR;
-#else
 	clear_bit(ATM_VF_ADDR, &vcc->flags);
-#endif
 }
 
 static int
@@ -2969,66 +2744,51 @@
 	HPRINTK("send %d.%d\n", vcc->vpi, vcc->vci);
 
 	if ((skb->len > HE_TPD_BUFSIZE) ||
-		((vcc->qos.aal == ATM_AAL0) && (skb->len != ATM_AAL0_SDU)))
-	{
+	    ((vcc->qos.aal == ATM_AAL0) && (skb->len != ATM_AAL0_SDU))) {
 		hprintk("buffer too large (or small) -- %d bytes\n", skb->len );
 		if (vcc->pop)
 			vcc->pop(vcc, skb);
 		else
 			dev_kfree_skb_any(skb);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-		++vcc->stats->tx_err;
-#else
 		atomic_inc(&vcc->stats->tx_err);
-#endif
 		return -EINVAL;
 	}
 
 #ifndef USE_SCATTERGATHER
-	if (skb_shinfo(skb)->nr_frags)
-	{
-		hprintk1("no scatter/gather support\n");
+	if (skb_shinfo(skb)->nr_frags) {
+		hprintk("no scatter/gather support\n");
 		if (vcc->pop)
 			vcc->pop(vcc, skb);
 		else
 			dev_kfree_skb_any(skb);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-		++vcc->stats->tx_err;
-#else
 		atomic_inc(&vcc->stats->tx_err);
-#endif
 		return -EINVAL;
 	}
 #endif
-	HE_SPIN_LOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
 
 	tpd = __alloc_tpd(he_dev);
-	if (tpd == NULL)
-	{
+	if (tpd == NULL) {
 		if (vcc->pop)
 			vcc->pop(vcc, skb);
 		else
 			dev_kfree_skb_any(skb);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-		++vcc->stats->tx_err;
-#else
 		atomic_inc(&vcc->stats->tx_err);
-#endif
-		HE_SPIN_UNLOCK(he_dev, flags);
+		spin_unlock_irqrestore(&he_dev->global_lock, flags);
 		return -ENOMEM;
 	}
 
 	if (vcc->qos.aal == ATM_AAL5)
 		tpd->status |= TPD_CELLTYPE(TPD_USERCELL);
-	else
-	{
+	else {
 		char *pti_clp = (void *) (skb->data + 3);
 		int clp, pti;
 
 		pti = (*pti_clp & ATM_HDR_PTI_MASK) >> ATM_HDR_PTI_SHIFT; 
 		clp = (*pti_clp & ATM_HDR_CLP);
 		tpd->status |= TPD_CELLTYPE(pti);
-		if (clp) tpd->status |= TPD_CLP;
+		if (clp)
+			tpd->status |= TPD_CLP;
 
 		skb_pull(skb, ATM_AAL0_SDU - ATM_CELL_PAYLOAD);
 	}
@@ -3039,12 +2799,10 @@
 	tpd->iovec[slot].len = skb->len - skb->data_len;
 	++slot;
 
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-	{
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		if (slot == TPD_MAXIOV)		/* send tpd; start new tpd */
-		{
+		if (slot == TPD_MAXIOV) {	/* queue tpd; start new tpd */
 			tpd->vcc = vcc;
 			tpd->skb = NULL;	/* not the last fragment
 						   so dont ->push() yet */
@@ -3052,18 +2810,13 @@
 
 			__enqueue_tpd(he_dev, tpd, cid);
 			tpd = __alloc_tpd(he_dev);
-			if (tpd == NULL)
-			{
+			if (tpd == NULL) {
 				if (vcc->pop)
 					vcc->pop(vcc, skb);
 				else
 					dev_kfree_skb_any(skb);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-				++vcc->stats->tx_err;
-#else
 				atomic_inc(&vcc->stats->tx_err);
-				HE_SPIN_UNLOCK(he_dev, flags);
-#endif
+				spin_unlock_irqrestore(&he_dev->global_lock, flags);
 				return -ENOMEM;
 			}
 			tpd->status |= TPD_USERCELL;
@@ -3078,7 +2831,7 @@
 
 	}
 
-	tpd->iovec[slot-1].len |= TPD_LST;
+	tpd->iovec[slot - 1].len |= TPD_LST;
 #else
 	tpd->address0 = pci_map_single(he_dev->pci_dev, skb->data, skb->len, PCI_DMA_TODEVICE);
 	tpd->length0 = skb->len | TPD_LST;
@@ -3091,13 +2844,9 @@
 	ATM_SKB(skb)->vcc = vcc;
 
 	__enqueue_tpd(he_dev, tpd, cid);
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-	++vcc->stats->tx;
-#else
 	atomic_inc(&vcc->stats->tx);
-#endif
 
 	return 0;
 }
@@ -3110,16 +2859,15 @@
 	struct he_ioctl_reg reg;
 	int err = 0;
 
-	switch (cmd)
-	{
+	switch (cmd) {
 		case HE_GET_REG:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
+			if (!capable(CAP_NET_ADMIN))
+				return -EPERM;
 
 			copy_from_user(&reg, (struct he_ioctl_reg *) arg,
 						sizeof(struct he_ioctl_reg));
-			HE_SPIN_LOCK(he_dev, flags);
-			switch (reg.type)
-			{
+			spin_lock_irqsave(&he_dev->global_lock, flags);
+			switch (reg.type) {
 				case HE_REGTYPE_PCI:
 					reg.val = he_readl(he_dev, reg.addr);
 					break;
@@ -3139,8 +2887,9 @@
 					err = -EINVAL;
 					break;
 			}
-			HE_SPIN_UNLOCK(he_dev, flags);
-			if (err == 0) copy_to_user((struct he_ioctl_reg *) arg, &reg,
+			spin_unlock_irqrestore(&he_dev->global_lock, flags);
+			if (err == 0)
+				copy_to_user((struct he_ioctl_reg *) arg, &reg,
 							sizeof(struct he_ioctl_reg));
 			break;
 		default:
@@ -3148,7 +2897,7 @@
 			if (atm_dev->phy && atm_dev->phy->ioctl)
 				err = atm_dev->phy->ioctl(atm_dev, cmd, arg);
 #else /* CONFIG_ATM_HE_USE_SUNI */
-			return -EINVAL;
+			err = -EINVAL;
 #endif /* CONFIG_ATM_HE_USE_SUNI */
 			break;
 	}
@@ -3164,15 +2913,15 @@
 
 	HPRINTK("phy_put(val 0x%x, addr 0x%lx)\n", val, addr);
 
-	HE_SPIN_LOCK(he_dev, flags);
-        he_writel(he_dev, val, FRAMER + (addr*4));
+	spin_lock_irqsave(&he_dev->global_lock, flags);
+	he_writel(he_dev, val, FRAMER + (addr*4));
 #ifdef CONFIG_IA64_SGI_SN2
 	(void) he_readl(he_dev, FRAMER + (addr*4));
 #endif
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 }
  
-        
+	
 static unsigned char
 he_phy_get(struct atm_dev *atm_dev, unsigned long addr)
 { 
@@ -3180,9 +2929,9 @@
 	struct he_dev *he_dev = HE_DEV(atm_dev);
 	unsigned reg;
 
-	HE_SPIN_LOCK(he_dev, flags);
-        reg = he_readl(he_dev, FRAMER + (addr*4));
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
+	reg = he_readl(he_dev, FRAMER + (addr*4));
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 	HPRINTK("phy_get(addr 0x%lx) =0x%x\n", addr, reg);
 	return reg;
@@ -3197,7 +2946,7 @@
 #ifdef notdef
 	struct he_rbrq *rbrq_tail;
 	struct he_tpdrq *tpdrq_head;
-        int rbpl_head, rbpl_tail;
+	int rbpl_head, rbpl_tail;
 #endif
 	static long mcc = 0, oec = 0, dcc = 0, cec = 0;
 
@@ -3213,12 +2962,12 @@
 	if (!left--)
 		return sprintf(page, "Mismatched Cells  VPI/VCI Not Open  Dropped Cells  RCM Dropped Cells\n");
 
-	HE_SPIN_LOCK(he_dev, flags);
+	spin_lock_irqsave(&he_dev->global_lock, flags);
 	mcc += he_readl(he_dev, MCC);
 	oec += he_readl(he_dev, OEC);
 	dcc += he_readl(he_dev, DCC);
 	cec += he_readl(he_dev, CEC);
-	HE_SPIN_UNLOCK(he_dev, flags);
+	spin_unlock_irqrestore(&he_dev->global_lock, flags);
 
 	if (!left--)
 		return sprintf(page, "%16ld  %16ld  %13ld  %17ld\n\n", 
@@ -3242,11 +2991,12 @@
 
 
 #ifdef notdef
-        rbpl_head = RBPL_MASK(he_readl(he_dev, G0_RBPL_S));
-        rbpl_tail = RBPL_MASK(he_readl(he_dev, G0_RBPL_T));
+	rbpl_head = RBPL_MASK(he_readl(he_dev, G0_RBPL_S));
+	rbpl_tail = RBPL_MASK(he_readl(he_dev, G0_RBPL_T));
 
 	inuse = rbpl_head - rbpl_tail;
-	if (inuse < 0) inuse += CONFIG_RBPL_SIZE * sizeof(struct he_rbp);
+	if (inuse < 0)
+		inuse += CONFIG_RBPL_SIZE * sizeof(struct he_rbp);
 	inuse /= sizeof(struct he_rbp);
 
 	if (!left--)
@@ -3287,32 +3037,31 @@
 	he_writel(he_dev, val, HOST_CNTL);
        
 	/* Send READ instruction */
-	for (i=0; i<sizeof(readtab)/sizeof(readtab[0]); i++) {
+	for (i = 0; i < sizeof(readtab)/sizeof(readtab[0]); i++) {
 		he_writel(he_dev, val | readtab[i], HOST_CNTL);
 		udelay(EEPROM_DELAY);
 	}
        
-        /* Next, we need to send the byte address to read from */
-	for (i=7; i>=0; i--) {
+	/* Next, we need to send the byte address to read from */
+	for (i = 7; i >= 0; i--) {
 		he_writel(he_dev, val | clocktab[j++] | (((addr >> i) & 1) << 9), HOST_CNTL);
 		udelay(EEPROM_DELAY);
 		he_writel(he_dev, val | clocktab[j++] | (((addr >> i) & 1) << 9), HOST_CNTL);
 		udelay(EEPROM_DELAY);
 	}
        
-	j=0;
+	j = 0;
 
 	val &= 0xFFFFF7FF;      /* Turn off write enable */
 	he_writel(he_dev, val, HOST_CNTL);
        
 	/* Now, we can read data from the EEPROM by clocking it in */
-	for (i=7; i>=0; i--) {
+	for (i = 7; i >= 0; i--) {
 		he_writel(he_dev, val | clocktab[j++], HOST_CNTL);
-	        udelay(EEPROM_DELAY);
-	        tmp_read = he_readl(he_dev, HOST_CNTL);
-	        byte_read |= (unsigned char)
-	                        ((tmp_read & ID_DOUT)
-	                         >> ID_DOFFSET << i);
+		udelay(EEPROM_DELAY);
+		tmp_read = he_readl(he_dev, HOST_CNTL);
+		byte_read |= (unsigned char)
+			   ((tmp_read & ID_DOUT) >> ID_DOFFSET << i);
 		he_writel(he_dev, val | clocktab[j++], HOST_CNTL);
 		udelay(EEPROM_DELAY);
 	}
@@ -3320,9 +3069,10 @@
 	he_writel(he_dev, val | ID_CS, HOST_CNTL);
 	udelay(EEPROM_DELAY);
 
-        return (byte_read);
+	return byte_read;
 }
 
+MODULE_LICENSE("GPL");
 MODULE_AUTHOR("chas williams <chas@cmf.nrl.navy.mil>");
 MODULE_DESCRIPTION("ForeRunnerHE ATM Adapter driver");
 MODULE_PARM(disable64, "h");
@@ -3338,82 +3088,28 @@
 MODULE_PARM(sdh, "i");
 MODULE_PARM_DESC(sdh, "use SDH framing (default 0)");
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,1)
 static struct pci_device_id he_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_FORE, PCI_DEVICE_ID_FORE_HE, PCI_ANY_ID, PCI_ANY_ID,
 	  0, 0, 0 },
-        { 0, }
+	{ 0, }
 };
 
 static struct pci_driver he_driver = {
 	.name =		"he",
 	.probe =	he_init_one,
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,9)
 	.remove =	__devexit_p(he_remove_one),
-#else
-	.remove =	he_remove_one,
-#endif
 	.id_table =	he_pci_tbl,
 };
 
 static int __init he_init(void)
 {
-        return pci_module_init(&he_driver);
+	return pci_module_init(&he_driver);
 }
 
 static void __exit he_cleanup(void)
 {
-        pci_unregister_driver(&he_driver);
+	pci_unregister_driver(&he_driver);
 }
 
 module_init(he_init);
 module_exit(he_cleanup);
-#else
-static int __init
-he_init()
-{
-	if (!pci_present())
-		return -EIO;
-
-#ifdef CONFIG_ATM_HE_USE_SUNI_MODULE
-	/* request_module("suni"); */
-#endif
-
-	pci_dev = NULL;
-	while ((pci_dev = pci_find_device(PCI_VENDOR_ID_FORE,
-					PCI_DEVICE_ID_FORE_HE, pci_dev)) != NULL)
-		if (he_init_one(pci_dev, NULL) == 0)
-			++ndevs;
-
-	return (ndevs ? 0 : -ENODEV);
-}
-
-static void __devexit
-he_cleanup(void)
-{
-	while (he_devs)
-	{
-		struct he_dev *next = he_devs->next;
-		he_stop(he_devs);
-		atm_dev_deregister(he_devs->atm_dev);
-		kfree(he_devs);
-
-		he_devs = next;
-	}
-
-}
-
-int init_module(void)
-{
-	return he_init();
-}
-
-void cleanup_module(void)
-{
-	he_cleanup();
-}
-#endif
-
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,7)
-MODULE_LICENSE("GPL");
-#endif
diff -Nru a/drivers/atm/he.h b/drivers/atm/he.h
--- a/drivers/atm/he.h	Wed Jun 25 14:35:48 2003
+++ b/drivers/atm/he.h	Wed Jun 25 14:35:48 2003
@@ -355,21 +355,24 @@
 	struct he_dev *next;
 };
 
+struct he_iovec
+{
+	u32 iov_base;
+	u32 iov_len;
+};
+
+#define HE_MAXIOV 20
+
 struct he_vcc
 {
-	struct iovec iov_head[32];
-	struct iovec *iov_tail;
+	struct he_iovec iov_head[HE_MAXIOV];
+	struct he_iovec *iov_tail;
 	int pdu_len;
 
 	int rc_index;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-	struct wait_queue *rx_waitq;
-	atruct wait_queue *tx_waitq;
-#else
 	wait_queue_head_t rx_waitq;
 	wait_queue_head_t tx_waitq;
-#endif
 };
 
 #define HE_VCC(vcc)	((struct he_vcc *)(vcc->dev_data))
