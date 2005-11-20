Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVKTH6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVKTH6b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 02:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVKTH6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 02:58:31 -0500
Received: from [204.13.84.100] ([204.13.84.100]:16958 "EHLO
	stargazer.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S1750837AbVKTH6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 02:58:31 -0500
Date: Sat, 19 Nov 2005 23:58:18 -0800
To: linux-kernel@vger.kernel.org
Cc: hch@lst.de
Subject: [Patch] kernel/ptrace.c minor cleanup
Message-ID: <20051120075818.GA5200@defiant.tbdnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: nkiesel@tbdnetworks.com (Norbert Kiesel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch
 - removes a (basically) unused variable
 - removes some tailing whitepsace
 - converts 2 "if (x) BUG()" to "BUG_ON(x)"
 - fixes one comment

Best,
  Norbert


diff -ru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	2005-11-19 23:01:16.000000000 -0800
+++ b/kernel/ptrace.c	2005-11-19 23:44:04.000000000 -0800
@@ -29,8 +29,7 @@
  */
 void __ptrace_link(task_t *child, task_t *new_parent)
 {
-	if (!list_empty(&child->ptrace_list))
-		BUG();
+	BUG_ON(!list_empty(&child->ptrace_list));
 	if (child->parent == new_parent)
 		return;
 	list_add(&child->ptrace_list, &child->parent->ptrace_children);
@@ -38,7 +37,7 @@
 	child->parent = new_parent;
 	SET_LINKS(child);
 }
- 
+
 /*
  * Turn a tracing stop into a normal stop now, since with no tracer there
  * would be no way to wake it up with SIGCONT or SIGKILL.  If there was a
@@ -71,8 +70,7 @@
  */
 void __ptrace_unlink(task_t *child)
 {
-	if (!child->ptrace)
-		BUG();
+	BUG_ON(!child->ptrace);
 	child->ptrace = 0;
 	if (!list_empty(&child->ptrace_list)) {
 		list_del_init(&child->ptrace_list);
@@ -113,9 +111,8 @@
 	}
 	read_unlock(&tasklist_lock);
 
-	if (!ret && !kill) {
+	if (!ret && !kill)
 		wait_task_inactive(child);
-	}
 
 	/* All systems go.. */
 	return ret;
@@ -150,9 +147,8 @@
 
 int ptrace_attach(struct task_struct *task)
 {
-	int retval;
+	int retval = -EPERM;
 	task_lock(task);
-	retval = -EPERM;
 	if (task->pid <= 1)
 		goto bad;
 	if (task->tgid == current->tgid)
@@ -206,7 +202,7 @@
 
 /*
  * Access another process' address space.
- * Source/target buffer must be kernel space, 
+ * Source/target buffer must be kernel space,
  * Do not walk the page table directly, use get_user_pages
  */
 
@@ -254,7 +250,7 @@
 	}
 	up_read(&mm->mmap_sem);
 	mmput(mm);
-	
+
 	return buf - old_buf;
 }
 
@@ -278,7 +274,7 @@
 		copied += retval;
 		src += retval;
 		dst += retval;
-		len -= retval;			
+		len -= retval;
 	}
 	return copied;
 }
@@ -303,7 +299,7 @@
 		copied += retval;
 		src += retval;
 		dst += retval;
-		len -= retval;			
+		len -= retval;
 	}
 	return copied;
 }
@@ -412,11 +408,10 @@
 		struct task_struct **childp)
 {
 	struct task_struct *child;
-	int ret;
 
 	/*
 	 * Callers use child == NULL as an indication to exit early even
-	 * when the return value is 0, so make sure it is non-NULL here.
+	 * when the return value is 0, so make sure it is NULL here.
 	 */
 	*childp = NULL;
 
@@ -426,8 +421,7 @@
 		 */
 		if (current->ptrace & PT_PTRACED)
 			return -EPERM;
-		ret = security_ptrace(current->parent, current);
-		if (ret)
+		if (security_ptrace(current->parent, current))
 			return -EPERM;
 		/*
 		 * Set the ptrace bit in the process ptrace flags.
@@ -442,7 +436,6 @@
 	if (pid == 1)
 		return -EPERM;
 
-	ret = -ESRCH;
 	read_lock(&tasklist_lock);
 	child = find_task_by_pid(pid);
 	if (child)
