Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWJMTbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWJMTbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWJMTbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:31:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60087 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751829AbWJMTbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:31:39 -0400
Date: Fri, 13 Oct 2006 12:27:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi, ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
Subject: Re: [PATCH 1 of 2] Stackfs: Introduce stackfs_copy_{attr,inode}_*
Message-Id: <20061013122706.56970df2.akpm@osdl.org>
In-Reply-To: <ceb6edcac7047367ca16.1160738329@thor.fsl.cs.sunysb.edu>
References: <patchbomb.1160738328@thor.fsl.cs.sunysb.edu>
	<ceb6edcac7047367ca16.1160738329@thor.fsl.cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 07:18:49 -0400
Josef "Jeff" Sipek <jsipek@cs.sunysb.edu> wrote:

> From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> 
> The following patch introduces several stackfs_copy_* functions which allow
> stackable filesystems (such as eCryptfs and Unionfs) to easily copy over
> (currently only) inode attributes. This prevents code duplication and allows
> for code reuse.

Fair enough.

> include/linux/stack_fs.h |   65 ++++++++++++++++++++++++++++++++++++++++++++++

The name stack_fs implies that there's a filesystem called stackfs.  Only
there isn't.  I wonder if we can choose a better name for all of this. 
Maybe fs_stack_*?

> 
> diff --git a/include/linux/stack_fs.h b/include/linux/stack_fs.h
> new file mode 100644
> --- /dev/null
> +++ b/include/linux/stack_fs.h
> @@ -0,0 +1,65 @@
> +#ifndef _LINUX_STACK_FS_H
> +#define _LINUX_STACK_FS_H
> +
> +/* This file defines generic functions used primarily by stackable
> + * filesystems
> + */
> +
> +static inline void stackfs_copy_inode_size(struct inode *dst,
> +					   const struct inode *src)
> +{
> +	i_size_write(dst, i_size_read((struct inode *)src));
> +	dst->i_blocks = src->i_blocks;
> +}

What are the locking requirements for these functions?  Presumably the
caller must hold i_mutex on at least the source inode, and perhaps the
destination one?

If i_mutex is held, i_size_read() isn't needed.

If i_mutex is held, i_size_write() isn't needed either.

So please document the locking requirements via source comments and then
see if this can be simplified.

If this function stays as it is, it's too big to inline.

> +static inline void stackfs_copy_attr_atime(struct inode *dest,
> +					   const struct inode *src)
> +{
> +	dest->i_atime = src->i_atime;
> +}
> +
> +static inline void stackfs_copy_attr_times(struct inode *dest,
> +					   const struct inode *src)
> +{
> +	dest->i_atime = src->i_atime;
> +	dest->i_mtime = src->i_mtime;
> +	dest->i_ctime = src->i_ctime;
> +}
> +
> +static inline void stackfs_copy_attr_timesizes(struct inode *dest,
> +					       const struct inode *src)
> +{
> +	dest->i_atime = src->i_atime;
> +	dest->i_mtime = src->i_mtime;
> +	dest->i_ctime = src->i_ctime;
> +	stackfs_copy_inode_size(dest, src);
> +}
> +
> +static inline void __stackfs_copy_attr_all(struct inode *dest,
> +					   const struct inode *src,
> +					   int (*get_nlinks)(struct inode *))
> +{
> +	if (!get_nlinks)
> +		dest->i_nlink = src->i_nlink;
> +	else
> +		dest->i_nlink = get_nlinks(dest);

I cannot find a get_nlinks() in 2.6.19-rc2?

> +	dest->i_mode = src->i_mode;
> +	dest->i_uid = src->i_uid;
> +	dest->i_gid = src->i_gid;
> +	dest->i_rdev = src->i_rdev;
> +	dest->i_atime = src->i_atime;
> +	dest->i_mtime = src->i_mtime;
> +	dest->i_ctime = src->i_ctime;
> +	dest->i_blkbits = src->i_blkbits;
> +	dest->i_flags = src->i_flags;
> +}
>
> +static inline void stackfs_copy_attr_all(struct inode *dest,
> +					 const struct inode *src)
> +{
> +	__stackfs_copy_attr_all(dest, src, NULL);
> +}

Many of these functions are too large to be inlined.  Suggest they be
placed in fs/fs-stack.c (or whatever we call it).

The functions themselves seem a bit arbitrary. 
stackfs_copy_attr_timesizes() copy the three timestamps and the size.  Is
there actually any methodical reason for that, or is it simply some
sequence which happens to have been observed in ecryptfs?

And please - if I asked these questions when reviewing the patch, others
will ask them when reading the code two years from now.  So please treat my
questions as "gosh, I should have put a comment in there".
