Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVGGVfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVGGVfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVGGVeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:34:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:177 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261863AbVGGVb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:31:59 -0400
Date: Thu, 7 Jul 2005 14:31:52 -0700
From: Greg KH <greg@kroah.com>
To: Mike Waychison <mike@waychison.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] add securityfs for all LSMs to use
Message-ID: <20050707213152.GA31664@kroah.com>
References: <20050706081725.GA15544@kroah.com> <42CCB6C6.9040007@waychison.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CCB6C6.9040007@waychison.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 12:59:50AM -0400, Mike Waychison wrote:
> Greg KH wrote:
> > Here's a small patch against 2.6.13-rc2 that adds securityfs, a virtual
> > fs that all LSMs can use instead of creating their own.  The fs should
> > be mounted at /sys/kernel/security, and the fs creates that mount point.
> > This will make the LSB people happy that we aren't creating a new
> > /my_lsm_fs directory in the root for every different LSM.
> 
> How are LSM modules supposed to use these files?  or is that forthcoming?

It's up to them to use it.  See the patches from Serge that convert
seclvl to use it instead of sysfs.

> > +/* SMP-safe */
> > +static int mknod(struct inode *dir, struct dentry *dentry,
> > +			 int mode, dev_t dev)
> > +{
> > +	struct inode *inode = get_inode(dir->i_sb, mode, dev);
> > +	int error = -EPERM;
> > +
> > +	if (dentry->d_inode)
> 
> You leak an inode here.

Thankfully, the code path never actually has a d_inode assigned to the
dentry at this point, so we really don't :)

But I've fixed up the code now so this doesn't come up again (it was
mentioned on kernelnewbies the other day too...)

> > +static int create_by_name(const char *name, mode_t mode,
> > +			  struct dentry *parent,
> > +			  struct dentry **dentry)
> > +{
> > +	int error = 0;
> > +
> > +	/* If the parent is not specified, we create it in the root.
> > +	 * We need the root dentry to do this, which is in the super
> > +	 * block. A pointer to that is in the struct vfsmount that we
> > +	 * have around.
> > +	 */
> > +	if (!parent ) {
> > +		if (mount && mount->mnt_sb) {
> > +			parent = mount->mnt_sb->s_root;
> > +		}
> > +	}
> 
> You should be guaranteed by here that mount is valid due to the
> simple_pin_fs().

It's still good to verify :)

> > +	if (!parent) {
> > +		pr_debug("securityfs: Ah! can not find a parent!\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	*dentry = NULL;
> 
> Not needed?

I've moved it above this if() to be safe.

> > +	down(&parent->d_inode->i_sem);
> > +	*dentry = lookup_one_len(name, parent, strlen(name));
> > +	if (!IS_ERR(dentry)) {
> > +		if ((mode & S_IFMT) == S_IFDIR)
> > +			error = mkdir(parent->d_inode, *dentry, mode);
> > +		else
> > +			error = create(parent->d_inode, *dentry, mode);
> > +	} else
> 
> } else {
> 
> > +		error = PTR_ERR(dentry);
> 
> }

No, not needed.

> > +struct dentry *securityfs_create_file(const char *name, mode_t mode,
> > +				   struct dentry *parent, void *data,
> > +				   struct file_operations *fops)
> > +{
> > +	struct dentry *dentry = NULL;
> > +	int error;
> > +
> > +	pr_debug("securityfs: creating file '%s'\n",name);
> > +
> > +	error = simple_pin_fs("securityfs", &mount, &mount_count);
> > +	if (error) {
> > +		dentry = ERR_PTR(error);
> > +		goto exit;
> > +	}
> > +
> > +	error = create_by_name(name, mode, parent, &dentry);
> > +	if (error) {
> > +		dentry = ERR_PTR(error);
> 
> simple_release_fs

Good catch, fixed now, thanks.

> > +/**
> > + * securityfs_remove - removes a file or directory from the securityfs filesystem
> > + *
> > + * @dentry: a pointer to a the dentry of the file or directory to be
> > + *          removed.
> > + *
> > + * This function removes a file or directory in securityfs that was previously
> > + * created with a call to another securityfs function (like
> > + * securityfs_create_file() or variants thereof.)
> > + *
> > + * This function is required to be called in order for the file to be
> > + * removed, no automatic cleanup of files will happen when a module is
> > + * removed, you are responsible here.
> > + */
> 
> Is this true?  It would appear that this module can't be unloaded until
> all files are _remove'd, no? (due to mount pinning).

No, the files are created by a separate module, so you are correct in
that the security core could not be unloaded (if it could be made a
module.)  The issue is that the modules themselves could be unloaded.
Make sense?

> > +void securityfs_remove(struct dentry *dentry)
> > +{
> > +	struct dentry *parent;
> > +
> > +	if (!dentry)
> > +		return;
> > +
> > +	parent = dentry->d_parent;
> > +	if (!parent || !parent->d_inode)
> > +		return;
> > +
> > +	down(&parent->d_inode->i_sem);
> > +	if (positive(dentry)) {
> > +		if (dentry->d_inode) {
> > +			if (S_ISDIR(dentry->d_inode->i_mode))
> > +				simple_rmdir(parent->d_inode, dentry);
> > +			else
> > +				simple_unlink(parent->d_inode, dentry);
> > +		dput(dentry);
> 
> Indentation?

Yup, fixed now.

> > +		}
> > +	}
> > +	up(&parent->d_inode->i_sem);
> > +	simple_release_fs(&mount, &mount_count);
> > +}
> > +EXPORT_SYMBOL_GPL(securityfs_remove);
> 
> Does EXPORT_SYMBOL(_GPL) even work from a module?   I must be behind the
> times.

Of course it does.  Anyway, this code isn't built as a module, so it's
not really an issue here :)

Thanks for the review and finding those bugs, I really appreciate it.

I'll send out a new version based on your comments in a few minutes.

thanks again,

greg k-h
