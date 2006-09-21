Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWIUQVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWIUQVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 12:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWIUQVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 12:21:06 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:12441 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751069AbWIUQVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 12:21:05 -0400
Message-ID: <4512BBEB.2000200@fr.ibm.com>
Date: Thu, 21 Sep 2006 18:20:59 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Linux Containers <containers@lists.osdl.org>
Subject: [patch -mm] namespaces: exit_task_namespaces() invalidates nsproxy
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

exit_task_namespaces() has replaced the former exit_namespace(). It
invalidates task->nsproxy and associated namespaces. This is an issue
for the (futur) pid namespace which is required to be valid in
exit_notify().

This patch moves exit_task_namespaces() after exit_notify() to keep
nsproxy valid.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
---
 kernel/exit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6.18-rc7-mm1/kernel/exit.c
===================================================================
--- 2.6.18-rc7-mm1.orig/kernel/exit.c
+++ 2.6.18-rc7-mm1/kernel/exit.c
@@ -922,7 +922,6 @@ fastcall NORET_TYPE void do_exit(long co
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
-	exit_task_namespaces(tsk);
 	exit_thread();
 	cpuset_exit(tsk);
 	exit_keys(tsk);
@@ -937,6 +936,7 @@ fastcall NORET_TYPE void do_exit(long co
 	tsk->exit_code = code;
 	proc_exit_connector(tsk);
 	exit_notify(tsk);
+	exit_task_namespaces(tsk);
 #ifdef CONFIG_NUMA
 	mpol_free(tsk->mempolicy);
 	tsk->mempolicy = NULL;
