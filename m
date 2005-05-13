Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVEMWMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVEMWMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVEMWKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:10:50 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:61344 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262569AbVEMWKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:10:00 -0400
Message-Id: <20050513220225.655149000@abc>
References: <20050513220019.907667000@abc>
Date: Sat, 14 May 2005 00:00:25 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-flexcop-irq-fix.patch
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: [DVB patch 06/11] flexcop: fixed interrupt-sharing
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fixed interrupt-sharing and added a spinlock to the irq-callback
(thanks to Pascal Riekenberg)

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/b2c2/flexcop-pci.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-pci.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-pci.c	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-pci.c	2005-05-12 01:30:40.000000000 +0200
@@ -53,6 +53,8 @@ struct flexcop_pci {
 	int active_dma1_addr; /* 0 = addr0 of dma1; 1 = addr1 of dma1 */
 	u32 last_dma1_cur_pos; /* position of the pointer last time the timer/packet irq occured */
 
+	spinlock_t irq_lock;
+
 	struct flexcop_device *fc_dev;
 };
 
@@ -93,6 +95,9 @@ static irqreturn_t flexcop_pci_irq(int i
 	struct flexcop_pci *fc_pci = dev_id;
 	struct flexcop_device *fc = fc_pci->fc_dev;
 	flexcop_ibi_value v = fc->read_ibi_reg(fc,irq_20c);
+	irqreturn_t ret = IRQ_HANDLED;
+
+	spin_lock_irq(&fc_pci->irq_lock);
 
 	deb_irq("irq: %08x cur_addr: %08x (%d), our addrs. 1: %08x 2: %08x; 0x000: "
 			"%08x, 0x00c: %08x\n",v.raw,
@@ -102,6 +107,7 @@ static irqreturn_t flexcop_pci_irq(int i
 			fc->read_ibi_reg(fc,dma1_000).raw,
 			fc->read_ibi_reg(fc,dma1_00c).raw);
 
+
 	if (v.irq_20c.DMA1_IRQ_Status == 1) {
 		if (fc_pci->active_dma1_addr == 0)
 			flexcop_pass_dmx_packets(fc_pci->fc_dev,fc_pci->dma[0].cpu_addr0,fc_pci->dma[0].size / 188);
@@ -134,14 +140,17 @@ static irqreturn_t flexcop_pci_irq(int i
 		}
 
 		fc_pci->last_dma1_cur_pos = cur_pos;
-	}
+	} else
+		ret = IRQ_NONE;
+
+	spin_unlock_irq(&fc_pci->irq_lock);
 
 /* packet count would be ideal for hw filtering, but it isn't working. Either
  * the data book is wrong, or I'm unable to read it correctly */
 
 /*	if (v.irq_20c.DMA1_Size_IRQ_Status == 1) { packet counter */
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int flexcop_pci_stream_control(struct flexcop_device *fc, int onoff)
@@ -240,6 +249,8 @@ static int flexcop_pci_init(struct flexc
 					SA_SHIRQ, DRIVER_NAME, fc_pci)) != 0)
 		goto err_pci_iounmap;
 
+	spin_lock_init(&fc_pci->irq_lock);
+
 	fc_pci->init_state |= FC_PCI_INIT;
 	goto success;
 

--

