Return-Path: <linux-kernel-owner+w=401wt.eu-S965120AbXAJVYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbXAJVYy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbXAJVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:24:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37006 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbXAJVYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:24:53 -0500
Date: Wed, 10 Jan 2007 21:24:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       esandeen@redhat.com, aviro@redhat.com, haveblue@us.ibm.com
Subject: Re: [PATCH 3/3] have pipefs ensure i_ino uniqueness by calling iunique and hashing the inode
Message-ID: <20070110212448.GA4656@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, esandeen@redhat.com, aviro@redhat.com,
	haveblue@us.ibm.com
References: <200701082047.l08KlHwK001925@dantu.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701082047.l08KlHwK001925@dantu.rdu.redhat.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 03:47:17PM -0500, Jeff Layton wrote:
> This converts pipefs to use the new scheme. Here we're calling iunique to get
> a unique i_ino value for the new inode, and then hashing it afterward. We
> call iunique with a max_reserved value of 1 to avoid collision with the root
> inode.  Since the inode is now hashed, we need to take care that we end up in
> generic_delete_inode rather than generic_forget_inode or we'll create a nasty
> leak, so we clear_nlink when we destroy the pipe info.
> 
> I'm not certain that this is the right place to add the clear_nlink, though
> it does seem to work. I'm open to suggestions on a better place to put
> this, or of a better way to make sure that we end up with i_nlink == 0 at
> iput time.

You should Cc Dave Hansen as he's did the nlink helpers and works on
the per-mount readonly code that requires them.

> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 68090e8..1d44ff0 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -825,6 +825,7 @@ void free_pipe_info(struct inode *inode)
>  {
>  	__free_pipe_info(inode->i_pipe);
>  	inode->i_pipe = NULL;
> +	clear_nlink(inode);
>  }
>  
>  static struct vfsmount *pipe_mnt __read_mostly;
> @@ -871,6 +872,8 @@ static struct inode * get_pipe_inode(void)
>  	inode->i_uid = current->fsuid;
>  	inode->i_gid = current->fsgid;
>  	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
> +	inode->i_ino = iunique(pipe_mnt->mnt_sb, 1);
> +	insert_inode_hash(inode);
>  
>  	return inode;
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---
