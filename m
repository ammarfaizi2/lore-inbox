Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbULSVrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbULSVrM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 16:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbULSVrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 16:47:12 -0500
Received: from imap3.nextra.sk ([195.168.1.92]:59657 "EHLO tic.nextra.sk")
	by vger.kernel.org with ESMTP id S261339AbULSVol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 16:44:41 -0500
Message-ID: <41C5F681.9090403@rainbow-software.org>
Date: Sun, 19 Dec 2004 22:45:37 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tic-80059-1103492678-0001-2"
To: Christoph Hellwig <hch@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] cdu31a - more fixes
References: <41C4BD54.2060703@rainbow-software.org> <20041219133607.GA599@infradead.org>
In-Reply-To: <20041219133607.GA599@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tic-80059-1103492678-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:
>>+#define RETURN_UP(retval) do {up(&sony_sem); return (retval);} while(0)
> 
> 
> Please don't use such obsfucation macros.  Instead use gotos in the
> functions to haev a single exit path that releases the lock.

OK, here's next version of the patch, now without that macro. It also 
adds set_capacity() call so dd can now be used to create CD image. I've 
also found and fixed some other problems (like the handle_abort_timeout 
that I broke in the previous patch).

-- 
Ondrej Zary

--=_tic-80059-1103492678-0001-2
Content-Type: text/plain; name="cdu31a-locking-dd.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdu31a-locking-dd.patch"

--- linux-2.6.10-rc3/drivers/cdrom/cdu31a.c	2004-12-03 22:54:16.000000000 +0100
+++ linux/drivers/cdrom/cdu31a.c	2004-12-19 22:38:02.000000000 +0100
@@ -146,6 +146,10 @@
  *		      Set double-speed drives to double speed by default
  *		      Removed all readahead things - not needed anymore
  *			Ondrej Zary <rainbow@rainbow-software.org>
+ * 17 December 2004 -- converted MODULE_PARM to module_param, added PARM_DESC
+ *		       modified locking to use sony_sem semaphore
+ *		       de-uglyfied the code a bit
+ *		       add set_capacity() call so dd can be used
 */
 
 #include <linux/major.h>
@@ -180,7 +184,7 @@
 
 #define CDU31A_MAX_CONSECUTIVE_ATTENTIONS 10
 
-#define DEBUG 1
+#define DEBUG 0
 
 /* Define the following if you have data corruption problems. */
 #undef SONY_POLL_EACH_BYTE
@@ -202,8 +206,7 @@
 static int read_subcode(void);
 static void sony_get_toc(void);
 static int scd_spinup(void);
-/*static int scd_open(struct inode *inode, struct file *filp);*/
-static int scd_open(struct cdrom_device_info *, int);
+static int scd_open(struct cdrom_device_info *, int purpose);
 static void do_sony_cd_cmd(unsigned char cmd,
 			   unsigned char *params,
 			   unsigned int num_params,
@@ -217,10 +220,15 @@
 						   in the current read command. */
 
 
-/* The base I/O address of the Sony Interface.  This is a variable (not a
-   #define) so it can be easily changed via some future ioctl() */
+/* The base I/O address of the Sony Interface. */
 static unsigned int cdu31a_port = 0;
-module_param(cdu31a_port, uint, 0);
+module_param(cdu31a_port, int, 0444);
+MODULE_PARM_DESC(cdu31a_port, "base I/O address of the Sony Interface");
+
+/* IRQ of the Sony Interface.  0 if none. */
+static int cdu31a_irq = 0;
+module_param(cdu31a_irq, int, 0444);
+MODULE_PARM_DESC(cdu31a_irq, "IRQ of the Sony Interface, 0 if none");
 
 /*
  * The following are I/O addresses of the various registers for the drive.  The
@@ -238,6 +246,8 @@
 static struct request_queue *cdu31a_queue;
 static spinlock_t cdu31a_lock = SPIN_LOCK_UNLOCKED; /* queue lock */
 
+static struct gendisk *scd_gendisk;
+
 static int sony_spun_up = 0;	/* Has the drive been spun up? */
 
 static int sony_speed = 0;	/* Last wanted speed */
@@ -267,18 +277,11 @@
 static struct s_sony_subcode last_sony_subcode;	/* Points to the last
 						   subcode address read */
 
-static volatile int sony_inuse = 0;	/* Is the drive in use?  Only one operation
-					   at a time allowed */
+static DECLARE_MUTEX(sony_sem);	/* Semaphore for drive hardware access */
 
-static DECLARE_WAIT_QUEUE_HEAD(sony_wait);	/* Things waiting for the drive */
+static int is_double_speed = 0;	/* Does the drive support double speed ? */
 
-static struct task_struct *has_cd_task = NULL;	/* The task that is currently
-						   using the CDROM drive, or
-						   NULL if none. */
-
-static int is_double_speed = 0;	/* does the drive support double speed ? */
-
-static int is_auto_eject = 1;	/* Door has been locked? 1=No/0=Yes */
+static int door_locked = 0;	/* Door has been locked? */
 
 /*
  * The audio status uses the values from read subchannel data as specified
@@ -296,10 +299,6 @@
 static unsigned volatile char cur_pos_msf[3] = { 0, 0, 0 };
 static unsigned volatile char final_pos_msf[3] = { 0, 0, 0 };
 
-/* What IRQ is the drive using?  0 if none. */
-static int cdu31a_irq = 0;
-module_param(cdu31a_irq, int, 0);
-
 /* The interrupt handler will wake this queue up when it gets an
    interrupts. */
 DECLARE_WAIT_QUEUE_HEAD(cdu31a_irq_wait);
@@ -344,13 +343,16 @@
  */
 static int scd_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 {
-	if (CDSL_CURRENT != slot_nr) {
-		/* we have no changer support */
-		return -EINVAL;
-	}
-	if (scd_spinup() == 0) {
+	if (CDSL_CURRENT != slot_nr)
+		return -EINVAL;		/* we have no changer support */
+
+	if (sony_spun_up)
+		return CDS_DISC_OK;
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
+	if (scd_spinup() == 0)
 		sony_spun_up = 1;
-	}
+	up(&sony_sem);
 	return sony_spun_up ? CDS_DISC_OK : CDS_DRIVE_NOT_READY;
 }
 
@@ -445,13 +447,15 @@
 {
 	unsigned long retry_count;
 
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	reset_drive();
 
 	retry_count = jiffies + SONY_RESET_TIMEOUT;
 	while (time_before(jiffies, retry_count) && (!is_attention())) {
 		sony_sleep();
 	}
-
+	up(&sony_sem);
 	return 0;
 }
 
@@ -617,7 +621,7 @@
 	params[0] = SONY_SD_MECH_CONTROL;
 	params[1] = SONY_AUTO_SPIN_UP_BIT;	/* Set auto spin up */
 
-	if (is_auto_eject)
+	if (!door_locked)
 		params[1] |= SONY_AUTO_EJECT_BIT;
 
 	if (is_double_speed && want_doublespeed) {
@@ -642,8 +646,10 @@
 		sony_speed = 1;
 	else
 		sony_speed = speed - 1;
-
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	set_drive_params(sony_speed);
+	up(&sony_sem);
 	return 0;
 }
 
@@ -653,12 +659,11 @@
  */
 static int scd_lock_door(struct cdrom_device_info *cdi, int lock)
 {
-	if (lock == 0) {
-		is_auto_eject = 1;
-	} else {
-		is_auto_eject = 0;
-	}
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
+	door_locked = lock;
 	set_drive_params(sony_speed);
+	up(&sony_sem);
 	return 0;
 }
 
@@ -672,7 +677,7 @@
 	unsigned long retry_count;
 
 
-	printk("cdu31a: Resetting drive on error\n");
+	printk("CDU31A: Resetting drive on error\n");
 	reset_drive();
 	retry_count = jiffies + SONY_RESET_TIMEOUT;
 	while (time_before(jiffies, retry_count) && (!is_attention())) {
@@ -681,7 +686,7 @@
 	set_drive_params(sony_speed);
 	do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg, &res_size);
 	if ((res_size < 2) || ((res_reg[0] & 0xf0) == 0x20)) {
-		printk("cdu31a: Unable to spin up drive: 0x%2.2x\n",
+		printk("CDU31A: Unable to spin up drive: 0x%2.2x\n",
 		       res_reg[1]);
 	}
 
@@ -858,37 +863,12 @@
 {
 	unsigned long retry_count;
 	int num_retries;
-	int recursive_call;
-	unsigned long flags;
-
-
-	save_flags(flags);
-	cli();
-	if (current != has_cd_task) {	/* Allow recursive calls to this routine */
-		while (sony_inuse) {
-			interruptible_sleep_on(&sony_wait);
-			if (signal_pending(current)) {
-				result_buffer[0] = 0x20;
-				result_buffer[1] = SONY_SIGNAL_OP_ERR;
-				*result_size = 2;
-				restore_flags(flags);
-				return;
-			}
-		}
-		sony_inuse = 1;
-		has_cd_task = current;
-		recursive_call = 0;
-	} else {
-		recursive_call = 1;
-	}
 
 	num_retries = 0;
 retry_cd_operation:
 
 	while (handle_sony_cd_attention());
 
-	sti();
-
 	retry_count = jiffies + SONY_JIFFIES_TIMEOUT;
 	while (time_before(jiffies, retry_count) && (is_busy())) {
 		sony_sleep();
@@ -918,14 +898,6 @@
 		msleep(100);
 		goto retry_cd_operation;
 	}
-
-	if (!recursive_call) {
-		has_cd_task = NULL;
-		sony_inuse = 0;
-		wake_up_interruptible(&sony_wait);
-	}
-
-	restore_flags(flags);
 }
 
 
@@ -952,7 +924,7 @@
 		if (num_consecutive_attentions >
 		    CDU31A_MAX_CONSECUTIVE_ATTENTIONS) {
 			printk
-			    ("cdu31a: Too many consecutive attentions: %d\n",
+			    ("CDU31A: Too many consecutive attentions: %d\n",
 			     num_consecutive_attentions);
 			num_consecutive_attentions = 0;
 #if DEBUG
@@ -985,7 +957,7 @@
 			break;
 
 		case SONY_EJECT_PUSHED_ATTN:
-			if (is_auto_eject) {
+			if (!door_locked) {
 				sony_audio_status = CDROM_AUDIO_INVALID;
 			}
 			break;
@@ -1038,7 +1010,7 @@
 
 	retval = (val / 10) << 4;
 	retval = retval | val % 10;
-	return (retval);
+	return retval;
 }
 
 
@@ -1181,15 +1153,11 @@
    pending read operation. */
 static void handle_abort_timeout(unsigned long data)
 {
-	unsigned long flags;
-
 #if DEBUG
 	printk("Entering handle_abort_timeout\n");
 #endif
-	save_flags(flags);
-	cli();
 	/* If it is in use, ignore it. */
-	if (!sony_inuse) {
+	if (down_trylock(&sony_sem) == 0) {
 		/* We can't use abort_read(), because it will sleep
 		   or schedule in the timer interrupt.  Just start
 		   the operation, finish it on the next access to
@@ -1200,8 +1168,9 @@
 
 		sony_blocks_left = 0;
 		abort_read_started = 1;
+		up(&sony_sem);
 	}
-	restore_flags(flags);
+	
 #if DEBUG
 	printk("Leaving handle_abort_timeout\n");
 #endif
@@ -1348,10 +1317,7 @@
 
 /*
  * The OS calls this to perform a read or write operation to the drive.
- * Write obviously fail.  Reads to a read ahead of sony_buffer_size
- * bytes to help speed operations.  This especially helps since the OS
- * uses 1024 byte blocks and the drive uses 2048 byte blocks.  Since most
- * data access on a CD is done sequentially, this saves a lot of operations.
+ * Write obviously fail.
  */
 static void do_cdu31a_request(request_queue_t * q)
 {
@@ -1359,32 +1325,16 @@
 	int block, nblock, num_retries;
 	unsigned char res_reg[12];
 	unsigned int res_size;
-	unsigned long flags;
 
 
+	spin_unlock_irq(q->queue_lock);
 #if DEBUG
 	printk("Entering do_cdu31a_request\n");
 #endif
-
-	/* 
-	 * Make sure no one else is using the driver; wait for them
-	 * to finish if it is so.
-	 */
-	save_flags(flags);
-	cli();
-	while (sony_inuse) {
-		interruptible_sleep_on(&sony_wait);
-		if (signal_pending(current)) {
-			restore_flags(flags);
-#if DEBUG
-			printk("Leaving do_cdu31a_request at %d\n",
-			       __LINE__);
-#endif
-			return;
-		}
+	if (down_interruptible(&sony_sem)) {
+		spin_lock_irq(q->queue_lock);
+		return;
 	}
-	sony_inuse = 1;
-	has_cd_task = current;
 
 	/* Get drive status before doing anything. */
 	while (handle_sony_cd_attention());
@@ -1392,11 +1342,6 @@
 	/* Make sure we have a valid TOC. */
 	sony_get_toc();
 
-	/*
-	 * jens: driver has lots of races
-	 */
-	spin_unlock_irq(q->queue_lock);
-
 	/* Make sure the timer is cancelled. */
 	del_timer(&cdu31a_abort_timer);
 
@@ -1437,7 +1382,7 @@
 		 * If the block address is invalid or the request goes beyond the end of
 		 * the media, return an error.
 		 */
-		if (((block + nblock) / 4) >= sony_toc.lead_out_start_lba) {
+		if (((block + nblock) / 4) > sony_toc.lead_out_start_lba) {
 			printk("CDU31A: Request past end of media\n");
 			end_request(req, 0);
 			continue;
@@ -1513,7 +1458,6 @@
 		goto try_read_again;
 	}
       end_do_cdu31a_request:
-	spin_lock_irq(q->queue_lock);
 #if 0
 	/* After finished, cancel any pending operations. */
 	abort_read();
@@ -1523,11 +1467,8 @@
 	cdu31a_abort_timer.expires = jiffies + 2 * HZ;	/* Wait 2 seconds */
 	add_timer(&cdu31a_abort_timer);
 #endif
-
-	has_cd_task = NULL;
-	sony_inuse = 0;
-	wake_up_interruptible(&sony_wait);
-	restore_flags(flags);
+	up(&sony_sem);
+	spin_lock_irq(q->queue_lock);
 #if DEBUG
 	printk("Leaving do_cdu31a_request at %d\n", __LINE__);
 #endif
@@ -1549,461 +1490,292 @@
 	int mint = 99;
 	int maxt = 0;
 
+	if (sony_toc_read)
+		return;
 #if DEBUG
 	printk("Entering sony_get_toc\n");
 #endif
 
 	num_spin_ups = 0;
-	if (!sony_toc_read) {
-	      respinup_on_gettoc:
-		/* Ignore the result, since it might error if spinning already. */
-		do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
-			       &res_size);
 
-		do_sony_cd_cmd(SONY_READ_TOC_CMD, NULL, 0, res_reg,
-			       &res_size);
+      respinup_on_gettoc:
+	/* Ignore the result, since it might error if spinning already. */
+	do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
+		       &res_size);
 
-		/* The drive sometimes returns error 0.  I don't know why, but ignore
-		   it.  It seems to mean the drive has already done the operation. */
-		if ((res_size < 2)
-		    || ((res_reg[0] != 0) && (res_reg[1] != 0))) {
-			/* If the drive is already playing, it's ok.  */
-			if ((res_reg[1] == SONY_AUDIO_PLAYING_ERR)
-			    || (res_reg[1] == 0)) {
-				goto gettoc_drive_spinning;
-			}
-
-			/* If the drive says it is not spun up (even though we just did it!)
-			   then retry the operation at least a few times. */
-			if ((res_reg[1] == SONY_NOT_SPIN_ERR)
-			    && (num_spin_ups < MAX_CDU31A_RETRIES)) {
-				num_spin_ups++;
-				goto respinup_on_gettoc;
-			}
+	do_sony_cd_cmd(SONY_READ_TOC_CMD, NULL, 0, res_reg,
+		       &res_size);
 
-			printk("cdu31a: Error reading TOC: %x %s\n",
-			       res_reg[0], translate_error(res_reg[1]));
-			return;
+	/* The drive sometimes returns error 0.  I don't know why, but ignore
+	   it.  It seems to mean the drive has already done the operation. */
+	if ((res_size < 2)
+	    || ((res_reg[0] != 0) && (res_reg[1] != 0))) {
+		/* If the drive is already playing, it's ok.  */
+		if ((res_reg[1] == SONY_AUDIO_PLAYING_ERR)
+		    || (res_reg[1] == 0)) {
+			goto gettoc_drive_spinning;
+		}
+
+		/* If the drive says it is not spun up (even though we just did it!)
+		   then retry the operation at least a few times. */
+		if ((res_reg[1] == SONY_NOT_SPIN_ERR)
+		    && (num_spin_ups < MAX_CDU31A_RETRIES)) {
+			num_spin_ups++;
+			goto respinup_on_gettoc;
 		}
 
-	      gettoc_drive_spinning:
+		printk("CDU31A: Error reading TOC: %x %s\n",
+		       res_reg[0], translate_error(res_reg[1]));
+		return;
+	}
 
-		/* The idea here is we keep asking for sessions until the command
-		   fails.  Then we know what the last valid session on the disk is.
-		   No need to check session 0, since session 0 is the same as session
-		   1; the command returns different information if you give it 0. 
-		 */
+      gettoc_drive_spinning:
+
+	/* The idea here is we keep asking for sessions until the command
+	   fails.  Then we know what the last valid session on the disk is.
+	   No need to check session 0, since session 0 is the same as session
+	   1; the command returns different information if you give it 0. 
+	 */
 #if DEBUG
-		memset(&sony_toc, 0x0e, sizeof(sony_toc));
-		memset(&single_toc, 0x0f, sizeof(single_toc));
+	memset(&sony_toc, 0x0e, sizeof(sony_toc));
+	memset(&single_toc, 0x0f, sizeof(single_toc));
 #endif
-		session = 1;
-		while (1) {
+	session = 1;
+	while (1) {
 /* This seems to slow things down enough to make it work.  This
  * appears to be a problem in do_sony_cd_cmd.  This printk seems 
  * to address the symptoms...  -Erik */
 #if DEBUG
-			printk("cdu31a: Trying session %d\n", session);
+		printk("CDU31A: Trying session %d\n", session);
 #endif
-			parms[0] = session;
-			do_sony_cd_cmd(SONY_READ_TOC_SPEC_CMD,
-				       parms, 1, res_reg, &res_size);
+		parms[0] = session;
+		do_sony_cd_cmd(SONY_READ_TOC_SPEC_CMD,
+			       parms, 1, res_reg, &res_size);
 
 #if DEBUG
-			printk("%2.2x %2.2x\n", res_reg[0], res_reg[1]);
+		printk("%2.2x %2.2x\n", res_reg[0], res_reg[1]);
 #endif
 
-			if ((res_size < 2)
-			    || ((res_reg[0] & 0xf0) == 0x20)) {
-				/* An error reading the TOC, this must be past the last session. */
-				if (session == 1)
-					printk
-					    ("Yikes! Couldn't read any sessions!");
-				break;
-			}
+		if ((res_size < 2)
+		    || ((res_reg[0] & 0xf0) == 0x20)) {
+			/* An error reading the TOC, this must be past the last session. */
+			if (session == 1)
+				printk
+				    ("Yikes! Couldn't read any sessions!");
+			break;
+		}
 #if DEBUG
-			printk("Reading session %d\n", session);
+		printk("Reading session %d\n", session);
 #endif
 
-			parms[0] = session;
-			do_sony_cd_cmd(SONY_REQ_TOC_DATA_SPEC_CMD,
-				       parms,
-				       1,
-				       (unsigned char *) &single_toc,
-				       &res_size);
-			if ((res_size < 2)
-			    || ((single_toc.exec_status[0] & 0xf0) ==
-				0x20)) {
-				printk
-				    ("cdu31a: Error reading session %d: %x %s\n",
-				     session, single_toc.exec_status[0],
-				     translate_error(single_toc.
-						     exec_status[1]));
-				/* An error reading the TOC.  Return without sony_toc_read
-				   set. */
-				return;
-			}
-#if DEBUG
-			printk
-			    ("add0 %01x, con0 %01x, poi0 %02x, 1st trk %d, dsktyp %x, dum0 %x\n",
-			     single_toc.address0, single_toc.control0,
-			     single_toc.point0,
-			     bcd_to_int(single_toc.first_track_num),
-			     single_toc.disk_type, single_toc.dummy0);
-			printk
-			    ("add1 %01x, con1 %01x, poi1 %02x, lst trk %d, dummy1 %x, dum2 %x\n",
-			     single_toc.address1, single_toc.control1,
-			     single_toc.point1,
-			     bcd_to_int(single_toc.last_track_num),
-			     single_toc.dummy1, single_toc.dummy2);
+		parms[0] = session;
+		do_sony_cd_cmd(SONY_REQ_TOC_DATA_SPEC_CMD,
+			       parms,
+			       1,
+			       (unsigned char *) &single_toc,
+			       &res_size);
+		if ((res_size < 2)
+		    || ((single_toc.exec_status[0] & 0xf0) ==
+			0x20)) {
 			printk
-			    ("add2 %01x, con2 %01x, poi2 %02x leadout start min %d, sec %d, frame %d\n",
-			     single_toc.address2, single_toc.control2,
-			     single_toc.point2,
-			     bcd_to_int(single_toc.lead_out_start_msf[0]),
-			     bcd_to_int(single_toc.lead_out_start_msf[1]),
-			     bcd_to_int(single_toc.lead_out_start_msf[2]));
-			if (res_size > 18 && single_toc.pointb0 > 0xaf)
-				printk
-				    ("addb0 %01x, conb0 %01x, poib0 %02x, nextsession min %d, sec %d, frame %d\n"
-				     "#mode5_ptrs %02d, max_start_outer_leadout_msf min %d, sec %d, frame %d\n",
-				     single_toc.addressb0,
-				     single_toc.controlb0,
-				     single_toc.pointb0,
-				     bcd_to_int(single_toc.
-						next_poss_prog_area_msf
-						[0]),
-				     bcd_to_int(single_toc.
-						next_poss_prog_area_msf
-						[1]),
-				     bcd_to_int(single_toc.
-						next_poss_prog_area_msf
-						[2]),
-				     single_toc.num_mode_5_pointers,
-				     bcd_to_int(single_toc.
-						max_start_outer_leadout_msf
-						[0]),
-				     bcd_to_int(single_toc.
-						max_start_outer_leadout_msf
-						[1]),
-				     bcd_to_int(single_toc.
-						max_start_outer_leadout_msf
-						[2]));
-			if (res_size > 27 && single_toc.pointb1 > 0xaf)
-				printk
-				    ("addb1 %01x, conb1 %01x, poib1 %02x, %x %x %x %x #skipint_ptrs %d, #skiptrkassign %d %x\n",
-				     single_toc.addressb1,
-				     single_toc.controlb1,
-				     single_toc.pointb1,
-				     single_toc.dummyb0_1[0],
-				     single_toc.dummyb0_1[1],
-				     single_toc.dummyb0_1[2],
-				     single_toc.dummyb0_1[3],
-				     single_toc.num_skip_interval_pointers,
-				     single_toc.num_skip_track_assignments,
-				     single_toc.dummyb0_2);
-			if (res_size > 36 && single_toc.pointb2 > 0xaf)
-				printk
-				    ("addb2 %01x, conb2 %01x, poib2 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
-				     single_toc.addressb2,
-				     single_toc.controlb2,
-				     single_toc.pointb2,
-				     single_toc.tracksb2[0],
-				     single_toc.tracksb2[1],
-				     single_toc.tracksb2[2],
-				     single_toc.tracksb2[3],
-				     single_toc.tracksb2[4],
-				     single_toc.tracksb2[5],
-				     single_toc.tracksb2[6]);
-			if (res_size > 45 && single_toc.pointb3 > 0xaf)
-				printk
-				    ("addb3 %01x, conb3 %01x, poib3 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
-				     single_toc.addressb3,
-				     single_toc.controlb3,
-				     single_toc.pointb3,
-				     single_toc.tracksb3[0],
-				     single_toc.tracksb3[1],
-				     single_toc.tracksb3[2],
-				     single_toc.tracksb3[3],
-				     single_toc.tracksb3[4],
-				     single_toc.tracksb3[5],
-				     single_toc.tracksb3[6]);
-			if (res_size > 54 && single_toc.pointb4 > 0xaf)
-				printk
-				    ("addb4 %01x, conb4 %01x, poib4 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
-				     single_toc.addressb4,
-				     single_toc.controlb4,
-				     single_toc.pointb4,
-				     single_toc.tracksb4[0],
-				     single_toc.tracksb4[1],
-				     single_toc.tracksb4[2],
-				     single_toc.tracksb4[3],
-				     single_toc.tracksb4[4],
-				     single_toc.tracksb4[5],
-				     single_toc.tracksb4[6]);
-			if (res_size > 63 && single_toc.pointc0 > 0xaf)
-				printk
-				    ("addc0 %01x, conc0 %01x, poic0 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
-				     single_toc.addressc0,
-				     single_toc.controlc0,
-				     single_toc.pointc0,
-				     single_toc.dummyc0[0],
-				     single_toc.dummyc0[1],
-				     single_toc.dummyc0[2],
-				     single_toc.dummyc0[3],
-				     single_toc.dummyc0[4],
-				     single_toc.dummyc0[5],
-				     single_toc.dummyc0[6]);
-#endif
-#undef DEBUG
-#define DEBUG 0
+			    ("CDU31A: Error reading session %d: %x %s\n",
+			     session, single_toc.exec_status[0],
+			     translate_error(single_toc.
+					     exec_status[1]));
+			/* An error reading the TOC.  Return without sony_toc_read
+			   set. */
+			return;
+		}
 
+		sony_toc.lead_out_start_msf[0] =
+		    bcd_to_int(single_toc.lead_out_start_msf[0]);
+		sony_toc.lead_out_start_msf[1] =
+		    bcd_to_int(single_toc.lead_out_start_msf[1]);
+		sony_toc.lead_out_start_msf[2] =
+		    bcd_to_int(single_toc.lead_out_start_msf[2]);
+		sony_toc.lead_out_start_lba =
+		    single_toc.lead_out_start_lba =
+		    msf_to_log(sony_toc.lead_out_start_msf);
+
+		/* For points that do not exist, move the data over them
+		   to the right location. */
+		if (single_toc.pointb0 != 0xb0) {
+			memmove(((char *) &single_toc) + 27,
+				((char *) &single_toc) + 18,
+				res_size - 18);
+			res_size += 9;
+		} else if (res_size > 18) {
 			sony_toc.lead_out_start_msf[0] =
-			    bcd_to_int(single_toc.lead_out_start_msf[0]);
+			    bcd_to_int(single_toc.
+				       max_start_outer_leadout_msf
+				       [0]);
 			sony_toc.lead_out_start_msf[1] =
-			    bcd_to_int(single_toc.lead_out_start_msf[1]);
+			    bcd_to_int(single_toc.
+				       max_start_outer_leadout_msf
+				       [1]);
 			sony_toc.lead_out_start_msf[2] =
-			    bcd_to_int(single_toc.lead_out_start_msf[2]);
+			    bcd_to_int(single_toc.
+				       max_start_outer_leadout_msf
+				       [2]);
 			sony_toc.lead_out_start_lba =
-			    single_toc.lead_out_start_lba =
-			    msf_to_log(sony_toc.lead_out_start_msf);
-
-			/* For points that do not exist, move the data over them
-			   to the right location. */
-			if (single_toc.pointb0 != 0xb0) {
-				memmove(((char *) &single_toc) + 27,
-					((char *) &single_toc) + 18,
-					res_size - 18);
-				res_size += 9;
-			} else if (res_size > 18) {
-				sony_toc.lead_out_start_msf[0] =
-				    bcd_to_int(single_toc.
-					       max_start_outer_leadout_msf
-					       [0]);
-				sony_toc.lead_out_start_msf[1] =
-				    bcd_to_int(single_toc.
-					       max_start_outer_leadout_msf
-					       [1]);
-				sony_toc.lead_out_start_msf[2] =
+			    msf_to_log(sony_toc.
+				       lead_out_start_msf);
+		}
+		if (single_toc.pointb1 != 0xb1) {
+			memmove(((char *) &single_toc) + 36,
+				((char *) &single_toc) + 27,
+				res_size - 27);
+			res_size += 9;
+		}
+		if (single_toc.pointb2 != 0xb2) {
+			memmove(((char *) &single_toc) + 45,
+				((char *) &single_toc) + 36,
+				res_size - 36);
+			res_size += 9;
+		}
+		if (single_toc.pointb3 != 0xb3) {
+			memmove(((char *) &single_toc) + 54,
+				((char *) &single_toc) + 45,
+				res_size - 45);
+			res_size += 9;
+		}
+		if (single_toc.pointb4 != 0xb4) {
+			memmove(((char *) &single_toc) + 63,
+				((char *) &single_toc) + 54,
+				res_size - 54);
+			res_size += 9;
+		}
+		if (single_toc.pointc0 != 0xc0) {
+			memmove(((char *) &single_toc) + 72,
+				((char *) &single_toc) + 63,
+				res_size - 63);
+			res_size += 9;
+		}
+
+		/* prepare a special table of contents for a CD-I disc. They don't have one. */
+		if (single_toc.disk_type == 0x10 &&
+		    single_toc.first_track_num == 2 &&
+		    single_toc.last_track_num == 2 /* CD-I */ ) {
+			sony_toc.tracks[totaltracks].address = 1;
+			sony_toc.tracks[totaltracks].control = 4;	/* force data tracks */
+			sony_toc.tracks[totaltracks].track = 1;
+			sony_toc.tracks[totaltracks].
+			    track_start_msf[0] = 0;
+			sony_toc.tracks[totaltracks].
+			    track_start_msf[1] = 2;
+			sony_toc.tracks[totaltracks].
+			    track_start_msf[2] = 0;
+			mint = maxt = 1;
+			totaltracks++;
+		} else
+			/* gather track entries from this session */
+		{
+			int i;
+			for (i = 0;
+			     i <
+			     1 +
+			     bcd_to_int(single_toc.last_track_num)
+			     -
+			     bcd_to_int(single_toc.
+					first_track_num);
+			     i++, totaltracks++) {
+				sony_toc.tracks[totaltracks].
+				    address =
+				    single_toc.tracks[i].address;
+				sony_toc.tracks[totaltracks].
+				    control =
+				    single_toc.tracks[i].control;
+				sony_toc.tracks[totaltracks].
+				    track =
 				    bcd_to_int(single_toc.
-					       max_start_outer_leadout_msf
-					       [2]);
-				sony_toc.lead_out_start_lba =
-				    msf_to_log(sony_toc.
-					       lead_out_start_msf);
-			}
-			if (single_toc.pointb1 != 0xb1) {
-				memmove(((char *) &single_toc) + 36,
-					((char *) &single_toc) + 27,
-					res_size - 27);
-				res_size += 9;
-			}
-			if (single_toc.pointb2 != 0xb2) {
-				memmove(((char *) &single_toc) + 45,
-					((char *) &single_toc) + 36,
-					res_size - 36);
-				res_size += 9;
-			}
-			if (single_toc.pointb3 != 0xb3) {
-				memmove(((char *) &single_toc) + 54,
-					((char *) &single_toc) + 45,
-					res_size - 45);
-				res_size += 9;
-			}
-			if (single_toc.pointb4 != 0xb4) {
-				memmove(((char *) &single_toc) + 63,
-					((char *) &single_toc) + 54,
-					res_size - 54);
-				res_size += 9;
-			}
-			if (single_toc.pointc0 != 0xc0) {
-				memmove(((char *) &single_toc) + 72,
-					((char *) &single_toc) + 63,
-					res_size - 63);
-				res_size += 9;
-			}
-#if DEBUG
-			printk
-			    ("start track lba %u,  leadout start lba %u\n",
-			     single_toc.start_track_lba,
-			     single_toc.lead_out_start_lba);
-			{
-				int i;
-				for (i = 0;
-				     i <
-				     1 +
-				     bcd_to_int(single_toc.last_track_num)
-				     -
-				     bcd_to_int(single_toc.
-						first_track_num); i++) {
-					printk
-					    ("trk %02d: add 0x%01x, con 0x%01x,  track %02d, start min %02d, sec %02d, frame %02d\n",
-					     i,
-					     single_toc.tracks[i].address,
-					     single_toc.tracks[i].control,
-					     bcd_to_int(single_toc.
-							tracks[i].track),
-					     bcd_to_int(single_toc.
-							tracks[i].
-							track_start_msf
-							[0]),
-					     bcd_to_int(single_toc.
-							tracks[i].
-							track_start_msf
-							[1]),
-					     bcd_to_int(single_toc.
-							tracks[i].
-							track_start_msf
-							[2]));
-					if (mint >
-					    bcd_to_int(single_toc.
-						       tracks[i].track))
-						mint =
-						    bcd_to_int(single_toc.
-							       tracks[i].
-							       track);
-					if (maxt <
-					    bcd_to_int(single_toc.
-						       tracks[i].track))
-						maxt =
-						    bcd_to_int(single_toc.
-							       tracks[i].
-							       track);
-				}
-				printk
-				    ("min track number %d,   max track number %d\n",
-				     mint, maxt);
-			}
-#endif
-
-			/* prepare a special table of contents for a CD-I disc. They don't have one. */
-			if (single_toc.disk_type == 0x10 &&
-			    single_toc.first_track_num == 2 &&
-			    single_toc.last_track_num == 2 /* CD-I */ ) {
-				sony_toc.tracks[totaltracks].address = 1;
-				sony_toc.tracks[totaltracks].control = 4;	/* force data tracks */
-				sony_toc.tracks[totaltracks].track = 1;
+					       tracks[i].track);
 				sony_toc.tracks[totaltracks].
-				    track_start_msf[0] = 0;
+				    track_start_msf[0] =
+				    bcd_to_int(single_toc.
+					       tracks[i].
+					       track_start_msf[0]);
 				sony_toc.tracks[totaltracks].
-				    track_start_msf[1] = 2;
+				    track_start_msf[1] =
+				    bcd_to_int(single_toc.
+					       tracks[i].
+					       track_start_msf[1]);
 				sony_toc.tracks[totaltracks].
-				    track_start_msf[2] = 0;
-				mint = maxt = 1;
-				totaltracks++;
-			} else
-				/* gather track entries from this session */
-			{
-				int i;
-				for (i = 0;
-				     i <
-				     1 +
-				     bcd_to_int(single_toc.last_track_num)
-				     -
-				     bcd_to_int(single_toc.
-						first_track_num);
-				     i++, totaltracks++) {
-					sony_toc.tracks[totaltracks].
-					    address =
-					    single_toc.tracks[i].address;
-					sony_toc.tracks[totaltracks].
-					    control =
-					    single_toc.tracks[i].control;
-					sony_toc.tracks[totaltracks].
-					    track =
-					    bcd_to_int(single_toc.
-						       tracks[i].track);
-					sony_toc.tracks[totaltracks].
-					    track_start_msf[0] =
-					    bcd_to_int(single_toc.
-						       tracks[i].
-						       track_start_msf[0]);
-					sony_toc.tracks[totaltracks].
-					    track_start_msf[1] =
-					    bcd_to_int(single_toc.
-						       tracks[i].
-						       track_start_msf[1]);
-					sony_toc.tracks[totaltracks].
-					    track_start_msf[2] =
-					    bcd_to_int(single_toc.
-						       tracks[i].
-						       track_start_msf[2]);
-					if (i == 0)
-						single_toc.
-						    start_track_lba =
-						    msf_to_log(sony_toc.
-							       tracks
-							       [totaltracks].
-							       track_start_msf);
-					if (mint >
-					    sony_toc.tracks[totaltracks].
-					    track)
-						mint =
-						    sony_toc.
-						    tracks[totaltracks].
-						    track;
-					if (maxt <
-					    sony_toc.tracks[totaltracks].
-					    track)
-						maxt =
-						    sony_toc.
-						    tracks[totaltracks].
-						    track;
-				}
-			}
-			sony_toc.first_track_num = mint;
-			sony_toc.last_track_num = maxt;
-			/* Disk type of last session wins. For example:
-			   CD-Extra has disk type 0 for the first session, so
-			   a dumb HiFi CD player thinks it is a plain audio CD.
-			   We are interested in the disk type of the last session,
-			   which is 0x20 (XA) for CD-Extra, so we can access the
-			   data track ... */
-			sony_toc.disk_type = single_toc.disk_type;
-			sony_toc.sessions = session;
-
-			/* don't believe everything :-) */
-			if (session == 1)
-				single_toc.start_track_lba = 0;
-			sony_toc.start_track_lba =
-			    single_toc.start_track_lba;
-
-			if (session > 1 && single_toc.pointb0 == 0xb0 &&
-			    sony_toc.lead_out_start_lba ==
-			    single_toc.lead_out_start_lba) {
-				break;
-			}
-
-			/* Let's not get carried away... */
-			if (session > 40) {
-				printk("cdu31a: too many sessions: %d\n",
-				       session);
-				break;
-			}
-			session++;
+				    track_start_msf[2] =
+				    bcd_to_int(single_toc.
+					       tracks[i].
+					       track_start_msf[2]);
+				if (i == 0)
+					single_toc.
+					    start_track_lba =
+					    msf_to_log(sony_toc.
+						       tracks
+						       [totaltracks].
+						       track_start_msf);
+				if (mint >
+				    sony_toc.tracks[totaltracks].
+				    track)
+					mint =
+					    sony_toc.
+					    tracks[totaltracks].
+					    track;
+				if (maxt <
+				    sony_toc.tracks[totaltracks].
+				    track)
+					maxt =
+					    sony_toc.
+					    tracks[totaltracks].
+					    track;
+			}
+		}
+		sony_toc.first_track_num = mint;
+		sony_toc.last_track_num = maxt;
+		/* Disk type of last session wins. For example:
+		   CD-Extra has disk type 0 for the first session, so
+		   a dumb HiFi CD player thinks it is a plain audio CD.
+		   We are interested in the disk type of the last session,
+		   which is 0x20 (XA) for CD-Extra, so we can access the
+		   data track ... */
+		sony_toc.disk_type = single_toc.disk_type;
+		sony_toc.sessions = session;
+
+		/* don't believe everything :-) */
+		if (session == 1)
+			single_toc.start_track_lba = 0;
+		sony_toc.start_track_lba =
+		    single_toc.start_track_lba;
+
+		if (session > 1 && single_toc.pointb0 == 0xb0 &&
+		    sony_toc.lead_out_start_lba ==
+		    single_toc.lead_out_start_lba) {
+			break;
 		}
-		sony_toc.track_entries = totaltracks;
-		/* add one entry for the LAST track with track number CDROM_LEADOUT */
-		sony_toc.tracks[totaltracks].address = single_toc.address2;
-		sony_toc.tracks[totaltracks].control = single_toc.control2;
-		sony_toc.tracks[totaltracks].track = CDROM_LEADOUT;
-		sony_toc.tracks[totaltracks].track_start_msf[0] =
-		    sony_toc.lead_out_start_msf[0];
-		sony_toc.tracks[totaltracks].track_start_msf[1] =
-		    sony_toc.lead_out_start_msf[1];
-		sony_toc.tracks[totaltracks].track_start_msf[2] =
-		    sony_toc.lead_out_start_msf[2];
 
-		sony_toc_read = 1;
-#undef DEBUG
-#if DEBUG
-		printk
-		    ("Disk session %d, start track: %d, stop track: %d\n",
-		     session, single_toc.start_track_lba,
-		     single_toc.lead_out_start_lba);
-#endif
+		/* Let's not get carried away... */
+		if (session > 40) {
+			printk("CDU31A: too many sessions: %d\n",
+			       session);
+			break;
+		}
+		session++;
 	}
-#if DEBUG
+	sony_toc.track_entries = totaltracks;
+	/* add one entry for the LAST track with track number CDROM_LEADOUT */
+	sony_toc.tracks[totaltracks].address = single_toc.address2;
+	sony_toc.tracks[totaltracks].control = single_toc.control2;
+	sony_toc.tracks[totaltracks].track = CDROM_LEADOUT;
+	sony_toc.tracks[totaltracks].track_start_msf[0] =
+	    sony_toc.lead_out_start_msf[0];
+	sony_toc.tracks[totaltracks].track_start_msf[1] =
+	    sony_toc.lead_out_start_msf[1];
+	sony_toc.tracks[totaltracks].track_start_msf[2] =
+	    sony_toc.lead_out_start_msf[2];
+
+	sony_toc_read = 1;
+#if DEBUG
+	printk
+	    ("Disk session %d, start track: %d, stop track: %d\n",
+	     session, single_toc.start_track_lba,
+	     single_toc.lead_out_start_lba);
 	printk("Leaving sony_get_toc\n");
 #endif
 }
@@ -2019,8 +1791,12 @@
 	if (ms_info == NULL)
 		return 1;
 
-	if (!sony_toc_read)
+	if (!sony_toc_read) {
+		if (down_interruptible(&sony_sem))
+			return -ERESTARTSYS;
 		sony_get_toc();
+		up(&sony_sem);
+	}
 
 	ms_info->addr_format = CDROM_LBA;
 	ms_info->addr.lba = sony_toc.start_track_lba;
@@ -2098,8 +1874,11 @@
 	unsigned int res_size;
 
 	memset(mcn->medium_catalog_number, 0, 14);
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	do_sony_cd_cmd(SONY_REQ_UPC_EAN_CMD,
 		       NULL, 0, resbuffer, &res_size);
+	up(&sony_sem);
 	if ((res_size < 2) || ((resbuffer[0] & 0xf0) == 0x20));
 	else {
 		/* packed bcd to single ASCII digits */
@@ -2318,28 +2097,11 @@
 	unsigned char res_reg[12];
 	unsigned int res_size;
 	unsigned int cframe;
-	unsigned long flags;
 
-	/* 
-	 * Make sure no one else is using the driver; wait for them
-	 * to finish if it is so.
-	 */
-	save_flags(flags);
-	cli();
-	while (sony_inuse) {
-		interruptible_sleep_on(&sony_wait);
-		if (signal_pending(current)) {
-			restore_flags(flags);
-			return -EAGAIN;
-		}
-	}
-	sony_inuse = 1;
-	has_cd_task = current;
-	restore_flags(flags);
-
-	if (!sony_spun_up) {
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
+	if (!sony_spun_up)
 		scd_spinup();
-	}
 
 	/* Set the drive to do raw operations. */
 	params[0] = SONY_SD_DECODE_PARAM;
@@ -2468,14 +2230,12 @@
 	if ((res_size < 2) || ((res_reg[0] & 0xf0) == 0x20)) {
 		printk("CDU31A: Unable to reset decode params: 0x%2.2x\n",
 		       res_reg[1]);
-		return -EIO;
+		retval = -EIO;
 	}
 
-	has_cd_task = NULL;
-	sony_inuse = 0;
-	wake_up_interruptible(&sony_wait);
+	up(&sony_sem);
 
-	return (retval);
+	return retval;
 }
 
 static int
@@ -2501,6 +2261,10 @@
  */
 static int scd_tray_move(struct cdrom_device_info *cdi, int position)
 {
+	int retval;
+	
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	if (position == 1 /* open tray */ ) {
 		unsigned char res_reg[12];
 		unsigned int res_size;
@@ -2511,13 +2275,15 @@
 			       &res_size);
 
 		sony_audio_status = CDROM_AUDIO_INVALID;
-		return do_sony_cd_cmd_chk("EJECT", SONY_EJECT_CMD, NULL, 0,
+		retval = do_sony_cd_cmd_chk("EJECT", SONY_EJECT_CMD, NULL, 0,
 					  res_reg, &res_size);
 	} else {
 		if (0 == scd_spinup())
 			sony_spun_up = 1;
-		return 0;
+		retval = 0;
 	}
+	up(&sony_sem);
+	return retval;
 }
 
 /*
@@ -2529,127 +2295,139 @@
 	unsigned char res_reg[12];
 	unsigned int res_size;
 	unsigned char params[7];
-	int i;
-
+	int i, retval;
 
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	switch (cmd) {
-	case CDROMSTART:	/* Spin up the drive */
-		return do_sony_cd_cmd_chk("START", SONY_SPIN_UP_CMD, NULL,
-					  0, res_reg, &res_size);
-		break;
+		case CDROMSTART:	/* Spin up the drive */
+			retval = do_sony_cd_cmd_chk("START",
+					SONY_SPIN_UP_CMD, NULL, 0, res_reg,
+					&res_size);
+			break;
 
-	case CDROMSTOP:	/* Spin down the drive */
-		do_sony_cd_cmd(SONY_AUDIO_STOP_CMD, NULL, 0, res_reg,
-			       &res_size);
+		case CDROMSTOP:	/* Spin down the drive */
+			do_sony_cd_cmd(SONY_AUDIO_STOP_CMD, NULL, 0, res_reg,
+					&res_size);
 
-		/*
-		 * Spin the drive down, ignoring the error if the disk was
-		 * already not spinning.
-		 */
-		sony_audio_status = CDROM_AUDIO_NO_STATUS;
-		return do_sony_cd_cmd_chk("STOP", SONY_SPIN_DOWN_CMD, NULL,
-					  0, res_reg, &res_size);
-
-	case CDROMPAUSE:	/* Pause the drive */
-		if (do_sony_cd_cmd_chk
-		    ("PAUSE", SONY_AUDIO_STOP_CMD, NULL, 0, res_reg,
-		     &res_size))
-			return -EIO;
-		/* Get the current position and save it for resuming */
-		if (read_subcode() < 0) {
-			return -EIO;
-		}
-		cur_pos_msf[0] = last_sony_subcode.abs_msf[0];
-		cur_pos_msf[1] = last_sony_subcode.abs_msf[1];
-		cur_pos_msf[2] = last_sony_subcode.abs_msf[2];
-		sony_audio_status = CDROM_AUDIO_PAUSED;
-		return 0;
-		break;
+			/*
+			 * Spin the drive down, ignoring the error if the disk was
+			 * already not spinning.
+			 */
+			sony_audio_status = CDROM_AUDIO_NO_STATUS;
+			retval = do_sony_cd_cmd_chk("STOP",
+					SONY_SPIN_DOWN_CMD, NULL,
+					0, res_reg, &res_size);
+			break;
 
-	case CDROMRESUME:	/* Start the drive after being paused */
-		if (sony_audio_status != CDROM_AUDIO_PAUSED) {
-			return -EINVAL;
-		}
+		case CDROMPAUSE:	/* Pause the drive */
+			if (do_sony_cd_cmd_chk
+			    ("PAUSE", SONY_AUDIO_STOP_CMD, NULL, 0, res_reg,
+			     &res_size)) {
+				retval = -EIO;
+				break;
+			}
+			/* Get the current position and save it for resuming */
+			if (read_subcode() < 0) {
+				retval = -EIO;
+				break;
+			}
+			cur_pos_msf[0] = last_sony_subcode.abs_msf[0];
+			cur_pos_msf[1] = last_sony_subcode.abs_msf[1];
+			cur_pos_msf[2] = last_sony_subcode.abs_msf[2];
+			sony_audio_status = CDROM_AUDIO_PAUSED;
+			retval = 0;
+			break;
 
-		do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
-			       &res_size);
+		case CDROMRESUME:	/* Start the drive after being paused */
+			if (sony_audio_status != CDROM_AUDIO_PAUSED) {
+				retval = -EINVAL;
+				break;
+			}
 
-		/* Start the drive at the saved position. */
-		params[1] = int_to_bcd(cur_pos_msf[0]);
-		params[2] = int_to_bcd(cur_pos_msf[1]);
-		params[3] = int_to_bcd(cur_pos_msf[2]);
-		params[4] = int_to_bcd(final_pos_msf[0]);
-		params[5] = int_to_bcd(final_pos_msf[1]);
-		params[6] = int_to_bcd(final_pos_msf[2]);
-		params[0] = 0x03;
-		if (do_sony_cd_cmd_chk
-		    ("RESUME", SONY_AUDIO_PLAYBACK_CMD, params, 7, res_reg,
-		     &res_size) < 0)
-			return -EIO;
-		sony_audio_status = CDROM_AUDIO_PLAY;
-		return 0;
+			do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
+				&res_size);
 
-	case CDROMPLAYMSF:	/* Play starting at the given MSF address. */
-		do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
-			       &res_size);
+			/* Start the drive at the saved position. */
+			params[1] = int_to_bcd(cur_pos_msf[0]);
+			params[2] = int_to_bcd(cur_pos_msf[1]);
+			params[3] = int_to_bcd(cur_pos_msf[2]);
+			params[4] = int_to_bcd(final_pos_msf[0]);
+			params[5] = int_to_bcd(final_pos_msf[1]);
+			params[6] = int_to_bcd(final_pos_msf[2]);
+			params[0] = 0x03;
+			if (do_sony_cd_cmd_chk
+			    ("RESUME", SONY_AUDIO_PLAYBACK_CMD, params, 7,
+			     res_reg, &res_size) < 0) {
+				retval = -EIO;
+				break;
+			}
+			sony_audio_status = CDROM_AUDIO_PLAY;
+			retval = 0;
+			break;
 
-		/* The parameters are given in int, must be converted */
-		for (i = 1; i < 7; i++) {
-			params[i] =
-			    int_to_bcd(((unsigned char *) arg)[i - 1]);
-		}
-		params[0] = 0x03;
-		if (do_sony_cd_cmd_chk
-		    ("PLAYMSF", SONY_AUDIO_PLAYBACK_CMD, params, 7,
-		     res_reg, &res_size) < 0)
-			return -EIO;
+		case CDROMPLAYMSF:	/* Play starting at the given MSF address. */
+			do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
+				       &res_size);
 
-		/* Save the final position for pauses and resumes */
-		final_pos_msf[0] = bcd_to_int(params[4]);
-		final_pos_msf[1] = bcd_to_int(params[5]);
-		final_pos_msf[2] = bcd_to_int(params[6]);
-		sony_audio_status = CDROM_AUDIO_PLAY;
-		return 0;
+			/* The parameters are given in int, must be converted */
+			for (i = 1; i < 7; i++)
+				params[i] =
+				    int_to_bcd(((unsigned char *) arg)[i - 1]);
 
-	case CDROMREADTOCHDR:	/* Read the table of contents header */
-		{
+			params[0] = 0x03;
+			if (do_sony_cd_cmd_chk
+			    ("PLAYMSF", SONY_AUDIO_PLAYBACK_CMD, params, 7,
+			     res_reg, &res_size) < 0) {
+				retval = -EIO;
+				break;
+			}
+			/* Save the final position for pauses and resumes */
+			final_pos_msf[0] = bcd_to_int(params[4]);
+			final_pos_msf[1] = bcd_to_int(params[5]);
+			final_pos_msf[2] = bcd_to_int(params[6]);
+			sony_audio_status = CDROM_AUDIO_PLAY;
+			retval = 0;
+			break;
+
+		case CDROMREADTOCHDR: {	/* Read the table of contents header */
 			struct cdrom_tochdr *hdr;
 
 			sony_get_toc();
 			if (!sony_toc_read) {
-				return -EIO;
+				retval = -EIO;
+				break;
 			}
 
 			hdr = (struct cdrom_tochdr *) arg;
 			hdr->cdth_trk0 = sony_toc.first_track_num;
 			hdr->cdth_trk1 = sony_toc.last_track_num;
+			retval = 0;
+			break;
 		}
-		return 0;
 
-	case CDROMREADTOCENTRY:	/* Read a given table of contents entry */
-		{
+		case CDROMREADTOCENTRY: { /* Read a given table of contents entry */
 			struct cdrom_tocentry *entry;
 			int track_idx;
 			unsigned char *msf_val = NULL;
 
 			sony_get_toc();
 			if (!sony_toc_read) {
-				return -EIO;
+				retval = -EIO;
+				break;
 			}
 
 			entry = (struct cdrom_tocentry *) arg;
 
 			track_idx = find_track(entry->cdte_track);
 			if (track_idx < 0) {
-				return -EINVAL;
+				retval = -EINVAL;
+				break;
 			}
 
-			entry->cdte_adr =
-			    sony_toc.tracks[track_idx].address;
-			entry->cdte_ctrl =
-			    sony_toc.tracks[track_idx].control;
-			msf_val =
-			    sony_toc.tracks[track_idx].track_start_msf;
+			entry->cdte_adr = sony_toc.tracks[track_idx].address;
+			entry->cdte_ctrl = sony_toc.tracks[track_idx].control;
+			msf_val = sony_toc.tracks[track_idx].track_start_msf;
 
 			/* Logical buffer address or MSF format requested? */
 			if (entry->cdte_format == CDROM_LBA) {
@@ -2661,68 +2439,66 @@
 				entry->cdte_addr.msf.frame =
 				    *(msf_val + 2);
 			}
+			retval = 0;
+			break;
 		}
-		return 0;
-		break;
 
-	case CDROMPLAYTRKIND:	/* Play a track.  This currently ignores index. */
-		{
+		case CDROMPLAYTRKIND: {	/* Play a track.  This currently ignores index. */
 			struct cdrom_ti *ti = (struct cdrom_ti *) arg;
 			int track_idx;
 
 			sony_get_toc();
 			if (!sony_toc_read) {
-				return -EIO;
+				retval = -EIO;
+				break;
 			}
 
 			if ((ti->cdti_trk0 < sony_toc.first_track_num)
 			    || (ti->cdti_trk0 > sony_toc.last_track_num)
 			    || (ti->cdti_trk1 < ti->cdti_trk0)) {
-				return -EINVAL;
+				retval = -EINVAL;
+				break;
 			}
 
 			track_idx = find_track(ti->cdti_trk0);
 			if (track_idx < 0) {
-				return -EINVAL;
+				retval = -EINVAL;
+				break;
 			}
-			params[1] =
-			    int_to_bcd(sony_toc.tracks[track_idx].
-				       track_start_msf[0]);
-			params[2] =
-			    int_to_bcd(sony_toc.tracks[track_idx].
-				       track_start_msf[1]);
-			params[3] =
-			    int_to_bcd(sony_toc.tracks[track_idx].
-				       track_start_msf[2]);
+
+			params[1] = int_to_bcd(sony_toc.tracks[track_idx].
+					track_start_msf[0]);
+			params[2] = int_to_bcd(sony_toc.tracks[track_idx].
+					track_start_msf[1]);
+			params[3] = int_to_bcd(sony_toc.tracks[track_idx].
+					track_start_msf[2]);
 
 			/*
 			 * If we want to stop after the last track, use the lead-out
 			 * MSF to do that.
 			 */
-			if (ti->cdti_trk1 >= sony_toc.last_track_num) {
+			if (ti->cdti_trk1 >= sony_toc.last_track_num)
 				track_idx = find_track(CDROM_LEADOUT);
-			} else {
+			else
 				track_idx = find_track(ti->cdti_trk1 + 1);
-			}
 			if (track_idx < 0) {
-				return -EINVAL;
+				retval = -EINVAL;
+				break;
 			}
-			params[4] =
-			    int_to_bcd(sony_toc.tracks[track_idx].
-				       track_start_msf[0]);
-			params[5] =
-			    int_to_bcd(sony_toc.tracks[track_idx].
-				       track_start_msf[1]);
-			params[6] =
-			    int_to_bcd(sony_toc.tracks[track_idx].
-				       track_start_msf[2]);
+
+			params[4] = int_to_bcd(sony_toc.tracks[track_idx].
+					track_start_msf[0]);
+			params[5] = int_to_bcd(sony_toc.tracks[track_idx].
+					track_start_msf[1]);
+			params[6] = int_to_bcd(sony_toc.tracks[track_idx].
+					track_start_msf[2]);
 			params[0] = 0x03;
 
 			do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
-				       &res_size);
+					&res_size);
 
 			do_sony_cd_cmd(SONY_AUDIO_PLAYBACK_CMD, params, 7,
-				       res_reg, &res_size);
+					res_reg, &res_size);
 
 			if ((res_size < 2)
 			    || ((res_reg[0] & 0xf0) == 0x20)) {
@@ -2733,7 +2509,8 @@
 				printk
 				    ("Sony CDROM error %s (CDROMPLAYTRKIND)\n",
 				     translate_error(res_reg[1]));
-				return -EIO;
+				retval = -EIO;
+				break;
 			}
 
 			/* Save the final position for pauses and resumes */
@@ -2741,100 +2518,118 @@
 			final_pos_msf[1] = bcd_to_int(params[5]);
 			final_pos_msf[2] = bcd_to_int(params[6]);
 			sony_audio_status = CDROM_AUDIO_PLAY;
-			return 0;
+			retval = 0;
+			break;
 		}
 
-	case CDROMVOLCTRL:	/* Volume control.  What volume does this change, anyway? */
-		{
+		case CDROMVOLCTRL: {	/* Volume control.  What volume does this change, anyway? */
 			struct cdrom_volctrl *volctrl =
-			    (struct cdrom_volctrl *) arg;
+				(struct cdrom_volctrl *) arg;
 
 			params[0] = SONY_SD_AUDIO_VOLUME;
 			params[1] = volctrl->channel0;
 			params[2] = volctrl->channel1;
-			return do_sony_cd_cmd_chk("VOLCTRL",
-						  SONY_SET_DRIVE_PARAM_CMD,
-						  params, 3, res_reg,
-						  &res_size);
+			retval = do_sony_cd_cmd_chk("VOLCTRL",
+					 SONY_SET_DRIVE_PARAM_CMD,
+					 params, 3, res_reg, &res_size);
+			break;
 		}
-	case CDROMSUBCHNL:	/* Get subchannel info */
-		return sony_get_subchnl_info((struct cdrom_subchnl *) arg);
+		case CDROMSUBCHNL:	/* Get subchannel info */
+			retval = sony_get_subchnl_info(
+					(struct cdrom_subchnl *) arg);
+			break;
 
-	default:
-		return -EINVAL;
+		default:
+			retval = -EINVAL;
 	}
+	up(&sony_sem);
+	return retval;
 }
 
 static int scd_dev_ioctl(struct cdrom_device_info *cdi,
 			 unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
-	int i;
+	int i, retval;
 
+	if (down_interruptible(&sony_sem))
+		return -ERESTARTSYS;
 	switch (cmd) {
-	case CDROMREADAUDIO:	/* Read 2352 byte audio tracks and 2340 byte
+		case CDROMREADAUDIO: {
+				/* Read 2352 byte audio tracks and 2340 byte
 				   raw data tracks. */
-		{
 			struct cdrom_read_audio ra;
 
-
 			sony_get_toc();
 			if (!sony_toc_read) {
-				return -EIO;
+				retval = -EIO;
+				break;
 			}
 
-			if (copy_from_user(&ra, argp, sizeof(ra)))
-				return -EFAULT;
+			if (copy_from_user(&ra, argp, sizeof(ra))) {
+				retval = -EFAULT;
+				break;
+			}
 
 			if (ra.nframes == 0) {
-				return 0;
+				retval = 0;
+				break;
 			}
 
 			i = verify_area(VERIFY_WRITE, ra.buf,
 					CD_FRAMESIZE_RAW * ra.nframes);
-			if (i < 0)
-				return i;
+			if (i < 0) {
+				retval = i;
+				break;
+			}
 
-			if (ra.addr_format == CDROM_LBA) {
-				if ((ra.addr.lba >=
-				     sony_toc.lead_out_start_lba)
-				    || (ra.addr.lba + ra.nframes >=
-					sony_toc.lead_out_start_lba)) {
-					return -EINVAL;
-				}
-			} else if (ra.addr_format == CDROM_MSF) {
-				if ((ra.addr.msf.minute >= 75)
-				    || (ra.addr.msf.second >= 60)
-				    || (ra.addr.msf.frame >= 75)) {
-					return -EINVAL;
-				}
+			switch(ra.addr_format) {
+				case CDROM_LBA:
+					if ((ra.addr.lba >=
+					     sony_toc.lead_out_start_lba)
+					    || (ra.addr.lba + ra.nframes >=
+						sony_toc.lead_out_start_lba)) {
+						retval = -EINVAL;
+						goto exit_scd_dev_ioctl;
+					}
+					break;
+				case CDROM_MSF:
+					if ((ra.addr.msf.minute >= 75)
+					    || (ra.addr.msf.second >= 60)
+					    || (ra.addr.msf.frame >= 75)) {
+						retval = -EINVAL;
+						goto exit_scd_dev_ioctl;
+					}
 
-				ra.addr.lba = ((ra.addr.msf.minute * 4500)
+					ra.addr.lba = ((ra.addr.msf.minute * 4500)
 					       + (ra.addr.msf.second * 75)
 					       + ra.addr.msf.frame);
-				if ((ra.addr.lba >=
-				     sony_toc.lead_out_start_lba)
-				    || (ra.addr.lba + ra.nframes >=
-					sony_toc.lead_out_start_lba)) {
-					return -EINVAL;
-				}
+					if ((ra.addr.lba >=
+					     sony_toc.lead_out_start_lba)
+					    || (ra.addr.lba + ra.nframes >=
+						sony_toc.lead_out_start_lba)) {
+						retval = -EINVAL;
+						goto exit_scd_dev_ioctl;
+					}
 
 				/* I know, this can go negative on an unsigned.  However,
 				   the first thing done to the data is to add this value,
 				   so this should compensate and allow direct msf access. */
-				ra.addr.lba -= LOG_START_OFFSET;
-			} else {
-				return -EINVAL;
+					ra.addr.lba -= LOG_START_OFFSET;
+					break;
+				default:
+					retval = -EINVAL;
+					goto exit_scd_dev_ioctl;
 			}
-
-			return (read_audio(&ra));
+			retval = read_audio(&ra);
+			break;
 		}
-		return 0;
-		break;
-
-	default:
-		return -EINVAL;
+		default:
+			retval = -EINVAL;
 	}
+     exit_scd_dev_ioctl:
+	up(&sony_sem);
+	return retval;
 }
 
 static int scd_spinup(void)
@@ -2894,6 +2689,9 @@
 	unsigned int res_size;
 	unsigned char params[2];
 
+#if DEBUG
+	printk("CDU31A open, purpose=%d, usage=%d\n", purpose, sony_usage);
+#endif
 	if (purpose == 1) {
 		/* Open for IOCTLs only - no media check */
 		sony_usage++;
@@ -2909,7 +2707,7 @@
 				       res_reg, &res_size);
 			return -EIO;
 		}
-
+		set_capacity(scd_gendisk, 4 * sony_toc.lead_out_start_lba);
 		/* For XA on the CDU31A only, we have to do special reads.
 		   The CDU33A handles XA automagically. */
 		/* if (   (sony_toc.disk_type == SONY_XA_DISK_TYPE) */
@@ -2946,7 +2744,9 @@
 	}
 
 	sony_usage++;
-
+#if DEBUG
+	printk("CDU31A opened, purpose=%d, usage=%d\n", purpose, sony_usage);
+#endif
 	return 0;
 }
 
@@ -2957,6 +2757,9 @@
  */
 static void scd_release(struct cdrom_device_info *cdi)
 {
+#if DEBUG
+	printk("CDU31A closed, sony_usage %d\n", sony_usage);
+#endif
 	if (sony_usage == 1) {
 		unsigned char res_reg[12];
 		unsigned int res_size;
@@ -2996,6 +2799,7 @@
 	.name		= "cdu31a"
 };
 
+
 static int scd_block_open(struct inode *inode, struct file *file)
 {
 	return cdrom_open(&scd_info, inode, file);
@@ -3009,6 +2813,8 @@
 static int scd_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
+	int retval;
+
 	/* The eject and close commands should be handled by Uniform CD-ROM
 	 * driver - but I always got hard lockup instead of eject
 	 * until I put this here.
@@ -3016,12 +2822,15 @@
 	switch (cmd) {
 		case CDROMEJECT:
 			scd_lock_door(&scd_info, 0);
-			return scd_tray_move(&scd_info, 1);
+			retval = scd_tray_move(&scd_info, 1);
+			break;
 		case CDROMCLOSETRAY:
-			return scd_tray_move(&scd_info, 0);
+			retval = scd_tray_move(&scd_info, 0);
+			break;
 		default:
-			return cdrom_ioctl(file, &scd_info, inode, cmd, arg);
+			retval = cdrom_ioctl(file, &scd_info, inode, cmd, arg);
 	}
+	return retval;
 }
 
 static int scd_block_media_changed(struct gendisk *disk)
@@ -3038,8 +2847,6 @@
 	.media_changed	= scd_block_media_changed,
 };
 
-static struct gendisk *scd_gendisk;
-
 /* The different types of disc loading mechanisms supported */
 static char *load_mech[] __initdata =
     { "caddy", "tray", "pop-up", "unknown" };

--=_tic-80059-1103492678-0001-2--
