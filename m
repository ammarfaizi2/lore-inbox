Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSKIADz>; Fri, 8 Nov 2002 19:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263319AbSKIADz>; Fri, 8 Nov 2002 19:03:55 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:40656 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263313AbSKIADx>; Fri, 8 Nov 2002 19:03:53 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Helge Hafting <helge.hafting@broadpark.no>
Date: Sat, 9 Nov 2002 11:10:12 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15820.21092.115557.979931@notabene.cse.unsw.edu.au>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: raid-0 BUG in 2.5.46-bk4
In-Reply-To: message from Helge Hafting on Friday November 8
References: <3DCC3D41.386DB98C@broadpark.no>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 8, helge.hafting@broadpark.no wrote:
> I installed 2.5.46-bk4 in order to try the new
> raid patches.  (I have raid-1 and raid-0
> on smp, scsi)
> 
> Raid-1 seems to work fine, but processes
> trying to use the raid-0 (/usr/src)
> either segfaults or gets stuck in D-state
> quickly.
...
> ------------[ cut here ]------------
> kernel BUG at drivers/block/ll_rw_blk.c:1949!
....
>  [<c016f1d6>] mpage_bio_submit+0x22/0x28
>  [<c016f4a7>] do_mpage_readpage+0x25b/0x390

Hmmm.  looks like raid0_mergeable_bvec is simply wrong,
(in my defense, I re-wrote it before having seen the caller...)

Below is a patch that might fix it (key part is removing addition
of biovec->bv_len, rest is changing 'K' to more sensible 'sectors'.

Jens:  It looks like the biovec arg to  ->merge_bvec_fn is
un-necessary.  Is that right or am I missing something?

NeilBrown


--- drivers/md/raid0.c	2002/11/09 00:04:57	1.1
+++ drivers/md/raid0.c	2002/11/09 00:06:46
@@ -174,14 +174,14 @@ static int raid0_mergeable_bvec(request_
 {
 	mddev_t *mddev = q->queuedata;
 	sector_t block;
-	unsigned int chunk_size;
-	unsigned int bio_sz;
+	unsigned int chunk_sectors;
+	unsigned int bio_sectors;
 
-	chunk_size = mddev->chunk_size >> 10;
-	block = bio->bi_sector >> 1;
-	bio_sz = (bio->bi_size + biovec->bv_len) >> 10;
+	chunk_sectors = mddev->chunk_size >> 9;
+	sector = bio->bi_sector;
+	bio_sectors = bio->bi_size >> 9;
 
-	return (chunk_size - ((block & (chunk_size - 1)) + bio_sz)) << 10;
+	return (chunk_sectors - ((sector & (chunk_sectors - 1)) + bio_sectors)) << 9;
 }
 
 static int raid0_run (mddev_t *mddev)
