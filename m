Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129302AbRBSM6a>; Mon, 19 Feb 2001 07:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129233AbRBSM6L>; Mon, 19 Feb 2001 07:58:11 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:35092 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129143AbRBSM6D>; Mon, 19 Feb 2001 07:58:03 -0500
Date: Mon, 19 Feb 2001 14:09:09 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.1-ac16: add CDROM_LOCKDOOR ioctl to IDE floppies
Message-ID: <Pine.LNX.4.21.0102191406060.884-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch below. It Work For Me(tm) with an IDE ZIP drive.

--- drivers/ide/ide-floppy.c.old        Mon Feb 19 13:39:55 2001
+++ drivers/ide/ide-floppy.c    Mon Feb 19 13:48:53 2001
@@ -1517,15 +1517,21 @@
                                 unsigned int cmd, unsigned long arg)
 {
        idefloppy_pc_t pc;
+       int prevent = (arg) ? 1 : 0;

        switch (cmd) {
        case CDROMEJECT:
+               prevent = 0;
+               /* fall through */
+       case CDROM_LOCKDOOR:
                if (drive->usage > 1)
                        return -EBUSY;
-               idefloppy_create_prevent_cmd (&pc, 0);
-               (void) idefloppy_queue_pc_tail (drive, &pc);
-               idefloppy_create_start_stop_cmd (&pc, 2);
+               idefloppy_create_prevent_cmd (&pc, prevent);
                (void) idefloppy_queue_pc_tail (drive, &pc);
+               if (cmd == CDROMEJECT) {
+                       idefloppy_create_start_stop_cmd (&pc, 2);
+                       (void) idefloppy_queue_pc_tail (drive, &pc);
+               }
                return 0;
        case IDEFLOPPY_IOCTL_FORMAT_SUPPORTED:
                return (0);


-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

