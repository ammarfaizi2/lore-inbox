Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVBXRxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVBXRxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVBXRxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:53:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:4558 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262433AbVBXRwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:52:37 -0500
Date: Thu, 24 Feb 2005 09:42:30 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 4/10 CKRM: Full rcfs support
Message-ID: <20050224174230.GA10244@kroah.com>
References: <20041129221548.GD19892@kroah.com> <E1D4FN0-0006v2-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D4FN0-0006v2-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 01:33:18AM -0800, Gerrit Huizenga wrote:
> On Mon, 29 Nov 2004 14:15:48 PST, Greg KH wrote:
> > > +/*
> > > + * Address of variable used as flag to indicate a magic file, 
> > > + * value unimportant
> > > + */ 
> > > +int RCFS_IS_MAGIC;
> > 
> > Shouldn't this be static?
>  
> Nope - used across files.

It shouldn't be.

> > And what is a "magic" file used for?  I see where you set something to
> > point to this, but no where do you check for it.  What's the use of it?
>  
> I believe that these are auto-created file entries which are instantiated
> when a class is created, hence they "magically" appear.  They are also
> special in the sense that they are tied to the life of the class, unlike
> other files in the class directories.  The MAGIC value is used to help
> distinguish these auto-created entries from other entries in a directory.
> This is a little bit like "." and ".." but specific to the class creation.

That is just wrong.

> > > +int _rcfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
> > > +{
> > > +	struct inode *inode;
> > > +	int error = -EPERM;
> > > +
> > > +	if (dentry->d_inode)
> > > +		return -EEXIST;
> > > +	inode = rcfs_get_inode(dir->i_sb, mode, dev);
> > > +	if (inode) {
> > > +		if (dir->i_mode & S_ISGID) {
> > > +			inode->i_gid = dir->i_gid;
> > > +			if (S_ISDIR(mode))
> > > +				inode->i_mode |= S_ISGID;
> > > +		}
> > > +		d_instantiate(dentry, inode);
> > > +		dget(dentry);
> > > +		error = 0;
> > > +	}
> > > +	return error;
> > > +}
> > > +
> > > +EXPORT_SYMBOL_GPL(_rcfs_mknod);
> > > +
> > > +int rcfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
> > > +{
> > > +	/* User can only create directories, not files */
> > > +	if ((mode & S_IFMT) != S_IFDIR)
> > > +		return -EINVAL;
> > > +
> > > +	return dir->i_op->mkdir(dir, dentry, mode);
> > > +}
> > > +
> > > +EXPORT_SYMBOL_GPL(rcfs_mknod);
> > 
> > Why 2 mknod functions?  Do they both really need to be exported?
>  
> I believe they are both exported so resource controllers can create
> class specific directories (including corresponding magic files)
> in the case of _rcfs_mknod, and rcfs_mknod is the exported fs op
> which allows a restricted set of standard user filesystem operations
> within the created directory.  So, yes.

Then name the functions sanely.  As it is, they are not descriptive of
what they actually do at all.

> > > +	__copy_from_user(optbuf, buf, count);
> > > +	if (optbuf[count - 1] == '\n')
> > > +		optbuf[count - 1] = '\0';
> > 
> > Stripping off a single trailing \n character?  Why?
>  
> I believe this is the "echo value > /rcfs/class/magic_file".  If
> there is a newline, it would show up as an extra newline during
> an ls.  Of course, Shailabh can correct me if I'm wrong on this one.

So what if a user adds 2 \n to the end of the string.  You missed that
one.  If you are going to try to protect the names of your files, don't
do it half-hearted...

> > > +inline struct rcfs_inode_info *RCFS_I(struct inode *inode)
> > > +{
> > > +	return container_of(inode, struct rcfs_inode_info, vfs_inode);
> > > +}
> > > +
> > > +EXPORT_SYMBOL_GPL(RCFS_I);
> > 
> > This should be named something sane, and just use a #define for it like
> > most other container_of() users.
> 
> Stupid name gone.  I didn't grok the need for the #define though?

Use a #define, not a inline function for this, like everyone else in the
kernel does for their container_of macros.  Actually inline functions
can't be exported anyway...

> > > +config RCFS_FS
> > > +	tristate "Resource Class File System (User API)"
> > > +	depends on CKRM
> > > +	help
> > > +	  RCFS is the filesystem API for CKRM. This separate configuration 
> > > +	  option is provided only for debugging and will eventually disappear 
> > > +	  since rcfs will be automounted whenever CKRM is configured. 
> > > +
> > > +	  Say N if unsure, Y if you've enabled CKRM, M to debug rcfs 
> > > +	  initialization.
> > > +
> > 
> > So is this option going to stay around, or should it always be enabled
> > if CKRM is enabled?  Why not just do that for the user?
> 
> It may be a module, but yes, this should be auto-set in the future when
> CKRM is enabled.

Then fix it?  :)

greg k-h
