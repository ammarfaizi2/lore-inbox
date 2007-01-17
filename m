Return-Path: <linux-kernel-owner+w=401wt.eu-S932495AbXAQPhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbXAQPhV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 10:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbXAQPhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 10:37:21 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:30626 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932495AbXAQPhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 10:37:15 -0500
Date: Wed, 17 Jan 2007 18:43:19 +0300
From: Alexey Dobriyan <adobriyan@openvz.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, devel@openvz.org
Subject: [PATCH] Introduce and use get_task_mnt_ns()
Message-ID: <20070117154319.GD6021@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apply after "[PATCH] Fix NULL ->nsproxy dereference in /proc/*/mounts".

Similar to get_task_mm(): get a reference to task's mnt namespace if any.
Suggested by Pavel Emelianov.

Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
---

 fs/proc/base.c          |   15 ++-------------
 include/linux/nsproxy.h |    1 +
 kernel/nsproxy.c        |   14 ++++++++++++++
 3 files changed, 17 insertions(+), 13 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -370,13 +370,7 @@ static int mounts_open(struct inode *ino
 	int ret = -EINVAL;
 
 	if (task) {
-		task_lock(task);
-		if (task->nsproxy) {
-			ns = task->nsproxy->mnt_ns;
-			if (ns)
-				get_mnt_ns(ns);
-		}
-		task_unlock(task);
+		ns = get_task_mnt_ns(task);
 		put_task_struct(task);
 	}
 
@@ -443,12 +437,7 @@ static int mountstats_open(struct inode 
 		struct task_struct *task = get_proc_task(inode);
 
 		if (task) {
-			task_lock(task);
-			if (task->nsproxy)
-				mnt_ns = task->nsproxy->mnt_ns;
-			if (mnt_ns)
-				get_mnt_ns(mnt_ns);
-			task_unlock(task);
+			mnt_ns = get_task_mnt_ns(task);
 			put_task_struct(task);
 		}
 
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -35,6 +35,7 @@ struct nsproxy *dup_namespaces(struct ns
 int copy_namespaces(int flags, struct task_struct *tsk);
 void get_task_namespaces(struct task_struct *tsk);
 void free_nsproxy(struct nsproxy *ns);
+struct mnt_namespace * get_task_mnt_ns(struct task_struct *tsk);
 
 static inline void put_nsproxy(struct nsproxy *ns)
 {
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -147,3 +147,17 @@ void free_nsproxy(struct nsproxy *ns)
 		put_pid_ns(ns->pid_ns);
 	kfree(ns);
 }
+
+struct mnt_namespace * get_task_mnt_ns(struct task_struct *tsk)
+{
+	struct mnt_namespace *mnt_ns = NULL;
+
+	task_lock(tsk);
+	if (tsk->nsproxy)
+		mnt_ns = tsk->nsproxy->mnt_ns;
+	if (mnt_ns)
+		get_mnt_ns(mnt_ns);
+	task_unlock(tsk);
+
+	return mnt_ns;
+}

