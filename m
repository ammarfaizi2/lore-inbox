Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVCCIOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVCCIOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVCCIOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:14:41 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:29354 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261574AbVCCIOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:14:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oQW9+nR4785NV2QpENPvrUVjja73aGvRZUaRciFjzx5U2p5xF+UGHZUAK9a7hkU0Abyfpg5WJlRp48cRIiZpJM8fgApnW1LIKDsE7HdWOFswgtLXJf8dmq3nHx1oCeiF8ACvphTH0zWgs3pyCrwy7koXlYubHcBAOepxqicuU7Q=
Message-ID: <58cb370e05030300145c554abe@mail.gmail.com>
Date: Thu, 3 Mar 2005 09:14:03 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH ide-dev-2.6] ide: ide_dma_intr oops fix
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <20050303080519.GE19505@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050303030318.GA25410@htj.dyndns.org>
	 <20050303064925.GB19505@suse.de> <4226B54E.6020709@gmail.com>
	 <58cb370e050303000478119a22@mail.gmail.com>
	 <20050303080519.GE19505@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005 09:05:19 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Mar 03 2005, Bartlomiej Zolnierkiewicz wrote:
> > On Thu, 03 Mar 2005 15:57:18 +0900, Tejun Heo <htejun@gmail.com> wrote:
> > >   Hello, Jens.
> > >
> > > Jens Axboe wrote:
> > > > On Thu, Mar 03 2005, Tejun Heo wrote:
> > > >
> > > >> Hello, Bartlomiej.
> > > >>
> > > >> This patch fixes ide_dma_intr() oops which occurs for TASKFILE ioctl
> > > >>using DMA dataphses.  This is against the latest ide-dev-2.6 tree +
> > > >>all your recent 9 patches.
> > > >>
> > > >> Signed-off-by: Tejun Heo <htejun@gmail.com>
> > > >>
> > > >>Index: linux-taskfile-ng/drivers/ide/ide-dma.c
> > > >>===================================================================
> > > >>--- linux-taskfile-ng.orig/drivers/ide/ide-dma.c      2005-03-03 11:59:16.485582413 +0900
> > > >>+++ linux-taskfile-ng/drivers/ide/ide-dma.c   2005-03-03 12:00:07.753376048 +0900
> > > >>@@ -175,10 +175,14 @@ ide_startstop_t ide_dma_intr (ide_drive_
> > > >>      if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
> > > >>              if (!dma_stat) {
> > > >>                      struct request *rq = HWGROUP(drive)->rq;
> > > >>-                     ide_driver_t *drv;
> > > >>
> > > >>-                     drv = *(ide_driver_t **)rq->rq_disk->private_data;;
> > > >>-                     drv->end_request(drive, 1, rq->nr_sectors);
> > > >>+                     if (rq->rq_disk) {
> > > >>+                             ide_driver_t *drv;
> > > >>+
> > > >>+                             drv = *(ide_driver_t **)rq->rq_disk->private_data;;
> > > >>+                             drv->end_request(drive, 1, rq->nr_sectors);
> > > >>+                     } else
> > > >>+                             ide_end_request(drive, 1, rq->nr_sectors);
> > > >>                      return ide_stopped;
> > > >>              }
> > > >>              printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
> > > >
> > > > Why not just set rq_disk for taskfile requests as well, seems a lot
> > > > cleaner than special casing the end_request handling.
> > >
> > >   Just because other places were fixed this way and the whole drive
> > > command issue/completion codes are just about to be restructured.  Above
> > > code will go away soon.  Please consider it a quick fix.
> > >
> > >   Thanks.
> >
> > Because struct gendisk is now allocated by device drivers (like in SCSI
> > subsystem) rq_disk can't be set for REQ_DRIVE_TASKFILE requests
> > (for some requests it can be set but better to keep it consistent).
> 
> Seems cleaner to store the driver in the drive structure then, no
> special casing needed.

This can't be done *correctly* with driver model support, that is why SCSI
does the same trick.  There were three incremental patch series, all sent
to linux-{ide,kernel} (all patches except the final one are now in ide-dev-2.6),
to convert IDE device drivers to driver model.
