Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbTCMJqw>; Thu, 13 Mar 2003 04:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbTCMJqv>; Thu, 13 Mar 2003 04:46:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:35272 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262212AbTCMJqu>;
	Thu, 13 Mar 2003 04:46:50 -0500
Date: Thu, 13 Mar 2003 01:58:40 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       bzzz@tmi.comex.ru
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-Id: <20030313015840.1df1593c.akpm@digeo.com>
In-Reply-To: <m3el5bmyrf.fsf@lexa.home.net>
References: <m3el5bmyrf.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2003 09:57:29.0292 (UTC) FILETIME=[F55758C0:01C2E946]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> 
> Hi!
> 
> as Andrew said, concurrent balloc for ext3 is useless because of BKL.
> and I saw it in benchmarks. but it may be useful for ext2.
> 
> Results:
>          9/100000   9/500000   16/100000  16/500000  32/100000  32/500000
> ext2:    0m9.260s   0m46.160s  0m18.133s  1m33.553s  0m35.958s  3m4.164s
> ext2-ca: 0m8.578s   0m42.712s  0m17.412s  1m28.637s  0m33.736s  2m53.824s
> 
> in those benchmarks, I run 2 process, each of them writes N blocks 
> (9, 16, 32), truncates file and repeat these steps M times (100000, 500000).

OK.  The main gain here is from the large context switch rate which
lock_super() can cause on big machines.

> -		if (!ext2_clear_bit(bit + i, bitmap_bh->b_data))
> +		if (!test_and_clear_bit(bit + i, (void *) bitmap_bh->b_data))

Nope.

This is an on-disk bitmap.  ext2_clear_bit() is endian-neutral - see the
ppc/ppc64/mips/etc implementations.  The code you have here will not work on
big-endian architectures.

We either need to create per-architecture atomic implementations of
ext2_foo_bit(), or use the existing ones under spinlock.

You could do:

int bzzz_set_bit(struct ext2_bg_info *bgi, void *addr, int bit)
{
#if __BIG_ENDIAN
	int ret;

	spin_lock(&bgi->s_alloc_lock);
	ret = ext2_set_bit(addr, bit);
	spin_unlock(&bgi->s_alloc_lock);
	return ret;
#else
	return test_and_set_bit(addr, bit);
#endif
}

I think that will work...

> @@ -45,6 +45,7 @@
>  	u32 s_next_generation;
>  	unsigned long s_dir_count;
>  	u8 *s_debts;
> +	spinlock_t s_alloc_lock;
>  };

You can do better than this.  A spinlock per blockgroup will scale better,
and is pretty easy.

See that s_debts thing?  That points to an array of bytes, one per
blockgroup.  Turn it into:

	struct ext2_bg_info {
		u8 s_debt;
		spinlock_t s_alloc_lock;
	};

And the locking can become per-blockgroup.

The problem with this is the fs-wide s_free_blocks_count thing.  It needs
global locking.  But do we need it?

If you look, you'll see that's not really used for much.  When we report the
free block count to userspace you can just locklesly zoom across all the
blockgroups adding them up.  You'll have to do the same in
find_group_orlov(), which is a bit sucky, but that's only used by mkdir.

The only thing left which needs the global free blocks counter is the
"reserved blocks for root" thing, which doesn't work very well anyway.  A way
to fix that would be to add a "reserved to root" field to ext2_bg_info, and
to precalculate these at mount time.

So the mount code walks across the blockgroups reserving blocks in each one
until it has reserved the required number of blocks.  This way the for-root
reservation becomes per-block-group.  It should only be dipped into if all
blockgroups are otherwise full.

Or something like that ;)


