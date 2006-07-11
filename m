Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWGKHzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWGKHzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWGKHzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:55:09 -0400
Received: from cimai.net4.nerim.net ([62.212.121.89]:56983 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750717AbWGKHy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:54:58 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20060711075425.246261000@localhost.localdomain>
References: <20060711075051.382004000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 11 Jul 2006 09:50:57 +0200
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH -mm 6/7] add the user namespace to the execns syscall
Content-Disposition: inline; filename=user-namespace-add-execns-syscall.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows a process to unshare its user namespace through
the execns() syscall.

It also forbids the use of the unshare() syscall on user namespaces.
The purpose of this restriction is to prevent inconsistencies in the
accounting for each process.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>

---
 fs/exec.c     |   22 ++++++++++++++++++----
 kernel/fork.c |    5 +++++
 2 files changed, 23 insertions(+), 4 deletions(-)

Index: 2.6.18-rc1-mm1/fs/exec.c
===================================================================
--- 2.6.18-rc1-mm1.orig/fs/exec.c
+++ 2.6.18-rc1-mm1/fs/exec.c
@@ -1254,6 +1254,7 @@ int do_execns(int unshare_flags, char * 
 	struct nsproxy *new_nsproxy = NULL, *old_nsproxy = NULL;
 	struct uts_namespace *uts, *new_uts = NULL;
 	struct ipc_namespace *ipc, *new_ipc = NULL;
+	struct user_namespace *user, *new_user = NULL;
 
 	err = unshare_utsname(unshare_flags, &new_uts);
 	if (err)
@@ -1261,24 +1262,27 @@ int do_execns(int unshare_flags, char * 
 	err = unshare_ipcs(unshare_flags, &new_ipc);
 	if (err)
 		goto bad_execns_cleanup_uts;
+	err = unshare_user_ns(unshare_flags, &new_user);
+	if (err)
+		goto bad_execns_cleanup_ipc;
 
-	if (new_uts || new_ipc) {
+	if (new_uts || new_ipc || new_user) {
 		old_nsproxy = current->nsproxy;
 		new_nsproxy = dup_namespaces(old_nsproxy);
 		if (!new_nsproxy) {
 			err = -ENOMEM;
-			goto bad_execns_cleanup_ipc;
+			goto bad_execns_cleanup_user;
 		}
 	}
 
 	err = do_execve(filename, argv, envp, regs);
 	if (err)
-		goto bad_execns_cleanup_ipc;
+		goto bad_execns_cleanup_user;
 
 	/* make sure all files are flushed */
 	flush_all_old_files(current->files);
 
-	if (new_uts || new_ipc) {
+	if (new_uts || new_ipc || new_user) {
 
 		task_lock(current);
 
@@ -1299,12 +1303,22 @@ int do_execns(int unshare_flags, char * 
 			new_ipc = ipc;
 		}
 
+		if (new_user) {
+			user = current->nsproxy->user_ns;
+			current->nsproxy->user_ns = new_user;
+			new_user = user;
+		}
+
 		task_unlock(current);
 	}
 
 	if (new_nsproxy)
 		put_nsproxy(new_nsproxy);
 
+bad_execns_cleanup_user:
+	if (new_user)
+		put_user_ns(new_user);
+
 bad_execns_cleanup_ipc:
 	if (new_ipc)
 		put_ipc_ns(new_ipc);
Index: 2.6.18-rc1-mm1/kernel/fork.c
===================================================================
--- 2.6.18-rc1-mm1.orig/kernel/fork.c
+++ 2.6.18-rc1-mm1/kernel/fork.c
@@ -1615,6 +1615,11 @@ asmlinkage long sys_unshare(unsigned lon
 				CLONE_NEWUTS|CLONE_NEWIPC))
 		goto bad_unshare_out;
 
+	/* Also return -EINVAL for all unsharable namespaces. May be a
+	 * -EACCES would be more appropriate ? */
+	if (unshare_flags & CLONE_NEWUSER)
+		goto bad_unshare_out;
+
 	if ((err = unshare_thread(unshare_flags)))
 		goto bad_unshare_out;
 	if ((err = unshare_fs(unshare_flags, &new_fs)))

--
