Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUKODhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUKODhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbUKODgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:36:51 -0500
Received: from ozlabs.org ([203.10.76.45]:691 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261468AbUKOCj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:39:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16792.6126.561975.238024@cargo.ozlabs.ibm.com>
Date: Mon, 15 Nov 2004 13:43:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add __iomem annotations to drivers/scsi/mac53c94.c
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds __iomem annotations to drivers/scsi/mac53c94.c, and
changes one use of st_le32 to writel.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/scsi/mac53c94.c test-pmac/drivers/scsi/mac53c94.c
--- linux-2.5/drivers/scsi/mac53c94.c	2004-04-04 16:06:05.000000000 +1000
+++ test-pmac/drivers/scsi/mac53c94.c	2004-11-15 09:36:29.000000000 +1100
@@ -41,9 +41,9 @@
 };
 
 struct fsc_state {
-	struct	mac53c94_regs *regs;
+	struct	mac53c94_regs __iomem *regs;
 	int	intr;
-	struct	dbdma_regs *dma;
+	struct	dbdma_regs __iomem *dma;
 	int	dmaintr;
 	int	clk_freq;
 	struct	Scsi_Host *host;
@@ -106,10 +106,10 @@
 static int mac53c94_host_reset(struct scsi_cmnd *cmd)
 {
 	struct fsc_state *state = (struct fsc_state *) cmd->device->host->hostdata;
-	struct mac53c94_regs *regs = state->regs;
-	struct dbdma_regs *dma = state->dma;
+	struct mac53c94_regs __iomem *regs = state->regs;
+	struct dbdma_regs __iomem *dma = state->dma;
 
-	st_le32(&dma->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
+	writel((RUN|PAUSE|FLUSH|WAKE) << 16, &dma->control);
 	writeb(CMD_SCSI_RESET, &regs->command);	/* assert RST */
 	udelay(100);			/* leave it on for a while (>= 25us) */
 	writeb(CMD_RESET, &regs->command);
@@ -121,8 +121,8 @@
 
 static void mac53c94_init(struct fsc_state *state)
 {
-	struct mac53c94_regs *regs = state->regs;
-	struct dbdma_regs *dma = state->dma;
+	struct mac53c94_regs __iomem *regs = state->regs;
+	struct dbdma_regs __iomem *dma = state->dma;
 	int x;
 
 	writeb(state->host->this_id | CF1_PAR_ENABLE, &regs->config1);
@@ -143,7 +143,7 @@
 static void mac53c94_start(struct fsc_state *state)
 {
 	struct scsi_cmnd *cmd;
-	struct mac53c94_regs *regs = state->regs;
+	struct mac53c94_regs __iomem *regs = state->regs;
 	int i;
 
 	if (state->phase != idle || state->current_req != NULL)
@@ -191,8 +191,8 @@
 static void mac53c94_interrupt(int irq, void *dev_id, struct pt_regs *ptregs)
 {
 	struct fsc_state *state = (struct fsc_state *) dev_id;
-	struct mac53c94_regs *regs = state->regs;
-	struct dbdma_regs *dma = state->dma;
+	struct mac53c94_regs __iomem *regs = state->regs;
+	struct dbdma_regs __iomem *dma = state->dma;
 	struct scsi_cmnd *cmd = state->current_req;
 	int nb, stat, seq, intr;
 	static int mac53c94_errors;
@@ -458,10 +458,10 @@
 	state->pdev = pdev;
 	state->mdev = mdev;
 
-	state->regs = (struct mac53c94_regs *)
+	state->regs = (struct mac53c94_regs __iomem *)
 		ioremap(macio_resource_start(mdev, 0), 0x1000);
 	state->intr = macio_irq(mdev, 0);
-	state->dma = (struct dbdma_regs *)
+	state->dma = (struct dbdma_regs __iomem *)
 		ioremap(macio_resource_start(mdev, 1), 0x1000);
 	state->dmaintr = macio_irq(mdev, 1);
 	if (state->regs == NULL || state->dma == NULL) {
