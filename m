Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVBBTuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVBBTuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVBBTuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:50:24 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:27313 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262253AbVBBTsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:48:40 -0500
Date: Wed, 2 Feb 2005 20:47:31 +0100 (CET)
From: =?ISO-8859-15?Q?Peter_M=FCnster?= <pmlists@free.fr>
X-X-Sender: peter@gaston.free.fr
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net, axboe@suse.de, benh@kernel.crashing.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [Patch] keep ide disk sleeping when resuming
Message-ID: <Pine.LNX.4.58.0502022006030.4130@gaston.free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need this patch (against linux-2.6.11-rc2), to keep ide disk sleeping,
when resuming from ACPI S1.

In fact, it's just removing a patch from 22 Jun 2004 by Jens Axboe. He has
told me, that "We can probably kill the patch completely".
So, this is what I'm doing now.

Kind regards, Peter

--- drivers/ide/ide-disk.c.orig	2005-02-02 20:30:12.000000000 +0100
+++ drivers/ide/ide-disk.c	2005-02-02 20:32:21.000000000 +0100
@@ -864,9 +864,7 @@
 enum {
 	idedisk_pm_flush_cache	= ide_pm_state_start_suspend,
 	idedisk_pm_standby,
-
-	idedisk_pm_idle		= ide_pm_state_start_resume,
-	idedisk_pm_restore_dma,
+	idedisk_pm_restore_dma	= ide_pm_state_start_resume
 };
 
 static void idedisk_complete_power_step (ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
@@ -881,9 +879,6 @@
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) complete */
 		rq->pm->pm_step = ide_pm_state_completed;
 		break;
-	case idedisk_pm_idle:		/* Resume step 1 (idle) complete */
-		rq->pm->pm_step = idedisk_pm_restore_dma;
-		break;
 	}
 }
 
@@ -914,12 +909,6 @@
 		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
-	case idedisk_pm_idle:		/* Resume step 1 (idle) */
-		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler = task_no_data_intr;
-		return do_rw_taskfile(drive, args);
-
 	case idedisk_pm_restore_dma:	/* Resume step 2 (restore DMA) */
 		/*
 		 * Right now, all we do is call hwif->ide_dma_check(drive),

-- 
http://pmrb.free.fr/contact/
