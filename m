Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUDBHVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 02:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbUDBHVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 02:21:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:10656 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263325AbUDBHV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 02:21:29 -0500
Subject: [PATCH] PowerMac: cleanup of some scsi drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080890457.1425.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Apr 2004 17:20:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch from Christoph Hellwig does much welcomes cleanup of
the old mac53c94 and mesh SCSI drivers, removing sillycaps etc...

Please apply,
Ben.


--- 1.8/drivers/scsi/mac53c94.c	Thu Feb  5 06:44:32 2004
+++ edited/drivers/scsi/mac53c94.c	Fri Feb 13 07:58:29 2004
@@ -25,8 +25,11 @@
 #include <asm/pci-bridge.h>
 #include <asm/macio.h>
 
-#include "scsi.h"
-#include "hosts.h"
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
+
 #include "mac53c94.h"
 
 enum fsc_phase {
@@ -44,9 +47,9 @@
 	int	dmaintr;
 	int	clk_freq;
 	struct	Scsi_Host *host;
-	Scsi_Cmnd *request_q;
-	Scsi_Cmnd *request_qtail;
-	Scsi_Cmnd *current_req;		/* req we're currently working on */
+	struct scsi_cmnd *request_q;
+	struct scsi_cmnd *request_qtail;
+	struct scsi_cmnd *current_req;		/* req we're currently working on */
 	enum fsc_phase phase;		/* what we're currently trying to do */
 	struct dbdma_cmd *dma_cmds;	/* space for dbdma commands, aligned */
 	void	*dma_cmd_space;
@@ -60,15 +63,15 @@
 static void mac53c94_interrupt(int, void *, struct pt_regs *);
 static irqreturn_t do_mac53c94_interrupt(int, void *, struct pt_regs *);
 static void cmd_done(struct fsc_state *, int result);
-static void set_dma_cmds(struct fsc_state *, Scsi_Cmnd *);
+static void set_dma_cmds(struct fsc_state *, struct scsi_cmnd *);
 
 
-static int mac53c94_queue(Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
+static int mac53c94_queue(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 {
 	struct fsc_state *state;
 
 #if 0
-	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
 		int i;
 		printk(KERN_DEBUG "mac53c94_queue %p: command is", cmd);
 		for (i = 0; i < cmd->cmd_len; ++i)
@@ -95,12 +98,12 @@
 	return 0;
 }
 
-static int mac53c94_abort(Scsi_Cmnd *cmd)
+static int mac53c94_abort(struct scsi_cmnd *cmd)
 {
-	return SCSI_ABORT_SNOOZE;
+	return FAILED;
 }
 
-static int mac53c94_host_reset(Scsi_Cmnd *cmd)
+static int mac53c94_host_reset(struct scsi_cmnd *cmd)
 {
 	struct fsc_state *state = (struct fsc_state *) cmd->device->host->hostdata;
 	struct mac53c94_regs *regs = state->regs;
@@ -139,7 +142,7 @@
  */
 static void mac53c94_start(struct fsc_state *state)
 {
-	Scsi_Cmnd *cmd;
+	struct scsi_cmnd *cmd;
 	struct mac53c94_regs *regs = state->regs;
 	int i;
 
@@ -148,7 +151,7 @@
 	if (state->request_q == NULL)
 		return;
 	state->current_req = cmd = state->request_q;
-	state->request_q = (Scsi_Cmnd *) cmd->host_scribble;
+	state->request_q = (struct scsi_cmnd *) cmd->host_scribble;
 
 	/* Off we go */
 	writeb(0, &regs->count_lo);
@@ -190,10 +193,9 @@
 	struct fsc_state *state = (struct fsc_state *) dev_id;
 	struct mac53c94_regs *regs = state->regs;
 	struct dbdma_regs *dma = state->dma;
-	Scsi_Cmnd *cmd = state->current_req;
+	struct scsi_cmnd *cmd = state->current_req;
 	int nb, stat, seq, intr;
 	static int mac53c94_errors;
-	int dma_dir;
 
 	/*
 	 * Apparently, reading the interrupt register unlatches
@@ -308,14 +310,13 @@
 			printk(KERN_DEBUG "intr %x before data xfer complete\n", intr);
 		}
 		writel(RUN << 16, &dma->control);	/* stop dma */
-		dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
 		if (cmd->use_sg != 0) {
 			pci_unmap_sg(state->pdev,
 				(struct scatterlist *)cmd->request_buffer,
-				cmd->use_sg, dma_dir);
+				cmd->use_sg, cmd->sc_data_direction);
 		} else {
 			pci_unmap_single(state->pdev, state->dma_addr,
-				cmd->request_bufflen, dma_dir);
+				cmd->request_bufflen, cmd->sc_data_direction);
 		}
 		/* should check dma status */
 		writeb(CMD_I_COMPLETE, &regs->command);
@@ -347,7 +348,7 @@
 
 static void cmd_done(struct fsc_state *state, int result)
 {
-	Scsi_Cmnd *cmd;
+	struct scsi_cmnd *cmd;
 
 	cmd = state->current_req;
 	if (cmd != 0) {
@@ -362,24 +363,24 @@
 /*
  * Set up DMA commands for transferring data.
  */
-static void set_dma_cmds(struct fsc_state *state, Scsi_Cmnd *cmd)
+static void set_dma_cmds(struct fsc_state *state, struct scsi_cmnd *cmd)
 {
 	int i, dma_cmd, total;
 	struct scatterlist *scl;
 	struct dbdma_cmd *dcmds;
 	dma_addr_t dma_addr;
 	u32 dma_len;
-	int dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
 
-	dma_cmd = cmd->sc_data_direction == SCSI_DATA_WRITE? OUTPUT_MORE:
-		INPUT_MORE;
+	dma_cmd = cmd->sc_data_direction == DMA_TO_DEVICE ?
+			OUTPUT_MORE : INPUT_MORE;
 	dcmds = state->dma_cmds;
 	if (cmd->use_sg > 0) {
 		int nseg;
 
 		total = 0;
 		scl = (struct scatterlist *) cmd->buffer;
-		nseg = pci_map_sg(state->pdev, scl, cmd->use_sg, dma_dir);
+		nseg = pci_map_sg(state->pdev, scl, cmd->use_sg,
+				cmd->sc_data_direction);
 		for (i = 0; i < nseg; ++i) {
 			dma_addr = sg_dma_address(scl);
 			dma_len = sg_dma_len(scl);
@@ -398,7 +399,7 @@
 		if (total > 0xffff)
 			panic("mac53c94: transfer size >= 64k");
 		dma_addr = pci_map_single(state->pdev, cmd->request_buffer,
-					  total, dma_dir);
+					  total, cmd->sc_data_direction);
 		state->dma_addr = dma_addr;
 		st_le16(&dcmds->req_count, total);
 		st_le32(&dcmds->phy_addr, dma_addr);
@@ -411,7 +412,7 @@
 	cmd->SCp.this_residual = total;
 }
 
-static Scsi_Host_Template mac53c94_template = {
+static struct scsi_host_template mac53c94_template = {
 	.proc_name	= "53c94",
 	.name		= "53C94",
 	.queuecommand	= mac53c94_queue,
===== drivers/scsi/mesh.c 1.11 vs edited =====
--- 1.11/drivers/scsi/mesh.c	Thu Feb  5 06:47:27 2004
+++ edited/drivers/scsi/mesh.c	Fri Feb 13 07:58:31 2004
@@ -44,8 +44,11 @@
 #include <asm/pci-bridge.h>
 #include <asm/macio.h>
 
-#include "scsi.h"
-#include "hosts.h"
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
+
 #include "mesh.h"
 
 #if 1
@@ -131,7 +134,7 @@
 	enum sdtr_phase sdtr_state;
 	int	sync_params;
 	int	data_goes_out;		/* guess as to data direction */
-	Scsi_Cmnd *current_req;
+	struct scsi_cmnd *current_req;
 	u32	saved_ptr;
 #ifdef MESH_DBG
 	int	log_ix;
@@ -147,12 +150,12 @@
 	int	dmaintr;
 	struct	Scsi_Host *host;
 	struct	mesh_state *next;
-	Scsi_Cmnd *request_q;
-	Scsi_Cmnd *request_qtail;
+	struct scsi_cmnd *request_q;
+	struct scsi_cmnd *request_qtail;
 	enum mesh_phase phase;		/* what we're currently trying to do */
 	enum msg_phase msgphase;
 	int	conn_tgt;		/* target we're connected to */
-	Scsi_Cmnd *current_req;		/* req we're currently working on */
+	struct scsi_cmnd *current_req;		/* req we're currently working on */
 	int	data_ptr;
 	int	dma_started;
 	int	dma_count;
@@ -185,7 +188,7 @@
 static void mesh_done(struct mesh_state *ms, int start_next);
 static void mesh_interrupt(int irq, void *dev_id, struct pt_regs *ptregs);
 static void cmd_complete(struct mesh_state *ms);
-static void set_dma_cmds(struct mesh_state *ms, Scsi_Cmnd *cmd);
+static void set_dma_cmds(struct mesh_state *ms, struct scsi_cmnd *cmd);
 static void halt_dma(struct mesh_state *ms);
 static void phase_mismatch(struct mesh_state *ms);
 
@@ -344,7 +347,7 @@
 /*
  * Complete a SCSI command
  */
-static void mesh_completed(struct mesh_state *ms, Scsi_Cmnd *cmd)
+static void mesh_completed(struct mesh_state *ms, struct scsi_cmnd *cmd)
 {
 	(*cmd->scsi_done)(cmd);
 }
@@ -402,14 +405,14 @@
 }
 
 
-static void mesh_start_cmd(struct mesh_state *ms, Scsi_Cmnd *cmd)
+static void mesh_start_cmd(struct mesh_state *ms, struct scsi_cmnd *cmd)
 {
 	volatile struct mesh_regs *mr = ms->mesh;
 	int t, id;
 
 	id = cmd->device->id;
 	ms->current_req = cmd;
-	ms->tgts[id].data_goes_out = cmd->sc_data_direction == SCSI_DATA_WRITE;
+	ms->tgts[id].data_goes_out = cmd->sc_data_direction == DMA_TO_DEVICE;
 	ms->tgts[id].current_req = cmd;
 
 #if 1
@@ -558,7 +561,7 @@
  */
 static void mesh_start(struct mesh_state *ms)
 {
-	Scsi_Cmnd *cmd, *prev, *next;
+	struct scsi_cmnd *cmd, *prev, *next;
 
 	if (ms->phase != idle || ms->current_req != NULL) {
 		printk(KERN_ERR "inappropriate mesh_start (phase=%d, ms=%p)",
@@ -568,14 +571,14 @@
 
 	while (ms->phase == idle) {
 		prev = NULL;
-		for (cmd = ms->request_q; ; cmd = (Scsi_Cmnd *) cmd->host_scribble) {
+		for (cmd = ms->request_q; ; cmd = (struct scsi_cmnd *) cmd->host_scribble) {
 			if (cmd == NULL)
 				return;
 			if (ms->tgts[cmd->device->id].current_req == NULL)
 				break;
 			prev = cmd;
 		}
-		next = (Scsi_Cmnd *) cmd->host_scribble;
+		next = (struct scsi_cmnd *) cmd->host_scribble;
 		if (prev == NULL)
 			ms->request_q = next;
 		else
@@ -589,7 +592,7 @@
 
 static void mesh_done(struct mesh_state *ms, int start_next)
 {
-	Scsi_Cmnd *cmd;
+	struct scsi_cmnd *cmd;
 	struct mesh_target *tp = &ms->tgts[ms->conn_tgt];
 
 	cmd = ms->current_req;
@@ -679,7 +682,7 @@
 	int i, seq, nb;
 	volatile struct mesh_regs *mr = ms->mesh;
 	volatile struct dbdma_regs *md = ms->dma;
-	Scsi_Cmnd *cmd = ms->current_req;
+	struct scsi_cmnd *cmd = ms->current_req;
 	struct mesh_target *tp = &ms->tgts[ms->conn_tgt];
 
 	dlog(ms, "start_phase nmo/exc/fc/seq = %.8x",
@@ -854,7 +857,7 @@
 static void reselected(struct mesh_state *ms)
 {
 	volatile struct mesh_regs *mr = ms->mesh;
-	Scsi_Cmnd *cmd;
+	struct scsi_cmnd *cmd;
 	struct mesh_target *tp;
 	int b, t, prev;
 
@@ -985,7 +988,7 @@
 {
 	int tgt;
 	struct mesh_target *tp;
-	Scsi_Cmnd *cmd;
+	struct scsi_cmnd *cmd;
 	volatile struct mesh_regs *mr = ms->mesh;
 
 	for (tgt = 0; tgt < 8; ++tgt) {
@@ -1000,7 +1003,7 @@
 	}
 	ms->current_req = NULL;
 	while ((cmd = ms->request_q) != NULL) {
-		ms->request_q = (Scsi_Cmnd *) cmd->host_scribble;
+		ms->request_q = (struct scsi_cmnd *) cmd->host_scribble;
 		cmd->result = DID_RESET << 16;
 		mesh_completed(ms, cmd);
 	}
@@ -1154,7 +1157,7 @@
 static void handle_msgin(struct mesh_state *ms)
 {
 	int i, code;
-	Scsi_Cmnd *cmd = ms->current_req;
+	struct scsi_cmnd *cmd = ms->current_req;
 	struct mesh_target *tp = &ms->tgts[ms->conn_tgt];
 
 	if (ms->n_msgin == 0)
@@ -1252,7 +1255,7 @@
 /*
  * Set up DMA commands for transferring data.
  */
-static void set_dma_cmds(struct mesh_state *ms, Scsi_Cmnd *cmd)
+static void set_dma_cmds(struct mesh_state *ms, struct scsi_cmnd *cmd)
 {
 	int i, dma_cmd, total, off, dtot;
 	struct scatterlist *scl;
@@ -1270,7 +1273,7 @@
 			scl = (struct scatterlist *) cmd->buffer;
 			off = ms->data_ptr;
 			nseg = pci_map_sg(ms->pdev, scl, cmd->use_sg,
-				 scsi_to_pci_dma_dir(cmd ->sc_data_direction));
+					  cmd->sc_data_direction);
 			for (i = 0; i <nseg; ++i, ++scl) {
 				u32 dma_addr = sg_dma_address(scl);
 				u32 dma_len = sg_dma_len(scl);
@@ -1324,7 +1327,7 @@
 {
 	volatile struct dbdma_regs *md = ms->dma;
 	volatile struct mesh_regs *mr = ms->mesh;
-	Scsi_Cmnd *cmd = ms->current_req;
+	struct scsi_cmnd *cmd = ms->current_req;
 	int t, nb;
 
 	if (!ms->tgts[ms->conn_tgt].data_goes_out) {
@@ -1364,8 +1367,7 @@
 	if (cmd->use_sg != 0) {
 		struct scatterlist *sg;
 		sg = (struct scatterlist *)cmd->request_buffer;
-		pci_unmap_sg(ms->pdev, sg, cmd->use_sg,
-			     scsi_to_pci_dma_dir(cmd->sc_data_direction));
+		pci_unmap_sg(ms->pdev, sg, cmd->use_sg, cmd->sc_data_direction);
 	}
 	ms->dma_started = 0;
 }
@@ -1452,7 +1454,7 @@
 static void cmd_complete(struct mesh_state *ms)
 {
 	volatile struct mesh_regs *mr = ms->mesh;
-	Scsi_Cmnd *cmd = ms->current_req;
+	struct scsi_cmnd *cmd = ms->current_req;
 	struct mesh_target *tp = &ms->tgts[ms->conn_tgt];
 	int seq, n, t;
 
@@ -1635,7 +1637,7 @@
  * Called by midlayer with host locked to queue a new
  * request
  */
-static int mesh_queue(Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
+static int mesh_queue(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 {
 	struct mesh_state *ms;
 
@@ -1692,7 +1694,7 @@
  * queue if it isn't connected yet, and for pending command, assert
  * ATN until the bus gets freed.
  */
-static int mesh_abort(Scsi_Cmnd *cmd)
+static int mesh_abort(struct scsi_cmnd *cmd)
 {
 	struct mesh_state *ms = (struct mesh_state *) cmd->device->host->hostdata;
 
@@ -1700,7 +1702,7 @@
 	mesh_dump_regs(ms);
 	dumplog(ms, cmd->device->id);
 	dumpslog(ms);
-	return SCSI_ABORT_SNOOZE;
+	return FAILED;
 }
 
 /*
@@ -1709,7 +1711,7 @@
  * The midlayer will wait for devices to come back, we don't need
  * to do that ourselves
  */
-static int mesh_host_reset(Scsi_Cmnd *cmd)
+static int mesh_host_reset(struct scsi_cmnd *cmd)
 {
 	struct mesh_state *ms = (struct mesh_state *) cmd->device->host->hostdata;
 	volatile struct mesh_regs *mr = ms->mesh;
@@ -1832,7 +1834,7 @@
 	return 0;
 }
 
-static Scsi_Host_Template mesh_template = {
+static struct scsi_host_template mesh_template = {
 	.proc_name			= "mesh",
 	.name				= "MESH",
 	.queuecommand			= mesh_queue,


