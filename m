Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbULOEI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbULOEI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbULOEIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:08:06 -0500
Received: from opersys.com ([64.40.108.71]:55307 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261859AbULOD5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 22:57:42 -0500
Message-ID: <41BFB800.5090805@opersys.com>
Date: Tue, 14 Dec 2004 23:05:20 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH 3/4] LTT basic instrumentation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All instances of "TRACE_XXX" have been substituted with
"ltt_ev_XXX".

Signed-off-by: Karim Yaghmour <karim@opersys.com>

diff -urpN linux-2.6.10-rc3-bk8-relayfs/fs/buffer.c linux-2.6.10-rc3-bk8-relayfs-ltt/fs/buffer.c
--- linux-2.6.10-rc3-bk8-relayfs/fs/buffer.c	2004-12-14 17:44:11.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/fs/buffer.c	2004-12-14 22:07:03.000000000 -0500
@@ -39,6 +39,7 @@
  #include <linux/notifier.h>
  #include <linux/cpu.h>
  #include <linux/bitops.h>
+#include <linux/ltt-events.h>

  static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
  static void invalidate_bh_lrus(void);
@@ -87,7 +88,9 @@ void fastcall unlock_buffer(struct buffe
   */
  void __wait_on_buffer(struct buffer_head * bh)
  {
+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_BUF_WAIT_START, 0, 0, NULL);
  	wait_on_bit(&bh->b_state, BH_Lock, sync_buffer, TASK_UNINTERRUPTIBLE);
+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_BUF_WAIT_END, 0, 0, NULL);
  }

  static void
diff -urpN linux-2.6.10-rc3-bk8-relayfs/fs/exec.c linux-2.6.10-rc3-bk8-relayfs-ltt/fs/exec.c
--- linux-2.6.10-rc3-bk8-relayfs/fs/exec.c	2004-12-14 17:45:05.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/fs/exec.c	2004-12-14 22:24:03.000000000 -0500
@@ -47,6 +47,7 @@
  #include <linux/security.h>
  #include <linux/syscalls.h>
  #include <linux/rmap.h>
+#include <linux/ltt-events.h>

  #include <asm/uaccess.h>
  #include <asm/mmu_context.h>
@@ -1105,6 +1106,11 @@ int do_execve(char * filename,
  	if (IS_ERR(file))
  		goto out_kfree;

+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_EXEC,
+			   0,
+			   file->f_dentry->d_name.len,
+			   file->f_dentry->d_name.name);
+
  	sched_exec();

  	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
diff -urpN linux-2.6.10-rc3-bk8-relayfs/fs/ioctl.c linux-2.6.10-rc3-bk8-relayfs-ltt/fs/ioctl.c
--- linux-2.6.10-rc3-bk8-relayfs/fs/ioctl.c	2004-12-14 17:44:11.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/fs/ioctl.c	2004-12-14 17:58:04.000000000 -0500
@@ -11,6 +11,7 @@
  #include <linux/file.h>
  #include <linux/fs.h>
  #include <linux/security.h>
+#include <linux/ltt-events.h>
  #include <linux/module.h>

  #include <asm/uaccess.h>
@@ -68,6 +69,11 @@ asmlinkage long sys_ioctl(unsigned int f
                  goto out;
          }

+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_IOCTL,
+			   fd,
+			   cmd,
+			   NULL);
+
  	lock_kernel();
  	switch (cmd) {
  		case FIOCLEX:
diff -urpN linux-2.6.10-rc3-bk8-relayfs/fs/open.c linux-2.6.10-rc3-bk8-relayfs-ltt/fs/open.c
--- linux-2.6.10-rc3-bk8-relayfs/fs/open.c	2004-12-14 17:44:12.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/fs/open.c	2004-12-14 17:58:04.000000000 -0500
@@ -19,6 +19,8 @@
  #include <linux/security.h>
  #include <linux/mount.h>
  #include <linux/vfs.h>
+#include <linux/ltt-events.h>
+
  #include <asm/uaccess.h>
  #include <linux/fs.h>
  #include <linux/pagemap.h>
@@ -956,6 +958,10 @@ asmlinkage long sys_open(const char __us
  			error = PTR_ERR(f);
  			if (IS_ERR(f))
  				goto out_error;
+			ltt_ev_file_system(LTT_EV_FILE_SYSTEM_OPEN,
+					   fd,
+					   f->f_dentry->d_name.len,
+					   f->f_dentry->d_name.name);
  			fd_install(fd, f);
  		}
  out:
@@ -1031,6 +1037,10 @@ asmlinkage long sys_close(unsigned int f
  	filp = files->fd[fd];
  	if (!filp)
  		goto out_unlock;
+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_CLOSE,
+			   fd,
+			   0,
+			   NULL);
  	files->fd[fd] = NULL;
  	FD_CLR(fd, files->close_on_exec);
  	__put_unused_fd(files, fd);
diff -urpN linux-2.6.10-rc3-bk8-relayfs/fs/read_write.c linux-2.6.10-rc3-bk8-relayfs-ltt/fs/read_write.c
--- linux-2.6.10-rc3-bk8-relayfs/fs/read_write.c	2004-12-14 17:44:12.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/fs/read_write.c	2004-12-14 22:08:11.000000000 -0500
@@ -14,6 +14,7 @@
  #include <linux/security.h>
  #include <linux/module.h>
  #include <linux/syscalls.h>
+#include <linux/ltt-events.h>

  #include <asm/uaccess.h>
  #include <asm/unistd.h>
@@ -142,6 +143,12 @@ asmlinkage off_t sys_lseek(unsigned int
  		if (res != (loff_t)retval)
  			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
  	}
+
+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_SEEK,
+			   fd,
+			   offset,
+			   NULL);
+
  	fput_light(file, fput_needed);
  bad:
  	return retval;
@@ -169,6 +176,11 @@ asmlinkage long sys_llseek(unsigned int
  	offset = vfs_llseek(file, ((loff_t) offset_high << 32) | offset_low,
  			origin);

+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_SEEK,
+			   fd,
+			   offset,
+			   NULL);
+
  	retval = (int)offset;
  	if (offset >= 0) {
  		retval = -EFAULT;
@@ -289,6 +301,10 @@ asmlinkage ssize_t sys_read(unsigned int
  	file = fget_light(fd, &fput_needed);
  	if (file) {
  		loff_t pos = file_pos_read(file);
+ 	 	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_READ,
+ 				   fd,
+ 				   count,
+ 				   NULL);
  		ret = vfs_read(file, buf, count, &pos);
  		file_pos_write(file, pos);
  		fput_light(file, fput_needed);
@@ -307,6 +323,10 @@ asmlinkage ssize_t sys_write(unsigned in
  	file = fget_light(fd, &fput_needed);
  	if (file) {
  		loff_t pos = file_pos_read(file);
+ 	        ltt_ev_file_system(LTT_EV_FILE_SYSTEM_WRITE,
+ 				   fd,
+ 				   count,
+ 				   NULL);
  		ret = vfs_write(file, buf, count, &pos);
  		file_pos_write(file, pos);
  		fput_light(file, fput_needed);
@@ -328,8 +348,14 @@ asmlinkage ssize_t sys_pread64(unsigned
  	file = fget_light(fd, &fput_needed);
  	if (file) {
  		ret = -ESPIPE;
-		if (file->f_mode & FMODE_PREAD)
+		if (file->f_mode & FMODE_PREAD) {
+ 	 		ltt_ev_file_system(LTT_EV_FILE_SYSTEM_READ,
+ 					   fd,
+ 					   count,
+ 					   NULL);
  			ret = vfs_read(file, buf, count, &pos);
+		}
+
  		fput_light(file, fput_needed);
  	}

@@ -349,8 +375,13 @@ asmlinkage ssize_t sys_pwrite64(unsigned
  	file = fget_light(fd, &fput_needed);
  	if (file) {
  		ret = -ESPIPE;
-		if (file->f_mode & FMODE_PWRITE)
+		if (file->f_mode & FMODE_PWRITE) {
+ 			ltt_ev_file_system(LTT_EV_FILE_SYSTEM_WRITE,
+ 					   fd,
+ 					   count,
+ 					   NULL);
  			ret = vfs_write(file, buf, count, &pos);
+		}
  		fput_light(file, fput_needed);
  	}

@@ -535,6 +566,10 @@ sys_readv(unsigned long fd, const struct
  	file = fget_light(fd, &fput_needed);
  	if (file) {
  		loff_t pos = file_pos_read(file);
+ 		ltt_ev_file_system(LTT_EV_FILE_SYSTEM_READ,
+ 				   fd,
+ 				   vlen,
+ 				   NULL);
  		ret = vfs_readv(file, vec, vlen, &pos);
  		file_pos_write(file, pos);
  		fput_light(file, fput_needed);
@@ -553,6 +588,10 @@ sys_writev(unsigned long fd, const struc
  	file = fget_light(fd, &fput_needed);
  	if (file) {
  		loff_t pos = file_pos_read(file);
+	 	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_WRITE,
+ 				   fd,
+ 				   vlen,
+ 				   NULL);
  		ret = vfs_writev(file, vec, vlen, &pos);
  		file_pos_write(file, pos);
  		fput_light(file, fput_needed);
diff -urpN linux-2.6.10-rc3-bk8-relayfs/fs/select.c linux-2.6.10-rc3-bk8-relayfs-ltt/fs/select.c
--- linux-2.6.10-rc3-bk8-relayfs/fs/select.c	2004-12-14 17:44:13.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/fs/select.c	2004-12-14 17:58:04.000000000 -0500
@@ -22,6 +22,7 @@
  #include <linux/personality.h> /* for STICKY_TIMEOUTS */
  #include <linux/file.h>
  #include <linux/fs.h>
+#include <linux/ltt-events.h>

  #include <asm/uaccess.h>

@@ -223,6 +224,10 @@ int do_select(int n, fd_set_bits *fds, l
  				file = fget(i);
  				if (file) {
  					f_op = file->f_op;
+					ltt_ev_file_system(LTT_EV_FILE_SYSTEM_SELECT,
+							   i /*  The fd*/,
+							   __timeout,
+							   NULL);
  					mask = DEFAULT_POLLMASK;
  					if (f_op && f_op->poll)
  						mask = (*f_op->poll)(file, retval ? NULL : wait);
@@ -408,6 +413,10 @@ static void do_pollfd(unsigned int num,
  			struct file * file = fget(fd);
  			mask = POLLNVAL;
  			if (file != NULL) {
+			        ltt_ev_file_system(LTT_EV_FILE_SYSTEM_POLL,
+						   fd,
+						   0,
+						   NULL);
  				mask = DEFAULT_POLLMASK;
  				if (file->f_op && file->f_op->poll)
  					mask = file->f_op->poll(file, *pwait);
diff -urpN linux-2.6.10-rc3-bk8-relayfs/ipc/msg.c linux-2.6.10-rc3-bk8-relayfs-ltt/ipc/msg.c
--- linux-2.6.10-rc3-bk8-relayfs/ipc/msg.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/ipc/msg.c	2004-12-14 22:08:37.000000000 -0500
@@ -25,6 +25,7 @@
  #include <linux/security.h>
  #include <linux/sched.h>
  #include <linux/syscalls.h>
+#include <linux/ltt-events.h>
  #include <asm/current.h>
  #include <asm/uaccess.h>
  #include "util.h"
@@ -229,6 +230,7 @@ asmlinkage long sys_msgget (key_t key, i
  		msg_unlock(msq);
  	}
  	up(&msg_ids.sem);
+	ltt_ev_ipc(LTT_EV_IPC_MSG_CREATE, ret, msgflg);
  	return ret;
  }

diff -urpN linux-2.6.10-rc3-bk8-relayfs/ipc/sem.c linux-2.6.10-rc3-bk8-relayfs-ltt/ipc/sem.c
--- linux-2.6.10-rc3-bk8-relayfs/ipc/sem.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/ipc/sem.c	2004-12-14 22:09:01.000000000 -0500
@@ -72,6 +72,7 @@
  #include <linux/smp_lock.h>
  #include <linux/security.h>
  #include <linux/syscalls.h>
+#include <linux/ltt-events.h>
  #include <asm/uaccess.h>
  #include "util.h"

@@ -239,6 +240,7 @@ asmlinkage long sys_semget (key_t key, i
  	}

  	up(&sem_ids.sem);
+	ltt_ev_ipc(LTT_EV_IPC_SEM_CREATE, err, semflg);
  	return err;
  }

diff -urpN linux-2.6.10-rc3-bk8-relayfs/ipc/shm.c linux-2.6.10-rc3-bk8-relayfs-ltt/ipc/shm.c
--- linux-2.6.10-rc3-bk8-relayfs/ipc/shm.c	2004-12-14 17:45:05.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/ipc/shm.c	2004-12-14 22:09:20.000000000 -0500
@@ -27,6 +27,7 @@
  #include <linux/shmem_fs.h>
  #include <linux/security.h>
  #include <linux/syscalls.h>
+#include <linux/ltt-events.h>
  #include <asm/uaccess.h>

  #include "util.h"
@@ -277,7 +278,7 @@ asmlinkage long sys_shmget (key_t key, s
  		shm_unlock(shp);
  	}
  	up(&shm_ids.sem);
-
+	ltt_ev_ipc(LTT_EV_IPC_SHM_CREATE, err, shmflg);
  	return err;
  }

diff -urpN linux-2.6.10-rc3-bk8-relayfs/kernel/exit.c linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/exit.c
--- linux-2.6.10-rc3-bk8-relayfs/kernel/exit.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/exit.c	2004-12-14 17:58:05.000000000 -0500
@@ -24,6 +24,7 @@
  #include <linux/profile.h>
  #include <linux/mount.h>
  #include <linux/proc_fs.h>
+#include <linux/ltt-events.h>
  #include <linux/mempolicy.h>
  #include <linux/syscalls.h>

@@ -812,6 +813,8 @@ fastcall NORET_TYPE void do_exit(long co
  		acct_process(code);
  	__exit_mm(tsk);

+	ltt_ev_process_exit(0, 0);
+
  	exit_sem(tsk);
  	__exit_files(tsk);
  	__exit_fs(tsk);
@@ -1317,6 +1320,8 @@ static long do_wait(pid_t pid, int optio
  	struct task_struct *tsk;
  	int flag, retval;

+	ltt_ev_process(LTT_EV_PROCESS_WAIT, pid, 0);
+
  	add_wait_queue(&current->wait_chldexit,&wait);
  repeat:
  	flag = 0;
diff -urpN linux-2.6.10-rc3-bk8-relayfs/kernel/fork.c linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/fork.c
--- linux-2.6.10-rc3-bk8-relayfs/kernel/fork.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/fork.c	2004-12-14 17:58:05.000000000 -0500
@@ -39,6 +39,7 @@
  #include <linux/audit.h>
  #include <linux/profile.h>
  #include <linux/rmap.h>
+#include <linux/ltt-events.h>

  #include <asm/pgtable.h>
  #include <asm/pgalloc.h>
@@ -1159,6 +1160,8 @@ long do_fork(unsigned long clone_flags,
  			ptrace_notify ((trace << 8) | SIGTRAP);
  		}

+		ltt_ev_process(LTT_EV_PROCESS_FORK, p->pid, 0);
+
  		if (clone_flags & CLONE_VFORK) {
  			wait_for_completion(&vfork);
  			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
diff -urpN linux-2.6.10-rc3-bk8-relayfs/kernel/irq/handle.c linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/irq/handle.c
--- linux-2.6.10-rc3-bk8-relayfs/kernel/irq/handle.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/irq/handle.c	2004-12-14 21:52:50.000000000 -0500
@@ -11,6 +11,7 @@
  #include <linux/random.h>
  #include <linux/interrupt.h>
  #include <linux/kernel_stat.h>
+#include <linux/ltt-events.h>

  #include "internals.h"

@@ -91,6 +92,8 @@ fastcall int handle_IRQ_event(unsigned i
  {
  	int ret, retval = 0, status = 0;

+	ltt_ev_irq_entry(irq, !(user_mode(regs)));
+
  	if (!(action->flags & SA_INTERRUPT))
  		local_irq_enable();

@@ -106,6 +109,8 @@ fastcall int handle_IRQ_event(unsigned i
  		add_interrupt_randomness(irq);
  	local_irq_disable();

+	ltt_ev_irq_exit();
+
  	return retval;
  }

diff -urpN linux-2.6.10-rc3-bk8-relayfs/kernel/itimer.c linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/itimer.c
--- linux-2.6.10-rc3-bk8-relayfs/kernel/itimer.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/itimer.c	2004-12-14 17:58:05.000000000 -0500
@@ -11,6 +11,7 @@
  #include <linux/interrupt.h>
  #include <linux/syscalls.h>
  #include <linux/time.h>
+#include <linux/ltt-events.h>

  #include <asm/uaccess.h>

@@ -69,6 +70,8 @@ void it_real_fn(unsigned long __data)
  	struct task_struct * p = (struct task_struct *) __data;
  	unsigned long interval;

+	ltt_ev_timer(LTT_EV_TIMER_EXPIRED, 0, 0, 0);
+
  	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, p);
  	interval = p->it_real_incr;
  	if (interval) {
@@ -88,6 +91,7 @@ int do_setitimer(int which, struct itime
  	j = timeval_to_jiffies(&value->it_value);
  	if (ovalue && (k = do_getitimer(which, ovalue)) < 0)
  		return k;
+	ltt_ev_timer(LTT_EV_TIMER_SETITIMER, which, i, j);
  	switch (which) {
  		case ITIMER_REAL:
  			del_timer_sync(&current->real_timer);
diff -urpN linux-2.6.10-rc3-bk8-relayfs/kernel/sched.c linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/sched.c
--- linux-2.6.10-rc3-bk8-relayfs/kernel/sched.c	2004-12-14 17:45:05.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/sched.c	2004-12-14 17:58:05.000000000 -0500
@@ -44,6 +44,7 @@
  #include <linux/seq_file.h>
  #include <linux/syscalls.h>
  #include <linux/times.h>
+#include <linux/ltt-events.h>
  #include <asm/tlb.h>

  #include <asm/unistd.h>
@@ -317,6 +318,8 @@ static runqueue_t *task_rq_lock(task_t *
  {
  	struct runqueue *rq;

+	ltt_ev_process(LTT_EV_PROCESS_WAKEUP, p->pid, p->state);
+
  repeat_lock_task:
  	local_irq_save(*flags);
  	rq = task_rq(p);
@@ -2685,6 +2688,7 @@ switch_tasks:
  		++*switch_count;

  		prepare_arch_switch(rq, next);
+		ltt_ev_schedchange(prev, next);
  		prev = context_switch(rq, prev, next);
  		barrier();

diff -urpN linux-2.6.10-rc3-bk8-relayfs/kernel/signal.c linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/signal.c
--- linux-2.6.10-rc3-bk8-relayfs/kernel/signal.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/signal.c	2004-12-14 17:58:05.000000000 -0500
@@ -22,6 +22,7 @@
  #include <linux/security.h>
  #include <linux/syscalls.h>
  #include <linux/ptrace.h>
+#include <linux/ltt-events.h>
  #include <asm/param.h>
  #include <asm/uaccess.h>
  #include <asm/unistd.h>
@@ -833,6 +834,8 @@ specific_send_sig_info(int sig, struct s
  	if (sig_ignored(t, sig))
  		goto out;

+	ltt_ev_process(LTT_EV_PROCESS_SIGNAL, sig, t->pid);
+
  	/* Support queueing exactly one non-rt signal, so that we
  	   can get more detailed information about the cause of
  	   the signal. */
diff -urpN linux-2.6.10-rc3-bk8-relayfs/kernel/softirq.c linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/softirq.c
--- linux-2.6.10-rc3-bk8-relayfs/kernel/softirq.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/softirq.c	2004-12-14 17:58:05.000000000 -0500
@@ -16,6 +16,7 @@
  #include <linux/cpu.h>
  #include <linux/kthread.h>
  #include <linux/rcupdate.h>
+#include <linux/ltt-events.h>

  #include <asm/irq.h>
  /*
@@ -92,6 +93,7 @@ restart:

  	do {
  		if (pending & 1) {
+			ltt_ev_soft_irq(LTT_EV_SOFT_IRQ_SOFT_IRQ, (h - softirq_vec));
  			h->action(h);
  			rcu_bh_qsctr_inc(cpu);
  		}
@@ -246,6 +248,9 @@ static void tasklet_action(struct softir
  			if (!atomic_read(&t->count)) {
  				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
  					BUG();
+
+				ltt_ev_soft_irq(LTT_EV_SOFT_IRQ_TASKLET_ACTION, (unsigned long) (t->func));
+
  				t->func(t->data);
  				tasklet_unlock(t);
  				continue;
@@ -279,6 +284,9 @@ static void tasklet_hi_action(struct sof
  			if (!atomic_read(&t->count)) {
  				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
  					BUG();
+
+				ltt_ev_soft_irq(LTT_EV_SOFT_IRQ_TASKLET_HI_ACTION, (unsigned long) (t->func));
+
  				t->func(t->data);
  				tasklet_unlock(t);
  				continue;
diff -urpN linux-2.6.10-rc3-bk8-relayfs/kernel/time.c linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/time.c
--- linux-2.6.10-rc3-bk8-relayfs/kernel/time.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/time.c	2004-12-14 22:10:47.000000000 -0500
@@ -33,6 +33,7 @@
  #include <linux/smp_lock.h>
  #include <linux/syscalls.h>
  #include <linux/security.h>
+#include <linux/ltt-events.h>

  #include <asm/uaccess.h>
  #include <asm/unistd.h>
diff -urpN linux-2.6.10-rc3-bk8-relayfs/kernel/timer.c linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/timer.c
--- linux-2.6.10-rc3-bk8-relayfs/kernel/timer.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/kernel/timer.c	2004-12-14 22:11:02.000000000 -0500
@@ -32,6 +32,7 @@
  #include <linux/jiffies.h>
  #include <linux/cpu.h>
  #include <linux/syscalls.h>
+#include <linux/ltt-events.h>

  #include <asm/uaccess.h>
  #include <asm/unistd.h>
@@ -923,6 +924,8 @@ static void run_timer_softirq(struct sof
  {
  	tvec_base_t *base = &__get_cpu_var(tvec_bases);

+	ltt_ev(LTT_EV_KERNEL_TIMER, NULL);
+
  	if (time_after_eq(jiffies, base->timer_jiffies))
  		__run_timers(base);
  }
@@ -1081,6 +1084,7 @@ asmlinkage long sys_getegid(void)

  static void process_timeout(unsigned long __data)
  {
+	ltt_ev_timer(LTT_EV_TIMER_EXPIRED, 0, 0, 0);
  	wake_up_process((task_t *)__data);
  }

diff -urpN linux-2.6.10-rc3-bk8-relayfs/mm/filemap.c linux-2.6.10-rc3-bk8-relayfs-ltt/mm/filemap.c
--- linux-2.6.10-rc3-bk8-relayfs/mm/filemap.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/mm/filemap.c	2004-12-14 22:14:10.000000000 -0500
@@ -28,6 +28,7 @@
  #include <linux/blkdev.h>
  #include <linux/security.h>
  #include <linux/syscalls.h>
+#include <linux/ltt-events.h>
  /*
   * This is needed for the following functions:
   *  - try_to_release_page
@@ -402,9 +403,13 @@ void fastcall wait_on_page_bit(struct pa
  {
  	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);

+	ltt_ev_memory(LTT_EV_MEMORY_PAGE_WAIT_START, 0);
+
  	if (test_bit(bit_nr, &page->flags))
  		__wait_on_bit(page_waitqueue(page), &wait, sync_page,
  							TASK_UNINTERRUPTIBLE);
+
+	ltt_ev_memory(LTT_EV_MEMORY_PAGE_WAIT_END, 0);
  }
  EXPORT_SYMBOL(wait_on_page_bit);

diff -urpN linux-2.6.10-rc3-bk8-relayfs/mm/memory.c linux-2.6.10-rc3-bk8-relayfs-ltt/mm/memory.c
--- linux-2.6.10-rc3-bk8-relayfs/mm/memory.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/mm/memory.c	2004-12-14 17:58:05.000000000 -0500
@@ -47,6 +47,9 @@
  #include <linux/module.h>
  #include <linux/init.h>

+#include <linux/module.h>
+#include <linux/ltt-events.h>
+
  #include <asm/pgalloc.h>
  #include <asm/uaccess.h>
  #include <asm/tlb.h>
@@ -1346,6 +1349,7 @@ static int do_swap_page(struct mm_struct
  	spin_unlock(&mm->page_table_lock);
  	page = lookup_swap_cache(entry);
  	if (!page) {
+	        ltt_ev_memory(LTT_EV_MEMORY_SWAP_IN, address);
   		swapin_readahead(entry, address, vma);
   		page = read_swap_cache_async(entry, vma, address);
  		if (!page) {
diff -urpN linux-2.6.10-rc3-bk8-relayfs/mm/page_alloc.c linux-2.6.10-rc3-bk8-relayfs-ltt/mm/page_alloc.c
--- linux-2.6.10-rc3-bk8-relayfs/mm/page_alloc.c	2004-12-14 17:44:15.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/mm/page_alloc.c	2004-12-14 22:14:56.000000000 -0500
@@ -32,6 +32,7 @@
  #include <linux/sysctl.h>
  #include <linux/cpu.h>
  #include <linux/nodemask.h>
+#include <linux/ltt-events.h>

  #include <asm/tlbflush.h>

@@ -278,6 +279,8 @@ void __free_pages_ok(struct page *page,
  	LIST_HEAD(list);
  	int i;

+	ltt_ev_memory(LTT_EV_MEMORY_PAGE_FREE, order);
+
  	arch_free_page(page, order);

  	mod_page_state(pgfree, 1 << order);
@@ -752,6 +755,7 @@ fastcall unsigned long __get_free_pages(
  	page = alloc_pages(gfp_mask, order);
  	if (!page)
  		return 0;
+	ltt_ev_memory(LTT_EV_MEMORY_PAGE_ALLOC, order);
  	return (unsigned long) page_address(page);
  }

diff -urpN linux-2.6.10-rc3-bk8-relayfs/mm/page_io.c linux-2.6.10-rc3-bk8-relayfs-ltt/mm/page_io.c
--- linux-2.6.10-rc3-bk8-relayfs/mm/page_io.c	2004-10-18 17:53:21.000000000 -0400
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/mm/page_io.c	2004-12-14 17:58:05.000000000 -0500
@@ -17,6 +17,7 @@
  #include <linux/bio.h>
  #include <linux/swapops.h>
  #include <linux/writeback.h>
+#include <linux/ltt-events.h>
  #include <asm/pgtable.h>

  static struct bio *get_swap_bio(int gfp_flags, pgoff_t index,
@@ -103,6 +104,7 @@ int swap_writepage(struct page *page, st
  	inc_page_state(pswpout);
  	set_page_writeback(page);
  	unlock_page(page);
+	ltt_ev_memory(LTT_EV_MEMORY_SWAP_OUT, (unsigned long) page);
  	submit_bio(rw, bio);
  out:
  	return ret;
diff -urpN linux-2.6.10-rc3-bk8-relayfs/net/core/dev.c linux-2.6.10-rc3-bk8-relayfs-ltt/net/core/dev.c
--- linux-2.6.10-rc3-bk8-relayfs/net/core/dev.c	2004-12-14 17:44:16.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/net/core/dev.c	2004-12-14 22:17:58.000000000 -0500
@@ -107,6 +107,7 @@
  #include <linux/module.h>
  #include <linux/kallsyms.h>
  #include <linux/netpoll.h>
+#include <linux/ltt-events.h>
  #include <linux/rcupdate.h>
  #ifdef CONFIG_NET_RADIO
  #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
@@ -1252,6 +1253,8 @@ int dev_queue_xmit(struct sk_buff *skb)
  	      	if (skb_checksum_help(skb, 0))
  	      		goto out_kfree_skb;

+	ltt_ev_network(LTT_EV_NETWORK_PACKET_OUT, skb->protocol);
+
  	/* Disable soft irqs for various locks below. Also
  	 * stops preemption for RCU.
  	 */
@@ -1649,6 +1652,8 @@ int netif_receive_skb(struct sk_buff *sk

  	__get_cpu_var(netdev_rx_stat).total++;

+ 	ltt_ev_network(LTT_EV_NETWORK_PACKET_IN, skb->protocol);
+
  	skb->h.raw = skb->nh.raw = skb->data;
  	skb->mac_len = skb->nh.raw - skb->mac.raw;

diff -urpN linux-2.6.10-rc3-bk8-relayfs/net/socket.c linux-2.6.10-rc3-bk8-relayfs-ltt/net/socket.c
--- linux-2.6.10-rc3-bk8-relayfs/net/socket.c	2004-12-14 17:44:16.000000000 -0500
+++ linux-2.6.10-rc3-bk8-relayfs-ltt/net/socket.c	2004-12-14 17:58:05.000000000 -0500
@@ -81,6 +81,7 @@
  #include <linux/syscalls.h>
  #include <linux/compat.h>
  #include <linux/kmod.h>
+#include <linux/ltt-events.h>

  #ifdef CONFIG_NET_RADIO
  #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
@@ -551,6 +552,8 @@ int sock_sendmsg(struct socket *sock, st
  	struct sock_iocb siocb;
  	int ret;

+	ltt_ev_socket(LTT_EV_SOCKET_SEND, sock->type, size);
+
  	init_sync_kiocb(&iocb, NULL);
  	iocb.private = &siocb;
  	ret = __sock_sendmsg(&iocb, sock, msg, size);
@@ -603,6 +606,8 @@ int sock_recvmsg(struct socket *sock, st
  	struct sock_iocb siocb;
  	int ret;

+	ltt_ev_socket(LTT_EV_SOCKET_RECEIVE, sock->type, size);
+
          init_sync_kiocb(&iocb, NULL);
  	iocb.private = &siocb;
  	ret = __sock_recvmsg(&iocb, sock, msg, size, flags);
@@ -1197,6 +1202,8 @@ asmlinkage long sys_socket(int family, i
  	if (retval < 0)
  		goto out_release;

+	ltt_ev_socket(LTT_EV_SOCKET_CREATE, retval, type);
+
  out:
  	/* It may be already another descriptor 8) Not kernel problem. */
  	return retval;
@@ -1916,6 +1923,8 @@ asmlinkage long sys_socketcall(int call,
  		
  	a0=a[0];
  	a1=a[1];
+
+	ltt_ev_socket(LTT_EV_SOCKET_CALL, call, a0);
  	
  	switch(call)
  	{
