Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263497AbTCNUs5>; Fri, 14 Mar 2003 15:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263510AbTCNUs4>; Fri, 14 Mar 2003 15:48:56 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:49659 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S263509AbTCNUsx>; Fri, 14 Mar 2003 15:48:53 -0500
Date: Fri, 14 Mar 2003 13:59:10 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030314135910.P12806@schatzie.adilger.int>
Mail-Followup-To: Alex Tomas <bzzz@tmi.comex.ru>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int> <m38yvixvlz.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m38yvixvlz.fsf@lexa.home.net>; from bzzz@tmi.comex.ru on Fri, Mar 14, 2003 at 10:20:24AM +0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 14, 2003  10:20 +0300, Alex Tomas wrote:
>  AD> I would suggest just hooking the ext2_group_desc (and the
>  AD> buffer_head in which it lives) off of the ext2_bg_info array
>  AD> instead of passing both around explicitly.  Since we have
>  AD> ext2_bg_info as a group_number-indexed array already, this would
>  AD> essentially mean that wherever we call ext2_get_group_desc() we
>  AD> could just use sbi->bgi[group].desc (or make
>  AD> ext2_get_group_desc() do that, if we don't need it to populate
>  AD> bgi[group].desc in the first place).
> 
> it make sense. what about to make it by separate patch?
> just to prevent huge concurrent-balloc.diff

Could you make it a pre-requisite to the concurrent-alloc patch?  That
would make it a shoo-in to being accepted (cleans up code nicely).

>  >> + if (free_blocks < root_blocks + count &&
>  >> !capable(CAP_SYS_RESOURCE) && + sbi->s_resuid != current->fsuid &&
>  >> + (sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) { + /* + *
>  >> We are too close to reserve and we are not privileged.  + * Can we
>  >> allocate anything at all?  + */ + if (free_blocks > root_blocks) +
>  >> count = free_blocks - root_blocks; + else { +
>  >> spin_unlock(&bgi->alloc_lock); + return 0; + }

Argh, please try not to wrap code...

>  AD> Per my other email, if we want to handle large files properly by
>  AD> allowing them to fill the entire group, yet we want to keep the
>  AD> "reserved blocks" count correct, we could always grab the lock on
>  AD> the last group and add reserved blocks there.  Or, we could just
>  AD> ignore the reserved blocks count entirely.
> 
> hmm. looks I miss something here. reservation is protected by the lock.
> what's the problem?

So, what Andrew had complained about with the per-group reservation is
that it leaves "gaps" in the allocation of large files.  Small gaps,
which IMHO aren't so critical, but whatever.  So to avoid having gaps
in the allocation of large files you could additionally allow allocations
from the "reserved pool" of the group in the cases like:

    (inode->i_blocks >> (inode->i_blkbits - 9)) > sbi->s_blocks_per_group / 2

If we want to preserve the total reserved blocks count (in the case where
the above test is the only reason we can allocate these blocks), we can
shift any reserved blocks we are "stealing" from this group into the last
group.

>  AD> I'm not sure whether I agree with this or not...  If a group ever
>  AD> exceeds the reserved mark for some reason (e.g. full filesystem)
>  AD> it will never be able to "improve itself" back to a decent amount
>  AD> of reserved blocks.  That said, you may want to only reduce
>  AD> "reserved" by "free" in the end, so that the total amount of
>  AD> reserved blocks is kept constant.  need to re-calculate
>  AD> "per_group" for each loop).
> 
> well, I believe reserved blocks may be really _reserved_ at the end of
> the fs. simple because of nobody should use them until fs is almost full.

The point of having the reserved blocks is to reduce fragmentation
in file allocation.  Having per-group reserved blocks is a good
idea, because it keeps the reserved "slack" per group, and helps file
allocations within that group have a bit of free space in which to grow.
If you are reserving all of the blocks at the end of the filesystem,
then the earlier groups will become 100% allocated prematurely and lose
any ability to keep files there contiguous.

What I was disagreeing with was reducing a groups reserved count because
it currently exceeds the per_group reserved count.  That's like saying
"the filesystem is 99% full, reduce the total reserved count to 1%".
Even if a group _currently_ exceeds the reserved limit, we should keep
the reserved limit for that group as-is, and hopefully allow it to grow
more "slack" for future allocation improvement if files are deleted.

If we are concerned about the total reserved blocks count (which I
personally am not), we can always add the shortfall in reserved blocks
for the current group to the remaining groups without reducing the
current group's reserved limit.

>  {
> -	struct ext2_sb_info * sbi = EXT2_SB(sb);
> -	struct ext2_super_block * es = sbi->s_es;
> -	unsigned free_blocks = le32_to_cpu(es->s_free_blocks_count);
> -	unsigned root_blocks = le32_to_cpu(es->s_r_blocks_count);
> +	unsigned free_blocks;
> +	unsigned root_blocks;
>  
> +	spin_lock(&bgi->balloc_lock);
> +	
> +	free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
>  	if (free_blocks < count)
>  		count = free_blocks;
> +	root_blocks = bgi->reserved;

>  >> + root_blocks = bgi->reserved;
> 
>  AD> I would avoid calling this "root_blocks" and instead just use
>  AD> "bgi->reserved" or "reserved_blocks" everywhere.  The original
>  AD> intent of these blocks was to reduce fragmentation and not
>  AD> necessarily reserved-for-root.
> 
> fixed

??

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

