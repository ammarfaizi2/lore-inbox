Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWFSIH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWFSIH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWFSIH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:07:28 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:27306 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S932255AbWFSIHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:07:25 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20060618235538.3600d06f.akpm@osdl.org> (message from Andrew
	Morton on Sun, 18 Jun 2006 23:55:38 -0700)
Subject: Re: [PATCH 3/7] fuse: add control filesystem
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
	<E1FplWy-000620-00@dorka.pomaz.szeredi.hu> <20060618235538.3600d06f.akpm@osdl.org>
Message-Id: <E1FsEmX-0002Kl-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 19 Jun 2006 10:06:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Presumably people with currently-working setups will find that whatever
> they used to have in /sys/fs/fuse/connections won't be there any more, so
> this is a non-back-compatible change.  How do we help them with that?

I can't think of any good technical solutions.  But the control
filesystem should only ever be used in case of a major cock-up needing
manual intervention anyway, and not during normal operation.
E.g. somebody is trying very hard to deadlock a fuse filesystem.

So documenting it and alerting package maintainers should be enough I
think.

> > +static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
> > +				      size_t len, loff_t *ppos)
> > +{
> > +	char tmp[32];
> > +	size_t size;
> > +
> > +	if (!*ppos) {
> > +		struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
> > +		if (!fc)
> > +			return 0;
> > +
> > +		file->private_data = (void *) atomic_read(&fc->num_waiting);
> > +		fuse_conn_put(fc);
> > +	}
> > +	size = sprintf(tmp, "%i\n", (int) file->private_data);
> > +	return simple_read_from_buffer(buf, len, ppos, tmp, size);
> > +}
> 
> What happens if the first read isn't at file offset 0?

Can't happen, because it's been opened with nonseekable_open.

> > +
> > +static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
> > +					  struct fuse_conn *fc,
> > +					  const char *name,
> > +					  int mode, int nlink,
> > +					  struct inode_operations *iop,
> > +					  const struct file_operations *fop)
> > +{
> > +	struct dentry *dentry;
> > +	struct inode *inode;
> > +
> > +	BUG_ON(fc->ctl_ndents >= FUSE_CTL_NUM_DENTRIES);
> > +	dentry = d_alloc_name(parent, name);
> > +	if (!dentry)
> > +		return NULL;
> > +
> > +	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
> 
> What locking protects fc->ctl_ndents?

fuse_mutex.  It's sort of documented at the declaration of fuse_mutex
in <fuse_i.h>, but I'll also add a header comment to these functions.

> > +	inode = new_inode(fuse_control_sb);
> > +	if (!inode)
> > +		return NULL;
> > +
> > +	inode->i_mode = mode;
> > +	inode->i_uid = fc->user_id;
> > +	inode->i_gid = fc->group_id;
> > +	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
> > +	if (iop)
> > +		inode->i_op = iop;
> 
> Is iop ever null?

Yes, for the non-directory nodes.

> > +	inode->i_fop = fop;
> > +	inode->i_nlink = nlink;
> > +	inode->u.generic_ip = fc;
> > +	d_add(dentry, inode);
> > +	return dentry;
> > +}
> > +
> > +int fuse_ctl_add_conn(struct fuse_conn *fc)
> > +{
> > +	struct dentry *parent;
> > +	char name[32];
> > +
> > +	if (!fuse_control_sb)
> > +		return 0;
> 
> Can this happen?

Certainly.  fuse_control_sb is non null only while the sb is active
(when it's mounted at least once).  A kernel mount could be created at
init time, but then the module unload problem would still remain.

> 
> > +	parent = fuse_control_sb->s_root;
> > +	parent->d_inode->i_nlink++;
> 
> What locking protects i_nlink?

fuse_mutex.

> 
> > +	sprintf(name, "%llu", (unsigned long long) fc->id);
> > +	parent = fuse_ctl_add_dentry(parent, fc, name, S_IFDIR | 0500, 2,
> > +				     &simple_dir_inode_operations,
> > +				     &simple_dir_operations);
> > +	if (!parent)
> > +		goto err;
> > +
> > +	if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400, 1,
> > +				NULL, &fuse_ctl_waiting_ops) ||
> > +	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
> > +				 NULL, &fuse_ctl_abort_ops))
> > +		goto err;
> > +
> > +	return 0;
> > +
> > + err:
> > +	fuse_ctl_remove_conn(fc);
> > +	return -ENOMEM;
> > +}
> > +
> > +void fuse_ctl_remove_conn(struct fuse_conn *fc)
> > +{
> > +	int i;
> > +
> > +	if (!fuse_control_sb)
> > +		return;
> > +
> > +	for (i = fc->ctl_ndents - 1; i >= 0; i--) {
> > +		struct dentry *dentry = fc->ctl_dentry[i];
> > +		dentry->d_inode->u.generic_ip = NULL;
> > +		d_drop(dentry);
> > +		dput(dentry);
> > +	}
> > +	fuse_control_sb->s_root->d_inode->i_nlink--;
> 
> Ditto.

Thanks,
Miklos
