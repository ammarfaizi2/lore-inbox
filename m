Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbSLNDq6>; Fri, 13 Dec 2002 22:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSLNDq5>; Fri, 13 Dec 2002 22:46:57 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46882 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266994AbSLNDq4>; Fri, 13 Dec 2002 22:46:56 -0500
Date: Fri, 13 Dec 2002 22:44:24 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: alan@redhat.com
Cc: stern@rowland.harvard.edu, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: My fixes to ide-tape in 2.4.20-ac2
Message-ID: <20021213224424.A3446@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I checked that my fixes were not corrected by Alan Stern,
and re-diffed them against 2.4.20-ac2. I think it would
be right if Alan (Cox :-) applied this patch to -ac3 or something.
Marcelo agreed to take it many times but forgot to actually apply.

-- Pete

BugID Synopsys
----- -------------------------------
36628 I/O error reading HP Colorado 5GB tape drive
62267 Segfault when insmod'in the ide-tape driver
I6809 ***** B5: divide error: 0000

36628:
Removes extra buffer flush from read_position(), which confuses
all versions of the HP Colorado.
Also touches up on insane logging.

62267:
ide-tape: Model: Seagate STT3401A
ide-tape: Firmware Revision: 308A
....
ide-tape: Maximum supported speed in KBps - 4000
ide-tape: Continuous transfer limits in blocks - 0     <===== HUH?!
ide-tape: Current speed in KBps - 755

I6809:
ide-tape: Model: Seagate STT3401A
ide-tape: Firmware Revision: 309C
....
ide-tape: Adjusted block size - 0		<===== Seagate strikes back
divide error: 0000

--- linux-2.4.20-ac2/drivers/ide/ide-tape.c	Fri Dec 13 16:55:13 2002
+++ linux-2.4.20-ac2-pb/drivers/ide/ide-tape.c	Fri Dec 13 18:12:20 2002
@@ -450,8 +450,6 @@
 #include <asm/bitops.h>
 
 
-#define NO_LONGER_REQUIRED	(1)
-
 /*
  *	OnStream support
  */
@@ -3486,29 +3482,10 @@
 		printk (KERN_INFO "ide-tape: Reached %s\n", __FUNCTION__);
 #endif /* IDETAPE_DEBUG_LOG */
 
-#ifdef NO_LONGER_REQUIRED
-	idetape_flush_tape_buffers(drive);
-#endif
 	idetape_create_read_position_cmd(&pc);
 	if (idetape_queue_pc_tail(drive, &pc))
 		return -1;
 	position = tape->first_frame_position;
-#ifdef NO_LONGER_REQUIRED
-	if (tape->onstream) {
-		if ((position != tape->last_frame_position - tape->blocks_in_buffer) &&
-		    (position != tape->last_frame_position + tape->blocks_in_buffer)) {
-			if (tape->blocks_in_buffer == 0) {
-				printk("ide-tape: %s: correcting read "
-					"position %d, %d, %d\n",
-					tape->name, position,
-					tape->last_frame_position,
-					tape->blocks_in_buffer);
-				position = tape->last_frame_position;
-				tape->first_frame_position = position;
-			}
-		}
-	}
-#endif
 	return position;
 }
 
@@ -6195,6 +6172,10 @@
 		printk(KERN_INFO "ide-tape: %s: overriding capabilities->max_speed (assuming 650KB/sec)\n", drive->name);
 		capabilities->max_speed = 650;
 	}
+	if (!capabilities->ctl) {
+		printk(KERN_INFO "ide-tape: %s: overriding capabilities->ctl (assuming 26KB)\n", drive->name);
+		capabilities->ctl = 52;
+	}
 
 	tape->capabilities = *capabilities;		/* Save us a copy */
 	if (capabilities->blk512)
@@ -6250,10 +6231,6 @@
 	idetape_create_mode_sense_cmd(&pc, IDETAPE_BLOCK_DESCRIPTOR);
 	if (idetape_queue_pc_tail(drive, &pc)) {
 		printk(KERN_ERR "ide-tape: Can't get block descriptor\n");
-		if (tape->tape_block_size == 0) {
-			printk(KERN_WARNING "ide-tape: Cannot deal with zero block size, assume 32k\n");
-			tape->tape_block_size =  32768;
-		}
 		return;
 	}
 	header = (idetape_mode_parameter_header_t *) pc.buffer;
@@ -6350,6 +6327,10 @@
 	idetape_get_inquiry_results(drive);
 	idetape_get_mode_sense_results(drive);
 	idetape_get_blocksize_from_block_descriptor(drive);
+	if (tape->tape_block_size == 0) {
+		printk(KERN_WARNING "ide-tape: Zero block size, using 512\n");
+		tape->tape_block_size = 512;
+	}
 	if (tape->onstream) {
 		idetape_onstream_mode_sense_tape_parameter_page(drive, 1);
 		idetape_configure_onstream(drive);
