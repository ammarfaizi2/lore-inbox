Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWINVCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWINVCp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWINVCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:02:45 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:18121 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750992AbWINVCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:02:44 -0400
Date: Thu, 14 Sep 2006 23:02:35 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Alignment of fields in struct dentry
Message-ID: <20060914210235.GA10548@wohnheim.fh-wedel.de>
References: <20060914093123.GA10431@wohnheim.fh-wedel.de> <20060914105029.GA1702@wohnheim.fh-wedel.de> <20060914183325.GU6441@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060914183325.GU6441@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andreas,

On Thu, 14 September 2006 12:33:25 -0600, Andreas Dilger wrote:
> 
> I think it makes sense to keep d_inode in the first part of the dentry
> always, because it is by far the most referenced field in the dentry,
> along with the critical fields from prune_dcache(), shrink_dcache_anon(),
> dget(), dput(), d_lookup().

d_inode is definitely one of the hotter fields in there.  It just
happens to cause the misalignment.  Bah, I don't see a good solution.

> While not totally accurate in terms of runtime frequency of use, the counts
> in the code:
> 
>           fs/*.[ch] fs/*/*.[ch] size32 size64 prune_dc shrk_dc_anon d_lookup
> d_inode	        384        2131      4      8
> d_lock          104         529      4      4       1       2
> d_count          18          66      4      4       1       2
> d_lru            18          18      4_     8       1       1
> d_hash           37         154      4      8_              2          1
> d_name           73         908     12_    16                          1
> d_flags          26         104      4      4       2
> d_mounted         7           7      4      4
> d_parent         40         231      4      8_                         2
> d_op             37         269      4      8
> d_rcu/d_child  3+22        3+45      8     16

[ d_hash is 8/16, actually ]

d_hash, d_name and d_parent belong way up to the top of the list, imo.
d_lookup() should be the hottest function of all, as the comment in
the structure definition already indicates.  Maybe the solution is to
rearrange the fields with those going to the top?

Using your scheme (slightly reduced) we now have:
		size32	size64	funky?
d_count		4	4
d_flags		4	4
d_lock		4	4_	y
d_inode		4_	8
d_hash		8	16--
d_parent	4	8_
d_name		12--	16___
d_lru		8_	16_
d_rcu/d_child	8	16__
d_subdirs	8___	16_
d_alias		8	16____
d_time		4	8
d_op		4_	8_
d_sb		4	8
d_fsdata	4	8__
d_cookie	0	0	y
d_mounted	4	4
d_iname		36____	36

With the two funky fields possibly growing, depending on kernel
config.  [_-] mark 16-, 32- 64- and 128-byte boundaries, depending on
len.  What really frightens me is that a 32-byte boundary goes right
through d_name on 32bit machines.  Iirc, my PIII has 32-byte
cachelines.  Not good.

How about moving [d_hash,d_parent,d_name] to the front?  Something
like:
		size32	size64	funky?
d_hash		8	16_
d_parent	4	8
d_name		12-	16--
d_inode		4	8_
d_count		4__	4
d_flags		4	4
d_lock		4	4	y

d_mounted	4	4

d_lru		8	16
d_rcu/d_child	8	16
d_subdirs	8	16
d_alias		8	16
d_time		4	8
d_op		4	8
d_sb		4	8
d_fsdata	4	8
d_cookie	0	0	y
d_iname		36	36

Now d_lookup() should use a single cacheline, even on my aged
notebook, and the other hot fields remain at the top.  d_mounted is
also moved up to remove the misalignment on 64bit.  Might be worth
a benchmark or two to see whether it makes a difference...

Jörn

-- 
Joern's library part 1:
http://lwn.net/Articles/2.6-kernel-api/
