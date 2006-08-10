Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161083AbWHJGeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbWHJGeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWHJGeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:34:17 -0400
Received: from brick.kernel.dk ([62.242.22.158]:63854 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161083AbWHJGeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:34:16 -0400
Date: Thu, 10 Aug 2006 08:35:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Message-ID: <20060810063532.GF11829@suse.de>
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net> <6bffcb0e0608090720g2ac739desd25a77e3c98ef268@mail.gmail.com> <6bffcb0e0608091544l376c37c6j5c766b38426c318b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0608091544l376c37c6j5c766b38426c318b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10 2006, Michal Piotrowski wrote:
> Hi,
> 
> On 09/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> >On 08/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> >> The mm snapshot broken-out-2006-08-08-00-59.tar.gz has been uploaded to
> >>
> >>    
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-08-00-59.tar.gz
> >>
> >
> >When I want to halt system I type "init 0", but it stops on
> >
> >Halting system...
> >Synchronizing SCSI cache for disk sda
> >Shutdown: hda
> >
> >Problem appears on 2.6.18-rc3-mm*. I guess that this is an IDE or ACPI bug.
> >I'll revert IDE and ACPI patches. If it won't help, I'll do binary search.
> 
> It's a git-block.patch
> 
> Jens, can you look at this?
> 
> Here is a config file
> http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm1/mm-config2

It's the already solved bug, I believe. The version referenced above
still has the fixed REQ_TYPE_ATA_TASKFILE and ->end_io_data for suspend
problem.

Let me know if it works or not with this applied.

diff -urp linux-2.6.18-rc3.virgin/drivers/ide/ide.c linux-2.6.18-rc3/drivers/ide/ide.c
--- linux-2.6.18-rc3.virgin/drivers/ide/ide.c	2006-08-10 08:32:18.000000000 +0200
+++ linux-2.6.18-rc3/drivers/ide/ide.c	2006-08-10 08:34:05.000000000 +0200
@@ -1223,7 +1223,7 @@ static int generic_ide_suspend(struct de
 	memset(&args, 0, sizeof(args));
 	rq.cmd_type = REQ_TYPE_PM_SUSPEND;
 	rq.special = &args;
-	rq.end_io_data = &rqpm;
+	rq.data = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
 	if (mesg.event == PM_EVENT_PRETHAW)
 		mesg.event = PM_EVENT_FREEZE;
@@ -1244,7 +1244,7 @@ static int generic_ide_resume(struct dev
 	memset(&args, 0, sizeof(args));
 	rq.cmd_type = REQ_TYPE_PM_RESUME;
 	rq.special = &args;
-	rq.end_io_data = &rqpm;
+	rq.data = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_resume;
 	rqpm.pm_state = PM_EVENT_ON;
 
diff -urp linux-2.6.18-rc3.virgin/drivers/ide/ide-io.c linux-2.6.18-rc3/drivers/ide/ide-io.c
--- linux-2.6.18-rc3.virgin/drivers/ide/ide-io.c	2006-08-10 08:32:18.000000000 +0200
+++ linux-2.6.18-rc3/drivers/ide/ide-io.c	2006-08-10 08:34:20.000000000 +0200
@@ -141,7 +141,7 @@ enum {
 
 static void ide_complete_power_step(ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
 {
-	struct request_pm_state *pm = rq->end_io_data;
+	struct request_pm_state *pm = rq->data;
 
 	if (drive->media != ide_disk)
 		return;
@@ -167,7 +167,7 @@ static void ide_complete_power_step(ide_
 
 static ide_startstop_t ide_start_power_step(ide_drive_t *drive, struct request *rq)
 {
-	struct request_pm_state *pm = rq->end_io_data;
+	struct request_pm_state *pm = rq->data;
 	ide_task_t *args = rq->special;
 
 	memset(args, 0, sizeof(*args));
@@ -402,7 +402,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			args[5] = hwif->INB(IDE_HCYL_REG);
 			args[6] = hwif->INB(IDE_SELECT_REG);
 		}
-	} else if (rq->cmd_type & REQ_TYPE_ATA_TASKFILE) {
+	} else if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args = (ide_task_t *) rq->special;
 		if (rq->errors == 0)
 			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
@@ -433,7 +433,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			}
 		}
 	} else if (blk_pm_request(rq)) {
-		struct request_pm_state *pm = rq->end_io_data;
+		struct request_pm_state *pm = rq->data;
 #ifdef DEBUG_PM
 		printk("%s: complete_power_step(step: %d, stat: %x, err: %x)\n",
 			drive->name, rq->pm->pm_step, stat, err);
@@ -945,7 +945,7 @@ done:
 
 static void ide_check_pm_state(ide_drive_t *drive, struct request *rq)
 {
-	struct request_pm_state *pm = rq->end_io_data;
+	struct request_pm_state *pm = rq->data;
 
 	if (blk_pm_suspend_request(rq) &&
 	    pm->pm_step == ide_pm_state_start_suspend)
@@ -1030,7 +1030,7 @@ static ide_startstop_t start_request (id
 		    rq->cmd_type == REQ_TYPE_ATA_TASKFILE)
 			return execute_drive_cmd(drive, rq);
 		else if (blk_pm_request(rq)) {
-			struct request_pm_state *pm = rq->end_io_data;
+			struct request_pm_state *pm = rq->data;
 #ifdef DEBUG_PM
 			printk("%s: start_power_step(step: %d)\n",
 				drive->name, rq->pm->pm_step);

-- 
Jens Axboe

