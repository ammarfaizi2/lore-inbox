Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276855AbRJCEVE>; Wed, 3 Oct 2001 00:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276856AbRJCEUx>; Wed, 3 Oct 2001 00:20:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58320 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276855AbRJCEUu>;
	Wed, 3 Oct 2001 00:20:50 -0400
Date: Wed, 3 Oct 2001 00:21:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11-pre2 fs/buffer.c: invalidate: busy buffer
In-Reply-To: <9pe345$8ic$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110030014270.21861-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Linus Torvalds wrote:

> It's harmless, although I hope that the LVM people will become a bit
> less invalidation-happy as a result of the warning (it's always happened
> before, it just hasn't warned about it in earlier kernels).

AFAICS, md.c also doesn't play nice with buffe cache.

        fsync_dev(dev);
        set_blocksize(dev, MD_SB_BYTES);
        bh = getblk(dev, sb_offset / MD_SB_BLOCKS, MD_SB_BYTES);
        if (!bh) {
                printk(GETBLK_FAILED, partition_name(dev));
                return 1;
        }
        memset(bh->b_data,0,bh->b_size);
        sb = (mdp_super_t *) bh->b_data;
        memcpy(sb, rdev->sb, MD_SB_BYTES);

        mark_buffer_uptodate(bh, 1);
        mark_buffer_dirty(bh);
        ll_rw_block(WRITE, 1, &bh);
        wait_on_buffer(bh);
        brelse(bh);
        fsync_dev(dev);

is not a good thing to do (write_disk_sb()).  Not to mention the fact that
set_blocksize() looks bogus, the code is obviously racy.  Think what will
happen if somebody is reading from device at that moment.

