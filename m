Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTH2Tyc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbTH2Tyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:54:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:39403 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261692AbTH2TyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:54:00 -0400
Subject: [RFC/PATCH] CKRM core 2.6.0-test2
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: ckrm-tech <ckrm-tech@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1062186797.15245.835.camel@elinux05.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Aug 2003 15:53:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Core patch defining kernel API for Class-based Kernel Resource
Management.
Required for all other patches related to CKRM.

For more details, please refer to 
	http://ckrm.sf.net

and earlier postings on lkml.

-- Shailabh

------------------------------------------------------------------------------------
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Fri Aug 29 14:08:14 2003
+++ b/arch/i386/Kconfig	Fri Aug 29 14:08:14 2003
@@ -461,6 +461,12 @@
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
 
+config CKRM
+	bool "Class Based Kernel Resource Management"
+	depends on EXPERIMENTAL
+	help
+	  This option adds CKRM support to the Kernel. Say N if you are
unsure.
+
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
 	depends on !(X86_VISWS || X86_VOYAGER)
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Fri Aug 29 14:08:14 2003
+++ b/fs/exec.c	Fri Aug 29 14:08:14 2003
@@ -45,6 +45,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/rmap-locking.h>
+#include <linux/ckrm.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -1098,6 +1099,8 @@
 	retval = search_binary_handler(&bprm,regs);
 	if (retval >= 0) {
 		free_arg_pages(&bprm);
+
+		ckrm_cb_exec(current,filename);
 
 		/* execve success */
 		security_bprm_free(&bprm);
diff -Nru a/include/linux/ckrm.h b/include/linux/ckrm.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/ckrm.h	Fri Aug 29 14:08:14 2003
@@ -0,0 +1,88 @@
+/* ckrm.h - Class-based Kernel Resource Management (CKRM)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Shailabh Nagar,  IBM Corp. 2003
+ * 
+ * 
+ * Provides kernel API of CKRM for in-kernel,per-resource controllers 
+ * (one each for cpu, memory, io, network) and callbacks for 
+ * classification modules.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ */
+
+#ifndef _SYS_CKRM_H
+#define _SYS_CKRM_H
+
+#ifdef CONFIG_CKRM
+
+#define
DECLARE_CKRM_CLASS(res)                                                    	\
+	struct ckrm_##res##_class *ckrm_alloc_##res##_class(void *obj);			\
+	int ckrm_free_##res##_class(struct ckrm_##res##_class *cls);			\
+	int ckrm_##res##_set_share(struct ckrm_##res##_class *cls, ulong
share);	\
+	ulong ckrm_##res##_get_usage(struct ckrm_##res##_class *cls);			\
+	struct ckrm_##res##_class
*ckrm_dflt_##res##_class(void*);                      \
+        void ckrm_##res##_change_class(struct task_struct *tsk, struct
ckrm_##res##_class *cls)
+
+DECLARE_CKRM_CLASS(cpu);
+DECLARE_CKRM_CLASS(mem);
+DECLARE_CKRM_CLASS(net);
+DECLARE_CKRM_CLASS(io);
+
+
+/* ckrm events and notification */
+
+struct task;
+
+struct ckrm_callbacks {
+	void (*fork)(struct task_struct *); /* on fork */
+	void (*exit)(struct task_struct *); /* on exit */
+	void (*exec)(struct task_struct *,char *filename); /* on exec*/
+	void (*login)(void);         /* new user logged in */
+	void (*id)(void);            /* any change on uid,gid */
+	void (*useradd)(struct user_struct *up);
+	void (*userdel)(struct user_struct *up);
+
+	char* (*classname)(void *obj);  /* return a name string */
+	/* and more to come */
+};
+
+extern struct ckrm_callbacks  ckrm_callbacks;
+
+#define CKRM_CB(fct)  if (ckrm_callbacks.fct) (*ckrm_callbacks.fct)
+#define CKRM_CBVAL(fct,args,val) 
((ckrm_callbacks.fct)?(*ckrm_callbacks.fct)args:(val))
+
+#else
+
+#define CKRM_CB(fct)
+#define CKRM_CBVAL(fct,args,val)  (val)
+
+#endif
+
+static inline void ckrm_cb_fork(struct task_struct* tsk)   {
CKRM_CB(fork)(tsk); }
+static inline void ckrm_cb_exit(struct task_struct* tsk)   {
CKRM_CB(exit)(tsk); }
+static inline void ckrm_cb_exec( struct task_struct* tsk,char
*filename)
+						   { CKRM_CB(exec)(tsk,filename); }
+static inline void ckrm_cb_login(void)                     {
CKRM_CB(login)(); }
+static inline void ckrm_cb_id(void)                        {
CKRM_CB(id)(); }
+static inline void ckrm_cb_useradd(struct user_struct *up) {
CKRM_CB(useradd)(up); }
+static inline void ckrm_cb_userdel(struct user_struct *up) {
CKRM_CB(userdel)(up); }
+
+static inline char* ckrm_cb_classname(void *obj) { return
CKRM_CBVAL(classname,(obj),"noname"); }
+
+int ckrm_register_engine(struct ckrm_callbacks *cbs);
+int ckrm_unregister_engine(void);
+
+#endif
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Aug 29 14:08:14 2003
+++ b/include/linux/sched.h	Fri Aug 29 14:08:14 2003
@@ -457,6 +457,12 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+
+	struct ckrm_cpu_class *cpu_class;
+	struct ckrm_mem_class *mem_class;
+	struct ckrm_net_class *net_class;
+	struct ckrm_io_class  *io_class;
+	void *ckrm_client_data;              
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	Fri Aug 29 14:08:14 2003
+++ b/kernel/Makefile	Fri Aug 29 14:08:14 2003
@@ -19,6 +19,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_CKRM) += ckrm.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the
-fno-omit-frame-pointer is
diff -Nru a/kernel/ckrm.c b/kernel/ckrm.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/ckrm.c	Fri Aug 29 14:08:14 2003
@@ -0,0 +1,117 @@
+/* ckrm.c - Class-based Kernel Resource Management (CKRM)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Shailabh Nagar,  IBM Corp. 2003
+ * 
+ * 
+ * Provides kernel API of CKRM for in-kernel,per-resource controllers 
+ * (one each for cpu, memory, io, network) and callbacks for 
+ * classification modules.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ */
+
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+#include <linux/mm.h>
+#include <asm/errno.h>
+#include <linux/string.h>
+#include <linux/ckrm.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+
+#define CKRM_DEFINE_RESOURCE_CLASSES    /* provide definitons for now
*/
+
+
+struct ckrm_callbacks  ckrm_callbacks;  /* nulled initially by default
*/
+EXPORT_SYMBOL(ckrm_callbacks);
+
+
+#ifdef CKRM_DEFINE_RESOURCE_CLASSES
+
+/* define some dummy classes that can be used for testing 
+ * the correct system will provide them in their associate kernel
+ * subsection
+ */
+
+#define DEF_CKRM_CLASS(res)							\
+struct ckrm_##res##_class { ulong share; ulong usage; };			\
+struct ckrm_##res##_class
ckrm_dflt_##res##_classobj={.share=100,.usage=0 };	\
+struct ckrm_##res##_class *ckrm_alloc_##res##_class(void *obj) {		\
+	   return kmalloc(sizeof(struct ckrm_##res##_class),GFP_KERNEL);	\
+}										\
+int ckrm_free_##res##_class(struct ckrm_##res##_class *cls) {			\
+	kfree(cls);								\
+        return 0;								\
+}										\
+int ckrm_##res##_set_share(struct ckrm_##res##_class *cls, ulong share)
{	\
+	cls->share = share;							\
+	return 0;								\
+}										\
+ulong ckrm_##res##_get_usage(struct ckrm_##res##_class *cls) {			\
+	return cls->usage;							\
+}										\
+struct ckrm_##res##_class *ckrm_dflt_##res##_class(void *obj) {			\
+	return &ckrm_dflt_##res##_classobj;					\
+}										\
+void ckrm_##res##_change_class(struct task_struct *tsk,				\
+                               struct ckrm_##res##_class *cls) {		\
+        tsk->res##_class = cls;							\
+}			                                                        \	
+EXPORT_SYMBOL(ckrm_##res##_change_class);					\
+EXPORT_SYMBOL(ckrm_alloc_##res##_class);					\
+EXPORT_SYMBOL(ckrm_free_##res##_class);						\
+EXPORT_SYMBOL(ckrm_##res##_set_share);						\
+EXPORT_SYMBOL(ckrm_##res##_get_usage);						\
+EXPORT_SYMBOL(ckrm_dflt_##res##_class)                                        
+
+
+
+DEF_CKRM_CLASS(cpu);
+DEF_CKRM_CLASS(mem);
+DEF_CKRM_CLASS(net);
+DEF_CKRM_CLASS(io);
+
+
+struct ckrm_callbacks ckrm_callbacks;
+static struct ckrm_callbacks ckrm_callbacks_orig;
+
+int ckrm_register_engine(struct ckrm_callbacks *cbs)
+{
+	/* need to do some error checking and permission checking */
+	ckrm_callbacks_orig = ckrm_callbacks;
+	ckrm_callbacks = *cbs;
+	return 0;
+}
+
+int ckrm_unregister_engine(void)
+{
+	ckrm_callbacks = ckrm_callbacks_orig;
+	return 0;
+}
+
+EXPORT_SYMBOL(ckrm_register_engine);
+EXPORT_SYMBOL(ckrm_unregister_engine);
+
+
+#endif
+
+
+
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Fri Aug 29 14:08:14 2003
+++ b/kernel/exit.c	Fri Aug 29 14:08:14 2003
@@ -22,6 +22,7 @@
 #include <linux/profile.h>
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
+#include <linux/ckrm.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -564,6 +565,8 @@
 static void exit_notify(struct task_struct *tsk)
 {
 	struct task_struct *t;
+
+	ckrm_cb_exit(tsk);
 
 	if (signal_pending(tsk) && !tsk->signal->group_exit
 	    && !thread_group_empty(tsk)) {
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri Aug 29 14:08:14 2003
+++ b/kernel/fork.c	Fri Aug 29 14:08:14 2003
@@ -30,6 +30,7 @@
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
+#include <linux/ckrm.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1062,6 +1063,7 @@
 	}
 
 	p = copy_process(clone_flags, stack_start, regs, stack_size,
parent_tidptr, child_tidptr);
+
 	/*
 	 * Do this prior waking up the new thread - the thread pointer
 	 * might get invalid after that point, if the thread exits quickly.
@@ -1070,6 +1072,8 @@
 
 	if (!IS_ERR(p)) {
 		struct completion vfork;
+
+		ckrm_cb_fork(p);
 
 		if (clone_flags & CLONE_VFORK) {
 			p->vfork_done = &vfork;
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Fri Aug 29 14:08:14 2003
+++ b/kernel/sys.c	Fri Aug 29 14:08:14 2003
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
+#include <linux/ckrm.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -554,6 +555,9 @@
 	current->fsgid = new_egid;
 	current->egid = new_egid;
 	current->gid = new_rgid;
+
+	ckrm_cb_id();
+
 	return 0;
 }
 
@@ -591,6 +595,9 @@
 	}
 	else
 		return -EPERM;
+
+	ckrm_cb_id();
+
 	return 0;
 }
   
@@ -679,6 +686,8 @@
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
+	ckrm_cb_id();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid,
LSM_SETID_RE);
 }
 
@@ -724,6 +733,8 @@
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
+	ckrm_cb_id();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid,
LSM_SETID_ID);
 }
 
@@ -770,6 +781,8 @@
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
+	ckrm_cb_id();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid,
LSM_SETID_RES);
 }
 
@@ -819,6 +832,9 @@
 		current->gid = rgid;
 	if (sgid != (gid_t) -1)
 		current->sgid = sgid;
+
+	ckrm_cb_id();
+
 	return 0;
 }
 
diff -Nru a/kernel/user.c b/kernel/user.c
--- a/kernel/user.c	Fri Aug 29 14:08:14 2003
+++ b/kernel/user.c	Fri Aug 29 14:08:14 2003
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
+#include <linux/ckrm.h>
 
 /*
  * UID task count cache, to get fast user lookup in "alloc_uid"
@@ -72,6 +73,7 @@
 void free_uid(struct user_struct *up)
 {
 	if (up && atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
+		ckrm_cb_userdel(up);
 		uid_hash_remove(up);
 		kmem_cache_free(uid_cachep, up);
 		spin_unlock(&uidhash_lock);
@@ -108,10 +110,10 @@
 			kmem_cache_free(uid_cachep, new);
 		} else {
 			uid_hash_insert(new, hashent);
+			ckrm_cb_useradd(up);
 			up = new;
 		}
 		spin_unlock(&uidhash_lock);
-
 	}
 	return up;
 }



