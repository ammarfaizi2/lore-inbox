Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbULJOq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbULJOq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 09:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbULJOqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 09:46:25 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40609 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261206AbULJOqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 09:46:16 -0500
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
From: Josh Boyer <jdub@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20041210005055.GA17822@kroah.com>
References: <20041210005055.GA17822@kroah.com>
Content-Type: text/plain
Message-Id: <1102689974.26320.39.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 10 Dec 2004 08:46:14 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 18:50, Greg KH wrote:
> A while ago a comment from another kernel developer about why they put a
> huge file in sysfs (one that was bigger than a single page and contained
> more than just 1 type of information), was something like, "well, it was
> just so easy, and there was no other place to put debugging stuff like
> that," got me to thinking.
> 
> What if there was a in-kernel filesystem that was explicitly just for
> putting debugging stuff?  Some place other than proc and sysfs, and that
> was easier than both of them to use.  Yet it needed to also be able to
> handle complex stuff like seq file and raw file_ops if needed.
> 
> Thus debugfs was born (yes, I know there's a userspace program called
> debugfs, this is an in-kernel filesystem and has nothing to do with
> that.)  debugfs is ment for putting stuff that kernel developers need to
> see exported to userspace, yet don't always want hanging around.

Cool idea.


> diff -Nru a/fs/debugfs/debugfs.h b/fs/debugfs/debugfs.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/fs/debugfs/debugfs.h	2004-12-09 16:32:32 -08:00
> @@ -0,0 +1,10 @@
> +#define DEBUG
> +
> +#ifdef DEBUG
> +#define dbg(format, arg...) printk(KERN_DEBUG "%s: " format , __FILE__ , ## arg)
> +#else
> +#define dbg(format, arg...) do {} while (0)
> +#endif

Fine for now, but if it gets merged should pr_debug be used?

> +
> +extern struct file_operations debugfs_file_operations;
> +

<snip>

> diff -Nru a/fs/debugfs/file.c b/fs/debugfs/file.c
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/fs/debugfs/file.c	2004-12-09 16:32:32 -08:00
> @@ -0,0 +1,165 @@
> +/*
> + *  debugfs.c  - a tiny little debug file system for people to use instead of /proc or /sys

<NIT>
Wrong file name :).
</NIT>

> + *
> + *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
> + *  Copyright (C) 2004 IBM Inc.
> + */
> +

<snip>

> +
> +simple_type(u8, "%c", unsigned long, simple_strtoul);
> +simple_type(u16, "%hi", unsigned long, simple_strtoul);
> +simple_type(u32, "%i", unsigned long, simple_strtoul);
> +EXPORT_SYMBOL_GPL(debugfs_create_u8);
> +EXPORT_SYMBOL_GPL(debugfs_create_u16);
> +EXPORT_SYMBOL_GPL(debugfs_create_u32);
> +
> +static ssize_t read_file_bool(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
> +{
> +	char buf[2];
> +	u32 *val = file->private_data;
> +	
> +	if (val)
> +		buf[0] = 'Y';
> +	else
> +		buf[0] = 'N';
> +	buf[1] = 0x00;
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t write_file_bool(struct file *file, const char __user *user_buf, size_t count, loff_t *ppos)
> +{
> +	char buf[32];
> +	int buf_size;
> +	u32 *val = file->private_data;
> +
> +	buf_size = min(count, (sizeof(buf)-1));
> +	if (copy_from_user(buf, user_buf, buf_size))
> +		return -EFAULT;
> +
> +	switch (buf[0]) {
> +	case 'y':
> +	case 'Y':
> +	case '1':
> +		*val = 1;
> +		break;
> +	case 'n':
> +	case 'N':
> +	case '0':
> +		*val = 0;
> +		break;
> +	}

Writing 'Y', 'y', or '1' is allowed, but only 'Y' is ever returned by
the read function (similar for the "false" case).  That can be confusing
to a program if it writes '1', and then checks to see if the value it
wrote took and it gets back 'Y'.  Maybe only allow what you are going to
return for bool values in the write case?


> diff -Nru a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/fs/debugfs/inode.c	2004-12-09 16:32:32 -08:00
> @@ -0,0 +1,229 @@
> +/*
> + *  debugfs.c  - a tiny little debug file system for people to use instead of /proc or /sys

Again.  Template perhaps? :)

> + *
> + *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
> + *  Copyright (C) 2004 IBM Inc.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/mount.h>
> +#include <linux/pagemap.h>
> +#include <linux/init.h>
> +#include <linux/namei.h>
> +#include <linux/debugfs.h>
> +#include "debugfs.h"
> +
> +#define DEBUG_MAGIC	0x64626720

#define DEBUGFS_MAGIC

<snip>

> diff -Nru a/include/linux/debugfs.h b/include/linux/debugfs.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/include/linux/debugfs.h	2004-12-09 16:32:32 -08:00
> @@ -0,0 +1,47 @@
> +/*
> + *  debugfs.h  - a tiny little debug file system for people to use instead of /proc or /sys
> + *
> + *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
> + *  Copyright (C) 2004 IBM Inc.
> + */
> +
> +#ifndef _DEBUGFS_H_
> +#define _DEBUGFS_H_
> +
> +#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEBUG_FS_MODULE)
> +struct dentry *debugfs_create_file(const char *name, mode_t mode,
> +				   struct dentry *parent, void *data,
> +				   struct file_operations *fops);
> +
> +static inline struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
> +{
> +	return debugfs_create_file(name, S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO, parent, NULL, NULL);
> +}
> +
> +void debugfs_remove(struct dentry *dentry);
> +
> +struct dentry *debugfs_create_u8(const char *name, mode_t mode, struct dentry *parent, u8 *value);
> +struct dentry *debugfs_create_u16(const char *name, mode_t mode, struct dentry *parent, u16 *value);
> +struct dentry *debugfs_create_u32(const char *name, mode_t mode, struct dentry *parent, u32 *value);
> +struct dentry *debugfs_create_bool(const char *name, mode_t mode, struct dentry *parent, u32 *value);
> +
> +#else
> +static inline struct dentry *debugfs_create_file(const char *name, mode_t mode, struct dentry *parent, void *data, struct file_operations *fops)
> +{ return ERR_PTR(-ENODEV); }
> +static inline struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
> +{ return ERR_PTR(-ENODEV); }
> +
> +static inline void debugfs_remove(struct dentry *dentry) { }
> +
> +static inline struct dentry *debugfs_create_u8(const char *name, mode_t mode, struct dentry *parent, u8 *value)
> +{ return ERR_PTR(-ENODEV); }
> +static inline struct dentry *debugfs_create_u16(const char *name, mode_t mode, struct dentry *parent, u16 *value)
> +{ return ERR_PTR(-ENODEV); }
> +static inline struct dentry *debugfs_create_u32(const char *name, mode_t mode, struct dentry *parent, u32 *value)
> +{ return ERR_PTR(-ENODEV); }
> +static inline struct dentry *debugfs_create_bool(const char *name, mode_t mode, struct dentry *parent, u32 *value)
> +{ return EFF_PTR(-ENODEV); }

Could these just return NULL perhaps?  Would be more like procfs then,
which is what I'd assume most drivers will be converting from.

> +
> +#endif
> +
> +#endif

josh

