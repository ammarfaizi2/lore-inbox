Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWHRBPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWHRBPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 21:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWHRBPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 21:15:54 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:5047 "EHLO
	haldeman.int.wirex.com") by vger.kernel.org with ESMTP
	id S932256AbWHRBPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 21:15:51 -0400
Date: Thu, 17 Aug 2006 18:15:49 -0700
From: Seth Arnold <seth.arnold@suse.de>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 4/8] SLIM main patch
Message-ID: <20060818011549.GO2584@suse.de>
Mail-Followup-To: Kylene Jo Hall <kjhall@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LSM ML <linux-security-module@vger.kernel.org>,
	Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
	Serge Hallyn <sergeh@us.ibm.com>
References: <1155844402.6788.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuxWNXB0+C4YKz9o"
Content-Disposition: inline
In-Reply-To: <1155844402.6788.58.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IuxWNXB0+C4YKz9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2006 at 12:53:22PM -0700, Kylene Jo Hall wrote:
> --- linux-2.6.18-rc3/security/slim/slm_main.c	1969-12-31 18:00:00.0000000=
00 -0600
> +++ linux-2.6.18-rc3-working/security/slim/slm_main.c	2006-08-08 13:01:26=
=2E000000000 -0500
> @@ -0,0 +1,1526 @@
> +/*
> + * SLIM - Simple Linux Integrity Module
> + *
> + * Copyright (C) 2005,2006 IBM Corporation
> + * Author: Mimi Zohar <zohar@us.ibm.com>
> + * 	   Kylene Hall <kjhall@us.ibm.com>
> + *
> + *      This program is free software; you can redistribute it and/or mo=
dify
> + *      it under the terms of the GNU General Public License as publishe=
d by
> + *      the Free Software Foundation, version 2 of the License.
> + */
> +
> +#include <linux/mman.h>
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/security.h>
> +#include <linux/integrity.h>
> +#include <linux/proc_fs.h>
> +#include <linux/socket.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/namei.h>
> +#include <linux/mm.h>
> +#include <linux/shm.h>
> +#include <linux/ipc.h>
> +#include <linux/errno.h>
> +#include <linux/xattr.h>
> +#include <net/sock.h>
> +
> +#include "slim.h"
> +
> +#define XATTR_NAME "security.slim.level"
> +
> +#define EXEMPT_STR "EXEMPT"
> +#define PUBLIC_STR "PUBLIC"
> +#define SYSTEM_SENSITIVE_STR "SYSTEM-SENSITIVE"
> +#define SYSTEM_STR "SYSTEM"
> +#define UNLIMITED_STR "UNLIMITED"
> +#define UNTRUSTED_STR "UNTRUSTED"
> +#define USER_SENSITIVE_STR "USER-SENSITIVE"
> +#define USER_STR "USER"
> +#define ZERO_STR "0"
> +
> +char *slm_iac_str[] =3D { ZERO_STR,
> +	UNTRUSTED_STR,
> +	USER_STR,
> +	SYSTEM_STR
> +};
> +static char *slm_sac_str[] =3D { ZERO_STR,
> +	PUBLIC_STR,
> +	USER_STR,
> +	USER_SENSITIVE_STR,
> +	SYSTEM_SENSITIVE_STR
> +};

I'd find these easier to understand if the #defines were done nearer
the array that uses them; some are integrity, some are secrecy, and it
isn't exactly clear to me which ones are which from just the above.

> +static char *get_token(char *buf_start, char *buf_end, char delimiter,
> +		       int *token_len)
> +{
> +	char *bufp =3D buf_start;
> +	char *token =3D NULL;
> +
> +	while (!token && (bufp < buf_end)) {	/* Get start of token */
> +		switch (*bufp) {
> +		case ' ':
> +		case '\n':
> +		case '\t':
> +			bufp++;
> +			break;
> +		case '#':
> +			while ((*bufp !=3D '\n') && (bufp++ < buf_end)) ;
> +			bufp++;
> +			break;
> +		default:
> +			token =3D bufp;
> +			break;
> +		}
> +	}
> +	if (!token)
> +		return NULL;
> +
> +	*token_len =3D 0;
> +	while ((*token_len =3D=3D 0) && (bufp <=3D buf_end)) {
> +		if ((*bufp =3D=3D delimiter) || (*bufp =3D=3D '\n'))
> +			*token_len =3D bufp - token;
> +		if (bufp =3D=3D buf_end)
> +			*token_len =3D bufp - token;
> +		bufp++;
> +	}
> +	if (*token_len =3D=3D 0)
> +		token =3D NULL;
> +	return token;
> +}
> +
> +static int is_guard_integrity(struct slm_file_xattr *level)
> +{
> +	if ((level->guard.iac_r !=3D SLM_IAC_NOTDEFINED)
> +	    && (level->guard.iac_wx !=3D SLM_IAC_NOTDEFINED))
> +		return 1;
> +	return 0;
> +}
> +
> +static int is_guard_secrecy(struct slm_file_xattr *level)
> +{
> +	if ((level->guard.sac_rx !=3D SLM_SAC_NOTDEFINED)
> +	    && (level->guard.sac_w !=3D SLM_SAC_NOTDEFINED))
> +		return 1;
> +	return 0;
> +}
> +
> +static int is_lower_integrity(struct slm_file_xattr *task_level,
> +			      struct slm_file_xattr *obj_level)
> +{
> +	if (task_level->iac_level < obj_level->iac_level)
> +		return 1;
> +	return 0;
> +}
> +static int is_isec_defined(struct slm_isec_data *isec)
> +{
> +	if (isec && isec->level.iac_level !=3D SLM_IAC_NOTDEFINED)
> +		return 1;
> +	return 0;
> +}

All of these booleans could be re-written to simply return the value of
the boolean check. I don't know if those are actually easier to read,
but someone should see them once and decide. :)

> +/*=20
> + * Called with current->files->file_lock. There is not a great lock to g=
rab
> + * for demotion of this type.  The only place f_mode is changed after in=
stall
> + * is in mark_files_ro in the filesystem code.  That function is also ch=
anging
> + * taking away write rights so even if we race the outcome is the same.
> + */
> +static inline void do_revoke_file_wperm(struct file *file,
> +					struct slm_file_xattr *cur_level)
> +{
> +	struct inode *inode;
> +	struct slm_isec_data *isec;
> +
> +	inode =3D file->f_dentry->d_inode;
> +	if (!inode)
> +		return;

How would the code get to this point? Should this be a BUG_ON instead?

> +	if (!S_ISREG(inode->i_mode) || !(file->f_mode && FMODE_WRITE))
> +		return;
> +
> +	isec =3D inode->i_security;
> +	spin_lock(&isec->lock);
> +	if (is_lower_integrity(cur_level, &isec->level))
> +		file->f_mode &=3D ~FMODE_WRITE;
> +	spin_unlock(&isec->lock);
> +}
> +
> +/*
> + * Revoke write permission on an open file. =20
> + */
> +static void revoke_file_wperm(struct slm_file_xattr *cur_level)
> +{
> +	int i, j =3D 0;
> +	struct files_struct *files =3D current->files;
> +	unsigned long fd =3D 0;
> +	struct fdtable *fdt;
> +	struct file *file;
> +
> +	if (!files || !cur_level)
> +		return;
> +
> +	spin_lock(&files->file_lock);
> +	fdt =3D files_fdtable(files);
> +
> +	for (;;) {
> +		i =3D j * __NFDBITS;
> +		if (i >=3D fdt->max_fdset || i >=3D fdt->max_fds)
> +			break;
> +		fd =3D fdt->open_fds->fds_bits[j++];
> +		while (fd) {
> +			if (fd & 1) {
> +				file =3D fdt->fd[i++];
> +				if (file && file->f_dentry)
> +					do_revoke_file_wperm(file, cur_level);

Which files wouldn't have dentries?

> +			}
> +			fd >>=3D 1;
> +		}
> +	}
> +	spin_unlock(&files->file_lock);
> +}
> +
> +static inline void do_revoke_mmap_wperm(struct vm_area_struct *mpnt,
> +					struct slm_isec_data *isec,
> +					struct slm_file_xattr *cur_level)
> +{
> +	unsigned long start =3D mpnt->vm_start;
> +	unsigned long end =3D mpnt->vm_end;
> +	size_t len =3D end - start;
> +
> +	if ((mpnt->vm_flags & (VM_WRITE | VM_MAYWRITE))
> +	    && (mpnt->vm_flags & VM_SHARED)
> +	    && (cur_level->iac_level < isec->level.iac_level))
> +		do_mprotect(start, len, PROT_READ);
> +}
> +
> +/*
> + * Revoke write permission to underlying mmap file (MAP_SHARED)
> + */
> +static void revoke_mmap_wperm(struct slm_file_xattr *cur_level)
> +{
> +	struct vm_area_struct *mpnt;
> +	struct file *file;
> +	struct dentry *dentry;
> +	struct slm_isec_data *isec;
> +
> +	flush_cache_mm(current->mm);

Is it a good idea to flush the cache before making the modifications?
Feels like the wrong order to me.

> +	down_write(&current->mm->mmap_sem);
> +	for (mpnt =3D current->mm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
> +		file =3D mpnt->vm_file;
> +		if (!file)
> +			continue;
> +
> +		dentry =3D file->f_dentry;
> +		if (!dentry || !dentry->d_inode)
> +			continue;
> +
> +		isec =3D dentry->d_inode->i_security;
> +		do_revoke_mmap_wperm(mpnt, isec, cur_level);
> +	}
> +	up_write(&current->mm->mmap_sem);
> +}
> +
> +/*
> + * Revoke write permissions and demote threads using shared memory
> + */
> +static void revoke_permissions(struct slm_file_xattr *cur_level)
> +{
> +	if (!is_kernel_thread(current)) {
> +		revoke_mmap_wperm(cur_level);
> +		revoke_file_wperm(cur_level);
> +	}
> +}
> +
> +static enum slm_iac_level set_iac(char *token)
> +{
> +	int iac;
> +
> +	if (strncmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) =3D=3D 0)
> +		return SLM_IAC_EXEMPT;
> +	for (iac =3D 0; iac < sizeof(slm_iac_str) / sizeof(char *); iac++) {
> +		if (strncmp(token, slm_iac_str[iac], strlen(slm_iac_str[iac]))
> +		    =3D=3D 0)
> +			return iac;
> +	}
> +	return SLM_IAC_ERROR;
> +}
> +
> +static enum slm_sac_level set_sac(char *token)
> +{
> +	int sac;
> +
> +	if (strncmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) =3D=3D 0)
> +		return SLM_SAC_EXEMPT;
> +	for (sac =3D 0; sac < sizeof(slm_sac_str) / sizeof(char *); sac++) {
> +		if (strncmp(token, slm_sac_str[sac], strlen(slm_sac_str[sac]))
> +		    =3D=3D 0)
> +			return sac;
> +	}
> +	return SLM_SAC_ERROR;
> +}
> +
> +static inline int set_bounds(char *token)
> +{
> +	if (strncmp(token, UNLIMITED_STR, strlen(UNLIMITED_STR)) =3D=3D 0)
> +		return 1;
> +	return 0;
> +}
> +
> +/*=20
> + * Get the 7 access class levels from the extended attribute=20
> + * Format: TIMESTAMP INTEGRITY SECRECY [INTEGRITY_GUARD INTEGRITY_GUARD]=
 [SECRECY_GUARD SECRECY_GUARD] [GUARD_ TYPE]
> + */
> +static int slm_parse_xattr(char *xattr_value, int xattr_len,
> +			   struct slm_file_xattr *level)
> +{
> +	char *token;
> +	int token_len;
> +	char *buf, *buf_end;
> +	int fieldno =3D 0;
> +	int rc =3D 0;
> +
> +	buf =3D xattr_value;
> +	buf_end =3D xattr_value + xattr_len;
> +
> +	while ((token =3D get_token(buf, buf_end, ' ', &token_len)) !=3D NULL) {
> +		buf =3D token + token_len;
> +		switch (++fieldno) {
> +		case 1:
> +			level->iac_level =3D set_iac(token);

set_iac() seems an odd name for a function parsing a string to return an
integer. Same with the other functions here..

> +			if (level->iac_level =3D=3D SLM_IAC_ERROR) {
> +				rc =3D -1;
> +				level->iac_level =3D SLM_IAC_UNTRUSTED;
> +			}
> +			break;
> +		case 2:
> +			level->sac_level =3D set_sac(token);
> +			if (level->sac_level =3D=3D SLM_SAC_ERROR) {
> +				rc =3D -1;
> +				level->sac_level =3D SLM_SAC_PUBLIC;
> +			}
> +			break;
> +		case 3:
> +			level->guard.iac_r =3D set_iac(token);
> +			if (level->guard.iac_r =3D=3D SLM_IAC_ERROR) {
> +				rc =3D -1;
> +				level->iac_level =3D SLM_IAC_UNTRUSTED;
> +			}
> +			break;
> +		case 4:
> +			level->guard.iac_wx =3D set_iac(token);
> +			if (level->guard.iac_wx =3D=3D SLM_IAC_ERROR) {
> +				rc =3D -1;
> +				level->iac_level =3D SLM_IAC_UNTRUSTED;
> +			}
> +			break;
> +		case 5:
> +			level->guard.unlimited =3D set_bounds(token);
> +			level->guard.sac_w =3D set_sac(token);
> +			if (level->guard.sac_w =3D=3D SLM_SAC_ERROR) {
> +				rc =3D -1;
> +				level->sac_level =3D SLM_SAC_PUBLIC;
> +			}
> +			break;
> +		case 6:
> +			level->guard.sac_rx =3D set_sac(token);
> +			if (level->guard.sac_rx =3D=3D SLM_SAC_ERROR) {
> +				rc =3D -1;
> +				level->sac_level =3D SLM_SAC_PUBLIC;
> +			}
> +			break;
> +		case 7:
> +			level->guard.unlimited =3D set_bounds(token);
> +		default:
> +			break;
> +		}
> +	}
> +	return rc;
> +}
> +
> +/*
> + *  Possible return codes:  INTEGRITY_PASS, INTEGRITY_FAIL, INTEGRITY_NO=
LABEL,
> + * 			 or -EINVAL
> + */
> +static int slm_get_xattr(struct dentry *dentry,
> +			 struct slm_file_xattr *level, int *status)
> +{
> +	int xattr_len;
> +	char *xattr_value =3D NULL;
> +	int rc, error =3D -EINVAL;
> +
> +	rc =3D integrity_verify_metadata(dentry, XATTR_NAME,
> +				       &xattr_value, &xattr_len, status);
> +	if (rc < 0) {
> +		if (rc !=3D -EOPNOTSUPP) {
> +			printk(KERN_INFO
> +				"%s integrity_verify_metadata failed "
> +				"(rc: %d - status: %d)\n",
> +			       dentry->d_name.name, rc, *status);
> +		}
> +		return rc;
> +	}
> +
> +	if (xattr_value) {
> +		memset(level, 0, sizeof(struct slm_file_xattr));
> +		error =3D slm_parse_xattr(xattr_value, xattr_len, level);
> +		kfree(xattr_value);
> +	}
> +
> +	if (level->iac_level !=3D SLM_IAC_UNTRUSTED) {
> +		rc =3D integrity_verify_data(dentry, status);
> +		if ((rc < 0) || (*status !=3D INTEGRITY_PASS)) {
> +			printk(KERN_INFO "%s integrity_verify_data failed "
> +			       " (rc: %d status: %d)\n", dentry->d_name.name,=20
> +				rc, *status);
> +			return rc;
> +		}
> +	}
> +
> +	if (error < 0)
> +		return -EINVAL;
> +	return rc;
> +}

slm_get_xattr() seems remarkably subtle given its name: *status can be
updated at two points in the function, a positive 'rc' from
integrity_verify_data() is left to return at the end, but negative 'rc'
values (that aren't -EOPNOTSUPP) get returned immediately, and if an
error variable is negative, a specific value is returned..

> +/* Caller responsible for necessary locking */
> +static inline void set_level(struct slm_file_xattr *level,
> +			     enum slm_iac_level iac, enum slm_sac_level sac)
> +{
> +	level->iac_level =3D iac;
> +	level->sac_level =3D sac;
> +}
> +static inline void set_level_exempt(struct slm_file_xattr *level)
> +{
> +	set_level(level, SLM_IAC_EXEMPT, SLM_SAC_EXEMPT);
> +}
> +
> +static inline void set_level_untrusted(struct slm_file_xattr *level)
> +{
> +	set_level(level, SLM_IAC_UNTRUSTED, SLM_SAC_PUBLIC);
> +}
> +
> +static inline void set_level_tsec_write(struct slm_file_xattr *level,
> +					struct slm_tsec_data *tsec)
> +{
> +	set_level(level, tsec->iac_wx, tsec->sac_w);
> +}
> +
> +static inline void set_level_tsec_read(struct slm_file_xattr *level,
> +				       struct slm_tsec_data *tsec)
> +{
> +	set_level(level, tsec->iac_r, tsec->sac_rx);
> +}
> +
> +static void get_sock_level(struct dentry *dentry, struct slm_file_xattr =
*level)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	int rc, status =3D 0;
> +
> +	rc =3D slm_get_xattr(dentry, level, &status);
> +	if (rc =3D=3D -EOPNOTSUPP)
> +		set_level_exempt(level);
> +	else
> +		set_level_tsec_read(level, cur_tsec);
> +}
> +
> +static void get_level(struct dentry *dentry, struct slm_file_xattr *leve=
l)
> +{
> +	int rc, status =3D 0;
> +
> +	rc =3D slm_get_xattr(dentry, level, &status);
> +	if (rc < 0) {
> +		switch (rc) {
> +		case -EOPNOTSUPP:
> +			set_level_exempt(level);
> +			break;
> +		case -EINVAL:	/* improperly formatted */
> +		default:
> +			set_level_untrusted(level);
> +			break;
> +		}
> +	} else {
> +		switch(status) {
> +			case INTEGRITY_FAIL:
> +			case INTEGRITY_NOLABEL:
> +				set_level_untrusted(level);
> +				break;
> +		}
> +	}
> +}

The complicated set of decision making in get_level() (which sets
levels, heh) might be simplified if slm_get_xattr() internals were
less complicated.

> +static struct slm_isec_data *slm_alloc_security(gfp_t flags)
> +{
> +	struct slm_isec_data *isec;
> +
> +	isec =3D kzalloc(sizeof(struct slm_isec_data), flags);
> +	if (!isec)
> +		return NULL;
> +
> +	spin_lock_init(&isec->lock);
> +	return isec;
> +}
> +
> +/*
> + * Exempt objects without extended attribute support
> + * for fastpath.  Others will be handled generically
> + * by the other functions.
> + */
> +static int is_exempt_fastpath(struct inode *inode)
> +{
> +	if ((inode->i_sb->s_magic =3D=3D PROC_SUPER_MAGIC)
> +	    || S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> +		return 1;
> +	return 0;
> +}
> +
> +/*
> + * All directories with xattr support should be labeled, but just in case
> + * recursively traverse path (dentry->parent) until level info is found.
> + */
> +static void slm_get_level(struct dentry *dentry, struct slm_file_xattr *=
level)
> +{
> +	struct inode *inode =3D dentry->d_inode;
> +	struct slm_isec_data *isec =3D inode->i_security;
> +
> +	if (is_isec_defined(isec)) {
> +		memcpy(level, &isec->level, sizeof(struct slm_file_xattr));
> +		return;
> +	}
> +
> +	memset(level, 0, sizeof(struct slm_file_xattr));
> +	if (is_exempt_fastpath(inode))
> +		set_level_exempt(level);
> +	else if (S_ISSOCK(inode->i_mode))
> +		get_sock_level(dentry, level);
> +	else
> +		get_level(dentry, level);
> +
> +	spin_lock(&isec->lock);
> +	memcpy(&isec->level, level, sizeof(struct slm_file_xattr));
> +	spin_unlock(&isec->lock);
> +}

No lock is required to read from isec->level, but a lock is required to
write to it. Does this make sense?

> +/*
> + * new tsk->security inherits from current->security
> + */
> +static struct slm_tsec_data *slm_init_task(struct task_struct *tsk, gfp_=
t flags)
> +{
> +	struct slm_tsec_data *tsec, *cur_tsec =3D current->security;
> +
> +	tsec =3D kzalloc(sizeof(struct slm_tsec_data), flags);
> +	if (!tsec)
> +		return NULL;
> +	tsec->lock =3D SPIN_LOCK_UNLOCKED;
> +	if (!cur_tsec) {
> +		tsec->iac_r =3D SLM_IAC_HIGHEST - 1;
> +		tsec->iac_wx =3D SLM_IAC_HIGHEST - 1;
> +		tsec->sac_w =3D SLM_SAC_NOTDEFINED + 1;
> +		tsec->sac_rx =3D SLM_SAC_NOTDEFINED + 1;
> +	} else
> +		memcpy(tsec, cur_tsec, sizeof(struct slm_tsec_data));
> +
> +	return tsec;
> +}
> +
> +static int is_iac_level_exempt(struct slm_file_xattr *level)
> +{
> +	if (level->iac_level =3D=3D SLM_IAC_EXEMPT)
> +		return 1;
> +	return 0;
> +}
> +
> +static int is_sac_level_exempt(struct slm_file_xattr *level)
> +{
> +	if (level->sac_level =3D=3D SLM_SAC_EXEMPT)
> +		return 1;
> +	return 0;
> +}
> +
> +static int is_iac_less_than_or_exempt(struct slm_file_xattr *level,
> +				      enum slm_iac_level iac)
> +{
> +	if (iac <=3D level->iac_level)
> +		return 1;
> +	return is_iac_level_exempt(level);
> +}
> +
> +static int is_iac_greater_than_or_exempt(struct slm_file_xattr *level,
> +					 enum slm_iac_level iac)
> +{
> +	if (iac >=3D level->iac_level)
> +		return 1;
> +	return is_iac_level_exempt(level);
> +}
> +
> +static int is_sac_less_than_or_exempt(struct slm_file_xattr *level,
> +				      enum slm_sac_level sac)
> +{
> +	if (sac <=3D level->sac_level)
> +		return 1;
> +	return is_sac_level_exempt(level);
> +}
> +
> +static int is_sac_greater_than_or_exempt(struct slm_file_xattr *level,
> +					 enum slm_sac_level sac)
> +{
> +	if (sac >=3D level->sac_level)
> +		return 1;
> +	return is_sac_level_exempt(level);
> +}
> +
> +/*
> + * enforce: IRAC(process) <=3D IAC(object)
> + * Permit process to read file of equal or greater integrity
> + * otherwise, demote the process.
> + */
> +static void enforce_integrity_read(struct slm_file_xattr *level)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +
> +	spin_lock(&cur_tsec->lock);
> +	if (!is_iac_less_than_or_exempt(level, cur_tsec->iac_r)) {
> +		/* Reading lower integrity, demote process */
> +		/* Even in the case of a integrity guard process. */
> +		cur_tsec->iac_r =3D level->iac_level;
> +		cur_tsec->iac_wx =3D level->iac_level;
> +		spin_unlock(&cur_tsec->lock);
> +
> +		revoke_permissions(level);
> +		return;
> +	}
> +	spin_unlock(&cur_tsec->lock);
> +}
> +
> +/*
> + * enforce: SRXAC(process) >=3D SAC(object)
> + * Permit process to read file of equal or lesser secrecy;
> + * otherwise, promote the process.
> + */
> +static void enforce_secrecy_read(struct slm_file_xattr *level)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +
> +	spin_lock(&cur_tsec->lock);
> +	if (!is_sac_greater_than_or_exempt(level, cur_tsec->sac_rx)) {
> +		/* Reading higher secrecy, promote process */
> +		/* Even in the case of a secrecy guard process. */
> +		cur_tsec->sac_rx =3D level->sac_level;
> +		cur_tsec->sac_w =3D level->sac_level;
> +		spin_unlock(&cur_tsec->lock);
> +
> +		/* Working item: revoke write permission to lower secrecy
> +		 * files. Prototyped but insufficiently tested for release
> +		 * current code will only allow authorized user to release
> +		 * sensitive data */
> +		return;
> +	}
> +	spin_unlock(&cur_tsec->lock);
> +}
> +
> +static void do_task_may_read(struct slm_file_xattr *level)
> +{
> +	enforce_integrity_read(level);
> +	enforce_secrecy_read(level);
> +}
> +
> +/*
> + * enforce: IWXAC(process) >=3D IAC(object)
> + * Permit process to write a file of equal or lesser integrity.
> + */
> +static int enforce_integrity_write(struct slm_file_xattr *level)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	int rc =3D 0;
> +
> +	spin_lock(&cur_tsec->lock);
> +	if (!(is_iac_greater_than_or_exempt(level, cur_tsec->iac_wx)
> +	      || (level->iac_level =3D=3D SLM_IAC_NOTDEFINED)))
> +		/* can't write higher integrity */
> +		rc =3D -EACCES;
> +	spin_unlock(&cur_tsec->lock);
> +	return rc;
> +}
> +
> +/*
> + * enforce: SWAC(process) <=3D SAC(process)
> + * Permit process to write a file of equal or greater secrecy
> + */
> +static int enforce_secrecy_write(struct slm_file_xattr *level)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	int rc =3D 0;
> +
> +	spin_lock(&cur_tsec->lock);
> +	if (!is_sac_less_than_or_exempt(level, cur_tsec->sac_w))
> +		/* can't write lower secrecy */
> +		rc =3D -EACCES;
> +	spin_unlock(&cur_tsec->lock);
> +	return rc;
> +}
> +
> +static int do_task_may_write(struct slm_file_xattr *level)
> +{
> +	int rc;
> +
> +	rc =3D enforce_integrity_write(level);
> +	if (rc < 0)
> +		return rc;
> +
> +	return enforce_secrecy_write(level);
> +}
> +
> +static int slm_set_taskperm(int mask, struct slm_file_xattr *level)
> +{
> +	int rc =3D 0;
> +
> +	if (mask & MAY_READ)
> +		do_task_may_read(level);
> +	if ((mask & MAY_WRITE) || (mask & MAY_APPEND))
> +		rc =3D do_task_may_write(level);
> +
> +	return rc;
> +}
> +
> +/*
> + * file changes invalidate isec=20
> + */
> +static int slm_file_permission(struct file *file, int mask)
> +{
> +	struct slm_isec_data *isec =3D file->f_dentry->d_inode->i_security;
> +
> +	if (((mask & MAY_WRITE) || (mask & MAY_APPEND)) && isec) {
> +		spin_lock(&isec->lock);
> +		isec->level.iac_level =3D SLM_IAC_NOTDEFINED;
> +		spin_unlock(&isec->lock);
> +	}
> +	return 0;
> +}
> +
> +static int is_untrusted_blk_access(struct inode *inode)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	int rc =3D 0;
> +
> +	spin_lock(&cur_tsec->lock);
> +	if (cur_tsec && (cur_tsec->iac_wx =3D=3D SLM_IAC_UNTRUSTED)
> +	    && S_ISBLK(inode->i_mode))
> +		rc =3D 1;
> +	spin_unlock(&cur_tsec->lock);
> +	return rc;
> +}
> +
> +/*
> + * Premise:
> + * Can't write or execute higher integrity, can't read lower integrity
> + * Can't read or execute higher secrecy, can't write lower secrecy
> + */
> +static int slm_inode_permission(struct inode *inode, int mask,
> +				struct nameidata *nd)
> +{
> +	struct dentry *dentry =3D NULL;
> +	struct slm_file_xattr level;
> +
> +	if (S_ISDIR(inode->i_mode) && (mask & MAY_WRITE))
> +		return 0;
> +
> +	dentry =3D (!nd || !nd->dentry) ? d_find_alias(inode) : nd->dentry;
> +	if (!dentry)
> +		return 0;
> +
> +	if (is_untrusted_blk_access(inode))
> +		return -EPERM;
> +
> +	slm_get_level(dentry, &level);
> +
> +	/* measure all SYSTEM level integrity objects */
> +	if (level.iac_level =3D=3D SLM_IAC_SYSTEM)
> +		integrity_measure(dentry, NULL, mask);
> +
> +	return slm_set_taskperm(mask, &level);
> +}
> +
> +/*=20
> + * This hook is called holding the inode mutex.
> + */
> +static int slm_inode_unlink(struct inode *dir, struct dentry *dentry)
> +{
> +	struct slm_file_xattr level;
> +
> +	if (!dentry || !dentry->d_name.name)
> +		return 0;
> +
> +	slm_get_level(dentry, &level);
> +	return slm_set_taskperm(MAY_WRITE, &level);
> +}
> +
> +static void slm_inode_free_security(struct inode *inode)
> +{
> +	struct slm_isec_data *isec =3D inode->i_security;
> +
> +	inode->i_security =3D NULL;
> +	kfree(isec);
> +}
> +
> +/*
> + * Check integrity permission to create a regular file.
> + */
> +static int slm_inode_create(struct inode *parent_dir,
> +			    struct dentry *dentry, int mask)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	struct slm_isec_data *parent_isec =3D parent_dir->i_security;
> +	struct slm_file_xattr *parent_level =3D &parent_isec->level;
> +	int rc =3D 0;
> +
> +	/*
> +	 * enforce: IWXAC(process) >=3D IAC(object)
> +	 * Permit process to write a file of equal or lesser integrity.
> +	 */
> +	spin_lock(&cur_tsec->lock);
> +	spin_lock(&parent_isec->lock);
> +	if (!is_iac_greater_than_or_exempt(parent_level, cur_tsec->iac_wx))
> +		rc =3D -EPERM;
> +	spin_unlock(&parent_isec->lock);
> +	spin_unlock(&cur_tsec->lock);
> +	return rc;
> +}
> +
> +#define MAX_XATTR_SIZE 76
> +
> +static int slm_set_xattr(struct slm_file_xattr *level,
> +			 char **name, void **value, size_t * value_len)
> +{
> +	int len;
> +	int xattr_len;
> +	char buf[MAX_XATTR_SIZE];
> +	char *bufp =3D buf;
> +	char *xattr_val =3D buf;
> +	char *xattr_name;
> +
> +	if (!level)
> +		return 0;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	if (is_iac_level_exempt(level)) {
> +		memcpy(bufp, EXEMPT_STR, strlen(EXEMPT_STR));
> +		bufp +=3D strlen(EXEMPT_STR);
> +	} else {
> +		len =3D strlen(slm_iac_str[level->iac_level]);
> +		memcpy(bufp, slm_iac_str[level->iac_level], len);
> +		bufp +=3D len;
> +	}
> +	*bufp++ =3D ' ';
> +	if (is_sac_level_exempt(level)) {
> +		memcpy(bufp, EXEMPT_STR, strlen(EXEMPT_STR));
> +		bufp +=3D strlen(EXEMPT_STR);
> +	} else {
> +		len =3D strlen(slm_sac_str[level->sac_level]);
> +		memcpy(bufp, slm_sac_str[level->sac_level], len);
> +		bufp +=3D len;
> +	}
> +	xattr_len =3D bufp - buf;
> +
> +	/* point after 'security.' */
> +	xattr_name =3D strchr(XATTR_NAME, '.');
> +	if (xattr_name)
> +		*name =3D kstrdup(xattr_name + 1, GFP_KERNEL);
> +	*value =3D kmalloc(xattr_len + 1, GFP_KERNEL);
> +	if (!*value) {
> +		kfree(name);
> +		return -ENOMEM;
> +	}
> +	memcpy(*value, xattr_val, xattr_len);
> +	*value_len =3D xattr_len;
> +	return 0;
> +}
> +
> +/* Create the security.slim.level extended attribute */
> +static int slm_inode_init_security(struct inode *inode, struct inode *di=
r,
> +				   char **name, void **value, size_t * len)
> +{
> +	struct slm_isec_data *isec =3D inode->i_security, *parent_isec =3D
> +	    dir->i_security;
> +	struct slm_tsec_data *cur_tsec =3D current->security;
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
> +		    && (cur_tsec->iac_wx !=3D cur_tsec->iac_r))
> +			set_level_exempt(&level);
> +		else
> +			set_level_tsec_write(&level, cur_tsec);
> +	}
> +
> +	/* if a guard process creates a UNIX socket, then EXEMPT it */
> +	if (S_ISSOCK(inode->i_mode)
> +	    && (cur_tsec->iac_wx !=3D cur_tsec->iac_r))
> +		set_level_exempt(&level);
> +	spin_unlock(&cur_tsec->lock);
> +
> +	spin_lock(&isec->lock);
> +	memcpy(&isec->level, &level, sizeof(struct slm_file_xattr));
> +	spin_unlock(&isec->lock);
> +
> +	data =3D kmalloc(sizeof(struct xattr_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* set levels, based on parent */
> +	rc =3D slm_set_xattr(&level, &data->name, &data->value, &data->len);
> +	if (rc < 0)
> +		return rc;

if the slm_set_xattr() fails, should data be freed?
>=20
> +	*name =3D data->name;
> +	*value =3D data->value;
> +	*len =3D data->len;
> +	return 0;
> +}
> +
> +static void slm_d_instantiate(struct dentry *dentry, struct inode *inode)
> +{
> +	struct slm_isec_data *isec;
> +	struct slm_file_xattr level;
> +
> +	if (!inode)
> +		return;
> +=20
> +	isec =3D inode->i_security;
> +	if (is_exempt_fastpath(inode)) {
> +		memset(&level, 0, sizeof(struct slm_file_xattr));
> +		set_level_exempt(&level);
> +	} else if (S_ISSOCK(inode->i_mode))
> +		memset(&level, 0, sizeof(struct slm_file_xattr));
> +	else
> +		get_level(dentry, &level);
> +
> +	spin_lock(&isec->lock);
> +	memcpy(&isec->level, &level, sizeof(struct slm_file_xattr));
> +	spin_unlock(&isec->lock);
> +}
> +
> +/*
> + * Check permissions to create a new directory in the existing directory
> + * associated with inode structure @dir.
> + */
> +static int slm_inode_mkdir(struct inode *parent_dir,
> +			   struct dentry *dentry, int mask)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	struct slm_isec_data *parent_isec =3D parent_dir->i_security;
> +	struct slm_file_xattr *parent_level =3D &parent_isec->level;
> +	int rc =3D 0;
> +
> +	spin_lock(&cur_tsec->lock);
> +	spin_lock(&parent_isec->lock);
> +	if (cur_tsec->iac_wx < parent_level->iac_level
> +	    && parent_level->iac_level =3D=3D SLM_IAC_SYSTEM)
> +		rc =3D -EACCES;
> +	spin_unlock(&parent_isec->lock);
> +	spin_unlock(&cur_tsec->lock);
> +	return rc;
> +}
> +
> +static int slm_inode_rename(struct inode *old_dir,
> +			    struct dentry *old_dentry,
> +			    struct inode *new_dir, struct dentry *new_dentry)
> +{
> +	struct slm_file_xattr old_level, parent_level;
> +	struct dentry *parent_dentry;
> +
> +	if (old_dir =3D=3D new_dir)
> +		return 0;
> +
> +	slm_get_level(old_dentry, &old_level);
> +
> +	parent_dentry =3D dget_parent(new_dentry);
> +	slm_get_level(parent_dentry, &parent_level);
> +	dput(parent_dentry);
> +
> +	if (is_lower_integrity(&old_level, &parent_level))
> +		return -EPERM;
> +	return 0;
> +}
> +
> +/*
> + * Limit the integrity value of an object to be no greater than that
> + * of the current process. This is especially important for objects
> + * being promoted.
> +*/
> +int slm_inode_setxattr(struct dentry *dentry, char *name, void *value,
> +		       size_t size, int flags)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	char *data =3D value;
> +	enum slm_iac_level iac;
> +
> +	if (strncmp(name, XATTR_NAME, strlen(XATTR_NAME)) !=3D 0)
> +		return 0;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	spin_lock(&cur_tsec->lock);
> +	iac =3D cur_tsec->iac_wx;
> +	spin_unlock(&cur_tsec->lock);
> +
> +	switch (iac) {
> +	case SLM_IAC_USER:
> +		if ((strncmp(data, USER_STR, strlen(USER_STR)) !=3D 0) &&
> +		    (strncmp(data, UNTRUSTED_STR, strlen(UNTRUSTED_STR)) !=3D 0))
> +			return -EPERM;
> +		break;
> +	case SLM_IAC_SYSTEM:
> +		if ((strncmp(data, SYSTEM_STR, strlen(SYSTEM_STR)) !=3D 0) &&
> +		    (strncmp(data, USER_STR, strlen(USER_STR)) !=3D 0) &&
> +		    (strncmp(data, UNTRUSTED_STR, strlen(UNTRUSTED_STR)) !=3D 0)
> +		    && (strncmp(data, EXEMPT_STR, strlen(EXEMPT_STR)) !=3D 0))
> +			return -EPERM;
> +		break;
> +	default:
> +		return -EPERM;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * SLIM extended attribute was modified, update isec.
> + */
> +static void slm_inode_post_setxattr(struct dentry *dentry, char *name,
> +				    void *value, size_t size, int flags)
> +{
> +	struct slm_isec_data *slm_isec;
> +	struct slm_file_xattr level;
> +	int rc, status =3D 0;
> +
> +	if (strncmp(name, XATTR_NAME, strlen(XATTR_NAME)) !=3D 0)
> +		return;
> +
> +	rc =3D slm_get_xattr(dentry, &level, &status);
> +	slm_isec =3D dentry->d_inode->i_security;
> +	spin_lock(&slm_isec->lock);
> +	memcpy(&slm_isec->level, &level, sizeof(struct slm_file_xattr));
> +	spin_unlock(&slm_isec->lock);
> +}
> +
> +static int slm_inode_removexattr(struct dentry *dentry, char *name)
> +{
> +	struct slm_isec_data *isec =3D dentry->d_inode->i_security;
> +	struct slm_tsec_data *tsec =3D current->security;
> +	enum slm_iac_level iac;
> +	int rc =3D 0;
> +
> +	if (strncmp(name, XATTR_NAME, strlen(XATTR_NAME)) !=3D 0)
> +		return 0;
> +
> +	if (isec) {
> +		spin_lock(&tsec->lock);
> +		iac =3D tsec->iac_wx;
> +		spin_unlock(&tsec->lock);
> +
> +		spin_lock(&isec->lock);
> +		switch(iac) {
> +		case SLM_IAC_SYSTEM:
> +			isec->level.iac_level =3D SLM_IAC_NOTDEFINED;
> +			break;
> +		case SLM_IAC_USER:
> +			if (isec->level.iac_level < SLM_IAC_NOTDEFINED ||
> +			    isec->level.iac_level > SLM_IAC_USER)
> +				rc =3D -EPERM;
> +			else
> +				isec->level.iac_level =3D SLM_IAC_NOTDEFINED;
> +			break;
> +		default:
> +			rc =3D -EPERM;
> +		}
> +		spin_unlock(&isec->lock);
> +	}
> +	return rc;
> +}
> +
> +static int slm_inode_alloc_security(struct inode *inode)
> +{
> +	struct slm_isec_data *isec =3D slm_alloc_security(GFP_KERNEL);
> +	if (!isec)
> +		return -ENOMEM;
> +
> +	inode->i_security =3D isec;
> +	return 0;
> +}
> +
> +/*
> + * Opening a socket demotes the integrity of a process to untrusted.
> + */
> +int slm_socket_create(int family, int type, int protocol, int kern)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	struct slm_file_xattr level;
> +
> +	/* demoting only internet sockets */
> +	if ((family !=3D AF_UNIX) && (family !=3D AF_NETLINK)) {

Comment doesn't really match the test..

> +		spin_lock(&cur_tsec->lock);
> +		if (cur_tsec->iac_r > SLM_IAC_UNTRUSTED) {
> +			cur_tsec->iac_r =3D SLM_IAC_UNTRUSTED;
> +			cur_tsec->iac_wx =3D SLM_IAC_UNTRUSTED;
> +			spin_unlock(&cur_tsec->lock);
> +
> +			memset(&level, 0, sizeof(struct slm_file_xattr));
> +			level.iac_level =3D SLM_IAC_UNTRUSTED;
> +
> +			revoke_permissions(&level);
> +			return 0;
> +		}
> +		spin_unlock(&cur_tsec->lock);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Didn't have the family type previously, so update the inode security =
now.
> + */
> +static void slm_socket_post_create(struct socket *sock, int family,
> +				   int type, int protocol, int kern)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	struct inode *inode =3D SOCK_INODE(sock);
> +	struct slm_isec_data *slm_isec =3D inode->i_security;
> +
> +	spin_lock(&slm_isec->lock);
> +	if (family =3D=3D PF_UNIX) {
> +		if (cur_tsec->iac_wx !=3D cur_tsec->iac_r)	/* guard process */
> +			set_level_exempt(&slm_isec->level);
> +		else
> +			set_level_tsec_write(&slm_isec->level, cur_tsec);
> +	} else
> +		set_level_untrusted(&slm_isec->level);
> +	spin_unlock(&slm_isec->lock);
> +}
> +
> +/*
> + * When a task gets allocated, it inherits the current IAC and SAC.
> + * Set the values and store them in p->security.
> + */
> +static int slm_task_alloc_security(struct task_struct *tsk)
> +{
> +	struct slm_tsec_data *tsec =3D tsk->security;
> +
> +	if (!tsec) {
> +		tsec =3D slm_init_task(tsk, GFP_KERNEL);
> +		if (!tsec)
> +			return -ENOMEM;
> +	}
> +	tsk->security =3D tsec;
> +	return 0;
> +}
> +
> +static void slm_task_free_security(struct task_struct *tsk)
> +{
> +	struct slm_tsec_data *tsec;
> +
> +	tsec =3D tsk->security;
> +	tsk->security =3D NULL;
> +	kfree(tsec);
> +}
> +
> +/* init_task is an integrity guard */
> +static int slm_task_init_alloc_security(struct task_struct *tsk)
> +{
> +	struct slm_tsec_data *tsec =3D kzalloc(sizeof(struct slm_tsec_data), GF=
P_KERNEL);
> +
> +	if (!tsec)
> +		return -ENOMEM;
> +
> +	tsec->lock =3D SPIN_LOCK_UNLOCKED;
> +
> +	tsec->iac_r =3D SLM_IAC_UNTRUSTED;
> +	tsec->iac_wx =3D SLM_IAC_SYSTEM;
> +	tsec->sac_w =3D SLM_SAC_PUBLIC;
> +	tsec->sac_rx =3D SLM_SAC_PUBLIC;
> +
> +	tsec->unlimited =3D 1;
> +
> +	tsk->security =3D tsec;
> +	return 0;
> +}
> +
> +static int slm_task_post_setuid(uid_t old_ruid, uid_t old_euid,
> +				uid_t old_suid, int flags)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +
> +	if (cur_tsec && flags =3D=3D LSM_SETID_ID) {
> +		/*set process to USER level integrity for everything but root */
> +		spin_lock(&cur_tsec->lock);
> +		if ((cur_tsec->iac_r =3D=3D cur_tsec->iac_wx)
> +		    && (cur_tsec->iac_r =3D=3D SLM_IAC_UNTRUSTED));
> +		else if (current->suid !=3D 0) {
> +			cur_tsec->iac_r =3D SLM_IAC_USER;
> +			cur_tsec->iac_wx =3D SLM_IAC_USER;
> +		} else if ((current->uid =3D=3D 0) && (old_ruid !=3D 0)) {
> +			cur_tsec->iac_r =3D SLM_IAC_SYSTEM;
> +			cur_tsec->iac_wx =3D SLM_IAC_SYSTEM;
> +		}
> +		spin_unlock(&cur_tsec->lock);
> +	}
> +	return 0;
> +}
> +
> +static inline int slm_setprocattr(struct task_struct *tsk,
> +				  char *name, void *value, size_t size)
> +{
> +	return -EACCES;
> +
> +}
> +
> +static inline int slm_getprocattr(struct task_struct *tsk,
> +				  char *name, void *value, size_t size)
> +{
> +	struct slm_tsec_data *tsec =3D tsk->security;
> +	size_t len =3D 0;
> +
> +	if (is_kernel_thread(tsk))
> +		len =3D snprintf(value, size, "KERNEL");
> +	else {
> +		spin_lock(&tsec->lock);
> +		if (tsec->iac_wx !=3D tsec->iac_r)
> +			len =3D snprintf(value, size, "GUARD wx:%s r:%s",
> +				       slm_iac_str[tsec->iac_wx],
> +				       slm_iac_str[tsec->iac_r]);
> +		else
> +			len =3D snprintf(value, size, "%s",
> +				       slm_iac_str[tsec->iac_wx]);
> +		spin_unlock(&tsec->lock);
> +	}
> +	return min(len, size);
> +}
> +
> +/*
> + * enforce: IWXAC(process) <=3D IAC(object)
> + * Permit process to execute file of equal or greater integrity
> + */
> +static void enforce_integrity_execute(struct linux_binprm *bprm,
> +				      struct slm_file_xattr *level,
> +				      struct slm_tsec_data *cur_tsec)
> +{
> +	spin_lock(&cur_tsec->lock);
> +	if (is_iac_less_than_or_exempt(level, cur_tsec->iac_wx))
> +		/* Being a guard process is not inherited */
> +		cur_tsec->iac_r =3D cur_tsec->iac_wx;
> +	else {
> +		cur_tsec->iac_r =3D level->iac_level;
> +		cur_tsec->iac_wx =3D level->iac_level;
> +		spin_unlock(&cur_tsec->lock);
> +
> +		revoke_permissions(level);
> +		return;
> +	}
> +	spin_unlock(&cur_tsec->lock);
> +}
> +
> +static void enforce_guard_integrity_execute(struct linux_binprm *bprm,
> +					    struct slm_file_xattr *level,
> +					    struct slm_tsec_data *cur_tsec)
> +{
> +	if ((strcmp(bprm->filename, bprm->interp) !=3D 0)
> +	    && (level->guard.unlimited))
> +		level->guard.unlimited =3D 0;
> +
> +	spin_lock(&cur_tsec->lock);
> +	if (level->guard.unlimited) {
> +		cur_tsec->iac_r =3D level->guard.iac_r;
> +		cur_tsec->iac_wx =3D level->guard.iac_wx;
> +	} else {
> +		if (cur_tsec->iac_r > level->guard.iac_r)
> +			cur_tsec->iac_r =3D level->guard.iac_r;
> +		if (cur_tsec->iac_wx > level->guard.iac_wx)
> +			cur_tsec->iac_wx =3D level->guard.iac_wx;
> +	}
> +	spin_unlock(&cur_tsec->lock);
> +}
> +
> +/*
> + * enforce: SRXAC(process) >=3D SAC(object)
> + * Permit process to execute file of equal or lesser secrecy
> + */
> +static void enforce_secrecy_execute(struct linux_binprm *bprm,
> +				    struct slm_file_xattr *level,
> +				    struct slm_tsec_data *cur_tsec)
> +{
> +	spin_lock(&cur_tsec->lock);
> +	if (is_sac_greater_than_or_exempt(level, cur_tsec->sac_rx))
> +		/* Being a guard process is not inherited */
> +		cur_tsec->sac_w =3D cur_tsec->sac_rx;
> +	else {
> +		cur_tsec->sac_rx =3D level->sac_level;
> +		cur_tsec->sac_w =3D level->sac_level;
> +
> +		/* Working item: revoke write permission to lower secrecy
> +		 * files. Prototyped but insufficiently tested for release
> +		 * current code will only allow authorized user to release
> +		 * sensitive data */
> +	}
> +	spin_unlock(&cur_tsec->lock);
> +}
> +
> +static void enforce_guard_secrecy_execute(struct linux_binprm *bprm,
> +					  struct slm_file_xattr *level,
> +					  struct slm_tsec_data *cur_tsec)
> +{
> +	/*
> +	 * set low write secrecy range,
> +	 *      not less than current value, prevent leaking data
> +	 */
> +	spin_lock(&cur_tsec->lock);
> +	cur_tsec->sac_w =3D max(cur_tsec->sac_w, level->guard.sac_w);
> +	/* limit secrecy range, never demote secrecy */
> +	cur_tsec->sac_rx =3D max(cur_tsec->sac_rx, level->guard.sac_rx);
> +	spin_unlock(&cur_tsec->lock);
> +}
> +
> +/*
> + * Enforce process integrity & secrecy levels.
> + * 	- update integrity process level of integrity guard program
> + * 	- update secrecy process level of secrecy guard program
> + */
> +static int slm_bprm_check_security(struct linux_binprm *bprm)
> +{
> +	struct dentry *dentry;
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	struct slm_file_xattr level;
> +	int rc, status;
> +
> +	/* Special case interpreters */
> +	spin_lock(&cur_tsec->lock);
> +	if (strcmp(bprm->filename, bprm->interp) !=3D 0) {
> +		if (!cur_tsec->script_dentry) {
> +			spin_unlock(&cur_tsec->lock);
> +			return 0;
> +		} else
> +			dentry =3D cur_tsec->script_dentry;
> +	} else {
> +		dentry =3D bprm->file->f_dentry;
> +		cur_tsec->script_dentry =3D dentry;
> +	}
> +	spin_unlock(&cur_tsec->lock);
> +
> +	slm_get_level(dentry, &level);
> +
> +	/* slm_inode_permission measured all SYSTEM level integrity objects */
> +	if (level.iac_level !=3D SLM_IAC_SYSTEM)
> +		integrity_measure(dentry, bprm->filename, MAY_EXEC);
> +
> +	/* Possible return codes: PERMIT, DENY, NOLABEL */
> +	rc =3D integrity_verify_data(dentry, &status);
> +	if (rc < 0)
> +		return rc;
> +
> +	switch(status) {
> +	case INTEGRITY_FAIL:
> +		if (!is_kernel_thread(current))
> +			return -EACCES;
> +	case INTEGRITY_NOLABEL:
> +		level.iac_level =3D SLM_IAC_UNTRUSTED;
> +		level.sac_level =3D SLM_SAC_PUBLIC;
> +	}
> +
> +	enforce_integrity_execute(bprm, &level, cur_tsec);
> +	if (is_guard_integrity(&level))
> +		enforce_guard_integrity_execute(bprm, &level, cur_tsec);
> +
> +	enforce_secrecy_execute(bprm, &level, cur_tsec);
> +	if (is_guard_secrecy(&level))
> +		enforce_guard_secrecy_execute(bprm, &level, cur_tsec);
> +
> +	return 0;
> +}
> +
> +static int slm_inode_setattr(struct dentry *dentry, struct iattr *iattr)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	struct slm_file_xattr level;
> +	int rc =3D 0;
> +
> +	slm_get_level(dentry, &level);
> +	spin_lock(&cur_tsec->lock);
> +	if (cur_tsec->iac_wx < level.iac_level)
> +			rc =3D -EACCES;
> +	spin_unlock(&cur_tsec->lock);
> +	return rc;
> +}
> +
> +static inline int slm_capable(struct task_struct *tsk, int cap)
> +{
> +	struct slm_tsec_data *tsec =3D tsk->security;
> +	int rc =3D 0;
> +
> +	/* Derived from include/linux/sched.h:capable. */
> +	if (cap_raised(tsk->cap_effective, cap)) {
> +		spin_lock(&tsec->lock);
> +		if (tsec->iac_wx =3D=3D SLM_IAC_UNTRUSTED &&
> +		    cap =3D=3D CAP_SYS_ADMIN)
> +			rc =3D -EACCES;

Why is CAP_SYS_ADMIN handled specially?

> +		spin_unlock(&tsec->lock);
> +		return rc;
> +	}
> +	return -EPERM;
> +}
> +
> +static int slm_ptrace(struct task_struct *parent, struct task_struct *ch=
ild)
> +{
> +	struct slm_tsec_data *parent_tsec =3D parent->security,
> +	    *child_tsec =3D child->security;
> +	int rc =3D 0;
> +
> +	if (is_kernel_thread(parent) || is_kernel_thread(child))
> +		return 0;

Why was this added?

> +	spin_lock(&parent_tsec->lock);
> +	if (parent_tsec->iac_wx < child_tsec->iac_wx)
> +		rc =3D -EPERM;
> +	spin_unlock(&parent_tsec->lock);
> +	return rc;
> +}
> +
> +static int slm_shm_alloc_security(struct shmid_kernel *shp)
> +{
> +	struct slm_tsec_data *cur_tsec =3D current->security;
> +	struct kern_ipc_perm *perm =3D &shp->shm_perm;
> +	struct slm_isec_data *isec =3D slm_alloc_security(GFP_KERNEL);
> +
> +	if (!isec)
> +		return -ENOMEM;
> +
> +	spin_lock(&cur_tsec->lock);
> +	if (cur_tsec->iac_wx !=3D cur_tsec->iac_r)	/* guard process */
> +		set_level_exempt(&isec->level);
> +	else
> +		set_level_tsec_write(&isec->level, cur_tsec);
> +	spin_unlock(&cur_tsec->lock);
> +	perm->security =3D isec;
> +
> +	return 0;
> +}
> +
> +static void slm_shm_free_security(struct shmid_kernel *shp)
> +{
> +	struct kern_ipc_perm *perm =3D &shp->shm_perm;
> +	struct slm_isec_data *isec =3D perm->security;
> +
> +	perm->security =3D NULL;
> +	kfree(isec);
> +}
> +
> +/*
> + *  When shp exists called holding perm->lock
> + */
> +static int slm_shm_shmctl(struct shmid_kernel *shp, int cmd)
> +{
> +	struct kern_ipc_perm *perm;
> +	struct slm_isec_data *perm_isec;
> +	struct file *file;
> +	struct dentry *dentry;
> +	struct inode *inode;
> +	int rc;
> +
> +	if (!shp)
> +		return 0;
> +
> +	perm =3D &shp->shm_perm;
> +	perm_isec =3D perm->security;
> +	file =3D shp->shm_file;
> +	dentry =3D file->f_dentry;
> +	inode =3D dentry->d_inode;
> +
> +	spin_lock(&perm_isec->lock);
> +	rc =3D slm_set_taskperm(MAY_READ | MAY_WRITE, &perm_isec->level);
> +	spin_unlock(&perm_isec->lock);
> +	return rc;
> +}
> +
> +/*
> + * Called holding perm->lock
> + */
> +static int slm_shm_shmat(struct shmid_kernel *shp,
> +			 char __user * shmaddr, int shmflg)
> +{
> +	int mask =3D MAY_READ;
> +	int rc;
> +	struct kern_ipc_perm *perm =3D &shp->shm_perm;
> +	struct file *file =3D shp->shm_file;
> +	struct dentry *dentry =3D file->f_dentry;
> +	struct inode *inode =3D dentry->d_inode;
> +	struct slm_isec_data *perm_isec =3D perm->security,
> +	    *isec =3D inode->i_security;
> +
> +	if (shmflg !=3D SHM_RDONLY)
> +		mask |=3D MAY_WRITE;
> +
> +	spin_lock(&perm_isec->lock);
> +	rc =3D slm_set_taskperm(mask, &perm_isec->level);
> +
> +	spin_lock(&isec->lock);
> +	memcpy(&isec->level, &perm_isec->level, sizeof(struct slm_file_xattr));
> +	spin_unlock(&perm_isec->lock);
> +	spin_unlock(&isec->lock);
> +
> +	return rc;
> +}
> +
> +static struct security_operations slm_security_ops =3D {
> +	.bprm_check_security =3D slm_bprm_check_security,
> +	.file_permission =3D slm_file_permission,
> +	.inode_permission =3D slm_inode_permission,
> +	.inode_unlink =3D slm_inode_unlink,
> +	.inode_create =3D slm_inode_create,
> +	.inode_mkdir =3D slm_inode_mkdir,
> +	.inode_rename =3D slm_inode_rename,
> +	.inode_setattr =3D slm_inode_setattr,
> +	.inode_setxattr =3D slm_inode_setxattr,
> +	.inode_post_setxattr =3D slm_inode_post_setxattr,
> +	.inode_removexattr =3D slm_inode_removexattr,
> +	.inode_alloc_security =3D slm_inode_alloc_security,
> +	.inode_free_security =3D slm_inode_free_security,
> +	.inode_init_security =3D slm_inode_init_security,
> +	.socket_create =3D slm_socket_create,
> +	.socket_post_create =3D slm_socket_post_create,
> +	.task_alloc_security =3D slm_task_alloc_security,
> +	.task_free_security =3D slm_task_free_security,
> +	.task_init_alloc_security =3D slm_task_init_alloc_security,
> +	.task_post_setuid =3D slm_task_post_setuid,
> +	.capable =3D slm_capable,
> +	.ptrace =3D slm_ptrace,
> +	.shm_alloc_security =3D slm_shm_alloc_security,
> +	.shm_free_security =3D slm_shm_free_security,
> +	.shm_shmat =3D slm_shm_shmat,
> +	.shm_shmctl =3D slm_shm_shmctl,
> +	.getprocattr =3D slm_getprocattr,
> +	.setprocattr =3D slm_setprocattr,
> +	.d_instantiate =3D slm_d_instantiate
> +};
> +
> +static int __init init_slm(void)
> +{
> +	current->security =3D slm_init_task(current, GFP_ATOMIC);
> +	return register_security(&slm_security_ops);
> +}
> +security_initcall(init_slm);

Thanks

--IuxWNXB0+C4YKz9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFE5RTF+9nuM9mwoJkRAkNCAJwMZ0hUs7aOHUWVkDRZ+ZGGY3UCTQCdEBcq
5Dkrvcx3EPWr+kkE420Nsto=
=hah6
-----END PGP SIGNATURE-----

--IuxWNXB0+C4YKz9o--
