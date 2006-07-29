Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWG2Xeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWG2Xeh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWG2Xeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:34:37 -0400
Received: from smtp.reflexsecurity.com ([72.54.64.74]:24228 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S1750767AbWG2Xeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:34:37 -0400
Date: Sat, 29 Jul 2006 19:34:16 -0400
From: Jason Lunz <lunz@falooley.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: "Rafael J\. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Vojtech Pavlik <vojtech@suse.cz>, Brad Campbell <brad@wasp.net.au>,
       David Brownell <david-b@pacbell.net>
Subject: [patch, rft] ide: reprogram disk pio timings on resume
Message-ID: <20060729233416.GA6346@opus.vpn-dev.reflex>
References: <200607281646.31207.rjw@sisk.pl> <1154105517.13509.153.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154105517.13509.153.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a step to the IDE PM state machine that reprograms disk PIO timings
as the first step on resume. This prevents ide deadlock on
resume-from-ram on my nforce3-based laptop.

An earlier implementation was written entirely within the amd74xx ide
driver, but Alan helpfully pointed out that this is the correct thing to
do globally. Still, I'm only calling hwif->tuneproc() for disks, based
on two things:

 - The existing state machine is already passed over for non-disk drives
 - Previous testing on my laptop shows that the hangs are related only
   to the disk - suspend/resume from a livecd showed that there's no
   need for this on the cdrom.

Signed-off-by: Jason Lunz <lunz@falooley.org>

---

Alan: I'm doing tuneproc() before WIN_IDLEIMMEDIATE as you said. It
works. I'd otherwise have done it after, based solely on the name -
thanks for the suggestion.

David, Rafael: It would be helpful if you could verify that this patch
cures your ide-relate hangs on s2ram as well (with my previous patch to
amd74xx unapplied). 

Brad: thanks for volunteering to test! You'll be the lucky first person
to try this on a non-nforce ide chipset. good luck.

Please be careful - I know next to nothing about IDE; I just know that
this make s2ram work on my laptop. This patch means altering ide resume
for all systems where it currently works already. I suppose there could
be regressions.

 drivers/ide/ide-io.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

Index: linux-2.6.18-rc2-git6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.18-rc2-git6.orig/drivers/ide/ide-io.c
+++ linux-2.6.18-rc2-git6/drivers/ide/ide-io.c
@@ -135,7 +135,8 @@
 	ide_pm_flush_cache	= ide_pm_state_start_suspend,
 	idedisk_pm_standby,
 
-	idedisk_pm_idle		= ide_pm_state_start_resume,
+	idedisk_pm_restore_pio	= ide_pm_state_start_resume,
+	idedisk_pm_idle,
 	ide_pm_restore_dma,
 };
 
@@ -156,7 +157,10 @@
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) complete */
 		pm->pm_step = ide_pm_state_completed;
 		break;
-	case idedisk_pm_idle:		/* Resume step 1 (idle) complete */
+	case idedisk_pm_restore_pio:	/* Resume step 1 complete */
+		pm->pm_step = idedisk_pm_idle;
+		break;
+	case idedisk_pm_idle:		/* Resume step 2 (idle) complete */
 		pm->pm_step = ide_pm_restore_dma;
 		break;
 	}
@@ -170,8 +174,11 @@
 	memset(args, 0, sizeof(*args));
 
 	if (drive->media != ide_disk) {
-		/* skip idedisk_pm_idle for ATAPI devices */
-		if (pm->pm_step == idedisk_pm_idle)
+		/*
+		 * skip idedisk_pm_restore_pio and idedisk_pm_idle for ATAPI
+		 * devices
+		 */
+		if (pm->pm_step == idedisk_pm_restore_pio)
 			pm->pm_step = ide_pm_restore_dma;
 	}
 
@@ -198,13 +205,19 @@
 		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
-	case idedisk_pm_idle:		/* Resume step 1 (idle) */
+	case idedisk_pm_restore_pio:	/* Resume step 1 (restore PIO) */
+		if (drive->hwif->tuneproc != NULL)
+			drive->hwif->tuneproc(drive, 255);
+		ide_complete_power_step(drive, rq, 0, 0);
+		return ide_stopped;
+
+	case idedisk_pm_idle:		/* Resume step 2 (idle) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler = task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
-	case ide_pm_restore_dma:	/* Resume step 2 (restore DMA) */
+	case ide_pm_restore_dma:	/* Resume step 3 (restore DMA) */
 		/*
 		 * Right now, all we do is call hwif->ide_dma_check(drive),
 		 * we could be smarter and check for current xfer_speed
