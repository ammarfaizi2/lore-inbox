Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbTJ3WQY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 17:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTJ3WQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 17:16:24 -0500
Received: from mail.gmx.de ([213.165.64.20]:2517 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262893AbTJ3WP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 17:15:57 -0500
X-Authenticated: #20450766
Date: Thu, 30 Oct 2003 23:12:57 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
cc: Kurt Garloff <garloff@suse.de>, Matthias Andree <matthias.andree@gmx.de>
Subject: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
In-Reply-To: <Pine.LNX.4.44.0310262035270.3346-100000@poirot.grange>
Message-ID: <Pine.LNX.4.44.0310302221400.5533-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Oct 2003, Guennadi Liakhovetski wrote:

> > The above (AM53C974) driver depends on BROKEN in 2.6 and doesn't compile.
> > Is anybody working on / planning to fix it?

Ok, I fixed it, well, at least, it works for me. What now? The fix is,
probably, not perfect. E.g. it doesn't support multiple cards now, but it
looks like the driver didn't support them even when it worked in its
latest version (sorry, if I am wrong).

Patch attached. Comments / improvement suggestions mostly welcome.

Guennadi
---
Guennadi Liakhovetski

diff -ur linux-2.6.0-test7.arm/drivers/scsi/AM53C974.c linux-2.6.0-test7/drivers/scsi/AM53C974.c
--- linux-2.6.0-test7.arm/drivers/scsi/AM53C974.c	Wed Oct  8 23:26:43 2003
+++ linux-2.6.0-test7/drivers/scsi/AM53C974.c	Thu Oct 30 23:00:40 2003
@@ -1,6 +1,5 @@
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/module.h>
+#include <linux/version.h>
 #include <linux/delay.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -10,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>

 #include <asm/io.h>
 #include <asm/system.h>
@@ -361,8 +361,8 @@
 static __inline__ void initialize_SCp(Scsi_Cmnd * cmd);
 static __inline__ void run_main(void);
 static void AM53C974_main(void);
-static void AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs);
-static void do_AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t do_AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs);
 static void AM53C974_intr_disconnect(struct Scsi_Host *instance);
 static int AM53C974_sync_neg(struct Scsi_Host *instance, int target, unsigned char *msg);
 static __inline__ void AM53C974_set_async(struct Scsi_Host *instance, int target);
@@ -382,7 +382,11 @@

 static struct Scsi_Host *first_instance;
 static Scsi_Host_Template *the_template;
+#undef AM53C974_MULTIPLE_CARD
+#ifdef AM53C974_MULTIPLE_CARD
+#error "FIXME! Multiple card support is broken. Looks like it never really worked. Might have to be fixed."
 static struct Scsi_Host *first_host;	/* Head of list of AMD boards */
+#endif
 static volatile int main_running;
 static int commandline_current;
 override_t overrides[7] =
@@ -457,8 +461,7 @@

 	printk("AM53C974: coroutine is%s running.\n", main_running ? "" : "n't");

-	save_flags(flags);
-	cli();
+	local_irq_save(flags);

 	if (!hostdata->connected) {
 		printk("scsi%d: no currently connected command\n", instance->host_no);
@@ -489,7 +492,7 @@
 			print_Scsi_Cmnd(ptr);
 	}

-	restore_flags(flags);
+	local_irq_restore(flags);
 }

 #endif				/* AM53C974_DEBUG */
@@ -504,14 +507,17 @@
 static void AM53C974_print(struct Scsi_Host *instance)
 {
 	AM53C974_local_declare();
+#if 0 /* Called only from error-handling paths with sufficient protection? */
 	unsigned long flags;
+#endif
 	unsigned long ctcreg, dmastc, dmaspa, dmawbc, dmawac;
 	unsigned char cmdreg, statreg, isreg, cfireg, cntlreg[4], dmacmd,
 	 dmastatus;
 	AM53C974_setio(instance);

-	save_flags(flags);
-	cli();
+#if 0 /* Called only from error-handling paths with sufficient protection? */
+	local_irq_save(flags);
+#endif
 	ctcreg = AM53C974_read_8(CTCHREG) << 16;
 	ctcreg |= AM53C974_read_8(CTCMREG) << 8;
 	ctcreg |= AM53C974_read_8(CTCLREG);
@@ -529,7 +535,9 @@
 	dmawbc = AM53C974_read_32(DMAWBC);
 	dmawac = AM53C974_read_32(DMAWAC);
 	dmastatus = AM53C974_read_8(DMASTATUS);
-	restore_flags(flags);
+#if 0 /* Called only from error-handling paths with sufficient protection? */
+	local_irq_restore(flags);
+#endif

 	printk("AM53C974 register dump:\n");
 	printk("IO base: 0x%04lx; CTCREG: 0x%04lx; CMDREG: 0x%02x; STATREG: 0x%02x; ISREG: 0x%02x\n",
@@ -559,15 +567,14 @@
 		return;
 #endif

-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	while ((inb_p(0x64) & 0x01) != 0x01);
 #ifdef AM53C974_DEBUG
 	key = inb(0x60);
 	if (key == 0x93)
 		deb_stop = 0;	/* don't stop if 'r' was pressed */
 #endif
-	restore_flags(flags);
+	local_irq_restore(flags);
 }

 #ifndef MODULE
@@ -667,7 +674,10 @@
 {
 	AM53C974_local_declare();
 	int i, j;
-	struct Scsi_Host *instance, *search;
+	struct Scsi_Host *instance;
+#ifdef AM53C974_MULTIPLE_CARD
+	struct Scsi_Host *search;
+#endif
 	struct AM53C974_hostdata *hostdata;

 #ifdef AM53C974_OPTION_DEBUG_PROBE_ONLY
@@ -739,21 +749,24 @@
 		return 0;
 	}
 /* Set up an interrupt handler if we aren't already sharing an IRQ with another board */
+#ifdef AM53C974_MULTIPLE_CARD
 	for (search = first_host;
 	     search && (((the_template != NULL) && (search->hostt != the_template)) ||
 		 (search->irq != instance->irq) || (search == instance));
 	     search = search->next);
 	if (!search) {
+#endif
 		if (request_irq(instance->irq, do_AM53C974_intr, SA_SHIRQ, "AM53C974", instance)) {
 			printk("scsi%d: IRQ%d not free, detaching\n", instance->host_no, instance->irq);
 			scsi_unregister(instance);
 			return 0;
 		}
+#ifdef AM53C974_MULTIPLE_CARD
 	} else {
 		printk("scsi%d: using interrupt handler previously installed for scsi%d\n",
 		       instance->host_no, search->host_no);
 	}
-
+#endif
 	if (!the_template) {
 		the_template = instance->hostt;
 		first_instance = instance;
@@ -832,7 +845,7 @@
 	if (cmd->use_sg) {
 		cmd->SCp.buffer = (struct scatterlist *) cmd->buffer;
 		cmd->SCp.buffers_residual = cmd->use_sg - 1;
-		cmd->SCp.ptr = (char *) cmd->SCp.buffer->address;
+		cmd->SCp.ptr = (char *) page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
 		cmd->SCp.this_residual = cmd->SCp.buffer->length;
 	} else {
 		cmd->SCp.buffer = NULL;
@@ -858,15 +871,14 @@
 static __inline__ void run_main(void)
 {
 	unsigned long flags;
-	save_flags(flags);
-	cli();
+ 	local_irq_save(flags);
 	if (!main_running) {
 		/* main_running is cleared in AM53C974_main once it can't do
 		   more work, and AM53C974_main exits with interrupts disabled. */
 		main_running = 1;
 		AM53C974_main();
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }

 /**************************************************************************
@@ -891,8 +903,7 @@
 	struct AM53C974_hostdata *hostdata = (struct AM53C974_hostdata *) instance->hostdata;
 	Scsi_Cmnd *tmp;

-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	DEB_QUEUE(printk(SEPARATOR_LINE));
 	DEB_QUEUE(printk("scsi%d: AM53C974_queue_command called\n", instance->host_no));
 	DEB_QUEUE(printk("cmd=%02x target=%02x lun=%02x bufflen=%d use_sg = %02x\n",
@@ -924,7 +935,7 @@

 /* Run the coroutine if it isn't already running. */
 	run_main();
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }

@@ -952,12 +963,14 @@
  * the host adapters have anything that can be done, at which point
  * we set main_running to 0 and exit. */

-	save_flags(flags);
-	cli();		/* Freeze request queues */
+	local_irq_save(flags); /* Freeze request queues */
 	do {
 		done = 1;
+#ifdef AM53C974_MULTIPLE_CARD
 		for (instance = first_instance; instance && instance->hostt == the_template;
 		     instance = instance->next) {
+#endif
+			instance = first_instance;
 			hostdata = (struct AM53C974_hostdata *) instance->hostdata;
 			AM53C974_setio(instance);
 			/* start to select target if we are not connected and not in the
@@ -993,10 +1006,12 @@
 				DEB(printk("main: connected; cmd = 0x%lx, sel_cmd = 0x%lx\n",
 					   (long) hostdata->connected, (long) hostdata->sel_cmd));
 			}
+#ifdef AM53C974_MULTIPLE_CARD
 		}		/* for instance */
+#endif
 	} while (!done);
 	main_running = 0;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }

 /************************************************************************
@@ -1008,14 +1023,16 @@
 *                                                                       *
 * Returns : nothing                                                     *
 ************************************************************************/
-static void do_AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t do_AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long flags;
 	struct Scsi_Host *dev = dev_id;
-
+	irqreturn_t ret;
+
 	spin_lock_irqsave(dev->host_lock, flags);
-	AM53C974_intr(irq, dev_id, regs);
+	ret = AM53C974_intr(irq, dev_id, regs);
 	spin_unlock_irqrestore(dev->host_lock, flags);
+	return ret;
 }

 /************************************************************************
@@ -1027,7 +1044,7 @@
 *                                                                       *
 * Returns : nothing                                                     *
 ************************************************************************/
-static void AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	AM53C974_local_declare();
 	struct Scsi_Host *instance;
@@ -1035,10 +1052,13 @@
 	unsigned char cmdreg, dmastatus, statreg, isreg, instreg, cfifo;

 /* find AM53C974 hostadapter responsible for this interrupt */
+#ifdef AM53C974_MULTIPLE_CARD
 	for (instance = first_instance; instance; instance = instance->next)
+#endif
+	instance = first_instance;
 		if ((instance->irq == irq) && (instance->hostt == the_template))
 			goto FOUND;
-	return;
+	return IRQ_NONE;

 /* found; now decode and process */
 	FOUND:
@@ -1065,8 +1085,7 @@
 		/* DMA transfer done */
 		unsigned long residual;
 		unsigned long flags;
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		if (!(AM53C974_read_8(DMACMD) & DMACMD_DIR)) {
 			do {
 				dmastatus = AM53C974_read_8(DMASTATUS);
@@ -1095,10 +1114,10 @@
 			AM53C974_information_transfer(instance, statreg, isreg, instreg, cfifo,
 						      dmastatus);
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 	if (!(dmastatus & DMASTATUS_SCSIINT)) {
-		return;
+		return IRQ_HANDLED;
 	}
 /*** SCSI related interrupts ***/
 	cmdreg = AM53C974_read_8(CMDREG);
@@ -1138,8 +1157,7 @@
 #endif
 		DEB(printk("Bus reset interrupt received\n"));
 		AM53C974_intr_bus_reset(instance);
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		if (hostdata->connected) {
 			hostdata->connected->result = DID_RESET << 16;
 			hostdata->connected->scsi_done((Scsi_Cmnd *) hostdata->connected);
@@ -1151,11 +1169,11 @@
 				hostdata->sel_cmd = NULL;
 			}
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 		if (hostdata->in_reset == 1)
 			goto EXIT;
 		else
-			return;
+			return IRQ_HANDLED;
 	}
 	if (instreg & INSTREG_ICMD) {
 		/* INVALID COMMAND INTERRUPT */
@@ -1172,20 +1190,18 @@
 		unsigned long flags;
 		/* DISCONNECT INTERRUPT */
 		DEB_INTR(printk("Disconnect interrupt received; "));
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		AM53C974_intr_disconnect(instance);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		goto EXIT;
 	}
 	if (instreg & INSTREG_RESEL) {
 		unsigned long flags;
 		/* RESELECTION INTERRUPT */
 		DEB_INTR(printk("Reselection interrupt received\n"));
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		AM53C974_intr_reselect(instance, statreg);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		goto EXIT;
 	}
 	if (instreg & INSTREG_SO) {
@@ -1193,15 +1209,14 @@
 		if (hostdata->selecting) {
 			unsigned long flags;
 			DEB_INTR(printk("DSR completed, starting select\n"));
-			save_flags(flags);
-			cli();
+			local_irq_save(flags);
 			AM53C974_select(instance, (Scsi_Cmnd *) hostdata->sel_cmd,
 			  (hostdata->sel_cmd->cmnd[0] == REQUEST_SENSE) ?
 					TAG_NONE : TAG_NEXT);
 			hostdata->selecting = 0;
 			AM53C974_set_sync(instance, hostdata->sel_cmd->device->id);
-			restore_flags(flags);
-			return;
+			local_irq_restore(flags);
+			return IRQ_HANDLED;
 		}
 		if (hostdata->sel_cmd != NULL) {
 			if (((isreg & ISREG_IS) != ISREG_OK_NO_STOP) &&
@@ -1209,22 +1224,20 @@
 				unsigned long flags;
 				/* UNSUCCESSFUL SELECTION */
 				DEB_INTR(printk("unsuccessful selection\n"));
-				save_flags(flags);
-				cli();
+				local_irq_save(flags);
 				hostdata->dma_busy = 0;
 				LIST(hostdata->sel_cmd, hostdata->issue_queue);
 				hostdata->sel_cmd->host_scribble = (unsigned char *) hostdata->issue_queue;
 				hostdata->issue_queue = hostdata->sel_cmd;
 				hostdata->sel_cmd = NULL;
 				hostdata->selecting = 0;
-				restore_flags(flags);
+				local_irq_restore(flags);
 				goto EXIT;
 			} else {
 				unsigned long flags;
 				/* SUCCESSFUL SELECTION */
 				DEB(printk("successful selection; cmd=0x%02lx\n", (long) hostdata->sel_cmd));
-				save_flags(flags);
-				cli();
+				local_irq_save(flags);
 				hostdata->dma_busy = 0;
 				hostdata->disconnecting = 0;
 				hostdata->connected = hostdata->sel_cmd;
@@ -1232,7 +1245,7 @@
 				hostdata->selecting = 0;
 #ifdef SCSI2
 				if (!hostdata->conneted->device->simple_tags)
-#else
+#endif
 					hostdata->busy[hostdata->connected->device->id] |= (1 << hostdata->connected->device->lun);
 				/* very strange -- use_sg is sometimes nonzero for request sense commands !! */
 				if ((hostdata->connected->cmnd[0] == REQUEST_SENSE) && hostdata->connected->use_sg) {
@@ -1243,16 +1256,15 @@
 				initialize_SCp((Scsi_Cmnd *) hostdata->connected);
 				hostdata->connected->SCp.phase = PHASE_CMDOUT;
 				AM53C974_information_transfer(instance, statreg, isreg, instreg, cfifo, dmastatus);
-				restore_flags(flags);
-				return;
+				local_irq_restore(flags);
+				return IRQ_HANDLED;
 			}
 		} else {
 			unsigned long flags;
-			save_flags(flags);
-			cli();
+			local_irq_save(flags);
 			AM53C974_information_transfer(instance, statreg, isreg, instreg, cfifo, dmastatus);
-			restore_flags(flags);
-			return;
+			local_irq_restore(flags);
+			return IRQ_HANDLED;
 		}
 	}
 	if (instreg & INSTREG_SR) {
@@ -1260,20 +1272,20 @@
 		if (hostdata->connected) {
 			unsigned long flags;
 			DEB_INTR(printk("calling information_transfer\n"));
-			save_flags(flags);
-			cli();
+			local_irq_save(flags);
 			AM53C974_information_transfer(instance, statreg, isreg, instreg, cfifo, dmastatus);
-			restore_flags(flags);
+			local_irq_restore(flags);
 		} else {
 			printk("scsi%d: weird: service request when no command connected\n", instance->host_no);
 			AM53C974_write_8(CMDREG, CMDREG_CFIFO);
 		}		/* clear FIFO */
-		return;
+		return IRQ_HANDLED;
 	}
 	EXIT:
 	    DEB_INTR(printk("intr: starting main\n"));
 	run_main();
 	DEB_INTR(printk("end of intr\n"));
+	return IRQ_HANDLED;
 }

 /**************************************************************************
@@ -1546,7 +1558,7 @@
 		if ((!cmd->SCp.this_residual) && cmd->SCp.buffers_residual) {
 			cmd->SCp.buffer++;
 			cmd->SCp.buffers_residual--;
-			cmd->SCp.ptr = (unsigned char *) cmd->SCp.buffer->address;
+			cmd->SCp.ptr = (unsigned char *) page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
 			cmd->SCp.this_residual = cmd->SCp.buffer->length;
 		}
 		if (cmd->SCp.this_residual) {
@@ -2268,7 +2280,6 @@
 static int AM53C974_abort(Scsi_Cmnd * cmd)
 {
 	AM53C974_local_declare();
-	unsigned long flags;
 	struct Scsi_Host *instance = cmd->device->host;
 	struct AM53C974_hostdata *hostdata = (struct AM53C974_hostdata *) instance->hostdata;
 	Scsi_Cmnd *tmp, **prev;
@@ -2276,8 +2287,6 @@
 #ifdef AM53C974_DEBUG
 	deb_stop = 1;
 #endif
-	save_flags(flags);
-	cli();
 	AM53C974_setio(instance);

 	DEB_ABORT(printk(SEPARATOR_LINE));
@@ -2292,7 +2301,6 @@
 		DEB_ABORT(printk("scsi%d: aborting connected command\n", instance->host_no));
 		hostdata->aborted = 1;
 		hostdata->msgout[0] = ABORT;
-		restore_flags(flags);
 		return (SCSI_ABORT_PENDING);
 	}
 /* Case 2 : If the command hasn't been issued yet,
@@ -2307,7 +2315,6 @@
 			(*prev) = (Scsi_Cmnd *) tmp->host_scribble;
 			tmp->host_scribble = NULL;
 			tmp->result = DID_ABORT << 16;
-			restore_flags(flags);
 			tmp->done(tmp);
 			return (SCSI_ABORT_SUCCESS);
 		}
@@ -2329,7 +2336,6 @@
  *          we fail. */
 	if (hostdata->connected || hostdata->sel_cmd) {
 		DEB_ABORT(printk("scsi%d : abort failed, other command connected.\n", instance->host_no));
-		restore_flags(flags);
 		return (SCSI_ABORT_NOT_RUNNING);
 	}
 /* Case 4: If the command is currently disconnected from the bus, and
@@ -2345,7 +2351,6 @@
 			hostdata->selecting = 1;
 			hostdata->sel_cmd = tmp;
 			AM53C974_write_8(CMDREG, CMDREG_DSR);
-			restore_flags(flags);
 			return (SCSI_ABORT_PENDING);
 		}
 	}
@@ -2358,7 +2363,6 @@
  * so we won't panic, but we will notify the user in case something really
  * broke. */
 	DEB_ABORT(printk("scsi%d : abort failed, command not found.\n", instance->host_no));
-	restore_flags(flags);
 	return (SCSI_ABORT_NOT_RUNNING);
 }

@@ -2370,20 +2374,15 @@
 * Inputs : cmd -- which command within the command block was responsible for the reset
 *
 * Returns : status (SCSI_ABORT_SUCCESS)
-*
-* FIXME(eric) the reset_flags are ignored.
 **************************************************************************/
-static int AM53C974_reset(Scsi_Cmnd * cmd, unsigned int reset_flags)
+static int AM53C974_reset(Scsi_Cmnd * cmd)
 {
 	AM53C974_local_declare();
-	unsigned long flags;
 	int i;
 	struct Scsi_Host *instance = cmd->device->host;
 	struct AM53C974_hostdata *hostdata = (struct AM53C974_hostdata *) instance->hostdata;
 	AM53C974_setio(instance);

-	save_flags(flags);
-	cli();
 	DEB(printk("AM53C974_reset called; "));

 	printk("AM53C974_reset called\n");
@@ -2417,10 +2416,9 @@
 	udelay(40);
 	AM53C974_config_after_reset(instance);

-	restore_flags(flags);
 	cmd->result = DID_RESET << 16;
 	cmd->scsi_done(cmd);
-	return SCSI_ABORT_SUCCESS;
+	return SCSI_RESET_SUCCESS;
 }


@@ -2451,8 +2449,8 @@
 	.release        	= AM53C974_release,
 	.info			= AM53C974_info,
 	.queuecommand		= AM53C974_queue_command,
-	.abort			= AM53C974_abort,
-	.reset			= AM53C974_reset,
+	.eh_abort_handler	= AM53C974_abort,
+	.eh_bus_reset_handler	= AM53C974_reset,
 	.can_queue		= 12,
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
diff -ur linux-2.6.0-test7.arm/drivers/scsi/AM53C974.h linux-2.6.0-test7/drivers/scsi/AM53C974.h
--- linux-2.6.0-test7.arm/drivers/scsi/AM53C974.h	Sat Aug  9 06:40:41 2003
+++ linux-2.6.0-test7/drivers/scsi/AM53C974.h	Thu Oct 30 23:05:41 2003
@@ -53,9 +53,7 @@
 static int AM53C974_pci_detect(Scsi_Host_Template * tpnt);
 static int AM53C974_release(struct Scsi_Host *shp);
 static const char *AM53C974_info(struct Scsi_Host *);
-static int AM53C974_command(Scsi_Cmnd * SCpnt);
 static int AM53C974_queue_command(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *));
 static int AM53C974_abort(Scsi_Cmnd * cmd);
-static int AM53C974_reset(Scsi_Cmnd * cmd, unsigned int);
-
+static int AM53C974_reset(Scsi_Cmnd * cmd);
 #endif				/* AM53C974_H */


