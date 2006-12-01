Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759297AbWLAJ5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759297AbWLAJ5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 04:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759300AbWLAJ5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 04:57:47 -0500
Received: from aun.it.uu.se ([130.238.12.36]:3251 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1759297AbWLAJ5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 04:57:46 -0500
Date: Fri, 1 Dec 2006 10:55:58 +0100 (MET)
Message-Id: <200612010955.kB19twqh002446@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2.6.19 1/3] sata_promise: PHYMODE4 fixup
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code to fix up the PHYMODE4 "align timing"
register value on second-generation Promise SATA chips.
Failure to correct this value on non-x86 machines makes
drive detection prone to failure due to timeouts. (I've
observed about 50% detection failure rates on SPARC64.)

The HW boots with a bad value in this register, but on x86
machines the Promise BIOS corrects it to the value recommended
by the manual, so most people have been unaffected by this issue.

After developing the patch I checked Promise's SATAII driver,
and discovered that it also corrects PHYMODE4 just like this
patch does.

This patch depends on the sata_promise SATAII updates
patch I sent recently.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

diff -rupN linux-2.6.19.sata_promise-1-genII-fixes/drivers/ata/sata_promise.c linux-2.6.19.sata_promise-2-PHYMODE4-fixup/drivers/ata/sata_promise.c
--- linux-2.6.19.sata_promise-1-genII-fixes/drivers/ata/sata_promise.c	2006-11-30 23:25:03.000000000 +0100
+++ linux-2.6.19.sata_promise-2-PHYMODE4-fixup/drivers/ata/sata_promise.c	2006-11-30 23:36:57.000000000 +0100
@@ -281,6 +281,7 @@ static struct pci_driver pdc_ata_pci_dri
 static int pdc_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
+	struct pdc_host_priv *hp = ap->host->private_data;
 	struct pdc_port_priv *pp;
 	int rc;
 
@@ -302,6 +303,16 @@ static int pdc_port_start(struct ata_por
 
 	ap->private_data = pp;
 
+	/* fix up PHYMODE4 align timing */
+	if ((hp->flags & PDC_FLAG_GEN_II) && sata_scr_valid(ap)) {
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;
+		unsigned int tmp;
+
+		tmp = readl(mmio + 0x014);
+		tmp = (tmp & ~3) | 1;	/* set bits 1:0 = 0:1 */
+		writel(tmp, mmio + 0x014);
+	}
+
 	return 0;
 
 err_out_kfree:
