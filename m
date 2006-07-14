Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422697AbWGNS1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbWGNS1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWGNS1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:27:50 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:63663 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422697AbWGNS1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:27:49 -0400
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1152897878.23584.6.camel@localhost.localdomain>
References: <1152897878.23584.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 11:27:44 -0700
Message-Id: <1152901664.314.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 10:24 -0700, Kylene Jo Hall wrote:
> +static int is_guard_integrity(struct slm_file_xattr *level)
> +{
> +	if ((level->guard.iac_r != SLM_IAC_NOTDEFINED)
> +	    && (level->guard.iac_wx != SLM_IAC_NOTDEFINED))
> +		return 1;
> +	return 0;
> +}
> +
> +static int is_guard_secrecy(struct slm_file_xattr *level)
> +{
> +	if ((level->guard.sac_rx != SLM_SAC_NOTDEFINED)
> +	    && (level->guard.sac_w != SLM_SAC_NOTDEFINED))
> +		return 1;
> +	return 0;
> +}

This is a nice helper function.  I think there are a couple of other
places where nice helpers like this could really clean things up.

> +static void revoke_file_wperm(struct slm_file_xattr *cur_level)
> +{
> +	int i, j = 0;
> +	struct files_struct *files = current->files;
> +	unsigned long fd = 0;
> +	struct fdtable *fdt;
> +	struct file *file;
> +
> +	if (!files || !cur_level)
> +		return;
> +
> +	spin_lock(&files->file_lock);
> +	fdt = files_fdtable(files);
> +
> +	for (;;) {
> +		i =j * __NFDBITS;
> +		if ( i>= fdt->max_fdset || i >= fdt->max_fds)
> +			break;
> +		fd = fdt->open_fds->fds_bits[j++];
> +		while(fd) {
> +			if (fd & 1) {
> +				file = fdt->fd[i++];
> +				if (file && file->f_dentry)
> +					do_revoke_file_wperm(file, cur_level);
> +			}
> +			fd >>= 1;
> +		}
> +	}
> +	spin_unlock(&files->file_lock);
> +}

This is an awfully ugly function ;)

Instead of actually walking the fd table and revoking permissions, would
doing a hook in generic_write_permission() help?  It might be easier to
switch back and forth.

> +static inline void do_revoke_mmap_wperm(struct vm_area_struct *mpnt,
> +					struct slm_isec_data *isec,
> +					struct slm_file_xattr *cur_level)
> +{
> +	unsigned long start = mpnt->vm_start;
> +	unsigned long end = mpnt->vm_end;
> +	size_t len = end - start;
> +	struct dentry *dentry = mpnt->vm_file->f_dentry;
> +
> +	if ((mpnt->vm_flags & VM_WRITE)
> +	    && (mpnt->vm_flags & VM_SHARED)
> +	    && (cur_level->iac_level < isec->level.iac_level)) {
> +		if (strncmp(dentry->d_name.name, "SYSV", 4) == 0) {
> +			down_write(&current->mm->mmap_sem);
> +			do_munmap(current->mm, start, len);
> +			up_write(&current->mm->mmap_sem);
> +		} else
> +			do_mprotect(start, len, PROT_READ);
> +	}
> +}

What is special about "SYSV"?  

Do you care about VM_MAYWRITE as well here?

> +static int using_shmem(void)
> +{
> +	struct task_struct *group_tsk;
> +
> +	if (!current->group_leader)
> +		return 0;
> +
> +	group_tsk = current->group_leader;
> +	if ((current->pid != group_tsk->pid) && (current->mm == group_tsk->mm))
> +		return 1;
> +	return 0;
> +}

I'm not sure this function name matches what it does.  Are you trying to
determine whether or not a task shares any address space with another?
When I think of "shmem", I think of shmfs.

> +static void do_demote_thread_entry(struct task_struct *thread_tsk)
> +				   
> +{
> +	struct slm_tsec_data *cur_tsec = current->security,
> +	    *thread_tsec = thread_tsk->security;
> +
> +	if (thread_tsk->pid == 1)
> +		return;

Why is init special-cased?  (these checks are near and dear to the
people doing containers :)

> +	if (current->pid != thread_tsk->pid)
> +		return;
> +	if (current->mm == thread_tsk->mm)
> +		return;
> +	if (!thread_tsec)
> +		return;
> +
> +	spin_lock(&thread_tsec->lock);
> +	thread_tsec->iac_r = cur_tsec->iac_r;
> +	thread_tsec->iac_wx = cur_tsec->iac_wx;
> +	spin_unlock(&thread_tsec->lock);
> +}
> +
> +#define do_demote_thread_list(head, member) { \
> +	struct task_struct *thread_tsk; \
> +	list_for_each_entry(thread_tsk, head, member) \
> +		do_demote_thread_entry(thread_tsk); \
> +}

Can this be an inline function instead?

> +static void demote_threads(void)
> +{
> +	do_demote_thread_list(&current->sibling, sibling);
> +	do_demote_thread_list(&current->children, children);
> +}
> +
> +/*
> + * Revoke write permissions and demote threads using shared memory
> + */
> +static void revoke_permissions(struct slm_file_xattr *cur_level)
> +{
> +	if ((!is_kernel_thread(current)) && (current->pid != 1)) {
> +		if (using_shmem())
> +			demote_threads();
> +
> +		revoke_mmap_wperm(cur_level);
> +		revoke_file_wperm(cur_level);
> +	}
> +}

Is that using_shmem() check really necessary?  IF you're not a threaded
process and you get asked to demote your threads, I would imagine that
the code would fall out of the loop immediately.  What does this protect
against?

> +static enum slm_iac_level set_iac(char *token)
> +{
> +	int iac;
> +
> +	if (memcmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
> +		return SLM_IAC_EXEMPT;
> +	else {

Might as well add brackets here.  Or, just kill the else{} block and
pull the code back to the lower indenting level.  The else is really
unnecessary because of the return;

> +		for (iac = 0; iac < sizeof(slm_iac_str) / sizeof(char *); iac++) {
> +			if (memcmp(token, slm_iac_str[iac],
> +				   strlen(slm_iac_str[iac])) == 0)
> +				return iac;

Why not use strcmp?

> +static enum slm_sac_level set_sac(char *token)
> +{
> +	int sac;
> +
> +	if (memcmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
> +		return SLM_SAC_EXEMPT;
> +	else {
> +		for (sac = 0; sac < sizeof(slm_sac_str) / sizeof(char *); sac++) {
> +			if (memcmp(token, slm_sac_str[sac],
> +				   strlen(slm_sac_str[sac])) == 0)
> +				return sac;
> +		}
> +	}
> +	return SLM_SAC_ERROR;
> +}

This function looks awfully similar :).  Can you just pass that array in
as an argument, and get rid of one of the functions?

> +static inline int set_bounds(char *token)
> +{
> +	if (memcmp(token, UNLIMITED_STR, strlen(UNLIMITED_STR)) == 0)
> +		return 1;
> +	return 0;
> +}

strcmp?

> +/* 
> + * Get the 7 access class levels from the extended attribute 
> + * Format: TIMESTAMP INTEGRITY SECRECY [INTEGRITY_GUARD INTEGRITY_GUARD] [SECRECY_GUARD SECRECY_GUARD] [GUARD_ TYPE]
> + */
> +static int slm_parse_xattr(char *xattr_value, int xattr_len,
> +			   struct slm_file_xattr *level)
> +{
> +	char *token;
> +	int token_len;
> +	char *buf, *buf_end;
> +	int fieldno = 0;
> +	int rc = -1;
> +
> +	buf = xattr_value + sizeof(time_t);
> +	if (*buf == 0x20)
> +		buf++;		/* skip blank after timestamp */
> +	buf_end = xattr_value + xattr_len;
> +
> +	while ((token = get_token(buf, buf_end, ' ', &token_len)) != NULL) {
> +		buf = token + token_len;
> +		switch (++fieldno) {
> +		case 1:
> +			if ((level->iac_level =
> +			     set_iac(token)) != SLM_IAC_ERROR)
> +				rc = 0;
> +			break;

How about:

			level->iac_level = set_iac(token);
			if (level->iac_level != SLM_IAC_ERROR)
				rc = 0;
			break;

> +		case 2:
> +			level->sac_level = set_sac(token);
> +			break;
> +		case 3:
> +			level->guard.iac_r = set_iac(token);
> +			break;
> +		case 4:
> +			level->guard.iac_wx = set_iac(token);
> +			break;
> +		case 5:
> +			level->guard.unlimited = set_bounds(token);
> +			level->guard.sac_w = set_sac(token);
> +			break;
> +		case 6:
> +			level->guard.sac_rx = set_sac(token);
> +			break;
> +		case 7:
> +			level->guard.unlimited = set_bounds(token);
> +		default:
> +			break;
> +		}
> +	}
> +	return rc;
> +}
> +
> +/*
> + *  Possible return codes:  INTEGRITY_PASS, INTEGRITY_FAIL, INTEGRITY_NOLABEL,
> + * 			 or -EINVAL
> + */
> +static int slm_get_xattr(struct dentry *dentry,
> +			 struct slm_file_xattr *level, int *xattr_status)
> +{
> +	int xattr_len;
> +	char *xattr_value = NULL;
> +	int rc, error = -EINVAL;
> +
> +	rc = integrity_verify_metadata(dentry, slm_xattr_name,
> +				       &xattr_value, &xattr_len, xattr_status);
> +	if (rc < 0) {
> +		printk(KERN_INFO
> +		       "%s integrity_verify_metadata failed (%d)\n",
> +		       dentry->d_name.name, rc);
> +		return rc;
> +	}
> +
> +	if (xattr_value) {
> +		memset(level, 0, sizeof(struct slm_file_xattr));
> +		error = slm_parse_xattr(xattr_value, xattr_len, level);
> +		kfree(xattr_value);
> +	}
> +
> +	if (level->iac_level != SLM_IAC_UNTRUSTED) {
> +		rc = integrity_verify_data(dentry);
> +		if (rc < 0) {
> +			printk(KERN_INFO "%s integrity_verify_data failed "
> +			       " (%d)\n", dentry->d_name.name, rc);
> +			return rc;
> +		}
> +	}
> +
> +	return error < 0 ? -EINVAL : rc;
> +}

How about expanding this to a normal if()?

> +static void get_sock_level(struct dentry *dentry, struct slm_file_xattr *level)
> +{
> +	struct slm_tsec_data *cur_tsec;
> +	int rc, xattr_status = 0;
> +
> +	cur_tsec = current->security;
> +
> +	rc = slm_get_xattr(dentry, level, &xattr_status);
> +	if (rc == -EINVAL) {

How about just 'if (rc)' just in case somebody decides to return a
different error code in the future?

> +		if (xattr_status == -EOPNOTSUPP) {
> +			level->iac_level = SLM_IAC_EXEMPT;
> +			level->sac_level = SLM_SAC_EXEMPT;
> +		} else {
> +			level->iac_level = cur_tsec->iac_r;
> +			level->sac_level = cur_tsec->sac_rx;
> +		}
> +	}
> +}
> +
> +static void get_level(struct dentry *dentry, struct slm_file_xattr *level)
> +{
> +	int rc, xattr_status = 0;
> +
> +	rc = slm_get_xattr(dentry, level, &xattr_status);
> +	if ((rc == INTEGRITY_FAIL) || (rc == INTEGRITY_NOLABEL)) {
> +		level->iac_level = SLM_IAC_UNTRUSTED;
> +		level->sac_level = SLM_SAC_PUBLIC;
> +	} else if (xattr_status == -EOPNOTSUPP) {
> +		level->iac_level = SLM_IAC_EXEMPT;
> +		level->sac_level = SLM_SAC_EXEMPT;
> +	} else if (rc == -EINVAL) {	/* improperly formatted */
> +		level->iac_level = SLM_IAC_UNTRUSTED;
> +		level->sac_level = SLM_SAC_PUBLIC;
> +	}
> +}
> +
> +static struct slm_isec_data *slm_alloc_security(void)
> +{
> +	struct slm_isec_data *isec;
> +
> +	isec = kzalloc(sizeof(struct slm_isec_data), GFP_KERNEL);
> +	if (!isec)
> +		return NULL;
> +
> +	isec->lock = SPIN_LOCK_UNLOCKED;
> +	return isec;
> +}

Is that safe, or is will the spin_lock_init() version make the lock
debugging code happier?

> +static struct slm_isec_data * slm_inode_alloc_and_lock(struct inode *inode)
> +{
> +	struct slm_isec_data *isec = slm_alloc_security();
> +	if (!isec)
> +		return NULL;
> +
> +	spin_lock(&slm_inode_sec_lock);
> +	if (inode->i_security) {
> +		kfree(isec);
> +		isec = inode->i_security;
> +	} else
> +		inode->i_security = isec;
> +	spin_unlock(&slm_inode_sec_lock);
> +
> +	return isec;
> +}
> +
> +/*
> + * Exempt objects without extended attribute support 
> + */
> +static int is_exempt(struct inode *inode)
> +{
> +	if ((inode->i_sb->s_magic == PROC_SUPER_MAGIC)
> +	    || S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> +		return 1;
> +	return 0;
> +}

This could probably be a much more generic function, no?  

inode_supports_xaddr()?  Seems like something that should check a
superblock flag or something.


Man, there's a lot of code in here.  ;)  I'll look over some more this
weekend.

-- Dave

