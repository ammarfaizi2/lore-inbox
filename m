Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263052AbVGIBNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbVGIBNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbVGIBLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 21:11:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263072AbVGIBLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 21:11:02 -0400
Date: Fri, 8 Jul 2005 18:10:21 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audit@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
       Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050709011021.GC19052@shell0.pdx.osdl.net>
References: <1120668881.8328.1.camel@localhost> <200507061523.11468.tinytim@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061523.11468.tinytim@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Timothy R. Chavez (tinytim@us.ibm.com) wrote:
> @@ -69,6 +70,8 @@ int inode_setattr(struct inode * inode, 
>  	unsigned int ia_valid = attr->ia_valid;
>  	int error = 0;
>  
> +	audit_notify_watch(inode, MAY_WRITE);	
> +

Hmm, this looks wrong.  It should be in notify_change, since I don't
think there's a strict requirement that a fs call inode_setattr, which
is just a commonly used helper.

>  	if (ia_valid & ATTR_SIZE) {
>  		if (attr->ia_size != i_size_read(inode)) {
>  			error = vmtruncate(inode, attr->ia_size);
> diff -Nurp linux-2.6.13-rc1-mm1/fs/namei.c linux-2.6.13-rc1-mm1~auditfs/fs/namei.c
> --- linux-2.6.13-rc1-mm1/fs/namei.c	2011-07-05 01:57:30.000000000 -0500
> +++ linux-2.6.13-rc1-mm1~auditfs/fs/namei.c	2011-07-05 02:01:36.000000000 -0500
> @@ -243,6 +243,8 @@ int permission(struct inode *inode, int 
>  	}
>  
> 
> +	audit_notify_watch(inode, mask);
> +
>  	/* Ordinary permission routines do not understand MAY_APPEND. */
>  	submask = mask & ~MAY_APPEND;
>  	if (inode->i_op && inode->i_op->permission)
> @@ -358,6 +360,8 @@ static inline int exec_permission_lite(s
>  	if (inode->i_op && inode->i_op->permission)
>  		return -EAGAIN;
>  
> +	audit_notify_watch(inode, MAY_EXEC);
> +
>  	if (current->fsuid == inode->i_uid)
>  		mode >>= 6;
>  	else if (in_group_p(inode->i_gid))
> @@ -1188,6 +1192,8 @@ static inline int may_delete(struct inod
>  
>  	BUG_ON(victim->d_parent->d_inode != dir);
>  
> +	audit_notify_watch(victim->d_inode, MAY_WRITE);
> +

I forget why you need two separate notifications on delete?  

>  	error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
>  	if (error)
>  		return error;
> @@ -1312,6 +1318,7 @@ int vfs_create(struct inode *dir, struct
>  	DQUOT_INIT(dir);
>  	error = dir->i_op->create(dir, dentry, mode, nd);
>  	if (!error) {
> +		audit_notify_watch(dentry->d_inode, MAY_WRITE);

And on create.  And, as I've mentioned, these bits could be collapsed
with fsnotify hooks.  I'll split that off from inotify, perhaps you can
work against that...

>  		fsnotify_create(dir, dentry->d_name.name);
>  		security_inode_post_create(dir, dentry, mode);
>  	}
> @@ -1637,6 +1644,7 @@ int vfs_mknod(struct inode *dir, struct 
>  	DQUOT_INIT(dir);
>  	error = dir->i_op->mknod(dir, dentry, mode, dev);
>  	if (!error) {
> +		audit_notify_watch(dentry->d_inode, MAY_WRITE);
>  		fsnotify_create(dir, dentry->d_name.name);
>  		security_inode_post_mknod(dir, dentry, mode, dev);
>  	}
> @@ -1710,6 +1718,7 @@ int vfs_mkdir(struct inode *dir, struct 
>  	DQUOT_INIT(dir);
>  	error = dir->i_op->mkdir(dir, dentry, mode);
>  	if (!error) {
> +		audit_notify_watch(dentry->d_inode, MAY_WRITE);
>  		fsnotify_mkdir(dir, dentry->d_name.name);
>  		security_inode_post_mkdir(dir,dentry, mode);
>  	}
> @@ -1951,6 +1960,7 @@ int vfs_symlink(struct inode *dir, struc
>  	DQUOT_INIT(dir);
>  	error = dir->i_op->symlink(dir, dentry, oldname);
>  	if (!error) {
> +		audit_notify_watch(dentry->d_inode, MAY_WRITE);
>  		fsnotify_create(dir, dentry->d_name.name);
>  		security_inode_post_symlink(dir, dentry, oldname);
>  	}
> @@ -2024,6 +2034,7 @@ int vfs_link(struct dentry *old_dentry, 
>  	error = dir->i_op->link(old_dentry, dir, new_dentry);
>  	up(&old_dentry->d_inode->i_sem);
>  	if (!error) {
> +		audit_notify_watch(new_dentry->d_inode, MAY_WRITE);
>  		fsnotify_create(dir, new_dentry->d_name.name);
>  		security_inode_post_link(old_dentry, dir, new_dentry);
>  	}
> @@ -2147,6 +2158,7 @@ static int vfs_rename_dir(struct inode *
>  	}
>  	if (!error) {
>  		d_move(old_dentry,new_dentry);
> +		audit_notify_watch(old_dentry->d_inode, MAY_WRITE);

Don't you get two identical notifications here (one from permission, and
one from here)?  And where's the update for the new?

>  		security_inode_post_rename(old_dir, old_dentry,
>  					   new_dir, new_dentry);
>  	}
> @@ -2175,6 +2187,7 @@ static int vfs_rename_other(struct inode
>  		/* The following d_move() should become unconditional */
>  		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
>  			d_move(old_dentry, new_dentry);
> +		audit_notify_watch(old_dentry->d_inode, MAY_WRITE);

Same here?

>  		security_inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
>  	}
>  	if (target)
> diff -Nurp linux-2.6.13-rc1-mm1/fs/open.c linux-2.6.13-rc1-mm1~auditfs/fs/open.c
> --- linux-2.6.13-rc1-mm1/fs/open.c	2011-07-05 01:57:31.000000000 -0500
> +++ linux-2.6.13-rc1-mm1~auditfs/fs/open.c	2011-07-05 02:01:36.000000000 -0500
> @@ -25,6 +25,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/syscalls.h>
>  #include <linux/rcupdate.h>
> +#include <linux/audit.h>
>  
>  #include <asm/unistd.h>
>  
> @@ -608,6 +609,8 @@ asmlinkage long sys_fchmod(unsigned int 
>  
>  	dentry = file->f_dentry;
>  	inode = dentry->d_inode;
> +	
> +	audit_notify_watch(inode, MAY_WRITE);

looks like you'll get two updates for these, this should be done in
notify_change.

>  	err = -EROFS;
>  	if (IS_RDONLY(inode))
> @@ -640,6 +643,8 @@ asmlinkage long sys_chmod(const char __u
>  	if (error)
>  		goto out;
>  	inode = nd.dentry->d_inode;
> +	
> +	audit_notify_watch(inode, MAY_WRITE);

ditto

>  	error = -EROFS;
>  	if (IS_RDONLY(inode))
> @@ -674,6 +679,7 @@ static int chown_common(struct dentry * 
>  		printk(KERN_ERR "chown_common: NULL inode\n");
>  		goto out;
>  	}
> +	audit_notify_watch(inode, MAY_WRITE);

ditto, and wouldn't it be useful to know these are attr writes, not just
regular writes?  and what about xattrs?

>  	error = -EROFS;
>  	if (IS_RDONLY(inode))
>  		goto out;
