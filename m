Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUFAGDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUFAGDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 02:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbUFAGDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 02:03:53 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:29160 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264897AbUFAGCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 02:02:23 -0400
Date: Tue, 1 Jun 2004 08:02:05 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040601060205.GE15492@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040601055616.GD15492@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040601055616.GD15492@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 June 2004 07:56:16 +0200, Jörn Engel wrote:
> 
> So effectively, it comes down to the recursive paths.  Unless someone
> comes up with a semantical parser that can figure out the maximum
> number of iterations, we have to look at them manually.

Linus, Andrew, would you accept patches like the one below?  With such
information and assuming that the comments will get maintained, it's
relatively simple to unroll recursions and measure stack comsumption
more accurately.

Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c

Add recursion markers to teach automated test tools how bad documented
recursions really are.  Currently, there is only a single such too that
can use the information and there is always the danger of documentation
and reality getting out of sync.  But until there's a better tool...

Currently, this patch also has a few cleanup bits included.  The cleanups
were helpful to figure out the depth of some recursions and could be
useful on their own.  If not, they are easily removed.

 arch/i386/kernel/apm.c      |    4 ++
 drivers/char/random.c       |    6 ++++
 drivers/ide/ide-tape.c      |   33 +++++++++++++-----------
 drivers/ide/ide-timing.h    |   60 ++++++++++++++++++--------------------------
 drivers/isdn/i4l/isdn_tty.c |    5 +++
 drivers/isdn/icn/icn.c      |    5 +++
 fs/block_dev.c              |    5 +++
 fs/quota_v2.c               |   43 +++++++++++++++++++------------
 kernel/signal.c             |    7 +++++
 kernel/sysctl.c             |   10 +++++++
 10 files changed, 113 insertions(+), 65 deletions(-)


--- linux-2.6.6stack/arch/i386/kernel/apm.c~recursion	2004-05-10 18:10:06.000000000 +0200
+++ linux-2.6.6stack/arch/i386/kernel/apm.c	2004-05-30 18:24:54.000000000 +0200
@@ -1058,6 +1058,10 @@
  *	monitor powerdown for us.
  */
  
+/**
+ * RECURSION:	2
+ * STEP:	apm_console_blank
+ */
 static int apm_console_blank(int blank)
 {
 	int	error;
--- linux-2.6.6stack/kernel/sysctl.c~recursion	2004-05-30 17:51:03.000000000 +0200
+++ linux-2.6.6stack/kernel/sysctl.c	2004-05-30 17:52:25.000000000 +0200
@@ -1188,6 +1188,11 @@
 #ifdef CONFIG_PROC_FS
 
 /* Scan the sysctl entries in table and add them all into /proc */
+
+/**
+ * RECURSION:	100
+ * STEP:	register_proc_table
+ */
 static void register_proc_table(ctl_table * table, struct proc_dir_entry *root)
 {
 	struct proc_dir_entry *de;
@@ -1237,6 +1242,11 @@
 /*
  * Unregister a /proc sysctl table and any subdirectories.
  */
+
+/**
+ * RECURSION:	100
+ * STEP:	unregister_proc_table
+ */
 static void unregister_proc_table(ctl_table * table, struct proc_dir_entry *root)
 {
 	struct proc_dir_entry *de;
--- linux-2.6.6stack/kernel/signal.c~recursion	2004-05-10 18:10:38.000000000 +0200
+++ linux-2.6.6stack/kernel/signal.c	2004-05-30 18:24:38.000000000 +0200
@@ -626,6 +626,13 @@
  * actual continuing for SIGCONT, but not the actual stopping for stop
  * signals.  The process stop is done as a signal action for SIG_DFL.
  */
+
+/**
+ * RECURSION:	2
+ * STEP:	handle_stop_signal
+ * STEP:	do_notify_parent_cldstop
+ * STEP:	__group_send_sig_info
+ */
 static void handle_stop_signal(int sig, struct task_struct *p)
 {
 	struct task_struct *t;
--- linux-2.6.6stack/fs/block_dev.c~recursion	2004-05-10 18:10:30.000000000 +0200
+++ linux-2.6.6stack/fs/block_dev.c	2004-05-31 17:20:53.000000000 +0200
@@ -547,6 +547,11 @@
 }
 EXPORT_SYMBOL(bd_set_size);
 
+/**
+ * RECURSION:	2
+ * STEP:	do_open
+ * STEP:	blkdev_get
+ */
 static int do_open(struct block_device *bdev, struct file *file)
 {
 	struct module *owner = NULL;
--- linux-2.6.6stack/fs/quota_v2.c~recursion	2004-05-10 18:10:32.000000000 +0200
+++ linux-2.6.6stack/fs/quota_v2.c	2004-05-30 18:36:23.000000000 +0200
@@ -352,6 +352,12 @@
 }
 
 /* Insert reference to structure into the trie */
+
+/**
+ * Recursion count equals V2_DQTREEDEPTH, keep both in sync
+ * RECURSION:	4
+ * STEP:	do_insert_tree
+ */
 static int do_insert_tree(struct dquot *dquot, uint *treeblk, int depth)
 {
 	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
@@ -369,12 +375,9 @@
 		*treeblk = ret;
 		memset(buf, 0, V2_DQBLKSIZE);
 		newact = 1;
-	}
-	else {
-		if ((ret = read_blk(filp, *treeblk, buf)) < 0) {
-			printk(KERN_ERR "VFS: Can't read tree quota block %u.\n", *treeblk);
-			goto out_buf;
-		}
+	} else if ((ret = read_blk(filp, *treeblk, buf)) < 0) {
+		printk(KERN_ERR "VFS: Can't read tree quota block %u.\n", *treeblk);
+		goto out_buf;
 	}
 	ref = (u32 *)buf;
 	newblk = le32_to_cpu(ref[GETIDINDEX(dquot->dq_id, depth)]);
@@ -389,14 +392,12 @@
 		}
 #endif
 		newblk = find_free_dqentry(dquot, &ret);
-	}
-	else
+	} else
 		ret = do_insert_tree(dquot, &newblk, depth+1);
 	if (newson && ret >= 0) {
 		ref[GETIDINDEX(dquot->dq_id, depth)] = cpu_to_le32(newblk);
 		ret = write_blk(filp, *treeblk, buf);
-	}
-	else if (newact && ret < 0)
+	} else if (newact && ret < 0)
 		put_free_dqblk(filp, dquot->dq_type, buf, *treeblk);
 out_buf:
 	freedqbuf(buf);
@@ -498,6 +499,12 @@
 }
 
 /* Remove reference to dquot from tree */
+
+/**
+ * Recursion count equals V2_DQTREEDEPTH, keep both in sync
+ * RECURSION:	4
+ * STEP:	remove_tree
+ */
 static int remove_tree(struct dquot *dquot, uint *blk, int depth)
 {
 	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
@@ -516,19 +523,17 @@
 	if (depth == V2_DQTREEDEPTH-1) {
 		ret = free_dqentry(dquot, newblk);
 		newblk = 0;
-	}
-	else
+	} else
 		ret = remove_tree(dquot, &newblk, depth+1);
 	if (ret >= 0 && !newblk) {
 		int i;
 		ref[GETIDINDEX(dquot->dq_id, depth)] = cpu_to_le32(0);
-		for (i = 0; i < V2_DQBLKSIZE && !buf[i]; i++);	/* Block got empty? */
+		for (i = 0; i < V2_DQBLKSIZE && !buf[i]; i++)
+			;	/* Block got empty? */
 		if (i == V2_DQBLKSIZE) {
 			put_free_dqblk(filp, dquot->dq_type, buf, *blk);
 			*blk = 0;
-		}
-		else
-			if ((ret = write_blk(filp, *blk, buf)) < 0)
+		} else if ((ret = write_blk(filp, *blk, buf)) < 0)
 				printk(KERN_ERR "VFS: Can't write quota tree block %u.\n", *blk);
 	}
 out_buf:
@@ -584,6 +589,12 @@
 }
 
 /* Find entry for given id in the tree */
+
+/**
+ * Recursion count equals V2_DQTREEDEPTH, keep both in sync
+ * RECURSION:	4
+ * STEP:	find_tree_dqentry
+ */
 static loff_t find_tree_dqentry(struct dquot *dquot, uint blk, int depth)
 {
 	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
--- linux-2.6.6stack/drivers/char/random.c~recursion	2004-05-10 18:10:23.000000000 +0200
+++ linux-2.6.6stack/drivers/char/random.c	2004-05-30 18:48:55.000000000 +0200
@@ -1311,6 +1311,12 @@
  * from the primary pool to the secondary extraction pool. We make
  * sure we pull enough for a 'catastrophic reseed'.
  */
+
+/** 
+ * RECURSION:	2
+ * STEP:	xfer_secondary_pool
+ * STEP:	extract_entropy
+ */
 static inline void xfer_secondary_pool(struct entropy_store *r,
 				       size_t nbytes, __u32 *tmp)
 {
--- linux-2.6.6stack/drivers/ide/ide-timing.h~recursion	2004-01-09 07:59:26.000000000 +0100
+++ linux-2.6.6stack/drivers/ide/ide-timing.h	2004-05-31 16:56:23.000000000 +0200
@@ -208,63 +208,53 @@
 	return t; 
 }
 
+/**
+ * RECURSION:	2
+ * STEP:	ide_timing_compute
+ */
 static int ide_timing_compute(ide_drive_t *drive, short speed, struct ide_timing *t, int T, int UT)
 {
 	struct hd_driveid *id = drive->id;
 	struct ide_timing *s, p;
 
-/*
- * Find the mode.
- */
-
-	if (!(s = ide_timing_find_mode(speed)))
+	s = ide_timing_find_mode(speed);
+	if (!s)
 		return -EINVAL;
 
-/*
- * If the drive is an EIDE drive, it can tell us it needs extended
- * PIO/MWDMA cycle timing.
- */
-
-	if (id && id->field_valid & 2) {	/* EIDE drive */
-
+	/* If the drive is an EIDE drive, it can tell us it needs extended
+	 * PIO/MWDMA cycle timing.
+	 */
+	if (id && (id->field_valid & 2)) {	/* EIDE drive */
 		memset(&p, 0, sizeof(p));
 
 		switch (speed & XFER_MODE) {
+		case XFER_PIO:
+			if (speed <= XFER_PIO_2)
+				p.cycle = p.cyc8b = id->eide_pio;
+			else
+				p.cycle = p.cyc8b = id->eide_pio_iordy;
+			break;
 
-			case XFER_PIO:
-				if (speed <= XFER_PIO_2) p.cycle = p.cyc8b = id->eide_pio;
-						    else p.cycle = p.cyc8b = id->eide_pio_iordy;
-				break;
-
-			case XFER_MWDMA:
-				p.cycle = id->eide_dma_min;
-				break;
+		case XFER_MWDMA:
+			p.cycle = id->eide_dma_min;
+			break;
 		}
-
 		ide_timing_merge(&p, t, t, IDE_TIMING_CYCLE | IDE_TIMING_CYC8B);
 	}
 
-/*
- * Convert the timing to bus clock counts.
- */
-
+	/* Convert the timing to bus clock counts. */
 	ide_timing_quantize(s, t, T, UT);
 
-/*
- * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
- * and some other commands. We have to ensure that the DMA cycle timing is
- * slower/equal than the fastest PIO timing.
- */
-
+	/* Even in DMA/UDMA modes we still use PIO access for IDENTIFY,
+	 * S.M.A.R.T and some other commands. We have to ensure that the
+	 * DMA cycle timing is slower/equal than the fastest PIO timing.
+	 */
 	if ((speed & XFER_MODE) != XFER_PIO) {
 		ide_timing_compute(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO), &p, T, UT);
 		ide_timing_merge(&p, t, t, IDE_TIMING_ALL);
 	}
 
-/*
- * Lenghten active & recovery time so that cycle time is correct.
- */
-
+	/* Lenghten active & recovery time so that cycle time is correct. */
 	if (t->act8b + t->rec8b < t->cyc8b) {
 		t->act8b += (t->cyc8b - (t->act8b + t->rec8b)) / 2;
 		t->rec8b = t->cyc8b - t->act8b;
--- linux-2.6.6stack/drivers/ide/ide-tape.c~recursion	2004-05-10 18:10:24.000000000 +0200
+++ linux-2.6.6stack/drivers/ide/ide-tape.c	2004-05-31 16:58:30.000000000 +0200
@@ -3653,6 +3653,11 @@
  *	the filemark is in our internal pipeline even if the tape doesn't
  *	support spacing over filemarks in the reverse direction.
  */
+
+/**
+ * RECURSION:	2
+ * STEP:	idetape_space_over_filemarks
+ */
 static int idetape_space_over_filemarks (ide_drive_t *drive,short mt_op,int mt_count)
 {
 	idetape_tape_t *tape = drive->driver_data;
@@ -3711,21 +3716,21 @@
 	 *	Now we can issue the space command.
 	 */
 	switch (mt_op) {
-		case MTFSF:
-		case MTBSF:
-			idetape_create_space_cmd(&pc,mt_count-count,IDETAPE_SPACE_OVER_FILEMARK);
-			return (idetape_queue_pc_tail(drive, &pc));
-		case MTFSFM:
-		case MTBSFM:
-			if (!tape->capabilities.sprev)
-				return (-EIO);
-			retval = idetape_space_over_filemarks(drive, MTFSF, mt_count-count);
-			if (retval) return (retval);
-			count = (MTBSFM == mt_op ? 1 : -1);
-			return (idetape_space_over_filemarks(drive, MTFSF, count));
-		default:
-			printk(KERN_ERR "ide-tape: MTIO operation %d not supported\n",mt_op);
+	case MTFSF:
+	case MTBSF:
+		idetape_create_space_cmd(&pc,mt_count-count,IDETAPE_SPACE_OVER_FILEMARK);
+		return (idetape_queue_pc_tail(drive, &pc));
+	case MTFSFM:
+	case MTBSFM:
+		if (!tape->capabilities.sprev)
 			return (-EIO);
+		retval = idetape_space_over_filemarks(drive, MTFSF, mt_count-count);
+		if (retval) return (retval);
+		count = (MTBSFM == mt_op ? 1 : -1);
+		return (idetape_space_over_filemarks(drive, MTFSF, count));
+	default:
+		printk(KERN_ERR "ide-tape: MTIO operation %d not supported\n",mt_op);
+		return (-EIO);
 	}
 }
 
--- linux-2.6.6stack/drivers/isdn/i4l/isdn_tty.c~recursion	2004-03-28 21:51:38.000000000 +0200
+++ linux-2.6.6stack/drivers/isdn/i4l/isdn_tty.c	2004-05-31 17:02:39.000000000 +0200
@@ -2519,6 +2519,11 @@
  * For RING-message handle auto-ATA if register 0 != 0
  */
 
+/**
+ * RECURSION:	2
+ * STEP:	isdn_tty_modem_result
+ * STEP:	isdn_tty_cmd_ATA
+ */
 static void
 isdn_tty_modem_result(int code, modem_info * info)
 {
--- linux-2.6.6stack/drivers/isdn/icn/icn.c~recursion	2004-03-28 21:51:38.000000000 +0200
+++ linux-2.6.6stack/drivers/isdn/icn/icn.c	2004-05-31 17:03:55.000000000 +0200
@@ -1097,6 +1097,11 @@
 /*
  * Delete card's pending timers, send STOP to linklevel
  */
+
+/**
+ * RECURSION:	2
+ * STEP:	icn_stopcard
+ */
 static void
 icn_stopcard(icn_card * card)
 {
