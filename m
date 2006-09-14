Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWINSdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWINSdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWINSdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:33:33 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:12942 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750988AbWINSdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:33:32 -0400
Date: Thu, 14 Sep 2006 12:33:25 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: =?utf-8?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Alignment of fields in struct dentry
Message-ID: <20060914183325.GU6441@schatzie.adilger.int>
Mail-Followup-To: =?utf-8?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060914093123.GA10431@wohnheim.fh-wedel.de> <20060914105029.GA1702@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060914105029.GA1702@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14, 2006  12:50 +0200, J�rn Engel wrote:
> > After taking a look at struct dentry, Arnd noted an alignment
> > problem.
> > On 64bit architectures, the first three take 12 bytes and d_inode is
> > not naturally aligned, so it can be aligned to byte 16.
> 
>  struct dentry {
>  	atomic_t d_count;
>  	unsigned int d_flags;		/* protected by d_lock */
>  	spinlock_t d_lock;		/* per dentry lock */
> -	struct inode *d_inode;		/* Where the name belongs to - NULL is
> -					 * negative */
> +	int d_mounted;
>  	/*
>  	 * The next three fields are touched by __d_lookup.  Place them here
>  	 * so they all fit in a cache line.
> @@ -93,6 +96,8 @@ struct dentry {
>  	struct dentry *d_parent;	/* parent directory */
>  	struct qstr d_name;
>  
> +	struct inode *d_inode;		/* Where the name belongs to - NULL is

I think it makes sense to keep d_inode in the first part of the dentry
always, because it is by far the most referenced field in the dentry,
along with the critical fields from prune_dcache(), shrink_dcache_anon(),
dget(), dput(), d_lookup().

While not totally accurate in terms of runtime frequency of use, the counts
in the code:

          fs/*.[ch] fs/*/*.[ch] size32 size64 prune_dc shrk_dc_anon d_lookup
d_inode	        384        2131      4      8
d_lock          104         529      4      4       1       2
d_count          18          66      4      4       1       2
d_lru            18          18      4_     8       1       1
d_hash           37         154      4      8_              2          1
d_name           73         908     12_    16                          1
d_flags          26         104      4      4       2
d_mounted         7           7      4      4
d_parent         40         231      4      8_                         2
d_op             37         269      4      8
d_rcu/d_child  3+22        3+45      8     16

The '_' are potential cacheline boundaries.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

