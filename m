Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWILR60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWILR60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWILR6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:58:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:17566 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030319AbWILR6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:58:11 -0400
Subject: [PATCH 6/7] SLIM: debug output
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>, akpm@osdl.org
Content-Type: text/plain
Date: Tue, 12 Sep 2006 10:58:05 -0700
Message-Id: <1158083885.18137.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains all the necessary pieces to add debugging output to
SLIM.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
--- 
 security/slim/slim.h      |   15 +
 security/slim/slm_main.c  |  356 +++++++++++++++++++++++++++++++-----
 security/slim/slm_secfs.c |  103 ++++++++++
 3 files changed, 429 insertions(+), 45 deletions(-)

--- linux-2.6.18-rc1-dbg/security/slim/slim.h	2006-07-21 15:36:52.000000000 -0500
+++ linux-2.6.18-rc1-dbg/security/slim/slim.h	2006-07-21 15:35:21.000000000 -0500
@@ -100,3 +100,18 @@ extern int slm_init_config(void);
 
 extern __init int slm_init_secfs(void);
 extern __exit void slm_cleanup_secfs(void);
+
+extern __init int slm_init_debugfs(void);
+extern __exit void slm_cleanup_debugfs(void);
+
+extern unsigned int slm_debug;
+enum slm_debug_level {
+	SLM_BASE = 1, 
+	SLM_INTEGRITY = 2, 
+	SLM_VERBOSE = 8,
+};
+
+#undef dprintk
+#define dprintk(level, format, a...) \
+	if (slm_debug & level) \
+		printk(KERN_INFO format, ##a)
--- linux-test/security/slim/slm_secfs.c	2006-09-06 11:14:07.000000000 -0700
+++ linux-test/security/slim/slm_secfs.c	2006-09-06 11:19:20.000000000 -0700
@@ -19,6 +19,7 @@
 #include "slim.h"
 
 static struct dentry *slim_sec_dir, *slim_level;
+static struct dentry *slim_debug_dir, *slim_integrity, *slim_verbose;
 
 static ssize_t slm_read_level(struct file *file, char __user *buf,
 			      size_t buflen, loff_t *ppos)
@@ -42,10 +44,76 @@ static ssize_t slm_read_level(struct fil
 	return simple_read_from_buffer(buf, buflen, ppos, data, len);
 }
 
+static int slm_open_debug(struct inode *inode, struct file *file)
+{
+	if (inode->u.generic_ip)
+		file->private_data = inode->u.generic_ip;
+	return 0;
+}
+
+static ssize_t slm_read_debug(struct file *file, char __user * buf,
+			      size_t buflen, loff_t * ppos)
+{
+	ssize_t len = 0;
+	enum slm_debug_level type = (enum slm_debug_level)file->private_data;
+	char *page = (char *)__get_free_page(GFP_KERNEL);
+
+	if (!page)
+		return -ENOMEM;
+
+	switch(type) {
+	case SLM_INTEGRITY:
+		len = sprintf(page, "slm_debug: integrity %s\n",
+			      ((slm_debug & SLM_INTEGRITY) == SLM_INTEGRITY)
+			      ? "ON" : "OFF");
+		break;
+	case SLM_VERBOSE:
+		len = sprintf(page, "evm_debug: verbose %s\n",
+			      ((slm_debug & SLM_VERBOSE) == SLM_VERBOSE)
+			      ? "ON" : "OFF");
+		break;
+	default:
+		break;
+	}
+	len = simple_read_from_buffer(buf, buflen, ppos, page, len);
+	free_page((unsigned long)page);
+	return len;
+}
+
+static ssize_t slm_write_debug(struct file *file, const char __user * buf,
+			       size_t buflen, loff_t * ppos)
+{
+	char flag;
+	enum slm_debug_level type = (enum slm_debug_level)file->private_data;
+
+	if (copy_from_user(&flag, buf, 1))
+		return -EFAULT;
+
+	switch(type) {
+	case SLM_INTEGRITY:
+		slm_debug = (flag == '0') ? slm_debug & ~SLM_INTEGRITY :
+		    slm_debug | SLM_INTEGRITY;
+		break;
+	case SLM_VERBOSE:
+		slm_debug = (flag == '0') ? slm_debug & ~SLM_VERBOSE :
+		    slm_debug | SLM_VERBOSE;
+		break;
+	default:
+		break;
+	}
+	return buflen;
+}
+
 static struct file_operations slm_level_ops = {
 	.read = slm_read_level,
 };
 
+static struct file_operations slm_debug_ops = {
+	.read = slm_read_debug,
+	.write = slm_write_debug,
+	.open = slm_open_debug,
+};
+
 int __init slm_init_secfs(void)
 {
 	if (!slim_enabled)
@@ -65,9 +133,45 @@ int __init slm_init_secfs(void)
 
 __initcall(slm_init_secfs);
 
+int __init slm_init_debugfs(void)
+{
+	if (!slim_enabled)
+		return 0;
+
+	slim_debug_dir = debugfs_create_dir("slim", NULL);
+	if (!slim_debug_dir || IS_ERR(slim_debug_dir))
+		return -EFAULT;
+	
+	slim_integrity = debugfs_create_file("integrity", S_IRUSR | S_IRGRP,
+					     slim_debug_dir, (void *)SLM_INTEGRITY,
+					     &slm_debug_ops);
+	if (!slim_integrity || IS_ERR(slim_integrity))
+		goto out_del_debugdir;
+	slim_verbose = debugfs_create_file("verbose", S_IRUSR | S_IRGRP,
+					   slim_debug_dir, (void *)SLM_VERBOSE,
+					   &slm_debug_ops);
+	if (!slim_verbose || IS_ERR(slim_verbose))
+		goto out_del_integrity;
+	return 0;
+
+out_del_integrity:
+	debugfs_remove(slim_integrity);
+out_del_debugdir:
+	debugfs_remove(slim_debug_dir);
+	return -EFAULT;
+}
+
+__initcall(slm_init_debugfs);
+
 void __exit slm_cleanup_secfs(void)
 {
 	securityfs_remove(slim_level);
 	securityfs_remove(slim_sec_dir);
 }
 
+void __exit slm_cleanup_debugfs(void)
+{
+	debugfs_remove(slim_verbose);
+	debugfs_remove(slim_integrity);
+	debugfs_remove(slim_debug_dir);
+}
--- linux-test/security/slim/slm_main.c	2006-09-06 10:46:22.000000000 -0700
+++ linux-test/security/slim/slm_main.c	2006-09-06 11:19:32.000000000 -0700
@@ -29,6 +29,7 @@
 
 #include "slim.h"
 
+unsigned int slm_debug = SLM_BASE;
 #define XATTR_NAME "security.slim.level"
 
 #define ZERO_STR "0"
@@ -121,8 +122,13 @@ static inline int mark_has_file_wperm(st
 
 	isec = inode->i_security;
 	spin_lock(&isec->lock);
-	if (is_lower_integrity(cur_level, &isec->level))
+	if (is_lower_integrity(cur_level, &isec->level)) {
 		rc = 1;
+		if (file->f_dentry->d_name.name)
+			dprintk(SLM_BASE, "pid %d - has write perm "
+				"for %s\n", current->pid,
+				file->f_dentry->d_name.name);
+	}
 	spin_unlock(&isec->lock);
 	return rc;
 }
@@ -174,11 +180,18 @@ static inline void do_revoke_mmap_wperm(
 	unsigned long start = mpnt->vm_start;
 	unsigned long end = mpnt->vm_end;
 	size_t len = end - start;
+ 	struct dentry *dentry = mpnt->vm_file->f_dentry;
 
 	if ((mpnt->vm_flags & (VM_WRITE | VM_MAYWRITE))
 	    && (mpnt->vm_flags & VM_SHARED)
-	    && (cur_level->iac_level < isec->level.iac_level))
-		do_mprotect(start, len, PROT_READ);
+	    && (cur_level->iac_level < isec->level.iac_level)) {
+		dprintk(SLM_BASE,
+			"%s: pid %d - revoking write"
+			" perm for %s\n", __FUNCTION__,
+			current->pid, dentry->d_name.name);
+		if (do_mprotect(start, len, PROT_READ) < 0)
+			dprintk(SLM_BASE, "do_mprotect failed");
+ 	}
 }
 
 /*
@@ -305,11 +318,22 @@ static int slm_get_xattr(struct dentry *
 	rc = integrity_verify_metadata(dentry, XATTR_NAME,
 				       &xattr_value, &xattr_len, status);
 
-	if (rc >=0 && *status == INTEGRITY_PASS && xattr_value) {
+	if (rc < 0 && rc != -EOPNOTSUPP) {
+		dprintk(SLM_BASE,
+			"%s integrity_verify_metadata failed "
+			"(rc: %d - status: %d)\n",
+			dentry->d_name.name, rc, *status);
+
+	} else if (rc >=0 && *status == INTEGRITY_PASS && xattr_value) {
 		rc = slm_parse_xattr(xattr_value, xattr_len, level);
 		kfree(xattr_value);
-		if (rc == 0 && level->iac_level != SLM_IAC_UNTRUSTED)
+		if (rc == 0 && level->iac_level != SLM_IAC_UNTRUSTED) {
 			rc = integrity_verify_data(dentry, status);
+			if ((rc < 0) || (*status != INTEGRITY_PASS))
+				dprintk(SLM_BASE, "%s integrity_verify_data failed "
+				" (rc: %d status: %d)\n", dentry->d_name.name,
+					rc, *status);
+		}
 	}
 	return rc;
 }
@@ -348,9 +372,12 @@ static void update_sock_level(struct den
 	int rc, status = 0;
 
 	rc = slm_get_xattr(dentry, level, &status);
-	if (rc == -EOPNOTSUPP)
+	if (rc == -EOPNOTSUPP) {
+		dprintk(SLM_INTEGRITY, "%s:%s - slm_get_xattr "
+			"not supported pid %d\n", __FUNCTION__,
+			dentry->d_name.name, current->pid);
 		set_level_exempt(level);
-	else
+	} else
 		set_level_tsec_read(level, cur_tsec);
 }
 
@@ -373,6 +400,8 @@ static void update_level(struct dentry *
 		switch(status) {
 			case INTEGRITY_FAIL:
 			case INTEGRITY_NOLABEL:
+				dprintk(SLM_INTEGRITY, "%s: %s FAIL/NOLABEL (%d)\n",
+				__FUNCTION__, dentry->d_name.name, rc);
 				set_level_untrusted(level);
 				break;
 		}
@@ -417,6 +446,8 @@ static void slm_get_level(struct dentry 
 		spin_lock(&isec->lock);
 		memcpy(level, &isec->level, sizeof(struct slm_file_xattr));
 		spin_unlock(&isec->lock);
+		dprintk(SLM_VERBOSE, "%s: %s level %d \n", __FUNCTION__,
+			dentry->d_name.name, level->iac_level);
 		return;
 	}
 
@@ -445,6 +476,9 @@ static struct slm_tsec_data *slm_init_ta
 		return NULL;
 	tsec->lock = SPIN_LOCK_UNLOCKED;
 	if (!cur_tsec) {
+		dprintk(SLM_VERBOSE,
+			"%s: pid %d current->pid %d cur_tsec\n",
+			__FUNCTION__, tsk->pid, current->pid);
 		tsec->iac_r = SLM_IAC_HIGHEST - 1;
 		tsec->iac_wx = SLM_IAC_HIGHEST - 1;
 	} else
@@ -481,7 +515,10 @@ static int is_iac_greater_than_or_exempt
  * Permit process to read file of equal or greater integrity
  * otherwise, demote the process.
  */
-static int enforce_integrity_read(struct slm_file_xattr *level)
+static int enforce_integrity_read(struct slm_file_xattr *level,
+				   const unsigned char *name,
+				   struct task_struct *parent_tsk,
+				   struct slm_tsec_data *parent_tsec)
 {
 	struct slm_tsec_data *cur_tsec = current->security;
 	int rc = 0;
@@ -491,10 +528,31 @@ static int enforce_integrity_read(struct
 		rc = has_file_wperm(level);
 		if (atomic_read(&current->mm->mm_users) != 1)
 			rc = 1;
-		if (rc)
+		if (rc) {
+			dprintk(SLM_BASE, "ppid %d(%s p=%d-%s) "
+				" pid %d(%s p=%d-%s) can't revoke, not demoting\n",
+				parent_tsk->pid, parent_tsk->comm,
+				parent_tsec->iac_r,
+				(parent_tsec->iac_wx != parent_tsec->iac_r)
+				? "GUARD" : slm_iac_str[parent_tsec-> iac_r],
+				current->pid, current->comm,
+				cur_tsec->iac_r, (cur_tsec->iac_wx != cur_tsec->iac_r)
+				? "GUARD" : slm_iac_str[cur_tsec->iac_r]);
 			spin_unlock(&cur_tsec->lock);
-		else {
+		} else {
 			/* Reading lower integrity, demote process */
+			dprintk(SLM_BASE, "ppid %d(%s p=%d-%s) "
+				" pid %d(%s p=%d-%s) demoting integrity to"
+				" iac=%d-%s(%s)\n",
+				parent_tsk->pid, parent_tsk->comm,
+				parent_tsec->iac_r,
+				(parent_tsec->iac_wx != parent_tsec->iac_r)
+				? "GUARD" : slm_iac_str[parent_tsec-> iac_r],
+				current->pid, current->comm,
+				cur_tsec->iac_r, (cur_tsec->iac_wx != cur_tsec->iac_r)
+				? "GUARD" : slm_iac_str[cur_tsec->iac_r],
+				level->iac_level, slm_iac_str[level->iac_level], name);
+
 			/* Even in the case of a integrity guard process. */
 			cur_tsec->iac_r = level->iac_level;
 			cur_tsec->iac_wx = level->iac_level;
@@ -507,42 +565,82 @@ static int enforce_integrity_read(struct
 	return 0;
 }
 
-static int do_task_may_read(struct slm_file_xattr *level)
+static int do_task_may_read(struct slm_file_xattr *level,
+			     const unsigned char *name,
+			     struct task_struct *parent_tsk,
+			     struct slm_tsec_data *parent_tsec)
 {
-	return enforce_integrity_read(level);
+	return enforce_integrity_read(level, name, parent_tsk, parent_tsec);
 }
 
 /*
  * enforce: IWXAC(process) >= IAC(object)
  * Permit process to write a file of equal or lesser integrity.
  */
-static int enforce_integrity_write(struct slm_file_xattr *level)
+static int enforce_integrity_write(struct slm_file_xattr *level,
+				   const unsigned char *name,
+				   struct task_struct *parent_tsk,
+				   struct slm_tsec_data *parent_tsec)
 {
 	struct slm_tsec_data *cur_tsec = current->security;
 	int rc = 0;
 
 	spin_lock(&cur_tsec->lock);
 	if (!(is_iac_greater_than_or_exempt(level, cur_tsec->iac_wx)
-	      || (level->iac_level == SLM_IAC_NOTDEFINED)))
+	      || (level->iac_level == SLM_IAC_NOTDEFINED))) {
 		/* can't write higher integrity */
+		dprintk(SLM_BASE, "ppid %d(%s p=%d-%s) "
+			"pid %d(%s p=%d-%s) can't write higher "
+			"integrity iac=%d-%s(%s)\n",
+			parent_tsk->pid, parent_tsk->comm,
+			parent_tsec->iac_wx,
+			(parent_tsec->iac_wx != parent_tsec->iac_r)
+			? "GUARD" : slm_iac_str[parent_tsec->
+						iac_wx],
+			current->pid, current->comm,
+			cur_tsec->iac_wx, (cur_tsec->iac_wx != cur_tsec->iac_r)
+			? "GUARD" : slm_iac_str[cur_tsec->iac_wx],
+			level->iac_level, slm_iac_str[level->iac_level], name);
 		rc = -EACCES;
+	}
 	spin_unlock(&cur_tsec->lock);
 	return rc;
 }
 
-static int do_task_may_write(struct slm_file_xattr *level)
+static int do_task_may_write(struct slm_file_xattr *level,
+			     const unsigned char *name,
+			     struct task_struct *parent_tsk,
+			     struct slm_tsec_data *parent_tsec)
 {
-	return enforce_integrity_write(level);
+	return enforce_integrity_write(level, name, parent_tsk, parent_tsec);
 }
 
-static int slm_set_taskperm(int mask, struct slm_file_xattr *level)
+static int slm_set_taskperm(int mask, struct slm_file_xattr *level,
+			    const unsigned char *name)
 {
+	struct task_struct *parent_tsk = current->parent, new_tsk;
+	struct slm_tsec_data *parent_tsec = NULL, new_tsec;
 	int rc = 0;
 
+	if (parent_tsk)
+		parent_tsec = parent_tsk->security;
+	else {
+		printk(KERN_INFO
+		       "%s: current pid %d: parent_tsk is null\n",
+		       __FUNCTION__, current->pid);
+		memset(&new_tsk, 0, sizeof(struct task_struct));
+		parent_tsk = &new_tsk;
+	}
+
+	if (!parent_tsec) {
+		memset(&new_tsec, 0, sizeof(struct slm_tsec_data));
+		parent_tsec = &new_tsec;
+	}
+
 	if (mask & MAY_READ)
-		rc = do_task_may_read(level);
+		rc = do_task_may_read(level, name, parent_tsk, parent_tsec);
 	if ((mask & MAY_WRITE) || (mask & MAY_APPEND))
-		rc |= do_task_may_write(level);
+		rc |= do_task_may_write(level, name, parent_tsk, parent_tsec);
 
 	return rc;
 }
@@ -562,15 +660,21 @@ static int slm_file_permission(struct fi
 	return 0;
 }
 
-static int is_untrusted_blk_access(struct inode *inode)
+static int is_untrusted_blk_access(struct inode *inode,
+				   const unsigned char *fname)
 {
 	struct slm_tsec_data *cur_tsec = current->security;
 	int rc = 0;
 
 	spin_lock(&cur_tsec->lock);
 	if (cur_tsec && (cur_tsec->iac_wx == SLM_IAC_UNTRUSTED)
-	    && S_ISBLK(inode->i_mode))
+	    && S_ISBLK(inode->i_mode)) {
+		dprintk(SLM_BASE, "pid %d(%s p=%d-%s) deny access %s\n",
+			current->pid, current->comm,
+			cur_tsec->iac_wx, (cur_tsec->iac_wx != cur_tsec->iac_r)
+			? "GUARD" : slm_iac_str[cur_tsec->iac_wx], fname);
 		rc = 1;
+	}
 	spin_unlock(&cur_tsec->lock);
 	return rc;
 }
@@ -583,8 +687,11 @@ static int is_untrusted_blk_access(struc
 static int slm_inode_permission(struct inode *inode, int mask,
 				struct nameidata *nd)
 {
+	char *path = NULL;
+	const unsigned char *fname = NULL;
 	struct dentry *dentry = NULL;
 	struct slm_file_xattr level;
+	int rc = 0;
 
 	if (S_ISDIR(inode->i_mode) && (mask & MAY_WRITE))
 		return 0;
@@ -593,16 +700,33 @@ static int slm_inode_permission(struct i
 	if (!dentry)
 		return 0;
 
-	if (is_untrusted_blk_access(inode))
-		return -EPERM;
+	if (nd) {		/* preferably use fullname */
+		path = (char *)__get_free_page(GFP_KERNEL);
+		if (path)
+			fname = d_path(nd->dentry, nd->mnt, path, PAGE_SIZE);
+	}
+
+	if (!fname)		/* no choice, use short name */
+		fname = (!dentry->d_name.name) ? dentry->d_iname :
+		    dentry->d_name.name;
+
+	if (is_untrusted_blk_access(inode, fname)) {
+		rc = -EPERM;
+		goto out;
+	}
 
 	slm_get_level(dentry, &level);
 
 	/* measure all SYSTEM level integrity objects */
 	if (level.iac_level == SLM_IAC_SYSTEM)
-		integrity_measure(dentry, NULL, mask);
+		integrity_measure(dentry, fname, mask);
 
-	return slm_set_taskperm(mask, &level);
+	rc = slm_set_taskperm(mask, &level, fname);
+
+out:
+	if (path)
+		free_page((unsigned long)path);
+	return rc;
 }
 
 /* 
@@ -616,7 +740,7 @@ static int slm_inode_unlink(struct inode
 		return 0;
 
 	slm_get_level(dentry, &level);
-	return slm_set_taskperm(MAY_WRITE, &level);
+	return slm_set_taskperm(MAY_WRITE, &level, dentry->d_name.name);
 }
 
 static void slm_inode_free_security(struct inode *inode)
@@ -644,8 +768,15 @@ static int slm_inode_create(struct inode
 	 */
 	spin_lock(&cur_tsec->lock);
 	spin_lock(&parent_isec->lock);
-	if (!is_iac_greater_than_or_exempt(parent_level, cur_tsec->iac_wx))
+	if (!is_iac_greater_than_or_exempt(parent_level, cur_tsec->iac_wx)) {
+		dprintk(SLM_INTEGRITY, "%s: prohibit current %s level "
+			"process writing into %s (%s level directory)\n",
+			__FUNCTION__, slm_iac_str[cur_tsec->iac_wx],
+			(!dentry->d_name.name)
+			? " " : (char *)dentry->d_name.name,
+			slm_iac_str[parent_level->iac_level]);
 		rc = -EPERM;
+	}
 	spin_unlock(&parent_isec->lock);
 	spin_unlock(&cur_tsec->lock);
 	return rc;
@@ -713,6 +844,8 @@ static int slm_inode_init_security(struc
 		spin_lock(&parent_isec->lock);
 		memcpy(&level, &parent_isec->level,
 		       sizeof(struct slm_file_xattr));
+		dprintk(SLM_VERBOSE, "%s: level %d\n", __FUNCTION__,
+			parent_isec->level.iac_level);
 		spin_unlock(&parent_isec->lock);
 	}
 
@@ -793,9 +926,17 @@ static int slm_inode_mkdir(struct inode 
 
 	spin_lock(&cur_tsec->lock);
 	spin_lock(&parent_isec->lock);
-	if (cur_tsec->iac_wx < parent_level->iac_level
-	    && parent_level->iac_level == SLM_IAC_SYSTEM)
-		rc = -EACCES;
+	if (cur_tsec->iac_wx < parent_level->iac_level) {
+		if (parent_level->iac_level == SLM_IAC_SYSTEM)
+			rc = -EACCES;
+		else
+			dprintk(SLM_VERBOSE, "%s:ppid %d (%s) %s - creating"
+				" lower integrity directory, than parent\n",
+				__FUNCTION__, current->pid, current->comm,
+				(!dentry->d_name.name)
+				? "" : (char *)dentry->d_name.name);
+
+	}
 	spin_unlock(&parent_isec->lock);
 	spin_unlock(&cur_tsec->lock);
 	return rc;
@@ -817,8 +958,13 @@ static int slm_inode_rename(struct inode
 	slm_get_level(parent_dentry, &parent_level);
 	dput(parent_dentry);
 
-	if (is_lower_integrity(&old_level, &parent_level))
+	if (is_lower_integrity(&old_level, &parent_level)) {
+		dprintk(SLM_BASE, "%s: prohibit rename of %s (low"
+			" integrity) into %s (higher level directory)\n",
+			__FUNCTION__, old_dentry->d_name.name,
+			parent_dentry->d_name.name);
 		return -EPERM;
+	}
 	return 0;
 }
 
@@ -840,6 +986,10 @@ int slm_inode_setxattr(struct dentry *de
 	if (!value)
 		return -EINVAL;
 
+	dprintk(SLM_VERBOSE, "%s: name %s value %s process:iac_r %s "
+		"iac_wx %s\n", __FUNCTION__, name, (char *)value,
+		slm_iac_str[cur_tsec->iac_r], slm_iac_str[cur_tsec->iac_wx]);
+
 	spin_lock(&cur_tsec->lock);
 	iac = cur_tsec->iac_wx;
 	spin_unlock(&cur_tsec->lock);
@@ -950,9 +1100,18 @@ int slm_socket_create(int family, int ty
 			if (atomic_read(&current->mm->mm_users) != 1)
 				rc = 1;
 			if (rc) {
+				dprintk(SLM_BASE,
+					"%s: ppid %d pid %d can't revoke, refusing socket\n",
+					__FUNCTION__, parent_tsk->pid, current->pid);
 				spin_unlock(&cur_tsec->lock);
 				return -EPERM;
 			} else {
+				dprintk(SLM_INTEGRITY,
+					"%s: ppid %d pid %d demoting "
+					"family %d type %d protocol %d kern %d"
+					" to untrusted.\n", __FUNCTION__,
+					parent_tsk->pid, current->pid, family,
+					type, protocol, kern);
 				cur_tsec->iac_r = SLM_IAC_UNTRUSTED;
 				cur_tsec->iac_wx = SLM_IAC_UNTRUSTED;
 				spin_unlock(&cur_tsec->lock);
@@ -1039,16 +1198,37 @@ static int slm_task_post_setuid(uid_t ol
 
 	if (cur_tsec && flags == LSM_SETID_ID) {
 		/*set process to USER level integrity for everything but root */
+		dprintk(SLM_VERBOSE, "ruid %d euid %d suid %d "
+			"cur: uid %d euid %d suid %d\n",
+			old_ruid, old_euid, old_suid,
+			current->uid, current->euid, current->suid);
 		spin_lock(&cur_tsec->lock);
 		if ((cur_tsec->iac_r == cur_tsec->iac_wx)
-		    && (cur_tsec->iac_r == SLM_IAC_UNTRUSTED));
-		else if (current->suid != 0) {
+		    && (cur_tsec->iac_r == SLM_IAC_UNTRUSTED)) {
+			dprintk(SLM_INTEGRITY,
+				"Integrity: pid %d iac_r %d "
+				" iac_wx %d remains UNTRUSTED\n",
+				current->pid, cur_tsec->iac_r,
+				cur_tsec->iac_wx);
+		} else if (current->suid != 0) {
+			dprintk(SLM_INTEGRITY, "setting: pid %d iac_r %d "
+				" iac_wx %d to USER\n",
+				current->pid, cur_tsec->iac_r,
+				cur_tsec->iac_wx);
 			cur_tsec->iac_r = SLM_IAC_USER;
 			cur_tsec->iac_wx = SLM_IAC_USER;
 		} else if ((current->uid == 0) && (old_ruid != 0)) {
+			dprintk(SLM_INTEGRITY, "setting: pid %d iac_r %d "
+				" iac_wx %d to SYSTEM\n",
+				current->pid, cur_tsec->iac_r,
+				cur_tsec->iac_wx);
 			cur_tsec->iac_r = SLM_IAC_SYSTEM;
 			cur_tsec->iac_wx = SLM_IAC_SYSTEM;
-		}
+		} else
+			dprintk(SLM_INTEGRITY, "%s: pid %d iac_r %d "
+				" iac_wx %d \n", __FUNCTION__,
+				current->pid, cur_tsec->iac_r,
+				cur_tsec->iac_wx);
 		spin_unlock(&cur_tsec->lock);
 	}
 	return 0;
@@ -1057,6 +1237,7 @@ static int slm_task_post_setuid(uid_t ol
 static inline int slm_setprocattr(struct task_struct *tsk,
 				  char *name, void *value, size_t size)
 {
+	dprintk(SLM_BASE, "%s: %s \n", __FUNCTION__, name);
 	return -EACCES;
 
 }
@@ -1096,16 +1277,60 @@ static int enforce_integrity_execute(str
 	int rc = 0;
 
 	spin_lock(&cur_tsec->lock);
-	if (is_iac_less_than_or_exempt(level, cur_tsec->iac_wx))
+	if (is_iac_less_than_or_exempt(level, cur_tsec->iac_wx)) {
+		dprintk(SLM_INTEGRITY,
+			"%s: ppid %d(%s %d-%s) pid %d(%s %d-%s)"
+			" %s executing\n",
+			__FUNCTION__, parent_tsk->pid,
+			parent_tsk->comm,
+			(!parent_tsec) ? 0 : parent_tsec->iac_wx,
+			(parent_tsec->iac_wx != parent_tsec->iac_r)
+			? "GUARD" : slm_iac_str[parent_tsec->
+						iac_wx],
+			current->pid, current->comm,
+			cur_tsec->iac_wx,
+			(cur_tsec->iac_wx != cur_tsec->iac_r)
+			? "GUARD" : slm_iac_str[cur_tsec->iac_wx],
+			bprm->filename);
+
 		/* Being a guard process is not inherited */
 		cur_tsec->iac_r = cur_tsec->iac_wx;
-	else {
+	} else {
 		rc = has_file_wperm(level);
 		if (atomic_read(&current->mm->mm_users) != 1)
 			rc = 1;
-		if (rc)
+		if (rc) {
+			dprintk(SLM_BASE,
+				"%s: ppid %d(%s %d-%s) pid %d(%s %d-%s)"
+				" %s can't revoke, deny execution\n",
+				__FUNCTION__, parent_tsk->pid,
+				parent_tsk->comm, parent_tsec->iac_wx,
+				(parent_tsec->iac_wx != parent_tsec->iac_r)
+				? "GUARD" : slm_iac_str[parent_tsec->
+						iac_wx],
+				current->pid, current->comm,
+				cur_tsec->iac_wx,
+				(cur_tsec->iac_wx != cur_tsec->iac_r)
+				? "GUARD" : slm_iac_str[cur_tsec->iac_wx],
+				bprm->filename);
 			spin_unlock(&cur_tsec->lock);
-		else {
+		} else {
+			dprintk(SLM_BASE,
+				"%s: ppid %d(%s %d-%s) pid %d(%s %d-%s)"
+				" %s executing, demoting integrity to "
+				" iac=%d-%s\n",
+				__FUNCTION__, parent_tsk->pid,
+				parent_tsk->comm, parent_tsec->iac_wx,
+				(parent_tsec->iac_wx != parent_tsec->iac_r)
+				? "GUARD" : slm_iac_str[parent_tsec->
+						iac_wx],
+				current->pid, current->comm,
+				cur_tsec->iac_wx,
+				(cur_tsec->iac_wx != cur_tsec->iac_r)
+				? "GUARD" : slm_iac_str[cur_tsec->iac_wx],
+				bprm->filename, level->iac_level,
+				slm_iac_str[level->iac_level]);
+
 			cur_tsec->iac_r = level->iac_level;
 			cur_tsec->iac_wx = level->iac_level;
 			spin_unlock(&cur_tsec->lock);
@@ -1121,9 +1346,25 @@ static void enforce_guard_integrity_exec
 					    struct slm_file_xattr *level,
 					    struct slm_tsec_data *cur_tsec)
 {
+	struct task_struct *parent_tsk = current->parent;
+
 	if ((strcmp(bprm->filename, bprm->interp) != 0)
-	    && (level->guard.unlimited))
+	    && (level->guard.unlimited)) {
+		dprintk(SLM_INTEGRITY, "%s:pid %d %s prohibiting "
+			"script from being an unlimited guard\n",
+			__FUNCTION__, current->pid, bprm->filename);
 		level->guard.unlimited = 0;
+	}
+
+	dprintk(SLM_INTEGRITY,
+		"%s: ppid %d pid %d %s (integrity guard)"
+		"cur: r %s wx %s new: r %s wx %s %s\n",
+		__FUNCTION__, parent_tsk->pid, current->pid,
+		bprm->filename, slm_iac_str[cur_tsec->iac_r],
+		slm_iac_str[cur_tsec->iac_wx],
+		slm_iac_str[level->guard.iac_r],
+		slm_iac_str[level->guard.iac_wx],
+		(level->guard.unlimited ? "unlimited" : "limited"));
 
 	spin_lock(&cur_tsec->lock);
 	if (level->guard.unlimited) {
@@ -1153,7 +1394,13 @@ static int slm_bprm_check_security(struc
 	/* Special case interpreters */
 	spin_lock(&cur_tsec->lock);
 	if (strcmp(bprm->filename, bprm->interp) != 0) {
+		dprintk(SLM_INTEGRITY,
+			"%s: executing %s (interp: %s)\n",
+			__FUNCTION__, bprm->filename, bprm->interp);
 		if (!cur_tsec->script_dentry) {
+			dprintk(SLM_INTEGRITY,
+				"%s: NULL script_dentry %s\n",
+				__FUNCTION__, bprm->filename);
 			spin_unlock(&cur_tsec->lock);
 			return 0;
 		} else
@@ -1165,6 +1412,9 @@ static int slm_bprm_check_security(struc
 	spin_unlock(&cur_tsec->lock);
 
 	slm_get_level(dentry, &level);
+	dprintk(SLM_INTEGRITY, "%s: %s level iac %d - %s\n",
+		__FUNCTION__, bprm->filename, level.iac_level,
+		slm_iac_str[level.iac_level]);
 
 	/* slm_inode_permission measured all SYSTEM level integrity objects */
 	if (level.iac_level != SLM_IAC_SYSTEM)
@@ -1177,10 +1427,17 @@ static int slm_bprm_check_security(struc
 
 	switch(status) {
 	case INTEGRITY_FAIL:
-		if (!is_kernel_thread(current))
+		if (!is_kernel_thread(current)) {
+			dprintk(SLM_BASE,
+				"%s: %s (Integrity status: FAIL)\n",
+				__FUNCTION__, bprm->filename);
 			return -EACCES;
+		}
 		break;
 	case INTEGRITY_NOLABEL:
+		dprintk(SLM_BASE,
+			"%s: %s (Integrity status: NOLABEL)\n",
+			__FUNCTION__, bprm->filename);
 		level.iac_level = SLM_IAC_UNTRUSTED;
 	}
 
@@ -1215,9 +1472,12 @@ static inline int slm_capable(struct tas
 	/* Derived from include/linux/sched.h:capable. */
 	if (cap_raised(tsk->cap_effective, cap)) {
 		spin_lock(&tsec->lock);
-		if (tsec->iac_wx == SLM_IAC_UNTRUSTED &&
-		    cap == CAP_SYS_ADMIN)
-			rc = -EACCES;
+		if (tsec->iac_wx == SLM_IAC_UNTRUSTED) {
+			dprintk(SLM_VERBOSE, "%s: pid %d %s requested cap %d\n",
+				__FUNCTION__, tsk->pid, tsk->comm, cap);
+			if (cap == CAP_SYS_ADMIN)
+				rc = -EACCES;
+		}
 		spin_unlock(&tsec->lock);
 		return rc;
 	}
@@ -1255,6 +1515,8 @@ static int slm_shm_alloc_security(struct
 		set_level_tsec_write(&isec->level, cur_tsec);
 	spin_unlock(&cur_tsec->lock);
 	perm->security = isec;
+	dprintk(SLM_INTEGRITY, "%s: level %d \n", __FUNCTION__,
+		isec->level.iac_level);
 
 	return 0;
 }
@@ -1290,7 +1552,7 @@ static int slm_shm_shmctl(struct shmid_k
 	inode = dentry->d_inode;
 
 	spin_lock(&perm_isec->lock);
-	rc = slm_set_taskperm(MAY_READ | MAY_WRITE, &perm_isec->level);
+	rc = slm_set_taskperm(MAY_READ | MAY_WRITE, &perm_isec->level, NULL);
 	spin_unlock(&perm_isec->lock);
 	return rc;
 }
@@ -1314,8 +1576,12 @@ static int slm_shm_shmat(struct shmid_ke
 		mask |= MAY_WRITE;
 
 	spin_lock(&perm_isec->lock);
-	rc = slm_set_taskperm(mask, &perm_isec->level);
+	rc = slm_set_taskperm(mask, &perm_isec->level, NULL);
 
+	dprintk(SLM_INTEGRITY,
+		"%s: %d mask %d level %d replace %d\n",
+		__FUNCTION__, shp->id, mask,
+		perm_isec->level.iac_level, isec->level.iac_level);
 	spin_lock(&isec->lock);
 	memcpy(&isec->level, &perm_isec->level, sizeof(struct slm_file_xattr));
 	spin_unlock(&perm_isec->lock);


