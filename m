Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVKNVdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVKNVdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVKNVdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:33:20 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:36561 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932154AbVKNVdF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:33:05 -0500
Message-Id: <20051114212529.510360000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:51 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 10/13] Change pid accesses: security/
Content-Disposition: inline; filename=B9-change-pid-tgid-references-security
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: security/
From: Serge Hallyn <serue@us.ibm.com>

Change pid accesses for security modules.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 security/commoncap.c             |    2 +-
 security/keys/process_keys.c     |    6 +++---
 security/keys/request_key_auth.c |    2 +-
 security/seclvl.c                |   16 ++++++++--------
 security/selinux/avc.c           |    4 ++--
 5 files changed, 15 insertions(+), 15 deletions(-)

Index: linux-2.6.15-rc1/security/commoncap.c
===================================================================
--- linux-2.6.15-rc1.orig/security/commoncap.c
+++ linux-2.6.15-rc1/security/commoncap.c
@@ -169,7 +169,7 @@ void cap_bprm_apply_creds (struct linux_
 	/* For init, we want to retain the capabilities set
 	 * in the init_task struct. Thus we skip the usual
 	 * capability rules */
-	if (current->pid != 1) {
+	if (task_pid(current) != 1) {
 		current->cap_permitted = new_permitted;
 		current->cap_effective =
 		    cap_intersect (new_permitted, bprm->cap_effective);
Index: linux-2.6.15-rc1/security/keys/process_keys.c
===================================================================
--- linux-2.6.15-rc1.orig/security/keys/process_keys.c
+++ linux-2.6.15-rc1/security/keys/process_keys.c
@@ -140,7 +140,7 @@ int install_thread_keyring(struct task_s
 	char buf[20];
 	int ret;
 
-	sprintf(buf, "_tid.%u", tsk->pid);
+	sprintf(buf, "_tid.%u", task_pid(tsk));
 
 	keyring = keyring_alloc(buf, tsk->uid, tsk->gid, 1, NULL);
 	if (IS_ERR(keyring)) {
@@ -173,7 +173,7 @@ int install_process_keyring(struct task_
 	int ret;
 
 	if (!tsk->signal->process_keyring) {
-		sprintf(buf, "_pid.%u", tsk->tgid);
+		sprintf(buf, "_pid.%u", task_tgid(tsk));
 
 		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, 1, NULL);
 		if (IS_ERR(keyring)) {
@@ -213,7 +213,7 @@ static int install_session_keyring(struc
 
 	/* create an empty session keyring */
 	if (!keyring) {
-		sprintf(buf, "_ses.%u", tsk->tgid);
+		sprintf(buf, "_ses.%u", task_tgid(tsk));
 
 		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, 1, NULL);
 		if (IS_ERR(keyring)) {
Index: linux-2.6.15-rc1/security/keys/request_key_auth.c
===================================================================
--- linux-2.6.15-rc1.orig/security/keys/request_key_auth.c
+++ linux-2.6.15-rc1/security/keys/request_key_auth.c
@@ -60,7 +60,7 @@ static int request_key_auth_instantiate(
 		else {
 			/* it isn't - use this process as the context */
 			rka->context = current;
-			rka->pid = current->pid;
+			rka->pid = task_pid(current);
 		}
 
 		rka->target_key = key_get((struct key *) data);
Index: linux-2.6.15-rc1/security/seclvl.c
===================================================================
--- linux-2.6.15-rc1.orig/security/seclvl.c
+++ linux-2.6.15-rc1/security/seclvl.c
@@ -296,7 +296,7 @@ static struct file_operations passwd_fil
 static int seclvl_ptrace(struct task_struct *parent, struct task_struct *child)
 {
 	if (seclvl >= 0) {
-		if (child->pid == 1) {
+		if (task_pid(child) == 1) {
 			seclvl_printk(1, KERN_WARNING, "Attempt to ptrace "
 				      "the init process dissallowed in "
 				      "secure level %d\n", seclvl);
@@ -313,7 +313,7 @@ static int seclvl_ptrace(struct task_str
 static int seclvl_capable(struct task_struct *tsk, int cap)
 {
 	/* init can do anything it wants */
-	if (tsk->pid == 1)
+	if (task_pid(tsk) == 1)
 		return 0;
 
 	switch (seclvl) {
@@ -375,10 +375,10 @@ static int seclvl_settime(struct timespe
 		    (tv->tv_sec == now.tv_sec && tv->tv_nsec < now.tv_nsec)) {
 			seclvl_printk(1, KERN_WARNING, "Attempt to decrement "
 				      "time in secure level %d denied: "
-				      "current->pid = [%d], "
-				      "current->group_leader->pid = [%d]\n",
-				      seclvl, current->pid,
-				      current->group_leader->pid);
+				      "current pid = [%d], "
+				      "current->group_leader pid = [%d]\n",
+				      seclvl, task_pid(current),
+				      task_pid(current->group_leader));
 			return -EPERM;
 		}		/* if attempt to decrement time */
 	}			/* if seclvl > 1 */
@@ -424,7 +424,7 @@ static void seclvl_bd_release(struct ino
 static int
 seclvl_inode_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
-	if (current->pid != 1 && S_ISBLK(inode->i_mode) && (mask & MAY_WRITE)) {
+	if (task_pid(current) != 1 && S_ISBLK(inode->i_mode) && (mask & MAY_WRITE)) {
 		switch (seclvl) {
 		case 2:
 			seclvl_printk(1, KERN_WARNING, "Write to block device "
@@ -479,7 +479,7 @@ static void seclvl_file_free_security(st
  */
 static int seclvl_umount(struct vfsmount *mnt, int flags)
 {
-	if (current->pid == 1)
+	if (task_pid(current) == 1)
 		return 0;
 	if (seclvl == 2) {
 		seclvl_printk(1, KERN_WARNING, "Attempt to unmount in secure "
Index: linux-2.6.15-rc1/security/selinux/avc.c
===================================================================
--- linux-2.6.15-rc1.orig/security/selinux/avc.c
+++ linux-2.6.15-rc1/security/selinux/avc.c
@@ -558,8 +558,8 @@ void avc_audit(u32 ssid, u32 tsid,
 	audit_log_format(ab, " for ");
 	if (a && a->tsk)
 		tsk = a->tsk;
-	if (tsk && tsk->pid) {
-		audit_log_format(ab, " pid=%d comm=", tsk->pid);
+	if (tsk && task_pid(tsk)) {
+		audit_log_format(ab, " pid=%d comm=", task_pid(tsk));
 		audit_log_untrustedstring(ab, tsk->comm);
 	}
 	if (a) {

--

