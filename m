Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbUKWGHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUKWGHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbUKWGFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:05:09 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:32965 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262112AbUKWGDV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:03:21 -0500
Subject: [PATCH 2.6.9] fork: add a hook in do_fork()
From: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, guillaume.thouvenin@bull.net
Date: Tue, 23 Nov 2004 07:03:17 +0100
Message-Id: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 07:10:22,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 07:10:23,
	Serialize complete at 23/11/2004 07:10:23
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   For a module, I need to execute a function when a fork occurs. My
solution is to add a pointer to a function (called fork_hook) in the
do_fork() and if this pointer isn't NULL, I call the function. To update
the pointer to the function I export a symbol (called trace_fork) that
defines another function with two parameters (the hook and an
identifier). This function provides a simple mechanism to manage access
to the fork_hook variable.

   I don't know if this solution is good but it's easy to implement and
it just does the trick. I made some tests and it doesn't impact the
performance of the Linux kernel. 

   I'd like to have your comment about this patch. Is it useful and is
it needed by someone else than me? 

Any comments are welcome,

Guillaume

Signed-Off-By: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

--- kernel/fork.c.orig	2004-10-19 08:41:53.000000000 +0200
+++ kernel/fork.c	2004-11-22 14:45:15.700858800 +0100
@@ -60,6 +60,51 @@ rwlock_t tasklist_lock __cacheline_align
 
 EXPORT_SYMBOL(tasklist_lock);
 
+/* 
+ * fork_hook is a pointer to a function to call when forking if it 
+ * isn't NULL.  
+ */
+void (*fork_hook) (int, int) = NULL;
+
+/**
+ * trace_fork: call a given external function when forking
+ * @func: function to call
+ * @id: identifier of fork_hook's owner
+ *
+ * This function sets the fork_hook and makes some sanity checks.
+ * Function returns 0 on success, -1 on failure (ie hook is 
+ * already used).
+ */
+int trace_fork(void (*func) (int, int), int id)
+{
+	/* 
+	 * fork_hook_id is used as a lock to protect the use of 
+	 * fork_hook variable. A module can set the fork_hook 
+	 * variable if it's not already used (fork_hook_id == 0)
+	 * or if it has the corresponding fork_hook_id. 
+	 * We use a static variable to keep its last value.
+	 */
+	static int fork_hook_id = 0;
+
+	/* We can set the hook if it's not already used */
+	if ((func != NULL) && (fork_hook_id == 0)) {
+		fork_hook = func;
+		fork_hook_id = id;
+		return 0;
+	}
+
+	/* We can remove the hook if we are the owner */
+	if ((func == NULL) && (fork_hook_id == id)) {
+		fork_hook = NULL;
+		fork_hook_id = 0;
+		return 0;
+	}
+
+	/* Request can not be satisfied */
+	return -1;
+}
+EXPORT_SYMBOL(trace_fork);
+
 int nr_processes(void)
 {
 	int cpu;
@@ -1281,6 +1326,10 @@ long do_fork(unsigned long clone_flags,
 		free_pidmap(pid);
 		pid = PTR_ERR(p);
 	}
+
+	if (fork_hook != NULL)
+		fork_hook(current->pid, pid);
+
 	return pid;
 }


