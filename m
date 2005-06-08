Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVFHQxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFHQxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVFHQuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:50:32 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:16348 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261374AbVFHQo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:44:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UQ1fQaIoW4ebZ3oDP9LFEl+BxXylK84MidX2Edy/gHlFYc5WHdsLV+JQvrlclDQ7Zixq9/G1qZrliLxY0PJ3eQDZMVGbFjJI1tMlVq4FOFABIPdjJLnWTzo8Io277kumAc3jCPdTQJTK3liBa18/6HDegVmV5D9a9/cw8Lcy40g=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: ericvh@gmail.com
Subject: Re: [PATCH 3/7] v9fs: VFS inode operations (2.0)
Date: Wed, 8 Jun 2005 20:48:49 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org
References: <200506071449.j57EnpRZ029602@ms-smtp-03-eri0.texas.rr.com>
In-Reply-To: <200506071449.j57EnpRZ029602@ms-smtp-03-eri0.texas.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506082048.50244.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 June 2005 18:49, ericvh@gmail.com wrote:
> This is part [3/7] of the v9fs-2.0 patch against Linux 2.6.
> 
> This part of the patch contains the VFS inode interfaces.

More findings at the micro level.

> --- /dev/null
> +++ b/fs/9p/vfs_inode.c

> + * This file contians vfs inode ops for the 9P2000 protocol.

contains

> +static inline int unixmode2p9mode(struct v9fs_session_info *v9ses, int mode)
> +{
> +	int res;
> +	res = mode & 0777;
> +	if (S_ISDIR(mode))
> +		res |= V9FS_DMDIR;
> +	if (v9ses->extended) {
> +		if (S_ISLNK(mode))
> +			res |= V9FS_DMSYMLINK;
> +		if (v9ses->nodev == 0) {
> +			if (S_ISSOCK(mode))
> +				res |= V9FS_DMSOCKET;
> +			if (S_ISFIFO(mode))
> +				res |= V9FS_DMNAMEDPIPE;
> +			if (S_ISBLK(mode))
> +				res |= V9FS_DMDEVICE;
> +			if (S_ISCHR(mode))
> +				res |= V9FS_DMDEVICE;
> +		}
> +
> +		if ((mode & S_ISUID) == S_ISUID)
> +			res |= V9FS_DMSETUID;
> +		if ((mode & S_ISGID) == S_ISGID)
> +			res |= V9FS_DMSETGID;
> +		if ((mode & V9FS_DMLINK))
> +			res |= V9FS_DMLINK;
> +	}
> +
> +	return res;
> +}

> +static inline int p9mode2unixmode(struct v9fs_session_info *v9ses, int mode)
> +{
> +	int res;
> +
> +	res = mode & 0777;
> +
> +	if ((mode & V9FS_DMDIR) == V9FS_DMDIR)
> +		res |= S_IFDIR;
> +	else if ((mode & V9FS_DMSYMLINK) && (v9ses->extended))
> +		res |= S_IFLNK;
> +	else if ((mode & V9FS_DMSOCKET) && (v9ses->extended)
> +		 && (v9ses->nodev == 0))
> +		res |= S_IFSOCK;
> +	else if ((mode & V9FS_DMNAMEDPIPE) && (v9ses->extended)
> +		 && (v9ses->nodev == 0))
> +		res |= S_IFIFO;
> +	else if ((mode & V9FS_DMDEVICE) && (v9ses->extended)
> +		 && (v9ses->nodev == 0))
> +		res |= S_IFBLK;
> +	else
> +		res |= S_IFREG;
> +
> +	if (v9ses->extended) {
> +		if ((mode & V9FS_DMSETUID) == V9FS_DMSETUID)
> +			res |= S_ISUID;
> +
> +		if ((mode & V9FS_DMSETGID) == V9FS_DMSETGID)
> +			res |= S_ISGID;
> +	}
> +
> +	return res;
> +}

> +static inline void
> +v9fs_blank_mistat(struct v9fs_session_info *v9ses, struct v9fs_stat *mistat)
> +{
> +	mistat->type = ~0;
> +	mistat->dev = ~0;
> +	mistat->qid.type = ~0;
> +	mistat->qid.version = ~0;
> +	*((long long *)&mistat->qid.path) = ~0;
> +	mistat->mode = ~0;
> +	mistat->atime = ~0;
> +	mistat->mtime = ~0;
> +	mistat->length = ~0;
> +	mistat->name = mistat->data;
> +	mistat->uid = mistat->data;
> +	mistat->gid = mistat->data;
> +	mistat->muid = mistat->data;
> +	if (v9ses->extended) {
> +		mistat->n_uid = ~0;
> +		mistat->n_gid = ~0;
> +		mistat->n_muid = ~0;
> +		mistat->extension = mistat->data;
> +	}
> +	*mistat->data = 0;
> +}

Approximately 178, 150 and 122 bytes of object code, respectively. Do you
really want them to be inlined?

> +/**
> + * v9fs_mistat2unix - convert mistat to unix stat
> + * @mistat: Plan 9 metadata (mistat) structure
> + * @stat: unix metadata (stat) structure to populate 
> + * @sb: superblock
> + *
> + */
> +
> +static void
> +v9fs_mistat2unix(struct v9fs_stat *mistat, struct stat *buf,
> +		 struct super_block *sb)

Comments and arguments don't match.

> +{

> +	if (v9ses && v9ses->extended) {
> +		/* TODO: string to uid mapping via user-space daemon */
> +		buf->st_uid = mistat->n_uid;
> +		buf->st_gid = mistat->n_gid;
> +
> +		sscanf(mistat->uid, "%x", (unsigned int *)&buf->st_uid);
> +		sscanf(mistat->gid, "%x", (unsigned int *)&buf->st_gid);
> +	} else {
> +		buf->st_uid = v9ses->uid;
> +		buf->st_gid = v9ses->gid;
> +	}

??? st_uid and st_gid will be overwritten.

> +	buf->st_uid = (unsigned short)-1;
> +	buf->st_gid = (unsigned short)-1;
> +
> +	if (v9ses && v9ses->extended) {
> +		if (mistat->n_uid != -1)
> +			sscanf(mistat->uid, "%x", (unsigned int *)&buf->st_uid);
> +
> +		if (mistat->n_gid != -1)
> +			sscanf(mistat->gid, "%x", (unsigned int *)&buf->st_gid);
> +	}
> +
> +	if (buf->st_uid == (unsigned short)-1)
> +		buf->st_uid = v9ses->uid;
> +	if (buf->st_gid == (unsigned short)-1)
> +		buf->st_gid = v9ses->gid;

> +/**
> + * v9fs_create - helper function to create files and directories

> + * @open_mode: resulting open mode for file ???

You're not sure?

> +/**
> + * v9fs_remove - helper function to remove files and directories
> + * @inode: directory inode that is being deleted
> + * @dentry:  dentry that is being deleted
> + * @rmdir: where we are a file or a directory
> + *
> + */
> +
> +static int v9fs_remove(struct inode *dir, struct dentry *file, int rmdir)

Comment and arguments don't match.

> +/**
> + * v9fs_vfs_mkdir - VFS mkdir hook to create a directory
> + * @i:  inode that is being unlinked

@inode

> + * @dentry: dentry that is being unlinked
> + * @mode: mode for new directory

> +static int v9fs_vfs_mkdir(struct inode *inode, struct dentry *dentry, int mode)

> +/**
> + * v9fs_vfs_unlink - VFS unlink hook to delete an inode
> + * @i:  inode that is being unlinked
> + * @dentry: dentry that is being unlinked
> + *
> + */
> +
> +static int v9fs_vfs_unlink(struct inode *i, struct dentry *d)

Comment and arguments don't match.

> +/**
> + * v9fs_vfs_rmdir - VFS unlink hook to delete a directory
> + * @i:  inode that is being unlinked
> + * @dentry: dentry that is being unlinked
> + *
> + */
> +
> +static int v9fs_vfs_rmdir(struct inode *i, struct dentry *d)

Comment and arguments don't match.

> +static int
> +v9fs_vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
> +		struct inode *new_dir, struct dentry *new_dentry)
> +{

> +	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);

Unchecked kmalloc.

> +static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
> +{

> +	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);

Better move right before !mistat check.

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

> +	if (v9ses->extended) {
> +		char *uid = kmalloc(strlen(mistat->uid), GFP_KERNEL);
> +		char *gid = kmalloc(strlen(mistat->gid), GFP_KERNEL);
> +		char *muid = kmalloc(strlen(mistat->muid), GFP_KERNEL);
> +		char *name = kmalloc(strlen(mistat->name), GFP_KERNEL);
> +		char *extension = kmalloc(strlen(mistat->extension),
> +					  GFP_KERNEL);
> +
> +		if ((!uid) || (!gid) || (!muid) || (!name) || (!extension)) {
> +			kfree(uid);
> +			kfree(gid);
> +			kfree(muid);
> +			kfree(name);
> +			kfree(extension);
> +
> +			return -ENOMEM;

kfree(mistat);

> +		if (iattr->ia_valid & ATTR_UID) {
> +			if (strlen(uid) != 8) {
> +				dprintk(DEBUG_ERROR, "uid strlen is %u not 8\n",
> +					(unsigned int)strlen(uid));
> +				sprintf(uid, "%08x", iattr->ia_uid);
> +			} else {
> +				kfree(uid);
> +				uid = kmalloc(9, GFP_KERNEL);

Unchecked kmalloc.

> +			}
> +
> +			sprintf(uid, "%08x", iattr->ia_uid);

Double sprintf.

> +			mistat->n_uid = iattr->ia_uid;
> +		}
> +
> +		if (iattr->ia_valid & ATTR_GID) {
> +			if (strlen(gid) != 8)
> +				dprintk(DEBUG_ERROR, "gid strlen is %u not 8\n",
> +					(unsigned int)strlen(gid));
> +			else {
> +				kfree(gid);
> +				gid = kmalloc(9, GFP_KERNEL);
> +			}
> +
> +			sprintf(gid, "%08x", iattr->ia_gid);
> +			mistat->n_gid = iattr->ia_gid;
> +		}

See uid.

> +static int
> +v9fs_vfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
> +{
> +	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);

Unchecked kmalloc.

> +	v9fs_blank_mistat(v9ses, mistat);

> +/**
> + * v9fs_readlink - read a symlink's location (internal version)

> + * @buf: buffer to load symlink location into

@buffer

> +static int v9fs_readlink(struct dentry *dentry, char *buffer, int buflen)

> +/**
> + * v9fs_vfs_link - create a hardlink

> + * @new_dentry: dentry for link

@dentry. Or new_dentry in the code.

> +static int
> +v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
> +	      struct dentry *dentry)
> +{

> +	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);

Unchecked kmalloc.

> +/**
> + * v9fs_vfs_mknod - create a special file

> + * @dev_t: device associated with special file

@rdev

> +static int
> +v9fs_vfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
> +{

> +	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);

Guess what? :-)

> +	else if (S_ISFIFO(mode)) ;	/* DO NOTHING */
> +	else {

	else if (S_ISFIFO(mode))
		;
	else {

means "do nothing" perfectly.

> +	if (!S_ISFIFO(mode)) {
> +		/* issue a twstat */
> +		v9fs_blank_mistat(v9ses, mistat);
> +		strcpy(mistat->data + 1, symname);
> +		mistat->extension = mistat->data + 1;
> +		retval = v9fs_t_wstat(v9ses, newfid->fid, mistat, &fcall);
> +		if (retval < 0) {
> +			dprintk(DEBUG_ERROR, "v9fs_t_wstat error: %s\n",
> +				FCALL_ERROR(fcall));
> +			goto FreeMem;
> +		}
> +
> +		kfree(fcall);

Will be freed in a line.

> +	}
> +
> +	/* need to update dcache so we show up */
> +	kfree(fcall);
