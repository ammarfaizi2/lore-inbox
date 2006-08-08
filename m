Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWHHIkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWHHIkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWHHIkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:40:09 -0400
Received: from brick.kernel.dk ([62.242.22.158]:5220 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932582AbWHHIkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:40:08 -0400
Date: Tue, 8 Aug 2006 10:41:16 +0200
From: Jens Axboe <axboe@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jason Lunz <lunz@gehennom.net>, Jiri Slaby <jirislaby@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-ide@vger.kernel.org
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Message-ID: <20060808084116.GF4025@suse.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com> <20060807162322.GA17564@knob.reflex> <200608072247.59184.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608072247.59184.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07 2006, Rafael J. Wysocki wrote:
> On Monday 07 August 2006 18:23, Jason Lunz wrote:
> > In gmane.linux.kernel, you wrote:
> > >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> > >
> > > I tried it and guess what :)... swsusp doesn't work :@.
> > >
> > > This time I was able to dump process states with sysrq-t:
> > > http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
> > >
> > > My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel prints is 
> > > suspending device 2.0
> > 
> > Does it go away if you revert this?
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
> > 
> > That should only affect resume, not suspend, but it does mess around
> > with ide power management. Is this maybe happening on the *second*
> > suspend?
> > 
> > > -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> > > +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> > 
> > This looks suspicious. -mm does have several ide-fix-hpt3xx patches.
> 
> I found that git-block.patch broke the suspend for me.  Still have no idea
> what's up with it.

Can you apply this on top of -mm and see if that fixes it?

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index d2339e9..db647a9 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -390,7 +390,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			args[5] = hwif->INB(IDE_HCYL_REG);
 			args[6] = hwif->INB(IDE_SELECT_REG);
 		}
-	} else if (rq->cmd_type & REQ_TYPE_ATA_TASKFILE) {
+	} else if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args = (ide_task_t *) rq->special;
 		if (rq->errors == 0)
 			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);

-- 
Jens Axboe

