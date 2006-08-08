Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWHHNvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWHHNvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWHHNvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:51:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:1238 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932590AbWHHNvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:51:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Date: Tue, 8 Aug 2006 15:50:35 +0200
User-Agent: KMail/1.9.3
Cc: Jiri Slaby <jirislaby@gmail.com>, Jason Lunz <lunz@gehennom.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-ide@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608081316.00749.rjw@sisk.pl> <20060808111925.GO4025@suse.de>
In-Reply-To: <20060808111925.GO4025@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081550.36054.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 13:19, Jens Axboe wrote:
> On Tue, Aug 08 2006, Rafael J. Wysocki wrote:
> > On Tuesday 08 August 2006 13:07, Jens Axboe wrote:
> > > On Tue, Aug 08 2006, Jens Axboe wrote:
> > > > On Tue, Aug 08 2006, Rafael J. Wysocki wrote:
> > > > > On Tuesday 08 August 2006 12:43, Jens Axboe wrote:
> > > > > > On Tue, Aug 08 2006, Jiri Slaby wrote:
> > > > > > > Rafael J. Wysocki wrote:
> > > > > > > >On Monday 07 August 2006 18:23, Jason Lunz wrote:
> > > > > > > >>In gmane.linux.kernel, you wrote:
> > > > > > > >>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> > > > > > > >>>I tried it and guess what :)... swsusp doesn't work :@.
> > > > > > > >>>
> > > > > > > >>>This time I was able to dump process states with sysrq-t:
> > > > > > > >>>http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
> > > > > > > >>>
> > > > > > > >>>My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel 
> > > > > > > >>>prints is suspending device 2.0
> > > > > > > >>Does it go away if you revert this?
> > > > > > > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
> > > > > > > >>
> > > > > > > >>That should only affect resume, not suspend, but it does mess around
> > > > > > > >>with ide power management. Is this maybe happening on the *second*
> > > > > > > >>suspend?
> > > > > > > >>
> > > > > > > >>>-hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> > > > > > > >>>+hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> > > > > > > >>This looks suspicious. -mm does have several ide-fix-hpt3xx patches.
> > > > > > > >
> > > > > > > >I found that git-block.patch broke the suspend for me.  Still have no idea
> > > > > > > >what's up with it.
> > > > > > > 
> > > > > > > I suspect elevator changes. The wait_for_completion is not woken in
> > > > > > > ide-io by ll_rw_blk. But I don't understand block layer too much.
> > > > > > 
> > > > > > The ide changes are far more likely, it's probably missing a completion.
> > > > > 
> > > > > Actually I think the commit f74bf2e6b415588e562fdcfdd454d587eb33cd46
> > > > > (Remove ->waiting member from struct request) is wrong, because
> > > > > generic_ide_suspend() uses the end_of_io member of rq to pass the PM data
> > > > > to ide_do_drive_cmd() where the pointer gets overwritten by &wait (must_wait
> > > > > is "true", because action == ide_wait).  Previously &wait was stored in
> > > > > rq->waiting and it didn't overwrite the PM data.
> > > > 
> > > > Indeed, that looks broken now. That must be what is screwing it up. With
> > > > the former patch applied, did cdrom detection still look funny to you?
> > 
> > Hm, I'm not sure what you mean ...
> 
> -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)

Ah, that.

> But perhaps that wasn't you?

No, that wasn't me. :-)

> > > > I'll concoct a fix for that breakage.
> > > 
> > > Something like this.
> > 
> > Looks good, I'll give it a try.
> 
> Thanks!

It fixes this particular issue for me, but your first patch (appended) is also
needed to prevent the box from hanging later during the resume (when it
tries to save the image).

Thanks,
Rafael


--
 drivers/ide/ide-io.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc3-mm2/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/ide/ide-io.c
+++ linux-2.6.18-rc3-mm2/drivers/ide/ide-io.c
@@ -402,7 +402,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			args[5] = hwif->INB(IDE_HCYL_REG);
 			args[6] = hwif->INB(IDE_SELECT_REG);
 		}
-	} else if (rq->cmd_type & REQ_TYPE_ATA_TASKFILE) {
+	} else if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args = (ide_task_t *) rq->special;
 		if (rq->errors == 0)
 			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
