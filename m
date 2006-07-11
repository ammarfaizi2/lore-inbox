Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWGKHym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWGKHym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWGKHym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:54:42 -0400
Received: from cimai.net4.nerim.net ([62.212.121.89]:51351 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750709AbWGKHyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:54:41 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20060711075400.915074000@localhost.localdomain>
References: <20060711075051.382004000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 11 Jul 2006 09:50:52 +0200
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH -mm 1/7] add execns syscall core routine
Content-Disposition: inline; filename=execns-syscall-core.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the execns syscall core routine.

This new syscall is very similar to execve(). It takes an extra
CLONE_* flag argument which defines which namespaces are unshared
during the execve() call.

The purpose of such a syscall is to make sure that a process unsharing
a namespace is free from any reference in the previous namespace. the
execve() semantic seems to be the best candidate as it already flushes
the previous process context.

The purpose of flush_all_old_files() is to close *all* files even the
files without the close-on-exec flag. To be done. 

sample user program : 

#include <stdio.h>
#include <stdlib.h>
#include <sched.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

#include <linux/unistd.h>

#ifndef __NR_execns
#if __i386__
#    define __NR_execns 318
#elif __x86_64__
#    define __NR_execns 280
#elif __s390x__
#    define __NR_execns 310
#else
#    error "Architecture not supported"
#endif
#endif

static inline _syscall4(int,execns,int,flags,const char *,file,char **,argv,char **,envp)

#ifndef CLONE_NEWIPC
#define CLONE_NEWIPC	0x08000000
#endif

#ifndef CLONE_NEWUSER
#define CLONE_NEWUSER	0x10000000
#endif

static void usage(const char *name)
{
    printf("usage: %s [-iu] <command>\n", name);
    printf("\t-i : unshare ipc namespace.\n");
    printf("\t-u : unshare user namespace.\n");
    printf("\n");
    printf("(C) Copyright IBM Corp, 2006\n");
    printf("\n");
    exit(1);
}

int main(int argc, char* argv[])
{
    int flags = 0;
    int c;

    while ((c = getopt(argc, argv, "+iuh")) != EOF) {
	switch (c) {
	case 'i': flags |= CLONE_NEWIPC; break;
	case 'u': flags |= CLONE_NEWUSER; break;
	case 'h':
	default:
	    usage(argv[0]);
	}
    };
    
    argv = &argv[optind];
    argc = argc - optind;
	
    execns(flags, argv[0], argv, __environ);
    fprintf(stderr, "execns(%s) : %s\n", argv[0], strerror(errno));
    return 1;
}


Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>

---
 fs/exec.c                |   82 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h    |    1 
 include/linux/syscalls.h |    3 +
 kernel/sys_ni.c          |    2 +
 4 files changed, 88 insertions(+)

Index: 2.6.18-rc1-mm1/fs/exec.c
===================================================================
--- 2.6.18-rc1-mm1.orig/fs/exec.c
+++ 2.6.18-rc1-mm1/fs/exec.c
@@ -49,6 +49,7 @@
 #include <linux/acct.h>
 #include <linux/audit.h>
 #include <linux/notifier.h>
+#include <linux/user.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -805,6 +806,11 @@ static void flush_old_files(struct files
 	spin_unlock(&files->file_lock);
 }
 
+static void flush_all_old_files(struct files_struct * files)
+{
+	/* flush it all even close_on_exec == 0 */
+}
+
 void get_task_comm(char *buf, struct task_struct *tsk)
 {
 	/* buf must be at least sizeof(tsk->comm) in size */
@@ -1235,6 +1241,82 @@ out_ret:
 	return retval;
 }
 
+/*
+ * sys_execns() executes a new program and unshares selected
+ * namespaces.
+ */
+int do_execns(int unshare_flags, char * filename,
+	char __user *__user *argv,
+	char __user *__user *envp,
+	struct pt_regs * regs)
+{
+	int err = 0;
+	struct nsproxy *new_nsproxy = NULL, *old_nsproxy = NULL;
+	struct uts_namespace *uts, *new_uts = NULL;
+	struct ipc_namespace *ipc, *new_ipc = NULL;
+
+	err = unshare_utsname(unshare_flags, &new_uts);
+	if (err)
+		goto bad_execns_out;
+	err = unshare_ipcs(unshare_flags, &new_ipc);
+	if (err)
+		goto bad_execns_cleanup_uts;
+
+	if (new_uts || new_ipc) {
+		old_nsproxy = current->nsproxy;
+		new_nsproxy = dup_namespaces(old_nsproxy);
+		if (!new_nsproxy) {
+			err = -ENOMEM;
+			goto bad_execns_cleanup_ipc;
+		}
+	}
+
+	err = do_execve(filename, argv, envp, regs);
+	if (err)
+		goto bad_execns_cleanup_ipc;
+
+	/* make sure all files are flushed */
+	flush_all_old_files(current->files);
+
+	if (new_uts || new_ipc) {
+
+		task_lock(current);
+
+		if (new_nsproxy) {
+			current->nsproxy = new_nsproxy;
+			new_nsproxy = old_nsproxy;
+		}
+
+		if (new_uts) {
+			uts = current->nsproxy->uts_ns;
+			current->nsproxy->uts_ns = new_uts;
+			new_uts = uts;
+		}
+
+		if (new_ipc) {
+			ipc = current->nsproxy->ipc_ns;
+			current->nsproxy->ipc_ns = new_ipc;
+			new_ipc = ipc;
+		}
+
+		task_unlock(current);
+	}
+
+	if (new_nsproxy)
+		put_nsproxy(new_nsproxy);
+
+bad_execns_cleanup_ipc:
+	if (new_ipc)
+		put_ipc_ns(new_ipc);
+
+bad_execns_cleanup_uts:
+	if (new_uts)
+		put_uts_ns(new_uts);
+
+bad_execns_out:
+	return err;
+}
+
 int set_binfmt(struct linux_binfmt *new)
 {
 	struct linux_binfmt *old = current->binfmt;
Index: 2.6.18-rc1-mm1/include/linux/sched.h
===================================================================
--- 2.6.18-rc1-mm1.orig/include/linux/sched.h
+++ 2.6.18-rc1-mm1/include/linux/sched.h
@@ -1335,6 +1335,7 @@ extern int disallow_signal(int);
 extern struct task_struct *child_reaper;
 
 extern int do_execve(char *, char __user * __user *, char __user * __user *, struct pt_regs *);
+extern int do_execns(int, char *, char __user * __user *, char __user * __user *, struct pt_regs *);
 extern long do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
 struct task_struct *fork_idle(int);
 
Index: 2.6.18-rc1-mm1/include/linux/syscalls.h
===================================================================
--- 2.6.18-rc1-mm1.orig/include/linux/syscalls.h
+++ 2.6.18-rc1-mm1/include/linux/syscalls.h
@@ -64,6 +64,7 @@ struct robust_list_head;
 #include <asm/signal.h>
 #include <linux/quota.h>
 #include <linux/key.h>
+#include <asm/ptrace.h>
 
 asmlinkage long sys_time(time_t __user *tloc);
 asmlinkage long sys_stime(time_t __user *tptr);
@@ -597,4 +598,6 @@ asmlinkage long sys_get_robust_list(int 
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
+asmlinkage long sys_execns(int flags, char *name, char **argv, char **envp,
+			struct pt_regs regs);
 #endif
Index: 2.6.18-rc1-mm1/kernel/sys_ni.c
===================================================================
--- 2.6.18-rc1-mm1.orig/kernel/sys_ni.c
+++ 2.6.18-rc1-mm1/kernel/sys_ni.c
@@ -134,3 +134,5 @@ cond_syscall(sys_madvise);
 cond_syscall(sys_mremap);
 cond_syscall(sys_remap_file_pages);
 cond_syscall(compat_sys_move_pages);
+
+cond_syscall(sys_execns);

--
