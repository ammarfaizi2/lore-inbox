Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270273AbSKECA7>; Mon, 4 Nov 2002 21:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270590AbSKECA6>; Mon, 4 Nov 2002 21:00:58 -0500
Received: from nameservices.net ([208.234.25.16]:47784 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S270273AbSKEB5X>;
	Mon, 4 Nov 2002 20:57:23 -0500
Message-ID: <3DC727EF.1F61453D@opersys.com>
Date: Mon, 04 Nov 2002 21:07:43 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.46 4/10: Core trace statements
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


D: These are the architecture-independent trace points required to
D: reconstruct the system's dynamic post-mortem using the LTT tools.
D: This set is a bare-minimum which could be easily found in any
D: Unix-like OS.

diffstat:
 fs/buffer.c      |    3 +++
 fs/exec.c        |    6 ++++++
 fs/ioctl.c       |    7 +++++++
 fs/open.c        |   10 ++++++++++
 fs/read_write.c  |   35 +++++++++++++++++++++++++++++++++++
 fs/select.c      |   10 ++++++++++
 ipc/msg.c        |    3 +++
 ipc/sem.c        |    2 ++
 ipc/shm.c        |    3 ++-
 kernel/exit.c    |    6 ++++++
 kernel/fork.c    |    3 +++
 kernel/itimer.c  |    5 +++++
 kernel/sched.c   |    8 +++++++-
 kernel/signal.c  |    3 +++
 kernel/softirq.c |   11 ++++++++++-
 kernel/time.c    |    1 +
 kernel/timer.c   |    3 +++
 mm/filemap.c     |    3 +++
 mm/memory.c      |    4 ++++
 mm/page_alloc.c  |    4 ++++
 mm/page_io.c     |    2 ++
 net/core/dev.c   |    6 ++++++
 net/socket.c     |   10 ++++++++++
 23 files changed, 145 insertions(+), 3 deletions(-)

diff -urpN linux-2.5.46/fs/buffer.c linux-2.5.46-ltt/fs/buffer.c
--- linux-2.5.46/fs/buffer.c	Mon Nov  4 17:30:31 2002
+++ linux-2.5.46-ltt/fs/buffer.c	Mon Nov  4 19:01:58 2002
@@ -37,6 +37,7 @@
 #include <linux/buffer_head.h>
 #include <linux/bio.h>
 #include <linux/notifier.h>
+#include <linux/trace.h>
 #include <asm/bitops.h>
 
 static void invalidate_bh_lrus(void);
@@ -134,11 +135,13 @@ void __wait_on_buffer(struct buffer_head
 
 	get_bh(bh);
 	do {
+		TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_BUF_WAIT_START, 0, 0, NULL);
 		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
 		blk_run_queues();
 		if (buffer_locked(bh))
 			schedule();
 	} while (buffer_locked(bh));
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_BUF_WAIT_END, 0, 0, NULL);
 	put_bh(bh);
 	finish_wait(wqh, &wait);
 }
diff -urpN linux-2.5.46/fs/exec.c linux-2.5.46-ltt/fs/exec.c
--- linux-2.5.46/fs/exec.c	Mon Nov  4 17:30:22 2002
+++ linux-2.5.46-ltt/fs/exec.c	Mon Nov  4 19:01:58 2002
@@ -43,6 +43,7 @@
 #include <linux/namei.h>
 #include <linux/proc_fs.h>
 #include <linux/ptrace.h>
+#include <linux/trace.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -1007,6 +1008,11 @@ int do_execve(char * filename, char ** a
 	if (IS_ERR(file))
 		return retval;
 
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_EXEC,
+			  0,
+			  file->f_dentry->d_name.len,
+			  file->f_dentry->d_name.name);
+
 	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
 	memset(bprm.page, 0, MAX_ARG_PAGES*sizeof(bprm.page[0])); 
 
diff -urpN linux-2.5.46/fs/ioctl.c linux-2.5.46-ltt/fs/ioctl.c
--- linux-2.5.46/fs/ioctl.c	Mon Nov  4 17:30:13 2002
+++ linux-2.5.46-ltt/fs/ioctl.c	Mon Nov  4 19:01:58 2002
@@ -10,6 +10,8 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
@@ -65,6 +67,11 @@ asmlinkage long sys_ioctl(unsigned int f
                 goto out;
         }
 
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_IOCTL,
+			  fd,
+			  cmd,
+			  NULL);
+
 	lock_kernel();
 	switch (cmd) {
 		case FIOCLEX:
diff -urpN linux-2.5.46/fs/open.c linux-2.5.46-ltt/fs/open.c
--- linux-2.5.46/fs/open.c	Mon Nov  4 17:30:05 2002
+++ linux-2.5.46-ltt/fs/open.c	Mon Nov  4 19:01:58 2002
@@ -18,6 +18,8 @@
 #include <linux/backing-dev.h>
 #include <linux/security.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
@@ -800,6 +802,10 @@ asmlinkage long sys_open(const char * fi
 			error = PTR_ERR(f);
 			if (IS_ERR(f))
 				goto out_error;
+			TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_OPEN,
+					  fd,
+					  f->f_dentry->d_name.len,
+					  f->f_dentry->d_name.name); 
 			fd_install(fd, f);
 		}
 out:
@@ -866,6 +872,10 @@ asmlinkage long sys_close(unsigned int f
 	filp = files->fd[fd];
 	if (!filp)
 		goto out_unlock;
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_CLOSE,
+			  fd,
+			  0,
+			  NULL);
 	files->fd[fd] = NULL;
 	FD_CLR(fd, files->close_on_exec);
 	__put_unused_fd(files, fd);
diff -urpN linux-2.5.46/fs/read_write.c linux-2.5.46-ltt/fs/read_write.c
--- linux-2.5.46/fs/read_write.c	Mon Nov  4 17:30:35 2002
+++ linux-2.5.46-ltt/fs/read_write.c	Mon Nov  4 19:01:58 2002
@@ -14,6 +14,8 @@
 #include <linux/security.h>
 #include <linux/module.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 
 struct file_operations generic_ro_fops = {
@@ -128,6 +130,10 @@ asmlinkage off_t sys_lseek(unsigned int 
 		if (res != (loff_t)retval)
 			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
 	}
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_SEEK,
+			  fd,
+			  offset,
+			  NULL);
 	fput(file);
 bad:
 	return retval;
@@ -154,6 +160,11 @@ asmlinkage long sys_llseek(unsigned int 
 	offset = llseek(file, ((loff_t) offset_high << 32) | offset_low,
 			origin);
 
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_SEEK,
+			  fd,
+			  offset,
+			  NULL);
+
 	retval = (int)offset;
 	if (offset >= 0) {
 		retval = -EFAULT;
@@ -348,6 +359,10 @@ asmlinkage ssize_t sys_read(unsigned int
 
 	file = fget(fd);
 	if (file) {
+	 	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_READ,
+				  fd,
+				  count,
+				  NULL); 
 		ret = vfs_read(file, buf, count, &file->f_pos);
 		fput(file);
 	}
@@ -362,6 +377,10 @@ asmlinkage ssize_t sys_write(unsigned in
 
 	file = fget(fd);
 	if (file) {
+	        TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_WRITE,
+				  fd, 
+				  count,
+				  NULL);
 		ret = vfs_write(file, buf, count, &file->f_pos);
 		fput(file);
 	}
@@ -380,6 +399,10 @@ asmlinkage ssize_t sys_pread64(unsigned 
 
 	file = fget(fd);
 	if (file) {
+		TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_READ,
+				  fd,
+				  count,
+				  NULL);
 		ret = vfs_read(file, buf, count, &pos);
 		fput(file);
 	}
@@ -398,6 +421,10 @@ asmlinkage ssize_t sys_pwrite64(unsigned
 
 	file = fget(fd);
 	if (file) {
+		TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_WRITE,
+				  fd,
+				  count,
+				  NULL);
 		ret = vfs_write(file, buf, count, &pos);
 		fput(file);
 	}
@@ -557,6 +584,10 @@ sys_readv(unsigned long fd, const struct
 	file = fget(fd);
 	if (!file)
 		goto bad_file;
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_READ,
+			  fd,
+			  nr_segs,
+			  NULL);
 	if (file->f_op && (file->f_mode & FMODE_READ) &&
 	    (file->f_op->readv || file->f_op->read)) {
 		ret = security_ops->file_permission (file, MAY_READ);
@@ -580,6 +611,10 @@ sys_writev(unsigned long fd, const struc
 	file = fget(fd);
 	if (!file)
 		goto bad_file;
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_WRITE,
+			  fd,
+			  nr_segs,
+			  NULL);
 	if (file->f_op && (file->f_mode & FMODE_WRITE) &&
 	    (file->f_op->writev || file->f_op->write)) {
 		ret = security_ops->file_permission (file, MAY_WRITE);
diff -urpN linux-2.5.46/fs/select.c linux-2.5.46-ltt/fs/select.c
--- linux-2.5.46/fs/select.c	Mon Nov  4 17:30:04 2002
+++ linux-2.5.46-ltt/fs/select.c	Mon Nov  4 19:01:58 2002
@@ -21,6 +21,8 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
@@ -202,6 +204,10 @@ int do_select(int n, fd_set_bits *fds, l
 			file = fget(i);
 			mask = POLLNVAL;
 			if (file) {
+				TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_SELECT,
+						  i /*  The fd*/,
+						  __timeout,
+						  NULL);
 				mask = DEFAULT_POLLMASK;
 				if (file->f_op && file->f_op->poll)
 					mask = file->f_op->poll(file, wait);
@@ -376,6 +382,10 @@ static void do_pollfd(unsigned int num, 
 			struct file * file = fget(fd);
 			mask = POLLNVAL;
 			if (file != NULL) {
+			        TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_POLL,
+						  fd,
+						  0,
+						  NULL);
 				mask = DEFAULT_POLLMASK;
 				if (file->f_op && file->f_op->poll)
 					mask = file->f_op->poll(file, *pwait);
diff -urpN linux-2.5.46/ipc/msg.c linux-2.5.46-ltt/ipc/msg.c
--- linux-2.5.46/ipc/msg.c	Mon Nov  4 17:30:03 2002
+++ linux-2.5.46-ltt/ipc/msg.c	Mon Nov  4 19:01:58 2002
@@ -26,6 +26,8 @@
 #include <asm/uaccess.h>
 #include "util.h"
 
+#include <linux/trace.h>
+
 /* sysctl: */
 int msg_ctlmax = MSGMAX;
 int msg_ctlmnb = MSGMNB;
@@ -311,6 +313,7 @@ asmlinkage long sys_msgget (key_t key, i
 		msg_unlock(msq);
 	}
 	up(&msg_ids.sem);
+	TRACE_IPC(TRACE_EV_IPC_MSG_CREATE, ret, msgflg);
 	return ret;
 }
 
diff -urpN linux-2.5.46/ipc/sem.c linux-2.5.46-ltt/ipc/sem.c
--- linux-2.5.46/ipc/sem.c	Mon Nov  4 17:30:22 2002
+++ linux-2.5.46-ltt/ipc/sem.c	Mon Nov  4 19:01:58 2002
@@ -67,6 +67,7 @@
 #include <asm/uaccess.h>
 #include "util.h"
 
+#include <linux/trace.h>
 
 #define sem_lock(id)	((struct sem_array*)ipc_lock(&sem_ids,id))
 #define sem_unlock(sma)	ipc_unlock(&(sma)->sem_perm)
@@ -193,6 +194,7 @@ asmlinkage long sys_semget (key_t key, i
 	}
 
 	up(&sem_ids.sem);
+	TRACE_IPC(TRACE_EV_IPC_SEM_CREATE, err, semflg);
 	return err;
 }
 
diff -urpN linux-2.5.46/ipc/shm.c linux-2.5.46-ltt/ipc/shm.c
--- linux-2.5.46/ipc/shm.c	Mon Nov  4 17:30:29 2002
+++ linux-2.5.46-ltt/ipc/shm.c	Mon Nov  4 19:13:32 2002
@@ -26,6 +26,7 @@
 #include <linux/proc_fs.h>
 #include <linux/shmem_fs.h>
 #include <linux/security.h>
+#include <linux/trace.h>
 #include <asm/uaccess.h>
 
 #include "util.h"
@@ -262,7 +263,7 @@ asmlinkage long sys_shmget (key_t key, s
 		shm_unlock(shp);
 	}
 	up(&shm_ids.sem);
-
+	TRACE_IPC(TRACE_EV_IPC_SHM_CREATE, err, shmflg);
 	return err;
 }
 
diff -urpN linux-2.5.46/kernel/exit.c linux-2.5.46-ltt/kernel/exit.c
--- linux-2.5.46/kernel/exit.c	Mon Nov  4 17:30:49 2002
+++ linux-2.5.46-ltt/kernel/exit.c	Mon Nov  4 19:01:58 2002
@@ -21,6 +21,8 @@
 #include <linux/ptrace.h>
 #include <linux/profile.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
@@ -643,6 +645,8 @@ fake_volatile:
 	acct_process(code);
 	__exit_mm(tsk);
 
+	TRACE_PROCESS_EXIT(0, 0);
+
 	sem_exit();
 	__exit_files(tsk);
 	__exit_fs(tsk);
@@ -790,6 +794,8 @@ asmlinkage long sys_wait4(pid_t pid,unsi
 	if (options & ~(WNOHANG|WUNTRACED|__WNOTHREAD|__WCLONE|__WALL))
 		return -EINVAL;
 
+	TRACE_PROCESS(TRACE_EV_PROCESS_WAIT, pid, 0);
+
 	add_wait_queue(&current->wait_chldexit,&wait);
 repeat:
 	flag = 0;
diff -urpN linux-2.5.46/kernel/fork.c linux-2.5.46-ltt/kernel/fork.c
--- linux-2.5.46/kernel/fork.c	Mon Nov  4 17:30:06 2002
+++ linux-2.5.46-ltt/kernel/fork.c	Mon Nov  4 19:01:58 2002
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/futex.h>
 #include <linux/ptrace.h>
+#include <linux/trace.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -995,6 +996,8 @@ struct task_struct *do_fork(unsigned lon
 		if (p->ptrace & PT_PTRACED)
 			send_sig(SIGSTOP, p, 1);
 
+		TRACE_PROCESS(TRACE_EV_PROCESS_FORK, p->pid, 0);
+
 		wake_up_forked_process(p);		/* do this last */
 		++total_forks;
 
diff -urpN linux-2.5.46/kernel/itimer.c linux-2.5.46-ltt/kernel/itimer.c
--- linux-2.5.46/kernel/itimer.c	Mon Nov  4 17:30:25 2002
+++ linux-2.5.46-ltt/kernel/itimer.c	Mon Nov  4 19:01:58 2002
@@ -10,6 +10,8 @@
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 
 int do_getitimer(int which, struct itimerval *value)
@@ -67,6 +69,8 @@ void it_real_fn(unsigned long __data)
 	struct task_struct * p = (struct task_struct *) __data;
 	unsigned long interval;
 
+	TRACE_TIMER(TRACE_EV_TIMER_EXPIRED, 0, 0, 0);
+
 	send_sig(SIGALRM, p, 1);
 	interval = p->it_real_incr;
 	if (interval) {
@@ -86,6 +90,7 @@ int do_setitimer(int which, struct itime
 	j = timeval_to_jiffies(&value->it_value);
 	if (ovalue && (k = do_getitimer(which, ovalue)) < 0)
 		return k;
+	TRACE_TIMER(TRACE_EV_TIMER_SETITIMER, which, i, j);
 	switch (which) {
 		case ITIMER_REAL:
 			del_timer_sync(&current->real_timer);
diff -urpN linux-2.5.46/kernel/sched.c linux-2.5.46-ltt/kernel/sched.c
--- linux-2.5.46/kernel/sched.c	Mon Nov  4 17:30:47 2002
+++ linux-2.5.46-ltt/kernel/sched.c	Mon Nov  4 19:01:58 2002
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
+#include <linux/trace.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -407,6 +408,8 @@ static int try_to_wake_up(task_t * p, in
 	long old_state;
 	runqueue_t *rq;
 
+	TRACE_PROCESS(TRACE_EV_PROCESS_WAKEUP, p->pid, p->state);
+
 repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
@@ -1034,8 +1037,11 @@ switch_tasks:
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
-	
+
 		prepare_arch_switch(rq, next);
+
+		TRACE_SCHEDCHANGE(prev, next);
+
 		prev = context_switch(prev, next);
 		barrier();
 		rq = this_rq();
diff -urpN linux-2.5.46/kernel/signal.c linux-2.5.46-ltt/kernel/signal.c
--- linux-2.5.46/kernel/signal.c	Mon Nov  4 17:30:24 2002
+++ linux-2.5.46-ltt/kernel/signal.c	Mon Nov  4 19:01:58 2002
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/trace.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/siginfo.h>
@@ -725,6 +726,8 @@ specific_send_sig_info(int sig, struct s
 	if (ignored_signal(sig, t))
 		goto out;
 
+	TRACE_PROCESS(TRACE_EV_PROCESS_SIGNAL, sig, t->pid);
+
 #define LEGACY_QUEUE(sigptr, sig) \
 	(((sig) < SIGRTMIN) && sigismember(&(sigptr)->signal, (sig)))
 
diff -urpN linux-2.5.46/kernel/softirq.c linux-2.5.46-ltt/kernel/softirq.c
--- linux-2.5.46/kernel/softirq.c	Mon Nov  4 17:30:15 2002
+++ linux-2.5.46-ltt/kernel/softirq.c	Mon Nov  4 19:01:58 2002
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/trace.h>
 
 /*
    - No shared variables, all the data are CPU local.
@@ -79,8 +80,10 @@ restart:
 		h = softirq_vec;
 
 		do {
-			if (pending & 1)
+		        if (pending & 1) {
+		                TRACE_SOFT_IRQ(TRACE_EV_SOFT_IRQ_SOFT_IRQ, (h - softirq_vec));
 				h->action(h);
+			}
 			h++;
 			pending >>= 1;
 		} while (pending);
@@ -188,6 +191,9 @@ static void tasklet_action(struct softir
 			if (!atomic_read(&t->count)) {
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
 					BUG();
+
+				TRACE_SOFT_IRQ(TRACE_EV_SOFT_IRQ_TASKLET_ACTION, (unsigned long) (t->func));
+
 				t->func(t->data);
 				tasklet_unlock(t);
 				continue;
@@ -221,6 +227,9 @@ static void tasklet_hi_action(struct sof
 			if (!atomic_read(&t->count)) {
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
 					BUG();
+
+				TRACE_SOFT_IRQ(TRACE_EV_SOFT_IRQ_TASKLET_HI_ACTION, (unsigned long) (t->func));
+
 				t->func(t->data);
 				tasklet_unlock(t);
 				continue;
diff -urpN linux-2.5.46/kernel/time.c linux-2.5.46-ltt/kernel/time.c
--- linux-2.5.46/kernel/time.c	Mon Nov  4 17:30:14 2002
+++ linux-2.5.46-ltt/kernel/time.c	Mon Nov  4 19:01:58 2002
@@ -27,6 +27,7 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
+#include <linux/trace.h>
 
 #include <asm/uaccess.h>
 
diff -urpN linux-2.5.46/kernel/timer.c linux-2.5.46-ltt/kernel/timer.c
--- linux-2.5.46/kernel/timer.c	Mon Nov  4 17:30:16 2002
+++ linux-2.5.46-ltt/kernel/timer.c	Mon Nov  4 19:01:58 2002
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/trace.h>
 
 #include <asm/uaccess.h>
 
@@ -736,6 +737,7 @@ static void run_timer_tasklet(unsigned l
 {
 	tvec_base_t *base = &per_cpu(tvec_bases, smp_processor_id());
 
+	TRACE_EVENT(TRACE_EV_KERNEL_TIMER, NULL);
 	if ((long)(jiffies - base->timer_jiffies) >= 0)
 		__run_timers(base);
 }
@@ -904,6 +906,7 @@ asmlinkage long sys_getegid(void)
 
 static void process_timeout(unsigned long __data)
 {
+	TRACE_TIMER(TRACE_EV_TIMER_EXPIRED, 0, 0, 0);
 	wake_up_process((task_t *)__data);
 }
 
diff -urpN linux-2.5.46/mm/filemap.c linux-2.5.46-ltt/mm/filemap.c
--- linux-2.5.46/mm/filemap.c	Mon Nov  4 17:30:18 2002
+++ linux-2.5.46-ltt/mm/filemap.c	Mon Nov  4 19:01:58 2002
@@ -26,6 +26,7 @@
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
 #include <linux/security.h>
+#include <linux/trace.h>
 /*
  * This is needed for the following functions:
  *  - try_to_release_page
@@ -271,11 +272,13 @@ void wait_on_page_bit(struct page *page,
 	DEFINE_WAIT(wait);
 
 	do {
+		TRACE_MEMORY(TRACE_EV_MEMORY_PAGE_WAIT_START, 0);
 		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
 		sync_page(page);
 		if (test_bit(bit_nr, &page->flags))
 			io_schedule();
 	} while (test_bit(bit_nr, &page->flags));
+	TRACE_MEMORY(TRACE_EV_MEMORY_PAGE_WAIT_END, 0);
 	finish_wait(waitqueue, &wait);
 }
 EXPORT_SYMBOL(wait_on_page_bit);
diff -urpN linux-2.5.46/mm/memory.c linux-2.5.46-ltt/mm/memory.c
--- linux-2.5.46/mm/memory.c	Mon Nov  4 17:30:26 2002
+++ linux-2.5.46-ltt/mm/memory.c	Mon Nov  4 19:01:58 2002
@@ -45,6 +45,9 @@
 #include <linux/pagemap.h>
 #include <linux/vcache.h>
 
+#include <linux/module.h>
+#include <linux/trace.h>
+
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
 #include <asm/uaccess.h>
@@ -993,6 +996,7 @@ static int do_swap_page(struct mm_struct
 	spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
+	        TRACE_MEMORY(TRACE_EV_MEMORY_SWAP_IN, address);
 		swapin_readahead(entry);
 		page = read_swap_cache_async(entry);
 		if (!page) {
diff -urpN linux-2.5.46/mm/page_alloc.c linux-2.5.46-ltt/mm/page_alloc.c
--- linux-2.5.46/mm/page_alloc.c	Mon Nov  4 17:30:06 2002
+++ linux-2.5.46-ltt/mm/page_alloc.c	Mon Nov  4 19:01:58 2002
@@ -28,6 +28,7 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/notifier.h>
+#include <linux/trace.h>
 
 #include <asm/topology.h>
 
@@ -186,6 +187,8 @@ void __free_pages_ok(struct page *page, 
 {
 	LIST_HEAD(list);
 
+	TRACE_MEMORY(TRACE_EV_MEMORY_PAGE_FREE, order);
+
 	free_pages_check(__FUNCTION__, page);
 	list_add(&page->list, &list);
 	free_pages_bulk(page_zone(page), 1, &list, order);
@@ -541,6 +544,7 @@ unsigned long __get_free_pages(unsigned 
 	page = alloc_pages(gfp_mask, order);
 	if (!page)
 		return 0;
+	TRACE_MEMORY(TRACE_EV_MEMORY_PAGE_ALLOC, order);
 	return (unsigned long) page_address(page);
 }
 
diff -urpN linux-2.5.46/mm/page_io.c linux-2.5.46-ltt/mm/page_io.c
--- linux-2.5.46/mm/page_io.c	Mon Nov  4 17:30:07 2002
+++ linux-2.5.46-ltt/mm/page_io.c	Mon Nov  4 19:01:58 2002
@@ -18,6 +18,7 @@
 #include <linux/swapops.h>
 #include <linux/buffer_head.h>	/* for block_sync_page() */
 #include <linux/mpage.h>
+#include <linux/trace.h>
 #include <asm/pgtable.h>
 
 static struct bio *
@@ -103,6 +104,7 @@ int swap_writepage(struct page *page)
 	inc_page_state(pswpout);
 	SetPageWriteback(page);
 	unlock_page(page);
+	TRACE_MEMORY(TRACE_EV_MEMORY_SWAP_OUT, (unsigned long) page);
 	submit_bio(WRITE, bio);
 out:
 	return ret;
diff -urpN linux-2.5.46/net/core/dev.c linux-2.5.46-ltt/net/core/dev.c
--- linux-2.5.46/net/core/dev.c	Mon Nov  4 17:30:29 2002
+++ linux-2.5.46-ltt/net/core/dev.c	Mon Nov  4 19:01:58 2002
@@ -105,10 +105,12 @@
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/trace.h>
 #if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
 #endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
+
 #ifdef CONFIG_PLIP
 extern int plip_init(void);
 #endif
@@ -1009,6 +1011,8 @@ int dev_queue_xmit(struct sk_buff *skb)
 			goto out;
 	}
 
+	TRACE_NETWORK(TRACE_EV_NETWORK_PACKET_OUT, skb->protocol);
+
 	/* Grab device queue */
 	spin_lock_bh(&dev->queue_lock);
 	q = dev->qdisc;
@@ -1419,6 +1423,8 @@ int netif_receive_skb(struct sk_buff *sk
 
 	netdev_rx_stat[smp_processor_id()].total++;
 
+	TRACE_NETWORK(TRACE_EV_NETWORK_PACKET_IN, skb->protocol);
+
 #ifdef CONFIG_NET_FASTROUTE
 	if (skb->pkt_type == PACKET_FASTROUTE) {
 		netdev_rx_stat[smp_processor_id()].fastroute_deferred_out++;
diff -urpN linux-2.5.46/net/socket.c linux-2.5.46-ltt/net/socket.c
--- linux-2.5.46/net/socket.c	Mon Nov  4 17:30:20 2002
+++ linux-2.5.46-ltt/net/socket.c	Mon Nov  4 19:01:58 2002
@@ -77,6 +77,8 @@
 #include <linux/wireless.h>
 #include <linux/divert.h>
 
+#include <linux/trace.h>
+
 #if defined(CONFIG_KMOD) && defined(CONFIG_NET)
 #include <linux/kmod.h>
 #endif
@@ -538,6 +540,8 @@ int sock_sendmsg(struct socket *sock, st
 	struct kiocb iocb;
 	int ret;
 
+	TRACE_SOCKET(TRACE_EV_SOCKET_SEND, sock->type, size);
+
 	init_sync_kiocb(&iocb, NULL);
 	ret = __sock_sendmsg(&iocb, sock, msg, size);
 	if (-EIOCBQUEUED == ret)
@@ -571,6 +575,8 @@ int sock_recvmsg(struct socket *sock, st
 	struct kiocb iocb;
 	int ret;
 
+	TRACE_SOCKET(TRACE_EV_SOCKET_RECEIVE, sock->type, size);
+
         init_sync_kiocb(&iocb, NULL);
 	ret = __sock_recvmsg(&iocb, sock, msg, size, flags);
 	if (-EIOCBQUEUED == ret)
@@ -1047,6 +1053,8 @@ asmlinkage long sys_socket(int family, i
 	if (retval < 0)
 		goto out_release;
 
+	TRACE_SOCKET(TRACE_EV_SOCKET_CREATE, retval, type);
+
 out:
 	/* It may be already another descriptor 8) Not kernel problem. */
 	return retval;
@@ -1666,6 +1674,8 @@ asmlinkage long sys_socketcall(int call,
 		
 	a0=a[0];
 	a1=a[1];
+
+	TRACE_SOCKET(TRACE_EV_SOCKET_CALL, call, a0);
 	
 	switch(call) 
 	{
