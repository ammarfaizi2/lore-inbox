Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVENHqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVENHqT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 03:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVENHqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 03:46:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:39112 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262701AbVENHpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 03:45:50 -0400
Date: Sat, 14 May 2005 00:45:25 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Message-ID: <20050514074524.GC20021@kroah.com>
References: <200505132117.37461.arnd@arndb.de> <200505132129.07603.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505132129.07603.arnd@arndb.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 09:29:06PM +0200, Arnd Bergmann wrote:
> This is an early version of the SPU file system, which is used
> to run code on the Synergistic Processing Units of the Broadband
> Engine.

The whitespace seems a bit dammaged in places, check your tabs vs.
spaces...

> /run	A stub file that lets us do ioctl.

No, as Ben said, do not do this.  Use write.  And as you are only doing
1 type of ioctl, it shouldn't be an issue.  Also it will be faster than
the ioctl due to lack of BKL usage :)

And I don't quite think you do the proper permission and validate of the
data in your code, you should verify this is all correct.

> +/**** spufs attributes
> + *
> + * Attributes in spufs behave similar to those in sysfs:
> + *
> + * Writing to an attribute immediately sets a value, an open file can be
> + * written to multiple times.
> + *
> + * Reading from an attribute creates a buffer from the value that might get
> + * read with multiple read calls. When the attribute has been read completely,
> + * no further read calls are possible until the file is opened again.
> + *
> + * All spufs attributes contain a text representation of a numeric value that
> + * are accessed with the get() and set() functions.
> + *
> + * Perhaps these file operations could be put in debugfs or libfs instead,
> + * they are not really SPU specific.

Yes they should.  I'll gladly take them for debugfs or like you state,
libfs is probably the better place for them so everyone can use them.

If you make up a patch, I'll fix up debugfs to use them properly.

> +#define spufs_attribute(name)						   \
> +static int name ## _open(struct inode *inode, struct file *file)	   \
> +{									   \
> +	return spufs_attr_open(inode, file, &name ## _get, &name ## _set); \
> +}									   \
> +static struct file_operations name = {					   \
> +	.open	 = name ## _open,					   \
> +	.release = spufs_attr_close,					   \
> +	.read	 = spufs_attr_read,					   \
> +	.write	 = spufs_attr_write,					   \
> +};

No module owner set?  Be careful if not...

> +static struct tree_descr spufs_dir_contents[] = {
> +	{ "mem",  &spufs_mem_fops,  0644, },

Named identifiers are the better way to do this (yeah, longer code I
know...)

> +	{ "run",  &spufs_run_fops,  0400, },
> +	{ "mbox", &spufs_mbox_fops, 0400, },
> +	{ "ibox", &spufs_ibox_fops, 0400, },
> +	{ "wbox", &spufs_wbox_fops, 0200, },
> +	{ "signal1_type", &spufs_signal1_type, 0600, },
> +	{ "signal2_type", &spufs_signal1_type, 0600, },
> +
> +#if 1 /* debugging only */
> +	{ "class0_mask", &spufs_class0_mask, 0600, },
> +	{ "class1_mask", &spufs_class1_mask, 0600, },
> +	{ "class2_mask", &spufs_class2_mask, 0600, },
> +	{ "class0_stat", &spufs_class0_stat, 0600, },
> +	{ "class1_stat", &spufs_class1_stat, 0600, },
> +	{ "class2_stat", &spufs_class2_stat, 0600, },
> +	{ "sr1", &spufs_mfc_sr1_RW, 0600, },
> +	{ "fir", &spufs_mfc_fir_R, 0400, },
> +	{ "fir_status_or", &spufs_mfc_fir_status_or_W, 0200, },
> +	{ "fir_status_and", &spufs_mfc_fir_status_and_W, 0200, },
> +	{ "fir_mask", &spufs_mfc_fir_mask_R, 0400, },
> +	{ "fir_mask_or", &spufs_mfc_fir_mask_or_W, 0200, },
> +	{ "fir_mask_and", &spufs_mfc_fir_mask_and_W, 0200, },
> +	{ "fir_chkstp", &spufs_mfc_fir_chkstp_enable_RW, 0600, },
> +	{ "cer", &spufs_mfc_cer_R, 0400, },
> +	{ "dsisr", &spufs_mfc_dsisr_RW, 0600, },
> +	{ "dsir", &spufs_mfc_dsir_R, 0200, },
> +	{ "cntl", &spufs_mfc_control_RW, 0600, },
> +	{ "sdr", &spufs_mfc_sdr_RW, 0600, },
> +#endif
> +	{},
> +};
> +
> +static int
> +spufs_fill_dir(struct dentry *dir, struct tree_descr *files,
> +		int mode, struct spu_context *ctx)
> +{
> +	struct inode *inode;
> +	struct dentry *dentry;
> +	int ret;
> +
> +	static struct inode_operations iops = {
> +		.getattr = simple_getattr,
> +		.setattr = spufs_setattr,
> +	};
> +
> +	ret = -ENOSPC;
> +	while (files->name && files->name[0]) {
> +		dentry = d_alloc_name(dir, files->name);
> +		if (!dentry)
> +			goto out;
> +		inode = spufs_new_inode(dir->d_sb,
> +				S_IFREG | (files->mode & mode));
> +		if (!inode)
> +			goto out;
> +		inode->i_op = &iops;
> +		inode->i_fop = files->ops;
> +		inode->i_mapping->a_ops = &spufs_aops;
> +		inode->i_mapping->backing_dev_info = &spufs_backing_dev_info;
> +		SPUFS_I(inode)->i_ctx = get_spu_context(ctx);
> +
> +		d_add(dentry, inode);
> +		files++;
> +	}
> +	return 0;
> +out:
> +	// FIXME: remove all files that are left
> +	return ret;
> +}
> +
> +static int
> +spufs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
> +{
> +	int ret;
> +	struct inode *inode;
> +	struct spu_context *ctx;
> +
> +	ret = -ENOSPC;
> +	inode = spufs_new_inode(dir->i_sb, mode | S_IFDIR);
> +	if (!inode)
> +		goto out;
> +
> +	if (dir->i_mode & S_ISGID) {
> +		inode->i_gid = dir->i_gid;
> +		inode->i_mode |= S_ISGID;
> +	}
> +	ctx = alloc_spu_context();
> +	SPUFS_I(inode)->i_ctx = ctx;
> +	if (!ctx)
> +		goto out_iput;
> +
> +	inode->i_op = &simple_dir_inode_operations;
> +	inode->i_fop = &simple_dir_operations;
> +	ret = spufs_fill_dir(dentry, spufs_dir_contents, mode, ctx);
> +	if (ret)
> +		goto out_free_ctx;
> +
> +	d_instantiate(dentry, inode);
> +	dget(dentry);
> +	dir->i_nlink++;
> +	goto out;
> +
> +out_free_ctx:
> +	put_spu_context(ctx);
> +out_iput:
> +	iput(inode);
> +out:
> +	return ret;
> +}
> +
> +/* This looks really wrong! */
> +static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)

Why do you need this?  Doesn't 'simple_rmdir' work for you?

The rest of your ramfs based fs code looks a bit complex.  Can't it be
as "simple" as the debugfs code is (only 100 lines for a fs.)  Or is it
doing different types of things that I'm completly misunderstanding?

And I still think that 100 lines of code to make a ramfs type fs is a
bit big, need to work on that one of these days...

> +union MFC_TagSizeClassCmd {
> +	struct {
> +		u16 mfc_size;
> +		u16 mfc_tag;
> +		u8  pad;
> +		u8  mfc_rclassid;
> +		u16 mfc_cmd;
> +	} u;
> +	struct {
> +		u32 mfc_size_tag32;
> +		u32 mfc_class_cmd32;
> +	} by32;
> +	u64 all64;
> +};

Remember __u16 and friends for structures that cross the user/kernel
boundry (like your ioctl that you will be rewriting...)

thanks,

greg k-h
