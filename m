Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWACVRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWACVRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWACVRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:17:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46479 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932569AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 44/50] ia64: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008SU-BK@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

on ia64 thread_info is at the constant offset from task_struct and stack
is embedded into the same beast.  Set __HAVE_THREAD_FUNCTIONS, made
task_thread_info() just add a constant.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/ia64/kernel/mca.c         |    4 ++--
 arch/ia64/kernel/signal.c      |   10 +++++-----
 include/asm-ia64/thread_info.h |    9 +++++++++
 3 files changed, 16 insertions(+), 7 deletions(-)

820e7e11aef95c5c303eede2c2e370b99d5aee5a
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 355af15..ee7eec9 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -766,7 +766,7 @@ ia64_mca_modify_original_stack(struct pt
 			l = strlen(previous_current->comm);
 		snprintf(comm, sizeof(comm), "%s %*s %d",
 			current->comm, l, previous_current->comm,
-			previous_current->thread_info->cpu);
+			task_thread_info(previous_current)->cpu);
 	}
 	memcpy(current->comm, comm, sizeof(current->comm));
 
@@ -1423,7 +1423,7 @@ format_mca_init_stack(void *mca_data, un
 	struct task_struct *p = (struct task_struct *)((char *)mca_data + offset);
 	struct thread_info *ti;
 	memset(p, 0, KERNEL_STACK_SIZE);
-	ti = (struct thread_info *)((char *)p + IA64_TASK_SIZE);
+	ti = task_thread_info(p);
 	ti->flags = _TIF_MCA_INIT;
 	ti->preempt_count = 1;
 	ti->task = p;
diff --git a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
index 58ce07e..463f6bb 100644
--- a/arch/ia64/kernel/signal.c
+++ b/arch/ia64/kernel/signal.c
@@ -655,11 +655,11 @@ set_sigdelayed(pid_t pid, int signo, int
 
 		if (!t)
 			return;
-		t->thread_info->sigdelayed.signo = signo;
-		t->thread_info->sigdelayed.code = code;
-		t->thread_info->sigdelayed.addr = addr;
-		t->thread_info->sigdelayed.start_time = start_time;
-		t->thread_info->sigdelayed.pid = pid;
+		task_thread_info(t)->sigdelayed.signo = signo;
+		task_thread_info(t)->sigdelayed.code = code;
+		task_thread_info(t)->sigdelayed.addr = addr;
+		task_thread_info(t)->sigdelayed.start_time = start_time;
+		task_thread_info(t)->sigdelayed.pid = pid;
 		wmb();
 		set_tsk_thread_flag(t, TIF_SIGDELAYED);
 	}
diff --git a/include/asm-ia64/thread_info.h b/include/asm-ia64/thread_info.h
index 171b220..653bb7f 100644
--- a/include/asm-ia64/thread_info.h
+++ b/include/asm-ia64/thread_info.h
@@ -57,11 +57,20 @@ struct thread_info {
 /* how to get the thread information struct from C */
 #define current_thread_info()	((struct thread_info *) ((char *) current + IA64_TASK_SIZE))
 #define alloc_thread_info(tsk)	((struct thread_info *) ((char *) (tsk) + IA64_TASK_SIZE))
+#define task_thread_info(tsk)	((struct thread_info *) ((char *) (tsk) + IA64_TASK_SIZE))
 #else
 #define current_thread_info()	((struct thread_info *) 0)
 #define alloc_thread_info(tsk)	((struct thread_info *) 0)
+#define task_thread_info(tsk)	((struct thread_info *) 0)
 #endif
 #define free_thread_info(ti)	/* nothing */
+#define task_stack_page(tsk)	((void *)(tsk))
+
+#define __HAVE_THREAD_FUNCTIONS
+#define setup_thread_stack(p, org) \
+	*task_thread_info(p) = *task_thread_info(org); \
+	task_thread_info(p)->task = (p);
+#define end_of_stack(p) (unsigned long *)((void *)(p) + IA64_RBS_OFFSET)
 
 #define __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
 #define alloc_task_struct()	((task_t *)__get_free_pages(GFP_KERNEL, KERNEL_STACK_SIZE_ORDER))
-- 
0.99.9.GIT

