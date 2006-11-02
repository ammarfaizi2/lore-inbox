Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWKBQGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWKBQGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWKBQGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:06:47 -0500
Received: from pat.uio.no ([129.240.10.4]:24538 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751453AbWKBQGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:06:45 -0500
Subject: Re: [PATCH 2/3] fsstack: Generic get/set lower object functions
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20061102035928.679.5819.stgit@thor.fsl.cs.sunysb.edu>
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu>
	 <20061102035928.679.5819.stgit@thor.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 11:06:05 -0500
Message-Id: <1162483565.6299.98.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.204, required 12,
	autolearn=disabled, AWL 1.66, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 22:59 -0500, Josef Jeff Sipek wrote:
> From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> 
> Every stackable filesystem needs to track what the corresponding lower
> objects are. The stackable fs superblock needs to maintain pointers to the
> lower superblock(s); the inodes need to maintain pointers to the lower
> inodes; dentries need to maintain pointers to the lower dentries and
> vfsmounts.
> 
> Currently, every stackable filesystem maintains this information in the
> private data of the object in question (the inode pointers may be also
> stored in the inode's container - which is what the following patch
> requires.)
> 
> This patch introduces generic structures to maintain the lower object
> references, and functions to get/set the lower object structure members.
> These functions are the generalized forms, which work with both linear and
> fanout stackable filesystem (eCryptfs and Unionfs to name some).
> 
> The patch is loosely based on Pekka Enberg's patches from October 13th
> (http://lkml.org/lkml/2006/10/13/82).
> 
> Cc: Pekka Enberg <penberg@cs.helsinki.fi>
> Cc: Michael Halcrow <mhalcrow@us.ibm.com>
> Cc: Erez Zadok <ezk@cs.sunysb.edu>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Al Viro <viro@ftp.linux.org.uk>
> Cc: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> ---
> 
>  include/linux/fs_stack.h |  264 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 264 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
> index bb516ce..fd4872e 100644
> --- a/include/linux/fs_stack.h
> +++ b/include/linux/fs_stack.h
> @@ -5,8 +5,272 @@ #define _LINUX_FS_STACK_H
>   * filesystems; none of these functions require i_mutex to be held.
>   */
>  
> +#include <linux/namei.h>
>  #include <linux/fs.h>
>  
> +/* structs to maintain pointers to the lower VFS objects */
> +struct fsstack_sb_info {
> +	union {
> +		struct super_block *sb;
> +		struct super_block **sbs;
> +	};
> +};

Why are you defining all these structs that are just wrapping unions?

> +
> +struct fsstack_inode_info {
> +	union {
> +		struct inode *inode;
> +		struct inode **inodes;
> +	};
> +};
> +
> +struct fsstack_dentry_info {
> +	union {
> +		struct path path;
> +		struct path *paths;
> +	};
> +};
> +
> +struct fsstack_file_info {
> +	union {
> +		struct file *file;
> +		struct file **files;
> +	};
> +};
> +
> +/* DO NOT USE!
> + *
> + * The following structure is used during the container_of calls to allow
> + * for as generic as possible way of accessing fsstack_inode_info given a
> + * pointer to the inode.
> + */
> +struct __fsstack_inode_generic_info {
> +	struct inode vfs_inode;		/* vfs inode */
> +	struct fsstack_inode_info info;	/* fsstack inode info */
> +};
> +
> +/*
> + * Functions to get lower objects from an upper one.
> + *
> + * NOTE: The filesystem specific info structures (for dentries, superblocks
> + * and files) _must_ have the following layout:
> + *
> + *	struct foo {
> + *		struct fsstack_{dentry,sb,file}_info info;
> + *		...
> + *	};
> + *
> + * Because of the usage of containers, the inode container structure _must_
> + * have the following layout:
> + *
> + * 	struct bar {
> + * 		struct inode vfs_inode;
> + * 		struct fsstack_inode_info info;
> + * 		...
> + * 	};
> + */
> +static inline struct super_block *
> +__fsstack_lower_sb(struct super_block *sb, unsigned long branch_idx)
> +{
> +	struct fsstack_sb_info *info = sb->s_fs_info;
> +	return info->sbs[branch_idx];
> +}
> +
> +static inline struct super_block **
> +__fsstack_lower_sbs(struct super_block *sb)
> +{
> +	struct fsstack_sb_info *info = sb->s_fs_info;
> +	return info->sbs;
> +}
> +
> +static inline void
> +__fsstack_set_lower_sb(struct super_block *sb, unsigned long branch_idx,
> +		       struct super_block *lower_sb)
> +{
> +	struct fsstack_sb_info *info = sb->s_fs_info;
> +	info->sbs[branch_idx] = lower_sb;
> +}
> +
> +static inline void
> +__fsstack_set_lower_sbs(struct super_block *sb, struct super_block **lower_sbs)
> +{
> +	struct fsstack_sb_info *info = sb->s_fs_info;
> +	info->sbs = lower_sbs;
> +}
> +
> +static inline struct super_block *fsstack_lower_sb(struct super_block *sb)
> +{
> +	struct fsstack_sb_info *info = sb->s_fs_info;
> +	return info->sb;
> +}
> +
> +static inline void
> +fsstack_set_lower_sb(struct super_block *sb, struct super_block *lower_sb)
> +{
> +	struct fsstack_sb_info *info = sb->s_fs_info;
> +	info->sb = lower_sb;
> +}
> +
> +/* get the fs dependent data */
> +static inline void * fsstack_inode_data(struct inode *inode)
> +{
> +	return &((struct __fsstack_inode_generic_info*) inode)->info;

Please make this wrap container_of() instead of rolling your own.
Also note that the naming convention for such a wrapper in almost all
other filesystems would be FSSTACK_I()

> +}
> +
> +static inline struct inode *
> +__fsstack_lower_inode(struct inode *inode, unsigned long branch_idx)
> +{
> +	struct fsstack_inode_info *info = fsstack_inode_data(inode);
> +		
> +	return info->inodes[branch_idx];
> +}

What is the value of "functions" like the above? They appear just to
obfuscate the code. Unless your aim is to hide the internals of the
struct __fsstack_inode_generic_info (sort of futile, since you are
asking users to include that structure in their private inode structs)
then it is much more obvious to see what is going on when you write

	inode = FSSTACK_I(inode)->inodes[branch];

rather than

	inode = __fsstack_lower_inode(inode, branch);

> +
> +static inline struct inode **
> +__fsstack_lower_inodes(struct inode *inode)
> +{
> +	struct fsstack_inode_info *info = fsstack_inode_data(inode);
> +	return info->inodes;
> +}
> +
> +static inline void
> +__fsstack_set_lower_inode(struct inode *inode, unsigned long branch_idx,
> +			  struct inode *lower_inode)
> +{
> +	struct fsstack_inode_info *info = fsstack_inode_data(inode);
> +	info->inodes[branch_idx] = lower_inode;
> +}
> +
> +static inline void
> +__fsstack_set_lower_inodes(struct inode *inode, struct inode **lower_inodes)
> +{
> +	struct fsstack_inode_info *info = fsstack_inode_data(inode);
> +	info->inodes = lower_inodes;
> +}
> +
> +static inline struct inode *fsstack_lower_inode(struct inode *inode)
> +{
> +	struct fsstack_inode_info *info = fsstack_inode_data(inode);
> +	return info->inode;
> +}
> +
> +static inline void
> +fsstack_set_lower_inode(struct inode *inode, struct inode *lower_inode)
> +{
> +	struct fsstack_inode_info *info = fsstack_inode_data(inode);
> +	info->inode = lower_inode;
> +}
> +
> +static inline struct dentry *
> +__fsstack_lower_dentry(struct dentry *dentry, unsigned long branch_idx)
> +{
> +	struct fsstack_dentry_info *info = dentry->d_fsdata;
> +	return info->paths[branch_idx].dentry;
> +}
> +
> +static inline struct path *
> +__fsstack_lower_paths(struct dentry *dentry)
> +{
> +	struct fsstack_dentry_info *info = dentry->d_fsdata;
> +	return info->paths;
> +}
> +
> +static inline void
> +__fsstack_set_lower_dentry(struct dentry *dentry, unsigned long branch_idx,
> +			   struct dentry *lower_dentry)
> +{
> +	struct fsstack_dentry_info *info = dentry->d_fsdata;
> +	info->paths[branch_idx].dentry = lower_dentry;
> +}
> +
> +static inline void
> +__fsstack_set_lower_paths(struct dentry *dentry, struct path *lower_paths)
> +{
> +	struct fsstack_dentry_info *info = dentry->d_fsdata;
> +	info->paths = lower_paths;
> +}
> +
> +static inline struct dentry *fsstack_lower_dentry(struct dentry *dentry)
> +{
> +	struct fsstack_dentry_info *info = dentry->d_fsdata;
> +	return info->path.dentry;
> +}
> +
> +static inline void
> +fsstack_set_lower_dentry(struct dentry *dentry, struct dentry *lower_dentry)
> +{
> +	struct fsstack_dentry_info *info = dentry->d_fsdata;
> +	info->path.dentry = lower_dentry;
> +}
> +
> +static inline struct vfsmount *
> +__fsstack_lower_mnt(struct dentry *dentry, unsigned long branch_idx)
> +{
> +	struct fsstack_dentry_info *info = dentry->d_fsdata;
> +	return info->paths[branch_idx].mnt;
> +}
> +
> +static inline void
> +__fsstack_set_lower_mnt(struct dentry *dentry, unsigned long branch_idx,
> +			struct vfsmount *lower_mnt)
> +{
> +	struct fsstack_dentry_info *info = dentry->d_fsdata;
> +	info->paths[branch_idx].mnt = lower_mnt;
> +}
> +
> +static inline struct vfsmount *fsstack_lower_mnt(struct dentry *dentry)
> +{
> +	struct fsstack_dentry_info *info = dentry->d_fsdata;
> +	return info->path.mnt;
> +}
> +
> +static inline void
> +fsstack_set_lower_mnt(struct dentry *dentry, struct vfsmount *lower_mnt)
> +{
> +	struct fsstack_dentry_info *info = dentry->d_fsdata;
> +	info->path.mnt = lower_mnt;
> +}
> +
> +static inline struct file *
> +__fsstack_lower_file(struct file *file, unsigned long branch_idx)
> +{
> +	struct fsstack_file_info *info = file->private_data;
> +	return info->files[branch_idx];
> +}
> +
> +static inline struct file **
> +__fsstack_lower_files(struct file *file)
> +{
> +	struct fsstack_file_info *info = file->private_data;
> +	return info->files;
> +}
> +
> +static inline void
> +__fsstack_set_lower_file(struct file *file, unsigned long branch_idx,
> +			 struct file *lower_file)
> +{
> +	struct fsstack_file_info *info = file->private_data;
> +	info->files[branch_idx] = lower_file;
> +}
> +
> +static inline void
> +__fsstack_set_lower_files(struct file *file, struct file **lower_files)
> +{
> +	struct fsstack_file_info *info = file->private_data;
> +	info->files = lower_files;
> +}
> +
> +static inline struct file *fsstack_lower_file(struct file *file)
> +{
> +	struct fsstack_file_info *info = file->private_data;
> +	return info->file;
> +}
> +
> +static inline void
> +fsstack_set_lower_file(struct file *file, struct file *lower_file)
> +{
> +	struct fsstack_file_info *info = file->private_data;
> +	info->file = lower_file;
> +}
> +
>  /* externs for fs/stack.c */
>  extern void fsstack_copy_attr_all(struct inode *dest, const struct inode *src,
>  				int (*get_nlinks)(struct inode *));
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

