Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUFFOSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUFFOSS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 10:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUFFOSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 10:18:18 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:29852 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263665AbUFFOSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 10:18:13 -0400
Message-ID: <40C32770.8070704@colorfullife.com>
Date: Sun, 06 Jun 2004 16:17:20 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ktech@wanadoo.es
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 2.6.7-rc1 breaks forcedeth
References: <E1BWwTR-0003d0-I6@mb07.in.mad.eresmas.com>
In-Reply-To: <E1BWwTR-0003d0-I6@mb07.in.mad.eresmas.com>
Content-Type: multipart/mixed;
 boundary="------------050005040302080906030405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050005040302080906030405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ktech@wanadoo.es wrote:

>forcedeth: irq line 11, Status 0x       4, Mask 08x
>
>  
>
I can't type: The formatting rule for printk was wrong. I've attached an 
updated patch.

I have two ideas:
- try the attached patch. It won't fix your problem, but it might give 
us further hints.
- is it possible to disable on-board devices in the bios? I'd go back to 
2.6.7-rc1 (i.e. without my debug patches) and try a few combinations. 
Does usb work if ethernet is disabled? ethernet if usb is disabled? Does 
the board support network boot? What happens if you disable network boot 
(PXE)?

--
    Manfred

--------------050005040302080906030405
Content-Type: text/plain;
 name="patch-forcedeth-test"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-forcedeth-test"

--- 2.6/drivers/net/forcedeth.c	2004-05-10 04:31:59.000000000 +0200
+++ build-2.6/drivers/net/forcedeth.c	2004-06-06 16:09:42.960783872 +0200
@@ -1126,6 +1126,15 @@
 		writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
 		pci_push(base);
 		dprintk(KERN_DEBUG "%s: irq: %08x\n", dev->name, events);
+
+printk(KERN_ERR "forcedeth %s: got irq Status 0x%08x, Mask 0x%08x\n",
+				dev->name, readl(base + NvRegIrqStatus),
+				readl(base + NvRegIrqMask));
+		if (np->in_shutdown) {
+printk(KERN_ERR "forcedeth: irq while not running.\n");
+			break;
+		}
+
 		if (!(events & np->irqmask))
 			break;
 
@@ -1195,16 +1204,13 @@
 	enable_irq(dev->irq);
 }
 
-static int nv_open(struct net_device *dev)
+static void nv_reset(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
 	u8 *base = get_hwbase(dev);
-	int ret, oom, i;
 
-	dprintk(KERN_DEBUG "nv_open: begin\n");
+	writel(0, base + NvRegIrqMask);
+	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
 
-	/* 1) erase previous misconfiguration */
-	/* 4.1-1: stop adapter: ignored, 4.3 seems to be overkill */
 	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
 	writel(0, base + NvRegMulticastAddrB);
 	writel(0, base + NvRegMulticastMaskA);
@@ -1215,9 +1221,22 @@
 	writel(0, base + NvRegUnknownTransmitterReg);
 	nv_txrx_reset(dev);
 	writel(0, base + NvRegUnknownSetupReg6);
+	pci_push(base);
+}
+
+static int nv_open(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	u8 *base = get_hwbase(dev);
+	int ret, oom, i;
+
+	dprintk(KERN_DEBUG "nv_open: begin\n");
+
+	/* 1) erase previous misconfiguration */
+	/* 4.1-1: stop adapter: ignored, 4.3 seems to be overkill */
+	nv_reset(dev);
 
 	/* 2) initialize descriptor rings */
-	np->in_shutdown = 0;
 	oom = nv_init_ring(dev);
 
 	/* 3) set mac address */
@@ -1319,10 +1338,7 @@
 	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
 	pci_push(base);
 
-	ret = request_irq(dev->irq, &nv_nic_irq, SA_SHIRQ, dev->name, dev);
-	if (ret)
-		goto out_drain;
-
+	np->in_shutdown = 0;
 	writel(np->irqmask, base + NvRegIrqMask);
 
 	spin_lock_irq(&np->lock);
@@ -1506,6 +1522,11 @@
 	writel(0, base + NvRegWakeUpFlags);
 	np->wolenabled = 0;
 
+printk(KERN_ERR "forcedeth: irq line %d, Status 0x%08x, Mask 0x%08x\n",
+		       		pci_dev->irq, readl(base + NvRegIrqStatus),
+				readl(base + NvRegIrqMask));
+	nv_reset(dev);
+
 	np->tx_flags = cpu_to_le16(NV_TX_LASTPACKET|NV_TX_LASTPACKET1|NV_TX_VALID);
 	if (id->driver_data & DEV_NEED_LASTPACKET1)
 		np->tx_flags |= cpu_to_le16(NV_TX_LASTPACKET1);
@@ -1516,6 +1537,12 @@
 	if (id->driver_data & DEV_NEED_TIMERIRQ)
 		np->irqmask |= NVREG_IRQ_TIMER;
 
+	np->in_shutdown = 1;
+	err = request_irq(dev->irq, &nv_nic_irq, SA_SHIRQ, dev->name, dev);
+	if (err) {
+printk(KERN_ERR "forcedeth: Duh. request_irq failed.\n");
+	}
+
 	err = register_netdev(dev);
 	if (err) {
 		printk(KERN_INFO "forcedeth: unable to register netdev: %d\n", err);

--------------050005040302080906030405--
