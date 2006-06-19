Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWFSGzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWFSGzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 02:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWFSGzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 02:55:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6363 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751147AbWFSGzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 02:55:43 -0400
Date: Sun, 18 Jun 2006 23:55:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] fuse: add control filesystem
Message-Id: <20060618235538.3600d06f.akpm@osdl.org>
In-Reply-To: <E1FplWy-000620-00@dorka.pomaz.szeredi.hu>
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
	<E1FplWy-000620-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 14:28:32 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> Add a control filesystem to fuse, replacing the attributes currently
> exported through sysfs.  An empty directory '/sys/fs/fuse/connections'
> is still created in sysfs, and mounting the control filesystem here
> provides backward compatibility.
> 
> Advantages of the control filesystem over the previous solution:
> 
>   - allows the object directory and the attributes to be owned by the
>     filesystem owner, hence letting unpriviled users abort the
>     filesystem connection
> 
>   - does not suffer from module unload race
> 

Presumably people with currently-working setups will find that whatever
they used to have in /sys/fs/fuse/connections won't be there any more, so
this is a non-back-compatible change.  How do we help them with that?


> +static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
> +				      size_t len, loff_t *ppos)
> +{
> +	char tmp[32];
> +	size_t size;
> +
> +	if (!*ppos) {
> +		struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
> +		if (!fc)
> +			return 0;
> +
> +		file->private_data = (void *) atomic_read(&fc->num_waiting);
> +		fuse_conn_put(fc);
> +	}
> +	size = sprintf(tmp, "%i\n", (int) file->private_data);
> +	return simple_read_from_buffer(buf, len, ppos, tmp, size);
> +}

What happens if the first read isn't at file offset 0?

> +
> +static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
> +					  struct fuse_conn *fc,
> +					  const char *name,
> +					  int mode, int nlink,
> +					  struct inode_operations *iop,
> +					  const struct file_operations *fop)
> +{
> +	struct dentry *dentry;
> +	struct inode *inode;
> +
> +	BUG_ON(fc->ctl_ndents >= FUSE_CTL_NUM_DENTRIES);
> +	dentry = d_alloc_name(parent, name);
> +	if (!dentry)
> +		return NULL;
> +
> +	fc->ctl_dentry[fc->ctl_ndents++] = dentry;

What locking protects fc->ctl_ndents?

> +	inode = new_inode(fuse_control_sb);
> +	if (!inode)
> +		return NULL;
> +
> +	inode->i_mode = mode;
> +	inode->i_uid = fc->user_id;
> +	inode->i_gid = fc->group_id;
> +	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
> +	if (iop)
> +		inode->i_op = iop;

Is iop ever null?

> +	inode->i_fop = fop;
> +	inode->i_nlink = nlink;
> +	inode->u.generic_ip = fc;
> +	d_add(dentry, inode);
> +	return dentry;
> +}
> +
> +int fuse_ctl_add_conn(struct fuse_conn *fc)
> +{
> +	struct dentry *parent;
> +	char name[32];
> +
> +	if (!fuse_control_sb)
> +		return 0;

Can this happen?

> +	parent = fuse_control_sb->s_root;
> +	parent->d_inode->i_nlink++;

What locking protects i_nlink?

> +	sprintf(name, "%llu", (unsigned long long) fc->id);
> +	parent = fuse_ctl_add_dentry(parent, fc, name, S_IFDIR | 0500, 2,
> +				     &simple_dir_inode_operations,
> +				     &simple_dir_operations);
> +	if (!parent)
> +		goto err;
> +
> +	if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400, 1,
> +				NULL, &fuse_ctl_waiting_ops) ||
> +	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
> +				 NULL, &fuse_ctl_abort_ops))
> +		goto err;
> +
> +	return 0;
> +
> + err:
> +	fuse_ctl_remove_conn(fc);
> +	return -ENOMEM;
> +}
> +
> +void fuse_ctl_remove_conn(struct fuse_conn *fc)
> +{
> +	int i;
> +
> +	if (!fuse_control_sb)
> +		return;
> +
> +	for (i = fc->ctl_ndents - 1; i >= 0; i--) {
> +		struct dentry *dentry = fc->ctl_dentry[i];
> +		dentry->d_inode->u.generic_ip = NULL;
> +		d_drop(dentry);
> +		dput(dentry);
> +	}
> +	fuse_control_sb->s_root->d_inode->i_nlink--;

Ditto.


