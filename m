Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbTBJVIj>; Mon, 10 Feb 2003 16:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTBJVIj>; Mon, 10 Feb 2003 16:08:39 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:55938 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265171AbTBJVIg>;
	Mon, 10 Feb 2003 16:08:36 -0500
Date: Mon, 10 Feb 2003 22:18:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, mikulas@artax.karlin.mff.cuni.cz,
       pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
Message-ID: <20030210211806.GA22275@dualathlon.random>
References: <Pine.LNX.4.44.0302101723540.32095-100000@artax.karlin.mff.cuni.cz> <Pine.LNX.4.44.0302100846090.2127-100000@home.transmeta.com> <20030210124000.456318e7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210124000.456318e7.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 12:40:00PM -0800, Andrew Morton wrote:
> 	void sync_dirty_buffer(struct buffer_head *bh)
> 	{
> 		lock_buffer(bh);
> 		if (test_clear_buffer_dirty(bh)) {
> 			get_bh(bh);
> 			bh->b_end_io = end_buffer_io_sync;
> 			submit_bh(WRITE, bh);
> 		} else {
> 			unlock_buffer(bh);
> 		}
> 	}

If you we don't take the lock around the mark_dirty_buffer as Linus
suggested (to avoid serializing in the non-sync case), why don't you
simply add lock_buffer() to ll_rw_block() as we suggested originally and
you #define sync_dirty_buffer as ll_rw_block+wait_on_buffer if you
really want to make the cleanup?

There would be no difference. I don't see the need of the above
specialized ll_rw_block-cloned function just for the O_SYNC usage,
O_SYNC isn't that a special case. lock_buffer in ll_rw_block makes more
sense to me, leaving the test-and-set-bit in there, and having a
secondary ll_rw_block with different behaviour just for O_SYNC doesn't
look that clean to me.

Especially in 2.4 I wouldn't like to make the below change that is
100% equivalent to a one liner patch that just adds lock_buffer()
instead of the test-and-set-bit (for reads I see no problems either).

BTW, Linus's way that suggests the lock around the data modifications
(unconditionally), would also enforce metadata coherency so it would
provide an additional coherency guarantee (but it's not directly related
to this problem and it may be overkill). Normally we always allow
in-core modifications of the buffer during write-IO to disk (also for
the data in pagecache). Only the journal commits must be very careful in
avoiding that (like applications must be careful to run fsync and not to
overwrite the data during the fsync). So normally taking the lock around
the in-core modification and mark_buffer_dirty, would be overkill IMHO.

Andrea
