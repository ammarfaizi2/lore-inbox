Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRCGAiN>; Tue, 6 Mar 2001 19:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRCGAhy>; Tue, 6 Mar 2001 19:37:54 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:23548 "EHLO
	tytlal.z.streaker.org") by vger.kernel.org with ESMTP
	id <S129737AbRCGAhr>; Tue, 6 Mar 2001 19:37:47 -0500
Date: Tue, 6 Mar 2001 16:34:21 -0800
From: Chip Salzenberg <chip@valinux.com>
To: Camm Maguire <camm@enhanced.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.2.18 IDE tape problem, with ide-scsi
Message-ID: <20010306163421.C21468@valinux.com>
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com>; from camm@enhanced.com on Tue, Feb 27, 2001 at 11:06:34AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With Andre's IDE subsystem, I found the below patch necessary to use
my IDE tape drive (Exabyte Eagle TR-4).  Frankly, it's been so long
since I created this patch that I can't remember the detailed reasons
for the changes.  But I knew them once.  :-)  And it works for me.

Reminder, this is against Andre Hedrick's 2.2 IDE subsystem.

Index: drivers/block/ide-tape.c
--- drivers/block/ide-tape.c.prev
+++ drivers/block/ide-tape.c	Tue Dec  5 01:17:32 2000
@@ -3096,7 +3096,10 @@ static int idetape_queue_pc_tail (ide_dr
 static int idetape_flush_tape_buffers (ide_drive_t *drive)
 {
+	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t pc;
 	int rc;
 
+	if (tape->chrdev_direction != idetape_direction_write)
+		return 0;
 	idetape_create_write_filemark_cmd(drive, &pc, 0);
 	if ((rc = idetape_queue_pc_tail (drive,&pc)))
@@ -5199,12 +5202,15 @@ static int idetape_chrdev_open (struct i
 	if (tape->chrdev_direction == idetape_direction_none) {
 		MOD_INC_USE_COUNT;
+		if (tape->onstream) {
 #if ONSTREAM_DEBUG
-		if (tape->debug_level >= 6)
-			printk(KERN_INFO "ide-tape: MOD_INC_USE_COUNT in idetape_chrdev_open-2\n");
+			if (tape->debug_level >= 6)
+				printk(KERN_INFO "ide-tape: MOD_INC_USE_COUNT"
+				       " in idetape_chrdev_open-2\n");
 #endif
-		idetape_create_prevent_cmd(drive, &pc, 1);
-		if (!idetape_queue_pc_tail (drive,&pc)) {
-			if (tape->door_locked != DOOR_EXPLICITLY_LOCKED)
-				tape->door_locked = DOOR_LOCKED;
+			idetape_create_prevent_cmd(drive, &pc, 1);
+			if (!idetape_queue_pc_tail (drive,&pc)) {
+				if (tape->door_locked != DOOR_EXPLICITLY_LOCKED)
+					tape->door_locked = DOOR_LOCKED;
+			}
 		}
 		idetape_analyze_headers(drive);
@@ -5258,14 +5264,17 @@ static int idetape_chrdev_release (struc
 		(void) idetape_rewind_tape (drive);
 	if (tape->chrdev_direction == idetape_direction_none) {
-		if (tape->door_locked != DOOR_EXPLICITLY_LOCKED) {
-			idetape_create_prevent_cmd(drive, &pc, 0);
-			if (!idetape_queue_pc_tail (drive,&pc))
-				tape->door_locked = DOOR_UNLOCKED;
-		}
-		MOD_DEC_USE_COUNT;
+		if (tape->onstream) {
+			if (tape->door_locked != DOOR_EXPLICITLY_LOCKED) {
+				idetape_create_prevent_cmd(drive, &pc, 0);
+				if (!idetape_queue_pc_tail (drive,&pc))
+					tape->door_locked = DOOR_UNLOCKED;
+			}
 #if ONSTREAM_DEBUG
-		if (tape->debug_level >= 6)
-			printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_chrdev_release\n");
+			if (tape->debug_level >= 6)
+				printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT"
+				       " in idetape_chrdev_release\n");
 #endif
+		}
+		MOD_DEC_USE_COUNT;
 	}
 	clear_bit (IDETAPE_BUSY, &tape->flags);

-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
