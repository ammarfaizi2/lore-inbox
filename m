Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423228AbWJSUsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423228AbWJSUsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423230AbWJSUsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:48:32 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:12211 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423228AbWJSUs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:48:29 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: akpm@osdl.org, Serge Hallyn <sergeh@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, Dave Safford <safford@us.ibm.com>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1159296281.25493.31.camel@moss-spartans.epoch.ncsc.mil>
References: <1158083865.18137.13.camel@localhost.localdomain>
	 <1159296281.25493.31.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 13:48:12 -0700
Message-Id: <1161290893.5182.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay.  We have been working on the issues below.  There
will be patches coming to address some of these concerns.  We have
included some comments and questions inline below.

On Tue, 2006-09-26 at 14:44 -0400, Stephen Smalley wrote: 
> On Tue, 2006-09-12 at 10:57 -0700, Kylene Jo Hall wrote: 
> > SLIM is an LSM module which provides an enhanced low water-mark
> > integrity and high water-mark secrecy mandatory access control
> > model.
> <snip> 
> > SLIM now performs a generic revocation operation, including revoking
> > mmap and shared memory access. Note that during demotion or promotion
> > of a process, SLIM needs only revoke write access to files with higher
> > integrity, or lower secrecy. Read and execute permissions are blocked
> > as needed, not revoked.  SLIM hopefully uses d_instantiate correctly now.
> 
> Neither the above text nor your Documentation nor your code comments
> seems to have been fully updated to reflect the changes to SLIM in this
> submission, e.g. the removal of the secrecy MAC model and the change in
> how you deal with "revocation".  Thus they are misleading and confusing
> to potential users and to subsequent maintenance of the code.
I'll provide a patch that fixes the comments and in-tree documentation.

> 
> > --- linux-2.6.18/security/slim/slm_main.c	1969-12-31 16:00:00.000000000 -0800
> > +++ linux-2.6.17-working/security/slim/slm_main.c	2006-09-06 11:49:09.000000000 -0700
> > +/* 
> > + * Called with current->files->file_lock. There is not a great lock to grab
> > + * for demotion of this type.  The only place f_mode is changed after install
> > + * is in mark_files_ro in the filesystem code.  That function is also changing
> > + * taking away write rights so even if we race the outcome is the same.
> > + */
> > +static inline int mark_has_file_wperm(struct file *file,
> > +					struct slm_file_xattr *cur_level)
> > +{
> > +	struct inode *inode;
> > +	struct slm_isec_data *isec;
> > +	int rc = 0;
> > +
> > +	inode = file->f_dentry->d_inode;
> > +	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
> > +		return 0;
> > +
> > +	isec = inode->i_security;
> > +	spin_lock(&isec->lock);
> > +	if (is_lower_integrity(cur_level, &isec->level))
> > +		rc = 1;
> > +	spin_unlock(&isec->lock);
> > +	return rc;
> > +}
> 
> So rather than "revoke", you just test for the presence of an open file
> with write access, and if present, you ultimately deny the read attempt
> that would have caused demotion?  Still calling the function "mark_..."
> is confusing here.  But it doesn't provide any real guarantees, as there
> may be open files sitting on an AF_LOCAL socket that the process will
> receive after the "demotion" (and you don't mediate file_receive, or
> file_mmap, so nothing prevents receipt and then mapping with
> PROT_WRITE), or another thread could be sharing the file table (and your
> mm_users test is neither sufficient nor correct as a way of checking for
> sharing in general), etc.
> 
> I think you would do better to just drop out the so-called "revocation"
> code altogether and acknowledge this limitation in your Documentation.
> Meanwhile, you could do a better job of using the permission checking
> hooks that do exist to apply checks on subsequent operations after
> demotion, like implementing file_receive, file_mmap, etc. 
> 
You are right in your AF_LOCAL socket concern.  We have been working
on that and have implemented the file_receive hook, however, once we
have this hook we cannot imagine the case where file_mmap is also
needed.  If you still feel it is necessary can you please explain
further.

--- linux-2.6.19-rc2/security/slim/slm_main.c	2006-10-19 12:05:58.000000000 -0700
+++ linux-2.6.19-rc2/security/slim/slm_main.c	2006-10-19 12:11:37.000000000 -0700
@@ -1130,6 +1103,34 @@ static int slm_socket_post_create(struct
 	return 0;
 }
 
+static int slm_file_receive(struct file *file)
+{
+	struct slm_isec_data *isec = file->f_dentry->d_inode->i_security;
+	struct slm_tsec_data *tsec = current->security;
+	struct slm_file_xattr level;
+	int rc = 0;
+
+	spin_lock(&isec->lock);
+	memcpy(&level, &isec->level, sizeof(struct slm_file_xattr));
+	spin_unlock(&isec->lock);
+
+	spin_lock(&tsec->lock);
+	if (file->f_mode & FMODE_READ) { /* IRAC(process) <= IAC(object) */
+		if (!is_iac_less_than_or_exempt(&level, tsec->iac_r))
+			rc = -EPERM;
+	}
+	if (file->f_mode & FMODE_WRITE) { /* IWXAC(process) >= IAC(object) */
+		if (!is_iac_greater_than_or_exempt(&level, tsec->iac_wx))
+			rc = -EPERM;
+	}
+	if (file->f_mode & FMODE_EXEC) { /* IWXAC(process) <= IAC(object) */
+		if (!is_iac_less_than_or_exempt(&level, tsec->iac_wx))
+			rc = -EPERM;
+	}
+	spin_unlock(&tsec->lock);
+	return rc;
+}
+
 /*
  * When a task gets allocated, it inherits the current IAC and SAC.
  * Set the values and store them in p->security.
@@ -1607,6 +1870,7 @@ static struct security_operations slm_se
 	.inode_init_security = slm_inode_init_security,
 	.socket_create = slm_socket_create,
 	.socket_post_create = slm_socket_post_create,
+	.file_receive = slm_file_receive,
 	.task_alloc_security = slm_task_alloc_security,
 	.task_free_security = slm_task_free_security,
 	.task_post_setuid = slm_task_post_setuid,


As for removing revocation altogether (and keeping demotion) we are
concerned that checking every read and write for example in the
file_permission hook would be a signifcant performance hit over the
revocation way.  Additionally, Alan Cox brought up that demoting with an
writeable open file really isnt' safe (http://marc.theaimsgroup.com/?
l=linux-kernel&m=115643804205202&w=2) and revocation would still be
necessary for mmaps as I don't know of a security hook that can be used
to double check reads and writes to mmaps.

Is it really not possible to enumerate all the possible cases and
mediate them?

> 
> > +/*
> > + * All directories with xattr support should be labeled, but just in case
> > + * recursively traverse path (dentry->parent) until level info is found.
> 
> The comment is no longer accurate, right?
Correct. 
> 
> > + */
> > +static void slm_get_level(struct dentry *dentry, struct slm_file_xattr *level)
> > +{
> > +	struct inode *inode = dentry->d_inode;
> > +	struct slm_isec_data *isec = inode->i_security;
> > +
> > +	if (is_isec_defined(isec)) {
> > +		spin_lock(&isec->lock);
> > +		memcpy(level, &isec->level, sizeof(struct slm_file_xattr));
> > +		spin_unlock(&isec->lock);
> > +		return;
> > +	}
> > +
> > +	if (is_exempt_fastpath(inode)) {
> > +		memset(level, 0, sizeof(struct slm_file_xattr));
> > +		set_level_exempt(level);
> > +	} else if (S_ISSOCK(inode->i_mode))
> > +		update_sock_level(dentry, level);
> > +	else
> > +		update_level(dentry, level);
> > +
> > +	spin_lock(&isec->lock);
> > +	memcpy(&isec->level, level, sizeof(struct slm_file_xattr));
> > +	spin_unlock(&isec->lock);
> 
> The locking doesn't make much sense to me, and that applies throughout.
> Can you explain it?  For example, why don't you have to recheck
> is_isec_defined() after taking the lock?  Why do you call this function
> repeatedly in various hooks rather than just setting up the isec once
> from d_instantiate and inode_init_security? 
> 
You were right about all the issues with this function.  It is no longer
needed thus negating the issue with the locking.  Removing this and the
reason it had been around (explanation below) also negates the need for
the other is_isec_defined checks.  I looked and the rest of the locking
looks sane to me.  Please point out any other particular instances you
aren't sure about.

> > +static int enforce_integrity_read(struct slm_file_xattr *level)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	int rc = 0;
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	if (!is_iac_less_than_or_exempt(level, cur_tsec->iac_r)) {
> > +		rc = has_file_wperm(level);
> > +		if (atomic_read(&current->mm->mm_users) != 1)
> 
> This only checks for users of the mm (not necessarily other forms of
> sharing), and it can yield "false" positives due to transient references
> (also noted by Hugh).  If you look at the SELinux code, you'll see a
> more complex test applied in selinux_setprocattr after this test, and
> that is only checking for mm sharing.  For sharing of the file table,
> there is the unsafe_exec checking that happens, with the corresponding
> LSM_UNSAFE_SHARE check applied by SELinux (since we are only flushing
> the table on context-changing exec).

Yes the mm_users check as is will cause us to fail things that might not
necessarily need to fail but at least we are failing closed.

It seems that all the checks in sys_unshare should be done and those
that can be unshared should be and if any sharing exists that can't be
undone (such as unshare_vm) then the demotion would need to be
prevented.  We would implement this similar to how we split sys_mprotect
and do_mprotect creating an exported do_unshare.

> > +
> > +/*
> > + * file changes invalidate isec 
> > + */
> > +static int slm_file_permission(struct file *file, int mask)
> > +{
> > +	struct slm_isec_data *isec = file->f_dentry->d_inode->i_security;
> > +
> > +	if (((mask & MAY_WRITE) || (mask & MAY_APPEND)) && isec) {
> > +		spin_lock(&isec->lock);
> > +		isec->level.iac_level = SLM_IAC_NOTDEFINED;
> > +		spin_unlock(&isec->lock);
> > +	}
> > +	return 0;
> > +}
> 
> I don't understand the above - any write to a file by any process resets it to an undefined state?
> And then you just reset from xattr upon the next hook that happens to
> call get_level or the next d_instantiate?  What is the point of that?

We had thought it was necessary to recheck the integrity data/metadata
after being invalidated by a write, but on reconsideration 
SLIM permitted the write in the first place, so it is unnecessary.

> 
> > +
> > +static int is_untrusted_blk_access(struct inode *inode)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	int rc = 0;
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	if (cur_tsec && (cur_tsec->iac_wx == SLM_IAC_UNTRUSTED)
> > +	    && S_ISBLK(inode->i_mode))
> > +		rc = 1;
> > +	spin_unlock(&cur_tsec->lock);
> > +	return rc;
> > +}
> 
> This kind of special case logic is troubling, and shouldn't be necessary.

Unfortunately, this does seem necessary.  Block devices don't have
xattrs and thus are treated as EXEMPT.  However, they shouldn't be
written to except by SYSTEM (logic updated to enforce this rather than !
UNTRUSTED).  We thought about special casing them to be SYSTEM
instead of EXEMPT or that might be able to do something like SELinux and
provide a daemon to label these files at boot, however, then special
casing would be necessary to avoid measuring these devices.  You don't
really want /dev/hda1 rehashed everytime you write to the filesystem.

> > +/*
> > + * Premise:
> > + * Can't write or execute higher integrity, can't read lower integrity
> > + * Can't read or execute higher secrecy, can't write lower secrecy
> 
> Misleading comment - no secrecy model within.
> 
> > + */
> > +static int slm_inode_permission(struct inode *inode, int mask,
> > +				struct nameidata *nd)
> > +{
> > +	struct dentry *dentry = NULL;
> > +	struct slm_file_xattr level;
> > +
> > +	if (S_ISDIR(inode->i_mode) && (mask & MAY_WRITE))
> > +		return 0;
> > +
> > +	dentry = (!nd || !nd->dentry) ? d_find_alias(inode) : nd->dentry;
> > +	if (!dentry)
> > +		return 0;
> 
> Relying on a dentry here is problematic.
> 
> > +
> > +	if (is_untrusted_blk_access(inode))
> > +		return -EPERM;
> > +
> > +	slm_get_level(dentry, &level);
> 
> If the isec isn't already set up here, you have a bug.
> It shouldn't be necessary to go through this processing on every
> permission check.
> 
> > +
> > +	/* measure all SYSTEM level integrity objects */
> > +	if (level.iac_level == SLM_IAC_SYSTEM)
> > +		integrity_measure(dentry, NULL, mask);
> 
> This seems to be the wrong point to perform a measurement.
> 
The SLIM measure policy is to measure all system files and anything executable.
Things opened writable are not measured.  Executables are caught in the
bprm_check_security hook.  Measurement cannot be moved to d_instantiate for
example because you don't know what flags the file will be opened with.
The measure hook is really only using the dentry to get the inode I will
provide a patch to change the hook to accept an inode instead, though the
filename will sometimes not be available without a dentry.

> > +/* Create the security.slim.level extended attribute */
> > +static int slm_inode_init_security(struct inode *inode, struct inode *dir,
> > +				   char **name, void **value, size_t * len)
> > +{
> > +	struct slm_isec_data *isec = inode->i_security, *parent_isec =
> > +	    dir->i_security;
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	struct slm_file_xattr level;
> > +	struct xattr_data *data;
> > +	int rc;
> > +
> > +	if (!name || !value || !len)
> > +		return 0;
> > +
> > +	memset(&level, 0, sizeof(struct slm_file_xattr));
> > +
> > +	if (is_isec_defined(parent_isec)) {
> > +		spin_lock(&parent_isec->lock);
> > +		memcpy(&level, &parent_isec->level,
> > +		       sizeof(struct slm_file_xattr));
> > +		spin_unlock(&parent_isec->lock);
> > +	}
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	/* low integrity process wrote into a higher level directory */
> > +	if (cur_tsec->iac_wx < level.iac_level)
> > +		set_level_tsec_write(&level, cur_tsec);
> > +	/* if directory is exempt, then use process level */
> > +	if (is_iac_level_exempt(&level)) {
> > +		/* When a guard process creates a directory */
> > +		if (S_ISDIR(inode->i_mode)
> > +		    && (cur_tsec->iac_wx != cur_tsec->iac_r))
> > +			set_level_exempt(&level);
> > +		else
> > +			set_level_tsec_write(&level, cur_tsec);
> > +	}
> > +
> > +	/* if a guard process creates a UNIX socket, then EXEMPT it */
> > +	if (S_ISSOCK(inode->i_mode)
> > +	    && (cur_tsec->iac_wx != cur_tsec->iac_r))
> > +		set_level_exempt(&level);
> > +	spin_unlock(&cur_tsec->lock);
> > +
> > +	spin_lock(&isec->lock);
> > +	memcpy(&isec->level, &level, sizeof(struct slm_file_xattr));
> > +	spin_unlock(&isec->lock);
> > +
> > +	data = kmalloc(sizeof(struct xattr_data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	/* set levels, based on parent */
> > +	rc = slm_set_xattr(&level, &data->name, &data->value, &data->len);
> > +	if (rc < 0) {
> > +		kfree(data);
> > +		return rc;
> > +	}
> > +
> > +	*name = data->name;
> > +	*value = data->value;
> > +	*len = data->len;
> 
> What frees the xattr_data structure?  Why does it even exist?
Not necessary so removed. 
> 
> > +static int slm_inode_rename(struct inode *old_dir,
> > +			    struct dentry *old_dentry,
> > +			    struct inode *new_dir, struct dentry *new_dentry)
> > +{
> > +	struct slm_file_xattr old_level, parent_level;
> > +	struct dentry *parent_dentry;
> > +
> > +	if (old_dir == new_dir)
> > +		return 0;
> > +
> > +	slm_get_level(old_dentry, &old_level);
> > +
> > +	parent_dentry = dget_parent(new_dentry);
> > +	slm_get_level(parent_dentry, &parent_level);
> > +	dput(parent_dentry);
> > +
> > +	if (is_lower_integrity(&old_level, &parent_level))
> > +		return -EPERM;
> > +	return 0;
> > +}
> 
> Why can't you get the parent level from old_dir if that is what you need?
> What is the rationale for this logic - renaming a file doesn't change its integrity.

Fixed to compare the original file level to the level of the new
directory.  The logic is that moving a low integrity file to a high
integrity directory is a bad idea for numerous reasons one being you end
up demoting your shells doing tab completions on such directories. 

> 
> > +static void slm_inode_post_setxattr(struct dentry *dentry, char *name,
> > +				    void *value, size_t size, int flags)
> > +{
> > +	struct slm_isec_data *slm_isec;
> > +	struct slm_file_xattr level;
> > +	int rc, status = 0;
> > +
> > +	if (strncmp(name, XATTR_NAME, strlen(XATTR_NAME)) != 0)
> > +		return;
> 
> Not just here, but in several places you are using strncmp like this.
> Are you sure that is what you mean to test (versus an exact match)?

Fixed.

> 
> > +
> > +	rc = slm_get_xattr(dentry, &level, &status);
> 
> Here you do a get_xattr, but this is post_setxattr - and you just ignore the supplied (value, size) pair?
> 
Fixed this to use the value size pair with the slm_parse_xattr function
rather than recalculating.

> I'm out of time for now, but there is plenty more to comment on.
> 

