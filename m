Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVHYOit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVHYOit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVHYOit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:38:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:27350 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750959AbVHYOis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:38:48 -0400
Date: Thu, 25 Aug 2005 09:38:07 -0500
From: serue@us.ibm.com
To: Chris Wright <chrisw@osdl.org>
Cc: linux-security-module@wirex.com, Greg Kroah <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
       James Morris <jmorris@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH 5/5] Remove unnecesary capability hooks in rootplug.
Message-ID: <20050825143807.GA8590@sergelap.austin.ibm.com>
References: <20050825012028.720597000@localhost.localdomain> <20050825012150.490797000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825012150.490797000@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, with the attached patch SELinux seems to work correctly.  You'll
probably want to make it a little prettier  :)  Note I have NOT ran the
ltp tests for correctness.  I'll do some performance runs, though
unfortunately can't do so on ppc right now.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com
--
 hooks.c |   93 ++++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 62 insertions(+), 31 deletions(-)

Index: linux-2.6.12/security/selinux/hooks.c
===================================================================
--- linux-2.6.12.orig/security/selinux/hooks.c	2005-08-25 12:56:51.000000000 -0500
+++ linux-2.6.12/security/selinux/hooks.c	2005-08-25 14:27:53.000000000 -0500
@@ -1352,7 +1352,7 @@ static int selinux_ptrace(struct task_st
 	struct task_security_struct *csec = child->security;
 	int rc;
 
-	rc = secondary_ops->ptrace(parent,child);
+	rc = secondary_ops->ptrace ? secondary_ops->ptrace(parent,child) : 0;
 	if (rc)
 		return rc;
 
@@ -1372,7 +1372,9 @@ static int selinux_capget(struct task_st
 	if (error)
 		return error;
 
-	return secondary_ops->capget(target, effective, inheritable, permitted);
+	return secondary_ops->capget ?
+		secondary_ops->capget(target, effective, inheritable,
+					permitted) : 0;
 }
 
 static int selinux_capset_check(struct task_struct *target, kernel_cap_t *effective,
@@ -1380,7 +1382,9 @@ static int selinux_capset_check(struct t
 {
 	int error;
 
-	error = secondary_ops->capset_check(target, effective, inheritable, permitted);
+	error = secondary_ops->capset_check ?
+		secondary_ops->capset_check(target, effective,
+			inheritable, permitted) : 0;
 	if (error)
 		return error;
 
@@ -1390,14 +1394,16 @@ static int selinux_capset_check(struct t
 static void selinux_capset_set(struct task_struct *target, kernel_cap_t *effective,
                                kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	secondary_ops->capset_set(target, effective, inheritable, permitted);
+	if (secondary_ops->capset_set)
+		secondary_ops->capset_set(target, effective, inheritable,
+		permitted);
 }
 
 static int selinux_capable(struct task_struct *tsk, int cap)
 {
 	int rc;
 
-	rc = secondary_ops->capable(tsk, cap);
+	rc = secondary_ops->capable ? secondary_ops->capable(tsk, cap) : 0;
 	if (rc)
 		return rc;
 
@@ -1412,7 +1418,7 @@ static int selinux_sysctl(ctl_table *tab
 	u32 tsid;
 	int rc;
 
-	rc = secondary_ops->sysctl(table, op);
+	rc = secondary_ops->sysctl ? secondary_ops->sysctl(table, op) : 0;
 	if (rc)
 		return rc;
 
@@ -1484,7 +1490,7 @@ static int selinux_syslog(int type)
 {
 	int rc;
 
-	rc = secondary_ops->syslog(type);
+	rc = secondary_ops->syslog ? secondary_ops->syslog(type) : 0;
 	if (rc)
 		return rc;
 
@@ -1527,7 +1533,8 @@ static int selinux_vm_enough_memory(long
 	int rc, cap_sys_admin = 0;
 	struct task_security_struct *tsec = current->security;
 
-	rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
+	rc = secondary_ops->capable ?
+		secondary_ops->capable(current, CAP_SYS_ADMIN) : 0;
 	if (rc == 0)
 		rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
 					SECCLASS_CAPABILITY,
@@ -1570,7 +1577,8 @@ static int selinux_bprm_set_security(str
 	struct avc_audit_data ad;
 	int rc;
 
-	rc = secondary_ops->bprm_set_security(bprm);
+	rc = secondary_ops->bprm_set_security ?
+		secondary_ops->bprm_set_security(bprm) : 0;
 	if (rc)
 		return rc;
 
@@ -1637,7 +1645,8 @@ static int selinux_bprm_set_security(str
 
 static int selinux_bprm_check_security (struct linux_binprm *bprm)
 {
-	return secondary_ops->bprm_check_security(bprm);
+	return secondary_ops->bprm_check_security ?
+		secondary_ops->bprm_check_security(bprm) : 0;
 }
 
 
@@ -1655,7 +1664,9 @@ static int selinux_bprm_secureexec (stru
 					 PROCESS__NOATSECURE, NULL);
 	}
 
-	return (atsecure || secondary_ops->bprm_secureexec(bprm));
+	return (atsecure ||
+		secondary_ops->bprm_secureexec ?
+			secondary_ops->bprm_secureexec(bprm) : 0);
 }
 
 static void selinux_bprm_free_security(struct linux_binprm *bprm)
@@ -1756,7 +1767,8 @@ static void selinux_bprm_apply_creds(str
 	u32 sid;
 	int rc;
 
-	secondary_ops->bprm_apply_creds(bprm, unsafe);
+	if (secondary_ops->bprm_apply_creds)
+		secondary_ops->bprm_apply_creds(bprm, unsafe);
 
 	tsec = current->security;
 
@@ -1982,7 +1994,8 @@ static int selinux_mount(char * dev_name
 {
 	int rc;
 
-	rc = secondary_ops->sb_mount(dev_name, nd, type, flags, data);
+	rc = secondary_ops->sb_mount ?
+		secondary_ops->sb_mount(dev_name, nd, type, flags, data) : 0;
 	if (rc)
 		return rc;
 
@@ -1998,7 +2011,8 @@ static int selinux_umount(struct vfsmoun
 {
 	int rc;
 
-	rc = secondary_ops->sb_umount(mnt, flags);
+	rc = secondary_ops->sb_umount ?
+		secondary_ops->sb_umount(mnt, flags) : 0;
 	if (rc)
 		return rc;
 
@@ -2032,7 +2046,8 @@ static int selinux_inode_link(struct den
 {
 	int rc;
 
-	rc = secondary_ops->inode_link(old_dentry,dir,new_dentry);
+	rc = secondary_ops->inode_link ?
+		secondary_ops->inode_link(old_dentry,dir,new_dentry) : 0;
 	if (rc)
 		return rc;
 	return may_link(dir, old_dentry, MAY_LINK);
@@ -2047,7 +2062,8 @@ static int selinux_inode_unlink(struct i
 {
 	int rc;
 
-	rc = secondary_ops->inode_unlink(dir, dentry);
+	rc = secondary_ops->inode_unlink ?
+		secondary_ops->inode_unlink(dir, dentry) : 0;
 	if (rc)
 		return rc;
 	return may_link(dir, dentry, MAY_UNLINK);
@@ -2082,7 +2098,8 @@ static int selinux_inode_mknod(struct in
 {
 	int rc;
 
-	rc = secondary_ops->inode_mknod(dir, dentry, mode, dev);
+	rc = secondary_ops->inode_mknod ?
+		secondary_ops->inode_mknod(dir, dentry, mode, dev) : 0;
 	if (rc)
 		return rc;
 
@@ -2115,7 +2132,8 @@ static int selinux_inode_follow_link(str
 {
 	int rc;
 
-	rc = secondary_ops->inode_follow_link(dentry,nameidata);
+	rc = secondary_ops->inode_follow_link ?
+		secondary_ops->inode_follow_link(dentry,nameidata) : 0;
 	if (rc)
 		return rc;
 	return dentry_has_perm(current, NULL, dentry, FILE__READ);
@@ -2126,7 +2144,8 @@ static int selinux_inode_permission(stru
 {
 	int rc;
 
-	rc = secondary_ops->inode_permission(inode, mask, nd);
+	rc = secondary_ops->inode_permission ?
+		secondary_ops->inode_permission(inode, mask, nd) : 0;
 	if (rc)
 		return rc;
 
@@ -2143,7 +2162,8 @@ static int selinux_inode_setattr(struct 
 {
 	int rc;
 
-	rc = secondary_ops->inode_setattr(dentry, iattr);
+	rc = secondary_ops->inode_setattr ?
+		secondary_ops->inode_setattr(dentry, iattr) : 0;
 	if (rc)
 		return rc;
 
@@ -2453,7 +2473,8 @@ static int selinux_file_mmap(struct file
 {
 	int rc;
 
-	rc = secondary_ops->file_mmap(file, reqprot, prot, flags);
+	rc = secondary_ops->file_mmap ?
+		secondary_ops->file_mmap(file, reqprot, prot, flags) : 0;
 	if (rc)
 		return rc;
 
@@ -2470,7 +2491,8 @@ static int selinux_file_mprotect(struct 
 {
 	int rc;
 
-	rc = secondary_ops->file_mprotect(vma, reqprot, prot);
+	rc = secondary_ops->file_mprotect ?
+		secondary_ops->file_mprotect(vma, reqprot, prot) : 0;
 	if (rc)
 		return rc;
 
@@ -2610,7 +2632,8 @@ static int selinux_task_create(unsigned 
 {
 	int rc;
 
-	rc = secondary_ops->task_create(clone_flags);
+	rc = secondary_ops->task_create ?
+		secondary_ops->task_create(clone_flags) : 0;
 	if (rc)
 		return rc;
 
@@ -2662,7 +2685,8 @@ static int selinux_task_setuid(uid_t id0
 
 static int selinux_task_post_setuid(uid_t id0, uid_t id1, uid_t id2, int flags)
 {
-	return secondary_ops->task_post_setuid(id0,id1,id2,flags);
+	return secondary_ops->task_post_setuid ?
+		secondary_ops->task_post_setuid(id0,id1,id2,flags) : 0;
 }
 
 static int selinux_task_setgid(gid_t id0, gid_t id1, gid_t id2, int flags)
@@ -2696,7 +2720,8 @@ static int selinux_task_setnice(struct t
 {
 	int rc;
 
-	rc = secondary_ops->task_setnice(p, nice);
+	rc = secondary_ops->task_setnice ?
+		secondary_ops->task_setnice(p, nice) : 0;
 	if (rc)
 		return rc;
 
@@ -2708,7 +2733,8 @@ static int selinux_task_setrlimit(unsign
 	struct rlimit *old_rlim = current->signal->rlim + resource;
 	int rc;
 
-	rc = secondary_ops->task_setrlimit(resource, new_rlim);
+	rc = secondary_ops->task_setrlimit ?
+		secondary_ops->task_setrlimit(resource, new_rlim) : 0;
 	if (rc)
 		return rc;
 
@@ -2737,7 +2763,8 @@ static int selinux_task_kill(struct task
 	u32 perm;
 	int rc;
 
-	rc = secondary_ops->task_kill(p, info, sig);
+	rc = secondary_ops->task_kill ?
+		secondary_ops->task_kill(p, info, sig) : 0;
 	if (rc)
 		return rc;
 
@@ -2778,7 +2805,8 @@ static void selinux_task_reparent_to_ini
 {
   	struct task_security_struct *tsec;
 
-	secondary_ops->task_reparent_to_init(p);
+	if (secondary_ops->task_reparent_to_init)
+		secondary_ops->task_reparent_to_init(p);
 
 	tsec = p->security;
 	tsec->osid = tsec->sid;
@@ -3227,7 +3255,8 @@ static int selinux_socket_unix_stream_co
 	struct avc_audit_data ad;
 	int err;
 
-	err = secondary_ops->unix_stream_connect(sock, other, newsk);
+	err = secondary_ops->unix_stream_connect ?
+		secondary_ops->unix_stream_connect(sock, other, newsk) : 0;
 	if (err)
 		return err;
 
@@ -3603,7 +3632,8 @@ static int selinux_netlink_send(struct s
 	struct av_decision avd;
 	int err;
 
-	err = secondary_ops->netlink_send(sk, skb);
+	err = secondary_ops->netlink_send ?
+		secondary_ops->netlink_send(sk, skb) : 0;
 	if (err)
 		return err;
 
@@ -3949,7 +3979,8 @@ static int selinux_shm_shmat(struct shmi
 	u32 perms;
 	int rc;
 
-	rc = secondary_ops->shm_shmat(shp, shmaddr, shmflg);
+	rc = secondary_ops->shm_shmat ?
+		secondary_ops->shm_shmat(shp, shmaddr, shmflg) : 0;
 	if (rc)
 		return rc;
 
