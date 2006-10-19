Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161431AbWJSPLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161431AbWJSPLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161432AbWJSPLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:11:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40089 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161431AbWJSPLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:11:37 -0400
Subject: Re: gfs2_dir_read_data(): fix uninitialized variable usage
From: Steven Whitehouse <swhiteho@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061019140207.GP3502@stusta.de>
References: <20061019140207.GP3502@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 19 Oct 2006 16:18:18 +0100
Message-Id: <1161271098.27980.147.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one is now in the GFS2 tree too. Thanks,

Steve.

On Thu, 2006-10-19 at 16:02 +0200, Adrian Bunk wrote:
> In the "if (extlen)" case, "bh" was used uninitialized.
> 
> This patch changes the code to what seems to have been intended.
> 
> Spotted by the Coverity checker.
> 
> This patch also removes a pointless "bh = NULL" asignment (the variable 
> is never accessed again after this point).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6/fs/gfs2/dir.c.old	2006-10-19 15:33:52.000000000 +0200
> +++ linux-2.6/fs/gfs2/dir.c	2006-10-19 15:35:44.000000000 +0200
> @@ -301,54 +301,52 @@ static int gfs2_dir_read_data(struct gfs
>  	while (copied < size) {
>  		unsigned int amount;
>  		struct buffer_head *bh;
>  		int new;
>  
>  		amount = size - copied;
>  		if (amount > sdp->sd_sb.sb_bsize - o)
>  			amount = sdp->sd_sb.sb_bsize - o;
>  
>  		if (!extlen) {
>  			new = 0;
>  			error = gfs2_extent_map(&ip->i_inode, lblock, &new,
>  						&dblock, &extlen);
>  			if (error || !dblock)
>  				goto fail;
>  			BUG_ON(extlen < 1);
>  			if (!ra)
>  				extlen = 1;
>  			bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
> -		}
> -		if (!bh) {
> +		} else {
>  			error = gfs2_meta_read(ip->i_gl, dblock, DIO_WAIT, &bh);
>  			if (error)
>  				goto fail;
>  		}
>  		error = gfs2_metatype_check(sdp, bh, GFS2_METATYPE_JD);
>  		if (error) {
>  			brelse(bh);
>  			goto fail;
>  		}
>  		dblock++;
>  		extlen--;
>  		memcpy(buf, bh->b_data + o, amount);
>  		brelse(bh);
> -		bh = NULL;
>  		buf += amount;
>  		copied += amount;
>  		lblock++;
>  		o = sizeof(struct gfs2_meta_header);
>  	}
>  
>  	return copied;
>  fail:
>  	return (copied) ? copied : error;
>  }
>  
>  static inline int __gfs2_dirent_find(const struct gfs2_dirent *dent,
>  				     const struct qstr *name, int ret)
>  {
>  	if (dent->de_inum.no_addr != 0 &&
>  	    be32_to_cpu(dent->de_hash) == name->hash &&
>  	    be16_to_cpu(dent->de_name_len) == name->len &&
>  	    memcmp(dent+1, name->name, name->len) == 0)
>  		return ret;
> 

