Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWHRSx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWHRSx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWHRSx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:53:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:35264 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932212AbWHRSxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:53:23 -0400
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Eric Sandeen <esandeen@redhat.com>
Cc: sho@tnes.nec.co.jp, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <44E5FB5D.60403@redhat.com>
References: <20060818181516sho@rifu.tnes.nec.co.jp>
	 <44E5F9F0.6030805@us.ibm.com>  <44E5FB5D.60403@redhat.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 18 Aug 2006 11:53:20 -0700
Message-Id: <1155927201.4845.1.camel@dyn9047017103.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 12:39 -0500, Eric Sandeen wrote:
> Mingming Cao wrote:
> 
> > Yes, this isn't being addressed in the current 2.6.18-rc4 kernel. I 
> > think this is better than casting to unsigned long long:
> > 
> > -     if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
> > +     if ((my_rsv->rsv_start > group_first_block - 1 + EXT3_BLOCKS_PER_GROUP(sb))
> 
> And there are a few more of these.  The patch I currently have in my stack follows.
> (personally I think
> 	last = first + (count - 1)
> is clearer than
> 	last = first - 1 + count
> but that's just my opinion...)
> 
> Thanks,
> 

ACK.
> -Eric
> 
> Signed-off-by: Eric Sandeen <esandeen@redhat.com>
> 
> Index: linux-2.6.17/fs/ext3/balloc.c
> ===================================================================
> --- linux-2.6.17.orig/fs/ext3/balloc.c
> +++ linux-2.6.17/fs/ext3/balloc.c
> @@ -168,7 +168,7 @@ goal_in_my_reservation(struct ext3_reser
>  	ext3_fsblk_t group_first_block, group_last_block;
>  
>  	group_first_block = ext3_group_first_block_no(sb, group);
> -	group_last_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
> +	group_last_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
>  
>  	if ((rsv->_rsv_start > group_last_block) ||
>  	    (rsv->_rsv_end < group_first_block))
> @@ -897,7 +897,7 @@ static int alloc_new_reservation(struct 
>  	spinlock_t *rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
>  
>  	group_first_block = ext3_group_first_block_no(sb, group);
> -	group_end_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
> +	group_end_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
>  
>  	if (grp_goal < 0)
>  		start_block = group_first_block;
> @@ -1132,7 +1132,7 @@ ext3_try_to_allocate_with_rsv(struct sup
>  			try_to_extend_reservation(my_rsv, sb,
>  					*count-my_rsv->rsv_end + grp_goal - 1);
>  
> -		if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
> +		if ((my_rsv->rsv_start > group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1))
>  		    || (my_rsv->rsv_end < group_first_block))
>  			BUG();
>  		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, grp_goal,
> 
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

