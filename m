Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265579AbTGDAD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 20:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265599AbTGDAD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 20:03:56 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:22175 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S265579AbTGDADR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 20:03:17 -0400
Date: Fri, 4 Jul 2003 02:17:42 +0200 (MEST)
Message-Id: <200307040017.h640Hg2D018363@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH][2.5.74] fix PowerMac swim3 floppy driver
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the 2.5 swim3 driver as follows:
- fix compile problems due to irqreturn_t changes not having been
  implemented in swim3.c (trivial: #include <linux/interrupt.h> and
  update the return type of swim3_interrupt())
- fix absence of initialisation since 2.5.1 when the swim3_init()
  call was removed from ll_rw_block.c (trivial: #include <linux/module.h>
  and use module_init(swim3_init))
- merge Paul Mackerras' update to the 2.4 swim3.c driver from March 29
  this year; this fixes write performance and reliability issues just
  like they did with the 2.4 driver
- fix compile warning by removing the now unused floppy_off() function

The resulting driver works reliably for me in raw access modes; I use
it mostly for building boot floppies (hformat + hcopy vmlinux.coff).

/Mikael

diff -ruN linux-2.5.74/drivers/block/swim3.c linux-2.5.74.ppc-swim3-fixes/drivers/block/swim3.c
--- linux-2.5.74/drivers/block/swim3.c	2003-05-05 22:56:29.000000000 +0200
+++ linux-2.5.74.ppc-swim3-fixes/drivers/block/swim3.c	2003-07-03 19:34:37.000000000 +0200
@@ -26,6 +26,8 @@
 #include <linux/ioctl.h>
 #include <linux/blk.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
 #include <asm/prom.h>
@@ -145,7 +147,7 @@
 #define RELAX		3	/* also eject in progress */
 #define READ_DATA_0	4
 #define TWOMEG_DRIVE	5
-#define SINGLE_SIDED	6
+#define SINGLE_SIDED	6	/* drive or diskette is 4MB type? */
 #define DRIVE_PRESENT	7
 #define DISK_IN		8
 #define WRITE_PROT	9
@@ -185,6 +187,7 @@
 	int	req_sector;	/* sector number ditto */
 	int	scount;		/* # sectors we're transferring at present */
 	int	retries;
+	int	settle_time;
 	int	secpercyl;	/* disk geometry information */
 	int	secpertrack;
 	int	total_secs;
@@ -233,8 +236,9 @@
 static void act(struct floppy_state *fs);
 static void scan_timeout(unsigned long data);
 static void seek_timeout(unsigned long data);
+static void settle_timeout(unsigned long data);
 static void xfer_timeout(unsigned long data);
-static void swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 /*static void fd_dma_interrupt(int irq, void *dev_id, struct pt_regs *regs);*/
 static int grab_drive(struct floppy_state *fs, enum swim_state state,
 		      int interruptible);
@@ -275,7 +279,6 @@
 	udelay(2);
 	out_8(&sw->select, sw->select & ~LSTRB);
 	udelay(1);
-	out_8(&sw->select, RELAX);
 }
 
 static int swim3_readbit(struct floppy_state *fs, int bit)
@@ -284,9 +287,8 @@
 	int stat;
 
 	swim3_select(fs, bit);
-	udelay(10);
+	udelay(1);
 	stat = in_8(&sw->status);
-	out_8(&sw->select, RELAX);
 	return (stat & DATA) == 0;
 }
 
@@ -375,13 +377,13 @@
 static inline void scan_track(struct floppy_state *fs)
 {
 	volatile struct swim3 *sw = fs->swim3;
-	int xx;
 
 	swim3_select(fs, READ_DATA_0);
-	xx = sw->intr;		/* clear SEEN_SECTOR bit */
+	in_8(&sw->intr);		/* clear SEEN_SECTOR bit */
+	in_8(&sw->error);
+	out_8(&sw->intr_enable, SEEN_SECTOR);
 	out_8(&sw->control_bis, DO_ACTION);
 	/* enable intr when track found */
-	out_8(&sw->intr_enable, ERROR_INTR | SEEN_SECTOR);
 	set_timeout(fs, HZ, scan_timeout);	/* enable timeout */
 }
 
@@ -396,12 +398,14 @@
 		swim3_action(fs, SEEK_NEGATIVE);
 		sw->nseek = -n;
 	}
-	fs->expect_cyl = (fs->cur_cyl > 0)? fs->cur_cyl + n: -1;
+	fs->expect_cyl = (fs->cur_cyl >= 0)? fs->cur_cyl + n: -1;
 	swim3_select(fs, STEP);
-	out_8(&sw->control_bis, DO_SEEK);
+	in_8(&sw->error);
 	/* enable intr when seek finished */
-	out_8(&sw->intr_enable, ERROR_INTR | SEEK_DONE);
-	set_timeout(fs, HZ/2, seek_timeout);	/* enable timeout */
+	out_8(&sw->intr_enable, SEEK_DONE);
+	out_8(&sw->control_bis, DO_SEEK);
+	set_timeout(fs, 3*HZ, seek_timeout);	/* enable timeout */
+	fs->settle_time = 0;
 }
 
 static inline void init_dma(struct dbdma_cmd *cp, int cmd,
@@ -449,18 +453,21 @@
 	}
 	++cp;
 	out_le16(&cp->command, DBDMA_STOP);
+	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
+	in_8(&sw->error);
+	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
+	if (rq_data_dir(fd_req) == WRITE)
+		out_8(&sw->control_bis, WRITE_SECTORS);
+	in_8(&sw->intr);
 	out_le32(&dr->control, (RUN << 16) | RUN);
-	out_8(&sw->control_bis,
-	      (rq_data_dir(fd_req) == WRITE? WRITE_SECTORS: 0) | DO_ACTION);
 	/* enable intr when transfer complete */
-	out_8(&sw->intr_enable, ERROR_INTR | TRANSFER_DONE);
+	out_8(&sw->intr_enable, TRANSFER_DONE);
+	out_8(&sw->control_bis, DO_ACTION);
 	set_timeout(fs, 2*HZ, xfer_timeout);	/* enable timeout */
 }
 
 static void act(struct floppy_state *fs)
 {
-	volatile struct swim3 *sw = fs->swim3;
-
 	for (;;) {
 		switch (fs->state) {
 		case idle:
@@ -493,20 +500,10 @@
 			return;
 
 		case settling:
-			/* wait for SEEK_COMPLETE to become true */
-			swim3_select(fs, SEEK_COMPLETE);
-			udelay(10);
-			out_8(&sw->intr_enable, ERROR_INTR | DATA_CHANGED);
-			in_8(&sw->intr);	/* clear DATA_CHANGED */
-			if (in_8(&sw->status) & DATA) {
-				/* seek_complete is not yet true */
-				set_timeout(fs, HZ/2, seek_timeout);
-				return;
-			}
-			out_8(&sw->intr_enable, 0);
-			in_8(&sw->intr);
-			fs->state = locating;
-			break;
+			/* check for SEEK_COMPLETE after 30ms */
+			fs->settle_time = (HZ + 32) / 33;
+			set_timeout(fs, fs->settle_time, settle_timeout);
+			return;
 
 		case do_transfer:
 			if (fs->cur_cyl != fs->req_cyl) {
@@ -538,7 +535,7 @@
 	volatile struct swim3 *sw = fs->swim3;
 
 	fs->timeout_pending = 0;
-	out_8(&sw->control_bic, DO_ACTION);
+	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
 	out_8(&sw->select, RELAX);
 	out_8(&sw->intr_enable, 0);
 	fs->cur_cyl = -1;
@@ -558,20 +555,34 @@
 	volatile struct swim3 *sw = fs->swim3;
 
 	fs->timeout_pending = 0;
-	if (fs->state == settling) {
-		printk(KERN_ERR "swim3: MSI sel=%x ctrl=%x stat=%x intr=%x ie=%x\n",
-		       sw->select, sw->control, sw->status, sw->intr, sw->intr_enable);
-	}
 	out_8(&sw->control_bic, DO_SEEK);
 	out_8(&sw->select, RELAX);
 	out_8(&sw->intr_enable, 0);
-	if (fs->state == settling && swim3_readbit(fs, SEEK_COMPLETE)) {
-		/* printk(KERN_DEBUG "swim3: missed settling interrupt\n"); */
+	printk(KERN_ERR "swim3: seek timeout\n");
+	end_request(fd_req, 0);
+	fs->state = idle;
+	start_request(fs);
+}
+
+static void settle_timeout(unsigned long data)
+{
+	struct floppy_state *fs = (struct floppy_state *) data;
+	volatile struct swim3 *sw = fs->swim3;
+
+	fs->timeout_pending = 0;
+	if (swim3_readbit(fs, SEEK_COMPLETE)) {
+		out_8(&sw->select, RELAX);
 		fs->state = locating;
 		act(fs);
 		return;
 	}
-	printk(KERN_ERR "swim3: seek timeout\n");
+	out_8(&sw->select, RELAX);
+	if (fs->settle_time < 2*HZ) {
+		++fs->settle_time;
+		set_timeout(fs, 1, settle_timeout);
+		return;
+	}
+	printk(KERN_ERR "swim3: seek settle timeout\n");
 	end_request(fd_req, 0);
 	fs->state = idle;
 	start_request(fs);
@@ -584,9 +595,13 @@
 	struct dbdma_regs *dr = fs->dma;
 	struct dbdma_cmd *cp = fs->dma_cmd;
 	unsigned long s;
+	int n;
 
 	fs->timeout_pending = 0;
 	st_le32(&dr->control, RUN << 16);
+	/* We must wait a bit for dbdma to stop */
+	for (n = 0; (in_le32(&dr->status) & ACTIVE) && n < 1000; n++)
+		udelay(1);
 	out_8(&sw->intr_enable, 0);
 	out_8(&sw->control_bic, WRITE_SECTORS | DO_ACTION);
 	out_8(&sw->select, RELAX);
@@ -605,7 +620,7 @@
 	start_request(fs);
 }
 
-static void swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t swim3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct floppy_state *fs = (struct floppy_state *) dev_id;
 	volatile struct swim3 *sw = fs->swim3;
@@ -614,18 +629,15 @@
 	struct dbdma_regs *dr;
 	struct dbdma_cmd *cp;
 
-	err = in_8(&sw->error);
 	intr = in_8(&sw->intr);
-#if 0
-	printk("swim3 intr state=%d intr=%x err=%x\n", fs->state, intr, err);
-#endif
+	err = (intr & ERROR_INTR)? in_8(&sw->error): 0;
 	if ((intr & ERROR_INTR) && fs->state != do_transfer)
 		printk(KERN_ERR "swim3_interrupt, state=%d, dir=%lx, intr=%x, err=%x\n",
 		       fs->state, rq_data_dir(fd_req), intr, err);
 	switch (fs->state) {
 	case locating:
 		if (intr & SEEN_SECTOR) {
-			out_8(&sw->control_bic, DO_ACTION);
+			out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
 			out_8(&sw->select, RELAX);
 			out_8(&sw->intr_enable, 0);
 			del_timer(&fs->timeout);
@@ -675,19 +687,33 @@
 	case do_transfer:
 		if ((intr & (ERROR_INTR | TRANSFER_DONE)) == 0)
 			break;
-		dr = fs->dma;
-		cp = fs->dma_cmd;
-		/* We must wait a bit for dbdma to complete */
-		for (n=0; (in_le32(&dr->status) & ACTIVE) && n < 1000; n++)
-			udelay(10);
-		DBDMA_DO_STOP(dr);
 		out_8(&sw->intr_enable, 0);
 		out_8(&sw->control_bic, WRITE_SECTORS | DO_ACTION);
 		out_8(&sw->select, RELAX);
 		del_timer(&fs->timeout);
 		fs->timeout_pending = 0;
+		dr = fs->dma;
+		cp = fs->dma_cmd;
 		if (rq_data_dir(fd_req) == WRITE)
 			++cp;
+		/*
+		 * Check that the main data transfer has finished.
+		 * On writing, the swim3 sometimes doesn't use
+		 * up all the bytes of the postamble, so we can still
+		 * see DMA active here.  That doesn't matter as long
+		 * as all the sector data has been transferred.
+		 */
+		if ((intr & ERROR_INTR) == 0 && cp->xfer_status == 0) {
+			/* wait a little while for DMA to complete */
+			for (n = 0; n < 100; ++n) {
+				if (cp->xfer_status != 0)
+					break;
+				udelay(1);
+				barrier();
+			}
+		}
+		/* turn off DMA */
+		out_le32(&dr->control, (RUN | PAUSE) << 16);
 		stat = ld_le16(&cp->xfer_status);
 		resid = ld_le16(&cp->res_count);
 		if (intr & ERROR_INTR) {
@@ -743,6 +769,7 @@
 	default:
 		printk(KERN_ERR "swim3: don't know what to do in state %d\n", fs->state);
 	}
+	return IRQ_HANDLED;
 }
 
 /*
@@ -794,16 +821,19 @@
 	if (err)
 		return err;
 	swim3_action(fs, EJECT);
-	for (n = 2*HZ; n > 0; --n) {
-		if (swim3_readbit(fs, RELAX))
-			break;
+	for (n = 20; n > 0; --n) {
 		if (signal_pending(current)) {
 			err = -EINTR;
 			break;
 		}
+		swim3_select(fs, RELAX);
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(1);
+		if (swim3_readbit(fs, DISK_IN) == 0)
+			break;
 	}
+	swim3_select(fs, RELAX);
+	udelay(150);
 	fs->ejected = 1;
 	release_drive(fs);
 	return err;
@@ -848,29 +878,31 @@
 	if (fs->ref_count == 0) {
 		if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
 			return -ENXIO;
-		out_8(&sw->mode, 0x95);
-		out_8(&sw->control_bic, 0xff);
 		out_8(&sw->setup, S_IBM_DRIVE | S_FCLK_DIV2);
+		out_8(&sw->control_bic, 0xff);
+		out_8(&sw->mode, 0x95);
 		udelay(10);
 		out_8(&sw->intr_enable, 0);
 		out_8(&sw->control_bis, DRIVE_ENABLE | INTR_ENABLE);
 		swim3_action(fs, MOTOR_ON);
 		fs->write_prot = -1;
 		fs->cur_cyl = -1;
-		for (n = HZ; n > 0; --n) {
-			if (swim3_readbit(fs, SEEK_COMPLETE))
+		for (n = 0; n < 2 * HZ; ++n) {
+			if (n >= HZ/30 && swim3_readbit(fs, SEEK_COMPLETE))
 				break;
 			if (signal_pending(current)) {
 				err = -EINTR;
 				break;
 			}
+			swim3_select(fs, RELAX);
 			current->state = TASK_INTERRUPTIBLE;
 			schedule_timeout(1);
 		}
 		if (err == 0 && (swim3_readbit(fs, SEEK_COMPLETE) == 0
 				 || swim3_readbit(fs, DISK_IN) == 0))
 			err = -ENXIO;
-		swim3_action(fs, 9);
+		swim3_action(fs, SETMFM);
+		swim3_select(fs, RELAX);
 
 	} else if (fs->ref_count == -1 || filp->f_flags & O_EXCL)
 		return -EBUSY;
@@ -893,6 +925,7 @@
 		if (fs->ref_count == 0) {
 			swim3_action(fs, MOTOR_OFF);
 			out_8(&sw->control_bic, DRIVE_ENABLE | INTR_ENABLE);
+			swim3_select(fs, RELAX);
 		}
 		return err;
 	}
@@ -912,6 +945,7 @@
 	if (fs->ref_count > 0 && --fs->ref_count == 0) {
 		swim3_action(fs, MOTOR_OFF);
 		out_8(&sw->control_bic, 0xff);
+		swim3_select(fs, RELAX);
 	}
 	return 0;
 }
@@ -934,15 +968,17 @@
 	sw = fs->swim3;
 	grab_drive(fs, revalidating, 0);
 	out_8(&sw->intr_enable, 0);
-	out_8(&sw->control_bis, DRIVE_ENABLE | INTR_ENABLE);
-	swim3_action(fs, MOTOR_ON);
+	out_8(&sw->control_bis, DRIVE_ENABLE);
+	swim3_action(fs, MOTOR_ON);	/* necessary? */
 	fs->write_prot = -1;
 	fs->cur_cyl = -1;
+	mdelay(1);
 	for (n = HZ; n > 0; --n) {
 		if (swim3_readbit(fs, SEEK_COMPLETE))
 			break;
 		if (signal_pending(current))
 			break;
+		swim3_select(fs, RELAX);
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(1);
 	}
@@ -952,17 +988,14 @@
 		swim3_action(fs, MOTOR_OFF);
 	else {
 		fs->ejected = 0;
-		swim3_action(fs, 9);
+		swim3_action(fs, SETMFM);
 	}
+	swim3_select(fs, RELAX);
 
 	release_drive(fs);
 	return ret;
 }
 
-static void floppy_off(unsigned int nr)
-{
-}
-
 static struct block_device_operations floppy_fops = {
 	.open		= floppy_open,
 	.release	= floppy_release,
@@ -1097,3 +1130,5 @@
 	
 	return 0;
 }
+
+module_init(swim3_init)
