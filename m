Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSGSXKq>; Fri, 19 Jul 2002 19:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSGSXKp>; Fri, 19 Jul 2002 19:10:45 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:17417 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317194AbSGSXJK>;
	Fri, 19 Jul 2002 19:09:10 -0400
Date: Fri, 19 Jul 2002 16:10:37 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM task control for 2.5.26
Message-ID: <20020719231036.GD24044@kroah.com>
References: <20020719230936.GA24044@kroah.com> <20020719231000.GB24044@kroah.com> <20020719231017.GC24044@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719231017.GC24044@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 21 Jun 2002 22:08:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.662   -> 1.663  
#	      kernel/uid16.c	1.1     -> 1.2    
#	       kernel/fork.c	1.50    -> 1.51   
#	include/linux/sched.h	1.71    -> 1.72   
#	        kernel/sys.c	1.20    -> 1.21   
#	            Makefile	1.274   -> 1.275  
#	 kernel/capability.c	1.4     -> 1.5    
#	         init/main.c	1.50    -> 1.51   
#	      kernel/sched.c	1.106   -> 1.107  
#	arch/i386/kernel/entry.S	1.32    -> 1.33   
#	arch/i386/kernel/ptrace.c	1.12    -> 1.13   
#	       kernel/kmod.c	1.9     -> 1.10   
#	 arch/i386/config.in	1.41    -> 1.42   
#	       kernel/exit.c	1.35    -> 1.36   
#	           fs/exec.c	1.32    -> 1.33   
#	     kernel/signal.c	1.22    -> 1.23   
#	include/linux/binfmts.h	1.2     -> 1.3    
#	     kernel/ptrace.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/19	greg@kroah.com	1.663
# LSM:  Enable the security framework.  This includes basic task control hooks.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Fri Jul 19 16:03:47 2002
+++ b/Makefile	Fri Jul 19 16:03:47 2002
@@ -157,7 +157,8 @@
 
 export srctree objtree
 
-SUBDIRS		:= init kernel mm fs ipc lib drivers sound net
+SUBDIRS		:= init kernel mm fs ipc lib drivers sound net security
+
 
 noconfig_targets := xconfig menuconfig config oldconfig randconfig \
 		    defconfig allyesconfig allnoconfig allmodconfig \
@@ -223,7 +224,7 @@
 # ---------------------------------------------------------------------------
 
 INIT		:= init/init.o
-CORE_FILES	:= kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o
+CORE_FILES	:= kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o
 LIBS		:= lib/lib.a
 DRIVERS		:= drivers/built-in.o sound/sound.o
 NETWORKS	:= net/network.o
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Fri Jul 19 16:03:47 2002
+++ b/arch/i386/config.in	Fri Jul 19 16:03:47 2002
@@ -423,4 +423,5 @@
 
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Fri Jul 19 16:03:47 2002
+++ b/arch/i386/kernel/entry.S	Fri Jul 19 16:03:47 2002
@@ -744,7 +744,7 @@
 	.long sys_getdents64	/* 220 */
 	.long sys_fcntl64
 	.long sys_ni_syscall	/* reserved for TUX */
-	.long sys_ni_syscall	/* reserved for Security */
+	.long sys_security	/* reserved for Security */
 	.long sys_gettid
 	.long sys_readahead	/* 225 */
 	.long sys_setxattr
diff -Nru a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
--- a/arch/i386/kernel/ptrace.c	Fri Jul 19 16:03:47 2002
+++ b/arch/i386/kernel/ptrace.c	Fri Jul 19 16:03:47 2002
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -158,6 +159,9 @@
 	if (request == PTRACE_TRACEME) {
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
+			goto out;
+		ret = security_ops->ptrace(current->parent, current);
+		if (ret)
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Fri Jul 19 16:03:47 2002
+++ b/fs/exec.c	Fri Jul 19 16:03:47 2002
@@ -623,6 +623,7 @@
 {
 	int mode;
 	struct inode * inode = bprm->file->f_dentry->d_inode;
+	int retval;
 
 	mode = inode->i_mode;
 	/*
@@ -652,27 +653,10 @@
 			bprm->e_gid = inode->i_gid;
 	}
 
-	/* We don't have VFS support for capabilities yet */
-	cap_clear(bprm->cap_inheritable);
-	cap_clear(bprm->cap_permitted);
-	cap_clear(bprm->cap_effective);
-
-	/*  To support inheritance of root-permissions and suid-root
-         *  executables under compatibility mode, we raise all three
-         *  capability sets for the file.
-         *
-         *  If only the real uid is 0, we only raise the inheritable
-         *  and permitted sets of the executable file.
-         */
-
-	if (!issecure(SECURE_NOROOT)) {
-		if (bprm->e_uid == 0 || current->uid == 0) {
-			cap_set_full(bprm->cap_inheritable);
-			cap_set_full(bprm->cap_permitted);
-		}
-		if (bprm->e_uid == 0) 
-			cap_set_full(bprm->cap_effective);
-	}
+	/* fill in binprm security blob */
+	retval = security_ops->bprm_set_security(bprm);
+	if (retval)
+		return retval;
 
 	memset(bprm->buf,0,BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file,0,bprm->buf,BINPRM_BUF_SIZE);
@@ -695,16 +679,9 @@
 
 void compute_creds(struct linux_binprm *bprm) 
 {
-	kernel_cap_t new_permitted, working;
 	int do_unlock = 0;
 
-	new_permitted = cap_intersect(bprm->cap_permitted, cap_bset);
-	working = cap_intersect(bprm->cap_inheritable,
-				current->cap_inheritable);
-	new_permitted = cap_combine(new_permitted, working);
-
-	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
-	    !cap_issubset(new_permitted, current->cap_permitted)) {
+	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
                 current->mm->dumpable = 0;
 		
 		lock_kernel();
@@ -716,32 +693,17 @@
 				bprm->e_uid = current->uid;
 				bprm->e_gid = current->gid;
 			}
-			if(!capable(CAP_SETPCAP)) {
-				new_permitted = cap_intersect(new_permitted,
-							current->cap_permitted);
-			}
 		}
 		do_unlock = 1;
 	}
 
-
-	/* For init, we want to retain the capabilities set
-         * in the init_task struct. Thus we skip the usual
-         * capability rules */
-	if (current->pid != 1) {
-		current->cap_permitted = new_permitted;
-		current->cap_effective =
-			cap_intersect(new_permitted, bprm->cap_effective);
-	}
-	
-        /* AUD: Audit candidate if current->cap_effective is set */
-
         current->suid = current->euid = current->fsuid = bprm->e_uid;
         current->sgid = current->egid = current->fsgid = bprm->e_gid;
 
 	if(do_unlock)
 		unlock_kernel();
-	current->keep_capabilities = 0;
+
+	security_ops->bprm_compute_creds(bprm);
 }
 
 
@@ -811,6 +773,10 @@
 	    }
 	}
 #endif
+	retval = security_ops->bprm_check_security(bprm);
+	if (retval) 
+		return retval;
+
 	/* kernel module loader fixup */
 	/* so we don't try to load run modprobe in kernel space. */
 	set_fs(USER_DS);
@@ -887,7 +853,7 @@
 	bprm.sh_bang = 0;
 	bprm.loader = 0;
 	bprm.exec = 0;
-
+	bprm.security = NULL;
 	bprm.mm = mm_alloc();
 	retval = -ENOMEM;
 	if (!bprm.mm)
@@ -905,6 +871,10 @@
 	if ((retval = bprm.envc) < 0)
 		goto out_mm;
 
+	retval = security_ops->bprm_alloc_security(&bprm);
+	if (retval) 
+		goto out;
+
 	retval = prepare_binprm(&bprm);
 	if (retval < 0) 
 		goto out; 
@@ -923,9 +893,11 @@
 		goto out; 
 
 	retval = search_binary_handler(&bprm,regs);
-	if (retval >= 0)
+	if (retval >= 0) {
 		/* execve success */
+		security_ops->bprm_free_security(&bprm);
 		return retval;
+	}
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
@@ -934,6 +906,9 @@
 		if (page)
 			__free_page(page);
 	}
+
+	if (bprm.security)
+		security_ops->bprm_free_security(&bprm);
 
 out_mm:
 	mmdrop(bprm.mm);
diff -Nru a/include/linux/binfmts.h b/include/linux/binfmts.h
--- a/include/linux/binfmts.h	Fri Jul 19 16:03:47 2002
+++ b/include/linux/binfmts.h	Fri Jul 19 16:03:47 2002
@@ -28,6 +28,7 @@
 	struct file * file;
 	int e_uid, e_gid;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
+	void *security;
 	int argc, envc;
 	char * filename;	/* Name of binary */
 	unsigned long loader, exec;
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Jul 19 16:03:47 2002
+++ b/include/linux/sched.h	Fri Jul 19 16:03:47 2002
@@ -354,6 +354,8 @@
 	void *notifier_data;
 	sigset_t *notifier_mask;
 	
+	void *security;
+
 /* Thread group tracking */
    	u32 parent_exec_id;
    	u32 self_exec_id;
@@ -587,10 +589,9 @@
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
-/*
- * capable() checks for a particular capability.
- * See include/linux/capability.h for defined capabilities.
- */
+/* capable prototype and code moved to security.[hc] */
+#include <linux/security.h>
+#if 0
 static inline int capable(int cap)
 {
 	if (cap_raised(current->cap_effective, cap)) {
@@ -599,6 +600,7 @@
 	}
 	return 0;
 }
+#endif	/* if 0 */
 
 /*
  * Routines for handling mm_structs
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Fri Jul 19 16:03:47 2002
+++ b/init/main.c	Fri Jul 19 16:03:47 2002
@@ -29,6 +29,7 @@
 #include <linux/tty.h>
 #include <linux/percpu.h>
 #include <linux/kernel_stat.h>
+#include <linux/security.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -390,6 +391,7 @@
 
 	fork_init(mempages);
 	proc_caches_init();
+	security_scaffolding_startup();
 	buffer_init();
 	vfs_caches_init(mempages);
 	radix_tree_init();
diff -Nru a/kernel/capability.c b/kernel/capability.c
--- a/kernel/capability.c	Fri Jul 19 16:03:47 2002
+++ b/kernel/capability.c	Fri Jul 19 16:03:47 2002
@@ -63,6 +63,7 @@
      data.permitted = cap_t(target->cap_permitted);
      data.inheritable = cap_t(target->cap_inheritable); 
      data.effective = cap_t(target->cap_effective);
+     ret = security_ops->capget(target, &data.effective, &data.inheritable, &data.permitted);
 
 out:
      read_unlock(&tasklist_lock); 
@@ -87,9 +88,7 @@
      for_each_task(target) {
              if (target->pgrp != pgrp)
                      continue;
-             target->cap_effective   = *effective;
-             target->cap_inheritable = *inheritable;
-             target->cap_permitted   = *permitted;
+	     security_ops->capset_set(target, effective, inheritable, permitted);
      }
 }
 
@@ -106,9 +105,7 @@
      for_each_task(target) {
              if (target == current || target->pid == 1)
                      continue;
-             target->cap_effective   = *effective;
-             target->cap_inheritable = *inheritable;
-             target->cap_permitted   = *permitted;
+	     security_ops->capset_set(target, effective, inheritable, permitted);
      }
 }
 
@@ -166,7 +163,9 @@
 
      ret = -EPERM;
 
-     /* verify restrictions on target's new Inheritable set */
+     if (security_ops->capset_check(target, &effective, &inheritable, &permitted))
+	     goto out;
+
      if (!cap_issubset(inheritable, cap_combine(target->cap_inheritable,
                        current->cap_permitted)))
              goto out;
@@ -182,6 +181,8 @@
 
      ret = 0;
 
+     /* having verified that the proposed changes are legal,
+           we now put them into effect. */
      if (pid < 0) {
              if (pid == -1)  /* all procs other than current and init */
                      cap_set_all(&effective, &inheritable, &permitted);
@@ -189,9 +190,7 @@
              else            /* all procs in process group */
                      cap_set_pg(-pid, &effective, &inheritable, &permitted);
      } else {
-             target->cap_effective   = effective;
-             target->cap_inheritable = inheritable;
-             target->cap_permitted   = permitted;
+	     security_ops->capset_set(target, &effective, &inheritable, &permitted);
      }
 
 out:
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Fri Jul 19 16:03:47 2002
+++ b/kernel/exit.c	Fri Jul 19 16:03:47 2002
@@ -14,6 +14,7 @@
 #include <linux/personality.h>
 #include <linux/tty.h>
 #include <linux/namespace.h>
+#include <linux/security.h>
 #include <linux/acct.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
@@ -61,6 +62,7 @@
 	wait_task_inactive(p);
 #endif
 	atomic_dec(&p->user->processes);
+	security_ops->task_free_security(p);
 	free_uid(p->user);
 	unhash_process(p);
 
@@ -187,10 +189,7 @@
 	/* cpus_allowed? */
 	/* rt_priority? */
 	/* signals? */
-	current->cap_effective = CAP_INIT_EFF_SET;
-	current->cap_inheritable = CAP_INIT_INH_SET;
-	current->cap_permitted = CAP_FULL_SET;
-	current->keep_capabilities = 0;
+	security_ops->task_reparent_to_init(current);
 	memcpy(current->rlim, init_task.rlim, sizeof(*(current->rlim)));
 	current->user = INIT_USER;
 
@@ -625,6 +624,10 @@
 			if (((p->exit_signal != SIGCHLD) ^ ((options & __WCLONE) != 0))
 			    && !(options & __WALL))
 				continue;
+
+			if (security_ops->task_wait(p))
+				continue;
+
 			flag = 1;
 			switch (p->state) {
 			case TASK_STOPPED:
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri Jul 19 16:03:47 2002
+++ b/kernel/fork.c	Fri Jul 19 16:03:47 2002
@@ -24,7 +24,7 @@
 #include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/fs.h>
-#include <linux/mm.h>
+#include <linux/security.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -618,6 +618,10 @@
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
 		return ERR_PTR(-EINVAL);
 
+	retval = security_ops->task_create(clone_flags);
+	if (retval)
+		goto fork_out;
+
 	retval = -ENOMEM;
 	p = dup_task_struct(current);
 	if (!p)
@@ -697,13 +701,16 @@
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
+	p->security = NULL;
 
 	INIT_LIST_HEAD(&p->local_pages);
 
 	retval = -ENOMEM;
+	if (security_ops->task_alloc_security(p))
+		goto bad_fork_cleanup;
 	/* copy all the process information */
 	if (copy_semundo(clone_flags, p))
-		goto bad_fork_cleanup;
+		goto bad_fork_cleanup_security;
 	if (copy_files(clone_flags, p))
 		goto bad_fork_cleanup_semundo;
 	if (copy_fs(clone_flags, p))
@@ -812,6 +819,8 @@
 	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_semundo(p);
+bad_fork_cleanup_security:
+	security_ops->task_free_security(p);
 bad_fork_cleanup:
 	put_exec_domain(p->thread_info->exec_domain);
 	if (p->binfmt && p->binfmt->module)
diff -Nru a/kernel/kmod.c b/kernel/kmod.c
--- a/kernel/kmod.c	Fri Jul 19 16:03:47 2002
+++ b/kernel/kmod.c	Fri Jul 19 16:03:47 2002
@@ -134,7 +134,7 @@
 	/* Give kmod all effective privileges.. */
 	curtask->euid = curtask->fsuid = 0;
 	curtask->egid = curtask->fsgid = 0;
-	cap_set_full(curtask->cap_effective);
+	security_ops->task_kmod_set_label();
 
 	/* Allow execve args to be in kernel space. */
 	set_fs(KERNEL_DS);
diff -Nru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	Fri Jul 19 16:03:47 2002
+++ b/kernel/ptrace.c	Fri Jul 19 16:03:47 2002
@@ -41,7 +41,9 @@
 
 int ptrace_attach(struct task_struct *task)
 {
+	int retval;
 	task_lock(task);
+	retval = -EPERM;
 	if (task->pid <= 1)
 		goto bad;
 	if (task == current)
@@ -53,7 +55,6 @@
 	    (current->uid != task->uid) ||
  	    (current->gid != task->egid) ||
  	    (current->gid != task->sgid) ||
- 	    (!cap_issubset(task->cap_permitted, current->cap_permitted)) ||
  	    (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
 		goto bad;
 	rmb();
@@ -62,6 +63,9 @@
 	/* the same process cannot be attached many times */
 	if (task->ptrace & PT_PTRACED)
 		goto bad;
+	retval = security_ops->ptrace(current, task);
+	if (retval)
+		goto bad;
 
 	/* Go */
 	task->ptrace |= PT_PTRACED;
@@ -82,7 +86,7 @@
 
 bad:
 	task_unlock(task);
-	return -EPERM;
+	return retval;
 }
 
 int ptrace_detach(struct task_struct *child, unsigned int data)
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Jul 19 16:03:47 2002
+++ b/kernel/sched.c	Fri Jul 19 16:03:47 2002
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
+#include <linux/security.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -1123,6 +1124,7 @@
 
 asmlinkage long sys_nice(int increment)
 {
+	int retval;
 	long nice;
 
 	/*
@@ -1144,6 +1146,11 @@
 		nice = -20;
 	if (nice > 19)
 		nice = 19;
+
+	retval = security_ops->task_setnice(current, nice);
+	if (retval)
+		return retval;
+
 	set_user_nice(current, nice);
 	return 0;
 }
@@ -1236,6 +1243,10 @@
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
 
+	retval = security_ops->task_setscheduler(p, policy, &lp);
+	if (retval)
+		goto out_unlock;
+
 	array = p->array;
 	if (array)
 		deactivate_task(p, task_rq(p));
@@ -1280,8 +1291,11 @@
 	retval = -ESRCH;
 	read_lock(&tasklist_lock);
 	p = find_process_by_pid(pid);
-	if (p)
-		retval = p->policy;
+	if (p) {
+		retval = security_ops->task_getscheduler(p);
+		if (!retval)
+			retval = p->policy;
+	}
 	read_unlock(&tasklist_lock);
 
 out_nounlock:
@@ -1302,6 +1316,11 @@
 	retval = -ESRCH;
 	if (!p)
 		goto out_unlock;
+
+	retval = security_ops->task_getscheduler(p);
+	if (retval)
+		goto out_unlock;
+
 	lp.sched_priority = p->rt_priority;
 	read_unlock(&tasklist_lock);
 
@@ -1509,13 +1528,21 @@
 	retval = -ESRCH;
 	read_lock(&tasklist_lock);
 	p = find_process_by_pid(pid);
-	if (p)
-		jiffies_to_timespec(p->policy & SCHED_FIFO ?
-					 0 : TASK_TIMESLICE(p), &t);
+	if (!p)
+		goto out_unlock;
+
+	retval = security_ops->task_getscheduler(p);
+	if (retval)
+		goto out_unlock;
+
+	jiffies_to_timespec(p->policy & SCHED_FIFO ?
+				0 : TASK_TIMESLICE(p), &t);
 	read_unlock(&tasklist_lock);
-	if (p)
-		retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
+	retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
 out_nounlock:
+	return retval;
+out_unlock:
+	read_unlock(&tasklist_lock);
 	return retval;
 }
 
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	Fri Jul 19 16:03:47 2002
+++ b/kernel/signal.c	Fri Jul 19 16:03:47 2002
@@ -548,6 +548,9 @@
 	ret = -EPERM;
 	if (bad_signal(sig, info, t))
 		goto out_nolock;
+	ret = security_ops->task_kill(t, info, sig);
+	if (ret)
+		goto out_nolock;
 
 	/* The null signal is a permissions and process existence probe.
 	   No signal is actually delivered.  Same goes for zombies. */
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Fri Jul 19 16:03:47 2002
+++ b/kernel/sys.c	Fri Jul 19 16:03:47 2002
@@ -19,6 +19,7 @@
 #include <linux/tqueue.h>
 #include <linux/device.h>
 #include <linux/times.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -234,6 +235,7 @@
 
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
+		int no_nice;
 		if (!proc_sel(p, which, who))
 			continue;
 		if (p->uid != current->euid &&
@@ -243,10 +245,17 @@
 		}
 		if (error == -ESRCH)
 			error = 0;
-		if (niceval < task_nice(p) && !capable(CAP_SYS_NICE))
+		if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
 			error = -EACCES;
-		else
-			set_user_nice(p, niceval);
+			continue;
+		}
+		no_nice = security_ops->task_setnice(p, niceval);
+		if (no_nice) {
+			error = no_nice;
+			continue;
+		}
+		set_user_nice(p, niceval);
+
 	}
 	read_unlock(&tasklist_lock);
 
@@ -416,6 +425,11 @@
 	int old_egid = current->egid;
 	int new_rgid = old_rgid;
 	int new_egid = old_egid;
+	int retval;
+
+	retval = security_ops->task_setgid(rgid, egid, (gid_t)-1, LSM_SETID_RE);
+	if (retval)
+		return retval;
 
 	if (rgid != (gid_t) -1) {
 		if ((old_rgid == rgid) ||
@@ -457,6 +471,11 @@
 asmlinkage long sys_setgid(gid_t gid)
 {
 	int old_egid = current->egid;
+	int retval;
+
+	retval = security_ops->task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_ID);
+	if (retval)
+		return retval;
 
 	if (capable(CAP_SETGID))
 	{
@@ -481,52 +500,6 @@
 	return 0;
 }
   
-/* 
- * cap_emulate_setxuid() fixes the effective / permitted capabilities of
- * a process after a call to setuid, setreuid, or setresuid.
- *
- *  1) When set*uiding _from_ one of {r,e,s}uid == 0 _to_ all of
- *  {r,e,s}uid != 0, the permitted and effective capabilities are
- *  cleared.
- *
- *  2) When set*uiding _from_ euid == 0 _to_ euid != 0, the effective
- *  capabilities of the process are cleared.
- *
- *  3) When set*uiding _from_ euid != 0 _to_ euid == 0, the effective
- *  capabilities are set to the permitted capabilities.
- *
- *  fsuid is handled elsewhere. fsuid == 0 and {r,e,s}uid!= 0 should 
- *  never happen.
- *
- *  -astor 
- *
- * cevans - New behaviour, Oct '99
- * A process may, via prctl(), elect to keep its capabilities when it
- * calls setuid() and switches away from uid==0. Both permitted and
- * effective sets will be retained.
- * Without this change, it was impossible for a daemon to drop only some
- * of its privilege. The call to setuid(!=0) would drop all privileges!
- * Keeping uid 0 is not an option because uid 0 owns too many vital
- * files..
- * Thanks to Olaf Kirch and Peter Benie for spotting this.
- */
-static inline void cap_emulate_setxuid(int old_ruid, int old_euid, 
-				       int old_suid)
-{
-	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
-	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
-	    !current->keep_capabilities) {
-		cap_clear(current->cap_permitted);
-		cap_clear(current->cap_effective);
-	}
-	if (old_euid == 0 && current->euid != 0) {
-		cap_clear(current->cap_effective);
-	}
-	if (old_euid != 0 && current->euid == 0) {
-		current->cap_effective = current->cap_permitted;
-	}
-}
-
 static int set_user(uid_t new_ruid, int dumpclear)
 {
 	struct user_struct *new_user, *old_user;
@@ -572,6 +545,11 @@
 asmlinkage long sys_setreuid(uid_t ruid, uid_t euid)
 {
 	int old_ruid, old_euid, old_suid, new_ruid, new_euid;
+	int retval;
+
+	retval = security_ops->task_setuid(ruid, euid, (uid_t)-1, LSM_SETID_RE);
+	if (retval)
+		return retval;
 
 	new_ruid = old_ruid = current->uid;
 	new_euid = old_euid = current->euid;
@@ -608,11 +586,7 @@
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
-	if (!issecure(SECURE_NO_SETUID_FIXUP)) {
-		cap_emulate_setxuid(old_ruid, old_euid, old_suid);
-	}
-
-	return 0;
+	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
 
@@ -632,6 +606,11 @@
 {
 	int old_euid = current->euid;
 	int old_ruid, old_suid, new_ruid, new_suid;
+	int retval;
+
+	retval = security_ops->task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_ID);
+	if (retval)
+		return retval;
 
 	old_ruid = new_ruid = current->uid;
 	old_suid = current->suid;
@@ -652,11 +631,7 @@
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
-	if (!issecure(SECURE_NO_SETUID_FIXUP)) {
-		cap_emulate_setxuid(old_ruid, old_euid, old_suid);
-	}
-
-	return 0;
+	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
 
@@ -669,6 +644,11 @@
 	int old_ruid = current->uid;
 	int old_euid = current->euid;
 	int old_suid = current->suid;
+	int retval;
+
+	retval = security_ops->task_setuid(ruid, euid, suid, LSM_SETID_RES);
+	if (retval)
+		return retval;
 
 	if (!capable(CAP_SETUID)) {
 		if ((ruid != (uid_t) -1) && (ruid != current->uid) &&
@@ -697,11 +677,7 @@
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
-	if (!issecure(SECURE_NO_SETUID_FIXUP)) {
-		cap_emulate_setxuid(old_ruid, old_euid, old_suid);
-	}
-
-	return 0;
+	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
 asmlinkage long sys_getresuid(uid_t *ruid, uid_t *euid, uid_t *suid)
@@ -720,6 +696,12 @@
  */
 asmlinkage long sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 {
+	int retval;
+
+	retval = security_ops->task_setgid(rgid, egid, sgid, LSM_SETID_RES);
+	if (retval)
+		return retval;
+
 	if (!capable(CAP_SETGID)) {
 		if ((rgid != (gid_t) -1) && (rgid != current->gid) &&
 		    (rgid != current->egid) && (rgid != current->sgid))
@@ -768,6 +750,11 @@
 asmlinkage long sys_setfsuid(uid_t uid)
 {
 	int old_fsuid;
+	int retval;
+
+	retval = security_ops->task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
+	if (retval)
+		return retval;
 
 	old_fsuid = current->fsuid;
 	if (uid == current->uid || uid == current->euid ||
@@ -782,24 +769,9 @@
 		current->fsuid = uid;
 	}
 
-	/* We emulate fsuid by essentially doing a scaled-down version
-	 * of what we did in setresuid and friends. However, we only
-	 * operate on the fs-specific bits of the process' effective
-	 * capabilities 
-	 *
-	 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
-	 *          if not, we might be a bit too harsh here.
-	 */
-	
-	if (!issecure(SECURE_NO_SETUID_FIXUP)) {
-		if (old_fsuid == 0 && current->fsuid != 0) {
-			cap_t(current->cap_effective) &= ~CAP_FS_MASK;
-		}
-		if (old_fsuid != 0 && current->fsuid == 0) {
-			cap_t(current->cap_effective) |=
-				(cap_t(current->cap_permitted) & CAP_FS_MASK);
-		}
-	}
+	retval = security_ops->task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
+	if (retval)
+		return retval;
 
 	return old_fsuid;
 }
@@ -810,6 +782,11 @@
 asmlinkage long sys_setfsgid(gid_t gid)
 {
 	int old_fsgid;
+	int retval;
+
+	retval = security_ops->task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_FS);
+	if (retval)
+		return retval;
 
 	old_fsgid = current->fsgid;
 	if (gid == current->gid || gid == current->egid ||
@@ -904,6 +881,10 @@
 	}
 
 ok_pgid:
+	err = security_ops->task_setpgid(p, pgid);
+	if (err)
+		goto out;
+
 	p->pgrp = pgid;
 	err = 0;
 out:
@@ -924,8 +905,11 @@
 		p = find_task_by_pid(pid);
 
 		retval = -ESRCH;
-		if (p)
-			retval = p->pgrp;
+		if (p) {
+			retval = security_ops->task_getpgid(p);
+			if (!retval)
+				retval = p->pgrp;
+		}
 		read_unlock(&tasklist_lock);
 		return retval;
 	}
@@ -949,8 +933,11 @@
 		p = find_task_by_pid(pid);
 
 		retval = -ESRCH;
-		if(p)
-			retval = p->session;
+		if(p) {
+			retval = security_ops->task_getsid(p);
+			if (!retval)
+				retval = p->session;
+		}
 		read_unlock(&tasklist_lock);
 		return retval;
 	}
@@ -1008,12 +995,19 @@
  
 asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist)
 {
+	gid_t groups[NGROUPS];
+	int retval;
+
 	if (!capable(CAP_SETGID))
 		return -EPERM;
 	if ((unsigned) gidsetsize > NGROUPS)
 		return -EINVAL;
-	if(copy_from_user(current->groups, grouplist, gidsetsize * sizeof(gid_t)))
+	if(copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
 		return -EFAULT;
+	retval = security_ops->task_setgroups(gidsetsize, groups);
+	if (retval)
+		return retval;
+	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
 	current->ngroups = gidsetsize;
 	return 0;
 }
@@ -1158,6 +1152,7 @@
 asmlinkage long sys_setrlimit(unsigned int resource, struct rlimit *rlim)
 {
 	struct rlimit new_rlim, *old_rlim;
+	int retval;
 
 	if (resource >= RLIM_NLIMITS)
 		return -EINVAL;
@@ -1172,6 +1167,11 @@
 		if (new_rlim.rlim_cur > NR_OPEN || new_rlim.rlim_max > NR_OPEN)
 			return -EPERM;
 	}
+
+	retval = security_ops->task_setrlimit(resource, &new_rlim);
+	if (retval)
+		return retval;
+
 	*old_rlim = new_rlim;
 	return 0;
 }
@@ -1242,6 +1242,10 @@
 {
 	int error = 0;
 	int sig;
+
+	error = security_ops->task_prctl(option, arg2, arg3, arg4, arg5);
+	if (error)
+		return error;
 
 	switch (option) {
 		case PR_SET_PDEATHSIG:
diff -Nru a/kernel/uid16.c b/kernel/uid16.c
--- a/kernel/uid16.c	Fri Jul 19 16:03:47 2002
+++ b/kernel/uid16.c	Fri Jul 19 16:03:47 2002
@@ -12,6 +12,7 @@
 #include <linux/prctl.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -128,6 +129,7 @@
 asmlinkage long sys_setgroups16(int gidsetsize, old_gid_t *grouplist)
 {
 	old_gid_t groups[NGROUPS];
+	gid_t new_groups[NGROUPS];
 	int i;
 
 	if (!capable(CAP_SETGID))
@@ -137,7 +139,11 @@
 	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(old_gid_t)))
 		return -EFAULT;
 	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
+		new_groups[i] = (gid_t)groups[i];
+	i = security_ops->task_setgroups(gidsetsize, new_groups);
+	if (i)
+		return i;
+	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
 	current->ngroups = gidsetsize;
 	return 0;
 }
