Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTEBSOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTEBSOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:14:44 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:53731 "EHLO
	mail-2.tiscali.it") by vger.kernel.org with ESMTP id S263055AbTEBSOj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:14:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniele Bellucci <bellucda@tiscali.it> (by way of Daniele Bellucci
	<danielebellucci@libero.it>)
Subject: FIX 2.4.20-2.4.21-rc1: comp. problems in find_task_by_pid, sys_capget, sys_ptrace, sys_tkill..
Date: Fri, 2 May 2003 20:26:45 +0200
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
Cc: gareth@valinux.com, marcelo@conectiva.com.br, zefram@fysh.org,
       morgan@transmeta.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305022026.45676.danielebellucci@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i've fixed some compatibility problems mist. :

include/linux/sched.h:
 change type of find_task_by_pid argument (pid) to pid_t (original: int)

arch/i386/kernel/ptrace.c:
 changed type of sys_ptrace pid argument to pid_t (original: long)

include/linux/fs.h:
  changed type of pid member of struct fown_struct to pid_t (original: int)

fs/proc/base.c:
 change type of pid variable in  proc_pid_lookup to pid_t (original: unsigned
 int) [See Above]


kernel/capability.c:
 in sys_capget: change type of pid variable to pid_t  (original: int)
 in sys_capset: change type of pid variable to pid_t  (original: int)

kernel/signal.c:
 in sys_tkill: changed type of pid argument to pid_t (original: int)



diff -urN -X dontdiff linux-2.4.20-orig/arch/i386/kernel/ptrace.c linux-2.4.20-pid_t/arch/i386/kernel/ptrace.c
--- linux-2.4.20-orig/arch/i386/kernel/ptrace.c	Sat Aug  3 02:39:42 2002
+++ linux-2.4.20-pid_t/arch/i386/kernel/ptrace.c	Thu May  1 14:26:58 2003
@@ -147,7 +147,7 @@
 	put_stack_long(child, EFL_OFFSET, tmp);
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage int sys_ptrace(long request, pid_t pid, long addr, long data)
 {
 	struct task_struct *child;
 	struct user * dummy = NULL;
diff -urN -X dontdiff linux-2.4.20-orig/fs/fcntl.c linux-2.4.20-pid_t/fs/fcntl.c
--- linux-2.4.20-orig/fs/fcntl.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-pid_t/fs/fcntl.c	Thu May  1 14:27:19 2003
@@ -435,7 +435,7 @@
 void send_sigio(struct fown_struct *fown, int fd, int band)
 {
 	struct task_struct * p;
-	int   pid	= fown->pid;
+	pid_t   pid	= fown->pid;
 	
 	read_lock(&tasklist_lock);
 	if ( (pid > 0) && (p = find_task_by_pid(pid)) ) {
diff -urN -X dontdiff linux-2.4.20-orig/fs/proc/base.c linux-2.4.20-pid_t/fs/proc/base.c
--- linux-2.4.20-orig/fs/proc/base.c	Sat Aug  3 02:39:45 2002
+++ linux-2.4.20-pid_t/fs/proc/base.c	Thu May  1 14:30:16 2003
@@ -974,7 +974,8 @@
 
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry)
 {
-	unsigned int pid, c;
+	pid_t pid;
+	unsigned int c;
 	struct task_struct *task;
 	const char *name;
 	struct inode *inode;
diff -urN -X dontdiff linux-2.4.20-orig/include/linux/fs.h linux-2.4.20-pid_t/include/linux/fs.h
--- linux-2.4.20-orig/include/linux/fs.h	Tue Apr 22 04:47:30 2003
+++ linux-2.4.20-pid_t/include/linux/fs.h	Thu May  1 14:51:42 2003
@@ -515,7 +515,7 @@
 };


The same can be applied for 2.4.21-rc1 version, too.
 
 struct fown_struct {
-	int pid;		/* pid or -pgrp where SIGIO should be sent */
+	pid_t pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
diff -urN -X dontdiff linux-2.4.20-orig/include/linux/sched.h linux-2.4.20-pid_t/include/linux/sched.h
--- linux-2.4.20-orig/include/linux/sched.h	Tue Apr 22 06:55:20 2003
+++ linux-2.4.20-pid_t/include/linux/sched.h	Thu May  1 14:51:42 2003
@@ -550,7 +550,7 @@
 	*p->pidhash_pprev = p->pidhash_next;
 }
 
-static inline struct task_struct *find_task_by_pid(int pid)
+static inline struct task_struct *find_task_by_pid(pid_t pid)
 {
 	struct task_struct *p, **htable = &pidhash[pid_hashfn(pid)];
 
diff -urN -X dontdiff linux-2.4.20-orig/kernel/capability.c linux-2.4.20-pid_t/kernel/capability.c
--- linux-2.4.20-orig/kernel/capability.c	Sat Jun 24 06:06:37 2000
+++ linux-2.4.20-pid_t/kernel/capability.c	Thu May  1 14:52:50 2003
@@ -21,7 +21,8 @@
 
 asmlinkage long sys_capget(cap_user_header_t header, cap_user_data_t dataptr)
 {
-     int error, pid;
+     int error;
+     pid_t pid;
      __u32 version;
      struct task_struct *target;
      struct __user_cap_data_struct data;
@@ -131,7 +132,8 @@
      kernel_cap_t inheritable, permitted, effective;
      __u32 version;
      struct task_struct *target;
-     int error, pid;
+     int error;
+     pid_t pid;
 
      if (get_user(version, &header->version))
 	     return -EFAULT; 
diff -urN -X dontdiff linux-2.4.20-orig/kernel/signal.c linux-2.4.20-pid_t/kernel/signal.c
--- linux-2.4.20-orig/kernel/signal.c	Tue Apr 22 04:20:42 2003
+++ linux-2.4.20-pid_t/kernel/signal.c	Thu May  1 14:32:38 2003
@@ -1003,7 +1003,7 @@
  *  Kill only one task, even if it's a CLONE_THREAD task.
  */
 asmlinkage long
-sys_tkill(int pid, int sig)
+sys_tkill(pid_t pid, int sig)
 {
        struct siginfo info;
        int error;




The same work for 2.4.21-rc1 too.



Daniele Bellucci

