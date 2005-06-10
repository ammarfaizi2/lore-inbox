Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVFJXfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVFJXfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVFJXei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:34:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261438AbVFJX2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:28:52 -0400
Date: Fri, 10 Jun 2005 16:28:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Steve Grubb <sgrubb@redhat.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Mounir Bsaibes <bsaibes@us.ibm.com>
Subject: Re: [RFC][PATCH] filesystem auditing by location+name
Message-ID: <20050610232809.GC9046@shell0.pdx.osdl.net>
References: <200506101728.25709.tinytim@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506101728.25709.tinytim@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps you could describe any specific reasons inotify isn't sufficient,
as it's similar in many ways.

Also, could drop some of that extra debugging code (heh, like that MKDEV
in audit_inode_free ;-)

Anyway, some quick comments below...

> diff -Nurp audit-2.6.git/fs/dcache.c audit-2.6.git~tc/fs/dcache.c
> --- audit-2.6.git/fs/dcache.c	2005-06-07 13:53:54.000000000 -0500
> +++ audit-2.6.git~tc/fs/dcache.c	2005-06-09 10:09:51.000000000 -0500
> @@ -32,6 +32,7 @@
>  #include <linux/seqlock.h>
>  #include <linux/swap.h>
>  #include <linux/bootmem.h>
> +#include <linux/audit.h>
>  
>  /* #define DCACHE_DEBUG 1 */
>  
> @@ -97,6 +98,7 @@ static inline void dentry_iput(struct de
>  {
>  	struct inode *inode = dentry->d_inode;
>  	if (inode) {
> +		audit_update_watch(dentry, AUDIT_UPDATE_REMOVE);
>  		dentry->d_inode = NULL;
>  		list_del_init(&dentry->d_alias);
>  		spin_unlock(&dentry->d_lock);
> @@ -802,6 +804,7 @@ void d_instantiate(struct dentry *entry,
>  	if (inode)
>  		list_add(&entry->d_alias, &inode->i_dentry);
>  	entry->d_inode = inode;
> +	audit_update_watch(entry, AUDIT_UPDATE_NORMAL);
>  	spin_unlock(&dcache_lock);
>  	security_d_instantiate(entry, inode);
>  }
> @@ -978,6 +981,7 @@ struct dentry *d_splice_alias(struct ino
>  		new = __d_find_alias(inode, 1);
>  		if (new) {
>  			BUG_ON(!(new->d_flags & DCACHE_DISCONNECTED));
> +			audit_update_watch(new, AUDIT_UPDATE_NORMAL);
>  			spin_unlock(&dcache_lock);
>  			security_d_instantiate(new, inode);
>  			d_rehash(dentry);
> @@ -987,6 +991,7 @@ struct dentry *d_splice_alias(struct ino
>  			/* d_instantiate takes dcache_lock, so we do it by hand */
>  			list_add(&dentry->d_alias, &inode->i_dentry);
>  			dentry->d_inode = inode;
> +			audit_update_watch(dentry, AUDIT_UPDATE_NORMAL);
>  			spin_unlock(&dcache_lock);
>  			security_d_instantiate(dentry, inode);
>  			d_rehash(dentry);
> @@ -1090,6 +1095,7 @@ struct dentry * __d_lookup(struct dentry
>  		if (!d_unhashed(dentry)) {
>  			atomic_inc(&dentry->d_count);
>  			found = dentry;
> +			audit_update_watch(dentry, AUDIT_UPDATE_NORMAL);
>  		}
>  		spin_unlock(&dentry->d_lock);
>  		break;
> @@ -1299,6 +1305,8 @@ void d_move(struct dentry * dentry, stru
>  		spin_lock(&target->d_lock);
>  	}
>  
> +	audit_update_watch(dentry, AUDIT_UPDATE_REMOVE);
> +
>  	/* Move the dentry to the target hash queue, if on different bucket */
>  	if (dentry->d_flags & DCACHE_UNHASHED)
>  		goto already_unhashed;
> @@ -1332,6 +1340,7 @@ already_unhashed:
>  		list_add(&target->d_child, &target->d_parent->d_subdirs);
>  	}
>  
> +	audit_update_watch(dentry, AUDIT_UPDATE_NORMAL);
>  	list_add(&dentry->d_child, &dentry->d_parent->d_subdirs);
>  	spin_unlock(&target->d_lock);
>  	spin_unlock(&dentry->d_lock);
> diff -Nurp audit-2.6.git/fs/inode.c audit-2.6.git~tc/fs/inode.c
> --- audit-2.6.git/fs/inode.c	2005-06-07 13:53:54.000000000 -0500
> +++ audit-2.6.git~tc/fs/inode.c	2005-06-08 11:05:20.000000000 -0500
> @@ -21,6 +21,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/cdev.h>
>  #include <linux/bootmem.h>
> +#include <linux/audit.h>
>  
>  /*
>   * This is needed for the following functions:
> @@ -172,6 +173,7 @@ void destroy_inode(struct inode *inode) 
>  {
>  	if (inode_has_buffers(inode))
>  		BUG();
> +	audit_inode_free(inode);
>  	security_inode_free(inode);
>  	if (inode->i_sb->s_op->destroy_inode)
>  		inode->i_sb->s_op->destroy_inode(inode);
> @@ -257,7 +259,7 @@ void clear_inode(struct inode *inode)
>  		bd_forget(inode);
>  	if (inode->i_cdev)
>  		cd_forget(inode);
> -	inode->i_state = I_CLEAR;
> +	inode->i_state = I_CLEAR | (inode->i_state & I_AUDIT);
>  }
>  
>  EXPORT_SYMBOL(clear_inode);
> @@ -1009,7 +1011,7 @@ void generic_delete_inode(struct inode *
>  	hlist_del_init(&inode->i_hash);
>  	spin_unlock(&inode_lock);
>  	wake_up_inode(inode);
> -	if (inode->i_state != I_CLEAR)
> +	if ((inode->i_state & ~I_AUDIT) != I_CLEAR)
>  		BUG();
>  	destroy_inode(inode);
>  }
> @@ -1323,6 +1325,7 @@ void __init inode_init(unsigned long mem
>  	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
>  				0, SLAB_RECLAIM_ACCOUNT|SLAB_PANIC, init_once, NULL);
>  	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
> +	audit_filesystem_init();
>  
>  	/* Hash may have been set up in inode_init_early */
>  	if (!hashdist)
> diff -Nurp audit-2.6.git/fs/namei.c audit-2.6.git~tc/fs/namei.c
> --- audit-2.6.git/fs/namei.c	2005-06-07 13:53:54.000000000 -0500
> +++ audit-2.6.git~tc/fs/namei.c	2005-06-10 11:28:00.000000000 -0500
> @@ -179,6 +179,9 @@ int generic_permission(struct inode *ino
>  		int (*check_acl)(struct inode *inode, int mask))
>  {
>  	umode_t			mode = inode->i_mode;
> +	
> +	if (audit_notify_watch(inode, mask))
> +		return -ENOMEM;

Why here?  Filesystems that don't use generic_permission() won't get
watched.

>  	if (current->fsuid == inode->i_uid)
>  		mode >>= 6;
> @@ -358,6 +361,9 @@ static inline int exec_permission_lite(s
>  	if (inode->i_op && inode->i_op->permission)
>  		return -EAGAIN;
>  
> +	if (audit_notify_watch(inode, MAY_EXEC))
> +		return -ENOMEM;
> +
>  	if (current->fsuid == inode->i_uid)
>  		mode >>= 6;
>  	else if (in_group_p(inode->i_gid))
> @@ -1172,6 +1178,10 @@ static inline int may_delete(struct inod
>  
>  	BUG_ON(victim->d_parent->d_inode != dir);
>  
> +	error = audit_notify_watch(victim->d_inode, MAY_WRITE);
> +	if (error)
> +		return error;

This looks like you'd potentially get two audit records, one for file
and one for parent dir (the second coming from normal permission() call
below).  Intentional?

> +
>  	error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
>  	if (error)
>  		return error;
> @@ -1295,6 +1305,8 @@ int vfs_create(struct inode *dir, struct
>  		return error;
>  	DQUOT_INIT(dir);
>  	error = dir->i_op->create(dir, dentry, mode, nd);
> +	if (!error)
> +		error =	audit_notify_watch(dentry->d_inode, MAY_WRITE);

This doesn't look right.  The thing was created, but just because
audit_notify_watch() failed, dnotify and security modules are never
informed.

>  	if (!error) {
>  		inode_dir_notify(dir, DN_CREATE);
>  		security_inode_post_create(dir, dentry, mode);
> @@ -1601,6 +1613,8 @@ int vfs_mknod(struct inode *dir, struct 
>  
>  	DQUOT_INIT(dir);
>  	error = dir->i_op->mknod(dir, dentry, mode, dev);
> +	if (!error)
> +		error = audit_notify_watch(dentry->d_inode, MAY_WRITE);

same here.

>  	if (!error) {
>  		inode_dir_notify(dir, DN_CREATE);
>  		security_inode_post_mknod(dir, dentry, mode, dev);
> @@ -1674,6 +1688,8 @@ int vfs_mkdir(struct inode *dir, struct 
>  
>  	DQUOT_INIT(dir);
>  	error = dir->i_op->mkdir(dir, dentry, mode);
> +	if (!error)
> +		error = audit_notify_watch(dentry->d_inode, MAY_WRITE);

and here

>  	if (!error) {
>  		inode_dir_notify(dir, DN_CREATE);
>  		security_inode_post_mkdir(dir,dentry, mode);
> @@ -1914,6 +1930,8 @@ int vfs_symlink(struct inode *dir, struc
>  
>  	DQUOT_INIT(dir);
>  	error = dir->i_op->symlink(dir, dentry, oldname);
> +	if (!error)
> +		error = audit_notify_watch(dentry->d_inode, MAY_WRITE);

and the rest of these...

>  	if (!error) {
>  		inode_dir_notify(dir, DN_CREATE);
>  		security_inode_post_symlink(dir, dentry, oldname);
> @@ -1987,6 +2005,8 @@ int vfs_link(struct dentry *old_dentry, 
>  	DQUOT_INIT(dir);
>  	error = dir->i_op->link(old_dentry, dir, new_dentry);
>  	up(&old_dentry->d_inode->i_sem);
> +	if (!error)
> +		error = audit_notify_watch(new_dentry->d_inode, MAY_WRITE);
>  	if (!error) {
>  		inode_dir_notify(dir, DN_CREATE);
>  		security_inode_post_link(old_dentry, dir, new_dentry);
> @@ -2109,11 +2129,13 @@ static int vfs_rename_dir(struct inode *
>  			d_rehash(new_dentry);
>  		dput(new_dentry);
>  	}
> -	if (!error) {
> +	if (!error)
>  		d_move(old_dentry,new_dentry);
> +
> +	error = audit_notify_watch(old_dentry->d_inode, MAY_WRITE);
> +	if (!error)
>  		security_inode_post_rename(old_dir, old_dentry,
>  					   new_dir, new_dentry);
> -	}
>  	return error;
>  }
>  
> @@ -2139,8 +2161,12 @@ static int vfs_rename_other(struct inode
>  		/* The following d_move() should become unconditional */
>  		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
>  			d_move(old_dentry, new_dentry);
> -		security_inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
>  	}
> +
> +	error = audit_notify_watch(old_dentry->d_inode, MAY_WRITE);
> +	if (!error)
> +		security_inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
> +
>  	if (target)
>  		up(&target->i_sem);
>  	dput(new_dentry);

> diff -Nurp audit-2.6.git/init/Kconfig audit-2.6.git~tc/init/Kconfig
> --- audit-2.6.git/init/Kconfig	2005-06-07 13:53:54.000000000 -0500
> +++ audit-2.6.git~tc/init/Kconfig	2005-06-10 09:40:39.000000000 -0500
> @@ -166,6 +166,7 @@ config AUDIT
>  	bool "Auditing support"
>  	depends on NET
>  	default y if SECURITY_SELINUX
> +	default n
>  	help
>  	  Enable auditing infrastructure that can be used with another
>  	  kernel subsystem, such as SELinux (which requires this for
> @@ -176,11 +177,22 @@ config AUDITSYSCALL
>  	bool "Enable system-call auditing support"
>  	depends on AUDIT && (X86 || PPC || PPC64 || ARCH_S390 || IA64 || UML)
>  	default y if SECURITY_SELINUX
> +	default n

Why these default changes?

>  	help
>  	  Enable low-overhead system-call auditing infrastructure that
>  	  can be used independently or with another kernel subsystem,
>  	  such as SELinux.
>  
> +config AUDITFILESYSTEM
> +	bool "Enable file system auditing support"
> +	depends on AUDITSYSCALL
> +	default n
> +	help
> +	  Enable file system auditing for regular files and directories.
> +	  When a targeted file or directory is accessed, an audit record
> +	  is generated describing the inode accessed, how it was accessed,
> +	  and by whom (ie: pid and system call).
> +
>  config HOTPLUG
>  	bool "Support for hot-pluggable devices" if !ARCH_S390
>  	default ARCH_S390
> diff -Nurp audit-2.6.git/kernel/auditfs.c audit-2.6.git~tc/kernel/auditfs.c
> --- audit-2.6.git/kernel/auditfs.c	1969-12-31 18:00:00.000000000 -0600
> +++ audit-2.6.git~tc/kernel/auditfs.c	2005-06-10 10:43:22.000000000 -0500
> +/* Convert a watch_transport structure into a kernel audit_watch structure. */
> +static inline struct audit_watch *audit_to_watch(void *memblk)

This should not be untyped.

> +{
> +	unsigned int offset;
> +	struct watch_transport *t;
> +	struct audit_watch *watch;
> +
> +	watch = audit_watch_alloc();
> +	if (!watch)
> +		goto audit_to_watch_exit;
> +
> +	t = memblk;
> +
> +	watch->w_perms = t->perms;
> +
> +	offset = sizeof(struct watch_transport);
> +	watch->w_filterkey = kmalloc(t->fklen+1, GFP_KERNEL);
> +	if (!watch->w_filterkey)
> +		goto audit_to_watch_fail;
> +	watch->w_filterkey[t->fklen] = 0;
> +	memcpy(watch->w_filterkey, memblk + offset, t->fklen);
> +
> +	offset += t->fklen;
> +	watch->w_path = kmalloc(t->pathlen+1, GFP_KERNEL);
> +	if (!watch->w_path)
> +		goto audit_to_watch_fail;
> +	watch->w_path[t->pathlen] = 0;
> +	memcpy(watch->w_path, memblk + offset, t->pathlen);
> +
> +	goto audit_to_watch_exit;

typically label and return would just go here.

audit_to_watch_exit:
	return watch;

> +
> +audit_to_watch_fail:
> +	audit_watch_free(watch);
> +	watch = NULL;
> +audit_to_watch_exit:
> +	return watch;
> +}
> +
> diff -Nurp audit-2.6.git/kernel/auditsc.c audit-2.6.git~tc/kernel/auditsc.c
> --- audit-2.6.git/kernel/auditsc.c	2005-06-09 13:47:02.000000000 -0500
> +++ audit-2.6.git~tc/kernel/auditsc.c	2005-06-10 16:32:57.000000000 -0500
> @@ -102,8 +102,6 @@ struct audit_aux_data {
>  	int			type;
>  };
>  
> -#define AUDIT_AUX_IPCPERM	0
> -

This looks unrelated (albeit unused)

>  struct audit_aux_data_ipcctl {
>  	struct audit_aux_data	d;
>  	struct ipc_perm		p;
> @@ -131,6 +129,17 @@ struct audit_aux_data_path {
>  	struct vfsmount		*mnt;
>  };
>  
> +struct audit_aux_data_watched {
> +	struct audit_aux_data	link;
> +	struct hlist_head	watches;
> +	unsigned long		ino;
> +	int			mask;
> +	uid_t			uid;
> +	gid_t			gid;
> +	dev_t			dev;
> +	dev_t			rdev;
> +};
> +
>  /* The per-task audit context. */
>  struct audit_context {
>  	int		    in_syscall;	/* 1 if task is in a syscall */
> @@ -248,6 +257,7 @@ static inline int audit_del_rule(struct 
>  	return -EFAULT;		/* No matching rule */
>  }
>  
> +#ifdef CONFIG_NET

We've dropped these #ifdefs, we rely on netlink and skb's.

>  /* Copy rule from user-space to kernel-space.  Called during
>   * AUDIT_ADD. */
>  static int audit_copy_rule(struct audit_rule *d, struct audit_rule *s)
> @@ -328,6 +338,7 @@ int audit_receive_filter(int type, int p
>  
>  	return err;
>  }
> +#endif


> +#ifdef CONFIG_AUDITFILESYSTEM
> +/* This has to be here instead of in auditfs.c, because it needs to
> +   see the audit context */
> +int auditfs_attach_wdata(struct inode *inode, struct hlist_head *watches,
> +			 int mask)
> +{
> +	struct audit_context *context = current->audit_context;
> +	struct audit_aux_data_watched *ax;
> +	struct audit_watch *watch;
> +	struct audit_watch_info *this, *winfo;
> +	struct hlist_node *pos, *tmp;
> +
> +	ax = kmalloc(sizeof(*ax), GFP_KERNEL);
> +	if (!ax)
> +		return -ENOMEM;
> +
> +	if (context->in_syscall && !context->auditable)
> +		context->auditable = 1;
> +
> +	INIT_HLIST_HEAD(&ax->watches);
> +
> +	hlist_for_each_entry(watch, pos, watches, w_watched) {
> +		winfo = kmalloc(sizeof(struct audit_watch_info), GFP_KERNEL);
> +		if (!winfo)
> +			goto auditfs_attach_wdata_fail;
> +		if (mask && (watch->w_perms && !(watch->w_perms&mask)))
> +			continue;
> +		winfo->watch = audit_watch_get(watch);
> +		hlist_add_head(&winfo->node, &ax->watches);
> +	}
> +
> +	ax->mask = mask;
> +	ax->ino = inode->i_ino;
> +	ax->uid = inode->i_uid;
> +	ax->gid = inode->i_gid;
> +	ax->dev = inode->i_sb->s_dev;
> +	ax->rdev = inode->i_rdev;
> +
> +	ax->link.type = AUDIT_FS_INODE;
> +	ax->link.next = context->aux;
> +	context->aux = (void *)ax;
> +
> +	return 0;
> +
> +auditfs_attach_wdata_fail:
> +	hlist_for_each_entry_safe(this, pos, tmp, &ax->watches, node) {
> +		hlist_del(&this->node);
> +		audit_watch_put(this->watch);
> +		kfree(this);
> +	}

looks like it leaks 'ax' in error path

> +	return -ENOMEM;
> +}
