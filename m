Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWHRRYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWHRRYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWHRRYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:24:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:52707 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030329AbWHRRYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:24:00 -0400
Subject: Re: [RFC][PATCH 4/8] SLIM main patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Seth Arnold <seth.arnold@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <20060818011549.GO2584@suse.de>
References: <1155844402.6788.58.camel@localhost.localdomain>
	 <20060818011549.GO2584@suse.de>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 10:24:02 -0700
Message-Id: <1155921842.6788.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your detailed review.  Responses inline below.

On Thu, 2006-08-17 at 18:15 -0700, Seth Arnold wrote:
> On Thu, Aug 17, 2006 at 12:53:22PM -0700, Kylene Jo Hall wrote:
> > --- linux-2.6.18-rc3/security/slim/slm_main.c	1969-12-31 18:00:00.000000000 -0600
> > +++ linux-2.6.18-rc3-working/security/slim/slm_main.c	2006-08-08 13:01:26.000000000 -0500
> > @@ -0,0 +1,1526 @@
> > +/*
> > + * SLIM - Simple Linux Integrity Module
> > + *
> > + * Copyright (C) 2005,2006 IBM Corporation
> > + * Author: Mimi Zohar <zohar@us.ibm.com>
> > + * 	   Kylene Hall <kjhall@us.ibm.com>
> > + *
> > + *      This program is free software; you can redistribute it and/or modify
> > + *      it under the terms of the GNU General Public License as published by
> > + *      the Free Software Foundation, version 2 of the License.
> > + */
> > +
> > +#include <linux/mman.h>
> > +#include <linux/config.h>
> > +#include <linux/kernel.h>
> > +#include <linux/security.h>
> > +#include <linux/integrity.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/socket.h>
> > +#include <linux/fs.h>
> > +#include <linux/file.h>
> > +#include <linux/namei.h>
> > +#include <linux/mm.h>
> > +#include <linux/shm.h>
> > +#include <linux/ipc.h>
> > +#include <linux/errno.h>
> > +#include <linux/xattr.h>
> > +#include <net/sock.h>
> > +
> > +#include "slim.h"
> > +
> > +#define XATTR_NAME "security.slim.level"
> > +
> > +#define EXEMPT_STR "EXEMPT"
> > +#define PUBLIC_STR "PUBLIC"
> > +#define SYSTEM_SENSITIVE_STR "SYSTEM-SENSITIVE"
> > +#define SYSTEM_STR "SYSTEM"
> > +#define UNLIMITED_STR "UNLIMITED"
> > +#define UNTRUSTED_STR "UNTRUSTED"
> > +#define USER_SENSITIVE_STR "USER-SENSITIVE"
> > +#define USER_STR "USER"
> > +#define ZERO_STR "0"
> > +
> > +char *slm_iac_str[] = { ZERO_STR,
> > +	UNTRUSTED_STR,
> > +	USER_STR,
> > +	SYSTEM_STR
> > +};
> > +static char *slm_sac_str[] = { ZERO_STR,
> > +	PUBLIC_STR,
> > +	USER_STR,
> > +	USER_SENSITIVE_STR,
> > +	SYSTEM_SENSITIVE_STR
> > +};
> 
> I'd find these easier to understand if the #defines were done nearer
> the array that uses them; some are integrity, some are secrecy, and it
> isn't exactly clear to me which ones are which from just the above.

When I first read your comment I thought you were refering to the arrays
which are used in many places and I think it should be clear which are
integrity and which are secrecy as we keep the same naming convention
throughout (iac vs. sac).  However, on closer look I think you mean the
ones which are actually defined with "#define" and those will not be a
problem to move.

> > +static char *get_token(char *buf_start, char *buf_end, char delimiter,
> > +		       int *token_len)
> > +{
> > +	char *bufp = buf_start;
> > +	char *token = NULL;
> > +
> > +	while (!token && (bufp < buf_end)) {	/* Get start of token */
> > +		switch (*bufp) {
> > +		case ' ':
> > +		case '\n':
> > +		case '\t':
> > +			bufp++;
> > +			break;
> > +		case '#':
> > +			while ((*bufp != '\n') && (bufp++ < buf_end)) ;
> > +			bufp++;
> > +			break;
> > +		default:
> > +			token = bufp;
> > +			break;
> > +		}
> > +	}
> > +	if (!token)
> > +		return NULL;
> > +
> > +	*token_len = 0;
> > +	while ((*token_len == 0) && (bufp <= buf_end)) {
> > +		if ((*bufp == delimiter) || (*bufp == '\n'))
> > +			*token_len = bufp - token;
> > +		if (bufp == buf_end)
> > +			*token_len = bufp - token;
> > +		bufp++;
> > +	}
> > +	if (*token_len == 0)
> > +		token = NULL;
> > +	return token;
> > +}
> > +
> > +static int is_guard_integrity(struct slm_file_xattr *level)
> > +{
> > +	if ((level->guard.iac_r != SLM_IAC_NOTDEFINED)
> > +	    && (level->guard.iac_wx != SLM_IAC_NOTDEFINED))
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static int is_guard_secrecy(struct slm_file_xattr *level)
> > +{
> > +	if ((level->guard.sac_rx != SLM_SAC_NOTDEFINED)
> > +	    && (level->guard.sac_w != SLM_SAC_NOTDEFINED))
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static int is_lower_integrity(struct slm_file_xattr *task_level,
> > +			      struct slm_file_xattr *obj_level)
> > +{
> > +	if (task_level->iac_level < obj_level->iac_level)
> > +		return 1;
> > +	return 0;
> > +}
> > +static int is_isec_defined(struct slm_isec_data *isec)
> > +{
> > +	if (isec && isec->level.iac_level != SLM_IAC_NOTDEFINED)
> > +		return 1;
> > +	return 0;
> > +}
> 
> All of these booleans could be re-written to simply return the value of
> the boolean check. I don't know if those are actually easier to read,
> but someone should see them once and decide. :)
> 
Let me make sure I understand.  You think "return (isec && isec-
>level.iacl_level != SLM_IAC_NOTDEFINED);" would be easier?

> > +/* 
> > + * Called with current->files->file_lock. There is not a great lock to grab
> > + * for demotion of this type.  The only place f_mode is changed after install
> > + * is in mark_files_ro in the filesystem code.  That function is also changing
> > + * taking away write rights so even if we race the outcome is the same.
> > + */
> > +static inline void do_revoke_file_wperm(struct file *file,
> > +					struct slm_file_xattr *cur_level)
> > +{
> > +	struct inode *inode;
> > +	struct slm_isec_data *isec;
> > +
> > +	inode = file->f_dentry->d_inode;
> > +	if (!inode)
> > +		return;
> 
> How would the code get to this point? Should this be a BUG_ON instead?
> 
Possibly I'll look into it.

> > +	if (!S_ISREG(inode->i_mode) || !(file->f_mode && FMODE_WRITE))
> > +		return;
> > +
> > +	isec = inode->i_security;
> > +	spin_lock(&isec->lock);
> > +	if (is_lower_integrity(cur_level, &isec->level))
> > +		file->f_mode &= ~FMODE_WRITE;
> > +	spin_unlock(&isec->lock);
> > +}
> > +
> > +/*
> > + * Revoke write permission on an open file.  
> > + */
> > +static void revoke_file_wperm(struct slm_file_xattr *cur_level)
> > +{
> > +	int i, j = 0;
> > +	struct files_struct *files = current->files;
> > +	unsigned long fd = 0;
> > +	struct fdtable *fdt;
> > +	struct file *file;
> > +
> > +	if (!files || !cur_level)
> > +		return;
> > +
> > +	spin_lock(&files->file_lock);
> > +	fdt = files_fdtable(files);
> > +
> > +	for (;;) {
> > +		i = j * __NFDBITS;
> > +		if (i >= fdt->max_fdset || i >= fdt->max_fds)
> > +			break;
> > +		fd = fdt->open_fds->fds_bits[j++];
> > +		while (fd) {
> > +			if (fd & 1) {
> > +				file = fdt->fd[i++];
> > +				if (file && file->f_dentry)
> > +					do_revoke_file_wperm(file, cur_level);
> 
> Which files wouldn't have dentries?
> 
Again, I'll check.

> > +			}
> > +			fd >>= 1;
> > +		}
> > +	}
> > +	spin_unlock(&files->file_lock);
> > +}
> > +
> > +static inline void do_revoke_mmap_wperm(struct vm_area_struct *mpnt,
> > +					struct slm_isec_data *isec,
> > +					struct slm_file_xattr *cur_level)
> > +{
> > +	unsigned long start = mpnt->vm_start;
> > +	unsigned long end = mpnt->vm_end;
> > +	size_t len = end - start;
> > +
> > +	if ((mpnt->vm_flags & (VM_WRITE | VM_MAYWRITE))
> > +	    && (mpnt->vm_flags & VM_SHARED)
> > +	    && (cur_level->iac_level < isec->level.iac_level))
> > +		do_mprotect(start, len, PROT_READ);
> > +}
> > +
> > +/*
> > + * Revoke write permission to underlying mmap file (MAP_SHARED)
> > + */
> > +static void revoke_mmap_wperm(struct slm_file_xattr *cur_level)
> > +{
> > +	struct vm_area_struct *mpnt;
> > +	struct file *file;
> > +	struct dentry *dentry;
> > +	struct slm_isec_data *isec;
> > +
> > +	flush_cache_mm(current->mm);
> 
> Is it a good idea to flush the cache before making the modifications?
> Feels like the wrong order to me.

Our thought was that we are going to revoke write access to the file at
this point, bu all pending writes are still valid. So we flush to make
sure they can still be written (since we are revoking permission to that
operation).
> 
> > +	down_write(&current->mm->mmap_sem);
> > +	for (mpnt = current->mm->mmap; mpnt; mpnt = mpnt->vm_next) {
> > +		file = mpnt->vm_file;
> > +		if (!file)
> > +			continue;
> > +
> > +		dentry = file->f_dentry;
> > +		if (!dentry || !dentry->d_inode)
> > +			continue;
> > +
> > +		isec = dentry->d_inode->i_security;
> > +		do_revoke_mmap_wperm(mpnt, isec, cur_level);
> > +	}
> > +	up_write(&current->mm->mmap_sem);
> > +}
> > +
> > +/*
> > + * Revoke write permissions and demote threads using shared memory
> > + */
> > +static void revoke_permissions(struct slm_file_xattr *cur_level)
> > +{
> > +	if (!is_kernel_thread(current)) {
> > +		revoke_mmap_wperm(cur_level);
> > +		revoke_file_wperm(cur_level);
> > +	}
> > +}
> > +
> > +static enum slm_iac_level set_iac(char *token)
> > +{
> > +	int iac;
> > +
> > +	if (strncmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
> > +		return SLM_IAC_EXEMPT;
> > +	for (iac = 0; iac < sizeof(slm_iac_str) / sizeof(char *); iac++) {
> > +		if (strncmp(token, slm_iac_str[iac], strlen(slm_iac_str[iac]))
> > +		    == 0)
> > +			return iac;
> > +	}
> > +	return SLM_IAC_ERROR;
> > +}
> > +
> > +static enum slm_sac_level set_sac(char *token)
> > +{
> > +	int sac;
> > +
> > +	if (strncmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
> > +		return SLM_SAC_EXEMPT;
> > +	for (sac = 0; sac < sizeof(slm_sac_str) / sizeof(char *); sac++) {
> > +		if (strncmp(token, slm_sac_str[sac], strlen(slm_sac_str[sac]))
> > +		    == 0)
> > +			return sac;
> > +	}
> > +	return SLM_SAC_ERROR;
> > +}
> > +
> > +static inline int set_bounds(char *token)
> > +{
> > +	if (strncmp(token, UNLIMITED_STR, strlen(UNLIMITED_STR)) == 0)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +/* 
> > + * Get the 7 access class levels from the extended attribute 
> > + * Format: TIMESTAMP INTEGRITY SECRECY [INTEGRITY_GUARD INTEGRITY_GUARD] [SECRECY_GUARD SECRECY_GUARD] [GUARD_ TYPE]
> > + */
> > +static int slm_parse_xattr(char *xattr_value, int xattr_len,
> > +			   struct slm_file_xattr *level)
> > +{
> > +	char *token;
> > +	int token_len;
> > +	char *buf, *buf_end;
> > +	int fieldno = 0;
> > +	int rc = 0;
> > +
> > +	buf = xattr_value;
> > +	buf_end = xattr_value + xattr_len;
> > +
> > +	while ((token = get_token(buf, buf_end, ' ', &token_len)) != NULL) {
> > +		buf = token + token_len;
> > +		switch (++fieldno) {
> > +		case 1:
> > +			level->iac_level = set_iac(token);
> 
> set_iac() seems an odd name for a function parsing a string to return an
> integer. Same with the other functions here..
Well put.  The funtion used to do that part as well but we restructured.
I'll fix the names.

> 
> > +			if (level->iac_level == SLM_IAC_ERROR) {
> > +				rc = -1;
> > +				level->iac_level = SLM_IAC_UNTRUSTED;
> > +			}
> > +			break;
> > +		case 2:
> > +			level->sac_level = set_sac(token);
> > +			if (level->sac_level == SLM_SAC_ERROR) {
> > +				rc = -1;
> > +				level->sac_level = SLM_SAC_PUBLIC;
> > +			}
> > +			break;
> > +		case 3:
> > +			level->guard.iac_r = set_iac(token);
> > +			if (level->guard.iac_r == SLM_IAC_ERROR) {
> > +				rc = -1;
> > +				level->iac_level = SLM_IAC_UNTRUSTED;
> > +			}
> > +			break;
> > +		case 4:
> > +			level->guard.iac_wx = set_iac(token);
> > +			if (level->guard.iac_wx == SLM_IAC_ERROR) {
> > +				rc = -1;
> > +				level->iac_level = SLM_IAC_UNTRUSTED;
> > +			}
> > +			break;
> > +		case 5:
> > +			level->guard.unlimited = set_bounds(token);
> > +			level->guard.sac_w = set_sac(token);
> > +			if (level->guard.sac_w == SLM_SAC_ERROR) {
> > +				rc = -1;
> > +				level->sac_level = SLM_SAC_PUBLIC;
> > +			}
> > +			break;
> > +		case 6:
> > +			level->guard.sac_rx = set_sac(token);
> > +			if (level->guard.sac_rx == SLM_SAC_ERROR) {
> > +				rc = -1;
> > +				level->sac_level = SLM_SAC_PUBLIC;
> > +			}
> > +			break;
> > +		case 7:
> > +			level->guard.unlimited = set_bounds(token);
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +	return rc;
> > +}
> > +
> > +/*
> > + *  Possible return codes:  INTEGRITY_PASS, INTEGRITY_FAIL, INTEGRITY_NOLABEL,
> > + * 			 or -EINVAL
> > + */
> > +static int slm_get_xattr(struct dentry *dentry,
> > +			 struct slm_file_xattr *level, int *status)
> > +{
> > +	int xattr_len;
> > +	char *xattr_value = NULL;
> > +	int rc, error = -EINVAL;
> > +
> > +	rc = integrity_verify_metadata(dentry, XATTR_NAME,
> > +				       &xattr_value, &xattr_len, status);
> > +	if (rc < 0) {
> > +		if (rc != -EOPNOTSUPP) {
> > +			printk(KERN_INFO
> > +				"%s integrity_verify_metadata failed "
> > +				"(rc: %d - status: %d)\n",
> > +			       dentry->d_name.name, rc, *status);
> > +		}
> > +		return rc;
> > +	}
> > +
> > +	if (xattr_value) {
> > +		memset(level, 0, sizeof(struct slm_file_xattr));
> > +		error = slm_parse_xattr(xattr_value, xattr_len, level);
> > +		kfree(xattr_value);
> > +	}
> > +
> > +	if (level->iac_level != SLM_IAC_UNTRUSTED) {
> > +		rc = integrity_verify_data(dentry, status);
> > +		if ((rc < 0) || (*status != INTEGRITY_PASS)) {
> > +			printk(KERN_INFO "%s integrity_verify_data failed "
> > +			       " (rc: %d status: %d)\n", dentry->d_name.name, 
> > +				rc, *status);
> > +			return rc;
> > +		}
> > +	}
> > +
> > +	if (error < 0)
> > +		return -EINVAL;
> > +	return rc;
> > +}
> 
> slm_get_xattr() seems remarkably subtle given its name: *status can be
> updated at two points in the function, a positive 'rc' from
> integrity_verify_data() is left to return at the end, but negative 'rc'
> values (that aren't -EOPNOTSUPP) get returned immediately, and if an
> error variable is negative, a specific value is returned..
> 
Yes that does look fishy.  I'll try to straighten it out better.

> > +/* Caller responsible for necessary locking */
> > +static inline void set_level(struct slm_file_xattr *level,
> > +			     enum slm_iac_level iac, enum slm_sac_level sac)
> > +{
> > +	level->iac_level = iac;
> > +	level->sac_level = sac;
> > +}
> > +static inline void set_level_exempt(struct slm_file_xattr *level)
> > +{
> > +	set_level(level, SLM_IAC_EXEMPT, SLM_SAC_EXEMPT);
> > +}
> > +
> > +static inline void set_level_untrusted(struct slm_file_xattr *level)
> > +{
> > +	set_level(level, SLM_IAC_UNTRUSTED, SLM_SAC_PUBLIC);
> > +}
> > +
> > +static inline void set_level_tsec_write(struct slm_file_xattr *level,
> > +					struct slm_tsec_data *tsec)
> > +{
> > +	set_level(level, tsec->iac_wx, tsec->sac_w);
> > +}
> > +
> > +static inline void set_level_tsec_read(struct slm_file_xattr *level,
> > +				       struct slm_tsec_data *tsec)
> > +{
> > +	set_level(level, tsec->iac_r, tsec->sac_rx);
> > +}
> > +
> > +static void get_sock_level(struct dentry *dentry, struct slm_file_xattr *level)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	int rc, status = 0;
> > +
> > +	rc = slm_get_xattr(dentry, level, &status);
> > +	if (rc == -EOPNOTSUPP)
> > +		set_level_exempt(level);
> > +	else
> > +		set_level_tsec_read(level, cur_tsec);
> > +}
> > +
> > +static void get_level(struct dentry *dentry, struct slm_file_xattr *level)
> > +{
> > +	int rc, status = 0;
> > +
> > +	rc = slm_get_xattr(dentry, level, &status);
> > +	if (rc < 0) {
> > +		switch (rc) {
> > +		case -EOPNOTSUPP:
> > +			set_level_exempt(level);
> > +			break;
> > +		case -EINVAL:	/* improperly formatted */
> > +		default:
> > +			set_level_untrusted(level);
> > +			break;
> > +		}
> > +	} else {
> > +		switch(status) {
> > +			case INTEGRITY_FAIL:
> > +			case INTEGRITY_NOLABEL:
> > +				set_level_untrusted(level);
> > +				break;
> > +		}
> > +	}
> > +}
> 
> The complicated set of decision making in get_level() (which sets
> levels, heh) might be simplified if slm_get_xattr() internals were
> less complicated.

Yes I'll try to straighten out too.  The last review it was requested
that INTEGRITY status be returned from the hooks in a *int and regular
kernel errors returned from the function to get error propogation
correct but seems like we still have it over complicated.
> 
> > +static struct slm_isec_data *slm_alloc_security(gfp_t flags)
> > +{
> > +	struct slm_isec_data *isec;
> > +
> > +	isec = kzalloc(sizeof(struct slm_isec_data), flags);
> > +	if (!isec)
> > +		return NULL;
> > +
> > +	spin_lock_init(&isec->lock);
> > +	return isec;
> > +}
> > +
> > +/*
> > + * Exempt objects without extended attribute support
> > + * for fastpath.  Others will be handled generically
> > + * by the other functions.
> > + */
> > +static int is_exempt_fastpath(struct inode *inode)
> > +{
> > +	if ((inode->i_sb->s_magic == PROC_SUPER_MAGIC)
> > +	    || S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * All directories with xattr support should be labeled, but just in case
> > + * recursively traverse path (dentry->parent) until level info is found.
> > + */
> > +static void slm_get_level(struct dentry *dentry, struct slm_file_xattr *level)
> > +{
> > +	struct inode *inode = dentry->d_inode;
> > +	struct slm_isec_data *isec = inode->i_security;
> > +
> > +	if (is_isec_defined(isec)) {
> > +		memcpy(level, &isec->level, sizeof(struct slm_file_xattr));
> > +		return;
> > +	}
> > +
> > +	memset(level, 0, sizeof(struct slm_file_xattr));
> > +	if (is_exempt_fastpath(inode))
> > +		set_level_exempt(level);
> > +	else if (S_ISSOCK(inode->i_mode))
> > +		get_sock_level(dentry, level);
> > +	else
> > +		get_level(dentry, level);
> > +
> > +	spin_lock(&isec->lock);
> > +	memcpy(&isec->level, level, sizeof(struct slm_file_xattr));
> > +	spin_unlock(&isec->lock);
> > +}
> 
> No lock is required to read from isec->level, but a lock is required to
> write to it. Does this make sense?
> 
Fixed alot of those this round and missed this one.  I'll make sure to
do another pass to double check.

> > +/*
> > + * new tsk->security inherits from current->security
> > + */
> > +static struct slm_tsec_data *slm_init_task(struct task_struct *tsk, gfp_t flags)
> > +{
> > +	struct slm_tsec_data *tsec, *cur_tsec = current->security;
> > +
> > +	tsec = kzalloc(sizeof(struct slm_tsec_data), flags);
> > +	if (!tsec)
> > +		return NULL;
> > +	tsec->lock = SPIN_LOCK_UNLOCKED;
> > +	if (!cur_tsec) {
> > +		tsec->iac_r = SLM_IAC_HIGHEST - 1;
> > +		tsec->iac_wx = SLM_IAC_HIGHEST - 1;
> > +		tsec->sac_w = SLM_SAC_NOTDEFINED + 1;
> > +		tsec->sac_rx = SLM_SAC_NOTDEFINED + 1;
> > +	} else
> > +		memcpy(tsec, cur_tsec, sizeof(struct slm_tsec_data));
> > +
> > +	return tsec;
> > +}
> > +
> > +static int is_iac_level_exempt(struct slm_file_xattr *level)
> > +{
> > +	if (level->iac_level == SLM_IAC_EXEMPT)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static int is_sac_level_exempt(struct slm_file_xattr *level)
> > +{
> > +	if (level->sac_level == SLM_SAC_EXEMPT)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static int is_iac_less_than_or_exempt(struct slm_file_xattr *level,
> > +				      enum slm_iac_level iac)
> > +{
> > +	if (iac <= level->iac_level)
> > +		return 1;
> > +	return is_iac_level_exempt(level);
> > +}
> > +
> > +static int is_iac_greater_than_or_exempt(struct slm_file_xattr *level,
> > +					 enum slm_iac_level iac)
> > +{
> > +	if (iac >= level->iac_level)
> > +		return 1;
> > +	return is_iac_level_exempt(level);
> > +}
> > +
> > +static int is_sac_less_than_or_exempt(struct slm_file_xattr *level,
> > +				      enum slm_sac_level sac)
> > +{
> > +	if (sac <= level->sac_level)
> > +		return 1;
> > +	return is_sac_level_exempt(level);
> > +}
> > +
> > +static int is_sac_greater_than_or_exempt(struct slm_file_xattr *level,
> > +					 enum slm_sac_level sac)
> > +{
> > +	if (sac >= level->sac_level)
> > +		return 1;
> > +	return is_sac_level_exempt(level);
> > +}
> > +
> > +/*
> > + * enforce: IRAC(process) <= IAC(object)
> > + * Permit process to read file of equal or greater integrity
> > + * otherwise, demote the process.
> > + */
> > +static void enforce_integrity_read(struct slm_file_xattr *level)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	if (!is_iac_less_than_or_exempt(level, cur_tsec->iac_r)) {
> > +		/* Reading lower integrity, demote process */
> > +		/* Even in the case of a integrity guard process. */
> > +		cur_tsec->iac_r = level->iac_level;
> > +		cur_tsec->iac_wx = level->iac_level;
> > +		spin_unlock(&cur_tsec->lock);
> > +
> > +		revoke_permissions(level);
> > +		return;
> > +	}
> > +	spin_unlock(&cur_tsec->lock);
> > +}
> > +
> > +/*
> > + * enforce: SRXAC(process) >= SAC(object)
> > + * Permit process to read file of equal or lesser secrecy;
> > + * otherwise, promote the process.
> > + */
> > +static void enforce_secrecy_read(struct slm_file_xattr *level)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	if (!is_sac_greater_than_or_exempt(level, cur_tsec->sac_rx)) {
> > +		/* Reading higher secrecy, promote process */
> > +		/* Even in the case of a secrecy guard process. */
> > +		cur_tsec->sac_rx = level->sac_level;
> > +		cur_tsec->sac_w = level->sac_level;
> > +		spin_unlock(&cur_tsec->lock);
> > +
> > +		/* Working item: revoke write permission to lower secrecy
> > +		 * files. Prototyped but insufficiently tested for release
> > +		 * current code will only allow authorized user to release
> > +		 * sensitive data */
> > +		return;
> > +	}
> > +	spin_unlock(&cur_tsec->lock);
> > +}
> > +
> > +static void do_task_may_read(struct slm_file_xattr *level)
> > +{
> > +	enforce_integrity_read(level);
> > +	enforce_secrecy_read(level);
> > +}
> > +
> > +/*
> > + * enforce: IWXAC(process) >= IAC(object)
> > + * Permit process to write a file of equal or lesser integrity.
> > + */
> > +static int enforce_integrity_write(struct slm_file_xattr *level)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	int rc = 0;
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	if (!(is_iac_greater_than_or_exempt(level, cur_tsec->iac_wx)
> > +	      || (level->iac_level == SLM_IAC_NOTDEFINED)))
> > +		/* can't write higher integrity */
> > +		rc = -EACCES;
> > +	spin_unlock(&cur_tsec->lock);
> > +	return rc;
> > +}
> > +
> > +/*
> > + * enforce: SWAC(process) <= SAC(process)
> > + * Permit process to write a file of equal or greater secrecy
> > + */
> > +static int enforce_secrecy_write(struct slm_file_xattr *level)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	int rc = 0;
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	if (!is_sac_less_than_or_exempt(level, cur_tsec->sac_w))
> > +		/* can't write lower secrecy */
> > +		rc = -EACCES;
> > +	spin_unlock(&cur_tsec->lock);
> > +	return rc;
> > +}
> > +
> > +static int do_task_may_write(struct slm_file_xattr *level)
> > +{
> > +	int rc;
> > +
> > +	rc = enforce_integrity_write(level);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	return enforce_secrecy_write(level);
> > +}
> > +
> > +static int slm_set_taskperm(int mask, struct slm_file_xattr *level)
> > +{
> > +	int rc = 0;
> > +
> > +	if (mask & MAY_READ)
> > +		do_task_may_read(level);
> > +	if ((mask & MAY_WRITE) || (mask & MAY_APPEND))
> > +		rc = do_task_may_write(level);
> > +
> > +	return rc;
> > +}
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
> > +
> > +/*
> > + * Premise:
> > + * Can't write or execute higher integrity, can't read lower integrity
> > + * Can't read or execute higher secrecy, can't write lower secrecy
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
> > +
> > +	if (is_untrusted_blk_access(inode))
> > +		return -EPERM;
> > +
> > +	slm_get_level(dentry, &level);
> > +
> > +	/* measure all SYSTEM level integrity objects */
> > +	if (level.iac_level == SLM_IAC_SYSTEM)
> > +		integrity_measure(dentry, NULL, mask);
> > +
> > +	return slm_set_taskperm(mask, &level);
> > +}
> > +
> > +/* 
> > + * This hook is called holding the inode mutex.
> > + */
> > +static int slm_inode_unlink(struct inode *dir, struct dentry *dentry)
> > +{
> > +	struct slm_file_xattr level;
> > +
> > +	if (!dentry || !dentry->d_name.name)
> > +		return 0;
> > +
> > +	slm_get_level(dentry, &level);
> > +	return slm_set_taskperm(MAY_WRITE, &level);
> > +}
> > +
> > +static void slm_inode_free_security(struct inode *inode)
> > +{
> > +	struct slm_isec_data *isec = inode->i_security;
> > +
> > +	inode->i_security = NULL;
> > +	kfree(isec);
> > +}
> > +
> > +/*
> > + * Check integrity permission to create a regular file.
> > + */
> > +static int slm_inode_create(struct inode *parent_dir,
> > +			    struct dentry *dentry, int mask)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	struct slm_isec_data *parent_isec = parent_dir->i_security;
> > +	struct slm_file_xattr *parent_level = &parent_isec->level;
> > +	int rc = 0;
> > +
> > +	/*
> > +	 * enforce: IWXAC(process) >= IAC(object)
> > +	 * Permit process to write a file of equal or lesser integrity.
> > +	 */
> > +	spin_lock(&cur_tsec->lock);
> > +	spin_lock(&parent_isec->lock);
> > +	if (!is_iac_greater_than_or_exempt(parent_level, cur_tsec->iac_wx))
> > +		rc = -EPERM;
> > +	spin_unlock(&parent_isec->lock);
> > +	spin_unlock(&cur_tsec->lock);
> > +	return rc;
> > +}
> > +
> > +#define MAX_XATTR_SIZE 76
> > +
> > +static int slm_set_xattr(struct slm_file_xattr *level,
> > +			 char **name, void **value, size_t * value_len)
> > +{
> > +	int len;
> > +	int xattr_len;
> > +	char buf[MAX_XATTR_SIZE];
> > +	char *bufp = buf;
> > +	char *xattr_val = buf;
> > +	char *xattr_name;
> > +
> > +	if (!level)
> > +		return 0;
> > +
> > +	memset(buf, 0, sizeof(buf));
> > +
> > +	if (is_iac_level_exempt(level)) {
> > +		memcpy(bufp, EXEMPT_STR, strlen(EXEMPT_STR));
> > +		bufp += strlen(EXEMPT_STR);
> > +	} else {
> > +		len = strlen(slm_iac_str[level->iac_level]);
> > +		memcpy(bufp, slm_iac_str[level->iac_level], len);
> > +		bufp += len;
> > +	}
> > +	*bufp++ = ' ';
> > +	if (is_sac_level_exempt(level)) {
> > +		memcpy(bufp, EXEMPT_STR, strlen(EXEMPT_STR));
> > +		bufp += strlen(EXEMPT_STR);
> > +	} else {
> > +		len = strlen(slm_sac_str[level->sac_level]);
> > +		memcpy(bufp, slm_sac_str[level->sac_level], len);
> > +		bufp += len;
> > +	}
> > +	xattr_len = bufp - buf;
> > +
> > +	/* point after 'security.' */
> > +	xattr_name = strchr(XATTR_NAME, '.');
> > +	if (xattr_name)
> > +		*name = kstrdup(xattr_name + 1, GFP_KERNEL);
> > +	*value = kmalloc(xattr_len + 1, GFP_KERNEL);
> > +	if (!*value) {
> > +		kfree(name);
> > +		return -ENOMEM;
> > +	}
> > +	memcpy(*value, xattr_val, xattr_len);
> > +	*value_len = xattr_len;
> > +	return 0;
> > +}
> > +
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
> > +	if (rc < 0)
> > +		return rc;
> 
> if the slm_set_xattr() fails, should data be freed?
> > 
> > +	*name = data->name;
> > +	*value = data->value;
> > +	*len = data->len;
> > +	return 0;
> > +}
> > +
> > +static void slm_d_instantiate(struct dentry *dentry, struct inode *inode)
> > +{
> > +	struct slm_isec_data *isec;
> > +	struct slm_file_xattr level;
> > +
> > +	if (!inode)
> > +		return;
> > + 
> > +	isec = inode->i_security;
> > +	if (is_exempt_fastpath(inode)) {
> > +		memset(&level, 0, sizeof(struct slm_file_xattr));
> > +		set_level_exempt(&level);
> > +	} else if (S_ISSOCK(inode->i_mode))
> > +		memset(&level, 0, sizeof(struct slm_file_xattr));
> > +	else
> > +		get_level(dentry, &level);
> > +
> > +	spin_lock(&isec->lock);
> > +	memcpy(&isec->level, &level, sizeof(struct slm_file_xattr));
> > +	spin_unlock(&isec->lock);
> > +}
> > +
> > +/*
> > + * Check permissions to create a new directory in the existing directory
> > + * associated with inode structure @dir.
> > + */
> > +static int slm_inode_mkdir(struct inode *parent_dir,
> > +			   struct dentry *dentry, int mask)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	struct slm_isec_data *parent_isec = parent_dir->i_security;
> > +	struct slm_file_xattr *parent_level = &parent_isec->level;
> > +	int rc = 0;
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	spin_lock(&parent_isec->lock);
> > +	if (cur_tsec->iac_wx < parent_level->iac_level
> > +	    && parent_level->iac_level == SLM_IAC_SYSTEM)
> > +		rc = -EACCES;
> > +	spin_unlock(&parent_isec->lock);
> > +	spin_unlock(&cur_tsec->lock);
> > +	return rc;
> > +}
> > +
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
> > +
> > +/*
> > + * Limit the integrity value of an object to be no greater than that
> > + * of the current process. This is especially important for objects
> > + * being promoted.
> > +*/
> > +int slm_inode_setxattr(struct dentry *dentry, char *name, void *value,
> > +		       size_t size, int flags)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	char *data = value;
> > +	enum slm_iac_level iac;
> > +
> > +	if (strncmp(name, XATTR_NAME, strlen(XATTR_NAME)) != 0)
> > +		return 0;
> > +
> > +	if (!value)
> > +		return -EINVAL;
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	iac = cur_tsec->iac_wx;
> > +	spin_unlock(&cur_tsec->lock);
> > +
> > +	switch (iac) {
> > +	case SLM_IAC_USER:
> > +		if ((strncmp(data, USER_STR, strlen(USER_STR)) != 0) &&
> > +		    (strncmp(data, UNTRUSTED_STR, strlen(UNTRUSTED_STR)) != 0))
> > +			return -EPERM;
> > +		break;
> > +	case SLM_IAC_SYSTEM:
> > +		if ((strncmp(data, SYSTEM_STR, strlen(SYSTEM_STR)) != 0) &&
> > +		    (strncmp(data, USER_STR, strlen(USER_STR)) != 0) &&
> > +		    (strncmp(data, UNTRUSTED_STR, strlen(UNTRUSTED_STR)) != 0)
> > +		    && (strncmp(data, EXEMPT_STR, strlen(EXEMPT_STR)) != 0))
> > +			return -EPERM;
> > +		break;
> > +	default:
> > +		return -EPERM;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/*
> > + * SLIM extended attribute was modified, update isec.
> > + */
> > +static void slm_inode_post_setxattr(struct dentry *dentry, char *name,
> > +				    void *value, size_t size, int flags)
> > +{
> > +	struct slm_isec_data *slm_isec;
> > +	struct slm_file_xattr level;
> > +	int rc, status = 0;
> > +
> > +	if (strncmp(name, XATTR_NAME, strlen(XATTR_NAME)) != 0)
> > +		return;
> > +
> > +	rc = slm_get_xattr(dentry, &level, &status);
> > +	slm_isec = dentry->d_inode->i_security;
> > +	spin_lock(&slm_isec->lock);
> > +	memcpy(&slm_isec->level, &level, sizeof(struct slm_file_xattr));
> > +	spin_unlock(&slm_isec->lock);
> > +}
> > +
> > +static int slm_inode_removexattr(struct dentry *dentry, char *name)
> > +{
> > +	struct slm_isec_data *isec = dentry->d_inode->i_security;
> > +	struct slm_tsec_data *tsec = current->security;
> > +	enum slm_iac_level iac;
> > +	int rc = 0;
> > +
> > +	if (strncmp(name, XATTR_NAME, strlen(XATTR_NAME)) != 0)
> > +		return 0;
> > +
> > +	if (isec) {
> > +		spin_lock(&tsec->lock);
> > +		iac = tsec->iac_wx;
> > +		spin_unlock(&tsec->lock);
> > +
> > +		spin_lock(&isec->lock);
> > +		switch(iac) {
> > +		case SLM_IAC_SYSTEM:
> > +			isec->level.iac_level = SLM_IAC_NOTDEFINED;
> > +			break;
> > +		case SLM_IAC_USER:
> > +			if (isec->level.iac_level < SLM_IAC_NOTDEFINED ||
> > +			    isec->level.iac_level > SLM_IAC_USER)
> > +				rc = -EPERM;
> > +			else
> > +				isec->level.iac_level = SLM_IAC_NOTDEFINED;
> > +			break;
> > +		default:
> > +			rc = -EPERM;
> > +		}
> > +		spin_unlock(&isec->lock);
> > +	}
> > +	return rc;
> > +}
> > +
> > +static int slm_inode_alloc_security(struct inode *inode)
> > +{
> > +	struct slm_isec_data *isec = slm_alloc_security(GFP_KERNEL);
> > +	if (!isec)
> > +		return -ENOMEM;
> > +
> > +	inode->i_security = isec;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Opening a socket demotes the integrity of a process to untrusted.
> > + */
> > +int slm_socket_create(int family, int type, int protocol, int kern)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	struct slm_file_xattr level;
> > +
> > +	/* demoting only internet sockets */
> > +	if ((family != AF_UNIX) && (family != AF_NETLINK)) {
> 
> Comment doesn't really match the test..
> 
will fix.
> > +		spin_lock(&cur_tsec->lock);
> > +		if (cur_tsec->iac_r > SLM_IAC_UNTRUSTED) {
> > +			cur_tsec->iac_r = SLM_IAC_UNTRUSTED;
> > +			cur_tsec->iac_wx = SLM_IAC_UNTRUSTED;
> > +			spin_unlock(&cur_tsec->lock);
> > +
> > +			memset(&level, 0, sizeof(struct slm_file_xattr));
> > +			level.iac_level = SLM_IAC_UNTRUSTED;
> > +
> > +			revoke_permissions(&level);
> > +			return 0;
> > +		}
> > +		spin_unlock(&cur_tsec->lock);
> > +	}
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Didn't have the family type previously, so update the inode security now.
> > + */
> > +static void slm_socket_post_create(struct socket *sock, int family,
> > +				   int type, int protocol, int kern)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	struct inode *inode = SOCK_INODE(sock);
> > +	struct slm_isec_data *slm_isec = inode->i_security;
> > +
> > +	spin_lock(&slm_isec->lock);
> > +	if (family == PF_UNIX) {
> > +		if (cur_tsec->iac_wx != cur_tsec->iac_r)	/* guard process */
> > +			set_level_exempt(&slm_isec->level);
> > +		else
> > +			set_level_tsec_write(&slm_isec->level, cur_tsec);
> > +	} else
> > +		set_level_untrusted(&slm_isec->level);
> > +	spin_unlock(&slm_isec->lock);
> > +}
> > +
> > +/*
> > + * When a task gets allocated, it inherits the current IAC and SAC.
> > + * Set the values and store them in p->security.
> > + */
> > +static int slm_task_alloc_security(struct task_struct *tsk)
> > +{
> > +	struct slm_tsec_data *tsec = tsk->security;
> > +
> > +	if (!tsec) {
> > +		tsec = slm_init_task(tsk, GFP_KERNEL);
> > +		if (!tsec)
> > +			return -ENOMEM;
> > +	}
> > +	tsk->security = tsec;
> > +	return 0;
> > +}
> > +
> > +static void slm_task_free_security(struct task_struct *tsk)
> > +{
> > +	struct slm_tsec_data *tsec;
> > +
> > +	tsec = tsk->security;
> > +	tsk->security = NULL;
> > +	kfree(tsec);
> > +}
> > +
> > +/* init_task is an integrity guard */
> > +static int slm_task_init_alloc_security(struct task_struct *tsk)
> > +{
> > +	struct slm_tsec_data *tsec = kzalloc(sizeof(struct slm_tsec_data), GFP_KERNEL);
> > +
> > +	if (!tsec)
> > +		return -ENOMEM;
> > +
> > +	tsec->lock = SPIN_LOCK_UNLOCKED;
> > +
> > +	tsec->iac_r = SLM_IAC_UNTRUSTED;
> > +	tsec->iac_wx = SLM_IAC_SYSTEM;
> > +	tsec->sac_w = SLM_SAC_PUBLIC;
> > +	tsec->sac_rx = SLM_SAC_PUBLIC;
> > +
> > +	tsec->unlimited = 1;
> > +
> > +	tsk->security = tsec;
> > +	return 0;
> > +}
> > +
> > +static int slm_task_post_setuid(uid_t old_ruid, uid_t old_euid,
> > +				uid_t old_suid, int flags)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +
> > +	if (cur_tsec && flags == LSM_SETID_ID) {
> > +		/*set process to USER level integrity for everything but root */
> > +		spin_lock(&cur_tsec->lock);
> > +		if ((cur_tsec->iac_r == cur_tsec->iac_wx)
> > +		    && (cur_tsec->iac_r == SLM_IAC_UNTRUSTED));
> > +		else if (current->suid != 0) {
> > +			cur_tsec->iac_r = SLM_IAC_USER;
> > +			cur_tsec->iac_wx = SLM_IAC_USER;
> > +		} else if ((current->uid == 0) && (old_ruid != 0)) {
> > +			cur_tsec->iac_r = SLM_IAC_SYSTEM;
> > +			cur_tsec->iac_wx = SLM_IAC_SYSTEM;
> > +		}
> > +		spin_unlock(&cur_tsec->lock);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static inline int slm_setprocattr(struct task_struct *tsk,
> > +				  char *name, void *value, size_t size)
> > +{
> > +	return -EACCES;
> > +
> > +}
> > +
> > +static inline int slm_getprocattr(struct task_struct *tsk,
> > +				  char *name, void *value, size_t size)
> > +{
> > +	struct slm_tsec_data *tsec = tsk->security;
> > +	size_t len = 0;
> > +
> > +	if (is_kernel_thread(tsk))
> > +		len = snprintf(value, size, "KERNEL");
> > +	else {
> > +		spin_lock(&tsec->lock);
> > +		if (tsec->iac_wx != tsec->iac_r)
> > +			len = snprintf(value, size, "GUARD wx:%s r:%s",
> > +				       slm_iac_str[tsec->iac_wx],
> > +				       slm_iac_str[tsec->iac_r]);
> > +		else
> > +			len = snprintf(value, size, "%s",
> > +				       slm_iac_str[tsec->iac_wx]);
> > +		spin_unlock(&tsec->lock);
> > +	}
> > +	return min(len, size);
> > +}
> > +
> > +/*
> > + * enforce: IWXAC(process) <= IAC(object)
> > + * Permit process to execute file of equal or greater integrity
> > + */
> > +static void enforce_integrity_execute(struct linux_binprm *bprm,
> > +				      struct slm_file_xattr *level,
> > +				      struct slm_tsec_data *cur_tsec)
> > +{
> > +	spin_lock(&cur_tsec->lock);
> > +	if (is_iac_less_than_or_exempt(level, cur_tsec->iac_wx))
> > +		/* Being a guard process is not inherited */
> > +		cur_tsec->iac_r = cur_tsec->iac_wx;
> > +	else {
> > +		cur_tsec->iac_r = level->iac_level;
> > +		cur_tsec->iac_wx = level->iac_level;
> > +		spin_unlock(&cur_tsec->lock);
> > +
> > +		revoke_permissions(level);
> > +		return;
> > +	}
> > +	spin_unlock(&cur_tsec->lock);
> > +}
> > +
> > +static void enforce_guard_integrity_execute(struct linux_binprm *bprm,
> > +					    struct slm_file_xattr *level,
> > +					    struct slm_tsec_data *cur_tsec)
> > +{
> > +	if ((strcmp(bprm->filename, bprm->interp) != 0)
> > +	    && (level->guard.unlimited))
> > +		level->guard.unlimited = 0;
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	if (level->guard.unlimited) {
> > +		cur_tsec->iac_r = level->guard.iac_r;
> > +		cur_tsec->iac_wx = level->guard.iac_wx;
> > +	} else {
> > +		if (cur_tsec->iac_r > level->guard.iac_r)
> > +			cur_tsec->iac_r = level->guard.iac_r;
> > +		if (cur_tsec->iac_wx > level->guard.iac_wx)
> > +			cur_tsec->iac_wx = level->guard.iac_wx;
> > +	}
> > +	spin_unlock(&cur_tsec->lock);
> > +}
> > +
> > +/*
> > + * enforce: SRXAC(process) >= SAC(object)
> > + * Permit process to execute file of equal or lesser secrecy
> > + */
> > +static void enforce_secrecy_execute(struct linux_binprm *bprm,
> > +				    struct slm_file_xattr *level,
> > +				    struct slm_tsec_data *cur_tsec)
> > +{
> > +	spin_lock(&cur_tsec->lock);
> > +	if (is_sac_greater_than_or_exempt(level, cur_tsec->sac_rx))
> > +		/* Being a guard process is not inherited */
> > +		cur_tsec->sac_w = cur_tsec->sac_rx;
> > +	else {
> > +		cur_tsec->sac_rx = level->sac_level;
> > +		cur_tsec->sac_w = level->sac_level;
> > +
> > +		/* Working item: revoke write permission to lower secrecy
> > +		 * files. Prototyped but insufficiently tested for release
> > +		 * current code will only allow authorized user to release
> > +		 * sensitive data */
> > +	}
> > +	spin_unlock(&cur_tsec->lock);
> > +}
> > +
> > +static void enforce_guard_secrecy_execute(struct linux_binprm *bprm,
> > +					  struct slm_file_xattr *level,
> > +					  struct slm_tsec_data *cur_tsec)
> > +{
> > +	/*
> > +	 * set low write secrecy range,
> > +	 *      not less than current value, prevent leaking data
> > +	 */
> > +	spin_lock(&cur_tsec->lock);
> > +	cur_tsec->sac_w = max(cur_tsec->sac_w, level->guard.sac_w);
> > +	/* limit secrecy range, never demote secrecy */
> > +	cur_tsec->sac_rx = max(cur_tsec->sac_rx, level->guard.sac_rx);
> > +	spin_unlock(&cur_tsec->lock);
> > +}
> > +
> > +/*
> > + * Enforce process integrity & secrecy levels.
> > + * 	- update integrity process level of integrity guard program
> > + * 	- update secrecy process level of secrecy guard program
> > + */
> > +static int slm_bprm_check_security(struct linux_binprm *bprm)
> > +{
> > +	struct dentry *dentry;
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	struct slm_file_xattr level;
> > +	int rc, status;
> > +
> > +	/* Special case interpreters */
> > +	spin_lock(&cur_tsec->lock);
> > +	if (strcmp(bprm->filename, bprm->interp) != 0) {
> > +		if (!cur_tsec->script_dentry) {
> > +			spin_unlock(&cur_tsec->lock);
> > +			return 0;
> > +		} else
> > +			dentry = cur_tsec->script_dentry;
> > +	} else {
> > +		dentry = bprm->file->f_dentry;
> > +		cur_tsec->script_dentry = dentry;
> > +	}
> > +	spin_unlock(&cur_tsec->lock);
> > +
> > +	slm_get_level(dentry, &level);
> > +
> > +	/* slm_inode_permission measured all SYSTEM level integrity objects */
> > +	if (level.iac_level != SLM_IAC_SYSTEM)
> > +		integrity_measure(dentry, bprm->filename, MAY_EXEC);
> > +
> > +	/* Possible return codes: PERMIT, DENY, NOLABEL */
> > +	rc = integrity_verify_data(dentry, &status);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	switch(status) {
> > +	case INTEGRITY_FAIL:
> > +		if (!is_kernel_thread(current))
> > +			return -EACCES;
> > +	case INTEGRITY_NOLABEL:
> > +		level.iac_level = SLM_IAC_UNTRUSTED;
> > +		level.sac_level = SLM_SAC_PUBLIC;
> > +	}
> > +
> > +	enforce_integrity_execute(bprm, &level, cur_tsec);
> > +	if (is_guard_integrity(&level))
> > +		enforce_guard_integrity_execute(bprm, &level, cur_tsec);
> > +
> > +	enforce_secrecy_execute(bprm, &level, cur_tsec);
> > +	if (is_guard_secrecy(&level))
> > +		enforce_guard_secrecy_execute(bprm, &level, cur_tsec);
> > +
> > +	return 0;
> > +}
> > +
> > +static int slm_inode_setattr(struct dentry *dentry, struct iattr *iattr)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	struct slm_file_xattr level;
> > +	int rc = 0;
> > +
> > +	slm_get_level(dentry, &level);
> > +	spin_lock(&cur_tsec->lock);
> > +	if (cur_tsec->iac_wx < level.iac_level)
> > +			rc = -EACCES;
> > +	spin_unlock(&cur_tsec->lock);
> > +	return rc;
> > +}
> > +
> > +static inline int slm_capable(struct task_struct *tsk, int cap)
> > +{
> > +	struct slm_tsec_data *tsec = tsk->security;
> > +	int rc = 0;
> > +
> > +	/* Derived from include/linux/sched.h:capable. */
> > +	if (cap_raised(tsk->cap_effective, cap)) {
> > +		spin_lock(&tsec->lock);
> > +		if (tsec->iac_wx == SLM_IAC_UNTRUSTED &&
> > +		    cap == CAP_SYS_ADMIN)
> > +			rc = -EACCES;
> 
> Why is CAP_SYS_ADMIN handled specially?
This function is here to add the ability to remove capabilities.
CAP_SYS_ADMIN should definitely be removed even if you are running as
root but have been demoted to UNTRUSTED.  We are testing others but some
tend to break existing applications.

> > +		spin_unlock(&tsec->lock);
> > +		return rc;
> > +	}
> > +	return -EPERM;
> > +}
> > +
> > +static int slm_ptrace(struct task_struct *parent, struct task_struct *child)
> > +{
> > +	struct slm_tsec_data *parent_tsec = parent->security,
> > +	    *child_tsec = child->security;
> > +	int rc = 0;
> > +
> > +	if (is_kernel_thread(parent) || is_kernel_thread(child))
> > +		return 0;
> 
> Why was this added?
> 
Kernel threads are never demoted or restricted by SLIM

> > +	spin_lock(&parent_tsec->lock);
> > +	if (parent_tsec->iac_wx < child_tsec->iac_wx)
> > +		rc = -EPERM;
> > +	spin_unlock(&parent_tsec->lock);
> > +	return rc;
> > +}
> > +
> > +static int slm_shm_alloc_security(struct shmid_kernel *shp)
> > +{
> > +	struct slm_tsec_data *cur_tsec = current->security;
> > +	struct kern_ipc_perm *perm = &shp->shm_perm;
> > +	struct slm_isec_data *isec = slm_alloc_security(GFP_KERNEL);
> > +
> > +	if (!isec)
> > +		return -ENOMEM;
> > +
> > +	spin_lock(&cur_tsec->lock);
> > +	if (cur_tsec->iac_wx != cur_tsec->iac_r)	/* guard process */
> > +		set_level_exempt(&isec->level);
> > +	else
> > +		set_level_tsec_write(&isec->level, cur_tsec);
> > +	spin_unlock(&cur_tsec->lock);
> > +	perm->security = isec;
> > +
> > +	return 0;
> > +}
> > +
> > +static void slm_shm_free_security(struct shmid_kernel *shp)
> > +{
> > +	struct kern_ipc_perm *perm = &shp->shm_perm;
> > +	struct slm_isec_data *isec = perm->security;
> > +
> > +	perm->security = NULL;
> > +	kfree(isec);
> > +}
> > +
> > +/*
> > + *  When shp exists called holding perm->lock
> > + */
> > +static int slm_shm_shmctl(struct shmid_kernel *shp, int cmd)
> > +{
> > +	struct kern_ipc_perm *perm;
> > +	struct slm_isec_data *perm_isec;
> > +	struct file *file;
> > +	struct dentry *dentry;
> > +	struct inode *inode;
> > +	int rc;
> > +
> > +	if (!shp)
> > +		return 0;
> > +
> > +	perm = &shp->shm_perm;
> > +	perm_isec = perm->security;
> > +	file = shp->shm_file;
> > +	dentry = file->f_dentry;
> > +	inode = dentry->d_inode;
> > +
> > +	spin_lock(&perm_isec->lock);
> > +	rc = slm_set_taskperm(MAY_READ | MAY_WRITE, &perm_isec->level);
> > +	spin_unlock(&perm_isec->lock);
> > +	return rc;
> > +}
> > +
> > +/*
> > + * Called holding perm->lock
> > + */
> > +static int slm_shm_shmat(struct shmid_kernel *shp,
> > +			 char __user * shmaddr, int shmflg)
> > +{
> > +	int mask = MAY_READ;
> > +	int rc;
> > +	struct kern_ipc_perm *perm = &shp->shm_perm;
> > +	struct file *file = shp->shm_file;
> > +	struct dentry *dentry = file->f_dentry;
> > +	struct inode *inode = dentry->d_inode;
> > +	struct slm_isec_data *perm_isec = perm->security,
> > +	    *isec = inode->i_security;
> > +
> > +	if (shmflg != SHM_RDONLY)
> > +		mask |= MAY_WRITE;
> > +
> > +	spin_lock(&perm_isec->lock);
> > +	rc = slm_set_taskperm(mask, &perm_isec->level);
> > +
> > +	spin_lock(&isec->lock);
> > +	memcpy(&isec->level, &perm_isec->level, sizeof(struct slm_file_xattr));
> > +	spin_unlock(&perm_isec->lock);
> > +	spin_unlock(&isec->lock);
> > +
> > +	return rc;
> > +}
> > +
> > +static struct security_operations slm_security_ops = {
> > +	.bprm_check_security = slm_bprm_check_security,
> > +	.file_permission = slm_file_permission,
> > +	.inode_permission = slm_inode_permission,
> > +	.inode_unlink = slm_inode_unlink,
> > +	.inode_create = slm_inode_create,
> > +	.inode_mkdir = slm_inode_mkdir,
> > +	.inode_rename = slm_inode_rename,
> > +	.inode_setattr = slm_inode_setattr,
> > +	.inode_setxattr = slm_inode_setxattr,
> > +	.inode_post_setxattr = slm_inode_post_setxattr,
> > +	.inode_removexattr = slm_inode_removexattr,
> > +	.inode_alloc_security = slm_inode_alloc_security,
> > +	.inode_free_security = slm_inode_free_security,
> > +	.inode_init_security = slm_inode_init_security,
> > +	.socket_create = slm_socket_create,
> > +	.socket_post_create = slm_socket_post_create,
> > +	.task_alloc_security = slm_task_alloc_security,
> > +	.task_free_security = slm_task_free_security,
> > +	.task_init_alloc_security = slm_task_init_alloc_security,
> > +	.task_post_setuid = slm_task_post_setuid,
> > +	.capable = slm_capable,
> > +	.ptrace = slm_ptrace,
> > +	.shm_alloc_security = slm_shm_alloc_security,
> > +	.shm_free_security = slm_shm_free_security,
> > +	.shm_shmat = slm_shm_shmat,
> > +	.shm_shmctl = slm_shm_shmctl,
> > +	.getprocattr = slm_getprocattr,
> > +	.setprocattr = slm_setprocattr,
> > +	.d_instantiate = slm_d_instantiate
> > +};
> > +
> > +static int __init init_slm(void)
> > +{
> > +	current->security = slm_init_task(current, GFP_ATOMIC);
> > +	return register_security(&slm_security_ops);
> > +}
> > +security_initcall(init_slm);
> 
> Thanks

