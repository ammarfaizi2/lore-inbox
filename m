Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267920AbTBRSI4>; Tue, 18 Feb 2003 13:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267911AbTBRSIO>; Tue, 18 Feb 2003 13:08:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42761 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267915AbTBRSHm>; Tue, 18 Feb 2003 13:07:42 -0500
Subject: PATCH: resync externs, add execute command remove is_flashcard
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:18:03 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCJf-0006B7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(is_flashcard is unneeded outside ide_probe as we have a drive->flash check)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/linux/ide.h linux-2.5.61-ac2/include/linux/ide.h
--- linux-2.5.61/include/linux/ide.h	2003-02-10 18:38:20.000000000 +0000
+++ linux-2.5.61-ac2/include/linux/ide.h	2003-02-18 18:02:56.000000000 +0000
@@ -1131,12 +1115,13 @@
 	struct ide_settings_s	*next;
 } ide_settings_t;
 
-void ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set);
-void ide_remove_setting(ide_drive_t *drive, char *name);
-ide_settings_t *ide_find_setting_by_name(ide_drive_t *drive, char *name);
-int ide_read_setting(ide_drive_t *t, ide_settings_t *setting);
-int ide_write_setting(ide_drive_t *drive, ide_settings_t *setting, int val);
-void ide_add_generic_settings(ide_drive_t *drive);
+extern struct semaphore ide_setting_sem;
+extern int ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set);
+extern void ide_remove_setting(ide_drive_t *drive, char *name);
+extern ide_settings_t *ide_find_setting_by_name(ide_drive_t *drive, char *name);
+extern int ide_read_setting(ide_drive_t *t, ide_settings_t *setting);
+extern int ide_write_setting(ide_drive_t *drive, ide_settings_t *setting, int val);
+extern void ide_add_generic_settings(ide_drive_t *drive);
 
 /*
  * /proc/ide interface
@@ -1270,12 +1255,19 @@
 extern int ide_end_request (ide_drive_t *drive, int uptodate, int nrsecs);
 
 /*
- * This is used on exit from the driver, to designate the next irq handler
+ * This is used on exit from the driver to designate the next irq handler
  * and also to start the safety timer.
  */
 extern void ide_set_handler (ide_drive_t *drive, ide_handler_t *handler, unsigned int timeout, ide_expiry_t *expiry);
 
 /*
+ * This is used on exit from the driver to designate the next irq handler
+ * and start the safety time safely and atomically from the IRQ handler
+ * with respect to the command issue (which it also does)
+ */
+extern void ide_execute_command(ide_drive_t *, task_ioreg_t cmd, ide_handler_t *, unsigned int, ide_expiry_t *);
+
+/*
  * Error reporting, in human readable form (luxurious, but a memory hog).
  *
  * (drive, msg, status)
@@ -1577,14 +1569,6 @@
  */
 extern void ide_stall_queue(ide_drive_t *drive, unsigned long timeout);
 
-/*
- * CompactFlash cards and their brethern pretend to be removable hard disks,
- * but they never have a slave unit, and they don't have doorlock mechanisms.
- * This test catches them, and is invoked elsewhere when setting appropriate
- * config bits.
- */
-extern int drive_is_flashcard (ide_drive_t *drive);
-
 extern int ide_spin_wait_hwgroup(ide_drive_t *);
 extern void ide_timer_expiry(unsigned long);
 extern void ide_intr(int irq, void *dev_id, struct pt_regs *regs);
