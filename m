Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVFWGmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVFWGmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVFWGlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:41:02 -0400
Received: from [24.22.56.4] ([24.22.56.4]:15846 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262283AbVFWGSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:45 -0400
Message-Id: <20050623061758.552172000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:13 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Vivek Kashyap <kashyapv@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 21/38] CKRM e18: Fix for compiler warnings
Content-Disposition: inline; filename=compiler-warning-fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes warnings seen when event callback table
is initialized.

Signed-Off-By: Vivek Kashyap <kashyapv@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

 kernel/ckrm/ckrm_sockc.c |    6 ++++--
 kernel/ckrm/ckrm_tc.c    |   21 +++++++++++++--------
 2 files changed, 17 insertions(+), 10 deletions(-)

Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_tc.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm_tc.c	2005-06-20 13:08:31.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_tc.c	2005-06-20 13:08:50.000000000 -0700
@@ -253,14 +253,17 @@ do {						\
 	ce_release(&ct_taskclass);              \
 } while (0)
 
-static void cb_taskclass_newtask(struct task_struct *tsk)
+static void cb_taskclass_newtask(void *tsk1)
 {
+	struct task_struct *tsk = (struct task_struct *)tsk1;
+
 	tsk->taskclass = NULL;
 	INIT_LIST_HEAD(&tsk->taskclass_link);
 }
 
-static void cb_taskclass_fork(struct task_struct *tsk)
+static void cb_taskclass_fork(void *tsk1)
 {
+	struct task_struct *tsk = (struct task_struct *)tsk1;
 	struct ckrm_task_class *cls = NULL;
 
 	pr_debug("%p:%d:%s\n", tsk, tsk->pid, tsk->comm);
@@ -281,26 +284,28 @@ static void cb_taskclass_fork(struct tas
 	ce_release(&ct_taskclass);
 }
 
-static void cb_taskclass_exit(struct task_struct *tsk)
+static void cb_taskclass_exit(void *tsk1)
 {
+	struct task_struct *tsk = (struct task_struct *)tsk1;
+
 	CE_CLASSIFY_NORET(&ct_taskclass, CKRM_EVENT_EXIT, tsk);
 	ckrm_set_taskclass(tsk, (void *)-1, NULL, CKRM_EVENT_EXIT);
 }
 
-static void cb_taskclass_exec(const char *filename)
+static void cb_taskclass_exec(void *filename)
 {
 	pr_debug("%p:%d:%s <%s>\n", current, current->pid, current->comm,
-		   filename);
+		   (const char *)filename);
 	CE_CLASSIFY_TASK_PROTECT(CKRM_EVENT_EXEC, current);
 }
 
-static void cb_taskclass_uid(void)
+static void cb_taskclass_uid(void *arg)
 {
 	pr_debug("%p:%d:%s\n", current, current->pid, current->comm);
 	CE_CLASSIFY_TASK_PROTECT(CKRM_EVENT_UID, current);
 }
 
-static void cb_taskclass_gid(void)
+static void cb_taskclass_gid(void *arg)
 {
 	pr_debug("%p:%d:%s\n", current, current->pid, current->comm);
 	CE_CLASSIFY_TASK_PROTECT(CKRM_EVENT_GID, current);
@@ -313,7 +318,7 @@ static struct ckrm_event_spec taskclass_
 	{CKRM_EVENT_EXIT, { cb_taskclass_exit, NULL }},
 	{CKRM_EVENT_UID, { cb_taskclass_uid, NULL }},
 	{CKRM_EVENT_GID, { cb_taskclass_gid, NULL }},
-	{-1, { -1, NULL }}
+	{-1, { NULL, NULL }}
 };
 
 /*
Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_sockc.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm_sockc.c	2005-06-20 13:08:38.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_sockc.c	2005-06-20 13:08:50.000000000 -0700
@@ -172,8 +172,9 @@ static void ckrm_sock_add_resctrl(struct
  *                   Functions called from classification points          *
  **************************************************************************/
 
-static void cb_sockclass_listen_start(struct sock *sk)
+static void cb_sockclass_listen_start(void *sk1)
 {
+	struct sock *sk = (struct sock *)sk1;
 	struct ckrm_net_struct *ns = NULL;
 	struct ckrm_sock_class *newcls = NULL;
 	struct ckrm_res_ctlr *rcbs;
@@ -243,8 +244,9 @@ static void cb_sockclass_listen_start(st
 	return;
 }
 
-static void cb_sockclass_listen_stop(struct sock *sk)
+static void cb_sockclass_listen_stop(void *sk1)
 {
+	struct sock *sk = (struct sock *)sk1;
 	struct ckrm_net_struct *ns = NULL;
 	struct ckrm_sock_class *newcls = NULL;
 

--
