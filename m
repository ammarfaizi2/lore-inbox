Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263419AbUECB1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUECB1q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 21:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUECB1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 21:27:46 -0400
Received: from ozlabs.org ([203.10.76.45]:16338 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263419AbUECB1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 21:27:17 -0400
Date: Mon, 3 May 2004 11:23:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Make ppc64 use generic ipc syscall translation
Message-ID: <20040503012309.GA31256@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply:

Currently ppc64 has its own code to convert 32-bit ipc() syscalls to
64-bit, rather than using the common translation code from
ipc/compat.c.  This patch, tweaked slightly from an earlier version of
Anton Blanchard's fixes that, replacing the ppc64 code with calls to
the common code.

I've run the LSB IPC tests, and as many of the LTP IPC tests as I
could figure out how to run easily, and it seems to pass them all.

===== arch/ppc64/kernel/sys_ppc32.c 1.88 vs edited =====
Index: working-2.6/arch/ppc64/kernel/sys_ppc32.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/sys_ppc32.c	2004-04-30 15:59:31.199989136 +1000
+++ working-2.6/arch/ppc64/kernel/sys_ppc32.c	2004-04-30 16:28:44.822901624 +1000
@@ -15,7 +15,6 @@
  */
 
 #include <linux/config.h>
-#include <asm/ptrace.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/fs.h> 
@@ -60,17 +59,17 @@
 #include <linux/compat.h>
 #include <linux/ptrace.h>
 #include <linux/aio_abi.h>
+#include <linux/elf.h>
+
+#include <net/scm.h>
+#include <net/sock.h>
 
+#include <asm/ptrace.h>
 #include <asm/types.h>
 #include <asm/ipc.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
-
 #include <asm/semaphore.h>
-
-#include <net/scm.h>
-#include <net/sock.h>
-#include <linux/elf.h>
 #include <asm/ppcdebug.h>
 #include <asm/time.h>
 #include <asm/ppc32.h>
@@ -1057,625 +1056,69 @@
 	return do_sys_settimeofday(tv ? &kts : NULL, tz ? &ktz : NULL);
 }
 
-
-struct msgbuf32 {
-	compat_long_t mtype; 
-	char mtext[1];
-};
-
-struct semid_ds32 {
-	struct ipc_perm sem_perm;
-	compat_time_t sem_otime;
-	compat_time_t sem_ctime;
-	compat_uptr_t sem_base;
-	compat_uptr_t sem_pending;
-	compat_uptr_t sem_pending_last;
-	compat_uptr_t undo;
-	unsigned short sem_nsems;
-};
-
-struct semid64_ds32 {
-	struct ipc64_perm sem_perm;
-	unsigned int __unused1;
-	compat_time_t sem_otime;
-	unsigned int __unused2;
-	compat_time_t sem_ctime;
-	compat_ulong_t sem_nsems;
-	compat_ulong_t __unused3;
-	compat_ulong_t __unused4;
-};
-
-struct msqid_ds32 {
-	struct ipc_perm msg_perm;
-	compat_uptr_t msg_first;
-	compat_uptr_t msg_last;
-	compat_time_t msg_stime;
-	compat_time_t msg_rtime;
-	compat_time_t msg_ctime;
-	compat_ulong_t msg_lcbytes;
-	compat_ulong_t msg_lqbytes;
-	unsigned short msg_cbytes;
-	unsigned short msg_qnum;
-	unsigned short msg_qbytes;
-	compat_ipc_pid_t msg_lspid;
-	compat_ipc_pid_t msg_lrpid;
-};
-
-struct msqid64_ds32 {
-	struct ipc64_perm msg_perm;
-	unsigned int __unused1;
-	compat_time_t msg_stime;
-	unsigned int __unused2;
-	compat_time_t msg_rtime;
-	unsigned int __unused3;
-	compat_time_t msg_ctime;
-	compat_ulong_t msg_cbytes;
-	compat_ulong_t msg_qnum;
-	compat_ulong_t msg_qbytes;
-	compat_pid_t msg_lspid;
-	compat_pid_t msg_lrpid;
-	compat_ulong_t __unused4;
-	compat_ulong_t __unused5;
-};
-
-struct shmid_ds32 {
-	struct ipc_perm shm_perm;
-	int shm_segsz;
-	compat_time_t shm_atime;
-	compat_time_t shm_dtime;
-	compat_time_t shm_ctime;
-	compat_ipc_pid_t shm_cpid;
-	compat_ipc_pid_t shm_lpid;
-	unsigned short shm_nattch;
-	unsigned short __unused;
-	compat_uptr_t __unused2;
-	compat_uptr_t __unused3;
-};
-
-struct shmid64_ds32 {
-	struct ipc64_perm shm_perm;
-	unsigned int __unused1;
-	compat_time_t shm_atime;
-	unsigned int __unused2;
-	compat_time_t shm_dtime;
-	unsigned int __unused3;
-	compat_time_t shm_ctime;
-	unsigned int __unused4;
-	compat_size_t shm_segsz;
-	compat_pid_t shm_cpid;
-	compat_pid_t shm_lpid;
-	compat_ulong_t shm_nattch;
-	compat_ulong_t __unused5;
-	compat_ulong_t __unused6;
-};
-
-/*
- * sys32_ipc() is the de-multiplexer for the SysV IPC calls in 32bit
- * emulation..
- *
- * This is really horribly ugly.
- */
-static long do_sys32_semctl(int first, int second, int third, void *uptr)
-{
-	union semun fourth;
-	u32 pad;
-	int err, err2;
-	mm_segment_t old_fs;
-
-	if (!uptr)
-		return -EINVAL;
-	err = -EFAULT;
-	if (get_user(pad, (u32 *)uptr))
-		return err;
-	if ((third & ~IPC_64) == SETVAL)
-		fourth.val = (int)pad;
-	else
-		fourth.__pad = (void *)A(pad);
-	switch (third & (~IPC_64)) {
-
-	case IPC_INFO:
-	case IPC_RMID:
-	case SEM_INFO:
-	case GETVAL:
-	case GETPID:
-	case GETNCNT:
-	case GETZCNT:
-	case GETALL:
-	case SETALL:
-	case SETVAL:
-		err = sys_semctl(first, second, third, fourth);
-		break;
-
-	case IPC_STAT:
-	case SEM_STAT:
-		if (third & IPC_64) {
-			struct semid64_ds s64;
-			struct semid64_ds32 *usp;
-
-			usp = (struct semid64_ds32 *)A(pad);
-			fourth.__pad = &s64;
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_semctl(first, second, third, fourth);
-			set_fs(old_fs);
-			err2 = copy_to_user(&usp->sem_perm, &s64.sem_perm,
-					    sizeof(struct ipc64_perm));
-			err2 |= __put_user(s64.sem_otime, &usp->sem_otime);
-			err2 |= __put_user(s64.sem_ctime, &usp->sem_ctime);
-			err2 |= __put_user(s64.sem_nsems, &usp->sem_nsems);
-			if (err2)
-				err = -EFAULT;
-		} else {
-			struct semid_ds s;
-			struct semid_ds32 *usp;
-
-			usp = (struct semid_ds32 *)A(pad);
-			fourth.__pad = &s;
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_semctl(first, second, third, fourth);
-			set_fs(old_fs);
-			err2 = copy_to_user(&usp->sem_perm, &s.sem_perm,
-					    sizeof(struct ipc_perm));
-			err2 |= __put_user(s.sem_otime, &usp->sem_otime);
-			err2 |= __put_user(s.sem_ctime, &usp->sem_ctime);
-			err2 |= __put_user(s.sem_nsems, &usp->sem_nsems);
-			if (err2)
-				err = -EFAULT;
-		}
-		break;
- 
-	case IPC_SET:
-		if (third & IPC_64) {
-			struct semid64_ds s64;
-			struct semid64_ds32 *usp;
-
-			usp = (struct semid64_ds32 *)A(pad);
-
-			err = get_user(s64.sem_perm.uid, &usp->sem_perm.uid);
-			err |= __get_user(s64.sem_perm.gid,
-					  &usp->sem_perm.gid);
-			err |= __get_user(s64.sem_perm.mode,
-					  &usp->sem_perm.mode);
-			if (err)
-				goto out;
-			fourth.__pad = &s64;
-
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_semctl(first, second, third, fourth);
-			set_fs(old_fs);
-
-		} else {
-			struct semid_ds s;
-			struct semid_ds32 *usp;
-
-			usp = (struct semid_ds32 *)A(pad);
-
-			err = get_user(s.sem_perm.uid, &usp->sem_perm.uid);
-			err |= __get_user(s.sem_perm.gid,
-					  &usp->sem_perm.gid);
-			err |= __get_user(s.sem_perm.mode,
-					  &usp->sem_perm.mode);
-			if (err)
-				goto out;
-			fourth.__pad = &s;
-
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_semctl(first, second, third, fourth);
-			set_fs(old_fs);
-		}
-		break;
-	default:
-		err = -EINVAL;
-	}
-out:
-	return err;
-}
-
-#define MAXBUF (64*1024)
-
-static int 
-do_sys32_msgsnd(int first, int second, int third, void *uptr)
-{
-	struct msgbuf *p;
-	struct msgbuf32 *up = (struct msgbuf32 *)uptr;
-	mm_segment_t old_fs;
-	int err;
-
-	if (second < 0 || (second >= MAXBUF-sizeof(struct msgbuf)))
-		return -EINVAL;
-
-	p = kmalloc(second + sizeof(struct msgbuf), GFP_USER);
-	if (!p)
-		return -ENOMEM;
-	err = get_user(p->mtype, &up->mtype);
-	err |= copy_from_user(p->mtext, &up->mtext, second);
-	if (err) {
-		err = -EFAULT;
-		goto out;
-	}
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_msgsnd(first, p, second, third);
-	set_fs(old_fs);
-out:
-	kfree(p);
-	return err;
-}
-
-static int
-do_sys32_msgrcv(int first, int second, int msgtyp, int third,
-		int version, void *uptr)
+long sys32_ipc(u32 call, u32 first, u32 second, u32 third, compat_uptr_t ptr,
+	       u32 fifth)
 {
-	struct msgbuf32 *up;
-	struct msgbuf *p;
-	mm_segment_t old_fs;
-	int err;
-
-	if (second < 0 || (second >= MAXBUF-sizeof(struct msgbuf)))
-		return -EINVAL;
-
-	if (!version) {
-		struct ipc_kludge_32 *uipck = (struct ipc_kludge_32 *)uptr;
-		struct ipc_kludge_32 ipck;
-
-		err = -EINVAL;
-		if (!uptr)
-			goto out;
-		err = -EFAULT;
-		if (copy_from_user(&ipck, uipck, sizeof(struct ipc_kludge_32)))
-			goto out;
-		uptr = (void *)A(ipck.msgp);
-		msgtyp = ipck.msgtyp;
-	}
-	err = -ENOMEM;
-	p = kmalloc(second + sizeof (struct msgbuf), GFP_USER);
-	if (!p)
-		goto out;
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_msgrcv(first, p, second, msgtyp, third);
-	set_fs(old_fs);
-	if (err < 0)
-		goto free_then_out;
-	up = (struct msgbuf32 *)uptr;
-	if (put_user(p->mtype, &up->mtype) ||
-	    copy_to_user(&up->mtext, p->mtext, err))
-		err = -EFAULT;
-free_then_out:
-	kfree(p);
-out:
-	return err;
-}
+	int version;
 
-static int
-do_sys32_msgctl(int first, int second, void *uptr)
-{
-	int err = -EINVAL, err2;
-	mm_segment_t old_fs;
-
-	switch (second & (~IPC_64)) {
-
-	case IPC_INFO:
-	case IPC_RMID:
-	case MSG_INFO:
-		err = sys_msgctl(first, second, (struct msqid_ds *)uptr);
-		break;
-
-	case IPC_SET:
-		if (second & IPC_64) {
-			struct msqid64_ds m64;
-			struct msqid64_ds32 *up = (struct msqid64_ds32 *)uptr;
-
-			err2 = copy_from_user(&m64.msg_perm, &up->msg_perm,
-					      sizeof(struct ipc64_perm));
-			err2 |= __get_user(m64.msg_qbytes, &up->msg_qbytes);
-			if (err2) {
-				err = -EFAULT;
-				break;
-			}
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_msgctl(first, second,
-					 (struct msqid_ds *)&m64);
-			set_fs(old_fs);
-		} else {
-			struct msqid_ds m;
-			struct msqid_ds32 *up = (struct msqid_ds32 *)uptr;
-
-			err2 = copy_from_user(&m.msg_perm, &up->msg_perm,
-					      sizeof(struct ipc_perm));
-			err2 |= __get_user(m.msg_qbytes, &up->msg_qbytes);
-			if (err2) {
-				err = -EFAULT;
-				break;
-			}
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_msgctl(first, second, &m);
-			set_fs(old_fs);
-		}
-		break;
-
-	case IPC_STAT:
-	case MSG_STAT:
-		if (second & IPC_64) {
-			struct msqid64_ds m64;
-			struct msqid64_ds32 *up = (struct msqid64_ds32 *)uptr;
-
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_msgctl(first, second,
-					 (struct msqid_ds *)&m64);
-			set_fs(old_fs);
-
-			err2 = copy_to_user(&up->msg_perm, &m64.msg_perm,
-					    sizeof(struct ipc64_perm));
- 			err2 |= __put_user(m64.msg_stime, &up->msg_stime);
-			err2 |= __put_user(m64.msg_rtime, &up->msg_rtime);
-			err2 |= __put_user(m64.msg_ctime, &up->msg_ctime);
-			err2 |= __put_user(m64.msg_cbytes, &up->msg_cbytes);
-			err2 |= __put_user(m64.msg_qnum, &up->msg_qnum);
-			err2 |= __put_user(m64.msg_qbytes, &up->msg_qbytes);
-			err2 |= __put_user(m64.msg_lspid, &up->msg_lspid);
-			err2 |= __put_user(m64.msg_lrpid, &up->msg_lrpid);
-			if (err2)
-				err = -EFAULT;
-		} else {
-			struct msqid64_ds m;
-			struct msqid_ds32 *up = (struct msqid_ds32 *)uptr;
-
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_msgctl(first, second, (struct msqid_ds *)&m);
-			set_fs(old_fs);
-
-			err2 = copy_to_user(&up->msg_perm, &m.msg_perm,
-					    sizeof(struct ipc_perm));
- 			err2 |= __put_user(m.msg_stime, &up->msg_stime);
-			err2 |= __put_user(m.msg_rtime, &up->msg_rtime);
-			err2 |= __put_user(m.msg_ctime, &up->msg_ctime);
-			err2 |= __put_user(m.msg_cbytes, &up->msg_cbytes);
-			err2 |= __put_user(m.msg_qnum, &up->msg_qnum);
-			err2 |= __put_user(m.msg_qbytes, &up->msg_qbytes);
-			err2 |= __put_user(m.msg_lspid, &up->msg_lspid);
-			err2 |= __put_user(m.msg_lrpid, &up->msg_lrpid);
-			if (err2)
-				err = -EFAULT;
-		}
-		break;
-	}
-	return err;
-}
-
-static int
-do_sys32_shmat(int first, int second, int third, int version, void *uptr)
-{
-	unsigned long raddr;
-	u32 *uaddr = (u32 *)A((u32)third);
-	int err = -EINVAL;
-
-	if (version == 1)
-		return err;
-	err = do_shmat(first, uptr, second, &raddr);
-	if (err)
-		return err;
-	err = put_user(raddr, uaddr);
-	return err;
-}
-
-static int
-do_sys32_shmctl(int first, int second, void *uptr)
-{
-	int err = -EINVAL, err2;
-	mm_segment_t old_fs;
-
-	switch (second & (~IPC_64)) {
-
-	case IPC_INFO:
-	case IPC_RMID:
-	case SHM_LOCK:
-	case SHM_UNLOCK:
-		err = sys_shmctl(first, second, (struct shmid_ds *)uptr);
-		break;
-	case IPC_SET:
-		if (second & IPC_64) {
-			struct shmid64_ds32 *up = (struct shmid64_ds32 *)uptr;
-			struct shmid64_ds s64;
-
-			err = get_user(s64.shm_perm.uid, &up->shm_perm.uid);
-			err |= __get_user(s64.shm_perm.gid, &up->shm_perm.gid);
-			err |= __get_user(s64.shm_perm.mode,
-					  &up->shm_perm.mode);
-			if (err)
-				break;
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_shmctl(first, second,
-					 (struct shmid_ds *)&s64);
-			set_fs(old_fs);
-		} else {
-			struct shmid_ds32 *up = (struct shmid_ds32 *)uptr;
-			struct shmid_ds s;
-
-			err = get_user(s.shm_perm.uid, &up->shm_perm.uid);
-			err |= __get_user(s.shm_perm.gid, &up->shm_perm.gid);
-			err |= __get_user(s.shm_perm.mode, &up->shm_perm.mode);
-			if (err)
-				break;
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_shmctl(first, second, &s);
-			set_fs(old_fs);
-		}
-		break;
-
-	case IPC_STAT:
-	case SHM_STAT:
-		if (second & IPC_64) {
-			struct shmid64_ds32 *up = (struct shmid64_ds32 *)uptr;
-			struct shmid64_ds s64;
-
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_shmctl(first, second,
-					 (struct shmid_ds *)&s64);
-			set_fs(old_fs);
-			if (err < 0)
-				break;
-
-			err2 = copy_to_user(&up->shm_perm, &s64.shm_perm,
-					    sizeof(struct ipc64_perm));
-			err2 |= __put_user(s64.shm_atime, &up->shm_atime);
-			err2 |= __put_user(s64.shm_dtime, &up->shm_dtime);
-			err2 |= __put_user(s64.shm_ctime, &up->shm_ctime);
-			err2 |= __put_user(s64.shm_segsz, &up->shm_segsz);
-			err2 |= __put_user(s64.shm_nattch, &up->shm_nattch);
-			err2 |= __put_user(s64.shm_cpid, &up->shm_cpid);
-			err2 |= __put_user(s64.shm_lpid, &up->shm_lpid);
-			if (err2)
-				err = -EFAULT;
-		} else {
-			struct shmid_ds32 *up = (struct shmid_ds32 *)uptr;
-			struct shmid_ds s;
-
-			old_fs = get_fs();
-			set_fs(KERNEL_DS);
-			err = sys_shmctl(first, second, &s);
-			set_fs(old_fs);
-			if (err < 0)
-				break;
-
-			err2 = copy_to_user(&up->shm_perm, &s.shm_perm,
-					    sizeof(struct ipc_perm));
-			err2 |= __put_user (s.shm_atime, &up->shm_atime);
-			err2 |= __put_user (s.shm_dtime, &up->shm_dtime);
-			err2 |= __put_user (s.shm_ctime, &up->shm_ctime);
-			err2 |= __put_user (s.shm_segsz, &up->shm_segsz);
-			err2 |= __put_user (s.shm_nattch, &up->shm_nattch);
-			err2 |= __put_user (s.shm_cpid, &up->shm_cpid);
-			err2 |= __put_user (s.shm_lpid, &up->shm_lpid);
-			if (err2)
-				err = -EFAULT;
-		}
-		break;
-
-	case SHM_INFO: {
-		struct shm_info si;
-		struct shm_info32 {
-			int used_ids;
-			u32 shm_tot, shm_rss, shm_swp;
-			u32 swap_attempts, swap_successes;
-		} *uip = (struct shm_info32 *)uptr;
-
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, (struct shmid_ds *)&si);
-		set_fs(old_fs);
-		if (err < 0)
-			break;
-		err2 = put_user(si.used_ids, &uip->used_ids);
-		err2 |= __put_user(si.shm_tot, &uip->shm_tot);
-		err2 |= __put_user(si.shm_rss, &uip->shm_rss);
-		err2 |= __put_user(si.shm_swp, &uip->shm_swp);
-		err2 |= __put_user(si.swap_attempts, &uip->swap_attempts);
-		err2 |= __put_user(si.swap_successes, &uip->swap_successes);
-		if (err2)
-			err = -EFAULT;
-		break;
-	}
-	}
-	return err;
-}
-
-static int sys32_semtimedop(int semid, struct sembuf *tsems, int nsems,
-			    const struct compat_timespec *timeout32)
-{
-	struct compat_timespec t32;
-	struct timespec *t64 = compat_alloc_user_space(sizeof(*t64));
-
-	if (copy_from_user(&t32, timeout32, sizeof(t32)))
-		return -EFAULT;
-
-	if (put_user(t32.tv_sec, &t64->tv_sec) ||
-	    put_user(t32.tv_nsec, &t64->tv_nsec))
-		return -EFAULT;
-
-	return sys_semtimedop(semid, tsems, nsems, t64);
-}
-
-/*
- * Note: it is necessary to treat first_parm, second_parm, and
- * third_parm as unsigned ints, with the corresponding cast to a
- * signed int to insure that the proper conversion (sign extension)
- * between the register representation of a signed int (msr in 32-bit
- * mode) and the register representation of a signed int (msr in
- * 64-bit mode) is performed.
- */
-asmlinkage long sys32_ipc(u32 call, u32 first_parm, u32 second_parm, u32 third_parm, u32 ptr, u32 fifth)
-{
-	int first  = (int)first_parm;
-	int second = (int)second_parm;
-	int third  = (int)third_parm;
-	int version, err;
-	
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
 	switch (call) {
 
+	case SEMTIMEDOP:
+		if (third)
+			/* sign extend semid */
+			return compat_sys_semtimedop((int)first,
+						     compat_ptr(ptr), second,
+						     compat_ptr(third));
+		/* else fall through for normal semop() */
 	case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
-		err = sys_semtimedop(first, (struct sembuf *)AA(ptr),
-				     second, NULL);
-		break;
-	case SEMTIMEDOP:
-		err = sys32_semtimedop(first, (struct sembuf *)AA(ptr), second,
-				       (const struct compat_timespec *)AA(fifth));
-		break;
+		/* sign extend semid */
+		return sys_semtimedop((int)first, compat_ptr(ptr), second,
+				      NULL);
 	case SEMGET:
-		err = sys_semget(first, second, third);
-		break;
+		/* sign extend key, nsems */
+		return sys_semget((int)first, (int)second, third);
 	case SEMCTL:
-		err = do_sys32_semctl(first, second, third,
-				      (void *)AA(ptr));
-		break;
+		/* sign extend semid, semnum */
+		return compat_sys_semctl((int)first, (int)second, third,
+					 compat_ptr(ptr));
 
 	case MSGSND:
-		err = do_sys32_msgsnd(first, second, third,
-				      (void *)AA(ptr));
-		break;
+		/* sign extend msqid */
+		return compat_sys_msgsnd((int)first, (int)second, third,
+					 compat_ptr(ptr));
 	case MSGRCV:
-		err = do_sys32_msgrcv(first, second, fifth, third,
-				      version, (void *)AA(ptr));
-		break;
+		/* sign extend msqid, msgtyp */
+		return compat_sys_msgrcv((int)first, second, (int)fifth,
+					 third, version, compat_ptr(ptr));
 	case MSGGET:
-		err = sys_msgget((key_t)first, second);
-		break;
+		/* sign extend key */	
+		return sys_msgget((int)first, second);
 	case MSGCTL:
-		err = do_sys32_msgctl(first, second, (void *)AA(ptr));
-		break;
+		/* sign extend msqid */
+		return compat_sys_msgctl((int)first, second, compat_ptr(ptr));
 
 	case SHMAT:
-		err = do_sys32_shmat(first, second, third,
-				     version, (void *)AA(ptr));
-		break;
-	case SHMDT: 
-		err = sys_shmdt((char *)AA(ptr));
-		break;
+		/* sign extend shmid */
+		return compat_sys_shmat((int)first, second, third, version,
+					compat_ptr(ptr));
+	case SHMDT:
+		return sys_shmdt(compat_ptr(ptr));
 	case SHMGET:
-		err = sys_shmget(first, second_parm, third);
-		break;
+		/* sign extend key_t */
+		return sys_shmget((int)first, second, third);
 	case SHMCTL:
-		err = do_sys32_shmctl(first, second, (void *)AA(ptr));
-		break;
+		/* sign extend shmid */
+		return compat_sys_shmctl((int)first, second, compat_ptr(ptr));
+
 	default:
-		err = -ENOSYS;
-		break;
+		return -ENOSYS;
 	}
-	return err;
+
+	return -ENOSYS;
 }
 
 /* Note: it is necessary to treat out_fd and in_fd as unsigned ints, 
Index: working-2.6/arch/ppc64/Kconfig
===================================================================
--- working-2.6.orig/arch/ppc64/Kconfig	2004-04-13 11:42:35.000000000 +1000
+++ working-2.6/arch/ppc64/Kconfig	2004-04-30 16:28:44.825901168 +1000
@@ -49,6 +49,10 @@
 
 source "init/Kconfig"
 
+config SYSVIPC_COMPAT
+	bool
+	depends on COMPAT && SYSVIPC
+	default y
 
 menu "Platform support"
 
Index: working-2.6/include/asm-ppc64/compat.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/compat.h	2004-01-22 17:41:03.000000000 +1100
+++ working-2.6/include/asm-ppc64/compat.h	2004-04-30 16:28:44.823901472 +1000
@@ -25,6 +25,7 @@
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef s32		compat_key_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
@@ -136,4 +137,66 @@
 	return (void *) (usp - len);
 }
 
+/*
+ * ipc64_perm is actually 32/64bit clean but since the compat layer refers to
+ * it we may as well define it.
+ */
+struct compat_ipc64_perm {
+	compat_key_t key;
+	compat_uid_t uid;
+	compat_gid_t gid;
+	compat_uid_t cuid;
+	compat_gid_t cgid;
+	compat_mode_t mode;
+	unsigned int seq;
+	unsigned int __pad2;
+	unsigned long __unused1;	/* yes they really are 64bit pads */
+	unsigned long __unused2;
+};
+
+struct compat_semid64_ds {
+	struct compat_ipc64_perm sem_perm;
+	unsigned int __unused1;
+	compat_time_t sem_otime;
+	unsigned int __unused2;
+	compat_time_t sem_ctime;
+	compat_ulong_t sem_nsems;
+	compat_ulong_t __unused3;
+	compat_ulong_t __unused4;
+};
+
+struct compat_msqid64_ds {
+	struct compat_ipc64_perm msg_perm;
+	unsigned int __unused1;
+	compat_time_t msg_stime;
+	unsigned int __unused2;
+	compat_time_t msg_rtime;
+	unsigned int __unused3;
+	compat_time_t msg_ctime;
+	compat_ulong_t msg_cbytes;
+	compat_ulong_t msg_qnum;
+	compat_ulong_t msg_qbytes;
+	compat_pid_t msg_lspid;
+	compat_pid_t msg_lrpid;
+	compat_ulong_t __unused4;
+	compat_ulong_t __unused5;
+};
+
+struct compat_shmid64_ds {
+	struct compat_ipc64_perm shm_perm;
+	unsigned int __unused1;
+	compat_time_t shm_atime;
+	unsigned int __unused2;
+	compat_time_t shm_dtime;
+	unsigned int __unused3;
+	compat_time_t shm_ctime;
+	unsigned int __unused4;
+	compat_size_t shm_segsz;
+	compat_pid_t shm_cpid;
+	compat_pid_t shm_lpid;
+	compat_ulong_t shm_nattch;
+	compat_ulong_t __unused5;
+	compat_ulong_t __unused6;
+};
+
 #endif /* _ASM_PPC64_COMPAT_H */
Index: working-2.6/include/asm-ppc64/ppc32.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/ppc32.h	2004-04-13 11:42:41.000000000 +1000
+++ working-2.6/include/asm-ppc64/ppc32.h	2004-04-30 16:28:44.824901320 +1000
@@ -141,9 +141,4 @@
 	struct mcontext32	uc_mcontext;
 };
 
-struct ipc_kludge_32 {
-	unsigned int msgp;
-	int msgtyp;
-};
-
 #endif  /* _PPC64_PPC32_H */


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
