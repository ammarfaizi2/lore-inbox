Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWD1J6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWD1J6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWD1J6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:58:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030343AbWD1J6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:58:11 -0400
Date: Fri, 28 Apr 2006 02:56:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: schwidefsky@de.ibm.com, penberg@cs.helsinki.fi, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-Id: <20060428025621.2c7577a0.akpm@osdl.org>
In-Reply-To: <20060428112225.418cadd9.holzheu@de.ibm.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Holzheu <holzheu@de.ibm.com> wrote:
>
> On zSeries machines there exists an interface which allows the operating
> system  to retrieve LPAR hypervisor accounting data. For example, it is
> possible to get usage data for physical and virtual cpus. In order to
> provide this information to user space programs, I implemented a new
> virtual Linux file system named 'hypfs' using the Linux 2.6 libfs
> framework. The name 'hypfs' stands for 'Hypervisor Filesystem'. All the
> accounting information is put into different virtual files which can be
> accessed from user space. All data is represented as ASCII strings.
> 
> When the file system is mounted the accounting information is retrieved
> and a file system tree is created with the attribute files containing
> the cpu information. The content of the files remains unchanged until a
> new update is made. An update can be triggered from user space through
> writing 'something' into a special purpose update file.

Looks sane.  A few comments, mainly minor, but a few bugs:


> +config HYPFS_FS
> +	bool "s390 hypervisor file system support"
> +	default y
> +	help
> +	  This is a virtual file system intended to provide accounting
> +	  information in a s390 hypervisor environment.
> +

"in an s390"?

> +static inline int diag204(unsigned long subcode, unsigned long size, void *addr)

There's a lot of inlining going on.  Is it excessive?

> ...
>
> +static int diag204_probe(void)
> +{
> +	void *buf;
> +	int pages, rc;
> +
> +	pages = diag204(SUBC_RSI | INFO_EXT, 0, 0);
> +	if (pages > 0) {

In other places, you return an error if (pages < 0), but not here.

> +		buf = kmalloc(pages * PAGE_SIZE, GFP_KERNEL);
> +		if (!buf) {
> +			rc = -ENOMEM;
> +			goto err_out;
> +		}
> +		if (diag204(SUBC_STIB7 | INFO_EXT, pages, buf) >= 0) {
> +			diag204_store_sc = SUBC_STIB7;
> +			diag204_info_type = INFO_EXT;
> +			goto out;
> +		}
> +		if (diag204(SUBC_STIB6 | INFO_EXT, pages, buf) >= 0) {
> +			diag204_store_sc = SUBC_STIB7;
> +			diag204_info_type = INFO_EXT;
> +			goto out;
> +		}
> +		kfree(buf);
> +	}
> +	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!buf) {
> +		rc = -ENOMEM;
> +		goto err_out;
> +	}
> +	if (diag204(SUBC_STIB4 | INFO_SIMPLE, pages, buf) >= 0) {
> +		diag204_store_sc = SUBC_STIB4;
> +		diag204_info_type = INFO_SIMPLE;
> +		goto out;
> +	} else {
> +		rc = -ENOSYS;
> +		goto err_out;
> +	}
> +      out:
> +	rc = 0;
> +      err_out:
> +	kfree(buf);
> +	return rc;
> +}

The indenting of the labels is a bit unconventional.

> +static void *diag204_store(void)
> +{
> +	void *buf;
> +	int pages;
> +
> +	if (diag204_store_sc == SUBC_STIB4)
> +		pages = 1;
> +	else
> +		pages = diag204(SUBC_RSI | diag204_info_type, 0, 0);
> +
> +	if (pages < 0)
> +		return ERR_PTR(-ENOSYS);
> +
> +	buf = kmalloc(pages * PAGE_SIZE, GFP_KERNEL);
> +	if (!buf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (diag204(diag204_store_sc | diag204_info_type, pages, buf) < 0) {
> +		kfree(buf);
> +		return ERR_PTR(-ENOSYS);
> +	}
> +	return buf;
> +}

One wonders if

	pages = diag204(...);
	return kmalloc(pages * PAGE_SIZE, gfp_flags);

would be a useful helper function.

> +	asm volatile("   diag    %0,%1,0x224\n"
> +		     : :"d" (0), "d"(ptr) : "memory");
> +}
> +
> +static inline int diag224_get_name_table(void)
> +{
> +	/* memory must be below 2GB */
> +	diag224_cpu_names = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
> +	if (!diag224_cpu_names)
> +		return -ENOMEM;
> +	diag224(diag224_cpu_names);
> +	EBCASC(diag224_cpu_names + 16, (*diag224_cpu_names + 1) * 16);
> +	return 0;
> +}
> +
> +static inline void diag224_delete_name_table(void)
> +{
> +	kfree(diag224_cpu_names);
> +}
> +
> +static int diag224_idx2name(int index, char *name)
> +{
> +	memcpy(name, diag224_cpu_names + ((index + 1) * 16), 16);
> +	name[16] = 0;

Should this be "15"?   I guess not...

> +	strstrip(name);
> +	return 0;
> +}
> +
> +int diag_init(void)
> +{
> +	int rc;
> +
> +	if (diag204_probe()) {
> +		printk(KERN_ERR "hypfs: diag 204 not working.");
> +		return -ENODATA;
> +	}
> +	rc = diag224_get_name_table();
> +	if (rc) {
> +		diag224_delete_name_table();
> +		printk(KERN_ERR "hypfs: could not get name table.\n");
> +	}
> +	return rc;
> +}

This can be __init

> +void diag_exit(void)
> +{
> +	diag224_delete_name_table();
> +}

And __exit.

> +int diag_create_files(struct super_block *sb, struct dentry *root)
> +{

Perhaps as a globally-visible function this should be called
hypfs_diag_create_files().  Ditto diag_init() and diag_exit().

> +	struct dentry *systems_dir, *hyp_dir;
> +	void *time_hdr, *part_hdr;
> +	int i;
> +	void *buffer, *rc;
> +
> +	buffer = diag204_store();
> +	if (IS_ERR(buffer))
> +		return PTR_ERR(buffer);
> +
> +	systems_dir = hypfs_mkdir(sb, root, "systems");
> +	if (IS_ERR(systems_dir))
> +		return PTR_ERR(systems_dir);
> +	time_hdr = (struct x_info_blk_hdr *)buffer;
> +	part_hdr = time_hdr + info_blk_hdr__size(diag204_info_type);
> +	for (i = 0; i < info_blk_hdr__npar(diag204_info_type, time_hdr); i++) {
> +		part_hdr = hypfs_create_lpar_files(sb, systems_dir, part_hdr);
> +		if (IS_ERR(part_hdr))
> +			return PTR_ERR(part_hdr);
> +	}
> +	if (info_blk_hdr__flags(diag204_info_type, time_hdr) & LPAR_PHYS_FLG) {
> +		void *rc;
> +		rc = hypfs_create_phys_files(sb, root, part_hdr);
> +		if (IS_ERR(rc))
> +			return PTR_ERR(rc);
> +	}
> +	hyp_dir = hypfs_mkdir(sb, root, "hyp");
> +	if (IS_ERR(hyp_dir))
> +		return PTR_ERR(hyp_dir);
> +	rc = hypfs_create_str(sb, hyp_dir, "type", "LPAR Hypervisor");
> +	if (IS_ERR(rc))
> +		return PTR_ERR(rc);
> +	kfree(buffer);
> +	return 0;
> +}

This leaks `buffer' on the error paths, yes?

> +/*
> + *  fs/hypfs/inode.c
> + *    Hypervisor filesystem for Linux on s390.
> + *
> + *    Copyright (C) IBM Corp. 2006
> + *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/namei.h>
> +#include <linux/vfs.h>
> +#include <linux/pagemap.h>
> +#include <linux/gfp.h>
> +#include <linux/time.h>
> +#include <linux/parser.h>
> +#include <linux/sysfs.h>
> +#include <linux/module.h>
> +#include <asm/ebcdic.h>
> +#include "hypfs.h"
> +#include "hypfs_diag.h"
> +
> +#define HYPFS_MAGIC 0x687970	/* ASCII 'hyp' */
> +#define TMP_SIZE 64		/* size of temporary buffers */
> +
> +static struct dentry *hypfs_create_update_file(struct super_block *sb,
> +					       struct dentry *dir);
> +
> +struct hypfs_sb_info {
> +	int uid;		/* uid used for files and dirs */
> +	int gid;		/* gid used for files and dirs */
> +};

uid_t?

> +
> +static int hypfs_open(struct inode *inode, struct file *filp)
> +{
> +	char *data = (char *)filp->f_dentry->d_inode->u.generic_ip;

Unneeded typecast.

> +	if (filp->f_mode & FMODE_WRITE) {
> +		if (!(inode->i_mode & S_IWUGO))
> +			return -EACCES;
> +	}
> +	if (filp->f_mode & FMODE_READ) {
> +		if (!(inode->i_mode & S_IRUGO))
> +			return -EACCES;
> +	}

Is the standard VFS permission checking not appropriate?

(A comment should be added here).

> +	mutex_lock(&hypfs_lock);
> +	filp->private_data = kmalloc(strlen(data) + 1, GFP_KERNEL);
> +	if (!filp->private_data) {
> +		mutex_unlock(&hypfs_lock);
> +		return -ENOMEM;
> +	}
> +	strcpy(filp->private_data, data);

kstrdup()

> +	mutex_unlock(&hypfs_lock);
> +	return 0;
> +}
> +
> +static ssize_t hypfs_aio_read(struct kiocb *iocb, __user char *buf,
> +			      size_t count, loff_t offset)
> +{
> +	char *data;
> +	size_t len;
> +	struct file *filp = iocb->ki_filp;
> +
> +	data = (char *)filp->private_data;

Unneeded cast.

> +	len = strlen(data);
> +	if (offset > len) {
> +		count = 0;
> +		goto out;
> +	}
> +	if (count > len - offset)
> +		count = len - offset;
> +	if (copy_to_user(buf, data + offset, count)) {
> +		count = -EFAULT;
> +		goto out;
> +	}
> +	iocb->ki_pos += count;
> +	file_accessed(filp);
> +      out:
> +	return count;
> +}
> +static ssize_t hypfs_aio_write(struct kiocb *iocb, const char __user *buf,
> +			       size_t count, loff_t pos)
> +{
> +	int rc;
> +	struct super_block *sb;
> +
> +	mutex_lock(&hypfs_lock);
> +	sb = iocb->ki_filp->f_dentry->d_inode->i_sb;
> +	if (last_update_time == get_seconds()) {
> +		rc = -EBUSY;
> +		goto out;
> +	}

Why's it looking at the time in this manner?

(Whatever the reason, a comment should be added here).

> +static struct dentry *hypfs_create_file(struct super_block *sb,
> +					struct dentry *parent, const char *name,
> +					char *data, mode_t mode)
> +{
> +	struct dentry *dentry;
> +	struct inode *inode;
> +	struct qstr qname;
> +
> +	qname.name = name;
> +	qname.len = strlen(name);
> +	qname.hash = full_name_hash(name, qname.len);
> +	dentry = lookup_one_len(name, parent, strlen(name));
> +	if (IS_ERR(dentry))
> +		return ERR_PTR(-ENOMEM);

	return dentry;

> +	inode = hypfs_make_inode(sb, mode);
> +	if (!inode) {
> +		dput(dentry);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	if (mode & S_IFREG) {
> +		inode->i_fop = &hypfs_file_ops;
> +		if(data)
> +			inode->i_size = strlen(data);
> +		else
> +			inode->i_size = 0;
> +	} else if (mode & S_IFDIR) {
> +		inode->i_op = &simple_dir_inode_operations;
> +		inode->i_fop = &simple_dir_operations;
> +		parent->d_inode->i_nlink++;
> +	} else
> +		BUG();
> +	inode->u.generic_ip = data;
> +	d_instantiate(dentry, inode);
> +	return dentry;
> +}
>
> +static struct dentry *hypfs_create_update_file(struct super_block *sb,
> +					       struct dentry *dir)
> +{
> +	struct dentry *dentry;
> +
> +	dentry = hypfs_create_file(sb, dir, "update", NULL,
> +				   S_IFREG | UPDATE_FILE_MODE);
> +	if (!dentry)
> +		return ERR_PTR(-ENOMEM);

But hypfs_create_file() will return ERR_PTR(-ENOMEM), never NULL.

> +	/*
> +	 * We do not put the update file on the 'delete' list with
> +	 * hypfs_add_dentry(), since it should not be removed when the tree
> +	 * is updated.
> +	 */
> +	return dentry;
> +}
> +
> +struct dentry *hypfs_create_u64(struct super_block *sb, struct dentry *dir,
> +				const char *name, __u64 value)
> +{
> +	char *buffer;
> +	char tmp[TMP_SIZE];
> +	struct dentry *dentry;
> +
> +	snprintf(tmp, TMP_SIZE, "%lld\n", (unsigned long long int)value);
> +	buffer = kmalloc(strlen(tmp) + 1, GFP_KERNEL);
> +	if (!buffer)
> +		return ERR_PTR(-ENOMEM);
> +	strcpy(buffer, tmp);

kstrdup()

> +	dentry =
> +	    hypfs_create_file(sb, dir, name, buffer, S_IFREG | REG_FILE_MODE);
> +	if (!dentry) {

IS_ERR()

> +		kfree(buffer);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	hypfs_add_dentry(dentry);
> +	return dentry;
> +}
> +
> +struct dentry *hypfs_create_str(struct super_block *sb, struct dentry *dir,
> +				const char *name, char *string)
> +{
> +	char *buffer;
> +	struct dentry *dentry;
> +
> +	buffer = kmalloc(strlen(string) + 2, GFP_KERNEL);
> +	if (!buffer)
> +		return ERR_PTR(-ENOMEM);
> +	sprintf(buffer, "%s\n", string);
> +	dentry =
> +	    hypfs_create_file(sb, dir, name, buffer, S_IFREG | REG_FILE_MODE);
> +	if (!dentry) {

IS_ERR()

(Better check the whole patch for this)

> +		kfree(buffer);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	hypfs_add_dentry(dentry);
> +	return dentry;
> +}

