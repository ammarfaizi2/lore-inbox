Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbUK2WSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbUK2WSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbUK2WRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:17:38 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:43916 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261832AbUK2WP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:15:58 -0500
Date: Mon, 29 Nov 2004 14:15:48 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 4/10 CKRM:  Full rcfs support
Message-ID: <20041129221548.GD19892@kroah.com>
References: <E1CYqZU-000588-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYqZU-000588-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 10:48:24AM -0800, Gerrit Huizenga wrote:
> +#include <linux/module.h>
> +#include <linux/list.h>
> +#include <linux/fs.h>
> +#include <linux/namei.h>
> +#include <linux/namespace.h>
> +#include <linux/dcache.h>
> +#include <linux/seq_file.h>
> +#include <linux/pagemap.h>
> +#include <linux/highmem.h>
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <linux/smp_lock.h>
> +#include <linux/backing-dev.h>
> +#include <linux/parser.h>
> +#include <asm/uaccess.h>
> +
> +#include <linux/rcfs.h>

asm last please.

> +/*
> + * Address of variable used as flag to indicate a magic file, 
> + * value unimportant
> + */ 
> +int RCFS_IS_MAGIC;

Shouldn't this be static?

And what is a "magic" file used for?  I see where you set something to
point to this, but no where do you check for it.  What's the use of it?

> +int _rcfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
> +{
> +	struct inode *inode;
> +	int error = -EPERM;
> +
> +	if (dentry->d_inode)
> +		return -EEXIST;
> +	inode = rcfs_get_inode(dir->i_sb, mode, dev);
> +	if (inode) {
> +		if (dir->i_mode & S_ISGID) {
> +			inode->i_gid = dir->i_gid;
> +			if (S_ISDIR(mode))
> +				inode->i_mode |= S_ISGID;
> +		}
> +		d_instantiate(dentry, inode);
> +		dget(dentry);
> +		error = 0;
> +	}
> +	return error;
> +}
> +
> +EXPORT_SYMBOL_GPL(_rcfs_mknod);
> +
> +int rcfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
> +{
> +	/* User can only create directories, not files */
> +	if ((mode & S_IFMT) != S_IFDIR)
> +		return -EINVAL;
> +
> +	return dir->i_op->mkdir(dir, dentry, mode);
> +}
> +
> +EXPORT_SYMBOL_GPL(rcfs_mknod);

Why 2 mknod functions?  Do they both really need to be exported?

> +
> +#define MAGIC_SHOW(FUNC)                                               \
> +static int                                                             \

You mix tabs and spaces in your #defines in this file, please just use
tabs properly.

> +static ssize_t
> +target_reclassify_write(struct file *file, const char __user * buf,
> +			size_t count, loff_t * ppos, int manual)
> +{
> +	struct rcfs_inode_info *ri = RCFS_I(file->f_dentry->d_inode);
> +	char *optbuf;
> +	int rc = -EINVAL;
> +	ckrm_classtype_t *clstype;
> +
> +	if ((ssize_t) count < 0 || (ssize_t) count > TARGET_MAX_INPUT_SIZE)
> +		return -EINVAL;

But count is an unsigned variable, right?  How could it ever be
negative?

> +	if (!access_ok(VERIFY_READ, buf, count))
> +		return -EFAULT;
> +	down(&(ri->vfs_inode.i_sem));
> +	optbuf = kmalloc(TARGET_MAX_INPUT_SIZE, GFP_KERNEL);

kmalloc with a lock held?  Is that a good idea?

You also don't check the return value of kmalloc, that's a bad idea.

> +	__copy_from_user(optbuf, buf, count);
> +	if (optbuf[count - 1] == '\n')
> +		optbuf[count - 1] = '\0';

Stripping off a single trailing \n character?  Why?

> +inline struct rcfs_inode_info *RCFS_I(struct inode *inode)
> +{
> +	return container_of(inode, struct rcfs_inode_info, vfs_inode);
> +}
> +
> +EXPORT_SYMBOL_GPL(RCFS_I);

This should be named something sane, and just use a #define for it like
most other container_of() users.

> +void rcfs_destroy_inodecache(void)
> +{
> +	printk(KERN_WARNING "destroy inodecache was called\n");

Do you really want to print this out in "production" code?

> +	if (kmem_cache_destroy(rcfs_inode_cachep))
> +		printk(KERN_INFO
> +		       "rcfs_inode_cache: not all structures were freed\n");

Shouldn't this really be INFO level?  What is a user going to do with
this information?

> +config RCFS_FS
> +	tristate "Resource Class File System (User API)"
> +	depends on CKRM
> +	help
> +	  RCFS is the filesystem API for CKRM. This separate configuration 
> +	  option is provided only for debugging and will eventually disappear 
> +	  since rcfs will be automounted whenever CKRM is configured. 
> +
> +	  Say N if unsure, Y if you've enabled CKRM, M to debug rcfs 
> +	  initialization.
> +

So is this option going to stay around, or should it always be enabled
if CKRM is enabled?  Why not just do that for the user?

thanks,

greg k-h
