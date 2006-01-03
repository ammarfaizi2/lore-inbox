Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWACVSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWACVSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWACVRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:17:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31375 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932560AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 20/50] uml: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Px-Jj@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/um/kernel/skas/process_kern.c |    4 ++--
 arch/um/kernel/tt/exec_kern.c      |    2 +-
 arch/um/kernel/tt/process_kern.c   |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

b55d7bb2f55e737c280bd0a8fb369b3bc91a8dbb
diff --git a/arch/um/kernel/skas/process_kern.c b/arch/um/kernel/skas/process_kern.c
index 9c99025..648dd55 100644
--- a/arch/um/kernel/skas/process_kern.c
+++ b/arch/um/kernel/skas/process_kern.c
@@ -119,7 +119,7 @@ int copy_thread_skas(int nr, unsigned lo
 		handler = new_thread_handler;
 	}
 
-	new_thread(p->thread_info, &p->thread.mode.skas.switch_buf,
+	new_thread(task_stack_page(p), &p->thread.mode.skas.switch_buf,
 		   &p->thread.mode.skas.fork_buf, handler);
 	return(0);
 }
@@ -186,7 +186,7 @@ int start_uml_skas(void)
 
 	init_task.thread.request.u.thread.proc = start_kernel_proc;
 	init_task.thread.request.u.thread.arg = NULL;
-	return(start_idle_thread(init_task.thread_info,
+	return(start_idle_thread(task_stack_page(&init_task),
 				 &init_task.thread.mode.skas.switch_buf,
 				 &init_task.thread.mode.skas.fork_buf));
 }
diff --git a/arch/um/kernel/tt/exec_kern.c b/arch/um/kernel/tt/exec_kern.c
index 065b504..1b98330 100644
--- a/arch/um/kernel/tt/exec_kern.c
+++ b/arch/um/kernel/tt/exec_kern.c
@@ -40,7 +40,7 @@ void flush_thread_tt(void)
 		do_exit(SIGKILL);
 	}
 		
-	new_pid = start_fork_tramp(current->thread_info, stack, 0, exec_tramp);
+	new_pid = start_fork_tramp(task_stack_page(current), stack, 0, exec_tramp);
 	if(new_pid < 0){
 		printk(KERN_ERR 
 		       "flush_thread : new thread failed, errno = %d\n",
diff --git a/arch/um/kernel/tt/process_kern.c b/arch/um/kernel/tt/process_kern.c
index 857f355..6f21c1f 100644
--- a/arch/um/kernel/tt/process_kern.c
+++ b/arch/um/kernel/tt/process_kern.c
@@ -254,7 +254,7 @@ int copy_thread_tt(int nr, unsigned long
 
 	clone_flags &= CLONE_VM;
 	p->thread.temp_stack = stack;
-	new_pid = start_fork_tramp(p->thread_info, stack, clone_flags, tramp);
+	new_pid = start_fork_tramp(task_stack_page(p), stack, clone_flags, tramp);
 	if(new_pid < 0){
 		printk(KERN_ERR "copy_thread : clone failed - errno = %d\n", 
 		       -new_pid);
@@ -426,7 +426,7 @@ int start_uml_tt(void)
 	int pages;
 
 	pages = (1 << CONFIG_KERNEL_STACK_ORDER);
-	sp = (void *) ((unsigned long) init_task.thread_info) +
+	sp = task_stack_page(&init_task) +
 		pages * PAGE_SIZE - sizeof(unsigned long);
 	return(tracer(start_kernel_proc, sp));
 }
-- 
0.99.9.GIT

