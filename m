Return-Path: <linux-kernel-owner+w=401wt.eu-S1751167AbXAPVTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbXAPVTH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 16:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXAPVTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 16:19:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45788 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbXAPVTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 16:19:05 -0500
Message-ID: <45AD3DCF.6000604@redhat.com>
Date: Tue, 16 Jan 2007 16:04:15 -0500
From: Wendy Cheng <wcheng@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, swhiteho@redhat.com,
       cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Cluster-devel] [-mm patch] make gfs2_change_nlink_i() static
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070113095640.GK7469@stusta.de>
In-Reply-To: <20070113095640.GK7469@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
>   
>> ...
>> Changes since 2.6.20-rc3-mm1:
>> ...
>>  git-gfs2-nmw.patch
>> ...
>>  git trees
>> ...
>>     
>
>
> This patch makes the needlessly globlal gfs2_change_nlink_i() static.
>   
We will probably need to call this routine from other files in our next 
round of code check-in.

-- Wendy
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
>  fs/gfs2/inode.c |   88 ++++++++++++++++++++++++------------------------
>  fs/gfs2/inode.h |    1 
>  2 files changed, 44 insertions(+), 45 deletions(-)
>
> --- linux-2.6.20-rc4-mm1/fs/gfs2/inode.h.old	2007-01-13 08:56:24.000000000 +0100
> +++ linux-2.6.20-rc4-mm1/fs/gfs2/inode.h	2007-01-13 08:56:30.000000000 +0100
> @@ -40,7 +40,6 @@
>  
>  int gfs2_dinode_dealloc(struct gfs2_inode *inode);
>  int gfs2_change_nlink(struct gfs2_inode *ip, int diff);
> -int gfs2_change_nlink_i(struct gfs2_inode *ip);
>  struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
>  			   int is_root, struct nameidata *nd);
>  struct inode *gfs2_createi(struct gfs2_holder *ghs, const struct qstr *name,
> --- linux-2.6.20-rc4-mm1/fs/gfs2/inode.c.old	2007-01-13 08:56:37.000000000 +0100
> +++ linux-2.6.20-rc4-mm1/fs/gfs2/inode.c	2007-01-13 08:57:21.000000000 +0100
> @@ -280,6 +280,50 @@
>  	return error;
>  }
>  
> +static int gfs2_change_nlink_i(struct gfs2_inode *ip)
> +{
> +	struct gfs2_sbd *sdp = ip->i_inode.i_sb->s_fs_info;
> +	struct gfs2_inode *rindex = GFS2_I(sdp->sd_rindex);
> +	struct gfs2_glock *ri_gl = rindex->i_gl;
> +	struct gfs2_rgrpd *rgd;
> +	struct gfs2_holder ri_gh, rg_gh;
> +	int existing, error;
> +
> +	/* if we come from rename path, we could have the lock already */
> +	existing = gfs2_glock_is_locked_by_me(ri_gl);
> +	if (!existing) {
> +		error = gfs2_rindex_hold(sdp, &ri_gh);
> +		if (error)
> +			goto out;
> +	}
> +
> +	/* find the matching rgd */
> +	error = -EIO;
> +	rgd = gfs2_blk2rgrpd(sdp, ip->i_num.no_addr);
> +	if (!rgd)
> +		goto out_norgrp;
> +
> +	/*
> +	 * Eventually we may want to move rgd(s) to a linked list
> +	 * and piggyback the free logic into one of gfs2 daemons
> +	 * to gain some performance.
> +	 */
> +	if (!rgd->rd_gl || !gfs2_glock_is_locked_by_me(rgd->rd_gl)) {
> +		error = gfs2_glock_nq_init(rgd->rd_gl, LM_ST_EXCLUSIVE, 0, &rg_gh);
> +		if (error)
> +			goto out_norgrp;
> +
> +		gfs2_unlink_di(&ip->i_inode); /* mark inode unlinked */
> +		gfs2_glock_dq_uninit(&rg_gh);
> +	}
> +
> +out_norgrp:
> +	if (!existing)
> +		gfs2_glock_dq_uninit(&ri_gh);
> +out:
> +	return error;
> +}
> +
>  /**
>   * gfs2_change_nlink - Change nlink count on inode
>   * @ip: The GFS2 inode
> @@ -326,50 +370,6 @@
>  	return error;
>  }
>  
> -int gfs2_change_nlink_i(struct gfs2_inode *ip)
> -{
> -	struct gfs2_sbd *sdp = ip->i_inode.i_sb->s_fs_info;
> -	struct gfs2_inode *rindex = GFS2_I(sdp->sd_rindex);
> -	struct gfs2_glock *ri_gl = rindex->i_gl;
> -	struct gfs2_rgrpd *rgd;
> -	struct gfs2_holder ri_gh, rg_gh;
> -	int existing, error;
> -
> -	/* if we come from rename path, we could have the lock already */
> -	existing = gfs2_glock_is_locked_by_me(ri_gl);
> -	if (!existing) {
> -		error = gfs2_rindex_hold(sdp, &ri_gh);
> -		if (error)
> -			goto out;
> -	}
> -
> -	/* find the matching rgd */
> -	error = -EIO;
> -	rgd = gfs2_blk2rgrpd(sdp, ip->i_num.no_addr);
> -	if (!rgd)
> -		goto out_norgrp;
> -
> -	/*
> -	 * Eventually we may want to move rgd(s) to a linked list
> -	 * and piggyback the free logic into one of gfs2 daemons
> -	 * to gain some performance.
> -	 */
> -	if (!rgd->rd_gl || !gfs2_glock_is_locked_by_me(rgd->rd_gl)) {
> -		error = gfs2_glock_nq_init(rgd->rd_gl, LM_ST_EXCLUSIVE, 0, &rg_gh);
> -		if (error)
> -			goto out_norgrp;
> -
> -		gfs2_unlink_di(&ip->i_inode); /* mark inode unlinked */
> -		gfs2_glock_dq_uninit(&rg_gh);
> -	}
> -
> -out_norgrp:
> -	if (!existing)
> -		gfs2_glock_dq_uninit(&ri_gh);
> -out:
> -	return error;
> -}
> -
>  struct inode *gfs2_lookup_simple(struct inode *dip, const char *name)
>  {
>  	struct qstr qstr;
>
>   

