Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUFVMRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUFVMRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUFVMRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:17:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21675 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263019AbUFVMRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:17:53 -0400
Date: Tue, 22 Jun 2004 14:17:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] idle ide disk on resume
Message-ID: <20040622121742.GA1937@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need this patch to survive suspend on my powerbook, if the drive is
sleeping when suspend is entered. Otherwise it freezes on resume when it
tries to read from the drive.

===== drivers/ide/ide-disk.c 1.86 vs edited =====
--- 1.86/drivers/ide/ide-disk.c	2004-06-05 22:15:29 +02:00
+++ edited/drivers/ide/ide-disk.c	2004-06-22 14:15:08 +02:00
@@ -1334,7 +1334,8 @@
 	idedisk_pm_flush_cache	= ide_pm_state_start_suspend,
 	idedisk_pm_standby,
 
-	idedisk_pm_restore_dma	= ide_pm_state_start_resume,
+	idedisk_pm_idle		= ide_pm_state_start_resume,
+	idedisk_pm_restore_dma,
 };
 
 static void idedisk_complete_power_step (ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
@@ -1349,6 +1350,9 @@
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) complete */
 		rq->pm->pm_step = ide_pm_state_completed;
 		break;
+	case idedisk_pm_idle:		/* resume step 1, idle drive */
+		rq->pm->pm_step = idedisk_pm_restore_dma;
+		break;
 	}
 }
 
@@ -1376,6 +1380,12 @@
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler	   = &task_no_data_intr;
+		return do_rw_taskfile(drive, args);
+
+	case idedisk_pm_idle:
+		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
+		args->command_type = IDE_DRIVE_TASK_NO_DATA;
+		args->handler = task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_restore_dma:	/* Resume step 1 (restore DMA) */

-- 
Jens Axboe

