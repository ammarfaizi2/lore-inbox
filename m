Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTEIAra (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbTEIAra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:47:30 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:28563 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262271AbTEIArU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:47:20 -0400
Message-Id: <200305090058.h490wNGi006609@locutus.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, hch@infradead.org,
       romieu@fr.zoreil.com, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [PATCH] unbalanced exit path in Forerunner HE he_init_one() 
In-reply-to: Your message of "Thu, 08 May 2003 19:47:00 -0300."
             <20030508194700.C13069@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 08 May 2003 20:58:23 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch should make the he code a bit more palatable.  it drops any
of the < 2.3 support left over the good 'ole days and puts all the
compatibility code in a single place.

--- linux-2.5.68/drivers/atm/he.c.001	Thu May  8 16:26:44 2003
+++ linux-2.5.68/drivers/atm/he.c	Thu May  8 17:43:30 2003
@@ -96,16 +96,30 @@
 #define USE_TPD_POOL
 /* #undef CONFIG_ATM_HE_USE_SUNI */
 
-/* 2.2 kernel support */
+/* compatibility */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,43)
-#define dev_kfree_skb_irq(skb)		dev_kfree_skb(skb)
-#define dev_kfree_skb_any(skb)		dev_kfree_skb(skb)
-#undef USE_TASKLET
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,69)
+typedef void irqreturn_t;
+#define IRQ_NONE
+#define IRQ_HANDLED
+#define IRQ_RETVAL(x)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,18)
-#define set_current_state(x)		current->state = (x);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,9)
+#define __devexit_p(func)		func
+#endif
+
+#ifndef MODULE_LICENSE
+#define MODULE_LICENSE(x)
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,3)
+#define pci_set_drvdata(pci_dev, data)	(pci_dev)->driver_data = (data)
+#define pci_get_drvdata(pci_dev)	(pci_dev)->driver_data
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,44)
+#define pci_pool_create(a, b, c, d, e)	pci_pool_create(a, b, c, d, e, SLAB_KERNEL)
 #endif
 
 #include "he.h"
@@ -135,11 +149,7 @@
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
@@ -357,9 +367,7 @@
 
 	printk(KERN_INFO "he: %s\n", version);
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,43)
 	if (pci_enable_device(pci_dev)) return -EIO;
-#endif
 	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0)
 	{
 		printk(KERN_WARNING "he: no suitable dma available\n");
@@ -368,11 +376,7 @@
 
 	atm_dev = atm_dev_register(DEV_LABEL, &he_ops, -1, 0);
 	if (!atm_dev) return -ENODEV;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)
 	pci_set_drvdata(pci_dev, atm_dev);
-#else
-	pci_dev->driver_data = atm_dev;
-#endif
 
 	he_dev = (struct he_dev *) kmalloc(sizeof(struct he_dev),
 							GFP_KERNEL);
@@ -403,11 +407,7 @@
 	struct atm_dev *atm_dev;
 	struct he_dev *he_dev;
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)
 	atm_dev = pci_get_drvdata(pci_dev);
-#else
-	atm_dev = pci_dev->driver_data;
-#endif
 	he_dev = HE_DEV(atm_dev);
 
 	/* need to remove from he_devs */
@@ -416,11 +416,7 @@
 	atm_dev_deregister(atm_dev);
 	kfree(he_dev);
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)
 	pci_set_drvdata(pci_dev, NULL);
-#else
-	pci_dev->driver_data = NULL;
-#endif
 }
 
 
@@ -783,13 +779,8 @@
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
 	if (he_dev->rbps_pool == NULL)
 	{
 		hprintk("unable to create rbps pages\n");
@@ -855,13 +846,8 @@
 
 	/* large buffer pool */
 #ifdef USE_RBPL_POOL
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,44)
-	he_dev->rbpl_pool = pci_pool_create("rbpl", he_dev->pci_dev,
-			CONFIG_RBPL_BUFSIZE, 8, 0, SLAB_KERNEL);
-#else
 	he_dev->rbpl_pool = pci_pool_create("rbpl", he_dev->pci_dev,
 			CONFIG_RBPL_BUFSIZE, 8, 0);
-#endif
 	if (he_dev->rbpl_pool == NULL)
 	{
 		hprintk("unable to create rbpl pool\n");
@@ -1053,11 +1039,7 @@
         he_dev = HE_DEV(dev);
         pci_dev = he_dev->pci_dev;
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,3)
 	he_dev->membase = pci_dev->resource[0].start;
-#else
-	he_dev->membase = pci_dev->base_address[0] & PCI_BASE_ADDRESS_MEM_MASK;
-#endif
 	HPRINTK("membase = 0x%lx  irq = %d.\n", he_dev->membase, pci_dev->irq);
 
 	/*
@@ -1519,13 +1501,8 @@
 	he_init_tpdrq(he_dev);
 
 #ifdef USE_TPD_POOL
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,44)
-	he_dev->tpd_pool = pci_pool_create("tpd", he_dev->pci_dev,
-		sizeof(struct he_tpd), TPD_ALIGNMENT, 0, SLAB_KERNEL);
-#else
 	he_dev->tpd_pool = pci_pool_create("tpd", he_dev->pci_dev,
 		sizeof(struct he_tpd), TPD_ALIGNMENT, 0);
-#endif
 	if (he_dev->tpd_pool == NULL)
 	{
 		hprintk("unable to create tpd pci_pool\n");
@@ -1919,11 +1896,7 @@
 		if (RBRQ_HBUF_ERR(he_dev->rbrq_head))
 		{
 			hprintk("HBUF_ERR!  (cid 0x%x)\n", cid);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-				++vcc->stats->rx_drop;
-#else
 				atomic_inc(&vcc->stats->rx_drop);
-#endif
 			goto return_host_buffers;
 		}
 
@@ -1958,27 +1931,12 @@
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
 		if (!skb)
 		{
 			HPRINTK("charge failed (%d.%d)\n", vcc->vpi, vcc->vci);
@@ -2035,11 +1993,7 @@
 #endif
 		vcc->push(vcc, skb);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-		++vcc->stats->rx;
-#else
 		atomic_inc(&vcc->stats->rx);
-#endif
 
 return_host_buffers:
 		++pdus_assembled;
@@ -2355,11 +2309,7 @@
 #endif
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,69)
 static irqreturn_t
-#else
-static void
-#endif
 he_irq_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long flags;
@@ -2367,11 +2317,7 @@
 	int handled = 0;
 
 	if (he_dev == NULL)
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,69)
 		return IRQ_NONE;
-#else
-		return;
-#endif
 
 	HE_SPIN_LOCK(he_dev, flags);
 
@@ -2406,11 +2352,7 @@
 #endif
 	}
 	HE_SPIN_UNLOCK(he_dev, flags);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,69)
 	return IRQ_RETVAL(handled);
-#else
-	return;
-#endif
 
 }
 
@@ -2454,11 +2396,7 @@
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
@@ -2509,11 +2447,7 @@
 
 	HPRINTK("open vcc %p %d.%d\n", vcc, vpi, vci);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-	vcc->flags |= ATM_VF_ADDR;
-#else
 	set_bit(ATM_VF_ADDR, &vcc->flags);
-#endif
 
 	cid = he_mkcid(he_dev, vpi, vci);
 
@@ -2528,13 +2462,8 @@
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
 
@@ -2729,20 +2658,10 @@
 	if (err)
 	{
 		if (he_vcc) kfree(he_vcc);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-		vcc->flags &= ~ATM_VF_ADDR;
-#else
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
@@ -2751,11 +2670,7 @@
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
@@ -2765,11 +2680,7 @@
 
 	HPRINTK("close vcc %p %d.%d\n", vcc, vcc->vpi, vcc->vci);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-	vcc->flags &= ~ATM_VF_READY;
-#else
 	clear_bit(ATM_VF_READY, &vcc->flags);
-#endif
 	cid = he_mkcid(he_dev, vcc->vpi, vcc->vci);
 
 	if (vcc->qos.rxtp.traffic_class != ATM_NONE)
@@ -2929,11 +2840,7 @@
 
 	kfree(he_vcc);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-	vcc->flags &= ~ATM_VF_ADDR;
-#else
 	clear_bit(ATM_VF_ADDR, &vcc->flags);
-#endif
 }
 
 static int
@@ -2969,11 +2876,7 @@
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
 
@@ -2985,11 +2888,7 @@
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
@@ -3002,11 +2901,7 @@
 			vcc->pop(vcc, skb);
 		else
 			dev_kfree_skb_any(skb);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-		++vcc->stats->tx_err;
-#else
 		atomic_inc(&vcc->stats->tx_err);
-#endif
 		HE_SPIN_UNLOCK(he_dev, flags);
 		return -ENOMEM;
 	}
@@ -3051,12 +2946,8 @@
 					vcc->pop(vcc, skb);
 				else
 					dev_kfree_skb_any(skb);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-				++vcc->stats->tx_err;
-#else
 				atomic_inc(&vcc->stats->tx_err);
 				HE_SPIN_UNLOCK(he_dev, flags);
-#endif
 				return -ENOMEM;
 			}
 			tpd->status |= TPD_USERCELL;
@@ -3086,11 +2977,7 @@
 	__enqueue_tpd(he_dev, tpd, cid);
 	HE_SPIN_UNLOCK(he_dev, flags);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,99)
-	++vcc->stats->tx;
-#else
 	atomic_inc(&vcc->stats->tx);
-#endif
 
 	return 0;
 }
@@ -3316,6 +3203,7 @@
         return (byte_read);
 }
 
+MODULE_LICENSE("GPL");
 MODULE_AUTHOR("chas williams <chas@cmf.nrl.navy.mil>");
 MODULE_DESCRIPTION("ForeRunnerHE ATM Adapter driver");
 MODULE_PARM(disable64, "h");
@@ -3331,7 +3219,6 @@
 MODULE_PARM(sdh, "i");
 MODULE_PARM_DESC(sdh, "use SDH framing (default 0)");
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,1)
 static struct pci_device_id he_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_FORE, PCI_DEVICE_ID_FORE_HE, PCI_ANY_ID, PCI_ANY_ID,
 	  0, 0, 0 },
@@ -3341,11 +3228,7 @@
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
 
@@ -3361,52 +3244,3 @@
 
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
--- linux-2.5.68/drivers/atm/he.h.001	Thu May  8 20:04:51 2003
+++ linux-2.5.68/drivers/atm/he.h	Thu May  8 17:38:59 2003
@@ -371,13 +371,8 @@
 
 	int rc_index;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-	struct wait_queue *rx_waitq;
-	struct wait_queue *tx_waitq;
-#else
 	wait_queue_head_t rx_waitq;
 	wait_queue_head_t tx_waitq;
-#endif
 };
 
 #define HE_VCC(vcc)	((struct he_vcc *)(vcc->dev_data))
