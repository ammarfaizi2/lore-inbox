Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVEXIsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVEXIsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVEXIsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:48:21 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:35701 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261974AbVEXInl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:43:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pw71Y7kZIRC4tm8syBYWv7tcFG8BlS2H+M5cUZn74R/GScJ2PasIV1qXio4+vQ1KrlM3HreJc1ms69qQeuY7Kp0ViFWPAz+lKD9X4+Z/EluYJb/ieIRBpThL/HfjtoXVcQ20rrgEFJYSunWm9VQrkJ+NrJt4kH/lAV6iiO9JjH8=
Message-ID: <84144f0205052401432ffa1075@mail.gmail.com>
Date: Tue, 24 May 2005 11:43:35 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: "ericvh@gmail.com" <ericvh@gmail.com>
Subject: Re: [RFC][patch 3/7] v9fs: VFS inode operations (2.0-rc6)
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi
In-Reply-To: <200505232225.j4NMPmH9014347@ms-smtp-01-eri0.texas.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505232225.j4NMPmH9014347@ms-smtp-01-eri0.texas.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Few comments below.

On 5/24/05, ericvh@gmail.com <ericvh@gmail.com> wrote:
> +
> +/**
> + * v9fs_get_inode - helper function to setup an inode
> + * @sb: superblock
> + * @mode: mode to setup inode with
> + *
> + */
> +
> +struct inode *v9fs_get_inode(struct super_block *sb, int mode)
> +{
> +	struct inode *inode = NULL;
> +
> +	dprintk(DEBUG_VFS, "super block: %p mode: %o\n", sb, mode);
> +	switch (mode & S_IFMT) {
> +	default:
> +		dprintk(DEBUG_ERROR, "BAD mode 0x%x S_IFMT 0x%x\n", mode,
> +			mode & S_IFMT);
> +		return ERR_PTR(-EINVAL);

Please move this ...

> +		break;
> +	case S_IFREG:
> +	case S_IFDIR:
> +	case S_IFLNK:
> +	case S_IFIFO:
> +	case S_IFBLK:
> +	case S_IFCHR:
> +	case S_IFSOCK:
> +		break;
> +	}
> +
> +	inode = new_inode(sb);
> +	if (inode) {
> +		inode->i_mode = mode;
> +		inode->i_uid = current->fsuid;
> +		inode->i_gid = current->fsgid;
> +		inode->i_blksize = sb->s_blocksize;
> +		inode->i_blocks = 0;
> +		inode->i_rdev = 0;
> +		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
> +
> +		switch (mode & S_IFMT) {
> +		default:
> +			panic("Can't happen");

... here. Drop the panic() and the above switch statement.

> +			break;
> +		case S_IFIFO:
> +		case S_IFBLK:
> +		case S_IFCHR:
> +		case S_IFSOCK:
> +		case S_IFREG:
> +			inode->i_op = &v9fs_file_inode_operations;
> +			inode->i_fop = &v9fs_file_operations;
> +			break;
> +		case S_IFDIR:
> +			inode->i_nlink++;
> +			inode->i_op = &v9fs_dir_inode_operations;
> +			inode->i_fop = &v9fs_dir_operations;
> +			break;
> +		case S_IFLNK:
> +			inode->i_op = &v9fs_symlink_inode_operations;
> +			break;
> +		}
> +	} else {
> +		eprintk(KERN_WARNING, "Problem allocating inode\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	return inode;
> +}
> +
> +/**
> + * v9fs_create - helper function to create files and directories
> + * @dir: directory inode file is being created in
> + * @file_dentry: dentry file is being created in 
> + * @perm: permissions file is being created with
> + * @open_mode: resulting open mode for file ???
> + * 
> + */
> +
> +static int
> +v9fs_create(struct inode *dir,
> +	    struct dentry *file_dentry,
> +	    unsigned int perm, unsigned int open_mode)
> +{
> +	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
> +	struct super_block *sb = dir ? dir->i_sb : NULL;

Please move the sb != NULL check below. The assignment is hairy.

> +	struct v9fs_fid *dirfid =
> +	    v9fs_fid_lookup(file_dentry->d_parent, FID_WALK);
> +	struct v9fs_fid *fid = NULL;
> +	struct inode *file_inode = NULL;
> +	struct v9fs_fcall *fcall = NULL;
> +	struct v9fs_qid qid;
> +	struct stat newstat;
> +	int dirfidnum = -1;
> +	long newfid = -1;
> +	int result = 0;
> +	unsigned int iounit = 0;
> +
> +	perm = unixmode2p9mode(v9ses, perm);
> +
> +	dprintk(DEBUG_VFS, "dir: %p dentry: %p perm: %o mode: %o\n", dir,
> +		file_dentry, perm, open_mode);
> +
> +	if ((!dirfid) || (!sb) || (!v9ses)) {
> +		dprintk(DEBUG_ERROR, "problem with arguments\n");
> +		return -EBADF;
> +	}
> +

[snip]

> +static int
> +v9fs_vfs_create(struct inode *inode, struct dentry *dentry, int perm,
> +		struct nameidata *nd)
> +{
> +	int retval = -EPERM;
> +	int open_mode = O_RDWR;
> +
> +	retval = v9fs_create(inode, dentry, perm, open_mode);
> +
> +	return retval;

Both local variables are redundant. Please just do:

	return v9fs_create(inode, dentry, perm, O_RDWR);

> +}
> +
> +/**
> + * v9fs_vfs_mkdir - VFS mkdir hook to create a directory
> + * @i:  inode that is being unlinked
> + * @dentry: dentry that is being unlinked
> + * @mode: mode for new directory
> + *
> + */
> +
> +static int v9fs_vfs_mkdir(struct inode *inode, struct dentry *dentry, int mode)
> +{
> +	int retval = -EPERM;
> +	int open_mode = O_RDONLY;
> +
> +	retval = v9fs_create(inode, dentry, mode | S_IFDIR, open_mode);
> +
> +	return retval;

Same here.

> +void v9fs_dentry_release(struct dentry *dentry)
> +{
> +	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
> +
> +	if (dentry->d_fsdata != NULL) {
> +		struct list_head *fid_list =
> +		    (struct list_head *)dentry->d_fsdata;

Drop the redundant cast.

> +		struct list_head *temp;
> +		struct v9fs_fid *current_fid = NULL;
> +		struct list_head *p;
> +		struct v9fs_fcall *fcall = NULL;
> +
> +		list_for_each_safe(p, temp, fid_list) {
> +			current_fid = list_entry(p, struct v9fs_fid, list);
> +			if (v9fs_t_clunk
> +			    (current_fid->v9ses, current_fid->fid, &fcall))
> +				dprintk(DEBUG_ERROR, "clunk failed: %s\n",
> +					FCALL_ERROR(fcall));
> +
> +			v9fs_put_idpool(current_fid->fid,
> +					&current_fid->v9ses->fidpool);
> +
> +			safe_cache_free(current_fid->v9ses->slab, fcall);
> +			v9fs_fid_destroy(current_fid);
> +		}
> +
> +		kfree(dentry->d_fsdata);	/* free the list_head */
> +	}
> +}
> +
> +static struct dentry_operations v9fs_dentry_operations = {
> +	.d_revalidate = v9fs_dentry_validate,
> +	.d_delete = v9fs_dentry_delete,
> +	.d_release = v9fs_dentry_release,
> +};
> +
> +/**
> + * v9fs_vfs_lookup - VFS lookup hook to "walk" to a new inode
> + * @dir:  inode that is being walked from
> + * @dentry: dentry that is being walked to?
> + * @nameidata: path data
> + *
> + */
> +
> +static struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
> +				      struct nameidata *nameidata)
> +{
> +	struct super_block *sb = NULL;
> +	struct v9fs_session_info *v9ses = NULL;
> +	struct v9fs_fid *dirfid = NULL;
> +	struct v9fs_fid *fid = NULL;
> +	struct inode *inode = NULL;

These NULL assignments are redundant.

> +	struct dentry *retval = NULL;

This variable is never changed. Therefore drop it and return NULL at the bottom.

> +	struct v9fs_fcall *fcall = NULL;
> +	struct stat newstat;
> +	int dirfidnum = -1;
> +	int newfid = -1;
> +	int result = 0;

More redundant assignments (except for fcall).

> +
> +	dprintk(DEBUG_VFS, "dir: %p dentry: (%s) %p nameidata: %p\n",
> +		dir, dentry->d_iname, dentry, nameidata);
> +
> +	if (!dir) {
> +		dprintk(DEBUG_ERROR, "no dir inode\n");

Perhaps you could drop at least some of these debugging printk's as they make
the code harder to follow.

> +static int v9fs_vfs_unlink(struct inode *i, struct dentry *d)
> +{
> +	int retval = -EPERM;
> +
> +	retval = v9fs_remove(i, d, 0);
> +	return retval;

Redundant local variables.

> +}
> +
> +/**
> + * v9fs_vfs_rmdir - VFS unlink hook to delete a directory
> + * @i:  inode that is being unlinked
> + * @dentry: dentry that is being unlinked
> + *
> + */
> +
> +static int v9fs_vfs_rmdir(struct inode *i, struct dentry *d)
> +{
> +	int retval = -EPERM;
> +
> +	retval = v9fs_remove(i, d, 1);
> +	return retval;

Ditto.

> +}
> +
> +/**
> + * v9fs_vfs_rename - VFS hook to rename an inode
> + * @old_dir:  old dir inode
> + * @old_dentry: old dentry
> + * @new_dir: new dir inode
> + * @new_dentry: new dentry
> + * 
> + */
> +
> +static int
> +v9fs_vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
> +		struct inode *new_dir, struct dentry *new_dentry)
> +{
> +	struct inode *old_inode = old_dentry ? old_dentry->d_inode : NULL;

Please move this assignment below and use proper if (!old_dentry) style
error handling. These assignments are hard to follow.

> +	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(old_inode);
> +	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry, FID_WALK);
> +	struct v9fs_fid *olddirfid =
> +	    v9fs_fid_lookup(old_dentry->d_parent, FID_WALK);
> +	struct v9fs_fid *newdirfid =
> +	    v9fs_fid_lookup(new_dentry->d_parent, FID_WALK);
> +	struct v9fs_stat *mistat = kmem_cache_alloc(v9ses->slab, GFP_KERNEL);
> +	struct v9fs_fcall *fcall = NULL;
> +	int fid = -1;
> +	int olddirfidnum = -1;
> +	int newdirfidnum = -1;
> +	int retval = 0;
> +
> +	dprintk(DEBUG_VFS, "\n");
> +
> +	if ((!oldfid) || (!olddirfid) || (!newdirfid)) {
> +		dprintk(DEBUG_ERROR, "problem with arguments\n");
> +		return -EPERM;
> +	}
> +
> +	/* 9P can only handle file rename in the same directory */
> +	if (memcmp(&olddirfid->qid, &newdirfid->qid, sizeof(newdirfid->qid))) {
> +		dprintk(DEBUG_ERROR, "old dir and new dir are different\n");
> +		retval = -EPERM;
> +		goto FreeFcall;

Please consider calling the above label "failed" or something similar. The
current one doesn't exactly communicate we're bailing out.

> +static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
> +{
> +	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dentry->d_inode);
> +	struct v9fs_fid *fid = v9fs_fid_lookup(dentry, FID_OP);
> +	struct v9fs_stat *mistat = kmem_cache_alloc(v9ses->slab, GFP_KERNEL);
> +	struct v9fs_fcall *fcall = NULL;
> +	int res = -EPERM;
> +
> +	dprintk(DEBUG_VFS, "\n");
> +	if (!fid) {
> +		dprintk(DEBUG_ERROR,
> +			"Couldn't find fid associated with dentry\n");
> +		return -EBADF;
> +	}
> +
> +	if (!mistat)
> +		return -ENOMEM;
> +
> +	v9fs_blank_mistat(v9ses, mistat);
> +	if (iattr->ia_valid & ATTR_MODE)
> +		mistat->mode = unixmode2p9mode(v9ses, iattr->ia_mode);
> +
> +	if (iattr->ia_valid & ATTR_MTIME)
> +		mistat->mtime = iattr->ia_mtime.tv_sec;
> +
> +	if (iattr->ia_valid & ATTR_ATIME)
> +		mistat->atime = iattr->ia_atime.tv_sec;
> +
> +	if (iattr->ia_valid & ATTR_SIZE)
> +		mistat->length = iattr->ia_size;
> +
> +	if (v9ses->extended) {
> +		char *uid = NULL;
> +		char *gid = NULL;
> +		char *muid = NULL;
> +		char *name = NULL;
> +		char *extension = NULL;

Redundant assignments.

> +static int
> +v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
> +	      struct dentry *dentry)
> +{
> +	int retval = -EPERM;
> +	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
> +	struct super_block *sb = dir ? dir->i_sb : NULL;
> +	struct v9fs_fcall *fcall = NULL;
> +	struct v9fs_stat *mistat = kmem_cache_alloc(v9ses->slab, GFP_KERNEL);
> +	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry, FID_OP);
> +	struct v9fs_fid *newfid = NULL;
> +	char symname[255];	/* just going to store hardlinkfid(%x) */

Please use kmalloc() instead. You're using a lot of stack here.

> +static int
> +v9fs_vfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
> +{
> +	int retval = -EPERM;
> +	struct v9fs_fid *newfid;
> +	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
> +	struct super_block *sb = dir ? dir->i_sb : NULL;
> +	struct v9fs_fcall *fcall = NULL;
> +	struct v9fs_stat *mistat = kmem_cache_alloc(v9ses->slab, GFP_KERNEL);
> +	char symname[255];

Same here.

			Pekka
