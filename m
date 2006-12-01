Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031720AbWLATOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031720AbWLATOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031733AbWLATOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:14:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17879 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1031720AbWLATOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:14:14 -0500
Subject: Re: [GFS2] Fix page lock/glock deadlock [32/70]
From: Russell Cattelan <cattelan@redhat.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164889047.3752.368.camel@quoit.chygwyn.com>
References: <1164889047.3752.368.camel@quoit.chygwyn.com>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 13:14:07 -0600
Message-Id: <1165000447.1194.86.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-30 at 12:17 +0000, Steven Whitehouse wrote:
> >From 2ca99501fa5422e84f18333918a503433449e2b5 Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Wed, 8 Nov 2006 10:26:54 -0500
> Subject: [PATCH] [GFS2] Fix page lock/glock deadlock
> 
> This fixes a race between the glock and the page lock encountered
> during truncate in gfs2_readpage and gfs2_prepare_write. The gfs2_readpages
> function doesn't need the same fix since it only uses a try lock anyway, so
> it will fail back to gfs2_readpage in the case of a potential deadlock.
> 
> This bug was spotted by Russell Cattelan.\
This bug was fixed correctly by Russell Cattelan
and this is an incomplete version of my patch.


As I keep trying to point out readpages is still wrong in that
the stuffed case is not correct and results in a panic
if a file is being truncated down.
If nr_pages is calculated prior a truncate the stuffed inode
case will try to operate on pages that are no longer there.


The correct fix is to not try and handled the stuffed inode 
case at all in readpages and simply return AOP_TRUNCATED_PAGE
and let things things fall back to readpage.


> 
> Cc: Russell Cattelan <cattelan@redhat.com>
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/glock.h       |    1 -
>  fs/gfs2/ops_address.c |   13 +++++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
> index b985627..a331bf8 100644
> --- a/fs/gfs2/glock.h
> +++ b/fs/gfs2/glock.h
> @@ -27,7 +27,6 @@ #define GL_SKIP			0x00000100
>  #define GL_ATIME		0x00000200
>  #define GL_NOCACHE		0x00000400
>  #define GL_NOCANCEL		0x00001000
> -#define GL_AOP			0x00004000
>  
>  #define GLR_TRYFAILED		13
>  #define GLR_CANCELED		14
> diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
> index 5c3962c..3822189 100644
> --- a/fs/gfs2/ops_address.c
> +++ b/fs/gfs2/ops_address.c
> @@ -230,7 +230,7 @@ static int gfs2_readpage(struct file *fi
>  				/* gfs2_sharewrite_nopage has grabbed the ip->i_gl already */
>  				goto skip_lock;
>  		}
> -		gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME|GL_AOP, &gh);
> +		gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME|LM_FLAG_TRY_1CB, &gh);
>  		do_unlock = 1;
>  		error = gfs2_glock_nq_m_atime(1, &gh);
>  		if (unlikely(error))
> @@ -254,6 +254,8 @@ skip_lock:
>  out:
>  	return error;
>  out_unlock:
> +	if (error == GLR_TRYFAILED)
> +		error = AOP_TRUNCATED_PAGE;
>  	unlock_page(page);
>  	if (do_unlock)
>  		gfs2_holder_uninit(&gh);
> @@ -293,7 +295,7 @@ static int gfs2_readpages(struct file *f
>  				goto skip_lock;
>  		}
>  		gfs2_holder_init(ip->i_gl, LM_ST_SHARED,
> -				 LM_FLAG_TRY_1CB|GL_ATIME|GL_AOP, &gh);
> +				 LM_FLAG_TRY_1CB|GL_ATIME, &gh);
>  		do_unlock = 1;
>  		ret = gfs2_glock_nq_m_atime(1, &gh);
>  		if (ret == GLR_TRYFAILED)
> @@ -366,10 +368,13 @@ static int gfs2_prepare_write(struct fil
>  	unsigned int write_len = to - from;
>  
> 
> -	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_ATIME|GL_AOP, &ip->i_gh);
> +	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_ATIME|LM_FLAG_TRY_1CB, &ip->i_gh);
>  	error = gfs2_glock_nq_m_atime(1, &ip->i_gh);
> -	if (error)
> +	if (unlikely(error)) {
> +		if (error == GLR_TRYFAILED)
> +			error = AOP_TRUNCATED_PAGE;
>  		goto out_uninit;
> +	}
>  
>  	gfs2_write_calc_reserv(ip, write_len, &data_blocks, &ind_blocks);
>  
-- 
Russell Cattelan <cattelan@redhat.com>

