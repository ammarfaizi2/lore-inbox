Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261435AbSJHTMQ>; Tue, 8 Oct 2002 15:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSJHTME>; Tue, 8 Oct 2002 15:12:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25872 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263252AbSJHTHi>; Tue, 8 Oct 2002 15:07:38 -0400
Subject: PATCH: first pass at seagate st-02 for 2.5
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:04:19 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzeV-0004uc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/seagate.c linux.2.5.41-ac1/drivers/scsi/seagate.c
--- linux.2.5.41/drivers/scsi/seagate.c	2002-07-20 20:11:16.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/seagate.c	2002-10-07 14:32:31.000000000 +0100
@@ -265,16 +265,14 @@
 #define WRITE_CONTROL(d) { isa_writeb((d), st0x_cr_sr); }
 #define WRITE_DATA(d) { isa_writeb((d), st0x_dr); }
 
-void
-st0x_setup (char *str, int *ints)
+static void st0x_setup (char *str, int *ints)
 {
 	controller_type = SEAGATE;
 	base_address = ints[1];
 	irq = ints[2];
 }
 
-void
-tmc8xx_setup (char *str, int *ints)
+static void tmc8xx_setup (char *str, int *ints)
 {
 	controller_type = FD;
 	base_address = ints[1];
@@ -389,8 +387,14 @@
 {
 	register int count = 0, start = jiffies + 1, stop = start + 25;
 
-	while (time_before (jiffies, start)) ;
-	for (; time_before (jiffies, stop); ++count) ;
+	/* FIXME: There may be a better approach, this is a straight port for
+	   now */
+	preempt_disable();
+	while (time_before (jiffies, start))
+		cpu_relax();
+	for (; time_before (jiffies, stop); ++count)
+		cpu_relax();
+	preempt_enable();
 
 /*
  * Ok, we now have a count for .25 seconds.  Convert to a
@@ -406,8 +410,9 @@
 {
 	register int count;
 
-	for (count = borken_calibration; count && (STATUS & STAT_REQ);
-	     --count) ;
+	for (count = borken_calibration; count && (STATUS & STAT_REQ); --count)
+		cpu_relax();
+	     	
 #if (DEBUG & DEBUG_BORKEN)
 	if (count)
 		printk ("scsi%d : borken timeout\n", hostno);
@@ -431,7 +436,7 @@
 
 	tpnt->proc_name = "seagate";
 /*
- *    First, we try for the manual override.
+ *	First, we try for the manual override.
  */
 	DANY ("Autodetecting ST0x / TMC-8xx\n");
 
@@ -462,14 +467,9 @@
  * space for the on-board RAM instead.
  */
 
-		for (i = 0;
-		     i < (sizeof (seagate_bases) / sizeof (unsigned int)); ++i)
-
+		for (i = 0; i < (sizeof (seagate_bases) / sizeof (unsigned int)); ++i)
 			for (j = 0; !base_address && j < NUM_SIGNATURES; ++j)
-				if (isa_check_signature
-				    (seagate_bases[i] + signatures[j].offset,
-				     signatures[j].signature,
-				     signatures[j].length)) {
+				if (isa_check_signature(seagate_bases[i] + signatures[j].offset, signatures[j].signature, signatures[j].length)) {
 					base_address = seagate_bases[i];
 					controller_type = signatures[j].type;
 				}
@@ -480,40 +480,36 @@
 	tpnt->name = (controller_type == SEAGATE) ? ST0X_ID_STR : FD_ID_STR;
 
 	if (!base_address) {
-		DANY ("ST0x / TMC-8xx not detected.\n");
+		printk(KERN_INFO "seagate: ST0x/TMC-8xx not detected.\n");
 		return 0;
 	}
 
-	st0x_cr_sr =
-	    base_address + (controller_type == SEAGATE ? 0x1a00 : 0x1c00);
+	st0x_cr_sr = base_address + (controller_type == SEAGATE ? 0x1a00 : 0x1c00);
 	st0x_dr = st0x_cr_sr + 0x200;
 
-	DANY ("%s detected. Base address = %x, cr = %x, dr = %x\n",
+	DANY("%s detected. Base address = %x, cr = %x, dr = %x\n",
 	      tpnt->name, base_address, st0x_cr_sr, st0x_dr);
 
-/*
- *	At all times, we will use IRQ 5.  Should also check for IRQ3 if we
- *      loose our first interrupt.
- */
+	/*
+	 *	At all times, we will use IRQ 5.  Should also check for IRQ3
+	 *	if we loose our first interrupt.
+	 */
 	instance = scsi_register (tpnt, 0);
 	if (instance == NULL)
 		return 0;
 
 	hostno = instance->host_no;
-	if (request_irq (irq, do_seagate_reconnect_intr, SA_INTERRUPT,
-			 (controller_type == SEAGATE) ? "seagate" : "tmc-8xx",
-			 instance)) {
-		printk ("scsi%d : unable to allocate IRQ%d\n", hostno, irq);
+	if (request_irq (irq, do_seagate_reconnect_intr, SA_INTERRUPT, (controller_type == SEAGATE) ? "seagate" : "tmc-8xx", instance)) {
+		printk(KERN_ERR "scsi%d : unable to allocate IRQ%d\n", hostno, irq);
 		return 0;
 	}
 	instance->irq = irq;
 	instance->io_port = base_address;
 #ifdef SLOW_RATE
-	printk (KERN_INFO "Calibrating borken timer... ");
-	borken_init ();
-	printk (" %d cycles per transfer\n", borken_calibration);
+	printk(KERN_INFO "Calibrating borken timer... ");
+	borken_init();
+	printk(" %d cycles per transfer\n", borken_calibration);
 #endif
-
 	printk (KERN_INFO "This is one second... ");
 	{
 		int clock;
@@ -559,12 +555,11 @@
 	return 1;
 }
 
-const char *
-seagate_st0x_info (struct Scsi_Host *shpnt)
+static const char *seagate_st0x_info (struct Scsi_Host *shpnt)
 {
 	static char buffer[64];
 
-	sprintf (buffer, "%s at irq %d, address 0x%05X",
+	snprintf(buffer, 64, "%s at irq %d, address 0x%05X",
 		 (controller_type == SEAGATE) ? ST0X_ID_STR : FD_ID_STR,
 		 irq, base_address);
 	return buffer;
@@ -640,36 +635,29 @@
 	int temp;
 	Scsi_Cmnd *SCtmp;
 
-	DPRINTK (PHASE_RESELECT, "scsi%d : seagate_reconnect_intr() called\n",
-		 hostno);
+	DPRINTK (PHASE_RESELECT, "scsi%d : seagate_reconnect_intr() called\n", hostno);
 
 	if (!should_reconnect)
-		printk ("scsi%d: unexpected interrupt.\n", hostno);
+		printk(KERN_WARNING "scsi%d: unexpected interrupt.\n", hostno);
 	else {
 		should_reconnect = 0;
 
-		DPRINTK (PHASE_RESELECT, "scsi%d : internal_command("
-			 "%d, %08x, %08x, RECONNECT_NOW\n", hostno,
-			 current_target, current_data, current_bufflen);
-
-		temp =
-		    internal_command (current_target, current_lun, current_cmnd,
-				      current_data, current_bufflen,
-				      RECONNECT_NOW);
+		DPRINTK (PHASE_RESELECT, "scsi%d : internal_command(%d, %08x, %08x, RECONNECT_NOW\n", 
+			hostno, current_target, current_data, current_bufflen);
 
-		if (msg_byte (temp) != DISCONNECT) {
+		temp = internal_command (current_target, current_lun, current_cmnd, current_data, current_bufflen, RECONNECT_NOW);
+
+		if (msg_byte(temp) != DISCONNECT) {
 			if (done_fn) {
-				DPRINTK (PHASE_RESELECT,
-					 "scsi%d : done_fn(%d,%08x)", hostno,
-					 hostno, temp);
+				DPRINTK(PHASE_RESELECT, "scsi%d : done_fn(%d,%08x)", hostno, hostno, temp);
 				if (!SCint)
 					panic ("SCint == NULL in seagate");
 				SCtmp = SCint;
 				SCint = NULL;
 				SCtmp->result = temp;
-				done_fn (SCtmp);
+				done_fn(SCtmp);
 			} else
-				printk ("done_fn() not defined.\n");
+				printk(KERN_ERR "done_fn() not defined.\n");
 		}
 	}
 }
@@ -687,7 +675,7 @@
 
 static int recursion_depth = 0;
 
-int seagate_st0x_queue_command (Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
+static int seagate_st0x_queue_command (Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
 {
 	int result, reconnect;
 	Scsi_Cmnd *SCtmp;
@@ -696,53 +684,49 @@
 	done_fn = done;
 	current_target = SCpnt->target;
 	current_lun = SCpnt->lun;
-	(const void *) current_cmnd = SCpnt->cmnd;
+	current_cmnd = SCpnt->cmnd;
 	current_data = (unsigned char *) SCpnt->request_buffer;
 	current_bufflen = SCpnt->request_bufflen;
 	SCint = SCpnt;
 	if (recursion_depth)
-		return 0;
+		return 1;
 	recursion_depth++;
 	do {
 #ifdef LINKED
-/*
- * Set linked command bit in control field of SCSI command.
- */
+		/*
+		 * Set linked command bit in control field of SCSI command.
+		 */
 
 		current_cmnd[SCpnt->cmd_len] |= 0x01;
 		if (linked_connected) {
-			DPRINTK (DEBUG_LINKED,
-				 "scsi%d : using linked commands, current I_T_L nexus is ",
-				 hostno);
-			if ((linked_target == current_target)
-			    && (linked_lun == current_lun)) {
-				DPRINTK (DEBUG_LINKED, "correct\n");
+			DPRINTK (DEBUG_LINKED, "scsi%d : using linked commands, current I_T_L nexus is ", hostno);
+			if (linked_target == current_target && linked_lun == current_lun) 
+			{
+				DPRINTK(DEBUG_LINKED, "correct\n");
 				reconnect = LINKED_RIGHT;
 			} else {
-				DPRINTK (DEBUG_LINKED, "incorrect\n");
+				DPRINTK(DEBUG_LINKED, "incorrect\n");
 				reconnect = LINKED_WRONG;
 			}
 		} else
 #endif				/* LINKED */
 			reconnect = CAN_RECONNECT;
 
-		result =
-		    internal_command (SCint->target, SCint->lun, SCint->cmnd,
-				      SCint->request_buffer,
-				      SCint->request_bufflen, reconnect);
-		if (msg_byte (result) == DISCONNECT)
+		result = internal_command(SCint->target, SCint->lun, SCint->cmnd,
+				      SCint->request_buffer, SCint->request_bufflen, reconnect);
+		if (msg_byte(result) == DISCONNECT)
 			break;
 		SCtmp = SCint;
 		SCint = NULL;
 		SCtmp->result = result;
-		done_fn (SCtmp);
+		done_fn(SCtmp);
 	}
 	while (SCint);
 	recursion_depth--;
 	return 0;
 }
 
-int seagate_st0x_command (Scsi_Cmnd * SCpnt)
+static int seagate_st0x_command(Scsi_Cmnd * SCpnt)
 {
 	return internal_command (SCpnt->target, SCpnt->lun, SCpnt->cmnd,
 				 SCpnt->request_buffer, SCpnt->request_bufflen,
@@ -755,17 +739,12 @@
 	unsigned char *data = NULL;
 	struct scatterlist *buffer = NULL;
 	int clock, temp, nobuffs = 0, done = 0, len = 0;
-	unsigned long flags;
-
 #ifdef DEBUG
 	int transfered = 0, phase = 0, newphase;
 #endif
-
 	register unsigned char status_read;
 	unsigned char tmp_data, tmp_control, status = 0, message = 0;
-
 	unsigned transfersize = 0, underflow = 0;
-
 #ifdef SLOW_RATE
 	int borken = (int) SCint->device->borken;	/* Does the current target require
 							   Very Slow I/O ?  */
@@ -775,84 +754,76 @@
 	st0x_aborted = 0;
 
 #if (DEBUG & PRINT_COMMAND)
-	printk ("scsi%d : target = %d, command = ", hostno, target);
-	print_command ((unsigned char *) cmnd);
+	printk("scsi%d : target = %d, command = ", hostno, target);
+	print_command((unsigned char *) cmnd);
 #endif
 
 #if (DEBUG & PHASE_RESELECT)
 	switch (reselect) {
 	case RECONNECT_NOW:
-		printk ("scsi%d : reconnecting\n", hostno);
+		printk("scsi%d : reconnecting\n", hostno);
 		break;
 #ifdef LINKED
 	case LINKED_RIGHT:
-		printk ("scsi%d : connected, can reconnect\n", hostno);
+		printk("scsi%d : connected, can reconnect\n", hostno);
 		break;
 	case LINKED_WRONG:
-		printk ("scsi%d : connected to wrong target, can reconnect\n",
+		printk("scsi%d : connected to wrong target, can reconnect\n",
 			hostno);
 		break;
 #endif
 	case CAN_RECONNECT:
-		printk ("scsi%d : allowed to reconnect\n", hostno);
+		printk("scsi%d : allowed to reconnect\n", hostno);
 		break;
 	default:
-		printk ("scsi%d : not allowed to reconnect\n", hostno);
+		printk("scsi%d : not allowed to reconnect\n", hostno);
 	}
 #endif
 
 	if (target == (controller_type == SEAGATE ? 7 : 6))
 		return DID_BAD_TARGET;
 
-/*
- *	We work it differently depending on if this is is "the first time,"
- *      or a reconnect.  If this is a reselect phase, then SEL will
- *      be asserted, and we must skip selection / arbitration phases.
- */
+	/*
+	 *	We work it differently depending on if this is is "the first time,"
+	 *      or a reconnect.  If this is a reselect phase, then SEL will
+	 *      be asserted, and we must skip selection / arbitration phases.
+	 */
 
 	switch (reselect) {
 	case RECONNECT_NOW:
 		DPRINTK (PHASE_RESELECT, "scsi%d : phase RESELECT \n", hostno);
-
-/*
- *	At this point, we should find the logical or of our ID and the original
- *      target's ID on the BUS, with BSY, SEL, and I/O signals asserted.
- *
- *      After ARBITRATION phase is completed, only SEL, BSY, and the
- *      target ID are asserted.  A valid initiator ID is not on the bus
- *      until IO is asserted, so we must wait for that.
- */
+		/*
+		 *	At this point, we should find the logical or of our ID
+		 *	and the original target's ID on the BUS, with BSY, SEL,
+		 *	and I/O signals asserted.
+		 *
+		 *      After ARBITRATION phase is completed, only SEL, BSY,
+		 *	and the target ID are asserted.  A valid initiator ID
+		 *	is not on the bus until IO is asserted, so we must wait
+		 *	for that.
+		 */
 		ULOOP (100 * 1000) {
 			temp = STATUS;
 			if ((temp & STAT_IO) && !(temp & STAT_BSY))
 				break;
-
 			if (TIMEOUT) {
-				DPRINTK (PHASE_RESELECT,
-					 "scsi%d : RESELECT timed out while waiting for IO .\n",
-					 hostno);
+				DPRINTK (PHASE_RESELECT, "scsi%d : RESELECT timed out while waiting for IO .\n", hostno);
 				return (DID_BAD_INTR << 16);
 			}
 		}
 
-/*
- *	After I/O is asserted by the target, we can read our ID and its
- *      ID off of the BUS.
- */
+		/*
+		 *	After I/O is asserted by the target, we can read our ID
+		 *	and its ID off of the BUS.
+		 */
 
-		if (!
-		    ((temp =
-		      DATA) & (controller_type == SEAGATE ? 0x80 : 0x40))) {
-			DPRINTK (PHASE_RESELECT,
-				 "scsi%d : detected reconnect request to different target.\n"
-				 "\tData bus = %d\n", hostno, temp);
+		if (!((temp = DATA) & (controller_type == SEAGATE ? 0x80 : 0x40))) {
+			DPRINTK (PHASE_RESELECT, "scsi%d : detected reconnect request to different target.\n\tData bus = %d\n", hostno, temp);
 			return (DID_BAD_INTR << 16);
 		}
 
 		if (!(temp & (1 << current_target))) {
-			printk
-			    ("scsi%d : Unexpected reselect interrupt.  Data bus = %d\n",
-			     hostno, temp);
+			printk(KERN_WARNING "scsi%d : Unexpected reselect interrupt.  Data bus = %d\n", hostno, temp);
 			return (DID_BAD_INTR << 16);
 		}
 
@@ -862,10 +833,11 @@
 		len = current_bufflen;	/* WDE add */
 		nobuffs = current_nobuffs;
 
-/*
- *	We have determined that we have been selected.  At this point,
- *      we must respond to the reselection by asserting BSY ourselves
- */
+		/*
+		 *	We have determined that we have been selected.  At this
+		 *	point, we must respond to the reselection by asserting
+		 *	BSY ourselves
+		 */
 
 #if 1
 		WRITE_CONTROL (BASE_CMD | CMD_DRVR_ENABLE | CMD_BSY);
@@ -873,93 +845,80 @@
 		WRITE_CONTROL (BASE_CMD | CMD_BSY);
 #endif
 
-/*
- *	The target will drop SEL, and raise BSY, at which time we must drop
- *      BSY.
- */
+		/*
+		 *	The target will drop SEL, and raise BSY, at which time
+		 *	we must drop BSY.
+		 */
 
 		ULOOP (100 * 1000) {
 			if (!(STATUS & STAT_SEL))
 				break;
 			if (TIMEOUT) {
 				WRITE_CONTROL (BASE_CMD | CMD_INTR);
-				DPRINTK (PHASE_RESELECT,
-					 "scsi%d : RESELECT timed out while waiting for SEL.\n",
-					 hostno);
+				DPRINTK (PHASE_RESELECT, "scsi%d : RESELECT timed out while waiting for SEL.\n", hostno);
 				return (DID_BAD_INTR << 16);
 			}
 		}
-
 		WRITE_CONTROL (BASE_CMD);
-
-/*
- *	At this point, we have connected with the target and can get
- *      on with our lives.
- */
+		/*
+		 *	At this point, we have connected with the target
+		 *	and can get on with our lives.
+		 */
 		break;
 	case CAN_RECONNECT:
-
 #ifdef LINKED
-/*
- * This is a bletcherous hack, just as bad as the Unix #! interpreter stuff.
- * If it turns out we are using the wrong I_T_L nexus, the easiest way to deal
- * with it is to go into our INFORMATION TRANSFER PHASE code, send a ABORT
- * message on MESSAGE OUT phase, and then loop back to here.
- */
-
-	      connect_loop:
-
-#endif
-
-		DPRINTK (PHASE_BUS_FREE, "scsi%d : phase = BUS FREE \n",
-			 hostno);
-
-/*
- *    BUS FREE PHASE
- *
- *      On entry, we make sure that the BUS is in a BUS FREE
- *      phase, by insuring that both BSY and SEL are low for
- *      at least one bus settle delay.  Several reads help
- *      eliminate wire glitch.
- */
+		/*
+		 * This is a bletcherous hack, just as bad as the Unix #!
+		 * interpreter stuff. If it turns out we are using the wrong
+		 * I_T_L nexus, the easiest way to deal with it is to go into
+		 *  our INFORMATION TRANSFER PHASE code, send a ABORT
+		 * message on MESSAGE OUT phase, and then loop back to here.
+		 */
+connect_loop:
+#endif
+		DPRINTK (PHASE_BUS_FREE, "scsi%d : phase = BUS FREE \n", hostno);
+
+		/*
+		 *    BUS FREE PHASE
+		 *
+		 *      On entry, we make sure that the BUS is in a BUS FREE
+		 *      phase, by insuring that both BSY and SEL are low for
+		 *      at least one bus settle delay.  Several reads help
+		 *      eliminate wire glitch.
+		 */
 
 #ifndef ARBITRATE
 #error FIXME: this is broken: we may not use jiffies here - we are under cli(). It will hardlock.
 		clock = jiffies + ST0X_BUS_FREE_DELAY;
 
-		while (((STATUS | STATUS | STATUS) &
-			(STAT_BSY | STAT_SEL)) &&
-		       (!st0x_aborted) && time_before (jiffies, clock)) ;
+		while (((STATUS | STATUS | STATUS) & (STAT_BSY | STAT_SEL)) && (!st0x_aborted) && time_before (jiffies, clock))
+			cpu_relax();
 
 		if (time_after (jiffies, clock))
 			return retcode (DID_BUS_BUSY);
 		else if (st0x_aborted)
 			return retcode (st0x_aborted);
 #endif
-
-		DPRINTK (PHASE_SELECTION, "scsi%d : phase = SELECTION\n",
-			 hostno);
+		DPRINTK (PHASE_SELECTION, "scsi%d : phase = SELECTION\n", hostno);
 
 		clock = jiffies + ST0X_SELECTION_DELAY;
 
-/*
- * Arbitration/selection procedure :
- * 1.  Disable drivers
- * 2.  Write HOST adapter address bit
- * 3.  Set start arbitration.
- * 4.  We get either ARBITRATION COMPLETE or SELECT at this
- *     point.
- * 5.  OR our ID and targets on bus.
- * 6.  Enable SCSI drivers and asserted SEL and ATTN
- */
+		/*
+		 * Arbitration/selection procedure :
+		 * 1.  Disable drivers
+		 * 2.  Write HOST adapter address bit
+		 * 3.  Set start arbitration.
+		 * 4.  We get either ARBITRATION COMPLETE or SELECT at this
+		 *     point.
+		 * 5.  OR our ID and targets on bus.
+		 * 6.  Enable SCSI drivers and asserted SEL and ATTN
+		 */
 
 #ifdef ARBITRATE
-		save_flags (flags);
-		cli ();
-		WRITE_CONTROL (0);
-		WRITE_DATA ((controller_type == SEAGATE) ? 0x80 : 0x40);
-		WRITE_CONTROL (CMD_START_ARB);
-		restore_flags (flags);
+		/* FIXME: verify host lock is always held here */
+		WRITE_CONTROL(0);
+		WRITE_DATA((controller_type == SEAGATE) ? 0x80 : 0x40);
+		WRITE_CONTROL(CMD_START_ARB);
 
 		ULOOP (ST0X_SELECTION_DELAY * 10000) {
 			status_read = STATUS;
@@ -968,40 +927,31 @@
 			if (st0x_aborted)	/* FIXME: What? We are going to do something even after abort? */
 				break;
 			if (TIMEOUT || (status_read & STAT_SEL)) {
-				printk
-				    ("scsi%d : arbitration lost or timeout.\n",
-				     hostno);
+				printk(KERN_WARNING "scsi%d : arbitration lost or timeout.\n", hostno);
 				WRITE_CONTROL (BASE_CMD);
 				return retcode (DID_NO_CONNECT);
 			}
 		}
-
-		DPRINTK (PHASE_SELECTION, "scsi%d : arbitration complete\n",
-			 hostno);
+		DPRINTK (PHASE_SELECTION, "scsi%d : arbitration complete\n", hostno);
 #endif
 
-/*
- *    When the SCSI device decides that we're gawking at it, it will
- *    respond by asserting BUSY on the bus.
- *
- *    Note : the Seagate ST-01/02 product manual says that we should
- *    twiddle the DATA register before the control register.    However,
- *    this does not work reliably so we do it the other way around.
- *
- *    Probably could be a problem with arbitration too, we really should
- *    try this with a SCSI protocol or logic analyzer to see what is
- *    going on.
- */
-		tmp_data =
-		    (unsigned char) ((1 << target) |
-				     (controller_type ==
-				      SEAGATE ? 0x80 : 0x40));
-		tmp_control =
-		    BASE_CMD | CMD_DRVR_ENABLE | CMD_SEL | (reselect ? CMD_ATTN
-							    : 0);
+		/*
+		 *    When the SCSI device decides that we're gawking at it, 
+		 *    it will respond by asserting BUSY on the bus.
+		 *
+		 *    Note : the Seagate ST-01/02 product manual says that we
+		 *    should twiddle the DATA register before the control
+		 *    register. However, this does not work reliably so we do
+		 *    it the other way around.
+		 *
+		 *    Probably could be a problem with arbitration too, we
+		 *    really should try this with a SCSI protocol or logic 
+		 *    analyzer to see what is going on.
+		 */
+		tmp_data = (unsigned char) ((1 << target) | (controller_type == SEAGATE ? 0x80 : 0x40));
+		tmp_control = BASE_CMD | CMD_DRVR_ENABLE | CMD_SEL | (reselect ? CMD_ATTN : 0);
 
-		save_flags (flags);
-		cli ();
+		/* FIXME: verify host lock is always held here */
 #ifdef OLDCNTDATASCEME
 #ifdef SWAPCNTDATA
 		WRITE_CONTROL (tmp_control);
@@ -1018,22 +968,20 @@
 		WRITE_CONTROL (tmp_control);	/* -- pavel@ucw.cz   */
 #endif
 
-		restore_flags (flags);
-
 		ULOOP (250 * 1000) {
 			if (st0x_aborted) {
-/*
- *	If we have been aborted, and we have a command in progress, IE the
- *      target still has BSY asserted, then we will reset the bus, and
- *      notify the midlevel driver to expect sense.
- */
+				/*
+				 *	If we have been aborted, and we have a
+				 *	command in progress, IE the target 
+				 *	still has BSY asserted, then we will
+				 *	reset the bus, and notify the midlevel
+				 *	driver to expect sense.
+				 */
 
 				WRITE_CONTROL (BASE_CMD);
 				if (STATUS & STAT_BSY) {
-					printk
-					    ("scsi%d : BST asserted after we've been aborted.\n",
-					     hostno);
-					seagate_st0x_reset (NULL, 0);
+					printk(KERN_WARNING "scsi%d : BST asserted after we've been aborted.\n", hostno);
+					seagate_st0x_bus_reset(NULL);
 					return retcode (DID_RESET);
 				}
 				return retcode (st0x_aborted);
@@ -1041,26 +989,20 @@
 			if (STATUS & STAT_BSY)
 				break;
 			if (TIMEOUT) {
-				DPRINTK (PHASE_SELECTION,
-					 "scsi%d : NO CONNECT with target %d, stat = %x \n",
-					 hostno, target, STATUS);
+				DPRINTK (PHASE_SELECTION, "scsi%d : NO CONNECT with target %d, stat = %x \n", hostno, target, STATUS);
 				return retcode (DID_NO_CONNECT);
 			}
 		}
 
-/* Establish current pointers.  Take into account scatter / gather */
+		/* Establish current pointers.  Take into account scatter / gather */
 
 		if ((nobuffs = SCint->use_sg)) {
 #if (DEBUG & DEBUG_SG)
 			{
 				int i;
-
-				printk
-				    ("scsi%d : scatter gather requested, using %d buffers.\n",
-				     hostno, nobuffs);
+				printk("scsi%d : scatter gather requested, using %d buffers.\n", hostno, nobuffs);
 				for (i = 0; i < nobuffs; ++i)
-					printk
-					    ("scsi%d : buffer %d address = %p length = %d\n",
+					printk("scsi%d : buffer %d address = %p length = %d\n",
 					     hostno, i,
 					     page_address(buffer[i].page) + buffer[i].offset,
 					     buffer[i].length);
@@ -1069,11 +1011,9 @@
 
 			buffer = (struct scatterlist *) SCint->buffer;
 			len = buffer->length;
-			data = (unsigned char *) buffer->address;
+			data = page_address(buffer->page) + buffer->offset;
 		} else {
-			DPRINTK (DEBUG_SG,
-				 "scsi%d : scatter gather not requested.\n",
-				 hostno);
+			DPRINTK (DEBUG_SG, "scsi%d : scatter gather not requested.\n", hostno);
 			buffer = NULL;
 			len = SCint->request_bufflen;
 			data = (unsigned char *) SCint->request_buffer;
@@ -1091,38 +1031,34 @@
 #endif
 	}			/* end of switch(reselect) */
 
-/*
- *    There are several conditions under which we wish to send a message :
- *      1.  When we are allowing disconnect / reconnect, and need to establish
- *          the I_T_L nexus via an IDENTIFY with the DiscPriv bit set.
- *
- *      2.  When we are doing linked commands, are have the wrong I_T_L nexus
- *          established and want to send an ABORT message.
- */
+	/*
+	 *    There are several conditions under which we wish to send a message :
+	 *      1.  When we are allowing disconnect / reconnect, and need to
+	 *	establish the I_T_L nexus via an IDENTIFY with the DiscPriv bit
+	 *	set.
+	 *
+	 *      2.  When we are doing linked commands, are have the wrong I_T_L
+	 *	nexus established and want to send an ABORT message.
+	 */
 
-/* GCC does not like an ifdef inside a macro, so do it the hard way. */
+	/* GCC does not like an ifdef inside a macro, so do it the hard way. */
 #ifdef LINKED
-	WRITE_CONTROL (BASE_CMD | CMD_DRVR_ENABLE |
-		       (((reselect == CAN_RECONNECT)
-			 || (reselect == LINKED_WRONG)
-			)? CMD_ATTN : 0));
+	WRITE_CONTROL (BASE_CMD | CMD_DRVR_ENABLE | (((reselect == CAN_RECONNECT)|| (reselect == LINKED_WRONG))? CMD_ATTN : 0));
 #else
-	WRITE_CONTROL (BASE_CMD | CMD_DRVR_ENABLE |
-		       (((reselect == CAN_RECONNECT)
-			)? CMD_ATTN : 0));
+	WRITE_CONTROL (BASE_CMD | CMD_DRVR_ENABLE | (((reselect == CAN_RECONNECT))? CMD_ATTN : 0));
 #endif
 
-/*
- *    INFORMATION TRANSFER PHASE
- *
- *      The nasty looking read / write inline assembler loops we use for
- *      DATAIN and DATAOUT phases are approximately 4-5 times as fast as
- *      the 'C' versions - since we're moving 1024 bytes of data, this
- *      really adds up.
- *
- *      SJT: The nasty-looking assembler is gone, so it's slower.
- *
- */
+	/*
+	 *    INFORMATION TRANSFER PHASE
+	 *
+	 *      The nasty looking read / write inline assembler loops we use for
+	 *      DATAIN and DATAOUT phases are approximately 4-5 times as fast as
+	 *      the 'C' versions - since we're moving 1024 bytes of data, this
+	 *      really adds up.
+	 *
+	 *      SJT: The nasty-looking assembler is gone, so it's slower.
+	 *
+	 */
 
 	DPRINTK (PHASE_ETC, "scsi%d : phase = INFORMATION TRANSFER\n", hostno);
 
@@ -1130,72 +1066,63 @@
 	transfersize = SCint->transfersize;
 	underflow = SCint->underflow;
 
-/*
- *	Now, we poll the device for status information,
- *      and handle any requests it makes.  Note that since we are unsure of
- *      how much data will be flowing across the system, etc and cannot
- *      make reasonable timeouts, that we will instead have the midlevel
- *      driver handle any timeouts that occur in this phase.
- */
+	/*
+	 *	Now, we poll the device for status information,
+	 *      and handle any requests it makes.  Note that since we are unsure
+	 *	of how much data will be flowing across the system, etc and
+	 *	cannot make reasonable timeouts, that we will instead have the
+	 *	midlevel driver handle any timeouts that occur in this phase.
+	 */
 
 	while (((status_read = STATUS) & STAT_BSY) && !st0x_aborted && !done) {
 #ifdef PARITY
 		if (status_read & STAT_PARITY) {
-			printk ("scsi%d : got parity error\n", hostno);
+			printk(KERN_ERR "scsi%d : got parity error\n", hostno);
 			st0x_aborted = DID_PARITY;
 		}
 #endif
-
 		if (status_read & STAT_REQ) {
 #if ((DEBUG & PHASE_ETC) == PHASE_ETC)
 			if ((newphase = (status_read & REQ_MASK)) != phase) {
 				phase = newphase;
 				switch (phase) {
 				case REQ_DATAOUT:
-					printk ("scsi%d : phase = DATA OUT\n",
-						hostno);
+					printk ("scsi%d : phase = DATA OUT\n", hostno);
 					break;
 				case REQ_DATAIN:
-					printk ("scsi%d : phase = DATA IN\n",
-						hostno);
+					printk ("scsi%d : phase = DATA IN\n", hostno);
 					break;
 				case REQ_CMDOUT:
 					printk
-					    ("scsi%d : phase = COMMAND OUT\n",
-					     hostno);
+					    ("scsi%d : phase = COMMAND OUT\n", hostno);
 					break;
 				case REQ_STATIN:
-					printk ("scsi%d : phase = STATUS IN\n",
-						hostno);
+					printk ("scsi%d : phase = STATUS IN\n",	hostno);
 					break;
 				case REQ_MSGOUT:
 					printk
-					    ("scsi%d : phase = MESSAGE OUT\n",
-					     hostno);
+					    ("scsi%d : phase = MESSAGE OUT\n", hostno);
 					break;
 				case REQ_MSGIN:
-					printk ("scsi%d : phase = MESSAGE IN\n",
-						hostno);
+					printk ("scsi%d : phase = MESSAGE IN\n", hostno);
 					break;
 				default:
-					printk ("scsi%d : phase = UNKNOWN\n",
-						hostno);
+					printk ("scsi%d : phase = UNKNOWN\n", hostno);
 					st0x_aborted = DID_ERROR;
 				}
 			}
 #endif
 			switch (status_read & REQ_MASK) {
 			case REQ_DATAOUT:
-/*
- * If we are in fast mode, then we simply splat the data out
- * in word-sized chunks as fast as we can.
- */
+				/*
+				 * If we are in fast mode, then we simply splat
+				 * the data out in word-sized chunks as fast as
+				 * we can.
+				 */
 
 				if (!len) {
 #if 0
-					printk
-					    ("scsi%d: underflow to target %d lun %d \n",
-					     hostno, target, lun);
+					printk("scsi%d: underflow to target %d lun %d \n", hostno, target, lun);
 					st0x_aborted = DID_ERROR;
 					fast = 0;
 #endif
@@ -1216,7 +1143,7 @@
 						 SCint->transfersize, len,
 						 data);
 
-/* SJT: Start. Fast Write */
+			/* SJT: Start. Fast Write */
 #ifdef SEAGATE_USE_ASM
 					__asm__ ("cld\n\t"
 #ifdef FAST32
@@ -1241,14 +1168,11 @@
 #else				/* SEAGATE_USE_ASM */
 					{
 #ifdef FAST32
-						unsigned int *iop =
-						    phys_to_virt (st0x_dr);
-						const unsigned int *dp =
-						    (unsigned int *) data;
+						unsigned int *iop = phys_to_virt (st0x_dr);
+						const unsigned int *dp =(unsigned int *) data;
 						int xferlen = transfersize >> 2;
 #else
-						unsigned char *iop =
-						    phys_to_virt (st0x_dr);
+						unsigned char *iop = phys_to_virt (st0x_dr);
 						const unsigned char *dp = data;
 						int xferlen = transfersize;
 #endif
@@ -1259,14 +1183,13 @@
 /* SJT: End */
 					len -= transfersize;
 					data += transfersize;
-					DPRINTK (DEBUG_FAST,
-						 "scsi%d : FAST transfer complete len = %d data = %08x\n",
-						 hostno, len, data);
+					DPRINTK (DEBUG_FAST, "scsi%d : FAST transfer complete len = %d data = %08x\n", hostno, len, data);
 				} else {
-/*
- *    We loop as long as we are in a data out phase, there is data to send,
- *      and BSY is still active.
- */
+					/*
+					 *    We loop as long as we are in a 
+					 *    data out phase, there is data to
+					 *    send, and BSY is still active.
+					 */
 
 /* SJT: Start. Slow Write. */
 #ifdef SEAGATE_USE_ASM
@@ -1335,8 +1258,7 @@
 					--nobuffs;
 					++buffer;
 					len = buffer->length;
-					data =
-					    (unsigned char *) buffer->address;
+					data = page_address(buffer->page) + buffer->offset;
 					DPRINTK (DEBUG_SG,
 						 "scsi%d : next scatter-gather buffer len = %d address = %08x\n",
 						 hostno, len, data);
@@ -1349,13 +1271,9 @@
 #if (DEBUG & (PHASE_DATAIN))
 					transfered += len;
 #endif
-					for (;
-					     len
-					     && (STATUS & (REQ_MASK | STAT_REQ))
-					     == (REQ_DATAIN | STAT_REQ);
-					     --len) {
+					for (; len && (STATUS & (REQ_MASK | STAT_REQ)) == (REQ_DATAIN | STAT_REQ); --len) {
 						*data++ = DATA;
-						borken_wait ();
+						borken_wait();
 					}
 #if (DEBUG & (PHASE_DATAIN))
 					transfered -= len;
@@ -1421,19 +1339,15 @@
 					len -= transfersize;
 					data += transfersize;
 #if (DEBUG & PHASE_DATAIN)
-					printk ("scsi%d: transfered += %d\n",
-						hostno, transfersize);
+					printk ("scsi%d: transfered += %d\n", hostno, transfersize);
 					transfered += transfersize;
 #endif
 
-					DPRINTK (DEBUG_FAST,
-						 "scsi%d : FAST transfer complete len = %d data = %08x\n",
-						 hostno, len, data);
+					DPRINTK (DEBUG_FAST, "scsi%d : FAST transfer complete len = %d data = %08x\n", hostno, len, data);
 				} else {
 
 #if (DEBUG & PHASE_DATAIN)
-					printk ("scsi%d: transfered += %d\n",
-						hostno, len);
+					printk ("scsi%d: transfered += %d\n", hostno, len);
 					transfered += len;	/* Assume we'll transfer it all, then
 								   subtract what we *didn't* transfer */
 #endif
@@ -1508,8 +1422,7 @@
 #endif				/* SEAGATE_USE_ASM */
 /* SJT: End. */
 #if (DEBUG & PHASE_DATAIN)
-					printk ("scsi%d: transfered -= %d\n",
-						hostno, len);
+					printk ("scsi%d: transfered -= %d\n", hostno, len);
 					transfered -= len;	/* Since we assumed all of Len got  *
 								   transfered, correct our mistake */
 #endif
@@ -1519,26 +1432,17 @@
 					--nobuffs;
 					++buffer;
 					len = buffer->length;
-					data =
-					    (unsigned char *) buffer->address;
-					DPRINTK (DEBUG_SG,
-						 "scsi%d : next scatter-gather buffer len = %d address = %08x\n",
-						 hostno, len, data);
+					data = page_address(buffer->page) + buffer->offset;
+					DPRINTK (DEBUG_SG, "scsi%d : next scatter-gather buffer len = %d address = %08x\n", hostno, len, data);
 				}
-
 				break;
 
 			case REQ_CMDOUT:
 				while (((status_read = STATUS) & STAT_BSY) &&
 				       ((status_read & REQ_MASK) == REQ_CMDOUT))
 					if (status_read & STAT_REQ) {
-						WRITE_DATA (*
-							    (const unsigned char
-							     *) cmnd);
-						cmnd =
-						    1 +
-						    (const unsigned char *)
-						    cmnd;
+						WRITE_DATA (*(const unsigned char *) cmnd);
+						cmnd = 1 + (const unsigned char *)cmnd;
 #ifdef SLOW_RATE
 						if (borken)
 							borken_wait ();
@@ -1551,23 +1455,21 @@
 				break;
 
 			case REQ_MSGOUT:
-/*
- *	We can only have sent a MSG OUT if we requested to do this
- *      by raising ATTN.  So, we must drop ATTN.
- */
-
+				/*
+				 *	We can only have sent a MSG OUT if we
+				 *	requested to do this by raising ATTN.
+				 *	So, we must drop ATTN.
+				 */
 				WRITE_CONTROL (BASE_CMD | CMD_DRVR_ENABLE);
-/*
- *	If we are reconnecting, then we must send an IDENTIFY message in
- *      response  to MSGOUT.
- */
+				/*
+				 *	If we are reconnecting, then we must 
+				 *	send an IDENTIFY message in response
+				 *	to MSGOUT.
+				 */
 				switch (reselect) {
 				case CAN_RECONNECT:
 					WRITE_DATA (IDENTIFY (1, lun));
-
-					DPRINTK (PHASE_RESELECT | PHASE_MSGOUT,
-						 "scsi%d : sent IDENTIFY message.\n",
-						 hostno);
+					DPRINTK (PHASE_RESELECT | PHASE_MSGOUT, "scsi%d : sent IDENTIFY message.\n", hostno);
 					break;
 #ifdef LINKED
 				case LINKED_WRONG:
@@ -1575,23 +1477,19 @@
 					linked_connected = 0;
 					reselect = CAN_RECONNECT;
 					goto connect_loop;
-					DPRINTK (PHASE_MSGOUT | DEBUG_LINKED,
-						 "scsi%d : sent ABORT message to cancel incorrect I_T_L nexus.\n",
-						 hostno);
-#endif				/* LINKED */
+					DPRINTK (PHASE_MSGOUT | DEBUG_LINKED, "scsi%d : sent ABORT message to cancel incorrect I_T_L nexus.\n", hostno);
+#endif					/* LINKED */
 					DPRINTK (DEBUG_LINKED, "correct\n");
 				default:
 					WRITE_DATA (NOP);
-					printk
-					    ("scsi%d : target %d requested MSGOUT, sent NOP message.\n",
-					     hostno, target);
+					printk("scsi%d : target %d requested MSGOUT, sent NOP message.\n", hostno, target);
 				}
 				break;
 
 			case REQ_MSGIN:
 				switch (message = DATA) {
 				case DISCONNECT:
-					DANY ("seagate: deciding to disconnect\n");
+					DANY("seagate: deciding to disconnect\n");
 					should_reconnect = 1;
 					current_data = data;	/* WDE add */
 					current_buffer = buffer;
@@ -1601,9 +1499,7 @@
 					linked_connected = 0;
 #endif
 					done = 1;
-					DPRINTK ((PHASE_RESELECT | PHASE_MSGIN),
-						 "scsi%d : disconnected.\n",
-						 hostno);
+					DPRINTK ((PHASE_RESELECT | PHASE_MSGIN), "scsi%d : disconnected.\n", hostno);
 					break;
 
 #ifdef LINKED
@@ -1611,18 +1507,14 @@
 				case LINKED_FLG_CMD_COMPLETE:
 #endif
 				case COMMAND_COMPLETE:
-/*
- * Note : we should check for underflow here.
- */
-					DPRINTK (PHASE_MSGIN,
-						 "scsi%d : command complete.\n",
-						 hostno);
+					/*
+					 * Note : we should check for underflow here.
+					 */
+					DPRINTK(PHASE_MSGIN, "scsi%d : command complete.\n", hostno);
 					done = 1;
 					break;
 				case ABORT:
-					DPRINTK (PHASE_MSGIN,
-						 "scsi%d : abort message.\n",
-						 hostno);
+					DPRINTK(PHASE_MSGIN, "scsi%d : abort message.\n", hostno);
 					done = 1;
 					break;
 				case SAVE_POINTERS:
@@ -1630,9 +1522,7 @@
 					current_bufflen = len;	/* WDE add */
 					current_data = data;	/* WDE mod */
 					current_nobuffs = nobuffs;
-					DPRINTK (PHASE_MSGIN,
-						 "scsi%d : pointers saved.\n",
-						 hostno);
+					DPRINTK (PHASE_MSGIN, "scsi%d : pointers saved.\n", hostno);
 					break;
 				case RESTORE_POINTERS:
 					buffer = current_buffer;
@@ -1640,91 +1530,87 @@
 					data = current_data;	/* WDE mod */
 					len = current_bufflen;
 					nobuffs = current_nobuffs;
-					DPRINTK (PHASE_MSGIN,
-						 "scsi%d : pointers restored.\n",
-						 hostno);
+					DPRINTK(PHASE_MSGIN, "scsi%d : pointers restored.\n", hostno);
 					break;
 				default:
 
-/*
- *	IDENTIFY distinguishes itself from the other messages by setting the
- *      high byte. [FIXME: should not this read "the high bit"? - pavel@ucw.cz]
- *
- *      Note : we need to handle at least one outstanding command per LUN,
- *      and need to hash the SCSI command for that I_T_L nexus based on the
- *      known ID (at this point) and LUN.
- */
+					/*
+					 *	IDENTIFY distinguishes itself
+					 *	from the other messages by 
+					 *	setting the high bit.
+					 *
+					 *      Note : we need to handle at 
+					 *	least one outstanding command
+					 *	per LUN, and need to hash the 
+					 *	SCSI command for that I_T_L
+					 *	nexus based on the known ID 
+					 *	(at this point) and LUN.
+					 */
 
 					if (message & 0x80) {
-						DPRINTK (PHASE_MSGIN,
-							 "scsi%d : IDENTIFY message received from id %d, lun %d.\n",
-							 hostno, target,
-							 message & 7);
+						DPRINTK (PHASE_MSGIN, "scsi%d : IDENTIFY message received from id %d, lun %d.\n", hostno, target, message & 7);
 					} else {
-
-/*
- *      We should go into a MESSAGE OUT phase, and send  a MESSAGE_REJECT
- *      if we run into a message that we don't like.  The seagate driver
- *      needs some serious restructuring first though.
- */
-
-						DPRINTK (PHASE_MSGIN,
-							 "scsi%d : unknown message %d from target %d.\n",
-							 hostno, message,
-							 target);
+						/*
+						 *      We should go into a
+						 *	MESSAGE OUT phase, and
+						 *	send  a MESSAGE_REJECT
+						 *      if we run into a message 
+						 *	that we don't like.  The
+						 *	seagate driver needs 
+						 *	some serious 
+						 *	restructuring first
+						 *	though.
+						 */
+						DPRINTK (PHASE_MSGIN, "scsi%d : unknown message %d from target %d.\n", hostno, message, target);
 					}
 				}
 				break;
-
 			default:
-				printk ("scsi%d : unknown phase.\n", hostno);
+				printk(KERN_ERR "scsi%d : unknown phase.\n", hostno);
 				st0x_aborted = DID_ERROR;
-			}	/* end of switch (status_read &
-				   REQ_MASK) */
-
+			}	/* end of switch (status_read &  REQ_MASK) */
 #ifdef SLOW_RATE
-/*
- * I really don't care to deal with borken devices in each single
- * byte transfer case (ie, message in, message out, status), so
- * I'll do the wait here if necessary.
- */
-			if (borken)
-				borken_wait ();
+			/*
+			 * I really don't care to deal with borken devices in
+			 * each single byte transfer case (ie, message in,
+			 * message out, status), so I'll do the wait here if 
+			 * necessary.
+			 */
+			if(borken)
+				borken_wait();
 #endif
 
 		}		/* if(status_read & STAT_REQ) ends */
-	}			/* while(((status_read = STATUS)...)
-				   ends */
+	}			/* while(((status_read = STATUS)...) ends */
 
-	DPRINTK (PHASE_DATAIN | PHASE_DATAOUT | PHASE_EXIT,
-		 "scsi%d : Transfered %d bytes\n", hostno, transfered);
+	DPRINTK(PHASE_DATAIN | PHASE_DATAOUT | PHASE_EXIT, "scsi%d : Transfered %d bytes\n", hostno, transfered);
 
 #if (DEBUG & PHASE_EXIT)
 #if 0				/* Doesn't work for scatter/gather */
-	printk ("Buffer : \n");
-	for (i = 0; i < 20; ++i)
-		printk ("%02x  ", ((unsigned char *) data)[i]);	/* WDE mod */
-	printk ("\n");
+	printk("Buffer : \n");
+	for(i = 0; i < 20; ++i)
+		printk("%02x  ", ((unsigned char *) data)[i]);	/* WDE mod */
+	printk("\n");
 #endif
-	printk ("scsi%d : status = ", hostno);
-	print_status (status);
-	printk (" message = %02x\n", message);
+	printk("scsi%d : status = ", hostno);
+	print_status(status);
+	printk(" message = %02x\n", message);
 #endif
 
-/* We shouldn't reach this until *after* BSY has been deasserted */
+	/* We shouldn't reach this until *after* BSY has been deasserted */
 
 #ifdef LINKED
 	else
 	{
-/*
- * Fix the message byte so that unsuspecting high level drivers don't
- * puke when they see a LINKED COMMAND message in place of the COMMAND
- * COMPLETE they may be expecting.  Shouldn't be necessary, but it's
- * better to be on the safe side.
- *
- * A non LINKED* message byte will indicate that the command completed,
- * and we are now disconnected.
- */
+		/*
+		 * Fix the message byte so that unsuspecting high level drivers
+		 * don't puke when they see a LINKED COMMAND message in place of
+		 * the COMMAND COMPLETE they may be expecting.  Shouldn't be
+		 * necessary, but it's better to be on the safe side.
+		 *
+		 * A non LINKED* message byte will indicate that the command
+		 * completed, and we are now disconnected.
+		 */
 
 		switch (message) {
 		case LINKED_CMD_COMPLETE:
@@ -1733,33 +1619,27 @@
 			linked_target = current_target;
 			linked_lun = current_lun;
 			linked_connected = 1;
-			DPRINTK (DEBUG_LINKED,
-				 "scsi%d : keeping I_T_L nexus established"
-				 "for linked command.\n", hostno);
+			DPRINTK (DEBUG_LINKED, "scsi%d : keeping I_T_L nexus established for linked command.\n", hostno);
 			/* We also will need to adjust status to accommodate intermediate
 			   conditions. */
-			if ((status == INTERMEDIATE_GOOD) ||
-			    (status == INTERMEDIATE_C_GOOD))
+			if ((status == INTERMEDIATE_GOOD) || (status == INTERMEDIATE_C_GOOD))
 				status = GOOD;
-
 			break;
-/*
- * We should also handle what are "normal" termination messages
- * here (ABORT, BUS_DEVICE_RESET?, and COMMAND_COMPLETE individually,
- * and flake if things aren't right.
- */
+			/*
+			 * We should also handle what are "normal" termination
+			 * messages here (ABORT, BUS_DEVICE_RESET?, and
+			 * COMMAND_COMPLETE individually, and flake if things
+			 * aren't right.
+			 */
 		default:
-			DPRINTK (DEBUG_LINKED,
-				 "scsi%d : closing I_T_L nexus.\n", hostno);
+			DPRINTK (DEBUG_LINKED, "scsi%d : closing I_T_L nexus.\n", hostno);
 			linked_connected = 0;
 		}
 	}
-#endif				/* LINKED */
+#endif	/* LINKED */
 
 	if (should_reconnect) {
-		DPRINTK (PHASE_RESELECT,
-			 "scsi%d : exiting seagate_st0x_queue_command()"
-			 "with reconnect enabled.\n", hostno);
+		DPRINTK (PHASE_RESELECT, "scsi%d : exiting seagate_st0x_queue_command() with reconnect enabled.\n", hostno);
 		WRITE_CONTROL (BASE_CMD | CMD_INTR);
 	} else
 		WRITE_CONTROL (BASE_CMD);
@@ -1770,7 +1650,7 @@
 static int seagate_st0x_abort (Scsi_Cmnd * SCpnt)
 {
 	st0x_aborted = DID_ABORT;
-	return SCSI_ABORT_PENDING;
+	return SUCCESS;
 }
 
 #undef ULOOP
@@ -1778,14 +1658,16 @@
 
 /*
  * the seagate_st0x_reset function resets the SCSI bus 
+ *
+ * May be called with SCpnt = NULL
  */
 
-static int seagate_st0x_reset (Scsi_Cmnd * SCpnt, unsigned int reset_flags)
+static int seagate_st0x_bus_reset(Scsi_Cmnd * SCpnt)
 {
-/* No timeouts - this command is going to fail because it was reset. */
+	/* No timeouts - this command is going to fail because it was reset. */
 	DANY ("scsi%d: Reseting bus... ", hostno);
 
-/* assert  RESET signal on SCSI bus.  */
+	/* assert  RESET signal on SCSI bus.  */
 	WRITE_CONTROL (BASE_CMD | CMD_RST);
 
 	udelay (20 * 1000);
@@ -1794,7 +1676,17 @@
 	st0x_aborted = DID_RESET;
 
 	DANY ("done.\n");
-	return SCSI_RESET_WAKEUP;
+	return SUCCESS;
+}
+
+static int seagate_st0x_host_reset(Scsi_Cmnd *SCpnt)
+{
+	return FAILED;
+}
+
+static int seagate_st0x_device_reset(Scsi_Cmnd *SCpnt)
+{
+	return FAILED;
 }
 
 /* Eventually this will go into an include file, but this will be later */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/seagate.h linux.2.5.41-ac1/drivers/scsi/seagate.h
--- linux.2.5.41/drivers/scsi/seagate.h	2002-07-20 20:11:11.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/seagate.h	2002-10-07 14:21:58.000000000 +0100
@@ -7,30 +7,30 @@
  */
 
 #ifndef _SEAGATE_H
-	#define SEAGATE_H
-/*
-	$Header
-*/
-#ifndef ASM
-int seagate_st0x_detect(Scsi_Host_Template *);
-int seagate_st0x_command(Scsi_Cmnd *);
-int seagate_st0x_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+#define SEAGATE_H
+
+static int seagate_st0x_detect(Scsi_Host_Template *);
+static int seagate_st0x_command(Scsi_Cmnd *);
+static int seagate_st0x_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 
 static int seagate_st0x_abort(Scsi_Cmnd *);
-const char *seagate_st0x_info(struct Scsi_Host *);
-static int seagate_st0x_reset(Scsi_Cmnd *, unsigned int); 
+static const char *seagate_st0x_info(struct Scsi_Host *);
+static int seagate_st0x_bus_reset(Scsi_Cmnd *);
+static int seagate_st0x_device_reset(Scsi_Cmnd *);
+static int seagate_st0x_host_reset(Scsi_Cmnd *);
 
-#define SEAGATE_ST0X  {  detect:         seagate_st0x_detect,		\
-			 info:           seagate_st0x_info,		\
-			 command:        seagate_st0x_command,		\
-			 queuecommand:   seagate_st0x_queue_command,	\
-			 abort:          seagate_st0x_abort,		\
-			 reset:          seagate_st0x_reset,		\
-			 can_queue:      1,				\
-			 this_id:        7,				\
-			 sg_tablesize:   SG_ALL,			\
-			 cmd_per_lun:    1,				\
+#define SEAGATE_ST0X  {  detect:         seagate_st0x_detect,			\
+			 info:           seagate_st0x_info,			\
+			 command:        seagate_st0x_command,			\
+			 queuecommand:   seagate_st0x_queue_command,		\
+			 eh_abort_handler:	seagate_st0x_abort,		\
+			 eh_bus_reset_handler:  seagate_st0x_bus_reset,		\
+			 eh_host_reset_handler: seagate_st0x_host_reset,	\
+			 eh_device_reset_handler:seagate_st0x_device_reset,	\
+			 can_queue:      1,					\
+			 this_id:        7,					\
+			 sg_tablesize:   SG_ALL,				\
+			 cmd_per_lun:    1,					\
 			 use_clustering: DISABLE_CLUSTERING}
-#endif /* ASM */
 
 #endif /* _SEAGATE_H */
