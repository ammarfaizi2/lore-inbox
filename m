Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268284AbUHQPh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268284AbUHQPh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268272AbUHQPh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:37:26 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:19423 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S268284AbUHQPRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:17:21 -0400
Message-ID: <4122213F.5020705@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:16:15 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [7/10]
Content-Type: multipart/mixed;
	boundary="------------030202000405070204000209"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030202000405070204000209
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 7bit


--------------030202000405070204000209
Content-Type: text/plain;
	name="gcc34_inline_07.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_07.diff"

--- 28p1/drivers/scsi/sim710.c~	2002-08-03 03:39:44.000000000 +0300
+++ 28p1/drivers/scsi/sim710.c	2004-08-16 23:55:56.000000000 +0300
@@ -921,172 +921,6 @@
 }
 
 
-/* A quick wrapper for sim710_intr_handle to grab the spin lock */
-
-static void
-do_sim710_intr_handle(int irq, void *dev_id, struct pt_regs *regs)
-{
-    unsigned long flags;
-
-    spin_lock_irqsave(&io_request_lock, flags);
-    sim710_intr_handle(irq, dev_id, regs);
-    spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
-
-/* A "high" level interrupt handler */
-
-static void
-sim710_intr_handle(int irq, void *dev_id, struct pt_regs *regs)
-{
-    struct Scsi_Host * host = (struct Scsi_Host *)dev_id;
-    struct sim710_hostdata *hostdata = (struct sim710_hostdata *)host->hostdata[0];
-    Scsi_Cmnd * cmd;
-    unsigned char istat, dstat;
-    unsigned char sstat0;
-    u32 scratch, dsps, resume_offset = 0;
-
-    istat = NCR_read8(ISTAT_REG);
-    if (!(istat & (ISTAT_SIP|ISTAT_DIP)))
-	return;
-    else {
-	sim710_intrs++;
-	dsps = NCR_read32(DSPS_REG);
-	hostdata->state = STATE_HALTED;
-	sstat0 = dstat = 0;
-	scratch = NCR_read32(SCRATCH_REG);
-	if (istat & ISTAT_SIP) {
-	    sstat0 = NCR_read8(SSTAT0_REG);
-	}
-	if (istat & ISTAT_DIP) {
-	    udelay(10);		/* Some comment somewhere about 10cycles
-				 * between accesses to sstat0 and dstat ??? */
-	    dstat = NCR_read8(DSTAT_REG);
-	}
-	DEB(DEB_INTS, printk("scsi%d: Int %d, istat %02x, sstat0 %02x "
-		"dstat %02x, dsp [%04x], scratch %02x\n",
-	    host->host_no, sim710_intrs, istat, sstat0, dstat,
-	    (u32 *)(bus_to_virt(NCR_read32(DSP_REG))) - hostdata->script,
-	    scratch));
-	if (scratch & 0x100) {
-	    u8 *p = hostdata->msgin_buf;
-
-	    DEB(DEB_INTS, printk("  msgin_buf: %02x %02x %02x %02x\n",
-			p[0], p[1], p[2], p[3]));
-	}
-	if ((dstat & DSTAT_SIR) && dsps == A_int_reselected) {
-	    /* Reselected.  Identify the target from LCRC_REG, and
-	     * update current command.  If we were trying to select
-	     * a device, then that command needs to go back on the
-	     * issue_queue for later.
-	     */
-	    unsigned char lcrc = NCR_read8(LCRC_REG_10);
-	    int id = 0;
-
-	    if (!(lcrc & 0x7f)) {
-		printk("scsi%d: Reselected with LCRC = %02x\n",
-			host->host_no, lcrc);
-		cmd = NULL;
-	    }
-	    else {
-		while (!(lcrc & 1)) {
-		    id++;
-		    lcrc >>= 1;
-		}
-		DEB(DEB_DISC, printk("scsi%d: Reselected by ID %d\n",
-			host->host_no, id));
-		if (hostdata->running) {
-		    /* Clear SIGP */
-		    (void)NCR_read8(CTEST2_REG_700);
-
-		    DEB(DEB_DISC, printk("scsi%d: Select of %d interrupted "
-				"by reselect from %d (%p)\n",
-				host->host_no, hostdata->running->target,
-				id, hostdata->target[id].cur_cmd));
-		    cmd = hostdata->running;
-		    hostdata->target[cmd->target].cur_cmd = NULL;
-		    cmd->SCp.ptr = (unsigned char *) hostdata->issue_queue;
-		    hostdata->issue_queue = cmd;
-		}
-		cmd = hostdata->running = hostdata->target[id].cur_cmd;
-	    }
-	}
-	else
-	    cmd = hostdata->running;
-
-	if (!cmd) {
-	    printk("scsi%d: No active command!\n", host->host_no);
-	    printk("scsi%d: Int %d, istat %02x, sstat0 %02x "
-		"dstat %02x, dsp [%04x], scratch %02x, dsps %08x\n",
-		host->host_no, sim710_intrs, istat, sstat0, dstat,
-		(u32 *)(bus_to_virt(NCR_read32(DSP_REG))) - hostdata->script,
-		NCR_read32(SCRATCH_REG), dsps);
-	    /* resume_offset is zero, which will cause a host reset */
-	}
-	else if (sstat0 & SSTAT0_700_STO) {
-	    DEB(DEB_TOUT, printk("scsi%d: Selection timeout\n", host->host_no));
-	    cmd->result = DID_NO_CONNECT << 16;
-	    SCSI_DONE(cmd);
-	    hostdata->target[cmd->target].cur_cmd = NULL;
-	    resume_offset = Ent_reselect;
-	}
-	else if (sstat0 & (SSTAT0_SGE|SSTAT0_UDC|SSTAT0_RST|SSTAT0_PAR)) {
-	    printk("scsi%d: Serious error, sstat0 = %02x\n", host->host_no,
-			    sstat0);
-	    sim710_errors++;
-	    /* resume_offset is zero, which will cause a host reset */
-	}
-	else if (dstat & (DSTAT_BF|DSTAT_ABRT|DSTAT_SSI|DSTAT_WTD)) {
-	    printk("scsi%d: Serious error, dstat = %02x\n", host->host_no,
-			    dstat);
-	    sim710_errors++;
-	    /* resume_offset is zero, which will cause a host reset */
-	}
-	else if (dstat & DSTAT_SIR)
-	    resume_offset = handle_script_int(host, cmd);
-	else if (sstat0 & SSTAT0_MA)
-	    resume_offset = handle_phase_mismatch(host, cmd);
-	else if (dstat & DSTAT_IID) {
-	    /* This can be due to a quick reselect while doing a WAIT
-	     * DISCONNECT.
-	     */
-	    resume_offset = handle_idd(host, cmd);
-	}
-	else {
-	    sim710_errors++;
-	    printk("scsi%d: Spurious interrupt!\n", host->host_no);
-	    /* resume_offset is zero, which will cause a host reset */
-	}
-    }
-
-    if (resume_offset) {
-	if (resume_offset == Ent_reselect) {
-	    hostdata->running = NULL;
-	    hostdata->state = STATE_IDLE;
-	}
-	else
-	    hostdata->state = STATE_BUSY;
-	DEB(DEB_RESUME, printk("scsi%d: Resuming at script[0x%x]\n",
-		host->host_no, resume_offset/4));
-#ifdef DEBUG_LIMIT_INTS
-	if (sim710_intrs < DEBUG_LIMIT_INTS)
-#endif
-	{
-	    NCR_write32(SCRATCH_REG, 0);
-	    NCR_write32(DSP_REG, virt_to_bus(hostdata->script+resume_offset/4));
-	}
-	if (resume_offset == Ent_reselect)
-	    run_process_issue_queue(hostdata);
-    }
-    else {
-	printk("scsi%d: Failed to handle interrupt.  Failing commands "
-		"and resetting SCSI bus and chip\n", host->host_no);
-	mdelay(1000);		/* Give chance to read screen!! */
-	full_reset(host);
-    }
-}
-
-
 static void
 run_command (struct sim710_hostdata *hostdata, Scsi_Cmnd *cmd)
 {
@@ -1284,6 +1118,172 @@
 }
 
 
+/* A quick wrapper for sim710_intr_handle to grab the spin lock */
+
+static void
+do_sim710_intr_handle(int irq, void *dev_id, struct pt_regs *regs)
+{
+    unsigned long flags;
+
+    spin_lock_irqsave(&io_request_lock, flags);
+    sim710_intr_handle(irq, dev_id, regs);
+    spin_unlock_irqrestore(&io_request_lock, flags);
+}
+
+
+/* A "high" level interrupt handler */
+
+static void
+sim710_intr_handle(int irq, void *dev_id, struct pt_regs *regs)
+{
+    struct Scsi_Host * host = (struct Scsi_Host *)dev_id;
+    struct sim710_hostdata *hostdata = (struct sim710_hostdata *)host->hostdata[0];
+    Scsi_Cmnd * cmd;
+    unsigned char istat, dstat;
+    unsigned char sstat0;
+    u32 scratch, dsps, resume_offset = 0;
+
+    istat = NCR_read8(ISTAT_REG);
+    if (!(istat & (ISTAT_SIP|ISTAT_DIP)))
+	return;
+    else {
+	sim710_intrs++;
+	dsps = NCR_read32(DSPS_REG);
+	hostdata->state = STATE_HALTED;
+	sstat0 = dstat = 0;
+	scratch = NCR_read32(SCRATCH_REG);
+	if (istat & ISTAT_SIP) {
+	    sstat0 = NCR_read8(SSTAT0_REG);
+	}
+	if (istat & ISTAT_DIP) {
+	    udelay(10);		/* Some comment somewhere about 10cycles
+				 * between accesses to sstat0 and dstat ??? */
+	    dstat = NCR_read8(DSTAT_REG);
+	}
+	DEB(DEB_INTS, printk("scsi%d: Int %d, istat %02x, sstat0 %02x "
+		"dstat %02x, dsp [%04x], scratch %02x\n",
+	    host->host_no, sim710_intrs, istat, sstat0, dstat,
+	    (u32 *)(bus_to_virt(NCR_read32(DSP_REG))) - hostdata->script,
+	    scratch));
+	if (scratch & 0x100) {
+	    u8 *p = hostdata->msgin_buf;
+
+	    DEB(DEB_INTS, printk("  msgin_buf: %02x %02x %02x %02x\n",
+			p[0], p[1], p[2], p[3]));
+	}
+	if ((dstat & DSTAT_SIR) && dsps == A_int_reselected) {
+	    /* Reselected.  Identify the target from LCRC_REG, and
+	     * update current command.  If we were trying to select
+	     * a device, then that command needs to go back on the
+	     * issue_queue for later.
+	     */
+	    unsigned char lcrc = NCR_read8(LCRC_REG_10);
+	    int id = 0;
+
+	    if (!(lcrc & 0x7f)) {
+		printk("scsi%d: Reselected with LCRC = %02x\n",
+			host->host_no, lcrc);
+		cmd = NULL;
+	    }
+	    else {
+		while (!(lcrc & 1)) {
+		    id++;
+		    lcrc >>= 1;
+		}
+		DEB(DEB_DISC, printk("scsi%d: Reselected by ID %d\n",
+			host->host_no, id));
+		if (hostdata->running) {
+		    /* Clear SIGP */
+		    (void)NCR_read8(CTEST2_REG_700);
+
+		    DEB(DEB_DISC, printk("scsi%d: Select of %d interrupted "
+				"by reselect from %d (%p)\n",
+				host->host_no, hostdata->running->target,
+				id, hostdata->target[id].cur_cmd));
+		    cmd = hostdata->running;
+		    hostdata->target[cmd->target].cur_cmd = NULL;
+		    cmd->SCp.ptr = (unsigned char *) hostdata->issue_queue;
+		    hostdata->issue_queue = cmd;
+		}
+		cmd = hostdata->running = hostdata->target[id].cur_cmd;
+	    }
+	}
+	else
+	    cmd = hostdata->running;
+
+	if (!cmd) {
+	    printk("scsi%d: No active command!\n", host->host_no);
+	    printk("scsi%d: Int %d, istat %02x, sstat0 %02x "
+		"dstat %02x, dsp [%04x], scratch %02x, dsps %08x\n",
+		host->host_no, sim710_intrs, istat, sstat0, dstat,
+		(u32 *)(bus_to_virt(NCR_read32(DSP_REG))) - hostdata->script,
+		NCR_read32(SCRATCH_REG), dsps);
+	    /* resume_offset is zero, which will cause a host reset */
+	}
+	else if (sstat0 & SSTAT0_700_STO) {
+	    DEB(DEB_TOUT, printk("scsi%d: Selection timeout\n", host->host_no));
+	    cmd->result = DID_NO_CONNECT << 16;
+	    SCSI_DONE(cmd);
+	    hostdata->target[cmd->target].cur_cmd = NULL;
+	    resume_offset = Ent_reselect;
+	}
+	else if (sstat0 & (SSTAT0_SGE|SSTAT0_UDC|SSTAT0_RST|SSTAT0_PAR)) {
+	    printk("scsi%d: Serious error, sstat0 = %02x\n", host->host_no,
+			    sstat0);
+	    sim710_errors++;
+	    /* resume_offset is zero, which will cause a host reset */
+	}
+	else if (dstat & (DSTAT_BF|DSTAT_ABRT|DSTAT_SSI|DSTAT_WTD)) {
+	    printk("scsi%d: Serious error, dstat = %02x\n", host->host_no,
+			    dstat);
+	    sim710_errors++;
+	    /* resume_offset is zero, which will cause a host reset */
+	}
+	else if (dstat & DSTAT_SIR)
+	    resume_offset = handle_script_int(host, cmd);
+	else if (sstat0 & SSTAT0_MA)
+	    resume_offset = handle_phase_mismatch(host, cmd);
+	else if (dstat & DSTAT_IID) {
+	    /* This can be due to a quick reselect while doing a WAIT
+	     * DISCONNECT.
+	     */
+	    resume_offset = handle_idd(host, cmd);
+	}
+	else {
+	    sim710_errors++;
+	    printk("scsi%d: Spurious interrupt!\n", host->host_no);
+	    /* resume_offset is zero, which will cause a host reset */
+	}
+    }
+
+    if (resume_offset) {
+	if (resume_offset == Ent_reselect) {
+	    hostdata->running = NULL;
+	    hostdata->state = STATE_IDLE;
+	}
+	else
+	    hostdata->state = STATE_BUSY;
+	DEB(DEB_RESUME, printk("scsi%d: Resuming at script[0x%x]\n",
+		host->host_no, resume_offset/4));
+#ifdef DEBUG_LIMIT_INTS
+	if (sim710_intrs < DEBUG_LIMIT_INTS)
+#endif
+	{
+	    NCR_write32(SCRATCH_REG, 0);
+	    NCR_write32(DSP_REG, virt_to_bus(hostdata->script+resume_offset/4));
+	}
+	if (resume_offset == Ent_reselect)
+	    run_process_issue_queue(hostdata);
+    }
+    else {
+	printk("scsi%d: Failed to handle interrupt.  Failing commands "
+		"and resetting SCSI bus and chip\n", host->host_no);
+	mdelay(1000);		/* Give chance to read screen!! */
+	full_reset(host);
+    }
+}
+
+
 int
 sim710_queuecommand(Scsi_Cmnd * cmd, void (*done)(Scsi_Cmnd *))
 {
--- 28p1/drivers/scsi/ips.c~	2004-08-08 02:26:05.000000000 +0300
+++ 28p1/drivers/scsi/ips.c	2004-08-17 00:09:52.000000000 +0300
@@ -802,6 +802,168 @@
 
 /****************************************************************************/
 /*                                                                          */
+/* Routine Name: ips_removeq_copp_head                                      */
+/*                                                                          */
+/* Routine Description:                                                     */
+/*                                                                          */
+/*   Remove the head of the queue                                           */
+/*                                                                          */
+/* ASSUMED to be called from within the HA lock                             */
+/*                                                                          */
+/****************************************************************************/
+static inline ips_copp_wait_item_t *
+ips_removeq_copp_head(ips_copp_queue_t * queue)
+{
+	ips_copp_wait_item_t *item;
+
+	METHOD_TRACE("ips_removeq_copp_head", 1);
+
+	item = queue->head;
+
+	if (!item) {
+		return (NULL);
+	}
+
+	queue->head = item->next;
+	item->next = NULL;
+
+	if (queue->tail == item)
+		queue->tail = NULL;
+
+	queue->count--;
+
+	return (item);
+}
+
+/****************************************************************************/
+/*                                                                          */
+/* Routine Name: ips_removeq_copp                                           */
+/*                                                                          */
+/* Routine Description:                                                     */
+/*                                                                          */
+/*   Remove an item from a queue                                            */
+/*                                                                          */
+/* ASSUMED to be called from within the HA lock                             */
+/*                                                                          */
+/****************************************************************************/
+static inline ips_copp_wait_item_t *
+ips_removeq_copp(ips_copp_queue_t * queue, ips_copp_wait_item_t * item)
+{
+	ips_copp_wait_item_t *p;
+
+	METHOD_TRACE("ips_removeq_copp", 1);
+
+	if (!item)
+		return (NULL);
+
+	if (item == queue->head) {
+		return (ips_removeq_copp_head(queue));
+	}
+
+	p = queue->head;
+
+	while ((p) && (item != p->next))
+		p = p->next;
+
+	if (p) {
+		/* found a match */
+		p->next = item->next;
+
+		if (!item->next)
+			queue->tail = p;
+
+		item->next = NULL;
+		queue->count--;
+
+		return (item);
+	}
+
+	return (NULL);
+}
+
+/****************************************************************************/
+/*                                                                          */
+/* Routine Name: ips_removeq_wait_head                                      */
+/*                                                                          */
+/* Routine Description:                                                     */
+/*                                                                          */
+/*   Remove the head of the queue                                           */
+/*                                                                          */
+/* ASSUMED to be called from within the HA lock                             */
+/*                                                                          */
+/****************************************************************************/
+static inline Scsi_Cmnd *
+ips_removeq_wait_head(ips_wait_queue_t * queue)
+{
+	Scsi_Cmnd *item;
+
+	METHOD_TRACE("ips_removeq_wait_head", 1);
+
+	item = queue->head;
+
+	if (!item) {
+		return (NULL);
+	}
+
+	queue->head = (Scsi_Cmnd *) item->host_scribble;
+	item->host_scribble = NULL;
+
+	if (queue->tail == item)
+		queue->tail = NULL;
+
+	queue->count--;
+
+	return (item);
+}
+
+/****************************************************************************/
+/*                                                                          */
+/* Routine Name: ips_removeq_wait                                           */
+/*                                                                          */
+/* Routine Description:                                                     */
+/*                                                                          */
+/*   Remove an item from a queue                                            */
+/*                                                                          */
+/* ASSUMED to be called from within the HA lock                             */
+/*                                                                          */
+/****************************************************************************/
+static inline Scsi_Cmnd *
+ips_removeq_wait(ips_wait_queue_t * queue, Scsi_Cmnd * item)
+{
+	Scsi_Cmnd *p;
+
+	METHOD_TRACE("ips_removeq_wait", 1);
+
+	if (!item)
+		return (NULL);
+
+	if (item == queue->head) {
+		return (ips_removeq_wait_head(queue));
+	}
+
+	p = queue->head;
+
+	while ((p) && (item != (Scsi_Cmnd *) p->host_scribble))
+		p = (Scsi_Cmnd *) p->host_scribble;
+
+	if (p) {
+		/* found a match */
+		p->host_scribble = item->host_scribble;
+
+		if (!item->host_scribble)
+			queue->tail = p;
+
+		item->host_scribble = NULL;
+		queue->count--;
+
+		return (item);
+	}
+
+	return (NULL);
+}
+
+/****************************************************************************/
+/*                                                                          */
 /* Routine Name: ips_eh_abort                                               */
 /*                                                                          */
 /* Routine Description:                                                     */
@@ -859,6 +1021,87 @@
 
 /****************************************************************************/
 /*                                                                          */
+/* Routine Name: ips_removeq_scb_head                                       */
+/*                                                                          */
+/* Routine Description:                                                     */
+/*                                                                          */
+/*   Remove the head of the queue                                           */
+/*                                                                          */
+/* ASSUMED to be called from within the HA lock                             */
+/*                                                                          */
+/****************************************************************************/
+static inline ips_scb_t *
+ips_removeq_scb_head(ips_scb_queue_t * queue)
+{
+	ips_scb_t *item;
+
+	METHOD_TRACE("ips_removeq_scb_head", 1);
+
+	item = queue->head;
+
+	if (!item) {
+		return (NULL);
+	}
+
+	queue->head = item->q_next;
+	item->q_next = NULL;
+
+	if (queue->tail == item)
+		queue->tail = NULL;
+
+	queue->count--;
+
+	return (item);
+}
+
+/****************************************************************************/
+/*                                                                          */
+/* Routine Name: ips_removeq_scb                                            */
+/*                                                                          */
+/* Routine Description:                                                     */
+/*                                                                          */
+/*   Remove an item from a queue                                            */
+/*                                                                          */
+/* ASSUMED to be called from within the HA lock                             */
+/*                                                                          */
+/****************************************************************************/
+static inline ips_scb_t *
+ips_removeq_scb(ips_scb_queue_t * queue, ips_scb_t * item)
+{
+	ips_scb_t *p;
+
+	METHOD_TRACE("ips_removeq_scb", 1);
+
+	if (!item)
+		return (NULL);
+
+	if (item == queue->head) {
+		return (ips_removeq_scb_head(queue));
+	}
+
+	p = queue->head;
+
+	while ((p) && (item != p->q_next))
+		p = p->q_next;
+
+	if (p) {
+		/* found a match */
+		p->q_next = item->q_next;
+
+		if (!item->q_next)
+			queue->tail = p;
+
+		item->q_next = NULL;
+		queue->count--;
+
+		return (item);
+	}
+
+	return (NULL);
+}
+
+/****************************************************************************/
+/*                                                                          */
 /* Routine Name: ips_eh_reset                                               */
 /*                                                                          */
 /* Routine Description:                                                     */
@@ -1058,21 +1301,85 @@
 
 /****************************************************************************/
 /*                                                                          */
-/* Routine Name: ips_queue                                                  */
+/* Routine Name: ips_putq_copp_tail                                         */
 /*                                                                          */
 /* Routine Description:                                                     */
 /*                                                                          */
-/*   Send a command to the controller                                       */
+/*   Add an item to the tail of the queue                                   */
 /*                                                                          */
-/* NOTE:                                                                    */
-/*    Linux obtains io_request_lock before calling this function            */
+/* ASSUMED to be called from within the HA lock                             */
 /*                                                                          */
 /****************************************************************************/
-int
-ips_queue(Scsi_Cmnd * SC, void (*done) (Scsi_Cmnd *))
+static inline void
+ips_putq_copp_tail(ips_copp_queue_t * queue, ips_copp_wait_item_t * item)
 {
-	ips_ha_t *ha;
-	ips_passthru_t *pt;
+	METHOD_TRACE("ips_putq_copp_tail", 1);
+
+	if (!item)
+		return;
+
+	item->next = NULL;
+
+	if (queue->tail)
+		queue->tail->next = item;
+
+	queue->tail = item;
+
+	if (!queue->head)
+		queue->head = item;
+
+	queue->count++;
+}
+
+/****************************************************************************/
+/*                                                                          */
+/* Routine Name: ips_putq_wait_tail                                         */
+/*                                                                          */
+/* Routine Description:                                                     */
+/*                                                                          */
+/*   Add an item to the tail of the queue                                   */
+/*                                                                          */
+/* ASSUMED to be called from within the HA lock                             */
+/*                                                                          */
+/****************************************************************************/
+static inline void
+ips_putq_wait_tail(ips_wait_queue_t * queue, Scsi_Cmnd * item)
+{
+	METHOD_TRACE("ips_putq_wait_tail", 1);
+
+	if (!item)
+		return;
+
+	item->host_scribble = NULL;
+
+	if (queue->tail)
+		queue->tail->host_scribble = (char *) item;
+
+	queue->tail = item;
+
+	if (!queue->head)
+		queue->head = item;
+
+	queue->count++;
+}
+
+/****************************************************************************/
+/*                                                                          */
+/* Routine Name: ips_queue                                                  */
+/*                                                                          */
+/* Routine Description:                                                     */
+/*                                                                          */
+/*   Send a command to the controller                                       */
+/*                                                                          */
+/* NOTE:                                                                    */
+/*    Linux obtains io_request_lock before calling this function            */
+/*                                                                          */
+/****************************************************************************/
+int
+ips_queue(Scsi_Cmnd * SC, void (*done) (Scsi_Cmnd *))
+{
+	ips_ha_t *ha;
+	ips_passthru_t *pt;
 
 	METHOD_TRACE("ips_queue", 1);
 
@@ -2693,6 +3000,66 @@
 
 /****************************************************************************/
 /*                                                                          */
+/* Routine Name: ips_putq_scb_head                                          */
+/*                                                                          */
+/* Routine Description:                                                     */
+/*                                                                          */
+/*   Add an item to the head of the queue                                   */
+/*                                                                          */
+/* ASSUMED to be called from within the HA lock                             */
+/*                                                                          */
+/****************************************************************************/
+static inline void
+ips_putq_scb_head(ips_scb_queue_t * queue, ips_scb_t * item)
+{
+	METHOD_TRACE("ips_putq_scb_head", 1);
+
+	if (!item)
+		return;
+
+	item->q_next = queue->head;
+	queue->head = item;
+
+	if (!queue->tail)
+		queue->tail = item;
+
+	queue->count++;
+}
+
+/****************************************************************************/
+/*                                                                          */
+/* Routine Name: ips_putq_scb_tail                                          */
+/*                                                                          */
+/* Routine Description:                                                     */
+/*                                                                          */
+/*   Add an item to the tail of the queue                                   */
+/*                                                                          */
+/* ASSUMED to be called from within the HA lock                             */
+/*                                                                          */
+/****************************************************************************/
+static inline void
+ips_putq_scb_tail(ips_scb_queue_t * queue, ips_scb_t * item)
+{
+	METHOD_TRACE("ips_putq_scb_tail", 1);
+
+	if (!item)
+		return;
+
+	item->q_next = NULL;
+
+	if (queue->tail)
+		queue->tail->q_next = item;
+
+	queue->tail = item;
+
+	if (!queue->head)
+		queue->head = item;
+
+	queue->count++;
+}
+
+/****************************************************************************/
+/*                                                                          */
 /* Routine Name: ips_next                                                   */
 /*                                                                          */
 /* Routine Description:                                                     */
@@ -2944,147 +3311,6 @@
 
 /****************************************************************************/
 /*                                                                          */
-/* Routine Name: ips_putq_scb_head                                          */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Add an item to the head of the queue                                   */
-/*                                                                          */
-/* ASSUMED to be called from within the HA lock                             */
-/*                                                                          */
-/****************************************************************************/
-static inline void
-ips_putq_scb_head(ips_scb_queue_t * queue, ips_scb_t * item)
-{
-	METHOD_TRACE("ips_putq_scb_head", 1);
-
-	if (!item)
-		return;
-
-	item->q_next = queue->head;
-	queue->head = item;
-
-	if (!queue->tail)
-		queue->tail = item;
-
-	queue->count++;
-}
-
-/****************************************************************************/
-/*                                                                          */
-/* Routine Name: ips_putq_scb_tail                                          */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Add an item to the tail of the queue                                   */
-/*                                                                          */
-/* ASSUMED to be called from within the HA lock                             */
-/*                                                                          */
-/****************************************************************************/
-static inline void
-ips_putq_scb_tail(ips_scb_queue_t * queue, ips_scb_t * item)
-{
-	METHOD_TRACE("ips_putq_scb_tail", 1);
-
-	if (!item)
-		return;
-
-	item->q_next = NULL;
-
-	if (queue->tail)
-		queue->tail->q_next = item;
-
-	queue->tail = item;
-
-	if (!queue->head)
-		queue->head = item;
-
-	queue->count++;
-}
-
-/****************************************************************************/
-/*                                                                          */
-/* Routine Name: ips_removeq_scb_head                                       */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Remove the head of the queue                                           */
-/*                                                                          */
-/* ASSUMED to be called from within the HA lock                             */
-/*                                                                          */
-/****************************************************************************/
-static inline ips_scb_t *
-ips_removeq_scb_head(ips_scb_queue_t * queue)
-{
-	ips_scb_t *item;
-
-	METHOD_TRACE("ips_removeq_scb_head", 1);
-
-	item = queue->head;
-
-	if (!item) {
-		return (NULL);
-	}
-
-	queue->head = item->q_next;
-	item->q_next = NULL;
-
-	if (queue->tail == item)
-		queue->tail = NULL;
-
-	queue->count--;
-
-	return (item);
-}
-
-/****************************************************************************/
-/*                                                                          */
-/* Routine Name: ips_removeq_scb                                            */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Remove an item from a queue                                            */
-/*                                                                          */
-/* ASSUMED to be called from within the HA lock                             */
-/*                                                                          */
-/****************************************************************************/
-static inline ips_scb_t *
-ips_removeq_scb(ips_scb_queue_t * queue, ips_scb_t * item)
-{
-	ips_scb_t *p;
-
-	METHOD_TRACE("ips_removeq_scb", 1);
-
-	if (!item)
-		return (NULL);
-
-	if (item == queue->head) {
-		return (ips_removeq_scb_head(queue));
-	}
-
-	p = queue->head;
-
-	while ((p) && (item != p->q_next))
-		p = p->q_next;
-
-	if (p) {
-		/* found a match */
-		p->q_next = item->q_next;
-
-		if (!item->q_next)
-			queue->tail = p;
-
-		item->q_next = NULL;
-		queue->count--;
-
-		return (item);
-	}
-
-	return (NULL);
-}
-
-/****************************************************************************/
-/*                                                                          */
 /* Routine Name: ips_putq_wait_head                                         */
 /*                                                                          */
 /* Routine Description:                                                     */
@@ -3113,119 +3339,6 @@
 
 /****************************************************************************/
 /*                                                                          */
-/* Routine Name: ips_putq_wait_tail                                         */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Add an item to the tail of the queue                                   */
-/*                                                                          */
-/* ASSUMED to be called from within the HA lock                             */
-/*                                                                          */
-/****************************************************************************/
-static inline void
-ips_putq_wait_tail(ips_wait_queue_t * queue, Scsi_Cmnd * item)
-{
-	METHOD_TRACE("ips_putq_wait_tail", 1);
-
-	if (!item)
-		return;
-
-	item->host_scribble = NULL;
-
-	if (queue->tail)
-		queue->tail->host_scribble = (char *) item;
-
-	queue->tail = item;
-
-	if (!queue->head)
-		queue->head = item;
-
-	queue->count++;
-}
-
-/****************************************************************************/
-/*                                                                          */
-/* Routine Name: ips_removeq_wait_head                                      */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Remove the head of the queue                                           */
-/*                                                                          */
-/* ASSUMED to be called from within the HA lock                             */
-/*                                                                          */
-/****************************************************************************/
-static inline Scsi_Cmnd *
-ips_removeq_wait_head(ips_wait_queue_t * queue)
-{
-	Scsi_Cmnd *item;
-
-	METHOD_TRACE("ips_removeq_wait_head", 1);
-
-	item = queue->head;
-
-	if (!item) {
-		return (NULL);
-	}
-
-	queue->head = (Scsi_Cmnd *) item->host_scribble;
-	item->host_scribble = NULL;
-
-	if (queue->tail == item)
-		queue->tail = NULL;
-
-	queue->count--;
-
-	return (item);
-}
-
-/****************************************************************************/
-/*                                                                          */
-/* Routine Name: ips_removeq_wait                                           */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Remove an item from a queue                                            */
-/*                                                                          */
-/* ASSUMED to be called from within the HA lock                             */
-/*                                                                          */
-/****************************************************************************/
-static inline Scsi_Cmnd *
-ips_removeq_wait(ips_wait_queue_t * queue, Scsi_Cmnd * item)
-{
-	Scsi_Cmnd *p;
-
-	METHOD_TRACE("ips_removeq_wait", 1);
-
-	if (!item)
-		return (NULL);
-
-	if (item == queue->head) {
-		return (ips_removeq_wait_head(queue));
-	}
-
-	p = queue->head;
-
-	while ((p) && (item != (Scsi_Cmnd *) p->host_scribble))
-		p = (Scsi_Cmnd *) p->host_scribble;
-
-	if (p) {
-		/* found a match */
-		p->host_scribble = item->host_scribble;
-
-		if (!item->host_scribble)
-			queue->tail = p;
-
-		item->host_scribble = NULL;
-		queue->count--;
-
-		return (item);
-	}
-
-	return (NULL);
-}
-
-/****************************************************************************/
-/*                                                                          */
 /* Routine Name: ips_putq_copp_head                                         */
 /*                                                                          */
 /* Routine Description:                                                     */
@@ -3254,119 +3367,6 @@
 
 /****************************************************************************/
 /*                                                                          */
-/* Routine Name: ips_putq_copp_tail                                         */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Add an item to the tail of the queue                                   */
-/*                                                                          */
-/* ASSUMED to be called from within the HA lock                             */
-/*                                                                          */
-/****************************************************************************/
-static inline void
-ips_putq_copp_tail(ips_copp_queue_t * queue, ips_copp_wait_item_t * item)
-{
-	METHOD_TRACE("ips_putq_copp_tail", 1);
-
-	if (!item)
-		return;
-
-	item->next = NULL;
-
-	if (queue->tail)
-		queue->tail->next = item;
-
-	queue->tail = item;
-
-	if (!queue->head)
-		queue->head = item;
-
-	queue->count++;
-}
-
-/****************************************************************************/
-/*                                                                          */
-/* Routine Name: ips_removeq_copp_head                                      */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Remove the head of the queue                                           */
-/*                                                                          */
-/* ASSUMED to be called from within the HA lock                             */
-/*                                                                          */
-/****************************************************************************/
-static inline ips_copp_wait_item_t *
-ips_removeq_copp_head(ips_copp_queue_t * queue)
-{
-	ips_copp_wait_item_t *item;
-
-	METHOD_TRACE("ips_removeq_copp_head", 1);
-
-	item = queue->head;
-
-	if (!item) {
-		return (NULL);
-	}
-
-	queue->head = item->next;
-	item->next = NULL;
-
-	if (queue->tail == item)
-		queue->tail = NULL;
-
-	queue->count--;
-
-	return (item);
-}
-
-/****************************************************************************/
-/*                                                                          */
-/* Routine Name: ips_removeq_copp                                           */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Remove an item from a queue                                            */
-/*                                                                          */
-/* ASSUMED to be called from within the HA lock                             */
-/*                                                                          */
-/****************************************************************************/
-static inline ips_copp_wait_item_t *
-ips_removeq_copp(ips_copp_queue_t * queue, ips_copp_wait_item_t * item)
-{
-	ips_copp_wait_item_t *p;
-
-	METHOD_TRACE("ips_removeq_copp", 1);
-
-	if (!item)
-		return (NULL);
-
-	if (item == queue->head) {
-		return (ips_removeq_copp_head(queue));
-	}
-
-	p = queue->head;
-
-	while ((p) && (item != p->next))
-		p = p->next;
-
-	if (p) {
-		/* found a match */
-		p->next = item->next;
-
-		if (!item->next)
-			queue->tail = p;
-
-		item->next = NULL;
-		queue->count--;
-
-		return (item);
-	}
-
-	return (NULL);
-}
-
-/****************************************************************************/
-/*                                                                          */
 /* Routine Name: ipsintr_blocking                                           */
 /*                                                                          */
 /* Routine Description:                                                     */
--- 28p1/drivers/scsi/qla1280.c~	2003-11-28 20:26:20.000000000 +0200
+++ 28p1/drivers/scsi/qla1280.c	2004-08-17 00:13:42.000000000 +0300
@@ -875,6 +875,41 @@
 }
 
 
+ /*
+    * qla2100_enable_intrs
+    * qla2100_disable_intrs
+    *
+    * Input:
+    *      ha = adapter block pointer.
+    *
+    * Returns:
+    *      None
+  */
+static inline void
+qla1280_enable_intrs(struct scsi_qla_host *ha)
+{
+	struct device_reg *reg;
+
+	reg = ha->iobase;
+	/* enable risc and host interrupts */
+	WRT_REG_WORD(&reg->ictrl, (ISP_EN_INT | ISP_EN_RISC));
+	RD_REG_WORD(&reg->ictrl);	/* PCI Posted Write flush */
+	ha->flags.ints_enabled = 1;
+}
+
+static inline void
+qla1280_disable_intrs(struct scsi_qla_host *ha)
+{
+	struct device_reg *reg;
+
+	reg = ha->iobase;
+	/* disable risc and host interrupts */
+	WRT_REG_WORD(&reg->ictrl, 0);
+	RD_REG_WORD(&reg->ictrl);	/* PCI Posted Write flush */
+	ha->flags.ints_enabled = 0;
+}
+
+
 /**************************************************************************
  * qla1280_do_device_init
  *    This routine will register the device with the SCSI subsystem,
@@ -2049,40 +2084,6 @@
 /*                QLogic ISP1280 Hardware Support Functions.                */
 /****************************************************************************/
 
- /*
-    * qla2100_enable_intrs
-    * qla2100_disable_intrs
-    *
-    * Input:
-    *      ha = adapter block pointer.
-    *
-    * Returns:
-    *      None
-  */
-static inline void
-qla1280_enable_intrs(struct scsi_qla_host *ha)
-{
-	struct device_reg *reg;
-
-	reg = ha->iobase;
-	/* enable risc and host interrupts */
-	WRT_REG_WORD(&reg->ictrl, (ISP_EN_INT | ISP_EN_RISC));
-	RD_REG_WORD(&reg->ictrl);	/* PCI Posted Write flush */
-	ha->flags.ints_enabled = 1;
-}
-
-static inline void
-qla1280_disable_intrs(struct scsi_qla_host *ha)
-{
-	struct device_reg *reg;
-
-	reg = ha->iobase;
-	/* disable risc and host interrupts */
-	WRT_REG_WORD(&reg->ictrl, 0);
-	RD_REG_WORD(&reg->ictrl);	/* PCI Posted Write flush */
-	ha->flags.ints_enabled = 0;
-}
-
 /*
  * qla1280_initialize_adapter
  *      Initialize board.
--- 28p1/drivers/scsi/scsiiom.c~	2000-12-31 21:06:00.000000000 +0200
+++ 28p1/drivers/scsi/scsiiom.c	2004-08-17 00:29:30.000000000 +0300
@@ -211,6 +211,24 @@
 };
 #endif
 
+static void __inline__
+dc390_InvalidCmd( PACB pACB )
+{
+    if( pACB->pActiveDCB->pActiveSRB->SRBState & (SRB_START_+SRB_MSGOUT) )
+	DC390_write8 (ScsiCmd, CLEAR_FIFO_CMD);
+}
+
+#define DC390_ENABLE_MSGOUT DC390_write8 (ScsiCmd, SET_ATN_CMD)
+
+/* abort command */
+static void __inline__
+dc390_EnableMsgOut_Abort ( PACB pACB, PSRB pSRB )
+{
+    pSRB->MsgOutBuf[0] = ABORT; 
+    pSRB->MsgCnt = 1; DC390_ENABLE_MSGOUT;
+    pSRB->pSRBDCB->DCBFlag &= ~ABORT_DEV_;
+}
+
 void __inline__
 DC390_Interrupt( int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -569,8 +587,6 @@
 };
 #endif
 
-#define DC390_ENABLE_MSGOUT DC390_write8 (ScsiCmd, SET_ATN_CMD)
-
 /* reject_msg */
 static void __inline__
 dc390_MsgIn_reject (PACB pACB, PSRB pSRB)
@@ -580,15 +596,6 @@
   DEBUG0 (printk (KERN_INFO "DC390: Reject message\n");)
 }
 
-/* abort command */
-static void __inline__
-dc390_EnableMsgOut_Abort ( PACB pACB, PSRB pSRB )
-{
-    pSRB->MsgOutBuf[0] = ABORT; 
-    pSRB->MsgCnt = 1; DC390_ENABLE_MSGOUT;
-    pSRB->pSRBDCB->DCBFlag &= ~ABORT_DEV_;
-}
-
 static PSRB
 dc390_MsgIn_QTag (PACB pACB, PDCB pDCB, UCHAR tag)
 {
@@ -1355,6 +1362,47 @@
 };
 
 
+static void __inline__
+dc390_RequestSense( PACB pACB, PDCB pDCB, PSRB pSRB )
+{
+    PSCSICMD  pcmd;
+
+    REMOVABLEDEBUG(printk (KERN_INFO "DC390: RequestSense (Cmd %02x, Id %02x, LUN %02x)\n",\
+	    pSRB->pcmd->cmnd[0], pDCB->TargetID, pDCB->TargetLUN);)
+
+    pSRB->SRBFlag |= AUTO_REQSENSE;
+    //pSRB->Segment0[0] = (UINT) pSRB->CmdBlock[0];
+    //pSRB->Segment0[1] = (UINT) pSRB->CmdBlock[4];
+    //pSRB->Segment1[0] = ((UINT)(pSRB->pcmd->cmd_len) << 8) + pSRB->SGcount;
+    //pSRB->Segment1[1] = pSRB->TotalXferredLen;
+    pSRB->SavedSGCount = pSRB->SGcount;
+    pSRB->SavedTotXLen = pSRB->TotalXferredLen;
+    pSRB->AdaptStatus = 0;
+    pSRB->TargetStatus = 0; /* CHECK_CONDITION<<1; */
+
+    pcmd = pSRB->pcmd;
+
+    pSRB->Segmentx.address = (PUCHAR) &(pcmd->sense_buffer);
+    pSRB->Segmentx.length = sizeof(pcmd->sense_buffer);
+    pSRB->pSegmentList = &pSRB->Segmentx;
+    pSRB->SGcount = 1;
+    pSRB->SGIndex = 0;
+
+    //pSRB->CmdBlock[0] = REQUEST_SENSE;
+    //pSRB->CmdBlock[1] = pDCB->TargetLUN << 5;
+    //(USHORT) pSRB->CmdBlock[2] = 0;
+    //(USHORT) pSRB->CmdBlock[4] = sizeof(pcmd->sense_buffer);
+    //pSRB->ScsiCmdLen = 6;
+
+    pSRB->TotalXferredLen = 0;
+    pSRB->SGToBeXferLen = 0;
+    if( dc390_StartSCSI( pACB, pDCB, pSRB ) ) {
+	dc390_Going_to_Waiting ( pDCB, pSRB );
+	dc390_waiting_timer (pACB, HZ/5);
+    }
+}
+
+
 void
 dc390_SRBdone( PACB pACB, PDCB pDCB, PSRB pSRB )
 {
@@ -1738,53 +1786,3 @@
     return;
 }
 
-
-static void __inline__
-dc390_RequestSense( PACB pACB, PDCB pDCB, PSRB pSRB )
-{
-    PSCSICMD  pcmd;
-
-    REMOVABLEDEBUG(printk (KERN_INFO "DC390: RequestSense (Cmd %02x, Id %02x, LUN %02x)\n",\
-	    pSRB->pcmd->cmnd[0], pDCB->TargetID, pDCB->TargetLUN);)
-
-    pSRB->SRBFlag |= AUTO_REQSENSE;
-    //pSRB->Segment0[0] = (UINT) pSRB->CmdBlock[0];
-    //pSRB->Segment0[1] = (UINT) pSRB->CmdBlock[4];
-    //pSRB->Segment1[0] = ((UINT)(pSRB->pcmd->cmd_len) << 8) + pSRB->SGcount;
-    //pSRB->Segment1[1] = pSRB->TotalXferredLen;
-    pSRB->SavedSGCount = pSRB->SGcount;
-    pSRB->SavedTotXLen = pSRB->TotalXferredLen;
-    pSRB->AdaptStatus = 0;
-    pSRB->TargetStatus = 0; /* CHECK_CONDITION<<1; */
-
-    pcmd = pSRB->pcmd;
-
-    pSRB->Segmentx.address = (PUCHAR) &(pcmd->sense_buffer);
-    pSRB->Segmentx.length = sizeof(pcmd->sense_buffer);
-    pSRB->pSegmentList = &pSRB->Segmentx;
-    pSRB->SGcount = 1;
-    pSRB->SGIndex = 0;
-
-    //pSRB->CmdBlock[0] = REQUEST_SENSE;
-    //pSRB->CmdBlock[1] = pDCB->TargetLUN << 5;
-    //(USHORT) pSRB->CmdBlock[2] = 0;
-    //(USHORT) pSRB->CmdBlock[4] = sizeof(pcmd->sense_buffer);
-    //pSRB->ScsiCmdLen = 6;
-
-    pSRB->TotalXferredLen = 0;
-    pSRB->SGToBeXferLen = 0;
-    if( dc390_StartSCSI( pACB, pDCB, pSRB ) ) {
-	dc390_Going_to_Waiting ( pDCB, pSRB );
-	dc390_waiting_timer (pACB, HZ/5);
-    }
-}
-
-
-
-static void __inline__
-dc390_InvalidCmd( PACB pACB )
-{
-    if( pACB->pActiveDCB->pActiveSRB->SRBState & (SRB_START_+SRB_MSGOUT) )
-	DC390_write8 (ScsiCmd, CLEAR_FIFO_CMD);
-}
-
--- 28p1/drivers/scsi/AM53C974.c~	2004-08-11 19:58:24.000000000 +0300
+++ 28p1/drivers/scsi/AM53C974.c	2004-08-17 00:47:29.000000000 +0300
@@ -1027,6 +1027,78 @@
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 
+/************************************************************************** 
+* Function : AM53C974_set_async(struct Scsi_Host *instance, int target)
+*
+* Purpose : put controller into async. mode
+*
+* Inputs : instance -- which AM53C974
+*          target -- which SCSI target to deal with
+* 
+* Returns : nothing
+**************************************************************************/
+static __inline__ void AM53C974_set_async(struct Scsi_Host *instance, int target)
+{
+	AM53C974_local_declare();
+	struct AM53C974_hostdata *hostdata = (struct AM53C974_hostdata *) instance->hostdata;
+	AM53C974_setio(instance);
+
+	AM53C974_write_8(STPREG, hostdata->sync_per[target]);
+	AM53C974_write_8(SOFREG, (DEF_SOF_RAD << 6) | (DEF_SOF_RAA << 4));
+}
+
+/************************************************************************** 
+* Function : AM53C974_set_sync(struct Scsi_Host *instance, int target)
+*
+* Purpose : put controller into sync. mode
+*
+* Inputs : instance -- which AM53C974
+*          target -- which SCSI target to deal with
+* 
+* Returns : nothing
+**************************************************************************/
+static __inline__ void AM53C974_set_sync(struct Scsi_Host *instance, int target)
+{
+	AM53C974_local_declare();
+	struct AM53C974_hostdata *hostdata = (struct AM53C974_hostdata *) instance->hostdata;
+	AM53C974_setio(instance);
+
+	AM53C974_write_8(STPREG, hostdata->sync_per[target]);
+	AM53C974_write_8(SOFREG, (SOFREG_SO & hostdata->sync_off[target]) |
+			 (DEF_SOF_RAD << 6) | (DEF_SOF_RAA << 4));
+}
+
+/************************************************************************** 
+* Function : AM53C974_transfer_dma(struct Scsi_Host *instance, short dir,
+*                                  unsigned long length, char *data)
+*
+* Purpose : setup DMA transfer
+*
+* Inputs : instance -- which AM53C974
+*          dir -- direction flag, 0: write to device, read from memory; 
+*                                 1: read from device, write to memory
+*          length -- number of bytes to transfer to from buffer
+*          data -- pointer to data buffer
+* 
+* Returns : nothing
+**************************************************************************/
+static __inline__ void AM53C974_transfer_dma(struct Scsi_Host *instance, short dir,
+					unsigned long length, char *data)
+{
+	AM53C974_local_declare();
+	AM53C974_setio(instance);
+
+	AM53C974_write_8(CMDREG, CMDREG_NOP);
+	AM53C974_write_8(DMACMD, (dir << 7) | DMACMD_INTE_D);	/* idle command */
+	AM53C974_write_8(STCLREG, (unsigned char) (length & 0xff));
+	AM53C974_write_8(STCMREG, (unsigned char) ((length & 0xff00) >> 8));
+	AM53C974_write_8(STCHREG, (unsigned char) ((length & 0xff0000) >> 16));
+	AM53C974_write_32(DMASTC, length & 0xffffff);
+	AM53C974_write_32(DMASPA, virt_to_bus(data));
+	AM53C974_write_8(CMDREG, CMDREG_IT | CMDREG_DMA);
+	AM53C974_write_8(DMACMD, (dir << 7) | DMACMD_INTE_D | DMACMD_START);
+}
+
 /************************************************************************
 * Function : AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs) *
 *                                                                       *
@@ -1464,47 +1536,6 @@
 	return (0);
 }
 
-/************************************************************************** 
-* Function : AM53C974_set_async(struct Scsi_Host *instance, int target)
-*
-* Purpose : put controller into async. mode
-*
-* Inputs : instance -- which AM53C974
-*          target -- which SCSI target to deal with
-* 
-* Returns : nothing
-**************************************************************************/
-static __inline__ void AM53C974_set_async(struct Scsi_Host *instance, int target)
-{
-	AM53C974_local_declare();
-	struct AM53C974_hostdata *hostdata = (struct AM53C974_hostdata *) instance->hostdata;
-	AM53C974_setio(instance);
-
-	AM53C974_write_8(STPREG, hostdata->sync_per[target]);
-	AM53C974_write_8(SOFREG, (DEF_SOF_RAD << 6) | (DEF_SOF_RAA << 4));
-}
-
-/************************************************************************** 
-* Function : AM53C974_set_sync(struct Scsi_Host *instance, int target)
-*
-* Purpose : put controller into sync. mode
-*
-* Inputs : instance -- which AM53C974
-*          target -- which SCSI target to deal with
-* 
-* Returns : nothing
-**************************************************************************/
-static __inline__ void AM53C974_set_sync(struct Scsi_Host *instance, int target)
-{
-	AM53C974_local_declare();
-	struct AM53C974_hostdata *hostdata = (struct AM53C974_hostdata *) instance->hostdata;
-	AM53C974_setio(instance);
-
-	AM53C974_write_8(STPREG, hostdata->sync_per[target]);
-	AM53C974_write_8(SOFREG, (SOFREG_SO & hostdata->sync_off[target]) |
-			 (DEF_SOF_RAD << 6) | (DEF_SOF_RAA << 4));
-}
-
 /***********************************************************************
 * Function : AM53C974_information_transfer(struct Scsi_Host *instance, *
 *                          unsigned char statreg, unsigned char isreg, *
@@ -2157,37 +2188,6 @@
 }
 
 /************************************************************************** 
-* Function : AM53C974_transfer_dma(struct Scsi_Host *instance, short dir,
-*                                  unsigned long length, char *data)
-*
-* Purpose : setup DMA transfer
-*
-* Inputs : instance -- which AM53C974
-*          dir -- direction flag, 0: write to device, read from memory; 
-*                                 1: read from device, write to memory
-*          length -- number of bytes to transfer to from buffer
-*          data -- pointer to data buffer
-* 
-* Returns : nothing
-**************************************************************************/
-static __inline__ void AM53C974_transfer_dma(struct Scsi_Host *instance, short dir,
-					unsigned long length, char *data)
-{
-	AM53C974_local_declare();
-	AM53C974_setio(instance);
-
-	AM53C974_write_8(CMDREG, CMDREG_NOP);
-	AM53C974_write_8(DMACMD, (dir << 7) | DMACMD_INTE_D);	/* idle command */
-	AM53C974_write_8(STCLREG, (unsigned char) (length & 0xff));
-	AM53C974_write_8(STCMREG, (unsigned char) ((length & 0xff00) >> 8));
-	AM53C974_write_8(STCHREG, (unsigned char) ((length & 0xff0000) >> 16));
-	AM53C974_write_32(DMASTC, length & 0xffffff);
-	AM53C974_write_32(DMASPA, virt_to_bus(data));
-	AM53C974_write_8(CMDREG, CMDREG_IT | CMDREG_DMA);
-	AM53C974_write_8(DMACMD, (dir << 7) | DMACMD_INTE_D | DMACMD_START);
-}
-
-/************************************************************************** 
 * Function : AM53C974_dma_blast(struct Scsi_Host *instance, unsigned char dmastatus,
 *                               unsigned char statreg)
 *
--- 28p1/drivers/scsi/megaraid.c~	2004-02-18 15:36:31.000000000 +0200
+++ 28p1/drivers/scsi/megaraid.c	2004-08-17 00:49:52.000000000 +0300
@@ -3471,6 +3471,24 @@
 	return count;
 }
 
+static inline void mega_freeSgList (mega_host_config * megaCfg)
+{
+	int i;
+
+	for (i = 0; i < megaCfg->max_cmds; i++) {
+		if (megaCfg->scbList[i].sgList)
+			pci_free_consistent (megaCfg->dev,
+					     sizeof (mega_64sglist) *
+					     MAX_SGLIST,
+					     megaCfg->scbList[i].sgList,
+					     megaCfg->scbList[i].
+					     dma_sghandle64);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)	/* 0x020400 */
+			kfree (megaCfg->scbList[i].sgList);	/* free sgList */
+#endif
+	}
+}
+
 /*---------------------------------------------------------------------
  * Release the controller's resources
  *---------------------------------------------------------------------*/
@@ -3880,24 +3898,6 @@
 	return;
 }
 
-static inline void mega_freeSgList (mega_host_config * megaCfg)
-{
-	int i;
-
-	for (i = 0; i < megaCfg->max_cmds; i++) {
-		if (megaCfg->scbList[i].sgList)
-			pci_free_consistent (megaCfg->dev,
-					     sizeof (mega_64sglist) *
-					     MAX_SGLIST,
-					     megaCfg->scbList[i].sgList,
-					     megaCfg->scbList[i].
-					     dma_sghandle64);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)	/* 0x020400 */
-			kfree (megaCfg->scbList[i].sgList);	/* free sgList */
-#endif
-	}
-}
-
 /*----------------------------------------------
  * Get information about the card/driver
  *----------------------------------------------*/
--- 28p1/drivers/scsi/megaraid2.c~	2004-08-08 02:26:05.000000000 +0300
+++ 28p1/drivers/scsi/megaraid2.c	2004-08-17 01:40:29.000000000 +0300
@@ -936,6 +936,19 @@
 }
 
 
+/**
+ * mega_runpendq()
+ * @adapter - pointer to our soft state
+ *
+ * Runs through the list of pending requests.
+ */
+static inline void
+mega_runpendq(adapter_t *adapter)
+{
+	if(!list_empty(&adapter->pending_list))
+		__mega_runpendq(adapter);
+}
+
 /*
  * megaraid_queue()
  * @scmd - Issue this scsi command
@@ -986,6 +999,98 @@
 
 
 /**
+ * mega_allocate_scb()
+ * @adapter - pointer to our soft state
+ * @cmd - scsi command from the mid-layer
+ *
+ * Allocate a SCB structure. This is the central structure for controller
+ * commands.
+ */
+static inline scb_t *
+mega_allocate_scb(adapter_t *adapter, Scsi_Cmnd *cmd)
+{
+	struct list_head *head = &adapter->free_list;
+	scb_t	*scb;
+
+	/* Unlink command from Free List */
+	if( !list_empty(head) ) {
+
+		scb = list_entry(head->next, scb_t, list);
+
+		list_del_init(head->next);
+
+		scb->state = SCB_ACTIVE;
+		scb->cmd = cmd;
+		scb->dma_type = MEGA_DMA_TYPE_NONE;
+
+		return scb;
+	}
+
+	return NULL;
+}
+
+
+/**
+ * mega_get_ldrv_num()
+ * @adapter - pointer to our soft state
+ * @cmd - scsi mid layer command
+ * @channel - channel on the controller
+ *
+ * Calculate the logical drive number based on the information in scsi command
+ * and the channel number.
+ */
+static inline int
+mega_get_ldrv_num(adapter_t *adapter, Scsi_Cmnd *cmd, int channel)
+{
+	int		tgt;
+	int		ldrv_num;
+
+	tgt = cmd->target;
+
+	if ( tgt > adapter->this_id )
+		tgt--;	/* we do not get inquires for initiator id */
+
+	ldrv_num = (channel * 15) + tgt;
+
+
+	/*
+	 * If we have a logical drive with boot enabled, project it first
+	 */
+	if( adapter->boot_ldrv_enabled ) {
+		if( ldrv_num == 0 ) {
+			ldrv_num = adapter->boot_ldrv;
+		}
+		else {
+			if( ldrv_num <= adapter->boot_ldrv ) {
+				ldrv_num--;
+			}
+		}
+	}
+
+	/*
+	 * If "delete logical drive" feature is enabled on this controller.
+	 * Do only if at least one delete logical drive operation was done.
+	 *
+	 * Also, after logical drive deletion, instead of logical drive number,
+	 * the value returned should be 0x80+logical drive id.
+	 *
+	 * These is valid only for IO commands.
+	 */
+
+	if (adapter->support_random_del && adapter->read_ldidmap )
+		switch (cmd->cmnd[0]) {
+		case READ_6:	/* fall through */
+		case WRITE_6:	/* fall through */
+		case READ_10:	/* fall through */
+		case WRITE_10:
+			ldrv_num += 0x80;
+		}
+
+	return ldrv_num;
+}
+
+
+/**
  * mega_build_cmd()
  * @adapter - pointer to our soft state
  * @cmd - Prepare using this scsi command
@@ -1566,51 +1671,6 @@
 }
 
 
-/**
- * mega_allocate_scb()
- * @adapter - pointer to our soft state
- * @cmd - scsi command from the mid-layer
- *
- * Allocate a SCB structure. This is the central structure for controller
- * commands.
- */
-static inline scb_t *
-mega_allocate_scb(adapter_t *adapter, Scsi_Cmnd *cmd)
-{
-	struct list_head *head = &adapter->free_list;
-	scb_t	*scb;
-
-	/* Unlink command from Free List */
-	if( !list_empty(head) ) {
-
-		scb = list_entry(head->next, scb_t, list);
-
-		list_del_init(head->next);
-
-		scb->state = SCB_ACTIVE;
-		scb->cmd = cmd;
-		scb->dma_type = MEGA_DMA_TYPE_NONE;
-
-		return scb;
-	}
-
-	return NULL;
-}
-
-
-/**
- * mega_runpendq()
- * @adapter - pointer to our soft state
- *
- * Runs through the list of pending requests.
- */
-static inline void
-mega_runpendq(adapter_t *adapter)
-{
-	if(!list_empty(&adapter->pending_list))
-		__mega_runpendq(adapter);
-}
-
 static void
 __mega_runpendq(adapter_t *adapter)
 {
@@ -1642,7 +1702,7 @@
  * busy. We also take the scb from the pending list if the mailbox is
  * available.
  */
-static inline int
+static int
 issue_scb(adapter_t *adapter, scb_t *scb)
 {
 	volatile mbox64_t	*mbox64 = adapter->mbox64;
@@ -1705,6 +1765,17 @@
 }
 
 
+/*
+ * Wait until the controller's mailbox is available
+ */
+static inline int
+mega_busywait_mbox (adapter_t *adapter)
+{
+	if (adapter->mbox->busy)
+		return __mega_busywait_mbox(adapter);
+	return 0;
+}
+
 /**
  * issue_scb_block()
  * @adapter - pointer to our soft state
@@ -1807,38 +1878,6 @@
 
 
 /**
- * megaraid_isr_iomapped()
- * @irq - irq
- * @devp - pointer to our soft state
- * @regs - unused
- *
- * Interrupt service routine for io-mapped controllers.
- * Find out if our device is interrupting. If yes, acknowledge the interrupt
- * and service the completed commands.
- */
-static void
-megaraid_isr_iomapped(int irq, void *devp, struct pt_regs *regs)
-{
-	adapter_t	*adapter = devp;
-	unsigned long	flags;
-
-
-	spin_lock_irqsave(adapter->host_lock, flags);
-
-	megaraid_iombox_ack_sequence(adapter);
-
-	/* Loop through any pending requests */
-	if( atomic_read(&adapter->quiescent ) == 0) {
-		mega_runpendq(adapter);
-	}
-
-	spin_unlock_irqrestore(adapter->host_lock, flags);
-
-	return;
-}
-
-
-/**
  * megaraid_iombox_ack_sequence - interrupt ack sequence for IO mapped HBAs
  * @adapter	- controller's soft state
  *
@@ -1901,38 +1940,6 @@
 
 
 /**
- * megaraid_isr_memmapped()
- * @irq - irq
- * @devp - pointer to our soft state
- * @regs - unused
- *
- * Interrupt service routine for memory-mapped controllers.
- * Find out if our device is interrupting. If yes, acknowledge the interrupt
- * and service the completed commands.
- */
-static void
-megaraid_isr_memmapped(int irq, void *devp, struct pt_regs *regs)
-{
-	adapter_t	*adapter = devp;
-	unsigned long	flags;
-
-
-	spin_lock_irqsave(adapter->host_lock, flags);
-
-	megaraid_memmbox_ack_sequence(adapter);
-
-	/* Loop through any pending requests */
-	if(atomic_read(&adapter->quiescent) == 0) {
-		mega_runpendq(adapter);
-	}
-
-	spin_unlock_irqrestore(adapter->host_lock, flags);
-
-	return;
-}
-
-
-/**
  * megaraid_memmbox_ack_sequence - interrupt ack sequence for memory mapped HBAs
  * @adapter	- controller's soft state
  *
@@ -2000,6 +2007,70 @@
 
 
 /**
+ * megaraid_isr_iomapped()
+ * @irq - irq
+ * @devp - pointer to our soft state
+ * @regs - unused
+ *
+ * Interrupt service routine for io-mapped controllers.
+ * Find out if our device is interrupting. If yes, acknowledge the interrupt
+ * and service the completed commands.
+ */
+static void
+megaraid_isr_iomapped(int irq, void *devp, struct pt_regs *regs)
+{
+	adapter_t	*adapter = devp;
+	unsigned long	flags;
+
+
+	spin_lock_irqsave(adapter->host_lock, flags);
+
+	megaraid_iombox_ack_sequence(adapter);
+
+	/* Loop through any pending requests */
+	if( atomic_read(&adapter->quiescent ) == 0) {
+		mega_runpendq(adapter);
+	}
+
+	spin_unlock_irqrestore(adapter->host_lock, flags);
+
+	return;
+}
+
+
+/**
+ * megaraid_isr_memmapped()
+ * @irq - irq
+ * @devp - pointer to our soft state
+ * @regs - unused
+ *
+ * Interrupt service routine for memory-mapped controllers.
+ * Find out if our device is interrupting. If yes, acknowledge the interrupt
+ * and service the completed commands.
+ */
+static void
+megaraid_isr_memmapped(int irq, void *devp, struct pt_regs *regs)
+{
+	adapter_t	*adapter = devp;
+	unsigned long	flags;
+
+
+	spin_lock_irqsave(adapter->host_lock, flags);
+
+	megaraid_memmbox_ack_sequence(adapter);
+
+	/* Loop through any pending requests */
+	if(atomic_read(&adapter->quiescent) == 0) {
+		mega_runpendq(adapter);
+	}
+
+	spin_unlock_irqrestore(adapter->host_lock, flags);
+
+	return;
+}
+
+
+/**
  * mega_cmd_done()
  * @adapter - pointer to our soft state
  * @completed - array of ids of completed commands
@@ -2008,7 +2079,7 @@
  *
  * Complete the comamnds and call the scsi mid-layer callback hooks.
  */
-static inline void
+static void
 mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 {
 	mega_ext_passthru	*epthru = NULL;
@@ -2311,17 +2382,6 @@
 }
 
 
-/*
- * Wait until the controller's mailbox is available
- */
-static inline int
-mega_busywait_mbox (adapter_t *adapter)
-{
-	if (adapter->mbox->busy)
-		return __mega_busywait_mbox(adapter);
-	return 0;
-}
-
 static int
 __mega_busywait_mbox (adapter_t *adapter)
 {
@@ -2476,6 +2536,44 @@
 }
 
 
+static inline void
+mega_free_sgl(adapter_t *adapter)
+{
+	scb_t	*scb;
+	int	i;
+
+	for(i = 0; i < adapter->max_cmds; i++) {
+
+		scb = &adapter->scb_list[i];
+
+		if( scb->sgl64 ) {
+			pci_free_consistent(adapter->dev,
+				sizeof(mega_sgl64) * adapter->sglen,
+				scb->sgl64,
+				scb->sgl_dma_addr);
+
+			scb->sgl64 = NULL;
+		}
+
+		if( scb->pthru ) {
+			pci_free_consistent(adapter->dev, sizeof(mega_passthru),
+				scb->pthru, scb->pthru_dma_addr);
+
+			scb->pthru = NULL;
+		}
+
+		if( scb->epthru ) {
+			pci_free_consistent(adapter->dev,
+				sizeof(mega_ext_passthru),
+				scb->epthru, scb->epthru_dma_addr);
+
+			scb->epthru = NULL;
+		}
+
+	}
+}
+
+
 /*
  * Release the controller's resources
  */
@@ -2605,44 +2703,6 @@
 	return 0;
 }
 
-static inline void
-mega_free_sgl(adapter_t *adapter)
-{
-	scb_t	*scb;
-	int	i;
-
-	for(i = 0; i < adapter->max_cmds; i++) {
-
-		scb = &adapter->scb_list[i];
-
-		if( scb->sgl64 ) {
-			pci_free_consistent(adapter->dev,
-				sizeof(mega_sgl64) * adapter->sglen,
-				scb->sgl64,
-				scb->sgl_dma_addr);
-
-			scb->sgl64 = NULL;
-		}
-
-		if( scb->pthru ) {
-			pci_free_consistent(adapter->dev, sizeof(mega_passthru),
-				scb->pthru, scb->pthru_dma_addr);
-
-			scb->pthru = NULL;
-		}
-
-		if( scb->epthru ) {
-			pci_free_consistent(adapter->dev,
-				sizeof(mega_ext_passthru),
-				scb->epthru, scb->epthru_dma_addr);
-
-			scb->epthru = NULL;
-		}
-
-	}
-}
-
-
 /*
  * Get information about the card/driver
  */
@@ -2860,6 +2920,27 @@
 }
 
 
+/**
+ * mega_allocate_inquiry()
+ * @dma_handle - handle returned for dma address
+ * @pdev - handle to pci device
+ *
+ * allocates memory for inquiry structure
+ */
+static inline caddr_t
+mega_allocate_inquiry(dma_addr_t *dma_handle, struct pci_dev *pdev)
+{
+	return pci_alloc_consistent(pdev, sizeof(mega_inquiry3), dma_handle);
+}
+
+
+static inline void
+mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, struct pci_dev *pdev)
+{
+	pci_free_consistent(pdev, sizeof(mega_inquiry3), inquiry, dma_handle);
+}
+
+
 #ifdef CONFIG_PROC_FS
 /* Following code handles /proc fs  */
 
@@ -5069,66 +5150,6 @@
 
 
 /**
- * mega_get_ldrv_num()
- * @adapter - pointer to our soft state
- * @cmd - scsi mid layer command
- * @channel - channel on the controller
- *
- * Calculate the logical drive number based on the information in scsi command
- * and the channel number.
- */
-static inline int
-mega_get_ldrv_num(adapter_t *adapter, Scsi_Cmnd *cmd, int channel)
-{
-	int		tgt;
-	int		ldrv_num;
-
-	tgt = cmd->target;
-
-	if ( tgt > adapter->this_id )
-		tgt--;	/* we do not get inquires for initiator id */
-
-	ldrv_num = (channel * 15) + tgt;
-
-
-	/*
-	 * If we have a logical drive with boot enabled, project it first
-	 */
-	if( adapter->boot_ldrv_enabled ) {
-		if( ldrv_num == 0 ) {
-			ldrv_num = adapter->boot_ldrv;
-		}
-		else {
-			if( ldrv_num <= adapter->boot_ldrv ) {
-				ldrv_num--;
-			}
-		}
-	}
-
-	/*
-	 * If "delete logical drive" feature is enabled on this controller.
-	 * Do only if at least one delete logical drive operation was done.
-	 *
-	 * Also, after logical drive deletion, instead of logical drive number,
-	 * the value returned should be 0x80+logical drive id.
-	 *
-	 * These is valid only for IO commands.
-	 */
-
-	if (adapter->support_random_del && adapter->read_ldidmap )
-		switch (cmd->cmnd[0]) {
-		case READ_6:	/* fall through */
-		case WRITE_6:	/* fall through */
-		case READ_10:	/* fall through */
-		case WRITE_10:
-			ldrv_num += 0x80;
-		}
-
-	return ldrv_num;
-}
-
-
-/**
  * mega_reorder_hosts()
  *
  * Hack: reorder the scsi hosts in mid-layer so that the controller with the
@@ -5342,27 +5363,6 @@
 }
 
 
-/**
- * mega_allocate_inquiry()
- * @dma_handle - handle returned for dma address
- * @pdev - handle to pci device
- *
- * allocates memory for inquiry structure
- */
-static inline caddr_t
-mega_allocate_inquiry(dma_addr_t *dma_handle, struct pci_dev *pdev)
-{
-	return pci_alloc_consistent(pdev, sizeof(mega_inquiry3), dma_handle);
-}
-
-
-static inline void
-mega_free_inquiry(caddr_t inquiry, dma_addr_t dma_handle, struct pci_dev *pdev)
-{
-	pci_free_consistent(pdev, sizeof(mega_inquiry3), inquiry, dma_handle);
-}
-
-
 /** mega_internal_dev_inquiry()
  * @adapter - pointer to our soft state
  * @ch - channel for this device
--- 28p1/drivers/scsi/megaraid2.h~	2004-08-16 20:23:01.000000000 +0300
+++ 28p1/drivers/scsi/megaraid2.h	2004-08-17 01:28:04.000000000 +0300
@@ -1091,14 +1091,12 @@
 static int megaraid_detect(Scsi_Host_Template *);
 static void mega_find_card(Scsi_Host_Template *, u16, u16);
 static int mega_query_adapter(adapter_t *);
-static inline int issue_scb(adapter_t *, scb_t *);
+static int issue_scb(adapter_t *, scb_t *);
 static int mega_setup_mailbox(adapter_t *);
 
 static int megaraid_queue (Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
 static scb_t * mega_build_cmd(adapter_t *, Scsi_Cmnd *, int *);
-static inline scb_t *mega_allocate_scb(adapter_t *, Scsi_Cmnd *);
 static void __mega_runpendq(adapter_t *);
-static inline void mega_runpendq(adapter_t *);
 static int issue_scb_block(adapter_t *, u_char *);
 
 static void megaraid_isr_memmapped(int, void *, struct pt_regs *);
@@ -1115,9 +1113,8 @@
 
 static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
 			      u32 *buffer, u32 *length);
-static inline int mega_busywait_mbox (adapter_t *);
 static int __mega_busywait_mbox (adapter_t *);
-static inline void mega_cmd_done(adapter_t *, u8 [], int, int);
+static void mega_cmd_done(adapter_t *, u8 [], int, int);
 static inline void mega_free_sgl (adapter_t *adapter);
 static void mega_8_to_40ld (mraid_inquiry *inquiry,
 		mega_inquiry3 *enquiry3, mega_product_info *);
@@ -1167,8 +1164,6 @@
 
 static int mega_adapinq(adapter_t *, dma_addr_t);
 static int mega_internal_dev_inquiry(adapter_t *, u8, u8, dma_addr_t);
-static inline caddr_t mega_allocate_inquiry(dma_addr_t *, struct pci_dev *);
-static inline void mega_free_inquiry(caddr_t, dma_addr_t, struct pci_dev *);
 static int mega_print_inquiry(char *, char *);
 #endif
 
@@ -1179,7 +1174,6 @@
 		scb_t *, Scsi_Cmnd *, int, int);
 static void mega_enum_raid_scsi(adapter_t *);
 static void mega_get_boot_drv(adapter_t *);
-static inline int mega_get_ldrv_num(adapter_t *, Scsi_Cmnd *, int);
 static int mega_support_random_del(adapter_t *);
 static int mega_del_logdrv(adapter_t *, int);
 static int mega_do_del_logdrv(adapter_t *, int);
--- 28p1/drivers/scsi/nsp32.c~	2003-11-28 20:26:20.000000000 +0200
+++ 28p1/drivers/scsi/nsp32.c	2004-08-17 01:46:27.000000000 +0300
@@ -3365,6 +3365,48 @@
 	return val;
 }
 
+static inline void nsp32_prom_set(nsp32_hw_data *data, int bit, int val)
+{
+	unsigned int base = data->BaseAddress;
+	int tmp;
+
+	tmp = nsp32_index_read1(base, SERIAL_ROM_CTL);
+
+	if (val == 0) {
+		tmp &= ~bit;
+	} else {
+		tmp |=  bit;
+	}
+
+	nsp32_index_write1(base, SERIAL_ROM_CTL, tmp);
+
+	udelay(10);
+}
+
+static inline int nsp32_prom_get(nsp32_hw_data *data, int bit)
+{
+	unsigned int base = data->BaseAddress;
+	int tmp, ret;
+
+	if (bit != SROM_DATA) {
+		nsp32_msg(KERN_ERR, "return value is not appropriate");
+		return 0;
+	}
+
+
+	tmp = nsp32_index_read1(base, SERIAL_ROM_CTL) & bit;
+
+	if (tmp == 0) {
+		ret = 0;
+	} else {
+		ret = 1;
+	}
+
+	udelay(10);
+
+	return ret;
+}
+
 static void nsp32_prom_start (nsp32_hw_data *data)
 {
 	/* start condition */
@@ -3410,49 +3452,6 @@
 	return val;
 }
 
-static inline void nsp32_prom_set(nsp32_hw_data *data, int bit, int val)
-{
-	unsigned int base = data->BaseAddress;
-	int tmp;
-
-	tmp = nsp32_index_read1(base, SERIAL_ROM_CTL);
-
-	if (val == 0) {
-		tmp &= ~bit;
-	} else {
-		tmp |=  bit;
-	}
-
-	nsp32_index_write1(base, SERIAL_ROM_CTL, tmp);
-
-	udelay(10);
-}
-
-static inline int nsp32_prom_get(nsp32_hw_data *data, int bit)
-{
-	unsigned int base = data->BaseAddress;
-	int tmp, ret;
-
-	if (bit != SROM_DATA) {
-		nsp32_msg(KERN_ERR, "return value is not appropriate");
-		return 0;
-	}
-
-
-	tmp = nsp32_index_read1(base, SERIAL_ROM_CTL) & bit;
-
-	if (tmp == 0) {
-		ret = 0;
-	} else {
-		ret = 1;
-	}
-
-	udelay(10);
-
-	return ret;
-}
-
-
 /**************************************************************************
  * Power Management
  */
--- 28p1/drivers/scsi/aic7xxx/aic79xx_osm.c~	2004-08-16 20:13:01.000000000 +0300
+++ 28p1/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-08-17 02:02:23.000000000 +0300
@@ -2871,6 +2871,19 @@
 	ahd_unlock(ahd, &s);
 }
 
+static __inline int
+ahd_linux_dv_fallback(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
+{
+	u_long s;
+	int retval;
+
+	ahd_lock(ahd, &s);
+	retval = ahd_linux_fallback(ahd, devinfo);
+	ahd_unlock(ahd, &s);
+
+	return (retval);
+}
+
 static void
 ahd_linux_dv_transition(struct ahd_softc *ahd, struct scsi_cmnd *cmd,
 			struct ahd_devinfo *devinfo,
@@ -3517,19 +3530,6 @@
 	cmd->cmnd[4] = le | SSS_START;
 }
 
-static __inline int
-ahd_linux_dv_fallback(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
-{
-	u_long s;
-	int retval;
-
-	ahd_lock(ahd, &s);
-	retval = ahd_linux_fallback(ahd, devinfo);
-	ahd_unlock(ahd, &s);
-
-	return (retval);
-}
-
 static int
 ahd_linux_fallback(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 {

--------------030202000405070204000209--
