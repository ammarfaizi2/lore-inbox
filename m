Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVAJWGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVAJWGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbVAJV6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:58:53 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:49091 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262514AbVAJVlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:41:06 -0500
Date: Mon, 10 Jan 2005 16:40:36 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 2/11] FUSE - core
In-reply-to: <E1Co4kB-00044r-00@dorka.pomaz.szeredi.hu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <41E2F654.5090707@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <E1Co4kB-00044r-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Miklos Szeredi wrote:
> This patch adds FUSE core.
> 
> This contains the following files:
> 
>  o inode.c
>     - superblock operations (alloc_inode, destroy_inode, read_inode,
>       clear_inode, put_super, show_options)
>     - registers FUSE filesystem
> 
>  o fuse_i.h
>     - private header file
> 
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> diff -Nurp a/fs/fuse/Makefile b/fs/fuse/Makefile
> --- a/fs/fuse/Makefile	1970-01-01 01:00:00.000000000 +0100
> +++ b/fs/fuse/Makefile	2005-01-10 19:28:38.000000000 +0100
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for the FUSE filesystem.
> +#
> +
> +obj-$(CONFIG_FUSE) += fuse.o
> +
> +fuse-objs := inode.o
> diff -Nurp a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> --- a/fs/fuse/fuse_i.h	1970-01-01 01:00:00.000000000 +0100
> +++ b/fs/fuse/fuse_i.h	2005-01-10 19:28:38.000000000 +0100
> @@ -0,0 +1,90 @@
> +/*
> +  FUSE: Filesystem in Userspace
> +  Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
> +
> +  This program can be distributed under the terms of the GNU GPL.
> +  See the file COPYING.
> +*/
> +
> +#include <linux/fuse.h>
> +#include <linux/fs.h>
> +#include <linux/wait.h>
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/mm.h>
> +#include <linux/backing-dev.h>
> +#include <asm/semaphore.h>
> +
> +/** FUSE specific inode data */
> +struct fuse_inode {
> +	/** Unique ID, which identifies the inode between userspace
> +	 * and kernel */
> +	u64 nodeid;
> +
> +	/** Time in jiffies until the file attributes are valid */
> +	unsigned long i_time;
> +};
> +
> +/**
> + * A Fuse connection.
> + *
> + * This structure is created, when the filesystem is mounted, and is
> + * destroyed, when the client device is closed and the filesystem is
> + * unmounted.
> + */
> +struct fuse_conn {
> +	/** The superblock of the mounted filesystem */
> +	struct super_block *sb;
> +
> +	/** The user id for this mount */
> +	uid_t user_id;
> +
> +	/** Backing dev info */
> +	struct backing_dev_info bdi;
> +};
> +
> +static inline struct fuse_conn **get_fuse_conn_super_p(struct super_block *sb)
> +{
> +	return (struct fuse_conn **) &sb->s_fs_info;
> +}
> +
> +static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
> +{
> +	return *get_fuse_conn_super_p(sb);
> +}
> +
> +static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
> +{
> +	return get_fuse_conn_super(inode->i_sb);
> +}
> +
> +static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
> +{
> +	return (struct fuse_inode *) (&inode[1]);
> +}
> +
> +static inline u64 get_node_id(struct inode *inode)
> +{
> +	return get_fuse_inode(inode)->nodeid;
> +}
> +
> +/**
> + * This is the single global spinlock which protects FUSE's structures
> + *
> + * The following data is protected by this lock:
> + *
> + *  - the private_data field of the device file
> + *  - the s_fs_info field of the super block
> + *  - unused_list, pending, processing lists in fuse_conn
> + *  - the unique request ID counter reqctr in fuse_conn
> + *  - the sb (super_block) field in fuse_conn
> + *  - the file (device file) field in fuse_conn
> + */

These comments seem out of date.  There is no unused_lsit, pending or
processing lists in fuse_conn.  Nor is there a reqctr or file.

> +extern spinlock_t fuse_lock;
> +
> +/**
> + * Check if the connection can be released, and if yes, then free the
> + * connection structure
> + */
> +void fuse_release_conn(struct fuse_conn *fc);
> +
> diff -Nurp a/fs/fuse/inode.c b/fs/fuse/inode.c
> --- a/fs/fuse/inode.c	1970-01-01 01:00:00.000000000 +0100
> +++ b/fs/fuse/inode.c	2005-01-10 19:28:38.000000000 +0100
> @@ -0,0 +1,427 @@
> +/*
> +  FUSE: Filesystem in Userspace
> +  Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
> +
> +  This program can be distributed under the terms of the GNU GPL.
> +  See the file COPYING.
> +*/
> +
> +#include "fuse_i.h"
> +
> +#include <linux/pagemap.h>
> +#include <linux/slab.h>
> +#include <linux/file.h>
> +#include <linux/mount.h>
> +#include <linux/seq_file.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/parser.h>
> +#include <linux/statfs.h>
> +
> +MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> +MODULE_DESCRIPTION("Filesystem in Userspace");
> +MODULE_LICENSE("GPL");
> +
> +spinlock_t fuse_lock;
> +static kmem_cache_t *fuse_inode_cachep;
> +static int mount_count;
> +
> +static int mount_max = 1000;
> +module_param(mount_max, int, 0644);
> +MODULE_PARM_DESC(mount_max, "Maximum number of FUSE mounts allowed, if -1 then unlimited (default: 1000)");
> +
> +#define FUSE_SUPER_MAGIC 0x65735546
> +
> +struct fuse_mount_data {
> +	int fd;
> +	unsigned rootmode;
> +	unsigned user_id;
> +};
> +
> +static struct inode *fuse_alloc_inode(struct super_block *sb)
> +{
> +	struct inode *inode;
> +	struct fuse_inode *fi;
> +
> +	inode = kmem_cache_alloc(fuse_inode_cachep, SLAB_KERNEL);
> +	if (!inode)
> +		return NULL;
> +
> +	fi = get_fuse_inode(inode);
> +	memset(fi, 0, sizeof(*fi));
> +
> +	return inode;
> +}
> +
> +static void fuse_destroy_inode(struct inode *inode)
> +{
> +	kmem_cache_free(fuse_inode_cachep, inode);
> +}
> +
> +static void fuse_read_inode(struct inode *inode)
> +{
> +	/* No op */
> +}
> +
> +static void fuse_clear_inode(struct inode *inode)
> +{
> +}
> +
> +void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr)
> +{
> +	if (S_ISREG(inode->i_mode) && i_size_read(inode) != attr->size)
> +		invalidate_inode_pages(inode->i_mapping);
> +
> +	inode->i_ino     = attr->ino;
> +	inode->i_mode    = (inode->i_mode & S_IFMT) + (attr->mode & 07777);
> +	inode->i_nlink   = attr->nlink;
> +	inode->i_uid     = attr->uid;
> +	inode->i_gid     = attr->gid;
> +	i_size_write(inode, attr->size);
> +	inode->i_blksize = PAGE_CACHE_SIZE;
> +	inode->i_blocks  = attr->blocks;
> +	inode->i_atime.tv_sec   = attr->atime;
> +	inode->i_atime.tv_nsec  = attr->atimensec;
> +	inode->i_mtime.tv_sec   = attr->mtime;
> +	inode->i_mtime.tv_nsec  = attr->mtimensec;
> +	inode->i_ctime.tv_sec   = attr->ctime;
> +	inode->i_ctime.tv_nsec  = attr->ctimensec;
> +}
> +
> +static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
> +{
> +	inode->i_mode = attr->mode & S_IFMT;
> +	i_size_write(inode, attr->size);
> +}
> +
> +static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
> +{
> +	unsigned long nodeid = *(unsigned long *) _nodeidp;
> +	if (get_node_id(inode) == nodeid)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static int fuse_inode_set(struct inode *inode, void *_nodeidp)
> +{
> +	unsigned long nodeid = *(unsigned long *) _nodeidp;
> +	get_fuse_inode(inode)->nodeid = nodeid;
> +	return 0;
> +}
> +
> +struct inode *fuse_iget(struct super_block *sb, unsigned long nodeid,
> +			int generation, struct fuse_attr *attr, int version)
> +{
> +	struct inode *inode;
> +	struct fuse_conn *fc = get_fuse_conn_super(sb);
> +	int retried = 0;
> +
> + retry:
> +	inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set, &nodeid);
> +	if (!inode)
> +		return NULL;
> +
> +	if ((inode->i_state & I_NEW)) {
> +		inode->i_generation = generation;
> +		inode->i_data.backing_dev_info = &fc->bdi;
> +		fuse_init_inode(inode, attr);
> +		unlock_new_inode(inode);
> +	} else if ((inode->i_mode ^ attr->mode) & S_IFMT) {
> +		BUG_ON(retried);
> +		/* Inode has changed type, any I/O on the old should fail */
> +		make_bad_inode(inode);
> +		iput(inode);
> +		retried = 1;
> +		goto retry;
> +	}
> +
> +	fuse_change_attributes(inode, attr);
> +	inode->i_version = version;
> +	return inode;
> +}
> +
> +static void fuse_put_super(struct super_block *sb)
> +{
> +	struct fuse_conn *fc = get_fuse_conn_super(sb);
> +
> +	spin_lock(&fuse_lock);
> +	mount_count --;
> +	fc->sb = NULL;
> +	fc->user_id = 0;
> +	fuse_release_conn(fc);
> +	*get_fuse_conn_super_p(sb) = NULL;
> +	spin_unlock(&fuse_lock);
> +}
> +
> +enum {
> +	OPT_FD,
> +	OPT_ROOTMODE,
> +	OPT_USER_ID,
> +	OPT_DEFAULT_PERMISSIONS,
> +	OPT_ALLOW_OTHER,
> +	OPT_ALLOW_ROOT,
> +	OPT_KERNEL_CACHE,
> +	OPT_ERR
> +};
> +
> +static match_table_t tokens = {
> +	{OPT_FD,			"fd=%u"},
> +	{OPT_ROOTMODE,			"rootmode=%o"},
> +	{OPT_USER_ID,			"user_id=%u"},
> +	{OPT_DEFAULT_PERMISSIONS,	"default_permissions"},
> +	{OPT_ALLOW_OTHER,		"allow_other"},
> +	{OPT_ALLOW_ROOT,		"allow_root"},
> +	{OPT_KERNEL_CACHE,		"kernel_cache"},
> +	{OPT_ERR,			NULL}
> +};
> +
> +static int parse_fuse_opt(char *opt, struct fuse_mount_data *d)
> +{
> +	char *p;
> +	memset(d, 0, sizeof(struct fuse_mount_data));
> +	d->fd = -1;
> +
> +	while ((p = strsep(&opt, ",")) != NULL) {
> +		int token;
> +		int value;
> +		substring_t args[MAX_OPT_ARGS];
> +		if (!*p)
> +			continue;
> +
> +		token = match_token(p, tokens, args);
> +		switch (token) {
> +		case OPT_FD:
> +			if (match_int(&args[0], &value))
> +				return 0;
> +			d->fd = value;
> +			break;
> +
> +		case OPT_ROOTMODE:
> +			if (match_octal(&args[0], &value))
> +				return 0;
> +			d->rootmode = value;
> +			break;
> +
> +		case OPT_USER_ID:
> +			if (match_int(&args[0], &value))
> +				return 0;
> +			d->user_id = value;
> +			break;
> +
> +		default:
> +			return 0;
> +		}
> +	}
> +	if (d->fd == -1)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int fuse_show_options(struct seq_file *m, struct vfsmount *mnt)
> +{
> +	struct fuse_conn *fc = get_fuse_conn_super(mnt->mnt_sb);
> +
> +	seq_printf(m, ",user_id=%u", fc->user_id);
> +	return 0;
> +}
> +
> +void fuse_release_conn(struct fuse_conn *fc)
> +{
> +	kfree(fc);
> +}
> +
> +static struct fuse_conn *new_conn(void)
> +{
> +	struct fuse_conn *fc;
> +
> +	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
> +	if (fc != NULL) {
> +		memset(fc, 0, sizeof(*fc));
> +		fc->sb = NULL;
> +		fc->user_id = 0;
> +		fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
> +		fc->bdi.unplug_io_fn = default_unplug_io_fn;
> +	}
> +	return fc;
> +}
> +
> +static struct fuse_conn *get_conn(struct file *file, struct super_block *sb)
> +{
> +	struct fuse_conn *fc;
> +
> +	fc = new_conn();
> +	if (fc == NULL)
> +		return NULL;
> +	spin_lock(&fuse_lock);
> +	fc->sb = sb;
> +	spin_unlock(&fuse_lock);

The lock here looks unnessary, fc is private to this function at this point.

> +	return fc;
> +}
> +
> +static struct inode *get_root_inode(struct super_block *sb, unsigned mode)
> +{
> +	struct fuse_attr attr;
> +	memset(&attr, 0, sizeof(attr));
> +
> +	attr.mode = mode;
> +	attr.ino = FUSE_ROOT_ID;
> +	return fuse_iget(sb, 1, 0, &attr, 0);
> +}
> +
> +static struct super_operations fuse_super_operations = {
> +	.alloc_inode    = fuse_alloc_inode,
> +	.destroy_inode  = fuse_destroy_inode,
> +	.read_inode	= fuse_read_inode,
> +	.clear_inode	= fuse_clear_inode,
> +	.put_super	= fuse_put_super,
> +	.show_options	= fuse_show_options,
> +};
> +
> +static int inc_mount_count(void)
> +{
> +	int success = 0;
> +	spin_lock(&fuse_lock);
> +	mount_count ++;
> +	if (mount_max == -1 || mount_count <= mount_max)
> +		success = 1;
> +	spin_unlock(&fuse_lock);
> +	return success;
> +}
> +
> +static int fuse_read_super(struct super_block *sb, void *data, int silent)

Can you rename this to fuse_fill_super so its consistent with what the
VFS calls it?

> +{
> +	struct fuse_conn *fc;
> +	struct inode *root;
> +	struct fuse_mount_data d;
> +	struct file *file;
> +	int err;
> +
> +	if (!parse_fuse_opt((char *) data, &d))
> +		return -EINVAL;
> +
> +	sb->s_blocksize = PAGE_CACHE_SIZE;
> +	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
> +	sb->s_magic = FUSE_SUPER_MAGIC;
> +	sb->s_op = &fuse_super_operations;
> +	sb->s_maxbytes = MAX_LFS_FILESIZE;
> +
> +	file = fget(d.fd);
> +	if (!file)
> +		return -EINVAL;
> +
> +	fc = get_conn(file, sb);
> +	fput(file);
> +	if (fc == NULL)
> +		return -EINVAL;
> +
> +	fc->user_id = d.user_id;
> +
> +	*get_fuse_conn_super_p(sb) = fc;
> +
> +	err = -ENFILE;
> +	if (!inc_mount_count() && current->uid != 0)
> +		goto err;
> +
> +	err = -ENOMEM;
> +	root = get_root_inode(sb, d.rootmode);
> +	if (root == NULL)
> +		goto err;
> +
> +	sb->s_root = d_alloc_root(root);
> +	if (!sb->s_root) {
> +		iput(root);
> +		goto err;
> +	}
> +	return 0;
> +
> + err:
> +	spin_lock(&fuse_lock);
> +	mount_count --;
> +	fc->sb = NULL;
> +	fuse_release_conn(fc);
> +	spin_unlock(&fuse_lock);
> +	*get_fuse_conn_super_p(sb) = NULL;
> +	return err;
> +}
> +
> +static struct super_block *fuse_get_sb(struct file_system_type *fs_type,
> +				       int flags, const char *dev_name,
> +				       void *raw_data)
> +{
> +	return get_sb_nodev(fs_type, flags, raw_data, fuse_read_super);
> +}
> +
> +static struct file_system_type fuse_fs_type = {
> +	.owner		= THIS_MODULE,
> +	.name		= "fuse",
> +	.get_sb		= fuse_get_sb,
> +	.kill_sb	= kill_anon_super,
> +};
> +
> +static void fuse_inode_init_once(void * foo, kmem_cache_t * cachep,
> +				 unsigned long flags)
> +{
> +	struct inode * inode = foo;
> +
> +	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
> +	    SLAB_CTOR_CONSTRUCTOR)
> +		inode_init_once(inode);
> +}
> +
> +static int __init fuse_fs_init(void)
> +{
> +	int err;
> +
> +	err = register_filesystem(&fuse_fs_type);
> +	if (err)
> +		printk("fuse: failed to register filesystem\n");
> +	else {
> +		fuse_inode_cachep = kmem_cache_create("fuse_inode",
> +						      sizeof(struct inode) + sizeof(struct fuse_inode) ,

I'm not convinced this will get the right alignments in the case where
struct inode ever changes size.  You're better off using a new struct
that contains both and using the size of it here, as well as using it
for calculating the offset in get_fuse_inode instead of &inode[1].

> +						      0, SLAB_HWCACHE_ALIGN,
> +						      fuse_inode_init_once, NULL);
> +		if (!fuse_inode_cachep) {
> +			unregister_filesystem(&fuse_fs_type);
> +			err = -ENOMEM;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static void fuse_fs_cleanup(void)
> +{
> +	unregister_filesystem(&fuse_fs_type);
> +	kmem_cache_destroy(fuse_inode_cachep);
> +}
> +
> +int __init fuse_init(void)

static?

> +{
> +	int res;
> +
> +	printk("fuse init (API version %i.%i)\n",
> +	       FUSE_KERNEL_VERSION, FUSE_KERNEL_MINOR_VERSION);
> +
> +	spin_lock_init(&fuse_lock);
> +	res = fuse_fs_init();
> +	if (res)
> +		goto err;
> +
> +	return 0;
> +
> + err:
> +	return res;
> +}
> +
> +void __exit fuse_exit(void)

static?

> +{
> +	printk(KERN_DEBUG "fuse exit\n");
> +
> +	fuse_fs_cleanup();
> +}

Why not just do the cleanup here?  If you still want to keep fuse_exit
seperate from fuse_fs_cleanup, may I suggest marking the former __exit?

> +
> +module_init(fuse_init);
> +module_exit(fuse_exit);
> diff -Nurp a/include/linux/fuse.h b/include/linux/fuse.h
> --- a/include/linux/fuse.h	1970-01-01 01:00:00.000000000 +0100
> +++ b/include/linux/fuse.h	2005-01-10 19:28:38.000000000 +0100
> @@ -0,0 +1,38 @@
> +/*
> +    FUSE: Filesystem in Userspace
> +    Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
> +
> +    This program can be distributed under the terms of the GNU GPL.
> +    See the file COPYING.
> +*/
> +
> +/* This file defines the kernel interface of FUSE */
> +
> +#include <asm/types.h>
> +
> +/** Version number of this interface */
> +#define FUSE_KERNEL_VERSION 5
> +
> +/** Minor version number of this interface */
> +#define FUSE_KERNEL_MINOR_VERSION 1

I haven't yet looked at the other patches, but is this VERSION info
negotiated with userspace?

> +
> +/** The node ID of the root inode */
> +#define FUSE_ROOT_ID 1
> +
> +struct fuse_attr {
> +	__u64	ino;
> +	__u64	size;
> +	__u64	blocks;
> +	__u64	atime;
> +	__u64	mtime;
> +	__u64	ctime;
> +	__u32	atimensec;
> +	__u32	mtimensec;
> +	__u32	ctimensec;
> +	__u32	mode;
> +	__u32	nlink;
> +	__u32	uid;
> +	__u32	gid;
> +	__u32	rdev;
> +};
> +
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB4vZUdQs4kOxk3/MRAkXnAJ4xcjICb5lEPUrjsPcRRFGGqPAfvACfaCI+
LpifBiqVr1ggy7YgsMAu1n8=
=Mkbt
-----END PGP SIGNATURE-----
