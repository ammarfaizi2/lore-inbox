Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161199AbWALTYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbWALTYF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWALTYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:24:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161199AbWALTYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:24:04 -0500
Date: Thu, 12 Jan 2006 11:23:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.15-$SHA1: VT <-> X sometimes odd
In-Reply-To: <20060112192856.GA7938@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.64.0601121119100.3535@g5.osdl.org>
References: <20060110162305.GA7886@mipter.zuzino.mipt.ru> <43C4F114.9070308@gmail.com>
 <20060111153822.GA7879@mipter.zuzino.mipt.ru> <20060112192856.GA7938@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Jan 2006, Alexey Dobriyan wrote:
> 
> Now it's vim saving 5k proggie while X tarball was unpacking on reiserfs.
> :wq and vim freezes. Switching to another virtual "desktops" works and
> everything in general works except vim. But switching to VT and back
> sends system to hell.

This may be fixed by the current -git tree:

	commit 1bc691d3, Tejun Heo <htejun@gmail.com>:

	[PATCH] fix queue stalling while barrier sequencing

or if that isn't it, and you have an IDE drive, can you try if the 
appended trivial patch makes a difference?

			Linus

---
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index bcbaeb5..d726167 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -101,7 +101,7 @@ int __ide_end_request(ide_drive_t *drive
 	 * for those
 	 */
 	nbytes = nr_sectors << 9;
-	if (!rq->errors && rq_all_done(rq, nbytes)) {
+	if (0 && !rq->errors && rq_all_done(rq, nbytes)) {
 		rq->data_len = nbytes;
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
