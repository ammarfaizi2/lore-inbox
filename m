Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWCGAjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWCGAjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWCGAjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:39:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932532AbWCGAjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:39:39 -0500
Date: Mon, 6 Mar 2006 16:37:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
Message-Id: <20060306163745.65e0f4d8.akpm@osdl.org>
In-Reply-To: <20060306070456.GA16478@redhat.com>
References: <20060306070456.GA16478@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> Probably the first of many found with Coverity.
> 
> This is kfree'd outside of both arms of the if condition already,
> so fall through and free it just once.
> 
> Second variant is double-nasty, it deref's the free'd fcall
> before it tries to free it a second time.
> 
> (I wish we had a kfree variant that NULL'd the target when it was free'd)
> 
> Coverity bugs: 987, 986
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> 
> --- linux-2.6.15.noarch/fs/9p/vfs_super.c~	2006-03-06 01:53:38.000000000 -0500
> +++ linux-2.6.15.noarch/fs/9p/vfs_super.c	2006-03-06 01:54:36.000000000 -0500
> @@ -156,7 +156,6 @@ static struct super_block *v9fs_get_sb(s
>  	stat_result = v9fs_t_stat(v9ses, newfid, &fcall);
>  	if (stat_result < 0) {
>  		dprintk(DEBUG_ERROR, "stat error\n");
> -		kfree(fcall);
>  		v9fs_t_clunk(v9ses, newfid);
>  	} else {
>  		/* Setup the Root Inode */
> --- linux-2.6.15.noarch/fs/9p/vfs_inode.c~	2006-03-06 01:57:05.000000000 -0500
> +++ linux-2.6.15.noarch/fs/9p/vfs_inode.c	2006-03-06 01:58:05.000000000 -0500
> @@ -274,7 +274,6 @@ v9fs_create(struct v9fs_session_info *v9
>  		PRINT_FCALL_ERROR("clone error", fcall);
>  		goto error;
>  	}
> -	kfree(fcall);
>  
>  	err = v9fs_t_create(v9ses, fid, name, perm, mode, &fcall);
>  	if (err < 0) {

The second hunk is probably right and I guess the first one has to be right
as well, but it's all rather obscure, complex and (naturally) comment-free.

So I'll duck on this - Eric, could you please handle it?  Consider doing
away with the dynamically-allocated thing altogether and just allocating it
on the outermost caller's stack.  
