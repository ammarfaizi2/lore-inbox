Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTLVO26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 09:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTLVO26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 09:28:58 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:63501 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264326AbTLVO24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 09:28:56 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: elgaard@agol.dk, linux-kernel@vger.kernel.org
Subject: Re: Problem loopmounting CD on 2.6.0
References: <3FE2F8D4.1030903@agol.dk>
	<20031219140029.346f2523.rddunlap@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 22 Dec 2003 23:27:09 +0900
In-Reply-To: <20031219140029.346f2523.rddunlap@osdl.org>
Message-ID: <873cbdrkqq.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> On Fri, 19 Dec 2003 14:10:44 +0100 Niels Elgaard Larsen <elgaard@agol.dk> wrote:
> 
> | A similar (probably the same) problem have been reported for cryptoloop.
> | With a ISO9660 CD (actually Knoppix) in drive /dev/hdc, no SCSI emulation:
> | 
> | amigos20:/mnt# losetup /dev/loop5 /dev/hdc
> | amigos20:/mnt# mount -r /dev/loop5 /mnt/foo
> | 
> | Gives kernel output:
> | 
> | ===
> | hdc: cdrom_read_intr: data underrun (2 blocks)
> | end_request: I/O error, dev hdc, sector 64
> | isofs_fill_super: bread failed, dev=loop5, iso_blknum=16, block=32
> | ===
> | 
> | It works in 2.4.20
> | 
> | Also
> | 
> | dd if=/dev/hdc of=/tmp/foo
> | losetup /dev/loop5 /tmp/foo
> | mount -r /dev/loop5 /mnt/foo
> | 
> | works
> 
> I see differing sector size and block size reports by blockdev
> as follows.  Is this OK/expected or does it hint at a problem?

Probably we need to set the hardsect_size of real device to loop.
At least, it seems this problem was fixed.

What do you think of the following patch?

 drivers/block/loop.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/block/loop.c~loop-fix-hardsect_size drivers/block/loop.c
--- linux-2.6.0/drivers/block/loop.c~loop-fix-hardsect_size	2003-12-22 22:36:50.000000000 +0900
+++ linux-2.6.0-hirofumi/drivers/block/loop.c	2003-12-22 22:37:19.000000000 +0900
@@ -752,6 +752,7 @@ static int loop_set_fd(struct loop_devic
 		blk_queue_max_sectors(lo->lo_queue, q->max_sectors);
 		blk_queue_max_phys_segments(lo->lo_queue,q->max_phys_segments);
 		blk_queue_max_hw_segments(lo->lo_queue, q->max_hw_segments);
+		blk_queue_hardsect_size(lo->lo_queue, queue_hardsect_size(q));
 		blk_queue_max_segment_size(lo->lo_queue, q->max_segment_size);
 		blk_queue_segment_boundary(lo->lo_queue, q->seg_boundary_mask);
 		blk_queue_merge_bvec(lo->lo_queue, q->merge_bvec_fn);

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
