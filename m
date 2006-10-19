Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWJSN3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWJSN3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWJSN3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:29:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60823 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751613AbWJSN3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:29:30 -0400
Subject: Re: [2.6 patch] fs/gfs2/dir.c:gfs2_dir_write_data(): don't use an
	uninitialized variable
From: Steven Whitehouse <swhiteho@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061019132003.GN3502@stusta.de>
References: <20061019132003.GN3502@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 19 Oct 2006 14:36:21 +0100
Message-Id: <1161264981.27980.142.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

All three patches are now in the GFS2 git tree. Thanks,

Steve.

On Thu, 2006-10-19 at 15:20 +0200, Adrian Bunk wrote:
> In the "if (extlen)" case, "new" might be used uninitialized.
> 
> Looking at the code, it should be initialized to 0.
> 
> Spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6/fs/gfs2/dir.c.old	2006-10-19 01:08:00.000000000 +0200
> +++ linux-2.6/fs/gfs2/dir.c	2006-10-19 01:08:18.000000000 +0200
> @@ -169,37 +169,37 @@ static int gfs2_dir_write_data(struct gf
>  		return gfs2_dir_write_stuffed(ip, buf, (unsigned int)offset,
>  					      size);
>  
>  	if (gfs2_assert_warn(sdp, gfs2_is_jdata(ip)))
>  		return -EINVAL;
>  
>  	if (gfs2_is_stuffed(ip)) {
>  		error = gfs2_unstuff_dinode(ip, NULL);
>  		if (error)
>  			return error;
>  	}
>  
>  	lblock = offset;
>  	o = do_div(lblock, sdp->sd_jbsize) + sizeof(struct gfs2_meta_header);
>  
>  	while (copied < size) {
>  		unsigned int amount;
>  		struct buffer_head *bh;
> -		int new;
> +		int new = 0;
>  
>  		amount = size - copied;
>  		if (amount > sdp->sd_sb.sb_bsize - o)
>  			amount = sdp->sd_sb.sb_bsize - o;
>  
>  		if (!extlen) {
>  			new = 1;
>  			error = gfs2_extent_map(&ip->i_inode, lblock, &new,
>  						&dblock, &extlen);
>  			if (error)
>  				goto fail;
>  			error = -EIO;
>  			if (gfs2_assert_withdraw(sdp, dblock))
>  				goto fail;
>  		}
>  
>  		if (amount == sdp->sd_jbsize || new)
>  			error = gfs2_dir_get_new_buffer(ip, dblock, &bh);
> 

