Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVL2XYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVL2XYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVL2XYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:24:14 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:20544 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751156AbVL2XYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:24:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=PR1eBJ/03bxF7P7s2a5Z5cpCiMDMyUxD4a0+eUpsWAmU/ey1yAhvE4SgATEGkillWDOfvE+aOkydaliIEr1td0lAygcRnUKwuMZ2z2Rvwq6PKKOwLulKXdHlr53V26A3xQ09v8rwFhAErOVv3iVn2BGaEcjLYSlj5pHUJLlYxKw=
Message-ID: <355e5e5e0512291524s2c2fcc27g808ed4cb8c0ed008@mail.gmail.com>
Date: Thu, 29 Dec 2005 18:24:06 -0500
From: Lukasz Kosewski <lkosewsk@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.6.15-rc7-git3 3/3] sata_promise: a hotswap implementation using the new hotswap API
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7594_24531189.1135898646358"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7594_24531189.1135898646358
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

VGhpcyBwYXRjaCB1c2VzIHRoZSBob3Rzd2FwIEFQSSBpbiBwYXRjaCAwMiB0byBncmFudCB0aGUg
UHJvbWlzZQpTQVRBKElJKTE1MCBUeDQvVHgyIFBsdXMgY29udHJvbGxlcnMgaG90c3dhcHBpbmcg
cG93ZXJzLiAgQWxzbywgc29tZQpzaWxseSBpbnRlZ2VycyB3aGljaCBzaG91bGQgaGF2ZSBiZWVu
IHVuc2lnbmVkIGluIHBhdGNoIDAxIG5vdyBhcmUuCgpTaWduZWQtb2ZmLWJ5OiAgTHVrZSBLb3Nl
d3NraSA8bGtvc2V3c2tAZ21haWwuY29tPgoKTHVrZSBLb3Nld3NraQo=
------=_Part_7594_24531189.1135898646358
Content-Type: text/x-patch; 
	name=03-promise_hotswap_support-2.6.15-rc7-git3.diff; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="03-promise_hotswap_support-2.6.15-rc7-git3.diff"

29.12.05    Luke Kosewski   <lkosewsk@gmail.com>

	* A patch which uses the API in patch 02 in this series to give the
	  Promise SATA150 Tx4/Tx2 Plus and SATAII150 Tx4/Tx2 Plus controllers
	  drive hotswap.
	* Since I noticed a few places where unsigned and signed integers were
	  being cast around, this patch also changed all the signed integers in
	  question into unsigned ones.

	Signed-off-by:  Luke Kosewski <lkosewsk@gmail.com>

--- linux-2.6.15-rc7/drivers/scsi/sata_promise.c.old	2005-12-28 23:40:06.000000000 -0500
+++ linux-2.6.15-rc7/drivers/scsi/sata_promise.c	2005-12-29 16:21:55.000000000 -0500
@@ -85,7 +85,7 @@ struct pdc_port_priv {
 };
 
 struct pdc_host_priv {
-	int			hotplug_offset;
+	unsigned int		hotplug_offset;
 };
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -346,10 +346,36 @@ static void pdc_reset_port(struct ata_po
 	readl(mmio);	/* flush */
 }
 
+/* Mask/unmask hotplug interrupts for one channel (ap) */
+static void pdc_chan_hot_status(struct ata_port *ap, int enable)
+{
+	struct pdc_host_priv *hp = ap->host_set->private_data;
+	void *mmio = ap->host_set->mmio_base + hp->hotplug_offset;
+	u8 maskflags;
+
+	if (enable) {
+		/* Clear channel hotplug interrupts */
+		maskflags = readb(mmio);
+		maskflags |= (0x11 << ap->hard_port_no);
+		writeb(maskflags, mmio);
+	}
+
+	maskflags = readb(mmio + 2);
+	if (enable) /* Unmask channel hotplug interrupts */
+		maskflags &= ~(0x11 << ap->hard_port_no);
+	else /* Mask */
+		maskflags |= (0x11 << ap->hard_port_no);
+
+	writeb(maskflags, mmio + 2);
+}
+
 static void pdc_sata_phy_reset(struct ata_port *ap)
 {
 	pdc_reset_port(ap);
+
+	pdc_chan_hot_status(ap, 0);
 	sata_phy_reset(ap);
+	pdc_chan_hot_status(ap, 1);
 }
 
 static void pdc_pata_phy_reset(struct ata_port *ap)
@@ -497,11 +523,13 @@ static void pdc_irq_clear(struct ata_por
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
+	struct pdc_host_priv *hp = host_set->private_data;
 	struct ata_port *ap;
 	u32 mask = 0;
 	unsigned int i, tmp;
-	unsigned int handled = 0;
+	unsigned int handled = 0, hotplug_offset = hp->hotplug_offset;
 	void __iomem *mmio_base;
+	u8 plugdata, maskflags;
 
 	VPRINTK("ENTER\n");
 
@@ -525,7 +553,7 @@ static irqreturn_t pdc_interrupt (int ir
 	mask &= 0xffff;		/* only 16 tags possible */
 	if (!mask) {
 		VPRINTK("QUICK EXIT 3\n");
-		goto done_irq;
+		goto try_hotplug;
 	}
 
 	writel(mask, mmio_base + PDC_INT_SEQMASK);
@@ -544,9 +572,27 @@ static irqreturn_t pdc_interrupt (int ir
 		}
 	}
 
-	VPRINTK("EXIT\n");
+try_hotplug:
+	plugdata = readb(mmio_base + hotplug_offset);
+	maskflags = readb(mmio_base + hotplug_offset + 2);
+	plugdata &= ~maskflags;
+	if (plugdata) {
+		writeb(plugdata, mmio_base + hotplug_offset);
+		for (i = 0; i < host_set->n_ports; ++i) {
+			ap = host_set->ports[i];
+			if (!(ap->flags & ATA_FLAG_SATA))
+				continue; /* No PATA support here... continue */
+			if (plugdata & 0x1) /* Check unplug flag */
+				sata_hot_unplug(ap);
+			if ((plugdata >> 4) & 0x1) /* Check plug flag */
+				sata_hot_plug(ap);
+			plugdata >>= 1;
+		}
+		handled = 1;
+	}
+
+	VPRINTK("EXIT 4\n");
 
-done_irq:
 	spin_unlock(&host_set->lock);
 	return IRQ_RETVAL(handled);
 }
@@ -626,7 +672,7 @@ static void pdc_host_init(unsigned int c
 {
 	void __iomem *mmio = pe->mmio_base;
 	struct pdc_host_priv *hp = pe->private_data;
-	int hotplug_offset = hp->hotplug_offset;
+	unsigned int hotplug_offset = hp->hotplug_offset;
 	u32 tmp;
 
 	/*
@@ -644,9 +690,9 @@ static void pdc_host_init(unsigned int c
 	tmp = readl(mmio + hotplug_offset);
 	writel(tmp | 0xff, mmio + hotplug_offset);
 
-	/* mask plug/unplug ints */
+	/* unmask plug/unplug ints */
 	tmp = readl(mmio + hotplug_offset);
-	writel(tmp | 0xff0000, mmio + hotplug_offset);
+	writel(tmp & ~0xff0000, mmio + hotplug_offset);
 
 	/* reduce TBG clock to 133 Mhz. */
 	tmp = readl(mmio + PDC_TBG_MODE);


------=_Part_7594_24531189.1135898646358--
