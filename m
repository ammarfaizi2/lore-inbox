Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbTCJNeF>; Mon, 10 Mar 2003 08:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbTCJNeF>; Mon, 10 Mar 2003 08:34:05 -0500
Received: from colino.net ([62.212.100.143]:13815 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id <S261312AbTCJNeB>;
	Mon, 10 Mar 2003 08:34:01 -0500
Date: Mon, 10 Mar 2003 14:44:07 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] [ppc] 2.5.64 compilation fixes
Message-Id: <20030310144407.2f7ade71.colin@colino.net>
X-Mailer: Sylpheed version 0.8.10claws71 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__10_Mar_2003_14:44:07_+0100_1189a548"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__10_Mar_2003_14:44:07_+0100_1189a548
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi

I just downloaded 2.5.64 and tried to compile it on my mac; there were
some compilation errors, i tried to fix them all in order to try the
kernel.
Finally i only fixed some and then got tired ;-)
Maybe thery're fixed in CVS, i didn't check, and maybe these are not the
right fixes, but i thought i'd send it just in case.

cheers,
-- 
Colin
"If you can't beat your computer at chess, try kickboxing."

--Multipart_Mon__10_Mar_2003_14:44:07_+0100_1189a548
Content-Type: text/plain;
 name="2.5.64-ppc-fixes.diff"
Content-Disposition: attachment;
 filename="2.5.64-ppc-fixes.diff"
Content-Transfer-Encoding: 7bit

diff -ur linux-2.5.64/drivers/macintosh/adbhid.c linux-2.5.64-colin/drivers/macintosh/adbhid.c
--- linux-2.5.64/drivers/macintosh/adbhid.c	Wed Mar  5 04:29:56 2003
+++ linux-2.5.64-colin/drivers/macintosh/adbhid.c	Mon Mar 10 13:18:17 2003
@@ -84,7 +84,7 @@
 
 static void adbhid_probe(void);
 
-static void adbhid_input_keycode(int, int, int);
+static void adbhid_input_keycode(int, int, int, struct pt_regs *);
 static void leds_done(struct adb_request *);
 
 static void init_trackpad(int id);
@@ -140,7 +140,7 @@
 }
 
 static void
-adbhid_input_keycode(int id, int keycode, int repeat, pt_regs *regs)
+adbhid_input_keycode(int id, int keycode, int repeat, struct pt_regs *regs)
 {
 	int up_flag;
 
diff -ur linux-2.5.64/drivers/macintosh/mediabay.c linux-2.5.64-colin/drivers/macintosh/mediabay.c
--- linux-2.5.64/drivers/macintosh/mediabay.c	Wed Mar  5 04:29:03 2003
+++ linux-2.5.64-colin/drivers/macintosh/mediabay.c	Mon Mar 10 13:14:35 2003
@@ -23,6 +23,7 @@
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/init.h>
+#include <linux/ide.h>
 #include <asm/prom.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -569,7 +570,7 @@
 				pmu_suspend();
 				ide_init_hwif_ports(&hw, (ide_ioreg_t) bay->cd_base, (ide_ioreg_t) 0, NULL);
 				hw.irq = bay->cd_irq;
-				bay->cd_index = ide_register_hw(&hw);
+				bay->cd_index = ide_register_hw(&hw, NULL);
 				pmu_resume();
 			}
 			if (bay->cd_index == -1) {
diff -ur linux-2.5.64/drivers/scsi/mac53c94.c linux-2.5.64-colin/drivers/scsi/mac53c94.c
--- linux-2.5.64/drivers/scsi/mac53c94.c	Wed Mar  5 04:28:58 2003
+++ linux-2.5.64-colin/drivers/scsi/mac53c94.c	Mon Mar 10 13:49:03 2003
@@ -16,6 +16,7 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 #include <asm/dbdma.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
@@ -167,7 +168,7 @@
 	cmd->scsi_done = done;
 	cmd->host_scribble = NULL;
 
-	state = (struct fsc_state *) cmd->host->hostdata;
+	state = (struct fsc_state *) cmd->device->host->hostdata;
 
 	save_flags(flags);
 	cli();
@@ -193,7 +194,7 @@
 int
 mac53c94_reset(Scsi_Cmnd *cmd, unsigned how)
 {
-	struct fsc_state *state = (struct fsc_state *) cmd->host->hostdata;
+	struct fsc_state *state = (struct fsc_state *) cmd->device->host->hostdata;
 	volatile struct mac53c94_regs *regs = state->regs;
 	volatile struct dbdma_regs *dma = state->dma;
 	unsigned long flags;
@@ -269,7 +270,7 @@
 	regs->command = CMD_FLUSH;
 	udelay(1);
 	eieio();
-	regs->dest_id = cmd->target;
+	regs->dest_id = cmd->device->id;
 	regs->sync_period = 0;
 	regs->sync_offset = 0;
 	eieio();
@@ -292,7 +293,7 @@
 do_mac53c94_interrupt(int irq, void *dev_id, struct pt_regs *ptregs)
 {
 	unsigned long flags;
-	struct Scsi_Host *dev = ((struct fsc_state *) dev_id)->current_req->host;
+	struct Scsi_Host *dev = ((struct fsc_state *) dev_id)->current_req->device->host;
 	
 	spin_lock_irqsave(dev->host_lock, flags);
 	mac53c94_interrupt(irq, dev_id, ptregs);
@@ -492,7 +493,7 @@
 			total += scl->length;
 			st_le16(&dcmds->req_count, scl->length);
 			st_le16(&dcmds->command, dma_cmd);
-			st_le32(&dcmds->phy_addr, virt_to_phys(scl->address));
+			st_le32(&dcmds->phy_addr, virt_to_phys(scl->dma_address));
 			dcmds->xfer_status = 0;
 			++scl;
 			++dcmds;
diff -ur linux-2.5.64/drivers/scsi/mesh.c linux-2.5.64-colin/drivers/scsi/mesh.c
--- linux-2.5.64/drivers/scsi/mesh.c	Wed Mar  5 04:29:30 2003
+++ linux-2.5.64-colin/drivers/scsi/mesh.c	Mon Mar 10 13:43:42 2003
@@ -80,7 +80,7 @@
 #define ALLOW_SYNC(tgt)		((sync_targets >> (tgt)) & 1)
 #define ALLOW_RESEL(tgt)	((resel_targets >> (tgt)) & 1)
 #define ALLOW_DEBUG(tgt)	((debug_targets >> (tgt)) & 1)
-#define DEBUG_TARGET(cmd)	((cmd) && ALLOW_DEBUG((cmd)->target))
+#define DEBUG_TARGET(cmd)	((cmd) && (cmd->device) && ALLOW_DEBUG((cmd)->device->id))
 
 #undef MESH_DBG
 #define N_DBG_LOG	50
@@ -465,7 +465,7 @@
 	cmd->scsi_done = done;
 	cmd->host_scribble = NULL;
 
-	ms = (struct mesh_state *) cmd->host->hostdata;
+	ms = (struct mesh_state *) cmd->device->host->hostdata;
 
 	if (ms->request_q == NULL)
 		ms->request_q = cmd;
@@ -486,13 +486,13 @@
 int
 mesh_abort(Scsi_Cmnd *cmd)
 {
-	struct mesh_state *ms = (struct mesh_state *) cmd->host->hostdata;
+	struct mesh_state *ms = (struct mesh_state *) cmd->device->host->hostdata;
 	unsigned long flags;
 
 	printk(KERN_DEBUG "mesh_abort(%p)\n", cmd);
 	spin_lock_irqsave(ms->host->host_lock, flags);
 	mesh_dump_regs(ms);
-	dumplog(ms, cmd->target);
+	dumplog(ms, cmd->device->id);
 	dumpslog(ms);
 	spin_unlock_irqrestore(ms->host->host_lock, flags);
 	return SCSI_ABORT_SNOOZE;
@@ -540,7 +540,7 @@
 int
 mesh_host_reset(Scsi_Cmnd *cmd)
 {
-	struct mesh_state *ms = (struct mesh_state *) cmd->host->hostdata;
+	struct mesh_state *ms = (struct mesh_state *) cmd->device->host->hostdata;
 	volatile struct mesh_regs *mr = ms->mesh;
 	volatile struct dbdma_regs *md = ms->dma;
 
@@ -661,7 +661,7 @@
 		for (cmd = ms->request_q; ; cmd = (Scsi_Cmnd *) cmd->host_scribble) {
 			if (cmd == NULL)
 				return;
-			if (ms->tgts[cmd->target].current_req == NULL)
+			if (ms->tgts[cmd->device->id].current_req == NULL)
 				break;
 			prev = cmd;
 		}
@@ -684,14 +684,14 @@
 	int t;
 
 	ms->current_req = cmd;
-	ms->tgts[cmd->target].data_goes_out = data_goes_out(cmd);
-	ms->tgts[cmd->target].current_req = cmd;
+	ms->tgts[cmd->device->id].data_goes_out = data_goes_out(cmd);
+	ms->tgts[cmd->device->id].current_req = cmd;
 
 #if 1
 	if (DEBUG_TARGET(cmd)) {
 		int i;
 		printk(KERN_DEBUG "mesh_start: %p ser=%lu tgt=%d cmd=",
-		       cmd, cmd->serial_number, cmd->target);
+		       cmd, cmd->serial_number, cmd->device->id);
 		for (i = 0; i < cmd->cmd_len; ++i)
 			printk(" %x", cmd->cmnd[i]);
 		printk(" use_sg=%d buffer=%p bufflen=%u\n",
@@ -708,12 +708,12 @@
 	ms->n_msgout = 0;
 	ms->last_n_msgout = 0;
 	ms->expect_reply = 0;
-	ms->conn_tgt = cmd->target;
-	ms->tgts[cmd->target].saved_ptr = 0;
+	ms->conn_tgt = cmd->device->id;
+	ms->tgts[cmd->device->id].saved_ptr = 0;
 	ms->stat = DID_OK;
 	ms->aborting = 0;
 #ifdef MESH_DBG
-	ms->tgts[cmd->target].n_log = 0;
+	ms->tgts[cmd->device->id].n_log = 0;
 	dlog(ms, "start cmd=%x", (int) cmd);
 #endif
 
@@ -1160,7 +1160,7 @@
 		case selecting:
 			dlog(ms, "Selecting phase at command completion",0);
 			ms->msgout[0] = IDENTIFY(ALLOW_RESEL(ms->conn_tgt),
-						 (cmd? cmd->lun: 0));
+						 ((cmd && cmd->device)? cmd->device->lun: 0));
 			ms->n_msgout = 1;
 			ms->expect_reply = 0;
 			if (ms->aborting) {
@@ -1331,7 +1331,7 @@
 			if (ms->request_q == NULL)
 				ms->request_qtail = cmd;
 			ms->request_q = cmd;
-			tp = &ms->tgts[cmd->target];
+			tp = &ms->tgts[cmd->device->id];
 			tp->current_req = NULL;
 		}
 		break;
@@ -1714,10 +1714,10 @@
 			if (cmd == NULL) {
 				do_abort(ms);
 				ms->msgphase = msg_out;
-			} else if (code != cmd->lun + IDENTIFY_BASE) {
+			} else if (code != cmd->device->lun + IDENTIFY_BASE) {
 				printk(KERN_WARNING "mesh: lun mismatch "
 				       "(%d != %d) on reselection from "
-				       "target %d\n", i, cmd->lun,
+				       "target %d\n", i, cmd->device->lun,
 				       ms->conn_tgt);
 			}
 			break;
diff -ur linux-2.5.64/include/asm-ppc/termbits.h linux-2.5.64-colin/include/asm-ppc/termbits.h
--- linux-2.5.64/include/asm-ppc/termbits.h	Wed Mar  5 04:29:23 2003
+++ linux-2.5.64-colin/include/asm-ppc/termbits.h	Mon Mar 10 14:07:51 2003
@@ -146,6 +146,7 @@
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
 /* c_lflag bits */

--Multipart_Mon__10_Mar_2003_14:44:07_+0100_1189a548--
