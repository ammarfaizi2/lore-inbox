Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314629AbSD0WUp>; Sat, 27 Apr 2002 18:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314625AbSD0WUo>; Sat, 27 Apr 2002 18:20:44 -0400
Received: from gear.torque.net ([204.138.244.1]:19729 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S314624AbSD0WUl>;
	Sat, 27 Apr 2002 18:20:41 -0400
Message-ID: <3CCB22BB.BA6BDFF6@torque.net>
Date: Sat, 27 Apr 2002 18:14:19 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.10-dj1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de, Dave Jones <davej@suse.de>, linux-scsi@vger.kernel.org
Subject: [PATCH] ide-scsi 2.5.10-dj1 compilation failure 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> reported this
compile error in lk 2.5.10-dj1:
> ide-scsi.c:837: unknown field `abort' specified in initializer
> ide-scsi.c:837: warning: initialization from incompatible pointer type
> ide-scsi.c:838: unknown field `reset' specified in initializer
> ide-scsi.c:838: warning: initialization from incompatible pointer type

Below is a patch which attempts to do the right thing:
it wires up the scsi new eh handling and attempts to do
a device reset.

It has been tested and oopses in start_request() inside
ide.c when a device reset is issued :-) Since the previous
ide-scsi logic just ignored scsi error handling, it isn't
really a whole lot worse. There is a "fix me" at the
appropriate point.

Doug Gilbert

--- linux/drivers/scsi/ide-scsi.c	Sat Apr 27 14:52:08 2002
+++ linux/drivers/scsi/ide-scsi.c2510dj1hack	Sat Apr 27 17:36:07 2002
@@ -804,14 +804,20 @@
 	return 0;
 }
 
-int idescsi_abort (Scsi_Cmnd *cmd)
+/* try to do correct thing for scsi subsystem's new eh */
+int idescsi_device_reset (Scsi_Cmnd *cmd)
 {
-	return SCSI_ABORT_SNOOZE;
-}
+	ide_drive_t *drive = idescsi_drives[cmd->target];
+        struct request req;
 
-int idescsi_reset (Scsi_Cmnd *cmd, unsigned int resetflags)
-{
-	return SCSI_RESET_SUCCESS;
+        ide_init_drive_cmd(&req);
+        req.flags = REQ_SPECIAL;
+/* FIX ME, the next executable line causes on oops in lk 2.5.10-dj1
+ * [code copied from ide-cd's ide_cdrom_reset(), does it work?]
+ */
+        ide_do_drive_cmd(drive, &req, ide_wait);
+
+	return SUCCESS;
 }
 
 int idescsi_bios (Disk *disk, kdev_t dev, int *parm)
@@ -834,8 +840,8 @@
 	info:		idescsi_info,
 	ioctl:		idescsi_ioctl,
 	queuecommand:	idescsi_queue,
-	abort:		idescsi_abort,
-	reset:		idescsi_reset,
+	eh_device_reset_handler: 
+			idescsi_device_reset,
 	bios_param:	idescsi_bios,
 	can_queue:	10,
 	this_id:	-1,

