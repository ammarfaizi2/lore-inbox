Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVHBKsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVHBKsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVHBKsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:48:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36559 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261481AbVHBKq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:46:56 -0400
Date: Tue, 2 Aug 2005 12:48:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Crash in ide_do_request() on card removal
Message-ID: <20050802104859.GG22569@suse.de>
References: <42EA1AB0.6070001@imc-berlin.de> <42EF439C.5000903@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EF439C.5000903@imc-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02 2005, Steven Scholz wrote:
> Steven Scholz wrote:
> 
> >Hi there,
> >
> >when surprisingly removing a CF ATA card (without unmounting before) I 
> >sometimes get kernel crashes in ide_do_request() (linux-2.6.13-rc4 on ARM):
> >
> >cardmgr[194]: shutting down socket 0
> >cardmgr[194]: executing: './ide stop hda'
> >cardmgr[194]: + umount -v /dev/hda1
> >Assertion '(hwgroup->drive)' failed in 
> >drivers/ide/ide-io.c:ide_do_request(1130)
> >Assertion '(drive)' failed in drivers/ide/ide-io.c:choose_drive(1035)
> >Unable to handle kernel NULL pointer dereference at virtual address 
> >00000010
> >pgd = c0e34000
> >[00000010] *pgd=20eb0031, *pte=00000000, *ppte=00000000
> >Internal error: Oops: 17 [#1]
> >Modules linked in: ide_cs pcmcia at91_cf pcmcia_core
> >CPU: 0
> >PC is at ide_do_request+0x100/0x480
> >LR is at 0x1
> >pc : [<c00f9980>]    lr : [<00000001>]    Not tainted
> >...
> >
> >As the assertions show "drive" is NULL (due to the card removal?) and 
> >thus the kernel crashes ...
> >
> >Upon card removal the pcmcia cardmgr tries to unmount the drive which 
> >disapeared.
> >
> >("sometimes" above means that the rest of the time the kernel is not 
> >dumping core, but the umount process hangs forever.)
> 
> (I think) I found the reason for this behaviour:
> 
> Upon card removal the functions
> 
> ~ # cardctl eject
> ide_release(398)
> ide_unregister(585): index=0
> blk_unregister_queue(3603)
> elv_unregister_queue(549)
> ide_unregister(698)
> ide_detach(164)
> 
> are called. Thus the request queue for the drive is discarded which is fair 
> enough. But disk->queue would still point to a (now invalid) 
> request_queue_t structure. Thus if I/O requests (e.g. "umount") are started 
> _after_ the drive was removed bad things can happen! So I think we should 
> explicitly remove the reference to that queue by doing
> 
> void blk_unregister_queue(struct gendisk *disk)
> {
> 	request_queue_t *q = disk->queue;
> 
> 	if (q && q->request_fn) {
> 		elv_unregister_queue(q);
> 		kobject_unregister(&q->kobj);
> +		disk->queue = NULL;
> 		kobject_put(&disk->kobj);
> 	}
> }

That's not quite true, q is not invalid after this call. It will only be
invalid when it is freed (which doesn't happen from here but rather from
the blk_cleanup_queue() call when the reference count drops to 0).

This is still not perfect, but a lot better. Does it work for you?

--- linux-2.6.12/drivers/ide/ide-disk.c~	2005-08-02 12:48:16.000000000 +0200
+++ linux-2.6.12/drivers/ide/ide-disk.c	2005-08-02 12:48:32.000000000 +0200
@@ -1054,6 +1054,7 @@
 	drive->driver_data = NULL;
 	drive->devfs_name[0] = '\0';
 	g->private_data = NULL;
+	g->disk = NULL;
 	put_disk(g);
 	kfree(idkp);
 }

-- 
Jens Axboe

