Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWGNRZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWGNRZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWGNRYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:24:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15596 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422657AbWGNRYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:24:35 -0400
Subject: [RFC][PATCH 3/6] SLIM main patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 10:24:38 -0700
Message-Id: <1152897878.23584.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SLIM is an LSM module which provides an enhanced low water-mark
integrity and high water-mark secrecy mandatory access control
model.

For simplicity, this version:
	- does not require stacker
	- uses the integrity service (dummy provider)

Major fixes based on prior review comments:
	- addition of ptrace and shared memory (shm) controls
	- addition of generic revocation support
	- proper use of d_instantiate

SLIM now performs a generic revocation operation, including revoking
mmap and shared memory access. Note that during demotion or promotion
of a process, SLIM needs only revoke write access to files with higher
integrity, or lower secrecy. Read and execute permissions are blocked
as needed, not revoked.  SLIM hopefully uses d_instantiate correctly now.

SLIM inherently deals with dynamic labels, which is a feature not
currently available in selinux. While it might be possible to
add support for this to selinux, it would not appear to be simple,
and it is not clear if the added complexity would be desirable
just to support this one model. (Isn't choice what LSM is all about? :-)

Comments on the model:

Some of the prior comments questioned the usefulness of the
low water-mark model itself. Two major questions raised concerned
a potential progression of the entire system to a fully demoted
state, and the security issues surrounding the guard processes.

In normal operation, the system seems to stabilize with a roughly
equal mixture of SYSTEM, USER, and UNTRUSTED processes. Most
applications seem to do a fixed set of operations in a fixed domain,
and stabilize at their appropriate level. Some applications, like
firefox and evolution, which inherently deal with untrusted data,
immediately go to the UNTRUSTED level, which is where they belong.
In a couple of cases, including cups and Notes, the applications
did not handle their demotions well, as they occured well into their
startup. For these applications, we simply force them to start up
as UNTRUSTED, so demotion is not an issue. The one application
that does tend to get demoted over time are shells, such as bash.
These are not problems, as new ones can be created with the
windowing system, or with su, as needed. To help with the associated
user interface issue, the user space package README shows how to
display the SLIM level in window titles, so it is always clear at
what level the process is currently running.

As for the issue of guard processes, SLIM defines three types of
guard processes: Unlimited Guards, Limited Guards, and Untrusted
Guards.  Unlimited Guards are the most security sensitive, as they
allow less trusted process to acquire a higher level of trust.
On my current system there are two unlimited guards, passwd and
userhelper. These two applications inherently have to be trusted
this way regardless of the MAC model used. In SLIM, the policy
clearly and simply labels them as having this level of trust.

Limited Guards are programs which cannot give away higher
trust, but which can keep their existing level despite reading
less trusted data. On my system I have seven limited guards:
yum, which is trusted to verify the signature on an (untrusted)
downloaded RPM file, and to install it, login and sshd, which read
untrusted user supplied login data, for authentication, dhclient
which reads untrusted network data, and updates they system
file /etc/resolv.conf, dbus-daemon, which accepts data from
potentially untrusted processes, Xorg, which has to accept data
from all Xwindow clients, regardless of level, and postfix which
delivers untrusted mail. Again, these applications inherently
must cross trust levels, and SLIM properly identifies them.

As mentioned earlier, cupsd and notes are applications which are
always run directly in untrusted mode, regardless of the level of
the invoking process.

The bottom line is that SLIM guard programs inherently do security
sensitive things, and have to be trusted. There are only a small
number of them, and they are clearly identified by their labels.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 security/slim/slm_main.c | 1536 +++++++++++++++++++++++++++++++++++++
 1 files changed, 1536 insertions(+)

--- linux-2.6.17-rc3/security/slim/slm_main.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18-rc1/security/slim/slm_main.c	2006-07-14 10:03:18.000000000 -0700
@@ -0,0 +1,1536 @@
+/*
+ * SLIM - Simple Linux Integrity Module
+ *
+ * Copyright (C) 2005,2006 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+#include <linux/mman.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+#include <linux/integrity.h>
+#include <linux/proc_fs.h>
+#include <linux/socket.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/namei.h>
+#include <linux/mm.h>
+#include <linux/shm.h>
+#include <linux/ipc.h>
+#include <linux/errno.h>
+#include <linux/xattr.h>
+#include <net/sock.h>
+
+#include "slim.h"
+
+#if defined(CONFIG_SECURITY_SLIM_MODULE)
+#define MY_NAME THIS_MODULE->name
+#else
+#define MY_NAME "slim"
+#endif
+
+static int secondary;
+static DEFINE_SPINLOCK(slm_inode_sec_lock);
+
+static char *slm_xattr_name = "security.slim.level";
+module_param(slm_xattr_name, charp, 0444);
+MODULE_PARM_DESC(slm_xattr_name, "SLIM extended attribute");
+
+#define EXEMPT_STR "EXEMPT"
+#define PUBLIC_STR "PUBLIC"
+#define SYSTEM_SENSITIVE_STR "SYSTEM-SENSITIVE"
+#define SYSTEM_STR "SYSTEM"
+#define UNLIMITED_STR "UNLIMITED"
+#define UNTRUSTED_STR "UNTRUSTED"
+#define USER_SENSITIVE_STR "USER-SENSITIVE"
+#define USER_STR "USER"
+#define ZERO_STR "0"
+
+char *slm_iac_str[] = { ZERO_STR,
+	UNTRUSTED_STR,
+	USER_STR,
+	SYSTEM_STR
+};
+static char *slm_sac_str[] = { ZERO_STR,
+	PUBLIC_STR,
+	USER_STR,
+	USER_SENSITIVE_STR,
+	SYSTEM_SENSITIVE_STR
+};
+
+static char *get_token(char *buf_start, char *buf_end, char delimiter,
+		       int *token_len)
+{
+	char *bufp = buf_start;
+	char *token = NULL;
+
+	while (!token && (bufp < buf_end)) {	/* Get start of token */
+		switch (*bufp) {
+		case ' ':
+		case '\n':
+		case '\t':
+			bufp++;
+			break;
+		case '#':
+			while ((*bufp != '\n') && (bufp++ < buf_end)) ;
+			bufp++;
+			break;
+		default:
+			token = bufp;
+			break;
+		}
+	}
+	if (!token)
+		return NULL;
+
+	*token_len = 0;
+	while ((*token_len == 0) && (bufp <= buf_end)) {
+		if ((*bufp == delimiter) || (*bufp == '\n'))
+			*token_len = bufp - token;
+		if (bufp == buf_end)
+			*token_len = bufp - token;
+		bufp++;
+	}
+	if (*token_len == 0)
+		token = NULL;
+	return token;
+}
+
+static int is_guard_integrity(struct slm_file_xattr *level)
+{
+	if ((level->guard.iac_r != SLM_IAC_NOTDEFINED)
+	    && (level->guard.iac_wx != SLM_IAC_NOTDEFINED))
+		return 1;
+	return 0;
+}
+
+static int is_guard_secrecy(struct slm_file_xattr *level)
+{
+	if ((level->guard.sac_rx != SLM_SAC_NOTDEFINED)
+	    && (level->guard.sac_w != SLM_SAC_NOTDEFINED))
+		return 1;
+	return 0;
+}
+
+/* 
+ * Called with current->files->file_lock. There is not a great lock to grab
+ * for demotion of this type.  The only place f_mode is changed after install
+ * is in mark_files_ro in the filesystem code.  That function is also changing
+ * taking away write rights so even if we race the outcome is the same.
+ */
+static inline void do_revoke_file_wperm(struct file *file,
+					struct slm_file_xattr *cur_level)
+{
+	struct inode *inode;
+	struct slm_isec_data *isec;
+
+	inode = file->f_dentry->d_inode;
+	if (!inode)
+		return;
+	if (!S_ISREG(inode->i_mode) || !(file->f_mode && FMODE_WRITE))
+		return;
+
+	isec = inode->i_security;
+	if (!isec)
+		return;
+	if (cur_level->iac_level < isec->level.iac_level)
+		file->f_mode &= ~FMODE_WRITE;
+}
+
+/*
+ * Revoke write permission on an open file.  
+ */
+static void revoke_file_wperm(struct slm_file_xattr *cur_level)
+{
+	int i, j = 0;
+	struct files_struct *files = current->files;
+	unsigned long fd = 0;
+	struct fdtable *fdt;
+	struct file *file;
+
+	if (!files || !cur_level)
+		return;
+
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+
+	for (;;) {
+		i =j * __NFDBITS;
+		if ( i>= fdt->max_fdset || i >= fdt->max_fds)
+			break;
+		fd = fdt->open_fds->fds_bits[j++];
+		while(fd) {
+			if (fd & 1) {
+				file = fdt->fd[i++];
+				if (file && file->f_dentry)
+					do_revoke_file_wperm(file, cur_level);
+			}
+			fd >>= 1;
+		}
+	}
+	spin_unlock(&files->file_lock);
+}
+
+static inline void do_revoke_mmap_wperm(struct vm_area_struct *mpnt,
+					struct slm_isec_data *isec,
+					struct slm_file_xattr *cur_level)
+{
+	unsigned long start = mpnt->vm_start;
+	unsigned long end = mpnt->vm_end;
+	size_t len = end - start;
+	struct dentry *dentry = mpnt->vm_file->f_dentry;
+
+	if ((mpnt->vm_flags & VM_WRITE)
+	    && (mpnt->vm_flags & VM_SHARED)
+	    && (cur_level->iac_level < isec->level.iac_level)) {
+		if (strncmp(dentry->d_name.name, "SYSV", 4) == 0) {
+			down_write(&current->mm->mmap_sem);
+			do_munmap(current->mm, start, len);
+			up_write(&current->mm->mmap_sem);
+		} else
+			do_mprotect(start, len, PROT_READ);
+	}
+}
+
+/*
+ * Revoke write permission to underlying mmap file (MAP_SHARED)
+ */
+static void revoke_mmap_wperm(struct slm_file_xattr *cur_level)
+{
+	struct vm_area_struct *mpnt;
+	struct file *file;
+	struct dentry *dentry;
+	struct slm_isec_data *isec;
+
+	flush_cache_mm(current->mm);
+
+	for (mpnt = current->mm->mmap; mpnt; mpnt = mpnt->vm_next) {
+		file = mpnt->vm_file;
+		if (!file)
+			continue;
+
+		dentry = file->f_dentry;
+		if (!dentry || !dentry->d_inode)
+			continue;
+
+		isec = dentry->d_inode->i_security;
+		if (!isec)
+			continue;
+
+		do_revoke_mmap_wperm(mpnt, isec, cur_level);
+	}
+}
+
+static int using_shmem(void)
+{
+	struct task_struct *group_tsk;
+
+	if (!current->group_leader)
+		return 0;
+
+	group_tsk = current->group_leader;
+	if ((current->pid != group_tsk->pid) && (current->mm == group_tsk->mm))
+		return 1;
+	return 0;
+}
+
+static void do_demote_thread_entry(struct task_struct *thread_tsk)
+				   
+{
+	struct slm_tsec_data *cur_tsec = current->security,
+	    *thread_tsec = thread_tsk->security;
+
+	if (thread_tsk->pid == 1)
+		return;
+	if (current->pid != thread_tsk->pid)
+		return;
+	if (current->mm == thread_tsk->mm)
+		return;
+	if (!thread_tsec)
+		return;
+
+	spin_lock(&thread_tsec->lock);
+	thread_tsec->iac_r = cur_tsec->iac_r;
+	thread_tsec->iac_wx = cur_tsec->iac_wx;
+	spin_unlock(&thread_tsec->lock);
+}
+
+#define do_demote_thread_list(head, member) { \
+	struct task_struct *thread_tsk; \
+	list_for_each_entry(thread_tsk, head, member) \
+		do_demote_thread_entry(thread_tsk); \
+}
+
+static void demote_threads(void)
+{
+	do_demote_thread_list(&current->sibling, sibling);
+	do_demote_thread_list(&current->children, children);
+}
+
+/*
+ * Revoke write permissions and demote threads using shared memory
+ */
+static void revoke_permissions(struct slm_file_xattr *cur_level)
+{
+	if ((!is_kernel_thread(current)) && (current->pid != 1)) {
+		if (using_shmem())
+			demote_threads();
+
+		revoke_mmap_wperm(cur_level);
+		revoke_file_wperm(cur_level);
+	}
+}
+
+static enum slm_iac_level set_iac(char *token)
+{
+	int iac;
+
+	if (memcmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
+		return SLM_IAC_EXEMPT;
+	else {
+		for (iac = 0; iac < sizeof(slm_iac_str) / sizeof(char *); iac++) {
+			if (memcmp(token, slm_iac_str[iac],
+				   strlen(slm_iac_str[iac])) == 0)
+				return iac;
+		}
+	}
+	return SLM_IAC_ERROR;
+}
+
+static enum slm_sac_level set_sac(char *token)
+{
+	int sac;
+
+	if (memcmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
+		return SLM_SAC_EXEMPT;
+	else {
+		for (sac = 0; sac < sizeof(slm_sac_str) / sizeof(char *); sac++) {
+			if (memcmp(token, slm_sac_str[sac],
+				   strlen(slm_sac_str[sac])) == 0)
+				return sac;
+		}
+	}
+	return SLM_SAC_ERROR;
+}
+
+static inline int set_bounds(char *token)
+{
+	if (memcmp(token, UNLIMITED_STR, strlen(UNLIMITED_STR)) == 0)
+		return 1;
+	return 0;
+}
+
+/* 
+ * Get the 7 access class levels from the extended attribute 
+ * Format: TIMESTAMP INTEGRITY SECRECY [INTEGRITY_GUARD INTEGRITY_GUARD] [SECRECY_GUARD SECRECY_GUARD] [GUARD_ TYPE]
+ */
+static int slm_parse_xattr(char *xattr_value, int xattr_len,
+			   struct slm_file_xattr *level)
+{
+	char *token;
+	int token_len;
+	char *buf, *buf_end;
+	int fieldno = 0;
+	int rc = -1;
+
+	buf = xattr_value + sizeof(time_t);
+	if (*buf == 0x20)
+		buf++;		/* skip blank after timestamp */
+	buf_end = xattr_value + xattr_len;
+
+	while ((token = get_token(buf, buf_end, ' ', &token_len)) != NULL) {
+		buf = token + token_len;
+		switch (++fieldno) {
+		case 1:
+			if ((level->iac_level =
+			     set_iac(token)) != SLM_IAC_ERROR)
+				rc = 0;
+			break;
+		case 2:
+			level->sac_level = set_sac(token);
+			break;
+		case 3:
+			level->guard.iac_r = set_iac(token);
+			break;
+		case 4:
+			level->guard.iac_wx = set_iac(token);
+			break;
+		case 5:
+			level->guard.unlimited = set_bounds(token);
+			level->guard.sac_w = set_sac(token);
+			break;
+		case 6:
+			level->guard.sac_rx = set_sac(token);
+			break;
+		case 7:
+			level->guard.unlimited = set_bounds(token);
+		default:
+			break;
+		}
+	}
+	return rc;
+}
+
+/*
+ *  Possible return codes:  INTEGRITY_PASS, INTEGRITY_FAIL, INTEGRITY_NOLABEL,
+ * 			 or -EINVAL
+ */
+static int slm_get_xattr(struct dentry *dentry,
+			 struct slm_file_xattr *level, int *xattr_status)
+{
+	int xattr_len;
+	char *xattr_value = NULL;
+	int rc, error = -EINVAL;
+
+	rc = integrity_verify_metadata(dentry, slm_xattr_name,
+				       &xattr_value, &xattr_len, xattr_status);
+	if (rc < 0) {
+		printk(KERN_INFO
+		       "%s integrity_verify_metadata failed (%d)\n",
+		       dentry->d_name.name, rc);
+		return rc;
+	}
+
+	if (xattr_value) {
+		memset(level, 0, sizeof(struct slm_file_xattr));
+		error = slm_parse_xattr(xattr_value, xattr_len, level);
+		kfree(xattr_value);
+	}
+
+	if (level->iac_level != SLM_IAC_UNTRUSTED) {
+		rc = integrity_verify_data(dentry);
+		if (rc < 0) {
+			printk(KERN_INFO "%s integrity_verify_data failed "
+			       " (%d)\n", dentry->d_name.name, rc);
+			return rc;
+		}
+	}
+
+	return error < 0 ? -EINVAL : rc;
+}
+
+static void get_sock_level(struct dentry *dentry, struct slm_file_xattr *level)
+{
+	struct slm_tsec_data *cur_tsec;
+	int rc, xattr_status = 0;
+
+	cur_tsec = current->security;
+
+	rc = slm_get_xattr(dentry, level, &xattr_status);
+	if (rc == -EINVAL) {
+		if (xattr_status == -EOPNOTSUPP) {
+			level->iac_level = SLM_IAC_EXEMPT;
+			level->sac_level = SLM_SAC_EXEMPT;
+		} else {
+			level->iac_level = cur_tsec->iac_r;
+			level->sac_level = cur_tsec->sac_rx;
+		}
+	}
+}
+
+static void get_level(struct dentry *dentry, struct slm_file_xattr *level)
+{
+	int rc, xattr_status = 0;
+
+	rc = slm_get_xattr(dentry, level, &xattr_status);
+	if ((rc == INTEGRITY_FAIL) || (rc == INTEGRITY_NOLABEL)) {
+		level->iac_level = SLM_IAC_UNTRUSTED;
+		level->sac_level = SLM_SAC_PUBLIC;
+	} else if (xattr_status == -EOPNOTSUPP) {
+		level->iac_level = SLM_IAC_EXEMPT;
+		level->sac_level = SLM_SAC_EXEMPT;
+	} else if (rc == -EINVAL) {	/* improperly formatted */
+		level->iac_level = SLM_IAC_UNTRUSTED;
+		level->sac_level = SLM_SAC_PUBLIC;
+	}
+}
+
+static struct slm_isec_data *slm_alloc_security(void)
+{
+	struct slm_isec_data *isec;
+
+	isec = kzalloc(sizeof(struct slm_isec_data), GFP_KERNEL);
+	if (!isec)
+		return NULL;
+
+	isec->lock = SPIN_LOCK_UNLOCKED;
+	return isec;
+}
+
+static struct slm_isec_data * slm_inode_alloc_and_lock(struct inode *inode)
+{
+	struct slm_isec_data *isec = slm_alloc_security();
+	if (!isec)
+		return NULL;
+
+	spin_lock(&slm_inode_sec_lock);
+	if (inode->i_security) {
+		kfree(isec);
+		isec = inode->i_security;
+	} else
+		inode->i_security = isec;
+	spin_unlock(&slm_inode_sec_lock);
+
+	return isec;
+}
+
+/*
+ * Exempt objects without extended attribute support 
+ */
+static int is_exempt(struct inode *inode)
+{
+	if ((inode->i_sb->s_magic == PROC_SUPER_MAGIC)
+	    || S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+		return 1;
+	return 0;
+}
+
+/*
+ * All directories with xattr support should be labeled, but just in case
+ * recursively traverse path (dentry->parent) until level info is found.
+ */
+static void slm_get_level(struct dentry *dentry, struct slm_file_xattr *level)
+{
+	struct inode *inode = dentry->d_inode;
+	struct slm_isec_data *isec = inode->i_security;
+
+	if (isec && (isec->level.iac_level != SLM_IAC_NOTDEFINED)) {
+		memcpy(level, &isec->level, sizeof(struct slm_file_xattr));
+		return;
+	}
+
+	if (!isec) {		/* Missed a few before LSM hooks enabled */
+		isec = slm_inode_alloc_and_lock(inode);
+		if (!isec)
+			return;
+	}
+
+	if (is_exempt(inode)) {
+		memset(level, 0, sizeof(struct slm_file_xattr));
+		level->iac_level = SLM_IAC_EXEMPT;
+		level->sac_level = SLM_SAC_EXEMPT;
+	} else if (S_ISSOCK(inode->i_mode))
+		get_sock_level(dentry, level);
+	else
+		get_level(dentry, level);
+
+	spin_lock(&isec->lock);
+	memcpy(&isec->level, level, sizeof(struct slm_file_xattr));
+	spin_unlock(&isec->lock);
+}
+
+/*
+ * new tsk->security inherits from current->security
+ */
+static struct slm_tsec_data *slm_init_task(struct task_struct *tsk)
+{
+	struct slm_tsec_data *tsec, *cur_tsec = current->security;
+
+	tsec = kzalloc(sizeof(struct slm_tsec_data), GFP_KERNEL);
+	if (!tsec)
+		return NULL;
+	tsec->lock = SPIN_LOCK_UNLOCKED;
+	if (!cur_tsec) {
+		tsec->iac_r = SLM_IAC_HIGHEST - 1;
+		tsec->iac_wx = SLM_IAC_HIGHEST - 1;
+		tsec->sac_w = SLM_SAC_NOTDEFINED + 1;
+		tsec->sac_rx = SLM_SAC_NOTDEFINED + 1;
+	} else
+		memcpy(tsec, cur_tsec, sizeof(struct slm_tsec_data));
+
+	return tsec;
+}
+
+/*
+ * enforce: IRAC(process) <= IAC(object)
+ * Permit process to read file of equal or greater integrity
+ * otherwise, demote the process.
+ */
+static void enforce_integrity_read(struct slm_file_xattr *level)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+
+	if (!((cur_tsec->iac_r <= level->iac_level)
+	      || (level->iac_level == SLM_IAC_EXEMPT))) {
+		/* Reading lower integrity, demote process
+		 * Even in the case of a integrity guard process. */
+		spin_lock(&cur_tsec->lock);
+		cur_tsec->iac_r = level->iac_level;
+		cur_tsec->iac_wx = level->iac_level;
+		spin_unlock(&cur_tsec->lock);
+
+		revoke_permissions(level);
+	}
+}
+
+/*
+ * enforce: SRXAC(process) >= SAC(object)
+ * Permit process to read file of equal or lesser secrecy;
+ * otherwise, promote the process.
+ */
+static void enforce_secrecy_read(struct slm_file_xattr *level)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+
+	if (!((cur_tsec->sac_rx >= level->sac_level)
+	      || (level->sac_level == SLM_SAC_EXEMPT))) {
+
+		/* Reading higher secrecy, promote process
+		 * Even in the case of a secrecy guard process. */
+		spin_lock(&cur_tsec->lock);
+		cur_tsec->sac_rx = level->sac_level;
+		cur_tsec->sac_w = level->sac_level;
+		spin_unlock(&cur_tsec->lock);
+
+		/* Working item: revoke write permission to lower secrecy
+		 * files. Prototyped but insufficiently tested for release
+		 * current code will only allow authorized user to release
+		 * sensitive data */
+	}
+}
+
+static void do_task_may_read(struct slm_file_xattr *level)
+{
+	enforce_integrity_read(level);
+	enforce_secrecy_read(level);
+}
+
+/*
+ * enforce: IWXAC(process) >= IAC(object)
+ * Permit process to write a file of equal or lesser integrity.
+ */
+static int enforce_integrity_write(struct slm_file_xattr *level)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+
+	if (!((cur_tsec->iac_wx >= level->iac_level)
+	      || (level->iac_level == SLM_IAC_NOTDEFINED)
+	      || (level->iac_level == SLM_IAC_EXEMPT)))
+		return -EACCES; /* can't write higher integrity */
+	return 0;
+}
+
+/*
+ * enforce: SWAC(process) <= SAC(process)
+ * Permit process to write a file of equal or greater secrecy
+ */
+static int enforce_secrecy_write(struct slm_file_xattr *level)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+
+	if (!((cur_tsec->sac_w <= level->sac_level)
+	      || (level->sac_level == SLM_SAC_EXEMPT)))
+		return -EACCES; /* can't write lower secrecy */
+	return 0;
+}
+
+static int do_task_may_write(struct slm_file_xattr *level)
+{
+	int rc;
+
+	rc = enforce_integrity_write(level);
+	if (rc < 0)
+		return rc;
+
+	return enforce_secrecy_write(level);
+}
+
+static int slm_set_taskperm(int mask, struct slm_file_xattr *level)
+{
+	struct slm_tsec_data *cur_tsec;
+	int rc = 0;
+
+	cur_tsec = current->security;
+	if (!cur_tsec) {
+		cur_tsec = slm_init_task(current);
+
+		if (!cur_tsec)
+			return -ENOMEM;
+
+		task_lock(current);
+		if (current->security) {
+			kfree(cur_tsec);
+			cur_tsec = current->security;
+		} else
+			current->security = cur_tsec;
+		task_unlock(current);
+	}
+
+	if (mask & MAY_READ)
+		do_task_may_read(level);
+	if ((mask & MAY_WRITE) || (mask & MAY_APPEND))
+		rc = do_task_may_write(level);
+	return rc;
+}
+
+/*
+ * Need an explanation here
+ */
+static int slm_file_permission(struct file *file, int mask)
+{
+	struct slm_isec_data *isec;
+
+	if ((mask & MAY_WRITE) || (mask & MAY_APPEND)) {
+		isec = file->f_dentry->d_inode->i_security;
+		if (isec) {
+			spin_lock(&isec->lock);
+			isec->level.iac_level = SLM_IAC_NOTDEFINED;
+			spin_unlock(&isec->lock);
+		}
+	}
+	return 0;
+}
+
+/*
+ * Premise:
+ * Can't write or execute higher integrity, can't read lower integrity
+ * Can't read or execute higher secrecy, can't write lower secrecy
+ */
+static int slm_inode_permission(struct inode *inode, int mask,
+				struct nameidata *nd)
+{
+	struct dentry *dentry = NULL;
+	struct slm_file_xattr level;
+
+	if (S_ISDIR(inode->i_mode) && (mask & MAY_WRITE))
+		return 0;
+
+	dentry = (!nd || !nd->dentry) ? d_find_alias(inode) : nd->dentry;
+	if (!dentry)
+		return 0;
+
+	slm_get_level(dentry, &level);
+
+	/* measure all SYSTEM level integrity objects */
+	if (level.iac_level == SLM_IAC_SYSTEM)
+		integrity_measure(dentry, NULL, mask);
+
+	return slm_set_taskperm(mask, &level);
+}
+
+/* 
+ * This hook is called holding the inode mutex.
+ */
+static int slm_inode_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct slm_file_xattr level;
+
+	if (!dentry || !dentry->d_name.name)
+		return 0;
+
+	slm_get_level(dentry, &level);
+	return slm_set_taskperm(MAY_WRITE, &level);
+}
+
+static void slm_inode_free_security(struct inode *inode)
+{
+	struct slm_isec_data *isec = inode->i_security;
+
+	inode->i_security = NULL;
+	kfree(isec);
+}
+
+/*
+ * Check integrity permission to create a regular file.
+ */
+static int slm_inode_create(struct inode *parent_dir,
+			    struct dentry *dentry, int mask)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+	struct slm_isec_data *parent_isec = parent_dir->i_security;
+	struct slm_file_xattr *parent_level;
+
+	if (!parent_isec)
+		return 0;
+	parent_level = &parent_isec->level;
+
+	/*
+	 * enforce: IWXAC(process) >= IAC(object)
+	 * Permit process to write a file of equal or lesser integrity.
+	 */
+	if (!((cur_tsec->iac_wx >= parent_level->iac_level)
+	      || (parent_level->iac_level == SLM_IAC_EXEMPT)))
+		return -EPERM;
+	return 0;
+}
+
+#define MAX_XATTR_SIZE 76
+
+static int slm_set_xattr(struct slm_file_xattr *level,
+			 char **name, void **value, size_t * value_len)
+{
+	int len;
+	int xattr_len;
+	char buf[MAX_XATTR_SIZE];
+	char *bufp = buf;
+	char *xattr_val = buf;
+	struct timespec now;
+	time_t nl_time;
+	char *xattr_name;
+
+	if (!level)
+		return 0;
+
+	memset(buf, 0, sizeof(buf));
+
+	now = CURRENT_TIME;
+	len = sizeof(now.tv_sec);
+	nl_time = htonl(now.tv_sec);
+	memcpy(bufp, &nl_time, len);
+	bufp += len;
+	*bufp++ = ' ';
+
+	if (level->iac_level == SLM_IAC_EXEMPT) {
+		memcpy(bufp, EXEMPT_STR, strlen(EXEMPT_STR));
+		bufp += strlen(EXEMPT_STR);
+	} else {
+		len = strlen(slm_iac_str[level->iac_level]);
+		memcpy(bufp, slm_iac_str[level->iac_level], len);
+		bufp += len;
+	}
+	*bufp++ = ' ';
+	if (level->sac_level == SLM_SAC_EXEMPT) {
+		memcpy(bufp, EXEMPT_STR, strlen(EXEMPT_STR));
+		bufp += strlen(EXEMPT_STR);
+	} else {
+		len = strlen(slm_sac_str[level->sac_level]);
+		memcpy(bufp, slm_sac_str[level->sac_level], len);
+		bufp += len;
+	}
+	xattr_len = bufp - buf;
+
+	/* point after 'security.' */
+	xattr_name = strchr(slm_xattr_name, '.');
+	if (xattr_name)
+		*name = kstrdup(xattr_name + 1, GFP_KERNEL);
+	*value = kmalloc(xattr_len + 1, GFP_KERNEL);
+	if (!*value) {
+		kfree(name);
+		return -ENOMEM;
+	}
+	memcpy(*value, xattr_val, xattr_len);
+	*value_len = xattr_len;
+	return 0;
+}
+
+/* Create the security.slim.level extended attribute */
+static int slm_inode_init_security(struct inode *inode, struct inode *dir,
+				   char **name, void **value, size_t * len)
+{
+	struct slm_isec_data *isec = inode->i_security, *parent_isec =
+	    dir->i_security;
+	struct slm_tsec_data *cur_tsec = current->security;
+	struct slm_file_xattr level;
+	struct xattr_data *data;
+	int rc;
+
+	if (!name || !value || !len)
+		return 0;
+
+	memset(&level, 0, sizeof(struct slm_file_xattr));
+
+	if (parent_isec && (parent_isec->level.iac_level != SLM_IAC_NOTDEFINED))
+		memcpy(&level, &parent_isec->level,
+		       sizeof(struct slm_file_xattr));
+
+	/* low integrity process wrote into a higher level directory */
+	if (cur_tsec->iac_wx < level.iac_level) {
+		level.iac_level = cur_tsec->iac_wx;
+		level.sac_level = cur_tsec->sac_w;
+	}
+	/* if directory is exempt, then use process level */
+	if (level.iac_level == SLM_IAC_EXEMPT) {
+		level.iac_level = cur_tsec->iac_wx;
+		level.sac_level = cur_tsec->sac_w;
+
+		/* Except for when a guard process creates a directory */
+		if (S_ISDIR(inode->i_mode)
+		    && (cur_tsec->iac_wx != cur_tsec->iac_r)) {
+			level.iac_level = SLM_IAC_EXEMPT;
+			level.sac_level = SLM_SAC_EXEMPT;
+		}
+	}
+
+	/* if a guard process creates a UNIX socket, then EXEMPT it */
+	if (S_ISSOCK(inode->i_mode)
+	    && (cur_tsec->iac_wx != cur_tsec->iac_r)) {
+		level.iac_level = SLM_IAC_EXEMPT;
+		level.sac_level = SLM_SAC_EXEMPT;
+	}
+
+	if (!isec)
+		return 0;
+
+	spin_lock(&isec->lock);
+	memcpy(&isec->level, &level, sizeof(struct slm_file_xattr));
+	spin_unlock(&isec->lock);
+
+	data = kmalloc(sizeof(struct xattr_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* set levels, based on parent */
+	rc = slm_set_xattr(&level, &data->name, &data->value, &data->len);
+	if (rc < 0)
+		return rc;
+
+	*name = data->name;
+	*value = data->value;
+	*len = data->len;
+	return 0;
+}
+
+static void slm_d_instantiate(struct dentry *dentry, struct inode *inode)
+{
+	struct slm_isec_data *isec;
+	struct slm_file_xattr level;
+
+	if (inode) {
+		if (is_exempt(inode)) {
+			memset(&level, 0, sizeof(struct slm_file_xattr));
+			level.iac_level = SLM_IAC_EXEMPT;
+			level.sac_level = SLM_SAC_EXEMPT;
+		} else if (S_ISSOCK(inode->i_mode))
+			memset(&level, 0, sizeof(struct slm_file_xattr));
+		else
+			get_level(dentry, &level);
+
+		isec = inode->i_security;
+		if (!isec) {	/* Missed a few before LSM hooks enabled */
+			isec = slm_inode_alloc_and_lock(inode);
+			if (!isec)
+				return;
+		}
+		spin_lock(&isec->lock);
+		memcpy(&isec->level, &level, sizeof(struct slm_file_xattr));
+		spin_unlock(&isec->lock);
+	}
+}
+
+/*
+ * Check permissions to create a new directory in the existing directory
+ * associated with inode structure @dir.
+ */
+static int slm_inode_mkdir(struct inode *parent_dir,
+			   struct dentry *dentry, int mask)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+	struct slm_isec_data *parent_isec = parent_dir->i_security;
+	struct slm_file_xattr *parent_level = &parent_isec->level;
+
+	if (cur_tsec->iac_wx < parent_level->iac_level) {
+		if (parent_level->iac_level == SLM_IAC_SYSTEM)
+			return -EACCES;
+	}
+	return 0;
+}
+
+static int slm_inode_rename(struct inode *old_dir,
+			    struct dentry *old_dentry,
+			    struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct slm_file_xattr old_level, parent_level;
+	struct dentry *parent_dentry;
+
+	if (old_dir == new_dir)
+		return 0;
+
+	slm_get_level(old_dentry, &old_level);
+
+	parent_dentry = dget_parent(new_dentry);
+	slm_get_level(parent_dentry, &parent_level);
+	dput(parent_dentry);
+
+	if (old_level.iac_level < parent_level.iac_level)
+		return -EPERM;
+	return 0;
+}
+
+/*
+ * Limit the integrity value of an object to be no greater than that
+ * of the current process. This is especially important for objects
+ * being promoted.
+*/
+int slm_inode_setxattr(struct dentry *dentry, char *name, void *value,
+		       size_t size, int flags)
+{
+	struct slm_tsec_data *cur_tsec;
+
+	if (memcmp(name, slm_xattr_name, strlen(slm_xattr_name)) != 0)
+		return 0;
+
+	cur_tsec = current->security;
+	if (!cur_tsec)
+		return 0;
+
+	if (!value)
+		return -EINVAL;
+
+	switch (cur_tsec->iac_wx) {
+	case SLM_IAC_USER:
+		if ((memcmp
+		     (value + sizeof(time_t) + 1, USER_STR,
+		      strlen(USER_STR)) != 0)
+		    &&
+		    (memcmp
+		     (value + sizeof(time_t) + 1, UNTRUSTED_STR,
+		      strlen(UNTRUSTED_STR)) != 0))
+			return -EPERM;
+		break;
+	case SLM_IAC_SYSTEM:
+		if ((memcmp
+		     (value + sizeof(time_t) + 1, SYSTEM_STR,
+		      strlen(SYSTEM_STR)) != 0)
+		    &&
+		    (memcmp
+		     (value + sizeof(time_t) + 1, USER_STR,
+		      strlen(USER_STR)) != 0)
+		    &&
+		    (memcmp
+		     (value + sizeof(time_t) + 1, UNTRUSTED_STR,
+		      strlen(UNTRUSTED_STR))
+		     != 0)
+		    &&
+		    (memcmp
+		     (value + sizeof(time_t) + 1, EXEMPT_STR,
+		      strlen(EXEMPT_STR)) != 0))
+			return -EPERM;
+		break;
+	default:
+		return -EPERM;
+	}
+	return 0;
+}
+
+/*
+ * SLIM extended attribute was modified, update isec.
+ */
+static void slm_inode_post_setxattr(struct dentry *dentry, char *name,
+				    void *value, size_t size, int flags)
+{
+	struct slm_isec_data *slm_isec;
+	struct slm_file_xattr level;
+	int rc, xattr_status = 0;
+
+	if (memcmp(name, slm_xattr_name, strlen(slm_xattr_name)) != 0)
+		return;
+
+	rc = slm_get_xattr(dentry, &level, &xattr_status);
+	slm_isec = dentry->d_inode->i_security;
+	if (!slm_isec)
+		return;
+	spin_lock(&slm_isec->lock);
+	memcpy(&slm_isec->level, &level, sizeof(struct slm_file_xattr));
+	spin_unlock(&slm_isec->lock);
+}
+
+static int slm_inode_removexattr(struct dentry *dentry, char *name)
+{
+	struct slm_isec_data *isec;
+
+	if (memcmp(name, slm_xattr_name, strlen(slm_xattr_name)) != 0)
+		return 0;
+
+	isec = dentry->d_inode->i_security;
+	if (isec) {
+		spin_lock(&isec->lock);
+		isec->level.iac_level = SLM_IAC_NOTDEFINED;
+		spin_unlock(&isec->lock);
+	}
+	return 0;
+}
+
+static int slm_inode_alloc_security(struct inode *inode)
+{
+	struct slm_isec_data *isec = slm_alloc_security();
+	if (!isec)
+		return -ENOMEM;
+
+	inode->i_security = isec;
+	return 0;
+}
+
+/*
+ * Opening a socket demotes the integrity of a process to untrusted.
+ */
+int slm_socket_create(int family, int type, int protocol, int kern)
+{
+	struct task_struct *parent_tsk;
+	struct slm_tsec_data *cur_tsec, *parent_tsec;
+	struct slm_file_xattr level;
+
+	cur_tsec = current->security;
+
+	/* demoting only internet sockets */
+	if ((family != AF_UNIX) && (family != AF_NETLINK)) {
+		if (cur_tsec->iac_r > SLM_IAC_UNTRUSTED) {
+			parent_tsk = current->parent;
+			parent_tsec = parent_tsk->security;
+			spin_lock(&cur_tsec->lock);
+			cur_tsec->iac_r = SLM_IAC_UNTRUSTED;
+			cur_tsec->iac_wx = SLM_IAC_UNTRUSTED;
+			spin_unlock(&cur_tsec->lock);
+
+			memset(&level, 0, sizeof(struct slm_file_xattr));
+			level.iac_level = SLM_IAC_UNTRUSTED;
+
+			revoke_permissions(&level);
+		}
+	}
+	return 0;
+}
+
+/*
+ * Didn't have the family type previously, so update the inode security now.
+ */
+static void slm_socket_post_create(struct socket *sock, int family,
+				   int type, int protocol, int kern)
+{
+	struct slm_isec_data *slm_isec;
+	struct slm_tsec_data *cur_tsec;
+	struct inode *inode;
+
+	inode = SOCK_INODE(sock);
+	slm_isec = inode->i_security;
+	if (!slm_isec)
+		return;
+
+	if (family == PF_UNIX) {
+		cur_tsec = current->security;
+		if (!cur_tsec)	/* task created before LSM hooks enabled */
+			return;
+		if (cur_tsec->iac_wx != cur_tsec->iac_r) {	/* guard process */
+			spin_lock(&slm_isec->lock);
+			slm_isec->level.iac_level = SLM_IAC_EXEMPT;
+			slm_isec->level.sac_level = SLM_SAC_EXEMPT;
+			spin_unlock(&slm_isec->lock);
+		} else {
+			spin_lock(&slm_isec->lock);
+			slm_isec->level.iac_level = cur_tsec->iac_wx;
+			slm_isec->level.sac_level = cur_tsec->sac_w;
+			spin_unlock(&slm_isec->lock);
+		}
+	} else {
+		spin_lock(&slm_isec->lock);
+		slm_isec->level.iac_level = SLM_IAC_UNTRUSTED;
+		slm_isec->level.sac_level = SLM_SAC_PUBLIC;
+		spin_unlock(&slm_isec->lock);
+	}
+}
+
+/*
+ * When a task gets allocated, it inherits the current IAC and SAC.
+ * Set the values and store them in p->security.
+ */
+static int slm_task_alloc_security(struct task_struct *tsk)
+{
+	struct slm_tsec_data *tsec = tsk->security;
+
+	if (!tsec) {
+		tsec = slm_init_task(tsk);
+		if (!tsec)
+			return -ENOMEM;
+	}
+	tsk->security = tsec;
+	return 0;
+}
+
+static void slm_task_free_security(struct task_struct *tsk)
+{
+	struct slm_tsec_data *tsec;
+
+	tsec = tsk->security;
+	tsk->security = NULL;
+	kfree(tsec);
+}
+
+static int slm_task_post_setuid(uid_t old_ruid, uid_t old_euid,
+				uid_t old_suid, int flags)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+
+	if (!cur_tsec) ;
+	else if (flags == LSM_SETID_ID) {
+		/*set process to USER level integrity for everything but root */
+		if ((cur_tsec->iac_r == cur_tsec->iac_wx)
+			&& (cur_tsec->iac_r == SLM_IAC_UNTRUSTED));
+		else if (current->suid != 0) {
+			spin_lock(&cur_tsec->lock);
+			cur_tsec->iac_r = SLM_IAC_USER;
+			cur_tsec->iac_wx = SLM_IAC_USER;
+			spin_unlock(&cur_tsec->lock);
+		} else if ((current->uid == 0) && (old_ruid != 0)) {
+			spin_lock(&cur_tsec->lock);
+			cur_tsec->iac_r = SLM_IAC_SYSTEM;
+			cur_tsec->iac_wx = SLM_IAC_SYSTEM;
+			spin_unlock(&cur_tsec->lock);
+		}
+	}
+	return 0;
+}
+
+static inline int slm_setprocattr(struct task_struct *tsk,
+				  char *name, void *value, size_t size)
+{
+	return -EACCES;
+
+}
+
+static inline int slm_getprocattr(struct task_struct *tsk,
+				  char *name, void *value, size_t size)
+{
+	struct slm_tsec_data *tsec = tsk->security;
+	size_t len = 0;
+
+	if (is_kernel_thread(tsk))
+		len = snprintf(value, size, "KERNEL");
+	else if (!tsec)
+		len = snprintf(value, size, "UNKNOWN");
+	else {
+		if (tsec->iac_wx != tsec->iac_r)
+			len = snprintf(value, size, "GUARD wx:%s r:%s",
+				       slm_iac_str[tsec->iac_wx],
+				       slm_iac_str[tsec->iac_r]);
+		else
+			len = snprintf(value, size, "%s",
+				       slm_iac_str[tsec->iac_wx]);
+	}
+	return min(len, size);
+}
+
+/*
+ * enforce: IWXAC(process) <= IAC(object)
+ * Permit process to execute file of equal or greater integrity
+ */
+static void enforce_integrity_execute(struct linux_binprm *bprm,
+				      struct slm_file_xattr *level)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+
+	if ((cur_tsec->iac_wx <= level->iac_level)
+	    || (level->iac_level == SLM_IAC_EXEMPT)) {
+		/* Being a guard process is not inherited */
+		spin_lock(&cur_tsec->lock);
+		cur_tsec->iac_r = cur_tsec->iac_wx;
+		spin_unlock(&cur_tsec->lock);
+	} else {
+		spin_lock(&cur_tsec->lock);
+		cur_tsec->iac_r = level->iac_level;
+		cur_tsec->iac_wx = level->iac_level;
+		spin_unlock(&cur_tsec->lock);
+
+		revoke_permissions(level);
+	}
+}
+
+static void enforce_guard_integrity_execute(struct linux_binprm *bprm,
+					    struct slm_file_xattr *level)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+
+	if ((strcmp(bprm->filename, bprm->interp) != 0)
+	    && (level->guard.unlimited))
+		level->guard.unlimited = 0;
+
+	if (level->guard.unlimited) {
+		spin_lock(&cur_tsec->lock);
+		cur_tsec->iac_r = level->guard.iac_r;
+		cur_tsec->iac_wx = level->guard.iac_wx;
+		spin_unlock(&cur_tsec->lock);
+	} else {
+		spin_lock(&cur_tsec->lock);
+		if (cur_tsec->iac_r > level->guard.iac_r)
+			cur_tsec->iac_r = level->guard.iac_r;
+		if (cur_tsec->iac_wx > level->guard.iac_wx)
+			cur_tsec->iac_wx = level->guard.iac_wx;
+		spin_unlock(&cur_tsec->lock);
+	}
+}
+
+/*
+ * enforce: SRXAC(process) >= SAC(object)
+ * Permit process to execute file of equal or lesser secrecy
+ */
+static void enforce_secrecy_execute(struct linux_binprm *bprm,
+				    struct slm_file_xattr *level)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+
+	if ((cur_tsec->sac_rx >= level->sac_level)
+	    || (level->sac_level == SLM_SAC_EXEMPT)) {
+		/* Being a guard process is not inherited */
+		spin_lock(&cur_tsec->lock);
+		cur_tsec->sac_w = cur_tsec->sac_rx;
+		spin_unlock(&cur_tsec->lock);
+	} else {
+		spin_lock(&cur_tsec->lock);
+		cur_tsec->sac_rx = level->sac_level;
+		cur_tsec->sac_w = level->sac_level;
+		spin_unlock(&cur_tsec->lock);
+
+		/* Todo: revoke write permission to lower secrecy
+		 * files.
+		 */
+	}
+}
+
+static void enforce_guard_secrecy_execute(struct linux_binprm *bprm,
+					  struct slm_file_xattr *level)
+{
+	struct slm_tsec_data *cur_tsec = current->security;
+
+	/*
+	 * set low write secrecy range,
+	 *      not less than current value, prevent leaking data
+	 */
+	spin_lock(&cur_tsec->lock);
+	cur_tsec->sac_w = cur_tsec->sac_w > level->guard.sac_w
+	    ? cur_tsec->sac_w : level->guard.sac_w;
+	/* limit secrecy range, never demote secrecy */
+	cur_tsec->sac_rx = cur_tsec->sac_rx > level->guard.sac_rx
+	    ? cur_tsec->sac_rx : level->guard.sac_rx;
+	spin_unlock(&cur_tsec->lock);
+}
+
+/*
+ * Enforce process integrity & secrecy levels.
+ * 	- update integrity process level of integrity guard program
+ * 	- update secrecy process level of secrecy guard program
+ */
+static int slm_bprm_check_security(struct linux_binprm *bprm)
+{
+	struct dentry *dentry;
+	struct slm_tsec_data *cur_tsec;
+	struct slm_file_xattr level;
+
+	cur_tsec = current->security;
+
+	/* Special case interpreters */
+	if (strcmp(bprm->filename, bprm->interp) != 0) {
+		if (!cur_tsec->script_dentry)
+			return 0;
+		else
+			dentry = cur_tsec->script_dentry;
+	} else {
+		dentry = bprm->file->f_dentry;
+		cur_tsec->script_dentry = dentry;
+	}
+
+	slm_get_level(dentry, &level);
+
+	/* slm_inode_permission measured all SYSTEM level integrity objects */
+	if (level.iac_level != SLM_IAC_SYSTEM)
+		integrity_measure(dentry, bprm->filename, MAY_EXEC);
+
+	/* Possible return codes: PERMIT, DENY, NOLABEL */
+	switch (integrity_verify_data(dentry)) {
+	case INTEGRITY_FAIL:
+		return -EACCES;
+	case INTEGRITY_NOLABEL:
+		level.iac_level = SLM_IAC_UNTRUSTED;
+	}
+
+	enforce_integrity_execute(bprm, &level);
+	if (is_guard_integrity(&level))
+		enforce_guard_integrity_execute(bprm, &level);
+
+	enforce_secrecy_execute(bprm, &level);
+	if (is_guard_secrecy(&level))
+		enforce_guard_secrecy_execute(bprm, &level);
+
+	return 0;
+}
+
+static int slm_ptrace(struct task_struct *parent, struct task_struct *child)
+{
+	struct slm_tsec_data *parent_tsec, *child_tsec;
+
+	parent_tsec = parent->security;
+	child_tsec = child->security;
+	if (parent_tsec->iac_wx < child_tsec->iac_wx)
+		return -EPERM;
+	return 0;
+}
+
+static int slm_shm_alloc_security(struct shmid_kernel *shp)
+{
+	struct slm_isec_data *isec;
+	struct slm_tsec_data *cur_tsec = current->security;
+	struct kern_ipc_perm *perm = &shp->shm_perm;
+
+	isec = slm_alloc_security();
+	if (!isec)
+		return -ENOMEM;
+
+	if (cur_tsec->iac_wx != cur_tsec->iac_r) {	/* guard process */
+		isec->level.iac_level = SLM_IAC_EXEMPT;
+		isec->level.sac_level = SLM_SAC_EXEMPT;
+	} else {
+		isec->level.iac_level = cur_tsec->iac_wx;
+		isec->level.sac_level = cur_tsec->sac_w;
+	}
+	perm->security = isec;
+
+	return 0;
+}
+
+static void slm_shm_free_security(struct shmid_kernel *shp)
+{
+	struct kern_ipc_perm *perm = &shp->shm_perm;
+	struct slm_isec_data *isec = perm->security;
+
+	perm->security = NULL;
+	kfree(isec);
+}
+
+/*
+ *  When shp exists called holding perm->lock
+ */
+static int slm_shm_shmctl(struct shmid_kernel *shp, int cmd)
+{
+	struct kern_ipc_perm *perm;
+	struct slm_isec_data *perm_isec;
+	struct file *file;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	if (!shp)
+		return 0;
+
+	perm = &shp->shm_perm;
+	perm_isec = perm->security;
+	file = shp->shm_file;
+	dentry = file->f_dentry;
+	inode = dentry->d_inode;
+
+	if (!perm_isec) {
+		perm_isec = slm_alloc_security();
+		if (!perm_isec)
+			return -ENOMEM;
+		perm->security = perm_isec;
+		if (is_exempt(inode)) {
+			perm_isec->level.iac_level = SLM_IAC_EXEMPT;
+			perm_isec->level.sac_level = SLM_SAC_EXEMPT;
+		} else if (S_ISSOCK(inode->i_mode))
+			get_sock_level(dentry, &perm_isec->level);
+		else 
+			get_level(dentry, &perm_isec->level);
+	}
+
+	return slm_set_taskperm(MAY_READ | MAY_WRITE, &perm_isec->level);
+}
+
+/*
+ * Called holding perm->lock
+ */
+static int slm_shm_shmat(struct shmid_kernel *shp,
+			 char __user * shmaddr, int shmflg)
+{
+	int mask = MAY_READ;
+	int rc;
+	struct kern_ipc_perm *perm = &shp->shm_perm;
+	struct file *file = shp->shm_file;
+	struct dentry *dentry = file->f_dentry;
+	struct inode *inode = dentry->d_inode;
+	struct slm_isec_data *perm_isec = perm->security,
+	    *isec = inode->i_security;
+
+	if (shmflg != SHM_RDONLY)
+		mask |= MAY_WRITE;
+
+	if (!perm_isec) {
+		perm_isec = slm_alloc_security();
+		if (!perm_isec)
+			return -ENOMEM;
+		perm->security = perm_isec;
+		if (is_exempt(inode)) {
+			perm_isec->level.iac_level = SLM_IAC_EXEMPT;
+			perm_isec->level.sac_level = SLM_SAC_EXEMPT;
+		} else if (S_ISSOCK(inode->i_mode))
+			get_sock_level(dentry, &perm_isec->level);
+		else 
+			get_level(dentry, &perm_isec->level);
+	}
+
+	rc = slm_set_taskperm(mask, &perm_isec->level);
+
+	spin_lock(&isec->lock);
+	memcpy(&isec->level, &perm_isec->level, sizeof(struct slm_file_xattr));
+	spin_unlock(&isec->lock);
+
+	return rc;
+}
+
+static struct security_operations slm_security_ops = {
+	.bprm_check_security = slm_bprm_check_security,
+	.file_permission = slm_file_permission,
+	.inode_permission = slm_inode_permission,
+	.inode_unlink = slm_inode_unlink,
+	.inode_create = slm_inode_create,
+	.inode_mkdir = slm_inode_mkdir,
+	.inode_rename = slm_inode_rename,
+	.inode_setxattr = slm_inode_setxattr,
+	.inode_post_setxattr = slm_inode_post_setxattr,
+	.inode_removexattr = slm_inode_removexattr,
+	.inode_alloc_security = slm_inode_alloc_security,
+	.inode_free_security = slm_inode_free_security,
+	.inode_init_security = slm_inode_init_security,
+	.socket_create = slm_socket_create,
+	.socket_post_create = slm_socket_post_create,
+	.task_alloc_security = slm_task_alloc_security,
+	.task_free_security = slm_task_free_security,
+	.task_post_setuid = slm_task_post_setuid,
+	.ptrace = slm_ptrace,
+	.shm_alloc_security = slm_shm_alloc_security,
+	.shm_free_security = slm_shm_free_security,
+	.shm_shmat = slm_shm_shmat,
+	.shm_shmctl = slm_shm_shmctl,
+	.getprocattr = slm_getprocattr,
+	.setprocattr = slm_setprocattr,
+	.d_instantiate = slm_d_instantiate
+};
+
+static int __init init_slm(void)
+{
+	char *security_prefix = "security.";
+	int error;
+
+	error = strncmp(slm_xattr_name, security_prefix,
+			strlen(security_prefix));
+	if (error != 0)
+		return -EINVAL;
+
+	error = slm_init_secfs();
+	if (error < 0)
+		return error;
+
+	if (register_security(&slm_security_ops)) {
+		if (mod_reg_security(MY_NAME, &slm_security_ops)) {
+			slm_cleanup_secfs();
+			return -EINVAL;
+		}
+		secondary = 1;
+	}
+	return 0;
+}
+
+static void __exit cleanup_slm(void)
+{
+	slm_cleanup_secfs();
+	if (secondary)
+		mod_unreg_security(MY_NAME, &slm_security_ops);
+	else
+		unregister_security(&slm_security_ops);
+}
+
+module_init(init_slm);
+module_exit(cleanup_slm);
+
+MODULE_LICENSE("GPL");


