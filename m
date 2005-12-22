Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVLVE4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVLVE4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVLVE4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:56:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36048 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965088AbVLVEvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:10 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 25/36] m68k: syscalls __user annotation
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQ1-0004t0-ME@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011534 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/kernel/sys_m68k.c |   39 ++++++++++++++++-----------------------
 1 files changed, 16 insertions(+), 23 deletions(-)

ca04ae0dbcbe00b822a4619d7b99bb9b2d56a399
diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 2ed7b78..7a107d0 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -31,7 +31,7 @@
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way unix traditionally does this, though.
  */
-asmlinkage int sys_pipe(unsigned long * fildes)
+asmlinkage int sys_pipe(unsigned long __user * fildes)
 {
 	int fd[2];
 	int error;
@@ -93,7 +93,7 @@ struct mmap_arg_struct {
 	unsigned long offset;
 };
 
-asmlinkage int old_mmap(struct mmap_arg_struct *arg)
+asmlinkage int old_mmap(struct mmap_arg_struct __user *arg)
 {
 	struct mmap_arg_struct a;
 	int error = -EFAULT;
@@ -159,11 +159,11 @@ out:
 
 struct sel_arg_struct {
 	unsigned long n;
-	fd_set *inp, *outp, *exp;
-	struct timeval *tvp;
+	fd_set __user *inp, *outp, *exp;
+	struct timeval __user *tvp;
 };
 
-asmlinkage int old_select(struct sel_arg_struct *arg)
+asmlinkage int old_select(struct sel_arg_struct __user *arg)
 {
 	struct sel_arg_struct a;
 
@@ -179,7 +179,7 @@ asmlinkage int old_select(struct sel_arg
  * This is really horribly ugly.
  */
 asmlinkage int sys_ipc (uint call, int first, int second,
-			int third, void *ptr, long fifth)
+			int third, void __user *ptr, long fifth)
 {
 	int version, ret;
 
@@ -189,14 +189,14 @@ asmlinkage int sys_ipc (uint call, int f
 	if (call <= SEMCTL)
 		switch (call) {
 		case SEMOP:
-			return sys_semop (first, (struct sembuf *)ptr, second);
+			return sys_semop (first, ptr, second);
 		case SEMGET:
 			return sys_semget (first, second, third);
 		case SEMCTL: {
 			union semun fourth;
 			if (!ptr)
 				return -EINVAL;
-			if (get_user(fourth.__pad, (void **) ptr))
+			if (get_user(fourth.__pad, (void __user *__user *) ptr))
 				return -EFAULT;
 			return sys_semctl (first, second, third, fourth);
 			}
@@ -206,31 +206,26 @@ asmlinkage int sys_ipc (uint call, int f
 	if (call <= MSGCTL)
 		switch (call) {
 		case MSGSND:
-			return sys_msgsnd (first, (struct msgbuf *) ptr,
-					  second, third);
+			return sys_msgsnd (first, ptr, second, third);
 		case MSGRCV:
 			switch (version) {
 			case 0: {
 				struct ipc_kludge tmp;
 				if (!ptr)
 					return -EINVAL;
-				if (copy_from_user (&tmp,
-						    (struct ipc_kludge *)ptr,
-						    sizeof (tmp)))
+				if (copy_from_user (&tmp, ptr, sizeof (tmp)))
 					return -EFAULT;
 				return sys_msgrcv (first, tmp.msgp, second,
 						   tmp.msgtyp, third);
 				}
 			default:
-				return sys_msgrcv (first,
-						   (struct msgbuf *) ptr,
+				return sys_msgrcv (first, ptr,
 						   second, fifth, third);
 			}
 		case MSGGET:
 			return sys_msgget ((key_t) first, second);
 		case MSGCTL:
-			return sys_msgctl (first, second,
-					   (struct msqid_ds *) ptr);
+			return sys_msgctl (first, second, ptr);
 		default:
 			return -ENOSYS;
 		}
@@ -240,20 +235,18 @@ asmlinkage int sys_ipc (uint call, int f
 			switch (version) {
 			default: {
 				ulong raddr;
-				ret = do_shmat (first, (char *) ptr,
-						 second, &raddr);
+				ret = do_shmat (first, ptr, second, &raddr);
 				if (ret)
 					return ret;
-				return put_user (raddr, (ulong *) third);
+				return put_user (raddr, (ulong __user *) third);
 			}
 			}
 		case SHMDT:
-			return sys_shmdt ((char *)ptr);
+			return sys_shmdt (ptr);
 		case SHMGET:
 			return sys_shmget (first, second, third);
 		case SHMCTL:
-			return sys_shmctl (first, second,
-					   (struct shmid_ds *) ptr);
+			return sys_shmctl (first, second, ptr);
 		default:
 			return -ENOSYS;
 		}
-- 
0.99.9.GIT

