Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbUKODHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbUKODHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbUKODGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:06:07 -0500
Received: from ozlabs.org ([203.10.76.45]:10163 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261488AbUKODCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 22:02:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16792.7451.713162.643549@cargo.ozlabs.ibm.com>
Date: Mon, 15 Nov 2004 14:06:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] __iomem annotations for swim3.c
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds __iomem annotations to drivers/block/swim3.c.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/block/swim3.c test-pmac/drivers/block/swim3.c
--- linux-2.5/drivers/block/swim3.c	2004-07-30 00:25:13.000000000 +1000
+++ test-pmac/drivers/block/swim3.c	2004-11-15 09:19:13.000000000 +1100
@@ -176,8 +176,8 @@
 
 struct floppy_state {
 	enum swim_state	state;
-	volatile struct swim3 *swim3;	/* hardware registers */
-	struct dbdma_regs *dma;	/* DMA controller registers */
+	struct swim3 __iomem *swim3;	/* hardware registers */
+	struct dbdma_regs __iomem *dma;	/* DMA controller registers */
 	int	swim3_intr;	/* interrupt number for SWIM3 */
 	int	dma_intr;	/* interrupt number for DMA channel */
 	int	cur_cyl;	/* cylinder head is on, or -1 */
@@ -259,7 +259,7 @@
 
 static void swim3_select(struct floppy_state *fs, int sel)
 {
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 
 	out_8(&sw->select, RELAX);
 	if (sel & 8)
@@ -271,7 +271,7 @@
 
 static void swim3_action(struct floppy_state *fs, int action)
 {
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 
 	swim3_select(fs, action);
 	udelay(1);
@@ -283,7 +283,7 @@
 
 static int swim3_readbit(struct floppy_state *fs, int bit)
 {
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 	int stat;
 
 	swim3_select(fs, bit);
@@ -381,7 +381,7 @@
 
 static inline void scan_track(struct floppy_state *fs)
 {
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 
 	swim3_select(fs, READ_DATA_0);
 	in_8(&sw->intr);		/* clear SEEN_SECTOR bit */
@@ -394,7 +394,7 @@
 
 static inline void seek_track(struct floppy_state *fs, int n)
 {
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 
 	if (n >= 0) {
 		swim3_action(fs, SEEK_POSITIVE);
@@ -425,9 +425,9 @@
 static inline void setup_transfer(struct floppy_state *fs)
 {
 	int n;
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 	struct dbdma_cmd *cp = fs->dma_cmd;
-	struct dbdma_regs *dr = fs->dma;
+	struct dbdma_regs __iomem *dr = fs->dma;
 
 	if (fd_req->current_nr_sectors <= 0) {
 		printk(KERN_ERR "swim3: transfer 0 sectors?\n");
@@ -445,7 +445,7 @@
 	out_8(&sw->sector, fs->req_sector);
 	out_8(&sw->nsect, n);
 	out_8(&sw->gap3, 0);
-	st_le32(&dr->cmdptr, virt_to_bus(cp));
+	out_le32(&dr->cmdptr, virt_to_bus(cp));
 	if (rq_data_dir(fd_req) == WRITE) {
 		/* Set up 3 dma commands: write preamble, data, postamble */
 		init_dma(cp, OUTPUT_MORE, write_preamble, sizeof(write_preamble));
@@ -537,7 +537,7 @@
 static void scan_timeout(unsigned long data)
 {
 	struct floppy_state *fs = (struct floppy_state *) data;
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 
 	fs->timeout_pending = 0;
 	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
@@ -557,7 +557,7 @@
 static void seek_timeout(unsigned long data)
 {
 	struct floppy_state *fs = (struct floppy_state *) data;
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 
 	fs->timeout_pending = 0;
 	out_8(&sw->control_bic, DO_SEEK);
@@ -572,7 +572,7 @@
 static void settle_timeout(unsigned long data)
 {
 	struct floppy_state *fs = (struct floppy_state *) data;
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 
 	fs->timeout_pending = 0;
 	if (swim3_readbit(fs, SEEK_COMPLETE)) {
@@ -596,14 +596,14 @@
 static void xfer_timeout(unsigned long data)
 {
 	struct floppy_state *fs = (struct floppy_state *) data;
-	volatile struct swim3 *sw = fs->swim3;
-	struct dbdma_regs *dr = fs->dma;
+	struct swim3 __iomem *sw = fs->swim3;
+	struct dbdma_regs __iomem *dr = fs->dma;
 	struct dbdma_cmd *cp = fs->dma_cmd;
 	unsigned long s;
 	int n;
 
 	fs->timeout_pending = 0;
-	st_le32(&dr->control, RUN << 16);
+	out_le32(&dr->control, RUN << 16);
 	/* We must wait a bit for dbdma to stop */
 	for (n = 0; (in_le32(&dr->status) & ACTIVE) && n < 1000; n++)
 		udelay(1);
@@ -628,10 +628,10 @@
 static irqreturn_t swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct floppy_state *fs = (struct floppy_state *) dev_id;
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 	int intr, err, n;
 	int stat, resid;
-	struct dbdma_regs *dr;
+	struct dbdma_regs __iomem *dr;
 	struct dbdma_cmd *cp;
 
 	intr = in_8(&sw->intr);
@@ -877,7 +877,7 @@
 static int floppy_open(struct inode *inode, struct file *filp)
 {
 	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 	int n, err = 0;
 
 	if (fs->ref_count == 0) {
@@ -946,7 +946,7 @@
 static int floppy_release(struct inode *inode, struct file *filp)
 {
 	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
-	volatile struct swim3 *sw = fs->swim3;
+	struct swim3 __iomem *sw = fs->swim3;
 	if (fs->ref_count > 0 && --fs->ref_count == 0) {
 		swim3_action(fs, MOTOR_OFF);
 		out_8(&sw->control_bic, 0xff);
@@ -964,7 +964,7 @@
 static int floppy_revalidate(struct gendisk *disk)
 {
 	struct floppy_state *fs = disk->private_data;
-	volatile struct swim3 *sw;
+	struct swim3 __iomem *sw;
 	int ret, n;
 
 	if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
@@ -1105,8 +1105,10 @@
 	
 	memset(fs, 0, sizeof(*fs));
 	fs->state = idle;
-	fs->swim3 = (volatile struct swim3 *) ioremap(swim->addrs[0].address, 0x200);
-	fs->dma = (struct dbdma_regs *) ioremap(swim->addrs[1].address, 0x200);
+	fs->swim3 = (struct swim3 __iomem *)
+		ioremap(swim->addrs[0].address, 0x200);
+	fs->dma = (struct dbdma_regs __iomem *)
+		ioremap(swim->addrs[1].address, 0x200);
 	fs->swim3_intr = swim->intrs[0].line;
 	fs->dma_intr = swim->intrs[1].line;
 	fs->cur_cyl = -1;
