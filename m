Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbSJFRVC>; Sun, 6 Oct 2002 13:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262150AbSJFRUp>; Sun, 6 Oct 2002 13:20:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54532 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262078AbSJFRRJ>; Sun, 6 Oct 2002 13:17:09 -0400
Subject: PATCH: 2.5.40 NCR5380 port to 2.5 first pass
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:13:55 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yEyZ-0001sb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is still more work to do, the driver sucks in 2.4 and 2.5 but 2.5 has a
lot more of what is needed to make it work nicely. Basically NCR5380_main
probably has to become a thread in the next generation of the code.

This however seems to get it up and crawling

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/scsi/g_NCR5380.c linux.2.5.40-ac5/drivers/scsi/g_NCR5380.c
--- linux.2.5.40/drivers/scsi/g_NCR5380.c	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.40-ac5/drivers/scsi/g_NCR5380.c	2002-10-04 12:02:24.000000000 +0100
@@ -779,15 +779,15 @@
 	Scsi_Device *dev;
 	extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];
 #endif
-	save_flags(flags);
-	cli();
 
+	/* For now this is constant so we may walk it */
 	for (scsi_ptr = first_instance; scsi_ptr; scsi_ptr = scsi_ptr->next)
 		if (scsi_ptr->host_no == hostno)
 			break;
 	NCR5380_setup(scsi_ptr);
 	hostdata = (struct NCR5380_hostdata *) scsi_ptr->hostdata;
 
+	spin_lock_irqsave(scsi_ptr->host_lock, flags);
 	PRINTP("SCSI host number %d : %s\n" ANDP scsi_ptr->host_no ANDP scsi_ptr->hostt->name);
 	PRINTP("Generic NCR5380 driver version %d\n" ANDP GENERIC_NCR5380_PUBLIC_RELEASE);
 	PRINTP("NCR5380 core version %d\n" ANDP NCR5380_PUBLIC_RELEASE);
@@ -874,7 +874,7 @@
 	len -= offset;
 	if (len > length)
 		len = length;
-	restore_flags(flags);
+	spin_unlock_irqrestore(scsi_ptr->host_lock, flags);
 	return len;
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/scsi/g_NCR5380.h linux.2.5.40-ac5/drivers/scsi/g_NCR5380.h
--- linux.2.5.40/drivers/scsi/g_NCR5380.h	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.40-ac5/drivers/scsi/g_NCR5380.h	2002-10-06 00:32:31.000000000 +0100
@@ -48,7 +48,9 @@
 int generic_NCR5380_detect(Scsi_Host_Template *);
 int generic_NCR5380_release_resources(struct Scsi_Host *);
 int generic_NCR5380_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int generic_NCR5380_reset(Scsi_Cmnd *, unsigned int);
+int generic_NCR5380_bus_reset(Scsi_Cmnd *);
+int generic_NCR5380_host_reset(Scsi_Cmnd *);
+int generic_NCR5380_device_reset(Scsi_Cmnd *);
 int notyet_generic_proc_info (char *buffer ,char **start, off_t offset,
                      int length, int hostno, int inout);
 const char* generic_NCR5380_info(struct Scsi_Host *);
@@ -77,8 +79,10 @@
 	release:        generic_NCR5380_release_resources,		\
 	info:           (void *)generic_NCR5380_info,			\
 	queuecommand:   generic_NCR5380_queue_command,			\
-	abort:          generic_NCR5380_abort,				\
-	reset:          generic_NCR5380_reset, 				\
+	eh_abort_handler:generic_NCR5380_abort,				\
+	eh_bus_reset_handler:generic_NCR5380_bus_reset,			\
+	eh_device_reset_handler:generic_NCR5380_device_reset,		\
+	eh_host_reset_handler:generic_NCR5380_host_reset,			\
 	bios_param:     NCR5380_BIOSPARAM,				\
 	can_queue:      CAN_QUEUE,					\
         this_id:        7,						\
@@ -154,7 +158,9 @@
 #define do_NCR5380_intr do_generic_NCR5380_intr
 #define NCR5380_queue_command generic_NCR5380_queue_command
 #define NCR5380_abort generic_NCR5380_abort
-#define NCR5380_reset generic_NCR5380_reset
+#define NCR5380_bus_reset generic_NCR5380_bus_reset
+#define NCR5380_device_reset generic_NCR5380_device_reset
+#define NCR5380_host_reset generic_NCR5380_host_reset
 #define NCR5380_pread generic_NCR5380_pread
 #define NCR5380_pwrite generic_NCR5380_pwrite
 #define NCR5380_proc_info notyet_generic_proc_info
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/scsi/NCR5380.c linux.2.5.40-ac5/drivers/scsi/NCR5380.c
--- linux.2.5.40/drivers/scsi/NCR5380.c	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.40-ac5/drivers/scsi/NCR5380.c	2002-10-06 00:31:38.000000000 +0100
@@ -396,24 +396,21 @@
  *
  *	Print the SCSI bus signals for debugging purposes
  *
- *	Locks: none
+ *	Locks: caller holds hostdata lock (not essential)
  */
 
 static void NCR5380_print(struct Scsi_Host *instance)
 {
 	NCR5380_local_declare();
-	unsigned long flags;
 	unsigned char status, data, basr, mr, icr, i;
 	NCR5380_setup(instance);
-	/* FIXME - this needs proper locking */
-	save_flags(flags);
-	cli();
+
 	data = NCR5380_read(CURRENT_SCSI_DATA_REG);
 	status = NCR5380_read(STATUS_REG);
 	mr = NCR5380_read(MODE_REG);
 	icr = NCR5380_read(INITIATOR_COMMAND_REG);
 	basr = NCR5380_read(BUS_AND_STATUS_REG);
-	restore_flags(flags);
+
 	printk("STATUS_REG: %02x ", status);
 	for (i = 0; signals[i].mask; ++i)
 		if (status & signals[i].mask)
@@ -500,7 +497,8 @@
  *      request.  main_running is checked/set here (in an inline function)
  *      rather than in NCR5380_main itself to reduce the chances of stack
  *      overflow.
- *
+ * FIXME: NCR5380_main should probably be run with schedule_task or be a
+ * thread.
  */
 
 static __inline__ void run_main(void)
@@ -533,6 +531,7 @@
 #endif
 
 static struct Scsi_Host *expires_first = NULL;
+static spinlock_t timer_lock;	/* Guards expires list */
 
 /* 
  * Function : int should_disconnect (unsigned char cmd)
@@ -578,17 +577,21 @@
 
 /*
  * Assumes instance->time_expires has been set in higher level code.
+ * We should move to a timer per host
  *
- * Locks: Caller must hold io_request_lock
+ * Locks: Takes the timer queue lock
  */
 
 static int NCR5380_set_timer(struct Scsi_Host *instance)
 {
 	struct Scsi_Host *tmp, **prev;
+	unsigned long flags;
 
 	if (((struct NCR5380_hostdata *) (instance->hostdata))->next_timer) {
 		return -1;
 	}
+	
+	spin_lock_irqsave(&timer_lock, flags);
 	for (prev = &expires_first, tmp = expires_first; tmp; prev = &(((struct NCR5380_hostdata *) tmp->hostdata)->next_timer), tmp = ((struct NCR5380_hostdata *) tmp->hostdata)->next_timer)
 		if (((struct NCR5380_hostdata *) instance->hostdata)->time_expires < ((struct NCR5380_hostdata *) tmp->hostdata)->time_expires)
 			break;
@@ -597,6 +600,8 @@
 	*prev = instance;
 
 	mod_timer(&usleep_timer, ((struct NCR5380_hostdata *) expires_first->hostdata)->time_expires);
+	
+	spin_unlock_irqrestore(&timer_lock, flags);
 	return 0;
 }
 
@@ -610,15 +615,15 @@
  *
  *	Doing something about unwanted reentrancy here might be useful 
  *
- *	Locks: disables irqs, takes and frees io_request_lock
+ *	Locks: disables irqs, takes and frees the timer lock
  */
  
 static void NCR5380_timer_fn(unsigned long unused)
 {
 	struct Scsi_Host *instance;
+	unsigned long flags;
 
-	spin_lock_irq(&io_request_lock);
-	
+	spin_lock_irqsave(&timer_lock, flags);
 	for (; expires_first && time_before_eq(((struct NCR5380_hostdata *) expires_first->hostdata)->time_expires, jiffies);) {
 		instance = ((struct NCR5380_hostdata *) expires_first->hostdata)->next_timer;
 		((struct NCR5380_hostdata *) expires_first->hostdata)->next_timer = NULL;
@@ -631,8 +636,10 @@
 		usleep_timer.expires = ((struct NCR5380_hostdata *) expires_first->hostdata)->time_expires;
 		add_timer(&usleep_timer);
 	}
+
+	spin_unlock_irqrestore(&timer_lock, flags);
+	
 	run_main();
-	spin_unlock_irq(&io_request_lock);
 }
 
 /**
@@ -648,6 +655,7 @@
 		dprintk(NDEBUG_INIT, ("scsi : NCR5380_all_init()\n"));
 		done = 1;
 		init_timer(&usleep_timer);
+		spin_lock_init(&timer_lock);
 		usleep_timer.function = NCR5380_timer_fn;
 	}
 }
@@ -777,7 +785,7 @@
  *	Print commands in the various queues, called from NCR5380_abort 
  *	and NCR5380_debug to aid debugging.
  *
- *	Locks: called functions disable irqs, missing queue lock in proc call
+ *	Locks: called functions disable irqs
  */
 
 static void NCR5380_print_status(struct Scsi_Host *instance)
@@ -872,7 +880,7 @@
 #ifdef PAS16_PUBLIC_RELEASE
 	SPRINTF("Highwater I/O busy_spin_counts -- write: %d  read: %d\n", pas_wmaxi, pas_maxi);
 #endif
-	spin_lock_irq(&io_request_lock);
+	spin_lock_irq(instance->host_lock);
 	SPRINTF("NCR5380 : coroutine is%s running.\n", main_running ? "" : "n't");
 	if (!hostdata->connected)
 		SPRINTF("scsi%d: no currently connected command\n", instance->host_no);
@@ -886,7 +894,7 @@
 	for (ptr = (Scsi_Cmnd *) hostdata->disconnected_queue; ptr; ptr = (Scsi_Cmnd *) ptr->host_scribble)
 		pos = lprint_Scsi_Cmnd(ptr, pos, buffer, length);
 
-	spin_unlock_irq(&io_request_lock);
+	spin_unlock_irq(instance->host_lock);
 	
 	*start = buffer;
 	if (pos - buffer < offset)
@@ -1131,6 +1139,8 @@
 	dprintk(NDEBUG_QUEUES, ("scsi%d : command added to %s of queue\n", instance->host_no, (cmd->cmnd[0] == REQUEST_SENSE) ? "head" : "tail"));
 
 	/* Run the coroutine if it isn't already running. */
+	
+	/* FIMXE: drop any locks here */
 	run_main();
 	return 0;
 }
@@ -1276,20 +1286,22 @@
 }
 
 #ifndef DONT_USE_INTR
-#include <linux/blk.h>
-#include <linux/spinlock.h>
 
 /**
  * 	NCR5380_intr	-	generic NCR5380 irq handler
+ *	@irq: interrupt number
+ *	@dev_id: device info
+ *	@regs: registers (unused)
  *
  *	Handle interrupts, reestablishing I_T_L or I_T_L_Q nexuses
  *      from the disconnected queue, and restarting NCR5380_main() 
  *      as required.
  *
- *	Locks: caller must hold the io_request lock.
+ *	Locks: takes the needed instance locks
  */
 
-static void NCR5380_intr(int irq, void *dev_id, struct pt_regs *regs) {
+static void NCR5380_intr(int irq, void *dev_id, struct pt_regs *regs) 
+{
 	NCR5380_local_declare();
 	struct Scsi_Host *instance;
 	int done;
@@ -1299,9 +1311,12 @@
 
 	do {
 		done = 1;
+		/* The instance list is constant while the driver is
+		   loaded */
 		for (instance = first_instance; instance && (instance->hostt == the_template); instance = instance->next)
+		{
 			if (instance->irq == irq) {
-
+				spin_lock_irq(instance->host_lock);
 				/* Look for pending interrupts */
 				NCR5380_setup(instance);
 				basr = NCR5380_read(BUS_AND_STATUS_REG);
@@ -1343,15 +1358,19 @@
 							{
 								unsigned long timeout = jiffies + NCR_TIMEOUT;
 
-								spin_unlock_irq(&io_request_lock);
-								while (NCR5380_read(BUS_AND_STATUS_REG) & BASR_ACK && time_before(jiffies, timeout));
-								spin_lock_irq(&io_request_lock);
+								spin_unlock_irq(instance->host_lock);
+								/* FIXME: prove timer is always running here! */
+								while (NCR5380_read(BUS_AND_STATUS_REG) & BASR_ACK && time_before(jiffies, timeout))
+									cpu_relax();
+								spin_lock_irq(instance->host_lock);
 
 								if (time_after_eq(jiffies, timeout))
 									printk("scsi%d: timeout at NCR5380.c:%d\n", host->host_no, __LINE__);
 							}
+							
 #else /* NCR_TIMEOUT */
-							while (NCR5380_read(BUS_AND_STATUS_REG) & BASR_ACK);
+							while (NCR5380_read(BUS_AND_STATUS_REG) & BASR_ACK)
+								cpu_relax();
 #endif
 
 							NCR5380_write(MODE_REG, MR_BASE);
@@ -1363,33 +1382,15 @@
 #endif
 					}
 				}	/* if BASR_IRQ */
+				spin_unlock_irq(instance->host_lock);
 				if (!done)
 					run_main();
 			}	/* if (instance->irq == irq) */
+		}
 	} while (!done);
 }
 
-/**
- *	do_NCR5380_intr
- *	@irq: interrupt number
- *	@dev_id: device info
- *	@regs: registers (unused)
- *
- *	Takes the io_request_lock and invokes the generic NCR5380 interrupt
- *	handler code
- *
- *	Locks: takes and releases the io_request lock
- */
-
-static void do_NCR5380_intr(int irq, void *dev_id, struct pt_regs *regs) {
-	unsigned long flags;
-
-	 spin_lock_irqsave(&io_request_lock, flags);
-	 NCR5380_intr(irq, dev_id, regs);
-	 spin_unlock_irqrestore(&io_request_lock, flags);
-}
-#endif
-
+#endif 
 
 /**
  *	collect_stats		-	collect stats on a scsi command
@@ -1450,7 +1451,7 @@
  *      If failed (no target) : cmd->scsi_done() will be called, and the 
  *              cmd->result host byte set to DID_BAD_TARGET.
  *
- *	Locks: caller holds io_request_lock
+ *	Locks: caller holds hostdata lock
  */
  
 static int NCR5380_select(struct Scsi_Host *instance, Scsi_Cmnd * cmd, int tag) 
@@ -1493,12 +1494,13 @@
 	{
 		unsigned long timeout = jiffies + 2 * NCR_TIMEOUT;
 
-		spin_unlock_irq(&io_request_lock);
+		spin_unlock_irq(instance->host_lock);
 
 		while (!(NCR5380_read(INITIATOR_COMMAND_REG) & ICR_ARBITRATION_PROGRESS)
-		       && time_before(jiffies, timeout));
+		       && time_before(jiffies, timeout))
+		       	cpu_relax();
 
-		spin_lock_irq(&io_request_lock);
+		spin_lock_irq(instance->host_lock);
 
 		if (time_after_eq(jiffies, timeout)) {
 			printk("scsi: arbitration timeout at %d\n", __LINE__);
@@ -1624,6 +1626,7 @@
 	   we poll only once ech clock tick */
 	value = NCR5380_read(STATUS_REG) & (SR_BSY | SR_IO);
 
+	/* FIXME HZ=100 assumption ? */
 	if (!value && (hostdata->select_time < 25)) {
 		/* RvC: we still must wait for a device response */
 		hostdata->select_time++;	/* after 25 ticks the device has failed */
@@ -1692,9 +1695,10 @@
 	{
 		unsigned long timeout = jiffies + NCR_TIMEOUT;
 
-		spin_unlock_irq(&io_request_lock);
-		while (!(NCR5380_read(STATUS_REG) & SR_REQ) && time_before(jiffies, timeout));
-		spin_lock_irq(&io_request_lock);
+		spin_unlock_irq(instance->host_lock);
+		while (!(NCR5380_read(STATUS_REG) & SR_REQ) && time_before(jiffies, timeout))
+			cpu_relax();
+		spin_lock_irq(instance->host_lock);
 
 		if (time_after_eq(jiffies, timeout)) {
 			printk("scsi%d: timeout at NCR5380.c:%d\n", instance->host_no, __LINE__);
@@ -1703,7 +1707,8 @@
 		}
 	}
 #else				/* NCR_TIMEOUT */
-	while (!(NCR5380_read(STATUS_REG) & SR_REQ));
+	while (!(NCR5380_read(STATUS_REG) & SR_REQ))
+		cpu_relax();
 #endif				/* def NCR_TIMEOUT */
 
 	dprintk(NDEBUG_SELECTION, ("scsi%d : target %d selected, going into MESSAGE OUT phase.\n", instance->host_no, cmd->target));
@@ -1886,7 +1891,8 @@
  *	Issue a reset sequence to the NCR5380 and try and get the bus
  *	back into sane shape.
  *
- *	Locks: caller holds io_request lock
+ *	Locks: caller holds queue lock
+ *	FIXME: sort this out and get new_eh running
  */
  
 static void do_reset(struct Scsi_Host *host) {
@@ -1907,7 +1913,8 @@
  * 
  * Returns : 0 on success, -1 on failure.
  *
- * Locks: io_request lock held by caller
+ * Locks: queue lock held by caller
+ *	FIXME: sort this out and get new_eh running
  */
 
 static int do_abort(struct Scsi_Host *host) {
@@ -1930,7 +1937,8 @@
 	 * the target sees, so we just handshake.
 	 */
 
-	while (!(tmp = NCR5380_read(STATUS_REG)) & SR_REQ);
+	while (!(tmp = NCR5380_read(STATUS_REG)) & SR_REQ)
+		cpu_relax();
 
 	NCR5380_write(TARGET_COMMAND_REG, PHASE_SR_TO_TCR(tmp));
 
@@ -2019,7 +2027,7 @@
 	 */
 
 #if defined(PSEUDO_DMA) && defined(UNSAFE)
-	spin_unlock_irq(&io_request_lock);
+	spin_unlock_irq(instance->host_lock);
 #endif
 	/* KLL May need eop and parity in 53c400 */
 	if (hostdata->flags & FLAG_NCR53C400)
@@ -2228,7 +2236,7 @@
 	*count = 0;
 	*phase = NCR5380_read(STATUS_REG) & PHASE_MASK;
 #if defined(PSEUDO_DMA) && defined(UNSAFE)
-	spin_lock_irq(&io_request_lock);
+	spin_lock_irq(instance->host_lock);
 #endif				/* defined(REAL_DMA_POLL) */
 	return foo;
 #endif				/* def REAL_DMA */
@@ -2707,9 +2715,11 @@
 
 	/*
 	 * Wait for target to go into MSGIN.
+	 * FIXME: timeout needed
 	 */
 
-	while (!(NCR5380_read(STATUS_REG) & SR_REQ));
+	while (!(NCR5380_read(STATUS_REG) & SR_REQ))
+		cpu_relax();
 
 	len = 1;
 	data = msg;
@@ -2843,12 +2853,12 @@
 	struct NCR5380_hostdata *hostdata = (struct NCR5380_hostdata *) instance->hostdata;
 	Scsi_Cmnd *tmp, **prev;
 
-	printk("scsi%d : aborting command\n", instance->host_no);
+	printk(KERN_WARNING "scsi%d : aborting command\n", instance->host_no);
 	print_Scsi_Cmnd(cmd);
 
 	NCR5380_print_status(instance);
 
-	printk("scsi%d : aborting command\n", instance->host_no);
+	printk(KERN_WARNING "scsi%d : aborting command\n", instance->host_no);
 	print_Scsi_Cmnd(cmd);
 
 	NCR5380_print_status(instance);
@@ -2893,6 +2903,8 @@
  * Case 2 : If the command hasn't been issued yet, we simply remove it 
  *          from the issue queue.
  */
+ 
+ 	/* FIXME: check - I think we need the hostdata lock here */
 	/* KLL */
 	dprintk(NDEBUG_ABORT, ("scsi%d : abort going into loop.\n", instance->host_no));
 	for (prev = (Scsi_Cmnd **) & (hostdata->issue_queue), tmp = (Scsi_Cmnd *) hostdata->issue_queue; tmp; prev = (Scsi_Cmnd **) & (tmp->host_scribble), tmp = (Scsi_Cmnd *) tmp->host_scribble)
@@ -2903,12 +2915,12 @@
 			tmp->result = DID_ABORT << 16;
 			dprintk(NDEBUG_ABORT, ("scsi%d : abort removed command from issue queue.\n", instance->host_no));
 			tmp->done(tmp);
-			return SCSI_ABORT_SUCCESS;
+			return SUCCESS;
 		}
 #if (NDEBUG  & NDEBUG_ABORT)
 	/* KLL */
 		else if (prev == tmp)
-			printk("scsi%d : LOOP\n", instance->host_no);
+			printk(KERN_ERR "scsi%d : LOOP\n", instance->host_no);
 #endif
 
 /* 
@@ -2924,7 +2936,7 @@
 
 	if (hostdata->connected) {
 		dprintk(NDEBUG_ABORT, ("scsi%d : abort failed, command connected.\n", instance->host_no));
-		return SCSI_ABORT_NOT_RUNNING;
+		return FAILED;
 	}
 /*
  * Case 4: If the command is currently disconnected from the bus, and 
@@ -2956,7 +2968,7 @@
 			dprintk(NDEBUG_ABORT, ("scsi%d : aborting disconnected command.\n", instance->host_no));
 
 			if (NCR5380_select(instance, cmd, (int) cmd->tag))
-				return SCSI_ABORT_BUSY;
+				return FAILED;
 			dprintk(NDEBUG_ABORT, ("scsi%d : nexus reestablished.\n", instance->host_no));
 
 			do_abort(instance);
@@ -2968,7 +2980,7 @@
 					tmp->host_scribble = NULL;
 					tmp->result = DID_ABORT << 16;
 					tmp->done(tmp);
-					return SCSI_ABORT_SUCCESS;
+					return SUCCESS;
 				}
 		}
 /*
@@ -2980,30 +2992,68 @@
  * so we won't panic, but we will notify the user in case something really
  * broke.
  */
-	printk("scsi%d : warning : SCSI command probably completed successfully\n" "         before abortion\n", instance->host_no);
-	return SCSI_ABORT_NOT_RUNNING;
+	printk(KERN_WARNING "scsi%d : warning : SCSI command probably completed successfully\n" "         before abortion\n", instance->host_no);
+	return FAILED;
 }
 
 
 /* 
- * Function : int NCR5380_reset (Scsi_Cmnd *cmd, unsigned int reset_flags)
+ * Function : int NCR5380_bus_reset (Scsi_Cmnd *cmd)
  * 
  * Purpose : reset the SCSI bus.
  *
- * Returns : SCSI_RESET_WAKEUP
+ * Returns : SUCCESS
  *
  * Locks: io_request_lock held by caller
  */
 
-#ifndef NCR5380_reset
+#ifndef NCR5380_bus_reset
 static
 #endif
-int NCR5380_reset(Scsi_Cmnd * cmd, unsigned int dummy) {
+int NCR5380_bus_reset(Scsi_Cmnd * cmd) {
 	NCR5380_local_declare();
 	NCR5380_setup(cmd->host);
 
 	NCR5380_print_status(cmd->host);
 	do_reset(cmd->host);
 
-	return SCSI_RESET_WAKEUP;
+	return SUCCESS;
+}
+
+/* 
+ * Function : int NCR5380_device_reset (Scsi_Cmnd *cmd)
+ * 
+ * Purpose : reset a SCSI device
+ *
+ * Returns : FAILED
+ *
+ * Locks: io_request_lock held by caller
+ */
+
+#ifndef NCR5380_device_reset
+static
+#endif
+int NCR5380_device_reset(Scsi_Cmnd * cmd) {
+	NCR5380_local_declare();
+	NCR5380_setup(cmd->host);
+	return FAILED;
+}
+
+/* 
+ * Function : int NCR5380_host_reset (Scsi_Cmnd *cmd)
+ * 
+ * Purpose : reset a SCSI device
+ *
+ * Returns : FAILED
+ *
+ * Locks: io_request_lock held by caller
+ */
+
+#ifndef NCR5380_host_reset
+static
+#endif
+int NCR5380_host_reset(Scsi_Cmnd * cmd) {
+	NCR5380_local_declare();
+	NCR5380_setup(cmd->host);
+	return FAILED;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/scsi/NCR5380.h linux.2.5.40-ac5/drivers/scsi/NCR5380.h
--- linux.2.5.40/drivers/scsi/NCR5380.h	2002-07-20 20:11:21.000000000 +0100
+++ linux.2.5.40-ac5/drivers/scsi/NCR5380.h	2002-10-06 00:14:22.000000000 +0100
@@ -304,10 +304,18 @@
 static
 #endif
 int NCR5380_abort(Scsi_Cmnd * cmd);
-#ifndef NCR5380_reset
+#ifndef NCR5380_bus_reset
 static
 #endif
-int NCR5380_reset(Scsi_Cmnd * cmd, unsigned int reset_flags);
+int NCR5380_bus_reset(Scsi_Cmnd * cmd);
+#ifndef NCR5380_host_reset
+static
+#endif
+int NCR5380_host_reset(Scsi_Cmnd * cmd);
+#ifndef NCR5380_device_reset
+static
+#endif
+int NCR5380_device_reset(Scsi_Cmnd * cmd);
 #ifndef NCR5380_queue_command
 static
 #endif
