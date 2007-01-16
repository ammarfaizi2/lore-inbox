Return-Path: <linux-kernel-owner+w=401wt.eu-S1751023AbXAPLEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXAPLEf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 06:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbXAPLEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 06:04:35 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:57800 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbXAPLEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 06:04:34 -0500
Message-ID: <45ACB13F.4020607@fr.ibm.com>
Date: Tue, 16 Jan 2007 12:04:31 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] user_ns: remove CONFIG_USER_NS
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104181257.GH11377@sergelap.austin.ibm.com> <20070111212039.68e57e65.akpm@osdl.org> <20070115072653.GA7385@sergelap.austin.ibm.com> <45AB97D5.6010503@fr.ibm.com> <20070115152825.GA20350@sergelap.austin.ibm.com> <45ABBB64.3060304@fr.ibm.com>
In-Reply-To: <45ABBB64.3060304@fr.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't look that useful anyway, it just deactivates the unshare
capability for the user namespace.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
---
 include/linux/sched.h          |    9 ---------
 include/linux/user_namespace.h |   33 ---------------------------------
 init/Kconfig                   |    4 ----
 kernel/user_namespace.c        |    3 ---
 4 files changed, 49 deletions(-)

Index: 2.6.20-rc4-mm1/include/linux/sched.h
===================================================================
--- 2.6.20-rc4-mm1.orig/include/linux/sched.h
+++ 2.6.20-rc4-mm1/include/linux/sched.h
@@ -1603,7 +1603,6 @@ extern int cond_resched(void);
 extern int cond_resched_lock(spinlock_t * lock);
 extern int cond_resched_softirq(void);
 
-#ifdef CONFIG_USER_NS
 /*
  * Check whether a task and a vfsmnt belong to the same uidns.
  * Since the initial namespace is exempt from these checks,
@@ -1622,14 +1621,6 @@ static inline int task_mnt_same_uidns(st
 		return 1;
 	return 0;
 }
-#else
-static inline int task_mnt_same_uidns(struct task_struct *tsk,
-					struct vfsmount *mnt)
-{
-	return 1;
-}
-#endif
-
 
 /*
  * Does a critical section need to be broken due to another
Index: 2.6.20-rc4-mm1/include/linux/user_namespace.h
===================================================================
--- 2.6.20-rc4-mm1.orig/include/linux/user_namespace.h
+++ 2.6.20-rc4-mm1/include/linux/user_namespace.h
@@ -16,8 +16,6 @@ struct user_namespace {
 
 extern struct user_namespace init_user_ns;
 
-#ifdef CONFIG_USER_NS
-
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 {
 	if (ns)
@@ -45,35 +43,4 @@ static inline int clone_mnt_userns_permi
 	return 1;
 }
 
-#else
-
-static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
-{
-	return NULL;
-}
-
-static inline int unshare_user_ns(unsigned long flags,
-			 struct user_namespace **new_user)
-{
-	if (flags & CLONE_NEWUSER)
-		return -EINVAL;
-
-	return 0;
-}
-
-static inline int copy_user_ns(int flags, struct task_struct *tsk)
-{
-	return 0;
-}
-
-static inline void put_user_ns(struct user_namespace *ns)
-{
-}
-
-static inline int clone_mnt_userns_permission(struct vfsmount *old)
-{
-	return 1;
-}
-#endif
-
 #endif /* _LINUX_USER_H */
Index: 2.6.20-rc4-mm1/init/Kconfig
===================================================================
--- 2.6.20-rc4-mm1.orig/init/Kconfig
+++ 2.6.20-rc4-mm1/init/Kconfig
@@ -222,10 +222,6 @@ config UTS_NS
 	  vservers, to use uts namespaces to provide different
 	  uts info for different servers.  If unsure, say N.
 
-config USER_NS
-	bool
-	default y
-
 config AUDIT
 	bool "Auditing support"
 	depends on NET
Index: 2.6.20-rc4-mm1/kernel/user_namespace.c
===================================================================
--- 2.6.20-rc4-mm1.orig/kernel/user_namespace.c
+++ 2.6.20-rc4-mm1/kernel/user_namespace.c
@@ -19,7 +19,6 @@ struct user_namespace init_user_ns = {
 
 EXPORT_SYMBOL_GPL(init_user_ns);
 
-#ifdef CONFIG_USER_NS
 /*
  * Clone a new ns copying an original user ns, setting refcount to 1
  * @old_ns: namespace to clone
@@ -110,5 +109,3 @@ void free_user_ns(struct kref *kref)
 	ns = container_of(kref, struct user_namespace, kref);
 	kfree(ns);
 }
-
-#endif /* CONFIG_USER_NS */
