Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbUKGQQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbUKGQQf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbUKGQQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:16:35 -0500
Received: from imap1.nextra.sk ([195.168.1.91]:11794 "EHLO mailhub1.nextra.sk")
	by vger.kernel.org with ESMTP id S261642AbUKGQPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:15:09 -0500
Message-ID: <418E4A27.2060104@rainbow-software.org>
Date: Sun, 07 Nov 2004 17:15:35 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041105)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tac-29322-1099844108-0001-2"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: cdu31a - anyone has this ancient drive for testing?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tac-29322-1099844108-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I've got a Sony CDU33A drive with COR334 controller. The Linux cdu31a 
driver was not updated for 2.6 kernel so it does not work.

Here are two patches that try to make the driver working with 2.6 
kernel. The cdu31a-timeouts-fix.patch fixes the timeout values in header 
file and the cdu31a-make-working.patch does the rest:
  - Make the driver work in 2.6.X
  - Added workaround to fix hard lockups on eject
  - Fixed door locking problem after mounting empty drive
  - Set double-speed drives to double speed by default
  - Removed all readahead things - not needed anymore

It does work on my system. I also know that it's still broken - it uses 
cli(), MODULE_PARM and it's also not very fast (I _never_ reached full 
300KB/s with it, but I know that it's possible in Windows) and probably 
many other things (I'm new to Linux kernel) - so I'm waiting for comments.

If someone has these ancient drives (CDU31A or CDU33A), please test :-)

-- 
Ondrej Zary

--=_tac-29322-1099844108-0001-2
Content-Type: text/plain; name="cdu31a-timeouts-fix.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdu31a-timeouts-fix.patch"

--- linux-2.6.9/drivers/cdrom/cdu31a.h	2004-10-18 23:53:12.000000000 +0200
+++ linux/drivers/cdrom/cdu31a.h	2004-10-20 16:07:15.000000000 +0200
@@ -72,10 +72,10 @@
                                            from drive (in 1/100th's
                                            of seconds). */
  
-#define SONY_JIFFIES_TIMEOUT    1000	/* Maximum number of times the
+#define SONY_JIFFIES_TIMEOUT    (10*HZ)	/* Maximum number of times the
                                            drive will wait/try for an
                                            operation */
-#define SONY_RESET_TIMEOUT      100	/* Maximum number of times the
+#define SONY_RESET_TIMEOUT      HZ	/* Maximum number of times the
                                            drive will wait/try a reset
                                            operation */
 #define SONY_READY_RETRIES      20000   /* How many times to retry a

--=_tac-29322-1099844108-0001-2
Content-Type: text/plain; name="cdu31a-make-working.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdu31a-make-working.patch"

--- linux-2.6.9/drivers/cdrom/cdu31a.c	2004-10-18 23:54:39.000000000 +0200
+++ linux/drivers/cdrom/cdu31a.c	2004-10-22 13:34:13.000000000 +0200
@@ -65,14 +65,6 @@
  * This section describes features beyond the normal audio and CD-ROM
  * functions of the drive.
  *
- * 2048 byte buffer mode
- *
- * If a disk is mounted with -o block=2048, data is copied straight
- * from the drive data port to the buffer.  Otherwise, the readahead
- * buffer must be involved to hold the other 1K of data when a 1K
- * block operation is done.  Note that with 2048 byte blocks you
- * cannot execute files from the CD.
- *
  * XA compatibility
  *
  * The driver should support XA disks for both the CDU31A and CDU33A.
@@ -147,6 +139,13 @@
  *	               Removed init_module & cleanup_module in favor of 
  *		       module_init & module_exit.
  *		       Torben Mathiasen <tmm@image.dk>
+ *
+ * 22 October 2004 -- Make the driver work in 2.6.X
+ *		      Added workaround to fix hard lockups on eject
+ *		      Fixed door locking problem after mounting empty drive
+ *		      Set double-speed drives to double speed by default
+ *		      Removed all readahead things - not needed anymore
+ *			Ondrej Zary <rainbow@rainbow-software.org>
 */
 
 #include <linux/major.h>
@@ -179,10 +178,9 @@
 #define MAJOR_NR CDU31A_CDROM_MAJOR
 #include <linux/blkdev.h>
 
-#define CDU31A_READAHEAD 4	/* 128 sector, 64kB, 32 reads read-ahead */
 #define CDU31A_MAX_CONSECUTIVE_ATTENTIONS 10
 
-#define DEBUG 0
+#define DEBUG 1
 
 /* Define the following if you have data corruption problems. */
 #undef SONY_POLL_EACH_BYTE
@@ -279,7 +277,6 @@
 						   NULL if none. */
 
 static int is_double_speed = 0;	/* does the drive support double speed ? */
-static int is_a_cdu31a = 1;	/* Is the drive a CDU31A? */
 
 static int is_auto_eject = 1;	/* Door has been locked? 1=No/0=Yes */
 
@@ -314,12 +311,8 @@
    it will be cleared. */
 static char disk_changed;
 
-/* Variable for using the readahead buffer.  The readahead buffer
-   is used for raw sector reads and for blocksizes that are smaller
-   than 2048 bytes. */
-static char readahead_buffer[CD_FRAMESIZE_RAW];
-static int readahead_dataleft = 0;
-static int readahead_bad = 0;
+/* This was readahead_buffer once... Now it's used only for audio reads */
+static char audio_buffer[CD_FRAMESIZE_RAW];
 
 /* Used to time a short period to abort an operation after the
    drive has been idle for a while.  This keeps the light on
@@ -440,7 +433,6 @@
 static inline void reset_drive(void)
 {
 	curr_control_reg = 0;
-	readahead_dataleft = 0;
 	sony_toc_read = 0;
 	outb(SONY_DRIVE_RESET_BIT, sony_cd_control_reg);
 }
@@ -556,82 +548,47 @@
 	static unsigned char errbuf[80];
 
 	switch (err_code) {
-	case 0x10:
-		return "illegal command ";
-	case 0x11:
-		return "illegal parameter ";
-
-	case 0x20:
-		return "not loaded ";
-	case 0x21:
-		return "no disc ";
-	case 0x22:
-		return "not spinning ";
-	case 0x23:
-		return "spinning ";
-	case 0x25:
-		return "spindle servo ";
-	case 0x26:
-		return "focus servo ";
-	case 0x29:
-		return "eject mechanism ";
-	case 0x2a:
-		return "audio playing ";
-	case 0x2c:
-		return "emergency eject ";
-
-	case 0x30:
-		return "focus ";
-	case 0x31:
-		return "frame sync ";
-	case 0x32:
-		return "subcode address ";
-	case 0x33:
-		return "block sync ";
-	case 0x34:
-		return "header address ";
-
-	case 0x40:
-		return "illegal track read ";
-	case 0x41:
-		return "mode 0 read ";
-	case 0x42:
-		return "illegal mode read ";
-	case 0x43:
-		return "illegal block size read ";
-	case 0x44:
-		return "mode read ";
-	case 0x45:
-		return "form read ";
-	case 0x46:
-		return "leadout read ";
-	case 0x47:
-		return "buffer overrun ";
-
-	case 0x53:
-		return "unrecoverable CIRC ";
-	case 0x57:
-		return "unrecoverable LECC ";
-
-	case 0x60:
-		return "no TOC ";
-	case 0x61:
-		return "invalid subcode data ";
-	case 0x63:
-		return "focus on TOC read ";
-	case 0x64:
-		return "frame sync on TOC read ";
-	case 0x65:
-		return "TOC data ";
-
-	case 0x70:
-		return "hardware failure ";
-	case 0x91:
-		return "leadin ";
-	case 0x92:
-		return "leadout ";
-	case 0x93:
-		return "data track ";
+		case 0x10: return "illegal command ";
+		case 0x11: return "illegal parameter ";
+
+		case 0x20: return "not loaded ";
+		case 0x21: return "no disc ";
+		case 0x22: return "not spinning ";
+		case 0x23: return "spinning ";
+		case 0x25: return "spindle servo ";
+		case 0x26: return "focus servo ";
+		case 0x29: return "eject mechanism ";
+		case 0x2a: return "audio playing ";
+		case 0x2c: return "emergency eject ";
+
+		case 0x30: return "focus ";
+		case 0x31: return "frame sync ";
+		case 0x32: return "subcode address ";
+		case 0x33: return "block sync ";
+		case 0x34: return "header address ";
+
+		case 0x40: return "illegal track read ";
+		case 0x41: return "mode 0 read ";
+		case 0x42: return "illegal mode read ";
+		case 0x43: return "illegal block size read ";
+		case 0x44: return "mode read ";
+		case 0x45: return "form read ";
+		case 0x46: return "leadout read ";
+		case 0x47: return "buffer overrun ";
+
+		case 0x53: return "unrecoverable CIRC ";
+		case 0x57: return "unrecoverable LECC ";
+
+		case 0x60: return "no TOC ";
+		case 0x61: return "invalid subcode data ";
+		case 0x63: return "focus on TOC read ";
+		case 0x64: return "frame sync on TOC read ";
+		case 0x65: return "TOC data ";
+
+		case 0x70: return "hardware failure ";
+		case 0x91: return "leadin ";
+		case 0x92: return "leadout ";
+		case 0x93: return "data track ";
 	}
 	sprintf(errbuf, "unknown 0x%02x ", err_code);
 	return errbuf;
@@ -696,8 +653,7 @@
  */
 static int scd_lock_door(struct cdrom_device_info *cdi, int lock)
 {
-	if (lock == 0 && sony_usage == 1) {
-		/* Unlock the door, only if nobody is using the drive */
+	if (lock == 0) {
 		is_auto_eject = 1;
 	} else {
 		is_auto_eject = 0;
@@ -1143,10 +1099,9 @@
    operation if the requested sector is not the next one from the
    drive. */
 static int
-start_request(unsigned int sector, unsigned int nsect, int read_nsect_only)
+start_request(unsigned int sector, unsigned int nsect)
 {
 	unsigned char params[6];
-	unsigned int read_size;
 	unsigned long retry_count;
 
 
@@ -1154,22 +1109,7 @@
 	printk("Entering start_request\n");
 #endif
 	log_to_msf(sector, params);
-	/* If requested, read exactly what was asked. */
-	if (read_nsect_only) {
-		read_size = nsect;
-	}
-	/*
-	 * If the full read-ahead would go beyond the end of the media, trim
-	 * it back to read just till the end of the media.
-	 */
-	else if ((sector + nsect) >= sony_toc.lead_out_start_lba) {
-		read_size = sony_toc.lead_out_start_lba - sector;
-	}
-	/* Read the full readahead amount. */
-	else {
-		read_size = CDU31A_READAHEAD / 4;
-	}
-	size_to_buf(read_size, &params[3]);
+	size_to_buf(nsect, &params[3]);
 
 	/*
 	 * Clear any outstanding attentions and wait for the drive to
@@ -1198,10 +1138,8 @@
 		write_params(params, 6);
 		write_cmd(SONY_READ_BLKERR_STAT_CMD);
 
-		sony_blocks_left = read_size * 4;
+		sony_blocks_left = nsect * 4;
 		sony_next_block = sector * 4;
-		readahead_dataleft = 0;
-		readahead_bad = 0;
 #if DEBUG
 		printk("Leaving start_request at %d\n", __LINE__);
 #endif
@@ -1212,8 +1150,7 @@
 #endif
 }
 
-/* Abort a pending read operation.  Clear all the drive status and
-   readahead variables. */
+/* Abort a pending read operation.  Clear all the drive status variables. */
 static void abort_read(void)
 {
 	unsigned char result_reg[2];
@@ -1238,8 +1175,6 @@
 	}
 
 	sony_blocks_left = 0;
-	readahead_dataleft = 0;
-	readahead_bad = 0;
 }
 
 /* Called when the timer times out.  This will abort the
@@ -1264,8 +1199,6 @@
 		write_cmd(SONY_ABORT_CMD);
 
 		sony_blocks_left = 0;
-		readahead_dataleft = 0;
-		readahead_bad = 0;
 		abort_read_started = 1;
 	}
 	restore_flags(flags);
@@ -1274,60 +1207,30 @@
 #endif
 }
 
-/* Actually get data and status from the drive. */
+/* Actually get one sector of data from the drive. */
 static void
-input_data(char *buffer,
-	   unsigned int bytesleft,
-	   unsigned int nblocks, unsigned int offset, unsigned int skip)
+input_data_sector(char *buffer)
 {
-	int i;
-	volatile unsigned char val;
-
-
 #if DEBUG
-	printk("Entering input_data\n");
+	printk("Entering input_data_sector\n");
 #endif
+
 	/* If an XA disk on a CDU31A, skip the first 12 bytes of data from
-	   the disk.  The real data is after that. */
-	if (sony_xa_mode) {
-		for (i = 0; i < CD_XA_HEAD; i++) {
-			val = read_data_register();
-		}
-	}
+	   the disk.  The real data is after that. We can use audio_buffer. */
+	if (sony_xa_mode)
+		insb(sony_cd_read_reg, audio_buffer, CD_XA_HEAD);
 
 	clear_data_ready();
 
-	if (bytesleft == 2048) {	/* 2048 byte direct buffer transfer */
-		insb(sony_cd_read_reg, buffer, 2048);
-		readahead_dataleft = 0;
-	} else {
-		/* If the input read did not align with the beginning of the block,
-		   skip the necessary bytes. */
-		if (skip != 0) {
-			insb(sony_cd_read_reg, readahead_buffer, skip);
-		}
-
-		/* Get the data into the buffer. */
-		insb(sony_cd_read_reg, &buffer[offset], bytesleft);
-
-		/* Get the rest of the data into the readahead buffer at the
-		   proper location. */
-		readahead_dataleft = (2048 - skip) - bytesleft;
-		insb(sony_cd_read_reg,
-		     readahead_buffer + bytesleft, readahead_dataleft);
-	}
-	sony_blocks_left -= nblocks;
-	sony_next_block += nblocks;
+	insb(sony_cd_read_reg, buffer, 2048);
 
 	/* If an XA disk, we have to clear out the rest of the unused
-	   error correction data. */
-	if (sony_xa_mode) {
-		for (i = 0; i < CD_XA_TAIL; i++) {
-			val = read_data_register();
-		}
-	}
+	   error correction data. We can use audio_buffer for that. */
+	if (sony_xa_mode)
+		insb(sony_cd_read_reg, audio_buffer, CD_XA_TAIL);
+
 #if DEBUG
-	printk("Leaving input_data at %d\n", __LINE__);
+	printk("Leaving input_data_sector\n");
 #endif
 }
 
@@ -1339,10 +1242,6 @@
 		unsigned char res_reg[], int *res_size)
 {
 	unsigned long retry_count;
-	unsigned int bytesleft;
-	unsigned int offset;
-	unsigned int skip;
-
 
 #if DEBUG
 	printk("Entering read_data_block\n");
@@ -1351,67 +1250,6 @@
 	res_reg[0] = 0;
 	res_reg[1] = 0;
 	*res_size = 0;
-	bytesleft = nblocks * 512;
-	offset = 0;
-
-	/* If the data in the read-ahead does not match the block offset,
-	   then fix things up. */
-	if (((block % 4) * 512) != ((2048 - readahead_dataleft) % 2048)) {
-		sony_next_block += block % 4;
-		sony_blocks_left -= block % 4;
-		skip = (block % 4) * 512;
-	} else {
-		skip = 0;
-	}
-
-	/* We have readahead data in the buffer, get that first before we
-	   decide if a read is necessary. */
-	if (readahead_dataleft != 0) {
-		if (bytesleft > readahead_dataleft) {
-			/* The readahead will not fill the requested buffer, but
-			   get the data out of the readahead into the buffer. */
-			memcpy(buffer,
-			       readahead_buffer + (2048 -
-						   readahead_dataleft),
-			       readahead_dataleft);
-			bytesleft -= readahead_dataleft;
-			offset += readahead_dataleft;
-			readahead_dataleft = 0;
-		} else {
-			/* The readahead will fill the whole buffer, get the data
-			   and return. */
-			memcpy(buffer,
-			       readahead_buffer + (2048 -
-						   readahead_dataleft),
-			       bytesleft);
-			readahead_dataleft -= bytesleft;
-			bytesleft = 0;
-			sony_blocks_left -= nblocks;
-			sony_next_block += nblocks;
-
-			/* If the data in the readahead is bad, return an error so the
-			   driver will abort the buffer. */
-			if (readahead_bad) {
-				res_reg[0] = 0x20;
-				res_reg[1] = SONY_BAD_DATA_ERR;
-				*res_size = 2;
-			}
-
-			if (readahead_dataleft == 0) {
-				readahead_bad = 0;
-			}
-
-			/* Final transfer is done for read command, get final result. */
-			if (sony_blocks_left == 0) {
-				get_result(res_reg, res_size);
-			}
-#if DEBUG
-			printk("Leaving read_data_block at %d\n",
-			       __LINE__);
-#endif
-			return;
-		}
-	}
 
 	/* Wait for the drive to tell us we have something */
 	retry_count = jiffies + SONY_JIFFIES_TIMEOUT;
@@ -1442,7 +1280,9 @@
 			abort_read();
 		}
 	} else {
-		input_data(buffer, bytesleft, nblocks, offset, skip);
+		input_data_sector(buffer);
+		sony_blocks_left -= nblocks;
+		sony_next_block += nblocks;
 
 		/* Wait for the status from the drive. */
 		retry_count = jiffies + SONY_JIFFIES_TIMEOUT;
@@ -1473,16 +1313,7 @@
 					SONY_NO_LECC_ERR_BLK_STAT)
 				    || (res_reg[0] ==
 					SONY_RECOV_LECC_ERR_BLK_STAT)) {
-					/* The data was successful, but if data was read from
-					   the readahead  and it was bad, set the whole
-					   buffer as bad. */
-					if (readahead_bad) {
-						readahead_bad = 0;
-						res_reg[0] = 0x20;
-						res_reg[1] =
-						    SONY_BAD_DATA_ERR;
-						*res_size = 2;
-					}
+					/* nothing here */
 				} else {
 					printk
 					    ("CDU31A: Data block error: 0x%x\n",
@@ -1490,12 +1321,6 @@
 					res_reg[0] = 0x20;
 					res_reg[1] = SONY_BAD_DATA_ERR;
 					*res_size = 2;
-
-					/* Data is in the readahead buffer but an error was returned.
-					   Make sure future requests don't use the data. */
-					if (bytesleft != 2048) {
-						readahead_bad = 1;
-					}
 				}
 
 				/* Final transfer is done for read command, get final result. */
@@ -1531,11 +1356,9 @@
 static void do_cdu31a_request(request_queue_t * q)
 {
 	struct request *req;
-	int block;
-	int nblock;
+	int block, nblock, num_retries;
 	unsigned char res_reg[12];
 	unsigned int res_size;
-	int num_retries;
 	unsigned long flags;
 
 
@@ -1591,7 +1414,10 @@
 
 		block = req->sector;
 		nblock = req->nr_sectors;
-
+#if DEBUG
+		printk("CDU31A: request at block %d, length %d blocks\n",
+			block, nblock);
+#endif
 		if (!sony_toc_read) {
 			printk("CDU31A: TOC not read\n");
 			end_request(req, 0);
@@ -1611,17 +1437,14 @@
 		 * If the block address is invalid or the request goes beyond the end of
 		 * the media, return an error.
 		 */
-		if ((block / 4) >= sony_toc.lead_out_start_lba) {
-			printk("CDU31A: Request past end of media\n");
-			end_request(req, 0);
-			continue;
-		}
 		if (((block + nblock) / 4) >= sony_toc.lead_out_start_lba) {
 			printk("CDU31A: Request past end of media\n");
 			end_request(req, 0);
 			continue;
 		}
 
+		if (nblock > 4)
+			nblock = 4;
 		num_retries = 0;
 
 	try_read_again:
@@ -1636,7 +1459,7 @@
 		/* If no data is left to be read from the drive, start the
 		   next request. */
 		if (sony_blocks_left == 0) {
-			if (start_request(block / 4, CDU31A_READAHEAD / 4, 0)) {
+			if (start_request(block / 4, nblock / 4)) {
 				end_request(req, 0);
 				continue;
 			}
@@ -1655,7 +1478,7 @@
 				end_request(req, 0);
 				continue;
 			}
-			if (start_request(block / 4, CDU31A_READAHEAD / 4, 0)) {
+			if (start_request(block / 4, nblock / 4)) {
 				printk("CDU31a: start request failed\n");
 				end_request(req, 0);
 				continue;
@@ -1665,7 +1488,12 @@
 		read_data_block(req->buffer, block, nblock, res_reg, &res_size);
 
 		if (res_reg[0] != 0x20) {
-			end_request(req, 1);
+			if (!end_that_request_first(req, 1, nblock)) {
+				spin_lock_irq(q->queue_lock);
+				blkdev_dequeue_request(req);
+				end_that_request_last(req);
+				spin_unlock_irq(q->queue_lock);
+			}
 			continue;
 		}
 
@@ -1774,7 +1602,7 @@
 /* This seems to slow things down enough to make it work.  This
  * appears to be a problem in do_sony_cd_cmd.  This printk seems 
  * to address the symptoms...  -Erik */
-#if 1
+#if DEBUG
 			printk("cdu31a: Trying session %d\n", session);
 #endif
 			parms[0] = session;
@@ -2529,8 +2357,7 @@
 	   return. */
 
 	retval = 0;
-	/* start_request clears out any readahead data, so it should be safe. */
-	if (start_request(ra->addr.lba, ra->nframes, 1)) {
+	if (start_request(ra->addr.lba, ra->nframes)) {
 		retval = -EIO;
 		goto exit_read_audio;
 	}
@@ -2538,7 +2365,7 @@
 	/* For every requested frame. */
 	cframe = 0;
 	while (cframe < ra->nframes) {
-		read_audio_data(readahead_buffer, res_reg, &res_size);
+		read_audio_data(audio_buffer, res_reg, &res_size);
 		if ((res_reg[0] & 0xf0) == 0x20) {
 			if (res_reg[1] == SONY_BAD_DATA_ERR) {
 				printk
@@ -2567,7 +2394,7 @@
 				/* Restart the request on the current frame. */
 				if (start_request
 				    (ra->addr.lba + cframe,
-				     ra->nframes - cframe, 1)) {
+				     ra->nframes - cframe)) {
 					retval = -EIO;
 					goto exit_read_audio;
 				}
@@ -2575,7 +2402,7 @@
 				/* Don't go back to the top because don't want to get into
 				   and infinite loop.  A lot of code gets duplicated, but
 				   that's no big deal, I don't guess. */
-				read_audio_data(readahead_buffer, res_reg,
+				read_audio_data(audio_buffer, res_reg,
 						&res_size);
 				if ((res_reg[0] & 0xf0) == 0x20) {
 					if (res_reg[1] ==
@@ -2596,7 +2423,7 @@
 				} else if (copy_to_user(ra->buf +
 							       (CD_FRAMESIZE_RAW
 								* cframe),
-						        readahead_buffer,
+						        audio_buffer,
 							CD_FRAMESIZE_RAW)) {
 					retval = -EFAULT;
 					goto exit_read_audio;
@@ -2610,7 +2437,7 @@
 				goto exit_read_audio;
 			}
 		} else if (copy_to_user(ra->buf + (CD_FRAMESIZE_RAW * cframe),
-					(char *)readahead_buffer,
+					(char *)audio_buffer,
 					CD_FRAMESIZE_RAW)) {
 			retval = -EFAULT;
 			goto exit_read_audio;
@@ -3061,12 +2888,18 @@
  * Open the drive for operations.  Spin the drive up and read the table of
  * contents if these have not already been done.
  */
-static int scd_open(struct cdrom_device_info *cdi, int openmode)
+static int scd_open(struct cdrom_device_info *cdi, int purpose)
 {
 	unsigned char res_reg[12];
 	unsigned int res_size;
 	unsigned char params[2];
 
+	if (purpose == 1) {
+		/* Open for IOCTLs only - no media check */
+		sony_usage++;
+		return 0;
+	}
+
 	if (sony_usage == 0) {
 		if (scd_spinup() != 0)
 			return -EIO;
@@ -3151,8 +2984,7 @@
 	.dev_ioctl		= scd_dev_ioctl,
 	.capability		= CDC_OPEN_TRAY | CDC_CLOSE_TRAY | CDC_LOCK |
 				  CDC_SELECT_SPEED | CDC_MULTI_SESSION |
-				  CDC_MULTI_SESSION | CDC_MCN |
-				  CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO |
+				  CDC_MCN | CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO |
 				  CDC_RESET | CDC_IOCTLS | CDC_DRIVE_STATUS,
 	.n_minors		= 1,
 };
@@ -3177,7 +3009,19 @@
 static int scd_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	return cdrom_ioctl(file, &scd_info, inode, cmd, arg);
+	/* The eject and close commands should be handled by Uniform CD-ROM
+	 * driver - but I always got hard lockup instead of eject
+	 * until I put this here.
+	 */
+	switch (cmd) {
+		case CDROMEJECT:
+			scd_lock_door(&scd_info, 0);
+			return scd_tray_move(&scd_info, 1);
+		case CDROMCLOSETRAY:
+			return scd_tray_move(&scd_info, 0);
+		default:
+			return cdrom_ioctl(file, &scd_info, inode, cmd, arg);
+	}
 }
 
 static int scd_block_media_changed(struct gendisk *disk)
@@ -3372,6 +3216,7 @@
 	tmp_irq = cdu31a_irq;	/* Need IRQ 0 because we can't sleep here. */
 	cdu31a_irq = 0;
 
+	sony_speed = is_double_speed; /* Set 2X drives to 2X by default */
 	set_drive_params(sony_speed);
 
 	cdu31a_irq = tmp_irq;
@@ -3417,13 +3262,12 @@
 		strcat(msg, buf);
 	}
 	strcat(msg, "\n");
-
-	is_a_cdu31a =
-	    strcmp("CD-ROM CDU31A", drive_config.product_id) == 0;
-
+	printk("%s",msg);
+	
 	cdu31a_queue = blk_init_queue(do_cdu31a_request, &cdu31a_lock);
 	if (!cdu31a_queue)
 		goto errout0;
+	blk_queue_hardsect_size(cdu31a_queue, 2048);
 
 	init_timer(&cdu31a_abort_timer);
 	cdu31a_abort_timer.function = handle_abort_timeout;

--=_tac-29322-1099844108-0001-2--
