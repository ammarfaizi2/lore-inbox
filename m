Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVBXJjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVBXJjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVBXJhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:37:47 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8346 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262126AbVBXJdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:33:20 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 4/10 CKRM: Full rcfs support 
In-reply-to: Your message of Mon, 29 Nov 2004 14:15:48 PST.
             <20041129221548.GD19892@kroah.com> 
Date: Thu, 24 Feb 2005 01:33:18 -0800
Message-Id: <E1D4FN0-0006v2-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 14:15:48 PST, Greg KH wrote:
> On Mon, Nov 29, 2004 at 10:48:24AM -0800, Gerrit Huizenga wrote:
> > +#include <linux/module.h>
> > +#include <linux/list.h>
> > +#include <linux/fs.h>
> > +#include <linux/namei.h>
> > +#include <linux/namespace.h>
> > +#include <linux/dcache.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/highmem.h>
> > +#include <linux/init.h>
> > +#include <linux/string.h>
> > +#include <linux/smp_lock.h>
> > +#include <linux/backing-dev.h>
> > +#include <linux/parser.h>
> > +#include <asm/uaccess.h>
> > +
> > +#include <linux/rcfs.h>
> 
> asm last please.
 
Fixed.

> > +/*
> > + * Address of variable used as flag to indicate a magic file, 
> > + * value unimportant
> > + */ 
> > +int RCFS_IS_MAGIC;
> 
> Shouldn't this be static?
 
Nope - used across files.

> And what is a "magic" file used for?  I see where you set something to
> point to this, but no where do you check for it.  What's the use of it?
 
I believe that these are auto-created file entries which are instantiated
when a class is created, hence they "magically" appear.  They are also
special in the sense that they are tied to the life of the class, unlike
other files in the class directories.  The MAGIC value is used to help
distinguish these auto-created entries from other entries in a directory.
This is a little bit like "." and ".." but specific to the class creation.

> > +int _rcfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
> > +{
> > +	struct inode *inode;
> > +	int error = -EPERM;
> > +
> > +	if (dentry->d_inode)
> > +		return -EEXIST;
> > +	inode = rcfs_get_inode(dir->i_sb, mode, dev);
> > +	if (inode) {
> > +		if (dir->i_mode & S_ISGID) {
> > +			inode->i_gid = dir->i_gid;
> > +			if (S_ISDIR(mode))
> > +				inode->i_mode |= S_ISGID;
> > +		}
> > +		d_instantiate(dentry, inode);
> > +		dget(dentry);
> > +		error = 0;
> > +	}
> > +	return error;
> > +}
> > +
> > +EXPORT_SYMBOL_GPL(_rcfs_mknod);
> > +
> > +int rcfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
> > +{
> > +	/* User can only create directories, not files */
> > +	if ((mode & S_IFMT) != S_IFDIR)
> > +		return -EINVAL;
> > +
> > +	return dir->i_op->mkdir(dir, dentry, mode);
> > +}
> > +
> > +EXPORT_SYMBOL_GPL(rcfs_mknod);
> 
> Why 2 mknod functions?  Do they both really need to be exported?
 
I believe they are both exported so resource controllers can create
class specific directories (including corresponding magic files)
in the case of _rcfs_mknod, and rcfs_mknod is the exported fs op
which allows a restricted set of standard user filesystem operations
within the created directory.  So, yes.

> > +
> > +#define MAGIC_SHOW(FUNC)                                               \
> > +static int                                                             \
> 
> You mix tabs and spaces in your #defines in this file, please just use
> tabs properly.
 
Fixed.

> > +static ssize_t
> > +target_reclassify_write(struct file *file, const char __user * buf,
> > +			size_t count, loff_t * ppos, int manual)
> > +{
> > +	struct rcfs_inode_info *ri = RCFS_I(file->f_dentry->d_inode);
> > +	char *optbuf;
> > +	int rc = -EINVAL;
> > +	ckrm_classtype_t *clstype;
> > +
> > +	if ((ssize_t) count < 0 || (ssize_t) count > TARGET_MAX_INPUT_SIZE)
> > +		return -EINVAL;
> 
> But count is an unsigned variable, right?  How could it ever be
> negative?
 
Yep.  But see how those nice casts covered up all the warnings?  ;-)
(Fixed!)

> > +	if (!access_ok(VERIFY_READ, buf, count))
> > +		return -EFAULT;
> > +	down(&(ri->vfs_inode.i_sem));
> > +	optbuf = kmalloc(TARGET_MAX_INPUT_SIZE, GFP_KERNEL);
> 
> kmalloc with a lock held?  Is that a good idea?

Lock?  Or sema?  Sema should be okay here, right?

> You also don't check the return value of kmalloc, that's a bad idea.
 
Yep - good catch.  Fixed.

> > +	__copy_from_user(optbuf, buf, count);
> > +	if (optbuf[count - 1] == '\n')
> > +		optbuf[count - 1] = '\0';
> 
> Stripping off a single trailing \n character?  Why?
 
I believe this is the "echo value > /rcfs/class/magic_file".  If
there is a newline, it would show up as an extra newline during
an ls.  Of course, Shailabh can correct me if I'm wrong on this one.

> > +inline struct rcfs_inode_info *RCFS_I(struct inode *inode)
> > +{
> > +	return container_of(inode, struct rcfs_inode_info, vfs_inode);
> > +}
> > +
> > +EXPORT_SYMBOL_GPL(RCFS_I);
> 
> This should be named something sane, and just use a #define for it like
> most other container_of() users.

Stupid name gone.  I didn't grok the need for the #define though?

> > +void rcfs_destroy_inodecache(void)
> > +{
> > +	printk(KERN_WARNING "destroy inodecache was called\n");
> 
> Do you really want to print this out in "production" code?
 
Nope.  Fixed.

> > +	if (kmem_cache_destroy(rcfs_inode_cachep))
> > +		printk(KERN_INFO
> > +		       "rcfs_inode_cache: not all structures were freed\n");
> 
> Shouldn't this really be INFO level?  What is a user going to do with
> this information?
> 
> > +config RCFS_FS
> > +	tristate "Resource Class File System (User API)"
> > +	depends on CKRM
> > +	help
> > +	  RCFS is the filesystem API for CKRM. This separate configuration 
> > +	  option is provided only for debugging and will eventually disappear 
> > +	  since rcfs will be automounted whenever CKRM is configured. 
> > +
> > +	  Say N if unsure, Y if you've enabled CKRM, M to debug rcfs 
> > +	  initialization.
> > +
> 
> So is this option going to stay around, or should it always be enabled
> if CKRM is enabled?  Why not just do that for the user?

It may be a module, but yes, this should be auto-set in the future when
CKRM is enabled.

gerrit
