Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVABBEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVABBEW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 20:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVABBER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 20:04:17 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:30160 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261208AbVABA7g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 19:59:36 -0500
Date: Sun, 02 Jan 2005 00:59:33 +0000
From: Willem Riede <osst@riede.org>
Subject: [PATCH 2/3] osst upgrade to 0.99.3
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
X-Mailer: Balsa 2.2.6
Message-Id: <1104627573l.3427l.3l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is patch 2 (see previous mail for context), providing osst error 
handling improvements.

signed-off-by: Willem Riede <osst@riede.org>

--- osst-patches/osst.h	2005-01-01 19:15:32.700230984 -0500
+++ /home/wriede/SfOsstCVS/Driver26/osst.h	2005-01-01 16:13:35.000000000 -0500
@@ -70,7 +70,7 @@
 #define BLOCK_SIZE_PAGE_LENGTH     4
 
 #define BUFFER_FILLING_PAGE        0x33
-#define BUFFER_FILLING_PAGE_LENGTH 
+#define BUFFER_FILLING_PAGE_LENGTH 4
 
 #define VENDOR_IDENT_PAGE          0x36
 #define VENDOR_IDENT_PAGE_LENGTH   8
@@ -577,6 +577,7 @@
   int min_block;
   int max_block;
   int recover_count;            /* from tape opening */
+  int abort_count;
   int write_count;
   int read_count;
   int recover_erreg;            /* from last status call */
--- osst-patches/osst.c	2005-01-01 19:11:25.000000000 -0500
+++ osst-patches/osst-2.c	2005-01-01 19:23:43.422396576 -0500
@@ -120,10 +120,10 @@
 // #define OSST_INJECT_ERRORS 1 
 #endif
 
-#define MAX_RETRIES 2
-#define MAX_READ_RETRIES 0
-#define MAX_WRITE_RETRIES 0
-#define MAX_READY_RETRIES 0
+/* Do not retry! The drive firmware already retries when appropriate,
+   and when it tries to tell us something, we had better listen... */
+#define MAX_RETRIES 0
+
 #define NO_TAPE  NOT_READY
 
 #define OSST_WAIT_POSITION_COMPLETE   (HZ > 200 ? HZ / 200 : 1)
@@ -224,7 +224,7 @@
 		if (driver_byte(result) & DRIVER_SENSE)
 			print_req_sense("osst ", SRpnt);
 	}
-//	else
+	else
 #endif
 	if (!(driver_byte(result) & DRIVER_SENSE) ||
 		((sense[0] & 0x70) == 0x70 &&
@@ -236,7 +236,7 @@
 		 SRpnt->sr_cmnd[0] != MODE_SENSE &&
 		 SRpnt->sr_cmnd[0] != TEST_UNIT_READY)) { /* Abnormal conditions for tape */
 		if (driver_byte(result) & DRIVER_SENSE) {
-			printk(KERN_WARNING "%s:W: Command with sense data: ", name);
+			printk(KERN_WARNING "%s:W: Command with sense data:\n", name);
 			print_req_sense("osst:", SRpnt);
 		}
 		else {
@@ -623,7 +623,7 @@
 	memset(cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = TEST_UNIT_READY;
 
-	SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_READY_RETRIES, TRUE);
+	SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_RETRIES, TRUE);
 	*aSRpnt = SRpnt;
 	if (!SRpnt) return (-EBUSY);
 
@@ -644,7 +644,7 @@
 	    memset(cmd, 0, MAX_COMMAND_SIZE);
 	    cmd[0] = TEST_UNIT_READY;
 
-	    SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_READY_RETRIES, TRUE);
+	    SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_RETRIES, TRUE);
 	}
 	*aSRpnt = SRpnt;
 #if DEBUG
@@ -684,7 +684,7 @@
 	memset(cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = TEST_UNIT_READY;
 
-	SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_READY_RETRIES, TRUE);
+	SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_RETRIES, TRUE);
 	*aSRpnt = SRpnt;
 	if (!SRpnt) return (-EBUSY);
 
@@ -703,7 +703,7 @@
 	    memset(cmd, 0, MAX_COMMAND_SIZE);
 	    cmd[0] = TEST_UNIT_READY;
 
-	    SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_READY_RETRIES, TRUE);
+	    SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_RETRIES, TRUE);
 	}
 	*aSRpnt = SRpnt;
 #if DEBUG
@@ -755,7 +755,7 @@
 	cmd[0] = WRITE_FILEMARKS;
 	cmd[1] = 1;
 
-	SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_WRITE_RETRIES, TRUE);
+	SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_RETRIES, TRUE);
 	*aSRpnt = SRpnt;
 	if (!SRpnt) return (-EBUSY);
 	if (STp->buffer->syscall_result) {
@@ -828,6 +828,62 @@
 	return -EBUSY;
 }
 
+static int osst_recover_wait_frame(struct osst_tape * STp, struct scsi_request ** aSRpnt, int writing)
+{
+	struct scsi_request   * SRpnt;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	unsigned long   	startwait = jiffies;
+	int			retval    = 1;
+        char		      * name      = tape_name(STp);
+                                                                                                                                
+	if (writing) {
+		char	mybuf[24];
+		char  * olddata = STp->buffer->b_data;
+		int	oldsize = STp->buffer->buffer_size;
+
+		/* write zero fm then read pos - if shows write error, try to recover - if no progress, wait */
+
+		memset(cmd, 0, MAX_COMMAND_SIZE);
+		cmd[0] = WRITE_FILEMARKS;
+		cmd[1] = 1;
+		SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout,
+								MAX_RETRIES, TRUE);
+
+		while (retval && time_before (jiffies, startwait + 5*60*HZ)) {
+
+			if (STp->buffer->syscall_result && (SRpnt->sr_sense_buffer[2] & 0x0f) != 2) {
+
+				/* some failure - not just not-ready */
+				retval = osst_write_error_recovery(STp, aSRpnt, 0);
+				break;
+			}
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout (HZ / OSST_POLL_PER_SEC);
+
+			STp->buffer->b_data = mybuf; STp->buffer->buffer_size = 24;
+			memset(cmd, 0, MAX_COMMAND_SIZE);
+			cmd[0] = READ_POSITION;
+
+			SRpnt = osst_do_scsi(SRpnt, STp, cmd, 20, SCSI_DATA_READ, STp->timeout,
+										MAX_RETRIES, TRUE);
+
+			retval = ( STp->buffer->syscall_result || (STp->buffer)->b_data[15] > 25 );
+			STp->buffer->b_data = olddata; STp->buffer->buffer_size = oldsize;
+		}
+		if (retval)
+			printk(KERN_ERR "%s:E: Device did not succeed to write buffered data\n", name);
+	} else
+		/* TODO - figure out which error conditions can be handled */
+		if (STp->buffer->syscall_result)
+			printk(KERN_WARNING
+				"%s:W: Recover_wait_frame(read) cannot handle %02x:%02x:%02x\n", name,
+					(*aSRpnt)->sr_sense_buffer[ 2] & 0x0f,
+					(*aSRpnt)->sr_sense_buffer[12],
+					(*aSRpnt)->sr_sense_buffer[13]);
+
+	return retval;
+}
+
 /*
  * Read the next OnStream tape frame at the current location
  */
@@ -841,10 +897,10 @@
 	char		      * name   = tape_name(STp);
 #endif
 
-	/* TODO: Error handling */
 	if (STp->poll)
-		retval = osst_wait_frame (STp, aSRpnt, STp->first_frame_position, 0, timeout);
-	
+		if (osst_wait_frame (STp, aSRpnt, STp->first_frame_position, 0, timeout))
+			retval = osst_recover_wait_frame(STp, aSRpnt, 0);
+
 	memset(cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = READ_6;
 	cmd[1] = 1;
@@ -852,13 +908,13 @@
 
 #if DEBUG
 	if (debugging)
-	    printk(OSST_DEB_MSG "%s:D: Reading frame from OnStream tape\n", name);
+		printk(OSST_DEB_MSG "%s:D: Reading frame from OnStream tape\n", name);
 #endif
 	SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, OS_FRAME_SIZE, SCSI_DATA_READ,
-				      STp->timeout, MAX_READ_RETRIES, TRUE);
+				      STp->timeout, MAX_RETRIES, TRUE);
 	*aSRpnt = SRpnt;
 	if (!SRpnt)
-	    return (-EBUSY);
+		return (-EBUSY);
 
 	if ((STp->buffer)->syscall_result) {
 	    retval = 1;
@@ -930,9 +986,10 @@
 #if DEBUG
 		printk(OSST_DEB_MSG "%s:D: Start Read Ahead on OnStream tape\n", name);
 #endif
-		SRpnt   = osst_do_scsi(*aSRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_READ_RETRIES, TRUE);
+		SRpnt   = osst_do_scsi(*aSRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_RETRIES, TRUE);
 		*aSRpnt = SRpnt;
-		retval  = STp->buffer->syscall_result;
+		if ((retval = STp->buffer->syscall_result))
+			printk(KERN_WARNING "%s:W: Error starting read ahead\n", name);
 	}
 
 	return retval;
@@ -972,6 +1029,7 @@
 						    name, STp->read_error_frame);
 #endif
 				STp->read_error_frame = 0;
+				STp->abort_count++;
 			}
 			return (-EIO);
 		}
@@ -989,10 +1047,11 @@
 				position = 0xbb8;
 			else if (position > STp->eod_frame_ppos || ++bad == 10) {
 				position = STp->read_error_frame - 1;
+				bad = 0;
 			}
 			else {
-				position += 39;
-				cnt += 20;
+				position += 29;
+				cnt      += 19;
 			}
 #if DEBUG
 			printk(OSST_DEB_MSG "%s:D: Bad frame detected, positioning tape to block %d\n",
@@ -1309,7 +1368,7 @@
 		cmd[8] = 32768 & 0xff;
 
 		SRpnt = osst_do_scsi(SRpnt, STp, cmd, OS_FRAME_SIZE, SCSI_DATA_READ,
-					    STp->timeout, MAX_READ_RETRIES, TRUE);
+					    STp->timeout, MAX_RETRIES, TRUE);
 	
 		if ((STp->buffer)->syscall_result || !SRpnt) {
 			printk(KERN_ERR "%s:E: Failed to read frame back from OnStream buffer\n", name);
@@ -1358,8 +1417,8 @@
 				vfree((void *)buffer);
 				return (-EIO);
 			}
-			flag = 0;
 			if ( i >= nframes + pending ) break;
+			flag = 0;
 		}
 		osst_copy_to_buffer(STp->buffer, p);
 		/*
@@ -1381,7 +1440,7 @@
 				p[0], p[1], p[2], p[3]);
 #endif
 		SRpnt = osst_do_scsi(SRpnt, STp, cmd, OS_FRAME_SIZE, SCSI_DATA_WRITE,
-					    STp->timeout, MAX_WRITE_RETRIES, TRUE);
+					    STp->timeout, MAX_RETRIES, TRUE);
 
 		if (STp->buffer->syscall_result)
 			flag = 1;
@@ -1397,7 +1456,7 @@
 				cmd[0] = WRITE_FILEMARKS;
 				cmd[1] = 1;
 				SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE,
-							    STp->timeout, MAX_WRITE_RETRIES, TRUE);
+							    STp->timeout, MAX_RETRIES, TRUE);
 #if DEBUG
 				if (debugging) {
 					printk(OSST_DEB_MSG "%s:D: Sleeping in re-write wait ready\n", name);
@@ -1412,7 +1471,7 @@
 					cmd[0] = TEST_UNIT_READY;
 
 					SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout,
-									 MAX_READY_RETRIES, TRUE);
+												MAX_RETRIES, TRUE);
 
 					if (SRpnt->sr_sense_buffer[2] == 2 && SRpnt->sr_sense_buffer[12] == 4 &&
 					    (SRpnt->sr_sense_buffer[13] == 1 || SRpnt->sr_sense_buffer[13] == 8)) {
@@ -1449,11 +1508,16 @@
 #endif
 			osst_get_frame_position(STp, aSRpnt);
 #if DEBUG
-			printk(OSST_DEB_MSG "%s:D: reported frame positions: host = %d, tape = %d\n",
-					  name, STp->first_frame_position, STp->last_frame_position);
+			printk(OSST_DEB_MSG "%s:D: reported frame positions: host = %d, tape = %d, buffer = %d\n",
+					  name, STp->first_frame_position, STp->last_frame_position, STp->cur_frames);
 #endif
 		}
-	}    
+	}
+	if (flag) {
+		/* error recovery did not successfully complete */
+		printk(KERN_ERR "%s:D: Write error recovery failed in %s\n", name,
+				STp->write_type == OS_WRITE_HEADER?"header":"body");
+	}
 	if (!pending)
 		osst_copy_to_buffer(STp->buffer, p);	/* so buffer content == at entry in all cases */
 	vfree((void *)buffer);
@@ -1513,7 +1577,7 @@
 					  name, STp->frame_seq_number-1, STp->first_frame_position);
 #endif
 			SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, OS_FRAME_SIZE, SCSI_DATA_WRITE,
-						      STp->timeout, MAX_WRITE_RETRIES, TRUE);
+						      STp->timeout, MAX_RETRIES, TRUE);
 			*aSRpnt = SRpnt;
 
 			if (STp->buffer->syscall_result) {		/* additional write error */
@@ -1551,6 +1615,7 @@
 			debugging = 0;
 		}
 #endif
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ / 10);
 	}
 	printk(KERN_ERR "%s:E: Failed to find valid tape media\n", name);
@@ -1636,7 +1701,9 @@
 	if (retval == 0) {
 		STp->recover_count++;
 		STp->recover_erreg++;
-	}
+	} else
+		STp->abort_count++;
+
 	STps->rw = rw_state;
 	return retval;
 }
@@ -2703,13 +2770,12 @@
 	*aSRpnt = SRpnt;
 
 	if (STp->buffer->syscall_result)
-		result = ((SRpnt->sr_sense_buffer[2] & 0x0f) == 3) ? -EIO : -EINVAL;
+		result = ((SRpnt->sr_sense_buffer[2] & 0x0f) == 3) ? -EIO : -EINVAL;	/* 3: Write Error */
 
 	if (result == -EINVAL)
 		printk(KERN_ERR "%s:E: Can't read tape position.\n", name);
 	else {
-
-		if (result == -EIO) {	/* re-read position */
+		if (result == -EIO) {	/* re-read position - this needs to preserve media errors */
 			unsigned char mysense[16];
 			memcpy (mysense, SRpnt->sr_sense_buffer, 16);
 			memset (scmd, 0, MAX_COMMAND_SIZE);
@@ -2717,8 +2783,15 @@
 			STp->buffer->b_data = mybuf; STp->buffer->buffer_size = 24;
 			SRpnt = osst_do_scsi(SRpnt, STp, scmd, 20, SCSI_DATA_READ,
 						    STp->timeout, MAX_RETRIES, TRUE);
+#if DEBUG
+			printk(OSST_DEB_MSG "%s:D: Reread position, reason=[%02x:%02x:%02x], result=[%s%02x:%02x:%02x]\n",
+					name, mysense[2], mysense[12], mysense[13], STp->buffer->syscall_result?"":"ok:",
+					SRpnt->sr_sense_buffer[2],SRpnt->sr_sense_buffer[12],SRpnt->sr_sense_buffer[13]);
+#endif
 			if (!STp->buffer->syscall_result)
 				memcpy (SRpnt->sr_sense_buffer, mysense, 16);
+			else
+				printk(KERN_WARNING "%s:W: Double error in get position\n", name);
 		}
 		STp->first_frame_position = ((STp->buffer)->b_data[4] << 24)
 					  + ((STp->buffer)->b_data[5] << 16)
@@ -2740,7 +2813,7 @@
 #endif
 		if (STp->cur_frames == 0 && STp->first_frame_position != STp->last_frame_position) {
 #if DEBUG
-			printk(KERN_WARNING "%s:D: Correcting read position %d, %d, %d\n", name,
+			printk(OSST_DEB_MSG "%s:D: Correcting read position %d, %d, %d\n", name,
 					STp->first_frame_position, STp->last_frame_position, STp->cur_frames);
 #endif
 			STp->first_frame_position = STp->last_frame_position;
@@ -2885,9 +2958,9 @@
 		if (offset < OS_DATA_SIZE)
 			osst_zero_buffer_tail(STp->buffer);
 
-		/* TODO: Error handling! */
 		if (STp->poll)
-			result = osst_wait_frame (STp, aSRpnt, STp->first_frame_position, -50, 120);
+			if (osst_wait_frame (STp, aSRpnt, STp->first_frame_position, -50, 120))
+				result = osst_recover_wait_frame(STp, aSRpnt, 1);
 
 		memset(cmd, 0, MAX_COMMAND_SIZE);
 		cmd[0] = WRITE_6;
@@ -2926,7 +2999,7 @@
 #endif
 
 		SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, transfer, SCSI_DATA_WRITE,
-					  STp->timeout, MAX_WRITE_RETRIES, TRUE);
+					      STp->timeout, MAX_RETRIES, TRUE);
 		*aSRpnt = SRpnt;
 		if (!SRpnt)
 			return (-EBUSY);
@@ -3056,8 +3129,9 @@
 	}
 
 	if (STp->poll)
-		osst_wait_frame (STp, aSRpnt, STp->first_frame_position, -50, 60);
-	/* TODO: Check for an error ! */
+		if (osst_wait_frame (STp, aSRpnt, STp->first_frame_position, -48, 120))
+			if (osst_recover_wait_frame(STp, aSRpnt, 1))
+				return (-EIO);
 
 //	osst_build_stats(STp, &SRpnt);
 
@@ -3082,7 +3156,7 @@
 		STp->write_pending = 1;
 #endif
 	SRpnt = osst_do_scsi(*aSRpnt, STp, cmd, OS_FRAME_SIZE, SCSI_DATA_WRITE, STp->timeout,
-							MAX_WRITE_RETRIES, synchronous);
+									MAX_RETRIES, synchronous);
 	if (!SRpnt)
 		return (-EBUSY);
 	*aSRpnt = SRpnt;
@@ -4328,9 +4402,9 @@
 	memset (cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = TEST_UNIT_READY;
 
-	SRpnt = osst_do_scsi(NULL, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_READY_RETRIES, TRUE);
+	SRpnt = osst_do_scsi(NULL, STp, cmd, 0, SCSI_DATA_NONE, STp->timeout, MAX_RETRIES, TRUE);
 	if (!SRpnt) {
-		retval = (STp->buffer)->syscall_result;
+		retval = (STp->buffer)->syscall_result;		/* FIXME - valid? */
 		goto err_out;
 	}
 	if ((SRpnt->sr_sense_buffer[0] & 0x70) == 0x70      &&
@@ -4349,7 +4423,7 @@
 			cmd[1] = 1;
 			cmd[4] = 1;
 			SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE,
-					     STp->timeout, MAX_READY_RETRIES, TRUE);
+					     STp->timeout, MAX_RETRIES, TRUE);
 		}
 		osst_wait_ready(STp, &SRpnt, (SRpnt->sr_sense_buffer[13]==1?15:3) * 60, 0);
 	}
@@ -4366,7 +4440,7 @@
 			cmd[0] = TEST_UNIT_READY;
 
 			SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE,
-					     STp->timeout, MAX_READY_RETRIES, TRUE);
+					     STp->timeout, MAX_RETRIES, TRUE);
 			if ((SRpnt->sr_sense_buffer[0] & 0x70) != 0x70 ||
 			    (SRpnt->sr_sense_buffer[2] & 0x0f) != UNIT_ATTENTION)
 				break;
@@ -4387,6 +4461,7 @@
 		}
 		new_session = TRUE;
 		STp->recover_count = 0;
+		STp->abort_count = 0;
 	}
 	/*
 	 * if we have valid headers from before, and the drive/tape seem untouched,
@@ -4474,7 +4549,7 @@
 			cmd[0] = TEST_UNIT_READY;
 
 			SRpnt = osst_do_scsi(SRpnt, STp, cmd, 0, SCSI_DATA_NONE,
-					     STp->timeout, MAX_READY_RETRIES, TRUE);
+						    STp->timeout, MAX_RETRIES, TRUE);
 			if ((SRpnt->sr_sense_buffer[0] & 0x70) != 0x70 ||
 			    (SRpnt->sr_sense_buffer[2] & 0x0f) == NOT_READY)
 			break;
@@ -4658,14 +4733,19 @@
 	}
 	if (SRpnt) scsi_release_request(SRpnt);
 
-	if (STp->recover_count) {
-		printk(KERN_INFO "%s:I: %d recovered errors in", name, STp->recover_count);
+	if (STp->abort_count || STp->recover_count) {
+		printk(KERN_INFO "%s:I:", name);
+		if (STp->abort_count)
+			printk(" %d unrecovered errors", STp->abort_count);
+		if (STp->recover_count)
+			printk(" %d recovered errors", STp->recover_count);
 		if (STp->write_count)
-			printk(" %d frames written", STp->write_count);
+			printk(" in %d frames written", STp->write_count);
 		if (STp->read_count)
-			printk(" %d frames read", STp->read_count);
+			printk(" in %d frames read", STp->read_count);
 		printk("\n");
 		STp->recover_count = 0;
+		STp->abort_count   = 0;
 	}
 	STp->write_count = 0;
 	STp->read_count  = 0;
@@ -5088,12 +5168,10 @@
 	if (nbr <= 2)
 		return FALSE;
 
-	priority = GFP_KERNEL;
+	priority = GFP_KERNEL /* | __GFP_NOWARN */;
 	if (need_dma)
 		priority |= GFP_DMA;
 
-	priority |= __GFP_NOWARN;
-
 	/* Try to allocate the first segment up to OS_DATA_SIZE and the others
 	   big enough to reach the goal (code assumes no segments in place) */
 	for (b_size = OS_DATA_SIZE, order = OSST_FIRST_ORDER; b_size >= PAGE_SIZE; order--, b_size /= 2) {


