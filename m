Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVASN4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVASN4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 08:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVASN4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 08:56:06 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:17330 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261722AbVASNzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 08:55:53 -0500
Subject: [PATCH 2.6.10] add a fork_hook for the relay_fork module
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: guillaume.thouvenin@bull.net
Date: Wed, 19 Jan 2005 14:55:44 +0100
Message-Id: <1106142944.10947.34.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/01/2005 15:04:00,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/01/2005 15:04:02,
	Serialize complete at 19/01/2005 15:04:02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   For the relay fork module (I posted it today), I need to execute a
function when a fork occurs. My solution is to add a pointer to a
function (called fork_hook) in the do_fork() and if this pointer isn't
NULL, I call the function. To update the pointer to the function I
export a symbol (called trace_fork) that defines another function with
one parameter (the hook).

   I know that such hooks are provided by PAGG patches but they are not
available in the main Linux kernel tree and that's why I provide this
one. 
  
   Thus, if you know a better solution I will be happy to read it. 

Guillaume

Signed-Off-By: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

--- linux-2.6.10/kernel/fork.c.orig	2005-01-04 11:28:58.000000000 +0100
+++ linux-2.6.10/kernel/fork.c	2005-01-19 14:23:25.000000000 +0100
@@ -61,6 +61,46 @@ rwlock_t tasklist_lock __cacheline_align
 
 EXPORT_SYMBOL(tasklist_lock);
 
+/*
+ * fork_hook is a pointer to a function to call when forking if it
+ * isn't NULL.
+ */
+spinlock_t fork_hook_lock = SPIN_LOCK_UNLOCKED;
+void (*fork_hook) (int, int) = NULL;
+
+/**
+ * trace_fork: call a given external function when forking
+ * @func: function to call
+ *
+ * This function sets the fork_hook and makes some sanity checks.
+ * Function returns 0 on success, -1 on failure (ie hook is
+ * already used).
+ * Limitation: currently, it can be used by only one module
+ */
+int trace_fork(void (*func) (int, int))
+{
+	int err;
+
+	err = 0;
+
+	spin_lock(&fork_hook_lock);
+	
+	/* We can set the hook if it's not already used */
+	if (func != NULL) {
+		if  (fork_hook == NULL) 
+			fork_hook = func;
+		else
+			err = -EBUSY;
+	} else
+		/* no check when releasing */
+		fork_hook = NULL;
+	
+	spin_unlock(&fork_hook_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(trace_fork);
+
 int nr_processes(void)
 {
 	int cpu;
@@ -1168,6 +1208,10 @@ long do_fork(unsigned long clone_flags,
 		free_pidmap(pid);
 		pid = PTR_ERR(p);
 	}
+
+	if (fork_hook != NULL)
+		fork_hook(current->pid, pid);
+
 	return pid;
 }

