Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVBXSSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVBXSSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVBXSSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:18:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:60597 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262441AbVBXSSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:18:30 -0500
Date: Thu, 24 Feb 2005 10:18:12 -0800
From: Chris Wright <chrisw@osdl.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH] CKRM [4/8] aFull directory support for rcfs
Message-ID: <20050224181812.GM15867@shell0.pdx.osdl.net>
References: <E1D4FNz-0006wB-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D4FNz-0006wB-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gerrit Huizenga (gh@us.ibm.com) wrote:
> +int rcfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
> +{
> +
> +	int retval = 0;
> +	struct ckrm_classtype *clstype;
> +
> +#if 0
> +	struct dentry *pd = list_entry(dir->i_dentry.next, struct dentry,
> +				       d_alias);
> +	if ((!strcmp(pd->d_name.name, "/") &&
> +	     !strcmp(dentry->d_name.name, "ce"))) {
> +		/* Call CE's mkdir if it has registered, else fail. */
> +		if (rcfs_eng_callbacks.mkdir) {
> +			return (*rcfs_eng_callbacks.mkdir) (dir, dentry, mode);
> +		} else {
> +			return -EINVAL;
> +		}
> +	}
> +#endif

This #if 0 should simply go, esp since it's broken w.r.t. namespaces
(i.e. mount --bind).

> +int rcfs_rmdir(struct inode *dir, struct dentry *dentry)
> +{
> +	struct rcfs_inode_info *ri = rcfs_get_inode_info(dentry->d_inode);
> +
> +#if 0
> +	struct dentry *pd = list_entry(dir->i_dentry.next,
> +				       struct dentry, d_alias);
> +	if ((!strcmp(pd->d_name.name, "/") &&
> +	     !strcmp(dentry->d_name.name, "ce"))) {
> +		/* Call CE's mkdir if it has registered, else fail. */
> +		if (rcfs_eng_callbacks.rmdir) {
> +			return (*rcfs_eng_callbacks.rmdir) (dir, dentry);
> +		} else {
> +			return simple_rmdir(dir, dentry);
> +		}
> +	} else if ((!strcmp(pd->d_name.name, "/") &&
> +		    !strcmp(dentry->d_name.name, "network"))) {
> +		return -EPERM;
> +	}
> +#endif

ditto

> +	if (!rcfs_empty(dentry)) {
> +		printk(KERN_ERR "rcfs_rmdir: directory not empty\n");
> +		return -ENOTEMPTY;
> +	}
> +	/* Core class removal  */
> +
> +	if (ri->core == NULL) {
> +		printk(KERN_ERR "rcfs_rmdir: core==NULL\n");
> +		/* likely a race condition */

If this is a concern, and isn't already sufficiently serialized by
vfs grabbing i_sem, then it should be fixed and handled internally,
not with printk.

> +int _rcfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
> +EXPORT_SYMBOL_GPL(_rcfs_mknod);
> +
> +int rcfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
> +
> +EXPORT_SYMBOL_GPL(rcfs_mknod);

OK, that's just not right ;-)

> +struct dentry *rcfs_create_internal(struct dentry *parent,
> +				    struct rcfs_magf *magf, int magic)
> +{
> +	struct qstr qstr;
> +	struct dentry *mfdentry;
> +
> +	/* Get new dentry for name */
> +	qstr.name = magf->name;
> +	qstr.len = strlen(magf->name);
> +	qstr.hash = full_name_hash(magf->name, qstr.len);
> +	mfdentry = lookup_hash(&qstr, parent);
> +
> +	if (!IS_ERR(mfdentry)) {
> +		int err;
> +
> +		down(&parent->d_inode->i_sem);
> +		if (magic && (magf->mode & S_IFDIR))
> +			err = parent->d_inode->i_op->mkdir(parent->d_inode,
> +							   mfdentry,
> +							   magf->mode);
> +		else {
> +			err = _rcfs_mknod(parent->d_inode, mfdentry,
> +					  magf->mode, 0);
> +			/*
> +			 * _rcfs_mknod doesn't increment parent's link count, 
> +			 * i_op->mkdir does.
> +			 */
> +			parent->d_inode->i_nlink++;
> +		}
> +		up(&parent->d_inode->i_sem);
> +		if (err) {
> +			dput(mfdentry);
> +			return mfdentry;

Error is lost, mfdentry dput yet returned...that looks broken.

> +static ssize_t
> +magic_write(struct file *file, const char __user *buf,
> +			   size_t count, loff_t *ppos)
> +{
> +	struct rcfs_inode_info *ri = 
> +		rcfs_get_inode_info(file->f_dentry->d_parent->d_inode);
> +	char *optbuf, *otherstr=NULL, *resname=NULL;
> +	int done, rc = 0;
> +	struct ckrm_core_class *core ;
> +	int (*func) (struct ckrm_core_class *, const char *,
> +			const char *) = NULL;
> +
> +	core = ri->core;
> +	if (!ckrm_is_core_valid(core))
> +		return -EINVAL;
> +
> +	if (count > MAX_INPUT_SIZE)
> +		return -EINVAL;
> +
> +	if (!access_ok(VERIFY_READ, buf, count))
> +		return -EFAULT;
> +
> +	down(&(ri->vfs_inode.i_sem));
> +
> +	optbuf = kmalloc(MAX_INPUT_SIZE+1, GFP_KERNEL);
> +	if (!optbuf) {
> +		up(&(ri->vfs_inode.i_sem));
> +		return -ENOMEM;
> +	}
> +	__copy_from_user(optbuf, buf, count);

Just use copy_from_user (w/out access_ok), and kmalloc outside of any
semaphore.  Why not use count to size the buffer (since it's size has
been validated?

> +	if (optbuf[count-1] == '\n')
> +		optbuf[count-1]='\0';
> +
> +	done = magic_parse(ri->mfdentry->d_name.name,
> +			optbuf, &resname, &otherstr);
> +
> +	if (!done) {
> +		printk(KERN_ERR "Error parsing data written to %s\n",
> +				ri->mfdentry->d_name.name);
> +		goto out;
> +	}
> +
> +	if (!strcmp(ri->mfdentry->d_name.name, RCFS_CONFIG_NAME)) {
> +		func = core->classtype->set_config;
> +	} else if (!strcmp(ri->mfdentry->d_name.name, RCFS_STATS_NAME)) {
> +		func = core->classtype->reset_stats;
> +	}
> +
> +	if (func) {
> +		rc = func(core, resname, otherstr);
> +		if (rc) {
> +			printk(KERN_ERR "magic_write: %s: error\n",
> +				ri->mfdentry->d_name.name);
> +		}
> +	}
> +
> +out:
> +	up(&(ri->vfs_inode.i_sem));
> +	kfree(optbuf);
> +	kfree(otherstr);
> +	kfree(resname);
> +	return rc ? rc : count;
> +}
> +
> +/*
> + * Shared function used by Target / Reclassify
> + */
> +
> +static ssize_t
> +target_reclassify_write(struct file *file, const char __user * buf,
> +			size_t count, loff_t * ppos, int manual)
> +{
> +	struct rcfs_inode_info *ri = rcfs_get_inode_info(file->f_dentry->d_inode);
> +	char *optbuf;
> +	int rc = -EINVAL;
> +	struct ckrm_classtype *clstype;
> +
> +	if (count > MAX_INPUT_SIZE)
> +		return -EINVAL;
> +	if (!access_ok(VERIFY_READ, buf, count))
> +		return -EFAULT;
> +	down(&(ri->vfs_inode.i_sem));
> +	optbuf = kmalloc(MAX_INPUT_SIZE, GFP_KERNEL);
> +	__copy_from_user(optbuf, buf, count);

Same here, and check for kmalloc failing.

> +	if (optbuf[count - 1] == '\n')
> +		optbuf[count - 1] = '\0';
> +	clstype = ri->core->classtype;
> +	if (clstype->forced_reclassify)
> +		rc = (*clstype->forced_reclassify) (manual ? ri->core: NULL, optbuf);
> +	up(&(ri->vfs_inode.i_sem));
> +	kfree(optbuf);
> +	return (!rc ? count : rc);
> +
> +}
[snip]
> +static ssize_t
> +shares_write(struct file *file, const char __user * buf,
> +	     size_t count, loff_t * ppos)
> +{
> +	struct inode *inode = file->f_dentry->d_inode;
> +	struct rcfs_inode_info *ri;
> +	char *optbuf;
> +	int rc = 0;
> +	struct ckrm_core_class *core;
> +	int done;
> +	char *resname = NULL;
> +
> +	struct ckrm_shares newshares = {
> +		CKRM_SHARE_UNCHANGED,
> +		CKRM_SHARE_UNCHANGED,
> +		CKRM_SHARE_UNCHANGED,
> +		CKRM_SHARE_UNCHANGED,
> +		CKRM_SHARE_UNCHANGED,
> +		CKRM_SHARE_UNCHANGED
> +	};
> +	if (count > SHARES_MAX_INPUT_SIZE)
> +		return -EINVAL;
> +	if (!access_ok(VERIFY_READ, buf, count))
> +		return -EFAULT;
> +	ri = rcfs_get_inode_info(file->f_dentry->d_parent->d_inode);
> +	if (!ri || !ckrm_is_core_valid((struct ckrm_core_class *) (ri->core))) {
> +		printk(KERN_ERR "shares_write: Error accessing core class\n");
> +		return -EFAULT;
> +	}
> +	down(&inode->i_sem);
> +	core = ri->core;
> +	optbuf = kmalloc(SHARES_MAX_INPUT_SIZE, GFP_KERNEL);
> +	if (!optbuf) {
> +		up(&inode->i_sem);
> +		return -ENOMEM;
> +	}
> +	__copy_from_user(optbuf, buf, count);

Same here.

> +	if (optbuf[count - 1] == '\n')
> +		optbuf[count - 1] = '\0';
> +	done = shares_parse(optbuf, &resname, &newshares);
> +	if (!done) {
> +		printk(KERN_ERR "Error parsing shares\n");
> +		rc = -EINVAL;
> +		goto write_out;
> +	}
> +	if (core->classtype->set_shares) {
> +		rc = (*core->classtype->set_shares) (core, resname, &newshares);
> +		if (rc) {
> +			printk(KERN_ERR
> +			       "shares_write: resctlr share set error\n");
> +			goto write_out;
> +		}
> +	}
> +	printk(KERN_ERR "Set %s shares to %d %d %d %d\n",
> +	       resname,
> +	       newshares.my_guarantee,
> +	       newshares.my_limit,
> +	       newshares.total_guarantee, newshares.max_limit);

This is pretty noisy, looks like it's really debugging, right?

> +	rc = count;
> +
> +write_out:
> +	up(&inode->i_sem);
> +	kfree(optbuf);
> +	kfree(resname);
> +	return rc;
> +}

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
