Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWIZSnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWIZSnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 14:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWIZSnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 14:43:52 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:39653 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751590AbWIZSnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 14:43:51 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: akpm@osdl.org, Serge Hallyn <sergeh@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, Dave Safford <safford@us.ibm.com>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1158083865.18137.13.camel@localhost.localdomain>
References: <1158083865.18137.13.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 26 Sep 2006 14:44:41 -0400
Message-Id: <1159296281.25493.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 10:57 -0700, Kylene Jo Hall wrote: 
> SLIM is an LSM module which provides an enhanced low water-mark
> integrity and high water-mark secrecy mandatory access control
> model.
<snip> 
> SLIM now performs a generic revocation operation, including revoking
> mmap and shared memory access. Note that during demotion or promotion
> of a process, SLIM needs only revoke write access to files with higher
> integrity, or lower secrecy. Read and execute permissions are blocked
> as needed, not revoked.  SLIM hopefully uses d_instantiate correctly now.

Neither the above text nor your Documentation nor your code comments
seems to have been fully updated to reflect the changes to SLIM in this
submission, e.g. the removal of the secrecy MAC model and the change in
how you deal with "revocation".  Thus they are misleading and confusing
to potential users and to subsequent maintenance of the code.

> --- linux-2.6.18/security/slim/slm_main.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17-working/security/slim/slm_main.c	2006-09-06 11:49:09.000000000 -0700
> +/* 
> + * Called with current->files->file_lock. There is not a great lock to grab
> + * for demotion of this type.  The only place f_mode is changed after install
> + * is in mark_files_ro in the filesystem code.  That function is also changing
> + * taking away write rights so even if we race the outcome is the same.
> + */
> +static inline int mark_has_file_wperm(struct file *file,
> +					struct slm_file_xattr *cur_level)
> +{
> +	struct inode *inode;
> +	struct slm_isec_data *isec;
> +	int rc = 0;
> +
> +	inode = file->f_dentry->d_inode;
> +	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
> +		return 0;
> +
> +	isec = inode->i_security;
> +	spin_lock(&isec->lock);
> +	if (is_lower_integrity(cur_level, &isec->level))
> +		rc = 1;
> +	spin_unlock(&isec->lock);
> +	return rc;
> +}

So rather than "revoke", you just test for the presence of an open file
with write access, and if present, you ultimately deny the read attempt
that would have caused demotion?  Still calling the function "mark_..."
is confusing here.  But it doesn't provide any real guarantees, as there
may be open files sitting on an AF_LOCAL socket that the process will
receive after the "demotion" (and you don't mediate file_receive, or
file_mmap, so nothing prevents receipt and then mapping with
PROT_WRITE), or another thread could be sharing the file table (and your
mm_users test is neither sufficient nor correct as a way of checking for
sharing in general), etc.

I think you would do better to just drop out the so-called "revocation"
code altogether and acknowledge this limitation in your Documentation.
Meanwhile, you could do a better job of using the permission checking
hooks that do exist to apply checks on subsequent operations after
demotion, like implementing file_receive, file_mmap, etc. 

> +/*
> + * All directories with xattr support should be labeled, but just in case
> + * recursively traverse path (dentry->parent) until level info is found.

The comment is no longer accurate, right?

> + */
> +static void slm_get_level(struct dentry *dentry, struct slm_file_xattr *level)
> +{
> +	struct inode *inode = dentry->d_inode;
> +	struct slm_isec_data *isec = inode->i_security;
> +
> +	if (is_isec_defined(isec)) {
> +		spin_lock(&isec->lock);
> +		memcpy(level, &isec->level, sizeof(struct slm_file_xattr));
> +		spin_unlock(&isec->lock);
> +		return;
> +	}
> +
> +	if (is_exempt_fastpath(inode)) {
> +		memset(level, 0, sizeof(struct slm_file_xattr));
> +		set_level_exempt(level);
> +	} else if (S_ISSOCK(inode->i_mode))
> +		update_sock_level(dentry, level);
> +	else
> +		update_level(dentry, level);
> +
> +	spin_lock(&isec->lock);
> +	memcpy(&isec->level, level, sizeof(struct slm_file_xattr));
> +	spin_unlock(&isec->lock);

The locking doesn't make much sense to me, and that applies throughout.
Can you explain it?  For example, why don't you have to recheck
is_isec_defined() after taking the lock?  Why do you call this function
repeatedly in various hooks rather than just setting up the isec once
from d_instantiate and inode_init_security? 

> +static int enforce_integrity_read(struct slm_file_xattr *level)
> +{
> +	struct slm_tsec_data *cur_tsec = current->security;
> +	int rc = 0;
> +
> +	spin_lock(&cur_tsec->lock);
> +	if (!is_iac_less_than_or_exempt(level, cur_tsec->iac_r)) {
> +		rc = has_file_wperm(level);
> +		if (atomic_read(&current->mm->mm_users) != 1)

This only checks for users of the mm (not necessarily other forms of
sharing), and it can yield "false" positives due to transient references
(also noted by Hugh).  If you look at the SELinux code, you'll see a
more complex test applied in selinux_setprocattr after this test, and
that is only checking for mm sharing.  For sharing of the file table,
there is the unsafe_exec checking that happens, with the corresponding
LSM_UNSAFE_SHARE check applied by SELinux (since we are only flushing
the table on context-changing exec).

> +
> +/*
> + * file changes invalidate isec 
> + */
> +static int slm_file_permission(struct file *file, int mask)
> +{
> +	struct slm_isec_data *isec = file->f_dentry->d_inode->i_security;
> +
> +	if (((mask & MAY_WRITE) || (mask & MAY_APPEND)) && isec) {
> +		spin_lock(&isec->lock);
> +		isec->level.iac_level = SLM_IAC_NOTDEFINED;
> +		spin_unlock(&isec->lock);
> +	}
> +	return 0;
> +}

I don't understand the above - any write to a file by any process resets it to an undefined state?
And then you just reset from xattr upon the next hook that happens to
call get_level or the next d_instantiate?  What is the point of that?

> +
> +static int is_untrusted_blk_access(struct inode *inode)
> +{
> +	struct slm_tsec_data *cur_tsec = current->security;
> +	int rc = 0;
> +
> +	spin_lock(&cur_tsec->lock);
> +	if (cur_tsec && (cur_tsec->iac_wx == SLM_IAC_UNTRUSTED)
> +	    && S_ISBLK(inode->i_mode))
> +		rc = 1;
> +	spin_unlock(&cur_tsec->lock);
> +	return rc;
> +}

This kind of special case logic is troubling, and shouldn't be necessary.

> +/*
> + * Premise:
> + * Can't write or execute higher integrity, can't read lower integrity
> + * Can't read or execute higher secrecy, can't write lower secrecy

Misleading comment - no secrecy model within.

> + */
> +static int slm_inode_permission(struct inode *inode, int mask,
> +				struct nameidata *nd)
> +{
> +	struct dentry *dentry = NULL;
> +	struct slm_file_xattr level;
> +
> +	if (S_ISDIR(inode->i_mode) && (mask & MAY_WRITE))
> +		return 0;
> +
> +	dentry = (!nd || !nd->dentry) ? d_find_alias(inode) : nd->dentry;
> +	if (!dentry)
> +		return 0;

Relying on a dentry here is problematic.

> +
> +	if (is_untrusted_blk_access(inode))
> +		return -EPERM;
> +
> +	slm_get_level(dentry, &level);

If the isec isn't already set up here, you have a bug.
It shouldn't be necessary to go through this processing on every
permission check.

> +
> +	/* measure all SYSTEM level integrity objects */
> +	if (level.iac_level == SLM_IAC_SYSTEM)
> +		integrity_measure(dentry, NULL, mask);

This seems to be the wrong point to perform a measurement.

> +/* Create the security.slim.level extended attribute */
> +static int slm_inode_init_security(struct inode *inode, struct inode *dir,
> +				   char **name, void **value, size_t * len)
> +{
> +	struct slm_isec_data *isec = inode->i_security, *parent_isec =
> +	    dir->i_security;
> +	struct slm_tsec_data *cur_tsec = current->security;
> +	struct slm_file_xattr level;
> +	struct xattr_data *data;
> +	int rc;
> +
> +	if (!name || !value || !len)
> +		return 0;
> +
> +	memset(&level, 0, sizeof(struct slm_file_xattr));
> +
> +	if (is_isec_defined(parent_isec)) {
> +		spin_lock(&parent_isec->lock);
> +		memcpy(&level, &parent_isec->level,
> +		       sizeof(struct slm_file_xattr));
> +		spin_unlock(&parent_isec->lock);
> +	}
> +
> +	spin_lock(&cur_tsec->lock);
> +	/* low integrity process wrote into a higher level directory */
> +	if (cur_tsec->iac_wx < level.iac_level)
> +		set_level_tsec_write(&level, cur_tsec);
> +	/* if directory is exempt, then use process level */
> +	if (is_iac_level_exempt(&level)) {
> +		/* When a guard process creates a directory */
> +		if (S_ISDIR(inode->i_mode)
> +		    && (cur_tsec->iac_wx != cur_tsec->iac_r))
> +			set_level_exempt(&level);
> +		else
> +			set_level_tsec_write(&level, cur_tsec);
> +	}
> +
> +	/* if a guard process creates a UNIX socket, then EXEMPT it */
> +	if (S_ISSOCK(inode->i_mode)
> +	    && (cur_tsec->iac_wx != cur_tsec->iac_r))
> +		set_level_exempt(&level);
> +	spin_unlock(&cur_tsec->lock);
> +
> +	spin_lock(&isec->lock);
> +	memcpy(&isec->level, &level, sizeof(struct slm_file_xattr));
> +	spin_unlock(&isec->lock);
> +
> +	data = kmalloc(sizeof(struct xattr_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* set levels, based on parent */
> +	rc = slm_set_xattr(&level, &data->name, &data->value, &data->len);
> +	if (rc < 0) {
> +		kfree(data);
> +		return rc;
> +	}
> +
> +	*name = data->name;
> +	*value = data->value;
> +	*len = data->len;

What frees the xattr_data structure?  Why does it even exist?

> +static int slm_inode_rename(struct inode *old_dir,
> +			    struct dentry *old_dentry,
> +			    struct inode *new_dir, struct dentry *new_dentry)
> +{
> +	struct slm_file_xattr old_level, parent_level;
> +	struct dentry *parent_dentry;
> +
> +	if (old_dir == new_dir)
> +		return 0;
> +
> +	slm_get_level(old_dentry, &old_level);
> +
> +	parent_dentry = dget_parent(new_dentry);
> +	slm_get_level(parent_dentry, &parent_level);
> +	dput(parent_dentry);
> +
> +	if (is_lower_integrity(&old_level, &parent_level))
> +		return -EPERM;
> +	return 0;
> +}

Why can't you get the parent level from old_dir if that is what you need?
What is the rationale for this logic - renaming a file doesn't change its integrity.

> +static void slm_inode_post_setxattr(struct dentry *dentry, char *name,
> +				    void *value, size_t size, int flags)
> +{
> +	struct slm_isec_data *slm_isec;
> +	struct slm_file_xattr level;
> +	int rc, status = 0;
> +
> +	if (strncmp(name, XATTR_NAME, strlen(XATTR_NAME)) != 0)
> +		return;

Not just here, but in several places you are using strncmp like this.
Are you sure that is what you mean to test (versus an exact match)?

> +
> +	rc = slm_get_xattr(dentry, &level, &status);

Here you do a get_xattr, but this is post_setxattr - and you just ignore the supplied (value, size) pair?

I'm out of time for now, but there is plenty more to comment on.

-- 
Stephen Smalley
National Security Agency

