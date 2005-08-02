Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVHBKCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVHBKCa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVHBJ74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:59:56 -0400
Received: from mail.imc-berlin.de ([217.110.46.186]:12303 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S261468AbVHBJ5w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:57:52 -0400
Message-ID: <42EF439C.5000903@imc-berlin.de>
Date: Tue, 02 Aug 2005 11:57:48 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Crash in ide_do_request() on card removal
References: <42EA1AB0.6070001@imc-berlin.de>
In-Reply-To: <42EA1AB0.6070001@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Scholz wrote:

> Hi there,
> 
> when surprisingly removing a CF ATA card (without unmounting before) I 
> sometimes get kernel crashes in ide_do_request() (linux-2.6.13-rc4 on ARM):
> 
> cardmgr[194]: shutting down socket 0
> cardmgr[194]: executing: './ide stop hda'
> cardmgr[194]: + umount -v /dev/hda1
> Assertion '(hwgroup->drive)' failed in 
> drivers/ide/ide-io.c:ide_do_request(1130)
> Assertion '(drive)' failed in drivers/ide/ide-io.c:choose_drive(1035)
> Unable to handle kernel NULL pointer dereference at virtual address 
> 00000010
> pgd = c0e34000
> [00000010] *pgd=20eb0031, *pte=00000000, *ppte=00000000
> Internal error: Oops: 17 [#1]
> Modules linked in: ide_cs pcmcia at91_cf pcmcia_core
> CPU: 0
> PC is at ide_do_request+0x100/0x480
> LR is at 0x1
> pc : [<c00f9980>]    lr : [<00000001>]    Not tainted
> ...
> 
> As the assertions show "drive" is NULL (due to the card removal?) and 
> thus the kernel crashes ...
> 
> Upon card removal the pcmcia cardmgr tries to unmount the drive which 
> disapeared.
> 
> ("sometimes" above means that the rest of the time the kernel is not 
> dumping core, but the umount process hangs forever.)

(I think) I found the reason for this behaviour:

Upon card removal the functions

~ # cardctl eject
ide_release(398)
ide_unregister(585): index=0
blk_unregister_queue(3603)
elv_unregister_queue(549)
ide_unregister(698)
ide_detach(164)

are called. Thus the request queue for the drive is discarded which is fair 
enough. But disk->queue would still point to a (now invalid) request_queue_t 
structure. Thus if I/O requests (e.g. "umount") are started _after_ the drive 
was removed bad things can happen! So I think we should explicitly remove the 
reference to that queue by doing

void blk_unregister_queue(struct gendisk *disk)
{
	request_queue_t *q = disk->queue;

	if (q && q->request_fn) {
		elv_unregister_queue(q);
		kobject_unregister(&q->kobj);
+		disk->queue = NULL;
		kobject_put(&disk->kobj);
	}
}

in drivers/block/ll_rw_blk.c

Then instead of a crash or hang one would get

~ # umount /mnt/pcmcia/
...
generic_shutdown_super(249) calling sop->put_super @ c00ac734
fat_clusters_flush(49)
generic_make_request: Trying to access nonexistent block-device hda1 (1)
FAT: bread failed in fat_clusters_flush

Thanks a million.

--
Steven








