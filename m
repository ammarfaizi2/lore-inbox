Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVJ2Fis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVJ2Fis (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVJ2Fis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:38:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9129 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751130AbVJ2Fir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:38:47 -0400
Date: Sat, 29 Oct 2005 06:38:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] sata_sil24 iomem annotations and fixes
Message-ID: <20051029053844.GY7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	trivial iomem annotations + missing memcpy_fromio() caught by
those
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/drivers/scsi/sata_sil24.c current/drivers/scsi/sata_sil24.c
--- RC14-base/drivers/scsi/sata_sil24.c	2005-10-28 18:17:09.000000000 -0400
+++ current/drivers/scsi/sata_sil24.c	2005-10-28 22:23:58.000000000 -0400
@@ -220,8 +220,8 @@
 
 /* ap->host_set->private_data */
 struct sil24_host_priv {
-	void *host_base;	/* global controller control (128 bytes @BAR0) */
-	void *port_base;	/* port registers (4 * 8192 bytes @BAR2) */
+	void __iomem *host_base;	/* global controller control (128 bytes @BAR0) */
+	void __iomem *port_base;	/* port registers (4 * 8192 bytes @BAR2) */
 };
 
 static u8 sil24_check_status(struct ata_port *ap);
@@ -349,10 +349,12 @@
 static inline void sil24_update_tf(struct ata_port *ap)
 {
 	struct sil24_port_priv *pp = ap->private_data;
-	void *port = (void *)ap->ioaddr.cmd_addr;
-	struct sil24_prb *prb = port;
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct sil24_prb __iomem *prb = port;
+	u8 fis[6 * 4];
 
-	ata_tf_from_fis(prb->fis, &pp->tf);
+	memcpy_fromio(fis, prb->fis, 6 * 4);
+	ata_tf_from_fis(fis, &pp->tf);
 }
 
 static u8 sil24_check_status(struct ata_port *ap)
@@ -376,9 +378,9 @@
 
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg)
 {
-	void *scr_addr = (void *)ap->ioaddr.scr_addr;
+	void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
-		void *addr;
+		void __iomem *addr;
 		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
 		return readl(scr_addr + sil24_scr_map[sc_reg] * 4);
 	}
@@ -387,9 +389,9 @@
 
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 {
-	void *scr_addr = (void *)ap->ioaddr.scr_addr;
+	void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
-		void *addr;
+		void __iomem *addr;
 		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
 		writel(val, scr_addr + sil24_scr_map[sc_reg] * 4);
 	}
@@ -454,7 +456,7 @@
 static int sil24_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void *port = (void *)ap->ioaddr.cmd_addr;
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
 	dma_addr_t paddr = pp->cmd_block_dma + qc->tag * sizeof(*pp->cmd_block);
 
@@ -467,7 +469,7 @@
 	/* unused */
 }
 
-static int __sil24_reset_controller(void *port)
+static int __sil24_reset_controller(void __iomem *port)
 {
 	int cnt;
 	u32 tmp;
@@ -493,7 +495,7 @@
 {
 	printk(KERN_NOTICE DRV_NAME
 	       " ata%u: resetting controller...\n", ap->id);
-	if (__sil24_reset_controller((void *)ap->ioaddr.cmd_addr))
+	if (__sil24_reset_controller((void __iomem *)ap->ioaddr.cmd_addr))
                 printk(KERN_ERR DRV_NAME
                        " ata%u: failed to reset controller\n", ap->id);
 }
@@ -527,7 +529,7 @@
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	struct sil24_port_priv *pp = ap->private_data;
-	void *port = (void *)ap->ioaddr.cmd_addr;
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	u32 irq_stat, cmd_err, sstatus, serror;
 
 	irq_stat = readl(port + PORT_IRQ_STAT);
@@ -574,7 +576,7 @@
 static inline void sil24_host_intr(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
-	void *port = (void *)ap->ioaddr.cmd_addr;
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	u32 slot_stat;
 
 	slot_stat = readl(port + PORT_SLOT_STAT);
@@ -689,7 +691,8 @@
 	struct ata_port_info *pinfo = &sil24_port_info[board_id];
 	struct ata_probe_ent *probe_ent = NULL;
 	struct sil24_host_priv *hpriv = NULL;
-	void *host_base = NULL, *port_base = NULL;
+	void __iomem *host_base = NULL;
+	void __iomem *port_base = NULL;
 	int i, rc;
 
 	if (!printed_version++)
@@ -771,7 +774,7 @@
 	writel(0, host_base + HOST_CTRL);
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
-		void *port = port_base + i * PORT_REGS_SIZE;
+		void __iomem *port = port_base + i * PORT_REGS_SIZE;
 		unsigned long portu = (unsigned long)port;
 		u32 tmp;
 		int cnt;
