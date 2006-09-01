Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWIAWUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWIAWUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWIAWUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:20:20 -0400
Received: from pat.uio.no ([129.240.10.4]:6354 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751072AbWIAWUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:20:19 -0400
Subject: Re: [PATCH 04/22][RFC] Unionfs: Common file operations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Josef Sipek <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
In-Reply-To: <20060901014138.GE5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060901014138.GE5788@fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 18:20:00 -0400
Message-Id: <1157149200.5628.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.085, required 12,
	autolearn=disabled, AWL 1.92, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 21:41 -0400, Josef Sipek wrote:
> From: David Quigley <dquigley@fsl.cs.sunysb.edu>
> 
> This patch contains helper functions used through the rest of the code which
> pertains to files.
> 
> Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
> Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
> 
> ---
> 
>  fs/unionfs/commonfops.c |  575 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 575 insertions(+)
> 
> diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/commonfops.c linux-2.6-git-unionfs/fs/unionfs/commonfops.c
> --- linux-2.6-git/fs/unionfs/commonfops.c	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6-git-unionfs/fs/unionfs/commonfops.c	2006-08-31 19:04:00.000000000 -0400
> @@ -0,0 +1,575 @@
> +/*
> + * Copyright (c) 2003-2006 Erez Zadok
> + * Copyright (c) 2003-2006 Charles P. Wright
> + * Copyright (c) 2005-2006 Josef 'Jeff' Sipek
> + * Copyright (c) 2005-2006 Junjiro Okajima
> + * Copyright (c) 2005      Arun M. Krishnakumar
> + * Copyright (c) 2004-2006 David P. Quigley
> + * Copyright (c) 2003-2004 Mohammad Nayyer Zubair
> + * Copyright (c) 2003      Puja Gupta
> + * Copyright (c) 2003      Harikesavan Krishnan
> + * Copyright (c) 2003-2006 Stony Brook University
> + * Copyright (c) 2003-2006 The Research Foundation of State University of New York
> + *
> + * For specific licensing information, see the COPYING file distributed with
> + * this package.
> + *
> + * This Copyright notice must be kept intact and distributed with all sources.
> + */
> +
> +#include "union.h"
> +
> +/* 1) Copyup the file
> + * 2) Rename the file to '.unionfs<original inode#><counter>' - obviously
> + * stolen from NFS's silly rename
> + */
> +static int copyup_deleted_file(struct file *file, struct dentry *dentry,
> +			       int bstart, int bindex)
> +{
> +	static unsigned int counter;
> +	const int i_inosize = sizeof(dentry->d_inode->i_ino) * 2;
> +	const int countersize = sizeof(counter) * 2;
> +	const int nlen = sizeof(".unionfs") + i_inosize + countersize - 1;
> +	char name[nlen + 1];
> +
> +	int err;
> +	struct dentry *tmp_dentry = NULL;
> +	struct dentry *hidden_dentry = NULL;
> +	struct dentry *hidden_dir_dentry = NULL;
> +
> +	hidden_dentry = dtohd_index(dentry, bstart);
> +
> +	sprintf(name, ".unionfs%*.*lx",
> +			i_inosize, i_inosize, hidden_dentry->d_inode->i_ino);
> +
> +	tmp_dentry = NULL;
> +	do {
> +		char *suffix = name + nlen - countersize;
> +
> +		dput(tmp_dentry);
> +		counter++;
> +		sprintf(suffix, "%*.*x", countersize, countersize, counter);
> +
> +		printk(KERN_DEBUG "unionfs: trying to rename %s to %s\n",
> +				dentry->d_name.name, name);
> +
> +		tmp_dentry = lookup_one_len(name, hidden_dentry->d_parent,
> +					    UNIONFS_TMPNAM_LEN);
> +		if (IS_ERR(tmp_dentry)) {
> +			err = PTR_ERR(tmp_dentry);
> +			goto out;
> +		}
> +	} while (tmp_dentry->d_inode != NULL);	/* need negative dentry */
> +
> +	err = copyup_named_file(dentry->d_parent->d_inode, file, name, bstart,
> +				bindex, file->f_dentry->d_inode->i_size);
> +	if (err)
> +		goto out;
> +
> +	/* bring it to the same state as an unlinked file */
> +	hidden_dentry = dtohd_index(dentry, dbstart(dentry));
> +	hidden_dir_dentry = lock_parent(hidden_dentry);
> +	err = vfs_unlink(hidden_dir_dentry->d_inode, hidden_dentry);
> +	unlock_dir(hidden_dir_dentry);
> +
> +out:
> +	return err;
> +}
> +
> +static void cleanup_file(struct file *file, struct dentry *dentry)
> +{
> +	int bindex, bstart, bend;
> +
> +	bstart = fbstart(file);
> +	bend = fbend(file);
> +	for (bindex = bstart; bindex <= bend; bindex++) {
> +		if (ftohf_index(file, bindex)) {
> +			branchput(dentry->d_sb, bindex);
> +			fput(ftohf_index(file, bindex));
> +		}
> +	}
> +
> +	if (ftohf_ptr(file)) {
> +		kfree(ftohf_ptr(file));
> +		ftohf_ptr(file) = NULL;
> +	}
> +}
> +
> +static int open_all_files(struct file *file, struct dentry *dentry)
> +{
> +	int bindex, bstart, bend, err = 0;
> +	struct file *hidden_file;
> +	struct dentry *hidden_dentry;
> +	struct super_block *sb = dentry->d_sb;
> +
> +	bstart = dbstart(dentry);
> +	bend = dbend(dentry);
> +
> +	for (bindex = bstart; bindex <= bend; bindex++) {
> +		hidden_dentry = dtohd_index(dentry, bindex);
> +		if (!hidden_dentry)
> +			continue;
> +
> +		dget(hidden_dentry);
> +		mntget(stohiddenmnt_index(sb, bindex));
> +		branchget(sb, bindex);
> +
> +		hidden_file = dentry_open(hidden_dentry,
> +				stohiddenmnt_index(sb, bindex), file->f_flags);
> +		if (IS_ERR(hidden_file)) {
> +			err = PTR_ERR(hidden_file);
> +			goto out;
> +		} else
> +			set_ftohf_index(file, bindex, hidden_file);
> +	}
> +out:
> +	return err;
> +}
> +
> +static int open_highest_file(struct file *file, struct dentry *dentry,
> +			     int willwrite)
> +{
> +	int bindex, bstart, bend, err = 0;
> +	struct file *hidden_file;
> +	struct dentry *hidden_dentry;
> +	struct inode *parent_inode = dentry->d_parent->d_inode;
> +	size_t inode_size = file->f_dentry->d_inode->i_size;
> +	struct super_block *sb = dentry->d_sb;
> +
> +	bstart = dbstart(dentry);
> +	bend = dbend(dentry);
> +
> +	hidden_dentry = dtohd(dentry);
> +	if (willwrite && IS_WRITE_FLAG(file->f_flags)
> +	    && is_robranch(dentry)) {
> +		for (bindex = bstart - 1; bindex >= 0; bindex--) {
> +			err = copyup_file(parent_inode, file, bstart, bindex,
> +					  inode_size);
> +			if (!err)
> +				break;
> +
> +		}
> +		atomic_set(&ftopd(file)->ufi_generation,
> +			atomic_read(&itopd(dentry->d_inode)->uii_generation));
> +		goto out;
> +	}
> +
> +	dget(hidden_dentry);
> +	mntget(stohiddenmnt_index(sb, bstart));
> +	branchget(sb, bstart);
> +	hidden_file = dentry_open(hidden_dentry,
> +			stohiddenmnt_index(sb, bstart), file->f_flags);
> +	if (IS_ERR(hidden_file)) {
> +		err = PTR_ERR(hidden_file);
> +		goto out;
> +	}
> +	set_ftohf(file, hidden_file);
> +	/* Fix up the position. */
> +	hidden_file->f_pos = file->f_pos;
> +
> +	memcpy(&(hidden_file->f_ra), &(file->f_ra),
> +	       sizeof(struct file_ra_state));
> +out:
> +	return err;
> +}
> +
> +static int do_delayed_copyup(struct file *file, struct dentry *dentry)
> +{
> +	int bindex, bstart, bend, err = 0;
> +	struct inode *parent_inode = dentry->d_parent->d_inode;
> +	size_t inode_size = file->f_dentry->d_inode->i_size;
> +
> +	bstart = fbstart(file);
> +	bend = fbend(file);
> +
> +	BUG_ON(!S_ISREG(file->f_dentry->d_inode->i_mode));
> +
> +	for (bindex = bstart - 1; bindex >= 0; bindex--) {
> +		if (!d_deleted(file->f_dentry))
> +			err = copyup_file(parent_inode, file, bstart,
> +					bindex, inode_size);
> +		else
> +			err = copyup_deleted_file(file, dentry, bstart, bindex);
> +
> +		if (!err)
> +			break;
> +	}
> +	if (!err && (bstart > fbstart(file))) {
> +		bend = fbend(file);
> +		for (bindex = bstart; bindex <= bend; bindex++) {
> +			if (ftohf_index(file, bindex)) {
> +				branchput(dentry->d_sb, bindex);
> +				fput(ftohf_index(file, bindex));
> +				set_ftohf_index(file, bindex, NULL);
> +			}
> +		}
> +		fbend(file) = bend;
> +	}
> +	return err;
> +}
> +
> +int unionfs_file_revalidate(struct file *file, int willwrite)
> +{
> +	struct super_block *sb;
> +	struct dentry *dentry;
> +	int sbgen, fgen, dgen;
> +	int bstart, bend;
> +	int size;
> +
> +	int err = 0;
> +
> +	dentry = file->f_dentry;
> +	lock_dentry(dentry);
> +	sb = dentry->d_sb;
> +	unionfs_read_lock(sb);
> +	if (!unionfs_d_revalidate(dentry, NULL) && !d_deleted(dentry)) {
> +		err = -ESTALE;
> +		goto out;
> +	}
> +
> +	sbgen = atomic_read(&stopd(sb)->usi_generation);
> +	dgen = atomic_read(&dtopd(dentry)->udi_generation);
> +	fgen = atomic_read(&ftopd(file)->ufi_generation);
> +
> +	BUG_ON(sbgen > dgen);
> +
> +	/* There are two cases we are interested in.  The first is if the
> +	 * generation is lower than the super-block.  The second is if someone
> +	 * has copied up this file from underneath us, we also need to refresh
> +	 * things. */
> +	if (!d_deleted(dentry) &&
> +	    ((sbgen > fgen) || (dbstart(dentry) != fbstart(file)))) {
> +		/* First we throw out the existing files. */
> +		cleanup_file(file, dentry);
> +
> +		/* Now we reopen the file(s) as in unionfs_open. */
> +		bstart = fbstart(file) = dbstart(dentry);
> +		bend = fbend(file) = dbend(dentry);
> +
> +		size = sizeof(struct file *) * sbmax(sb);
> +		ftohf_ptr(file) = kzalloc(size, GFP_KERNEL);
> +		if (!ftohf_ptr(file)) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +
> +		if (S_ISDIR(dentry->d_inode->i_mode)) {
> +			/* We need to open all the files. */
> +			err = open_all_files(file, dentry);
> +			if (err)
> +				goto out;
> +		} else {
> +			/* We only open the highest priority branch. */
> +			err = open_highest_file(file, dentry, willwrite);
> +			if (err)
> +				goto out;
> +		}
> +		atomic_set(&ftopd(file)->ufi_generation,
> +			   atomic_read(&itopd(dentry->d_inode)->
> +				       uii_generation));
> +	}
> +
> +	/* Copyup on the first write to a file on a readonly branch. */
> +	if (willwrite && IS_WRITE_FLAG(file->f_flags)
> +	    && !IS_WRITE_FLAG(ftohf(file)->f_flags) && is_robranch(dentry)) {
> +		printk(KERN_DEBUG
> +		       "Doing delayed copyup of a read-write file on a read-only branch.\n");
> +		err = do_delayed_copyup(file, dentry);
> +	}
> +
> +out:
> +	unlock_dentry(dentry);
> +	unionfs_read_unlock(dentry->d_sb);
> +	return err;
> +}
> +
> +/* unionfs_open helper function: open a directory */
> +static inline int __open_dir(struct inode *inode, struct file *file)
> +{
> +	struct dentry *hidden_dentry;
> +	struct file *hidden_file;
> +	int bindex, bstart, bend;
> +
> +	bstart = fbstart(file) = dbstart(file->f_dentry);
> +	bend = fbend(file) = dbend(file->f_dentry);
> +
> +	for (bindex = bstart; bindex <= bend; bindex++) {
> +		hidden_dentry = dtohd_index(file->f_dentry, bindex);
> +		if (!hidden_dentry)
> +			continue;
> +
> +		dget(hidden_dentry);
> +		mntget(stohiddenmnt_index(inode->i_sb, bindex));
> +		hidden_file = dentry_open(hidden_dentry,
> +					stohiddenmnt_index(inode->i_sb, bindex),
> +					file->f_flags);

Race! You cannot open an underlying NFS file by name after it has been
looked up: you have no guarantee that it hasn't been renamed.

> +		if (IS_ERR(hidden_file))
> +			return PTR_ERR(hidden_file);
> +
> +		set_ftohf_index(file, bindex, hidden_file);
> +
> +		/* The branchget goes after the open, because otherwise
> +		 * we would miss the reference on release. */
> +		branchget(inode->i_sb, bindex);
> +	}
> +
> +	return 0;
> +}
> +
> +/* unionfs_open helper function: open a file */
> +static inline int __open_file(struct inode *inode, struct file *file)
> +{
> +	struct dentry *hidden_dentry;
> +	struct file *hidden_file;
> +	int hidden_flags;
> +	int bindex, bstart, bend;
> +
> +	hidden_dentry = dtohd(file->f_dentry);
> +	hidden_flags = file->f_flags;
> +
> +	bstart = fbstart(file) = dbstart(file->f_dentry);
> +	bend = fbend(file) = dbend(file->f_dentry);
> +
> +	/* check for the permission for hidden file.  If the error is COPYUP_ERR,
> +	 * copyup the file.
> +	 */
> +	if (hidden_dentry->d_inode && is_robranch(file->f_dentry)) {
> +		/* if the open will change the file, copy it up otherwise defer it. */
> +		if (hidden_flags & O_TRUNC) {
> +			int size = 0;
> +			int err = -EROFS;
> +
> +			/* copyup the file */
> +			for (bindex = bstart - 1; bindex >= 0; bindex--) {
> +				err = copyup_file(file->f_dentry->d_parent->d_inode,
> +						file, bstart, bindex, size);
> +				if (!err)
> +					break;
> +			}
> +			return err;
> +		} else
> +			hidden_flags &= ~(OPEN_WRITE_FLAGS);
> +	}
> +
> +	dget(hidden_dentry);
> +
> +	/* dentry_open will decrement mnt refcnt if err.
> +	 * otherwise fput() will do an mntput() for us upon file close.
> +	 */
> +	mntget(stohiddenmnt_index(inode->i_sb, bstart));
> +	hidden_file = dentry_open(hidden_dentry,
> +				  stohiddenmnt_index(inode->i_sb, bstart),
> +				  hidden_flags);

Race: see above. Besides, calling dentry_open() directly on an NFS file
is a bug!

> +	if (IS_ERR(hidden_file))
> +		return PTR_ERR(hidden_file);
> +
> +	set_ftohf(file, hidden_file);
> +	branchget(inode->i_sb, bstart);
> +
> +	return 0;
> +}
> +
> +int unionfs_open(struct inode *inode, struct file *file)
> +{
> +	int err = 0;
> +	struct file *hidden_file = NULL;
> +	struct dentry *dentry = NULL;
> +	int bindex = 0, bstart = 0, bend = 0;
> +	int size;
> +
> +	ftopd_lhs(file) = kzalloc(sizeof(struct unionfs_file_info), GFP_KERNEL);
> +	if (!ftopd(file)) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	fbstart(file) = -1;
> +	fbend(file) = -1;
> +	atomic_set(&ftopd(file)->ufi_generation,
> +		   atomic_read(&itopd(inode)->uii_generation));
> +
> +	size = sizeof(struct file *) * sbmax(inode->i_sb);
> +	ftohf_ptr(file) = kzalloc(size, GFP_KERNEL);
> +	if (!ftohf_ptr(file)) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	dentry = file->f_dentry;
> +	lock_dentry(dentry);
> +	unionfs_read_lock(inode->i_sb);
> +
> +	bstart = fbstart(file) = dbstart(dentry);
> +	bend = fbend(file) = dbend(dentry);
> +
> +	/* increment, so that we can flush appropriately */
> +	atomic_inc(&itopd(dentry->d_inode)->uii_totalopens);
> +
> +	/* open all directories and make the unionfs file struct point to these hidden file structs */
> +	if (S_ISDIR(inode->i_mode))
> +		err = __open_dir(inode, file);	/* open a dir */
> +	else
> +		err = __open_file(inode, file);	/* open a file */
> +
> +	/* freeing the allocated resources, and fput the opened files */
> +	if (err) {
> +		for (bindex = bstart; bindex <= bend; bindex++) {
> +			hidden_file = ftohf_index(file, bindex);
> +			if (!hidden_file)
> +				continue;
> +
> +			branchput(file->f_dentry->d_sb, bindex);
> +			/* fput calls dput for hidden_dentry */
> +			fput(hidden_file);
> +		}
> +	}
> +
> +	unlock_dentry(dentry);
> +	unionfs_read_unlock(inode->i_sb);
> +
> +out:
> +	if (err) {
> +		kfree(ftohf_ptr(file));
> +		kfree(ftopd(file));
> +	}
> +
> +	return err;
> +}
> +
> +int unionfs_file_release(struct inode *inode, struct file *file)
> +{
> +	int err = 0;
> +	struct file *hidden_file = NULL;
> +	int bindex, bstart, bend;
> +	int fgen;
> +
> +	/* fput all the hidden files */
> +	fgen = atomic_read(&ftopd(file)->ufi_generation);
> +	bstart = fbstart(file);
> +	bend = fbend(file);
> +
> +	for (bindex = bstart; bindex <= bend; bindex++) {
> +		hidden_file = ftohf_index(file, bindex);
> +
> +		if (hidden_file) {
> +			fput(hidden_file);
> +			unionfs_read_lock(inode->i_sb);
> +			branchput(inode->i_sb, bindex);
> +			unionfs_read_unlock(inode->i_sb);
> +		}
> +	}
> +	kfree(ftohf_ptr(file));
> +
> +	if (ftopd(file)->rdstate) {
> +		ftopd(file)->rdstate->uds_access = jiffies;
> +		printk(KERN_DEBUG "Saving rdstate with cookie %u [%d.%lld]\n",
> +		       ftopd(file)->rdstate->uds_cookie,
> +		       ftopd(file)->rdstate->uds_bindex,
> +		       (long long)ftopd(file)->rdstate->uds_dirpos);
> +		spin_lock(&itopd(inode)->uii_rdlock);
> +		itopd(inode)->uii_rdcount++;
> +		list_add_tail(&ftopd(file)->rdstate->uds_cache,
> +			      &itopd(inode)->uii_readdircache);
> +		mark_inode_dirty(inode);
> +		spin_unlock(&itopd(inode)->uii_rdlock);
> +		ftopd(file)->rdstate = NULL;
> +	}
> +	kfree(ftopd(file));
> +	return err;
> +}
> +
> +static inline long do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct file *hidden_file;
> +	int err;
> +
> +	hidden_file = ftohf(file);
> +
> +	err = security_file_ioctl(hidden_file, cmd, arg);
> +	if (err)
> +		goto out;
> +	err = -ENOTTY;
> +	if (!hidden_file || !hidden_file->f_op)
> +		goto out;
> +	if (hidden_file->f_op->unlocked_ioctl) {
> +		err = hidden_file->f_op->unlocked_ioctl(hidden_file, cmd, arg);
> +	} else if (hidden_file->f_op->ioctl) {
> +		lock_kernel();
> +		err = hidden_file->f_op->ioctl(hidden_file->f_dentry->d_inode,
> +					       hidden_file, cmd, arg);
> +		unlock_kernel();
> +	}
> +
> +out:
> +	return err;
> +}
> +
> +long unionfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	long err = 0;		/* don't fail by default */
> +
> +	if ((err = unionfs_file_revalidate(file, 1)))
> +		goto out;
> +
> +	/* check if asked for local commands */
> +	switch (cmd) {
> +		case UNIONFS_IOCTL_INCGEN:
> +			if (!capable(CAP_SYS_ADMIN)) {
> +				err = -EACCES;
> +				goto out;
> +			}
> +			err = unionfs_ioctl_incgen(file, cmd, arg);
> +			break;
> +
> +		case UNIONFS_IOCTL_QUERYFILE:
> +			err = unionfs_ioctl_queryfile(file, cmd, arg);
> +			break;
> +
> +		default:
> +			err = do_ioctl(file, cmd, arg);
> +			break;
> +	}
> +
> +out:
> +	return err;
> +}
> +
> +int unionfs_flush(struct file *file, fl_owner_t id)
> +{
> +	int err = 0;		/* assume ok (see open.c:close_fp) */
> +	struct file *hidden_file = NULL;
> +	int bindex, bstart, bend;
> +
> +	if ((err = unionfs_file_revalidate(file, 1)))
> +		goto out;
> +	if (!atomic_dec_and_test
> +	    (&itopd(file->f_dentry->d_inode)->uii_totalopens))
> +		goto out;
> +
> +	lock_dentry(file->f_dentry);
> +
> +	bstart = fbstart(file);
> +	bend = fbend(file);
> +	for (bindex = bstart; bindex <= bend; bindex++) {
> +		hidden_file = ftohf_index(file, bindex);
> +
> +		if (hidden_file && hidden_file->f_op
> +		    && hidden_file->f_op->flush) {
> +			err = hidden_file->f_op->flush(hidden_file, id);
> +			if (err)
> +				goto out_lock;
> +
> +			/* if there are no more references to the dentry, dput it */
> +			if (d_deleted(file->f_dentry)) {
> +				dput(dtohd_index(file->f_dentry, bindex));
> +				set_dtohd_index(file->f_dentry, bindex, NULL);
> +			}
> +		}
> +
> +	}
> +
> +out_lock:
> +	unlock_dentry(file->f_dentry);
> +out:
> +	return err;
> +}
> +
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
VGER BF report: H 0.0108304
