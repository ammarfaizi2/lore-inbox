Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262608AbTCMXqR>; Thu, 13 Mar 2003 18:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbTCMXqR>; Thu, 13 Mar 2003 18:46:17 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:44026 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S262608AbTCMXqP>; Thu, 13 Mar 2003 18:46:15 -0500
Date: Thu, 13 Mar 2003 16:56:41 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030313165641.H12806@schatzie.adilger.int>
Mail-Followup-To: Alex Tomas <bzzz@tmi.comex.ru>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3of4fgjob.fsf@lexa.home.net>; from bzzz@tmi.comex.ru on Thu, Mar 13, 2003 at 10:17:56PM +0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thanks for this work, Alex.  It's been a long time in coming.

One thing I would wonder about is whether we should be implementing this in
ext2, or in ext3 only.  One of the decisions we made in the past is that we
shouldn't necessarily implement everything in ext2 (especially features that
complicated the code, and are only useful on high-end systems).

There was a desire to keep ext2 small and simple, and ext3 would get the
fancy high-end features that make sense if you have a large filesystem
that you would likely be using in conjunction with ext3 anyways.

It does make sense to test this out on ext2 since it is definitely easier
to code for ext2 than ext3, and the journaling doesn't skew the performance
so much.  Of course one of the reasons that ext2 is easier to code for is
exactly _because_ we don't put all of the features into ext2...

Comments on the code inline below...

On Mar 13, 2003  22:17 +0300, Alex Tomas wrote:
> -static inline int reserve_blocks(struct super_block *sb, int count)
> +static inline int group_reserve_blocks(struct ext2_sb_info *sbi, struct ext2_bg_info *bgi, 
> +					struct ext2_group_desc *desc,
> +					struct buffer_head *bh, int count, int use_reserve)

I would suggest just hooking the ext2_group_desc (and the buffer_head in
which it lives) off of the ext2_bg_info array instead of passing both
around explicitly.  Since we have ext2_bg_info as a group_number-indexed
array already, this would essentially mean that wherever we call
ext2_get_group_desc() we could just use sbi->bgi[group].desc (or make
ext2_get_group_desc() do that, if we don't need it to populate bgi[group].desc
in the first place).

> +	root_blocks = bgi->reserved;

I would avoid calling this "root_blocks" and instead just use "bgi->reserved"
or "reserved_blocks" everywhere.  The original intent of these blocks was to
reduce fragmentation and not necessarily reserved-for-root.

> +        if (free_blocks < root_blocks + count && !capable(CAP_SYS_RESOURCE) &&
> +            sbi->s_resuid != current->fsuid &&
> +            (sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
> +                /*
> +                 * We are too close to reserve and we are not privileged.
> +                 * Can we allocate anything at all?
> +                 */
> +                if (free_blocks > root_blocks)
> +                        count = free_blocks - root_blocks;
> +                else {
> +			spin_unlock(&bgi->alloc_lock);
> +                        return 0;
> +		}

Per my other email, if we want to handle large files properly by allowing them
to fill the entire group, yet we want to keep the "reserved blocks" count
correct, we could always grab the lock on the last group and add reserved
blocks there.  Or, we could just ignore the reserved blocks count entirely.

>  unsigned long ext2_count_free_blocks (struct super_block * sb)
>       :
> -	return le32_to_cpu(EXT2_SB(sb)->s_es->s_free_blocks_count);
> +        for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
> +                desc = ext2_get_group_desc (sb, i, NULL);
> +                if (!desc)
> +                        continue;
> +                desc_count += le16_to_cpu(desc->bg_free_blocks_count);
> +	}
> +	return desc_count;
>  #endif

In general, this should be safe to do without a lock, since it is only
used for heuristics (orlov) and statfs (which is out-of-date as soon as
we call it).  Are there any other users of ext2_count_free_blocks() that
need a correct value?  I suppose mount/unmount to set s_free_blocks_count,
but those probably have exclusive access to the filesystem anyways.

PS - it looks like you are using spaces for indents instead of tabs here...

> +	if (le32_to_cpu(es->s_free_blocks_count) != total_free)
> +		printk(KERN_INFO "EXT2-fs: last umount wasn't clean. correct free blocks counter\n");

Probably no need to print this for ext2, since there is already an "uncleanly
unmounted" flag in the superblock, and e2fsck will have otherwise fixed it
up.

> +	/* distribute reserved blocks over groups -bzzz */
> +	while (reserved && total_free) {
> +		unsigned int per_group = reserved / sbi->s_groups_count + 1;
> +		unsigned int free;
> +	
> +		for (i = 0; reserved && i < sbi->s_groups_count; i++) {
> +			gdp = ext2_get_group_desc (sb, i, NULL);
> +			if (!gdp) {
> +				ext2_error (sb, "ext2_check_descriptors",
> +						"can't get descriptor for group #%d", i);
> +				return 0;
> +			}
> +			
> +			free = le16_to_cpu(gdp->bg_free_blocks_count);
> +			if (per_group > free)
> +				per_group = free;

I'm not sure whether I agree with this or not...  If a group ever exceeds
the reserved mark for some reason (e.g. full filesystem) it will never be
able to "improve itself" back to a decent amount of reserved blocks.  That
said, you may want to only reduce "reserved" by "free" in the end, so that
the total amount of reserved blocks is kept constant.
need to re-calculate "per_group" for each loop).

>  extern __inline__ int
> +ext2_set_bit_atomic (spinlock_t *lock, int nr, volatile void *vaddr)

Please don't use "extern __inline__", as that can cause all sorts of
grief.  Either "static inline" or just "extern".

> +struct ext2_bg_info {
> +	u8 debts;
> +	spinlock_t alloc_lock;
> +	unsigned int reserved;
> +};

Please rename this "balloc_lock", as it is likely that we will get an
"ialloc_lock" in the future also.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

