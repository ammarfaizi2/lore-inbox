Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUFFIgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUFFIgy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUFFIgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:36:54 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:3738 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263093AbUFFIgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:36:33 -0400
Message-ID: <40C2D780.4010009@colorfullife.com>
Date: Sun, 06 Jun 2004 10:36:16 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: ktech@wanadoo.es, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.7-rc1 breaks forcedeth
References: <E1BWmws-0005aN-Nw@mb04.in.mad.eresmas.com> <Pine.LNX.4.58.0406051958150.7010@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406051958150.7010@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040503000303040408010009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040503000303040408010009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:

>I suspect that the driver should at the very least make sure to disable
>any potentially pending interrupts in the "nv_probe()" function. I have no 
>idea how to do that, but it looks like something like
>
>	writel(0, base + NvRegIrqMask);
>	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
>
>should probably do it. It would be better to reset the thing completely, 
>methinks, but whatever.
>
>  
>
I'll add that, but it's only a partial fix: what if ehci_hcd is loaded 
before the forcedeth driver?

Luis, could you apply the patch and boot with it? It should print 
something like

forcedeth: irq line 11, Status 0x00000020, Mask 0x00000020

If mask and status are really not zero, then it explains your problems. 
Additionally I try to reset the nic in nv_probe - there were a few 
reports seemed to indicate that the nic generates timer interrupts even 
if the mask is zero.

--
    Manfred

--------------040503000303040408010009
Content-Type: text/plain;
 name="patch-forcedeth-test"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-forcedeth-test"

--- 2.6/drivers/net/forcedeth.c	2004-05-10 04:31:59.000000000 +0200
+++ build-2.6/drivers/net/forcedeth.c	2004-06-06 10:31:43.826368991 +0200
@@ -1195,16 +1195,13 @@
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
@@ -1215,6 +1212,20 @@
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
 	np->in_shutdown = 0;
@@ -1506,6 +1517,11 @@
 	writel(0, base + NvRegWakeUpFlags);
 	np->wolenabled = 0;
 
+printk(KERN_ERR "forcedeth: irq line %d, Status 0x%8x, Mask %0x8x\n",
+		       		pci_dev->irq, readl(base + NvRegIrqStatus),
+				readl(base + NvRegIrqMask));
+	nv_reset(dev);
+
 	np->tx_flags = cpu_to_le16(NV_TX_LASTPACKET|NV_TX_LASTPACKET1|NV_TX_VALID);
 	if (id->driver_data & DEV_NEED_LASTPACKET1)
 		np->tx_flags |= cpu_to_le16(NV_TX_LASTPACKET1);

--------------040503000303040408010009--
