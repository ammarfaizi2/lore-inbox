Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTLBSiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTLBSiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:38:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:22694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263185AbTLBSiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:38:09 -0500
Date: Tue, 2 Dec 2003 10:37:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: ross.alexander@uk.neceur.com
cc: Ed Sweetman <ed.sweetman@wmich.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: IDE-SCSI oops in 2.6.0-test11
In-Reply-To: <OFCDE312E0.4BD86A49-ON80256DF0.004D17F7-80256DF0.004DA592@uk.neceur.com>
Message-ID: <Pine.LNX.4.58.0312021028590.1519@home.osdl.org>
References: <OFCDE312E0.4BD86A49-ON80256DF0.004D17F7-80256DF0.004DA592@uk.neceur.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003 ross.alexander@uk.neceur.com wrote:
>
> I can't get the source, otherwise I would have compiled it against
> 2.6.0.  However I don't find this point particularly relevant since
> 2.6.0 should be backward compatible with 2.4,0, atleast at the binary
> level.
>
> I tried the earlier versions of dvdrtools and cdrtools and their didn't
> like ide-cd.  This version (cdrecord-dvdpro) does but it still don't
> alter the fact that while using ide-scsi is no longer recommended, it
> still should work.

Well, we're trying, but nobody has had a lot of luck with it.

However, your particular case looks pretty straightforward:

> Here the the oops again.
>
> Dec  2 12:02:46 mig27 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
> Dec  2 12:02:46 mig27 kernel:  printing eip:
> Dec  2 12:02:46 mig27 kernel: 00000000

Somebody jumped through a NULL pointer, and it was:

> Dec  2 12:02:46 mig27 kernel: Process cdrecord-prodvd (pid: 369,  threadinfo=e4160000 task=f65d4100)
> Dec  2 12:02:46 mig27 kernel: Call Trace:
> Dec  2 12:02:46 mig27 kernel:  [<f9859b1b>]  idescsi_transfer_pc+0x11b/0x120 [ide_scsi]

That's the code that does:

	...
        if (test_bit (PC_DMA_OK, &pc->flags)) {
                set_bit (PC_DMA_IN_PROGRESS, &pc->flags);
                (void) (HWIF(drive)->ide_dma_begin(drive));
        }
	...

and it looks like the PC_DMA_OK flag is incorrect.

Doing a bit more digging shows that "idescsi_issue_pc()" seems to use some
variables without ever actually _initializing_ them. How about this
trivial one-liner? Does that make it work for you?

Jens? Comments?

			Linus

---
===== drivers/scsi/ide-scsi.c 1.33 vs edited =====
--- 1.33/drivers/scsi/ide-scsi.c	Tue Nov 18 23:40:45 2003
+++ edited/drivers/scsi/ide-scsi.c	Tue Dec  2 10:36:33 2003
@@ -516,6 +516,7 @@
 	pc->actually_transferred=0;					/* We haven't transferred any data yet */
 	pc->current_position=pc->buffer;
 	bcount.all = IDE_MIN(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
+	feature.all = 0;

 	if (drive->using_dma && rq->bio) {
 		if (test_bit(PC_WRITING, &pc->flags))
