Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbULJRVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbULJRVe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbULJRVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:21:34 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:21914 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261201AbULJRV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:21:27 -0500
Date: Fri, 10 Dec 2004 18:21:26 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
Message-ID: <20041210172126.GA23146@wohnheim.fh-wedel.de>
References: <20041210005055.GA17822@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041210005055.GA17822@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two-word summary: cool stuff!  Thanks!

On Thu, 9 December 2004 16:50:56 -0800, Greg KH wrote:
> 
> Thus debugfs was born (yes, I know there's a userspace program called
> debugfs, this is an in-kernel filesystem and has nothing to do with
> that.)  debugfs is ment for putting stuff that kernel developers need to
> see exported to userspace, yet don't always want hanging around.

In principle, it is the same as /proc, just with the explicit
information that binary compatibility will never be a goal, right?

Details differ, sure.

> diff -Nru a/fs/debugfs/debugfs_test.c b/fs/debugfs/debugfs_test.c

Nice example code.  But I'd vote for either killing it or renaming it
to debugfs_example.c.  Just to document that anyone actually compiling
it in is stupid.

> +static ssize_t default_read_file(struct file *file, char __user *user_buf,
> +				 size_t count, loff_t *ppos)

For a similar reason, I'd call this example_read_file().  You actually
fooled me for a moment and I was wondering why the heck this should be
part of debugfs. ;)

> +#define simple_type(type, format, temptype, strtolfn)	\
> +static ssize_t read_file_##type(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)	\

Long lines.  Taste varies, but...

> +{													\
> +	char buf[32];											\
> +	type *val = file->private_data;									\
> +													\
> +	snprintf(buf, sizeof(buf), format, *val);							\
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));			\
> +}													\
> +static ssize_t write_file_##type(struct file *file, const char __user *user_buf, size_t count, loff_t *ppos)	\
> +{													\
> +	char *endp;											\
> +	char buf[32];											\
> +	int buf_size;											\
> +	type *val = file->private_data;									\
> +	temptype tmp;											\
> +													\
> +	memset(buf, 0x00, sizeof(buf));									\
> +	buf_size = min(count, (sizeof(buf)-1));								\
> +	if (copy_from_user(buf, user_buf, buf_size))							\
> +		return -EFAULT;										\
> +													\
> +	tmp = strtolfn(buf, &endp, 0);									\
> +	if ((endp == buf) || ((type)tmp != tmp))							\
> +		return -EINVAL;										\
> +	*val = tmp;											\
> +	return count;											\
> +}													\
> +static struct file_operations fops_##type = {								\
> +	.read =		read_file_##type,								\
> +	.write =	write_file_##type,								\
> +	.open =		default_open,									\
> +	.llseek =	default_file_lseek,								\
> +};													\
> +struct dentry *debugfs_create_##type(const char *name, mode_t mode, struct dentry *parent, type *value)	\
> +{													\
> +	return debugfs_create_file(name, mode, parent, value, &fops_##type);				\
> +}
> +
> +simple_type(u8, "%c", unsigned long, simple_strtoul);
> +simple_type(u16, "%hi", unsigned long, simple_strtoul);
> +simple_type(u32, "%i", unsigned long, simple_strtoul);
> +EXPORT_SYMBOL_GPL(debugfs_create_u8);
> +EXPORT_SYMBOL_GPL(debugfs_create_u16);
> +EXPORT_SYMBOL_GPL(debugfs_create_u32);

Move above three lines into the macro?  Or do you prefer to me the
export move obvious?

> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/mount.h>
> +#include <linux/pagemap.h>
> +#include <linux/init.h>
> +#include <linux/namei.h>

I like to sort the above alphabetically.  Shouldn't matter, but it
looks neat and since there is no other natural order...

> +static struct inode *debugfs_get_inode(struct super_block *sb, int mode, dev_t dev)
> +{
> +	struct inode *inode = new_inode(sb);
> +
> +	if (inode) {
> +		inode->i_mode = mode;
> +		inode->i_uid = 0;
> +		inode->i_gid = 0;
> +		inode->i_blksize = PAGE_CACHE_SIZE;
> +		inode->i_blocks = 0;
> +		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
> +		switch (mode & S_IFMT) {
> +		default:
> +			init_special_inode(inode, mode, dev);

Just out of curiosity: why would anyone want special nodes under
/debug?

> +			break;
> +		case S_IFREG:
> +			inode->i_fop = &debugfs_file_operations;
> +			break;
> +		case S_IFDIR:
> +			inode->i_op = &simple_dir_inode_operations;
> +			inode->i_fop = &simple_dir_operations;
> +
> +			/* directory inodes start off with i_nlink == 2 (for "." entry) */
> +			inode->i_nlink++;
> +			break;
> +		}
> +	}
> +	return inode; 
> +}


> +static inline struct dentry *debugfs_create_file(const char *name, mode_t mode, struct dentry *parent, void *data, struct file_operations *fops)
> +{ return ERR_PTR(-ENODEV); }

Nice.  Gotta remember that one.

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
