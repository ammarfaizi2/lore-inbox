Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280382AbRKEIr3>; Mon, 5 Nov 2001 03:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280384AbRKEIrU>; Mon, 5 Nov 2001 03:47:20 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30724 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280382AbRKEIrO>; Mon, 5 Nov 2001 03:47:14 -0500
Date: Mon, 5 Nov 2001 09:47:01 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: disk throughput
Message-ID: <20011105094701.H29577@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been taking a look at one particular workload - the creation
> and use of many smallish files.  ie: the things we do every day
> with kernel trees.
> 
> There are a number of things which cause linux to perform quite badly
> with this workload.  I've fixed most of them and the speedups are quite
> dramatic.  The changes include:
> 
> - reorganise the sync_inode() paths so we don't do
>   read-a-block,write-a-block,read-a-block, ...
> 
> - asynchronous preread of an ext2 inode's block when we
>   create the inode, so:
> 
>   a) the reads will cluster into larger requests and
>   b) during inode writeout we don't keep stalling on
>      reads, preventing write clustering.
> 
> - Move ext2's bitmap loading code outside lock_super(),
>   so other threads can still get in and write to the
>   fs while the reader sleeps, thus increasing write
>   request merging.  This benefits multithreaded workloads
>   (ie: dbench) and needs more thought.
> 
> The above changes are basically a search-and-destroy mission against
> the things which are preventing effective writeout request merging.
> Once they're in place we also need:
> 
> - Alter the request queue size and elvtune settings
> 
> 
> The time to create 100,000 4k files (10 per directory) has fallen
> from 3:09 (3min 9second) down to 0:30.  A six-fold speedup.
  Nice :).

> All well and good, and still a WIP.  But by far the most dramatic
> speedups come from disabling ext2's policy of placing new directories
> in a different blockgroup from the parent:
> 
> --- linux-2.4.14-pre8/fs/ext2/ialloc.c	Tue Oct  9 21:31:40 2001
> +++ linux-akpm/fs/ext2/ialloc.c	Sun Nov  4 17:40:43 2001
> @@ -286,7 +286,7 @@ struct inode * ext2_new_inode (const str
>  repeat:
>  	gdp = NULL; i=0;
>  	
> -	if (S_ISDIR(mode)) {
> +	if (0 && S_ISDIR(mode)) {
>  		avefreei = le32_to_cpu(es->s_free_inodes_count) /
>  			sb->u.ext2_sb.s_groups_count;
>  /* I am not yet convinced that this next bit is necessary.
> 
> 
> Numbers.  The machine has 768 megs; the disk is IDE with a two meg cache.
> The workload consists of untarring, tarring, diffing and removing kernel
> trees. This filesystem is 21 gigs, and has 176 block groups.
  I'm not sure if this speedup isn't connected just with your testcase..
If I understood well the code it tries to spread files uniformly over the
fs (ie. all groups equally full). I think that if you have filesystem like
/home where are large+small files changing a lot your change can actually
lead to more fragmentation - groups in the beginning gets full (files
are created in the same group as it's parent). Then if some file gets deleted
and new one created filesystem will try to stuff new file in the first
groups and that causes fragmentation.. But it's just an idea - some testing
would be probably more useful...

> After each test which wrote data a `sync' was performed, and was included
> in the timing under the assumption that all the data will be written back
> by kupdate in a few seconds, and running `sync' allows measurement of the
> cost of that.
> 
> The filesystem was unmounted between each test - all tests are with
> cold caches.
> 
>                                 stock   patched 
> untar one kernel tree, sync:    0:31     0:14
> diff two trees:                 3:04     1:12
> tar kernel tree to /dev/null:   0:15     0:03
> remove 2 kernel trees, sync:    0:30     0:10
> 
> A significant thing here is the improvement in read performance as well
> as writes.  All of the other speedup changes only affect writes.
> 
> We are paying an extremely heavy price for placing directories in
> different block groups from their parent.  Why do we do this, and
> is it worth the cost?

								Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
