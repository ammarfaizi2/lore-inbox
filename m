Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262704AbTCPRea>; Sun, 16 Mar 2003 12:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262705AbTCPRe3>; Sun, 16 Mar 2003 12:34:29 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:58350 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S262704AbTCPRe0>; Sun, 16 Mar 2003 12:34:26 -0500
Date: Sun, 16 Mar 2003 10:44:48 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] distributed counters for ext2 to avoid group scaning
Message-ID: <20030316104447.D12806@schatzie.adilger.int>
Mail-Followup-To: Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <m3el5773to.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3el5773to.fsf@lexa.home.net>; from bzzz@tmi.comex.ru on Sun, Mar 16, 2003 at 06:01:55PM +0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 16, 2003  18:01 +0300, Alex Tomas wrote:
> hi!
> 
> ext2 with concurrent balloc/ialloc doesn't maintain global free inodes/blocks
> counters.   This is due to badness of spinlocks and atomic_t from big iron's
> viewpoint. therefore, to know these values we should scan all group
> descriptors.  there are 81 groups for 10G fs. I believe there is method to
> avoid scaning and decrease memory footprint. 
> 
> problem:
> 1) we have to maintain something like global counter
> 2) we do not want to use spinlock/atomic because of cache ping-pong badness
> 3) it's possible to fluctuate for some counters
>    for example, free blocks counter in ext2
> 
> solution:
> lets have some base value of counter and diff value for each cpu.
> every time, someone wants to change (increase/decrease) counter, he
> increases/decreases diff value for current cpu. value of global counter
> may be calculated as sum of base value and all diffs. In order to prevent
> diff overflow, we need sometime to 'resyn' diff with base value. this
> resync needs to be serialized by seqlock. I called it 'distributed counter'.

This sounds like a good idea.  I've thought about ways of fixing this
in the past, but hadn't had any good solutions.  Unfortunately, we are
still stuck with updating the per-group free blocks/inodes counts, and
since they are modified directly in the buffer heads we can't go changing
the alignments of those fields to match the locks.

> +	dcounter_init(&EXT2_SB(sb)->free_blocks_dc, total_free, 1);
> +	dcounter_init(&EXT2_SB(sb)->free_inodes_dc,
> +			le32_to_cpu (es->s_free_inodes_count), 1);

> +static inline void dcounter_init(struct dcounter *dc, int value, int min)
> +{
> +	seqlock_init(&dc->lock);
> +	dc->base = value;
> +	dc->min = min;
> +	memset(dc->diff, 0, sizeof(int) * NR_CPUS);
> +}

So, why is it that the minimum free blocks/inodes is 1?

> +struct dcounter {
> +	int base;
> +	int min;
> +	int diff[NR_CPUS];
> +	seqlock_t lock;
> +};

For a generic struct, it probably makes more sense to make these fields
"long" instead of "int".

Also, while your goal is to reduce cache ping-pong between CPUs, we will
now have cache ping-pong for the "diff" array.  We need to do per-cpu
values or make each value cacheline aligned to avoid ping-pong.

Just for sanity's sake, it would be good to call these fields something
other than "min" and "lock", since that makes life just hell with tags
(it always bugs me when structs have fields called list_head, list_entry,
page, inode, etc).

Maybe something like "dc_min", "dc_lock", etc. would be much nicer?
The same goes for the fields in the block group info - it would be nice
if they had a "bgi_" prefix.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

