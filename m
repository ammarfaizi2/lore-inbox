Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313790AbSDHX0T>; Mon, 8 Apr 2002 19:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313791AbSDHX0S>; Mon, 8 Apr 2002 19:26:18 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48489 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313790AbSDHX0R>; Mon, 8 Apr 2002 19:26:17 -0400
Date: Mon, 8 Apr 2002 19:26:15 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Patch for ide-tape in 2.4.19-pre
Message-ID: <20020408192615.A4539@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This format must be dear to lm's heart 8-)]

BugEyeD	Synopsis
-------	-------------------------------------
  36628	I/O error reading HP Colorado 5GB tape drive
  62267	Segfault when insmod'in the ide-tape driver

-- Pete

diff -urN -X dontdiff linux-2.4.19-pre6/drivers/ide/ide-tape.c linux-2.4.19-pre6-p3/drivers/ide/ide-tape.c
--- linux-2.4.19-pre6/drivers/ide/ide-tape.c	Fri Apr  5 16:00:25 2002
+++ linux-2.4.19-pre6-p3/drivers/ide/ide-tape.c	Fri Apr  5 16:10:55 2002
@@ -429,8 +429,6 @@
 #include <asm/bitops.h>
 
 
-#define NO_LONGER_REQUIRED	(1)
-
 /*
  *	OnStream support
  */
@@ -2101,10 +2099,6 @@
 		if (status.b.check && pc->c[0] == IDETAPE_REQUEST_SENSE_CMD)
 			status.b.check = 0;
 		if (status.b.check || test_bit (PC_DMA_ERROR, &pc->flags)) {	/* Error detected */
-#if IDETAPE_DEBUG_LOG
-			if (tape->debug_level >= 1)
-				printk (KERN_INFO "ide-tape: %s: I/O error, ",tape->name);
-#endif /* IDETAPE_DEBUG_LOG */
 			if (pc->c[0] == IDETAPE_REQUEST_SENSE_CMD) {
 				printk (KERN_ERR "ide-tape: I/O error in request sense command\n");
 				return ide_do_reset (drive);
@@ -2178,7 +2172,7 @@
 	pc->current_position+=bcount.all;
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 2)
-		printk(KERN_INFO "ide-tape: [cmd %x] transferred %d bytes on that interrupt\n", pc->c[0], bcount.all);
+		printk(KERN_INFO "ide-tape: [cmd %x] done %d\n", pc->c[0], bcount.all);
 #endif
 	ide_set_handler (drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* And set the interrupt handler again */
 	return ide_started;
@@ -2297,7 +2291,7 @@
 	}
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 2)
-		printk (KERN_INFO "ide-tape: Retry number - %d\n", pc->retries);
+		printk (KERN_INFO "ide-tape: Retry number - %d, [cmd %x]\n", pc->retries, pc->c[0]);
 #endif /* IDETAPE_DEBUG_LOG */
 
 	pc->retries++;
@@ -2472,7 +2466,8 @@
 	status.all = GET_STAT();
 	if (status.b.dsc) {
 		if (status.b.check) {					/* Error detected */
-			printk (KERN_ERR "ide-tape: %s: I/O error, ",tape->name);
+			printk (KERN_ERR "ide-tape: %s: I/O error: pc = %2x, key = %2x, asc = %2x, ascq = %2x\n",
+					tape->name, pc->c[0], tape->sense_key, tape->asc, tape->ascq);
 			return idetape_retry_pc (drive);			/* Retry operation */
 		}
 		pc->error = 0;
@@ -3274,29 +3269,14 @@
 	int position;
 
 #if IDETAPE_DEBUG_LOG
-        if (tape->debug_level >= 4)
-	printk (KERN_INFO "ide-tape: Reached idetape_read_position\n");
+	if (tape->debug_level >= 4)
+		printk (KERN_INFO "ide-tape: Reached idetape_read_position\n");
 #endif /* IDETAPE_DEBUG_LOG */
 
-#ifdef NO_LONGER_REQUIRED
-	idetape_flush_tape_buffers(drive);
-#endif
 	idetape_create_read_position_cmd(&pc);
 	if (idetape_queue_pc_tail (drive, &pc))
 		return -1;
 	position = tape->first_frame_position;
-#ifdef NO_LONGER_REQUIRED
-	if (tape->onstream) {
-		if ((position != tape->last_frame_position - tape->blocks_in_buffer) &&
-		    (position != tape->last_frame_position + tape->blocks_in_buffer)) {
-			if (tape->blocks_in_buffer == 0) {
-				printk("ide-tape: %s: correcting read position %d, %d, %d\n", tape->name, position, tape->last_frame_position, tape->blocks_in_buffer);
-				position = tape->last_frame_position;
-				tape->first_frame_position = position;
-			}
-		}
-	}
-#endif
 	return position;
 }
 
@@ -5861,6 +5841,10 @@
 		printk(KERN_INFO "ide-tape: %s: overriding capabilities->max_speed (assuming 650KB/sec)\n", drive->name);
 		capabilities->max_speed = 650;
 	}
+	if (!capabilities->ctl) {
+		printk(KERN_INFO "ide-tape: %s: overriding capabilities->ctl (assuming 26KB)\n", drive->name);
+		capabilities->ctl = 52;
+	}
 
 	tape->capabilities = *capabilities;		/* Save us a copy */
 	if (capabilities->blk512)
@@ -6200,7 +6184,7 @@
 		ide_register_module (&idetape_module);
 		MOD_DEC_USE_COUNT;
 #if ONSTREAM_DEBUG
-		printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
+		printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_reinit\n");
 #endif
 		return 0;
 	}
@@ -6209,7 +6193,7 @@
 		printk (KERN_ERR "ide-tape: Failed to register character device interface\n");
 		MOD_DEC_USE_COUNT;
 #if ONSTREAM_DEBUG
-		printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
+		printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_reinit\n");
 #endif
 		return -EBUSY;
 	}
@@ -6259,7 +6243,7 @@
 	ide_register_module (&idetape_module);
 	MOD_DEC_USE_COUNT;
 #if ONSTREAM_DEBUG
-	printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
+	printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_reinit\n");
 #endif
 
 	return 0;
