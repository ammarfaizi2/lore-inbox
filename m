Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVATPHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVATPHO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVATPHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:07:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:5587 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262147AbVATPG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:06:56 -0500
Date: Thu, 20 Jan 2005 07:06:46 -0800
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux for 2.6.10: lean and mean
Message-ID: <20050120150646.GG13036@kroah.com>
References: <41EF4E74.2000304@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EF4E74.2000304@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 01:23:48AM -0500, Karim Yaghmour wrote:
> +static struct inode *
> +relayfs_get_inode(struct super_block *sb, int mode, dev_t dev)
> +{
> +	struct inode * inode;
> +
> +	inode = new_inode(sb);
> +
> +	if (inode) {
> +		inode->i_mode = mode;
> +		inode->i_uid = current->fsuid;
> +		inode->i_gid = current->fsgid;

Are you sure you want these two fields set to the value of current-> ?

> +/*
> + * File creation. Allocate an inode, and we're done..
> + */
> +/* SMP-safe */
> +static int
> +relayfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
> +{
> +	struct inode * inode;
> +	int error = -ENOSPC;
> +
> +	inode = relayfs_get_inode(dir->i_sb, mode, dev);

Need to check for dentry->d_inode here before using it.

> +	if (inode) {
> +		d_instantiate(dentry, inode);
> +		dget(dentry);	/* Extra count - pin the dentry in core */
> +		error = 0;
> +	}
> +	return error;
> +}
> +
> +static int
> +relayfs_mkdir(struct inode * dir, struct dentry * dentry, int mode)
> +{
> +	int retval;
> +
> +	retval = relayfs_mknod(dir, dentry, mode | S_IFDIR, 0);

(mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR
instead of just | with S_IFDIR, right?

> +
> +	if (!retval)
> +		dir->i_nlink++;
> +	return retval;
> +}
> +
> +static int
> +relayfs_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *nd)
> +{
> +	return relayfs_mknod(dir, dentry, mode | S_IFREG, 0);

(mode & S_IALLUGO) | S_IFREG
here too, to be safe, right?

> +}
> +
> +static int
> +relayfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
> +{
> +	struct inode *inode;
> +	int error = -ENOSPC;
> +
> +	inode = relayfs_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
> +
> +	if (inode) {
> +		int l = strlen(symname)+1;
> +		error = page_symlink(inode, symname, l);
> +		if (!error) {
> +			d_instantiate(dentry, inode);
> +			dget(dentry);
> +		} else
> +			iput(inode);
> +	}
> +	return error;
> +}

Why do you want to allow symlinks in relayfs?

> +
> +/**
> + *	relayfs_create_entry - create a relayfs directory or file
> + *	@name: the name of the file to create
> + *	@parent: parent directory
> + *	@dentry: result dentry
> + *	@entry_type: type of file to create (S_IFREG, S_IFDIR)
> + *	@mode: mode
> + *	@data: data to associate with the file
> + *
> + *	Creates a file or directory with the specifed permissions.
> + */
> +static int
> +relayfs_create_entry(const char * name, struct dentry * parent, struct dentry **dentry, int entry_type, int mode, void * data)
> +{
> +	struct qstr qname;
> +	struct dentry * d;
> +
> +	int error = 0;
> +
> +	error = simple_pin_fs("relayfs", &relayfs_mount, &relayfs_mount_count);
> +	if (error) {
> +		printk(KERN_ERR "Couldn't mount relayfs: errcode %d\n", error);
> +		return error;
> +	}
> +
> +	qname.name = name;
> +	qname.len = strlen(name);
> +	qname.hash = full_name_hash(name, qname.len);
> +
> +	if (parent == NULL)
> +		if (relayfs_mount && relayfs_mount->mnt_sb)
> +			parent = relayfs_mount->mnt_sb->s_root;
> +
> +	if (parent == NULL) {
> +		simple_release_fs(&relayfs_mount, &relayfs_mount_count);
> + 		return -EINVAL;
> +	}
> +
> +	parent = dget(parent);
> +	down(&parent->d_inode->i_sem);
> +	d = lookup_hash(&qname, parent);
> +	if (IS_ERR(d)) {
> +		error = PTR_ERR(d);
> +		goto release_mount;
> +	}
> +
> +	if (d->d_inode) {
> +		error = -EEXIST;
> +		goto release_mount;
> +	}
> +
> +	if (entry_type == S_IFREG)
> +		error = relayfs_create(parent->d_inode, d, entry_type | mode, NULL);
> +	else
> +		error = relayfs_mkdir(parent->d_inode, d, entry_type | mode);

Why not just go off of the mode here?  That would let you get rid of a
paramater, as you need mode to be set properly anyway for directories.



> +	if (error)
> +		goto release_mount;
> +
> +	if ((entry_type == S_IFREG) && data) {
> +		d->d_inode->u.generic_ip = data;
> +		goto exit; /* don't release mount for regular files */
> +	}

Same here.

thanks,

greg k-h
