Return-Path: <linux-kernel-owner+w=401wt.eu-S965117AbXAJVWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbXAJVWT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbXAJVWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:22:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36978 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbXAJVWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:22:17 -0500
Date: Wed, 10 Jan 2007 21:22:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       esandeen@redhat.com, aviro@redhat.com
Subject: Re: [PATCH 2/3] change libfs sb creation routines to avoid collisions with their root inodes
Message-ID: <20070110212215.GB4425@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, esandeen@redhat.com, aviro@redhat.com
References: <200701082047.l08KlDCa001921@dantu.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701082047.l08KlDCa001921@dantu.rdu.redhat.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 03:47:13PM -0500, Jeff Layton wrote:
> This changes the superblock creation routines that call new_inode to take steps
> to avoid later collisions with other inodes that get created. I took the
> approach here of not hashing things unless is was strictly necessary, though
> that does mean that filesystem authors need to be careful to avoid collisions
> by calling iunique properly.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 503898d..5bdaf00 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -217,6 +217,12 @@ int get_sb_pseudo(struct file_system_type *fs_type, char *name,
>  	root = new_inode(s);
>  	if (!root)
>  		goto Enomem;
> +	/*
> +	 * since this is the first inode, make it number 1. New inodes created
> +         * after this must take care not to collide with it (by passing
> +	 * max_reserved of 1 to iunique).
> +	 */
> +	root->i_ino = 1;

Ok.

>  		return -ENOMEM;
> +	/* set to high value to try and avoid collisions with loop below */
> +	inode->i_ino = 0xffffffff;
> +	insert_inode_hash(inode);

This is odd.  Can't we just add some constant base to the loop below?

>  	inode->i_mode = S_IFDIR | 0755;
>  	inode->i_uid = inode->i_gid = 0;
>  	inode->i_blocks = 0;
> @@ -399,6 +408,11 @@ int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files
>  		inode->i_blocks = 0;
>  		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
>  		inode->i_fop = files->ops;
> +		/*
> +		 * no need to hash these, but you need to make sure that any
> +		 * calls to iunique on this mount call it with a max_reserved
> +		 * value high enough to avoid collisions with these inodes.
> +		 */
>  		inode->i_ino = i;
>  		d_add(dentry, inode);
