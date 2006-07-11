Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWGKHz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWGKHz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWGKHzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:55:23 -0400
Received: from cimai.net4.nerim.net ([62.212.121.89]:58007 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750711AbWGKHzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:55:12 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20060711075433.856729000@localhost.localdomain>
References: <20060711075051.382004000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 11 Jul 2006 09:50:58 +0200
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH -mm 7/7] forbid the use of the unshare syscall on ipc namespaces
Content-Disposition: inline; filename=ipc-namespace-remove-unshare.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch forbids the use of the unshare() syscall on ipc namespaces.

The purpose of this restriction is to protect the system from
inconsistencies when the namespace is unshared. e.g. shared memory ids
will be removed but not the memory mappings, semaphore ids will be
removed but the semundos not cleared.


Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Pavel Emelianov <xemul@openvz.org>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>

---
 kernel/fork.c |   23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

Index: 2.6.18-rc1-mm1/kernel/fork.c
===================================================================
--- 2.6.18-rc1-mm1.orig/kernel/fork.c
+++ 2.6.18-rc1-mm1/kernel/fork.c
@@ -1604,7 +1604,6 @@ asmlinkage long sys_unshare(unsigned lon
 	struct sem_undo_list *new_ulist = NULL;
 	struct nsproxy *new_nsproxy = NULL, *old_nsproxy = NULL;
 	struct uts_namespace *uts, *new_uts = NULL;
-	struct ipc_namespace *ipc, *new_ipc = NULL;
 
 	check_unshare_flags(&unshare_flags);
 
@@ -1612,12 +1611,12 @@ asmlinkage long sys_unshare(unsigned lon
 	err = -EINVAL;
 	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
 				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
-				CLONE_NEWUTS|CLONE_NEWIPC))
+				CLONE_NEWUTS))
 		goto bad_unshare_out;
 
 	/* Also return -EINVAL for all unsharable namespaces. May be a
 	 * -EACCES would be more appropriate ? */
-	if (unshare_flags & CLONE_NEWUSER)
+	if (unshare_flags & (CLONE_NEWUSER|CLONE_NEWIPC))
 		goto bad_unshare_out;
 
 	if ((err = unshare_thread(unshare_flags)))
@@ -1636,20 +1635,18 @@ asmlinkage long sys_unshare(unsigned lon
 		goto bad_unshare_cleanup_fd;
 	if ((err = unshare_utsname(unshare_flags, &new_uts)))
 		goto bad_unshare_cleanup_semundo;
-	if ((err = unshare_ipcs(unshare_flags, &new_ipc)))
-		goto bad_unshare_cleanup_uts;
 
-	if (new_ns || new_uts || new_ipc) {
+	if (new_ns || new_uts) {
 		old_nsproxy = current->nsproxy;
 		new_nsproxy = dup_namespaces(old_nsproxy);
 		if (!new_nsproxy) {
 			err = -ENOMEM;
-			goto bad_unshare_cleanup_ipc;
+			goto bad_unshare_cleanup_uts;
 		}
 	}
 
 	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
-				new_uts || new_ipc) {
+				new_uts) {
 
 		task_lock(current);
 
@@ -1697,22 +1694,12 @@ asmlinkage long sys_unshare(unsigned lon
 			new_uts = uts;
 		}
 
-		if (new_ipc) {
-			ipc = current->nsproxy->ipc_ns;
-			current->nsproxy->ipc_ns = new_ipc;
-			new_ipc = ipc;
-		}
-
 		task_unlock(current);
 	}
 
 	if (new_nsproxy)
 		put_nsproxy(new_nsproxy);
 
-bad_unshare_cleanup_ipc:
-	if (new_ipc)
-		put_ipc_ns(new_ipc);
-
 bad_unshare_cleanup_uts:
 	if (new_uts)
 		put_uts_ns(new_uts);

--
