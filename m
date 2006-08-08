Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWHHLGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWHHLGV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWHHLGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:06:21 -0400
Received: from brick.kernel.dk ([62.242.22.158]:34315 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S964833AbWHHLGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:06:19 -0400
Date: Tue, 8 Aug 2006 13:07:26 +0200
From: Jens Axboe <axboe@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Slaby <jirislaby@gmail.com>, Jason Lunz <lunz@gehennom.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-ide@vger.kernel.org
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Message-ID: <20060808110726.GN4025@suse.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D8626F.4020101@gmail.com> <20060808104353.GK4025@suse.de> <200608081259.15966.rjw@sisk.pl> <20060808110447.GM4025@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808110447.GM4025@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2006, Jens Axboe wrote:
> On Tue, Aug 08 2006, Rafael J. Wysocki wrote:
> > On Tuesday 08 August 2006 12:43, Jens Axboe wrote:
> > > On Tue, Aug 08 2006, Jiri Slaby wrote:
> > > > Rafael J. Wysocki wrote:
> > > > >On Monday 07 August 2006 18:23, Jason Lunz wrote:
> > > > >>In gmane.linux.kernel, you wrote:
> > > > >>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> > > > >>>I tried it and guess what :)... swsusp doesn't work :@.
> > > > >>>
> > > > >>>This time I was able to dump process states with sysrq-t:
> > > > >>>http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
> > > > >>>
> > > > >>>My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel 
> > > > >>>prints is suspending device 2.0
> > > > >>Does it go away if you revert this?
> > > > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
> > > > >>
> > > > >>That should only affect resume, not suspend, but it does mess around
> > > > >>with ide power management. Is this maybe happening on the *second*
> > > > >>suspend?
> > > > >>
> > > > >>>-hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> > > > >>>+hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> > > > >>This looks suspicious. -mm does have several ide-fix-hpt3xx patches.
> > > > >
> > > > >I found that git-block.patch broke the suspend for me.  Still have no idea
> > > > >what's up with it.
> > > > 
> > > > I suspect elevator changes. The wait_for_completion is not woken in
> > > > ide-io by ll_rw_blk. But I don't understand block layer too much.
> > > 
> > > The ide changes are far more likely, it's probably missing a completion.
> > 
> > Actually I think the commit f74bf2e6b415588e562fdcfdd454d587eb33cd46
> > (Remove ->waiting member from struct request) is wrong, because
> > generic_ide_suspend() uses the end_of_io member of rq to pass the PM data
> > to ide_do_drive_cmd() where the pointer gets overwritten by &wait (must_wait
> > is "true", because action == ide_wait).  Previously &wait was stored in
> > rq->waiting and it didn't overwrite the PM data.
> 
> Indeed, that looks broken now. That must be what is screwing it up. With
> the former patch applied, did cdrom detection still look funny to you?
> 
> I'll concoct a fix for that breakage.

Something like this.

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index db647a9..38479a2 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -141,7 +141,7 @@ enum {
 
 static void ide_complete_power_step(ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
 {
-	struct request_pm_state *pm = rq->end_io_data;
+	struct request_pm_state *pm = rq->data;
 
 	if (drive->media != ide_disk)
 		return;
@@ -164,7 +164,7 @@ static void ide_complete_power_step(ide_
 
 static ide_startstop_t ide_start_power_step(ide_drive_t *drive, struct request *rq)
 {
-	struct request_pm_state *pm = rq->end_io_data;
+	struct request_pm_state *pm = rq->data;
 	ide_task_t *args = rq->special;
 
 	memset(args, 0, sizeof(*args));
@@ -421,7 +421,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			}
 		}
 	} else if (blk_pm_request(rq)) {
-		struct request_pm_state *pm = rq->end_io_data;
+		struct request_pm_state *pm = rq->data;
 #ifdef DEBUG_PM
 		printk("%s: complete_power_step(step: %d, stat: %x, err: %x)\n",
 			drive->name, rq->pm->pm_step, stat, err);
@@ -933,7 +933,7 @@ #endif
 
 static void ide_check_pm_state(ide_drive_t *drive, struct request *rq)
 {
-	struct request_pm_state *pm = rq->end_io_data;
+	struct request_pm_state *pm = rq->data;
 
 	if (blk_pm_suspend_request(rq) &&
 	    pm->pm_step == ide_pm_state_start_suspend)
@@ -1018,7 +1018,7 @@ #endif
 		    rq->cmd_type == REQ_TYPE_ATA_TASKFILE)
 			return execute_drive_cmd(drive, rq);
 		else if (blk_pm_request(rq)) {
-			struct request_pm_state *pm = rq->end_io_data;
+			struct request_pm_state *pm = rq->data;
 #ifdef DEBUG_PM
 			printk("%s: start_power_step(step: %d)\n",
 				drive->name, rq->pm->pm_step);
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index d7b4499..0fd1e1c 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1219,7 +1219,7 @@ static int generic_ide_suspend(struct de
 	memset(&args, 0, sizeof(args));
 	rq.cmd_type = REQ_TYPE_PM_SUSPEND;
 	rq.special = &args;
-	rq.end_io_data = &rqpm;
+	rq.data = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
 	rqpm.pm_state = state.event;
 
@@ -1238,7 +1238,7 @@ static int generic_ide_resume(struct dev
 	memset(&args, 0, sizeof(args));
 	rq.cmd_type = REQ_TYPE_PM_RESUME;
 	rq.special = &args;
-	rq.end_io_data = &rqpm;
+	rq.data = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_resume;
 	rqpm.pm_state = PM_EVENT_ON;
 

-- 
Jens Axboe

