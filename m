Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSIJSJf>; Tue, 10 Sep 2002 14:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSIJSJe>; Tue, 10 Sep 2002 14:09:34 -0400
Received: from nameservices.net ([208.234.25.16]:2752 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S317767AbSIJSIh>;
	Tue, 10 Sep 2002 14:08:37 -0400
Message-ID: <3D7E3700.D621E131@opersys.com>
Date: Tue, 10 Sep 2002 14:16:32 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] 3/8 LTT for 2.5.34: Core trace statements
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These are the core trace statements inserted by LTT. The files modified:
fs/buffer.c
fs/exec.c
fs/ioctl.c
fs/open.c
fs/read_write.c
fs/select.c
ipc/msg.c
ipc/sem.c
ipc/shm.c
kernel/exit.c
kernel/fork.c
kernel/itimer.c
kernel/sched.c
kernel/signal.c
kernel/softirq.c
kernel/timer.c
mm/filemap.c
mm/memory.c
mm/page_alloc.c
mm/page_io.c
net/core/dev.c
net/socket.c

diff -urN linux-2.5.34/fs/buffer.c linux-2.5.34-ltt/fs/buffer.c
--- linux-2.5.34/fs/buffer.c	Mon Sep  9 13:35:12 2002
+++ linux-2.5.34-ltt/fs/buffer.c	Mon Sep  9 19:06:34 2002
@@ -34,6 +34,7 @@
 #include <linux/hash.h>
 #include <linux/suspend.h>
 #include <linux/buffer_head.h>
+#include <linux/trace.h>
 #include <asm/bitops.h>
 
 static void invalidate_bh_lrus(void);
@@ -135,6 +136,7 @@
 	get_bh(bh);
 	add_wait_queue(wq, &wait);
 	do {
+		TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_BUF_WAIT_START, 0, 0, NULL);
 		blk_run_queues();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!buffer_locked(bh))
@@ -142,6 +144,7 @@
 		schedule();
 	} while (buffer_locked(bh));
 	tsk->state = TASK_RUNNING;
+ 	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_BUF_WAIT_END, 0, 0, NULL);
 	remove_wait_queue(wq, &wait);
 	put_bh(bh);
 }
diff -urN linux-2.5.34/fs/exec.c linux-2.5.34-ltt/fs/exec.c
--- linux-2.5.34/fs/exec.c	Mon Sep  9 13:35:08 2002
+++ linux-2.5.34-ltt/fs/exec.c	Mon Sep  9 19:06:34 2002
@@ -41,6 +41,8 @@
 #include <linux/module.h>
 #include <linux/namei.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
@@ -886,6 +888,11 @@
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
 		return retval;
+
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_EXEC,
+			  0,
+			  file->f_dentry->d_name.len,
+			  file->f_dentry->d_name.name);
 
 	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
 	memset(bprm.page, 0, MAX_ARG_PAGES*sizeof(bprm.page[0])); 
diff -urN linux-2.5.34/fs/ioctl.c linux-2.5.34-ltt/fs/ioctl.c
--- linux-2.5.34/fs/ioctl.c	Mon Sep  9 13:35:05 2002
+++ linux-2.5.34-ltt/fs/ioctl.c	Mon Sep  9 19:06:34 2002
@@ -10,6 +10,8 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
@@ -64,6 +66,11 @@
                 fput(filp);
                 goto out;
         }
+
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_IOCTL,
+			  fd,
+			  cmd,
+			  NULL);
 
 	lock_kernel();
 	switch (cmd) {
diff -urN linux-2.5.34/fs/open.c linux-2.5.34-ltt/fs/open.c
--- linux-2.5.34/fs/open.c	Mon Sep  9 13:35:01 2002
+++ linux-2.5.34-ltt/fs/open.c	Mon Sep  9 19:06:34 2002
@@ -19,6 +19,8 @@
 #include <linux/backing-dev.h>
 #include <linux/security.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
@@ -801,6 +803,10 @@
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
@@ -867,6 +873,10 @@
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
diff -urN linux-2.5.34/fs/read_write.c linux-2.5.34-ltt/fs/read_write.c
--- linux-2.5.34/fs/read_write.c	Mon Sep  9 13:35:13 2002
+++ linux-2.5.34-ltt/fs/read_write.c	Mon Sep  9 19:06:34 2002
@@ -13,6 +13,8 @@
 #include <linux/dnotify.h>
 #include <linux/security.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 
 struct file_operations generic_ro_fops = {
@@ -133,6 +135,10 @@
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
@@ -163,6 +169,11 @@
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
@@ -229,6 +240,10 @@
 
 	file = fget(fd);
 	if (file) {
+	 	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_READ,
+				  fd,
+				  count,
+				  NULL); 
 		ret = vfs_read(file, buf, count, &file->f_pos);
 		fput(file);
 	}
@@ -243,6 +258,10 @@
 
 	file = fget(fd);
 	if (file) {
+	        TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_WRITE,
+				  fd, 
+				  count,
+				  NULL);
 		ret = vfs_write(file, buf, count, &file->f_pos);
 		fput(file);
 	}
@@ -261,6 +280,10 @@
 
 	file = fget(fd);
 	if (file) {
+		TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_READ,
+				  fd,
+				  count,
+				  NULL);
 		ret = vfs_read(file, buf, count, &pos);
 		fput(file);
 	}
@@ -279,6 +302,10 @@
 
 	file = fget(fd);
 	if (file) {
+		TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_WRITE,
+				  fd,
+				  count,
+				  NULL);
 		ret = vfs_write(file, buf, count, &pos);
 		fput(file);
 	}
@@ -405,6 +432,10 @@
 	file = fget(fd);
 	if (!file)
 		goto bad_file;
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_READ,
+			  fd,
+			  count,
+			  NULL);
 	if (file->f_op && (file->f_mode & FMODE_READ) &&
 	    (file->f_op->readv || file->f_op->read)) {
 		ret = security_ops->file_permission (file, MAY_READ);
@@ -428,6 +459,10 @@
 	file = fget(fd);
 	if (!file)
 		goto bad_file;
+	TRACE_FILE_SYSTEM(TRACE_EV_FILE_SYSTEM_WRITE,
+			  fd,
+			  count,
+			  NULL);
 	if (file->f_op && (file->f_mode & FMODE_WRITE) &&
 	    (file->f_op->writev || file->f_op->write)) {
 		ret = security_ops->file_permission (file, MAY_WRITE);
diff -urN linux-2.5.34/fs/select.c linux-2.5.34-ltt/fs/select.c
--- linux-2.5.34/fs/select.c	Mon Sep  9 13:35:01 2002
+++ linux-2.5.34-ltt/fs/select.c	Mon Sep  9 19:06:35 2002
@@ -21,6 +21,8 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
@@ -194,6 +196,10 @@
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
@@ -368,6 +374,10 @@
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
diff -urN linux-2.5.34/ipc/msg.c linux-2.5.34-ltt/ipc/msg.c
--- linux-2.5.34/ipc/msg.c	Mon Sep  9 13:34:59 2002
+++ linux-2.5.34-ltt/ipc/msg.c	Mon Sep  9 19:06:35 2002
@@ -25,6 +25,8 @@
 #include <asm/uaccess.h>
 #include "util.h"
 
+#include <linux/trace.h>
+
 /* sysctl: */
 int msg_ctlmax = MSGMAX;
 int msg_ctlmnb = MSGMNB;
@@ -300,6 +302,7 @@
 		msg_unlock(id);
 	}
 	up(&msg_ids.sem);
+	TRACE_IPC(TRACE_EV_IPC_MSG_CREATE, ret, msgflg);
 	return ret;
 }
 
diff -urN linux-2.5.34/ipc/sem.c linux-2.5.34-ltt/ipc/sem.c
--- linux-2.5.34/ipc/sem.c	Mon Sep  9 13:35:08 2002
+++ linux-2.5.34-ltt/ipc/sem.c	Mon Sep  9 19:06:35 2002
@@ -66,6 +66,7 @@
 #include <asm/uaccess.h>
 #include "util.h"
 
+#include <linux/trace.h>
 
 #define sem_lock(id)	((struct sem_array*)ipc_lock(&sem_ids,id))
 #define sem_unlock(id)	ipc_unlock(&sem_ids,id)
@@ -183,6 +184,7 @@
 	}
 
 	up(&sem_ids.sem);
+	TRACE_IPC(TRACE_EV_IPC_SEM_CREATE, err, semflg);
 	return err;
 }
 
diff -urN linux-2.5.34/ipc/shm.c linux-2.5.34-ltt/ipc/shm.c
--- linux-2.5.34/ipc/shm.c	Mon Sep  9 13:35:12 2002
+++ linux-2.5.34-ltt/ipc/shm.c	Mon Sep  9 19:06:35 2002
@@ -24,6 +24,7 @@
 #include <linux/mman.h>
 #include <linux/proc_fs.h>
 #include <linux/shmem_fs.h>
+#include <linux/trace.h>
 #include <asm/uaccess.h>
 
 #include "util.h"
@@ -245,6 +246,7 @@
 		shm_unlock(id);
 	}
 	up(&shm_ids.sem);
+	TRACE_IPC(TRACE_EV_IPC_SHM_CREATE, err, shmflg);
 	return err;
 }
 
diff -urN linux-2.5.34/kernel/exit.c linux-2.5.34-ltt/kernel/exit.c
--- linux-2.5.34/kernel/exit.c	Mon Sep  9 13:35:07 2002
+++ linux-2.5.34-ltt/kernel/exit.c	Mon Sep  9 19:06:35 2002
@@ -20,6 +20,8 @@
 #include <linux/binfmts.h>
 #include <linux/ptrace.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
@@ -598,6 +600,8 @@
 	acct_process(code);
 	__exit_mm(tsk);
 
+	TRACE_PROCESS(TRACE_EV_PROCESS_EXIT, 0, 0);
+
 	sem_exit();
 	__exit_files(tsk);
 	__exit_fs(tsk);
@@ -690,6 +694,8 @@
 
 	if (options & ~(WNOHANG|WUNTRACED|__WNOTHREAD|__WCLONE|__WALL))
 		return -EINVAL;
+
+	TRACE_PROCESS(TRACE_EV_PROCESS_WAIT, pid, 0);
 
 	add_wait_queue(&current->wait_chldexit,&wait);
 repeat:
diff -urN linux-2.5.34/kernel/fork.c linux-2.5.34-ltt/kernel/fork.c
--- linux-2.5.34/kernel/fork.c	Mon Sep  9 13:35:02 2002
+++ linux-2.5.34-ltt/kernel/fork.c	Mon Sep  9 19:06:35 2002
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/futex.h>
 #include <linux/ptrace.h>
+#include <linux/trace.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -922,6 +923,8 @@
 
 		if (p->ptrace & PT_PTRACED)
 			send_sig(SIGSTOP, p, 1);
+
+		TRACE_PROCESS(TRACE_EV_PROCESS_FORK, p->pid, 0);
 
 		wake_up_forked_process(p);		/* do this last */
 		++total_forks;
diff -urN linux-2.5.34/kernel/itimer.c linux-2.5.34-ltt/kernel/itimer.c
--- linux-2.5.34/kernel/itimer.c	Mon Sep  9 13:35:09 2002
+++ linux-2.5.34-ltt/kernel/itimer.c	Mon Sep  9 19:06:35 2002
@@ -10,6 +10,8 @@
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 
 int do_getitimer(int which, struct itimerval *value)
@@ -67,6 +69,8 @@
 	struct task_struct * p = (struct task_struct *) __data;
 	unsigned long interval;
 
+	TRACE_TIMER(TRACE_EV_TIMER_EXPIRED, 0, 0, 0);
+
 	send_sig(SIGALRM, p, 1);
 	interval = p->it_real_incr;
 	if (interval) {
@@ -86,6 +90,7 @@
 	j = timeval_to_jiffies(&value->it_value);
 	if (ovalue && (k = do_getitimer(which, ovalue)) < 0)
 		return k;
+	TRACE_TIMER(TRACE_EV_TIMER_SETITIMER, which, i, j);
 	switch (which) {
 		case ITIMER_REAL:
 			del_timer_sync(&current->real_timer);
diff -urN linux-2.5.34/kernel/sched.c linux-2.5.34-ltt/kernel/sched.c
--- linux-2.5.34/kernel/sched.c	Mon Sep  9 13:35:05 2002
+++ linux-2.5.34-ltt/kernel/sched.c	Mon Sep  9 19:06:35 2002
@@ -29,6 +29,7 @@
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/delay.h>
+#include <linux/trace.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -404,6 +405,8 @@
 	long old_state;
 	runqueue_t *rq;
 
+	TRACE_PROCESS(TRACE_EV_PROCESS_WAKEUP, p->pid, p->state);
+
 repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
@@ -1007,8 +1010,11 @@
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
diff -urN linux-2.5.34/kernel/signal.c linux-2.5.34-ltt/kernel/signal.c
--- linux-2.5.34/kernel/signal.c	Mon Sep  9 13:35:09 2002
+++ linux-2.5.34-ltt/kernel/signal.c	Mon Sep  9 19:13:44 2002
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/trace.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/siginfo.h>
@@ -678,6 +679,8 @@
 
 	if (ignored_signal(sig, t))
 		goto out;
+
+	TRACE_PROCESS(TRACE_EV_PROCESS_SIGNAL, sig, t->pid);
 
 #define LEGACY_QUEUE(sigptr, sig) \
 	(((sig) < SIGRTMIN) && sigismember(&(sigptr)->signal, (sig)))
diff -urN linux-2.5.34/kernel/softirq.c linux-2.5.34-ltt/kernel/softirq.c
--- linux-2.5.34/kernel/softirq.c	Mon Sep  9 13:35:05 2002
+++ linux-2.5.34-ltt/kernel/softirq.c	Mon Sep  9 19:06:35 2002
@@ -18,6 +18,7 @@
 #include <linux/tqueue.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
+#include <linux/trace.h>
 
 /*
    - No shared variables, all the data are CPU local.
@@ -85,8 +86,10 @@
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
@@ -194,6 +197,9 @@
 			if (!atomic_read(&t->count)) {
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
 					BUG();
+
+				TRACE_SOFT_IRQ(TRACE_EV_SOFT_IRQ_TASKLET_ACTION, (unsigned long) (t->func));
+
 				t->func(t->data);
 				tasklet_unlock(t);
 				continue;
@@ -227,6 +233,9 @@
 			if (!atomic_read(&t->count)) {
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
 					BUG();
+
+				TRACE_SOFT_IRQ(TRACE_EV_SOFT_IRQ_TASKLET_HI_ACTION, (unsigned long) (t->func));
+
 				t->func(t->data);
 				tasklet_unlock(t);
 				continue;
@@ -290,8 +299,10 @@
 	if (!spin_trylock(&global_bh_lock))
 		goto resched;
 
-	if (bh_base[nr])
+	if (bh_base[nr]){
+	        TRACE_SOFT_IRQ(TRACE_EV_SOFT_IRQ_BOTTOM_HALF, (nr));
 		bh_base[nr]();
+	}
 
 	hardirq_endlock();
 	spin_unlock(&global_bh_lock);
diff -urN linux-2.5.34/kernel/timer.c linux-2.5.34-ltt/kernel/timer.c
--- linux-2.5.34/kernel/timer.c	Mon Sep  9 13:35:06 2002
+++ linux-2.5.34-ltt/kernel/timer.c	Mon Sep  9 19:06:35 2002
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/tqueue.h>
 #include <linux/kernel_stat.h>
+#include <linux/trace.h>
 
 #include <asm/uaccess.h>
 
@@ -659,6 +660,7 @@
 
 void timer_bh(void)
 {
+	TRACE_EVENT(TRACE_EV_KERNEL_TIMER, NULL);
 	update_times();
 	run_timer_list();
 }
@@ -788,6 +790,7 @@
 
 static void process_timeout(unsigned long __data)
 {
+	TRACE_TIMER(TRACE_EV_TIMER_EXPIRED, 0, 0, 0);
 	wake_up_process((task_t *)__data);
 }
 
diff -urN linux-2.5.34/mm/filemap.c linux-2.5.34-ltt/mm/filemap.c
--- linux-2.5.34/mm/filemap.c	Mon Sep  9 13:35:08 2002
+++ linux-2.5.34-ltt/mm/filemap.c	Mon Sep  9 19:06:35 2002
@@ -23,6 +23,7 @@
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/security.h>
+#include <linux/trace.h>
 /*
  * This is needed for the following functions:
  *  - try_to_release_page
@@ -634,10 +635,12 @@
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!test_bit(bit_nr, &page->flags))
 			break;
+		TRACE_MEMORY(TRACE_EV_MEMORY_PAGE_WAIT_START, 0);
 		sync_page(page);
 		schedule();
 	} while (test_bit(bit_nr, &page->flags));
 	__set_task_state(tsk, TASK_RUNNING);
+ 	TRACE_MEMORY(TRACE_EV_MEMORY_PAGE_WAIT_END, 0);
 	remove_wait_queue(waitqueue, &wait);
 }
 EXPORT_SYMBOL(wait_on_page_bit);
diff -urN linux-2.5.34/mm/memory.c linux-2.5.34-ltt/mm/memory.c
--- linux-2.5.34/mm/memory.c	Mon Sep  9 13:35:11 2002
+++ linux-2.5.34-ltt/mm/memory.c	Mon Sep  9 19:06:35 2002
@@ -45,6 +45,9 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 
+#include <linux/module.h>
+#include <linux/trace.h>
+
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
 #include <asm/uaccess.h>
@@ -1157,6 +1160,7 @@
 	spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
+	        TRACE_MEMORY(TRACE_EV_MEMORY_SWAP_IN, address);
 		swapin_readahead(entry);
 		page = read_swap_cache_async(entry);
 		if (!page) {
diff -urN linux-2.5.34/mm/page_alloc.c linux-2.5.34-ltt/mm/page_alloc.c
--- linux-2.5.34/mm/page_alloc.c	Mon Sep  9 13:35:02 2002
+++ linux-2.5.34-ltt/mm/page_alloc.c	Mon Sep  9 19:06:35 2002
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/pagevec.h>
+#include <linux/trace.h>
 
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
@@ -98,6 +99,8 @@
 		ClearPageDirty(page);
 	BUG_ON(page_count(page) != 0);
 
+	TRACE_MEMORY(TRACE_EV_MEMORY_PAGE_FREE, order);
+
 	if (unlikely(current->flags & PF_FREE_PAGES)) {
 		if (!current->nr_local_pages && !in_interrupt()) {
 			list_add(&page->list, &current->local_pages);
@@ -434,6 +437,7 @@
 	page = alloc_pages(gfp_mask, order);
 	if (!page)
 		return 0;
+	TRACE_MEMORY(TRACE_EV_MEMORY_PAGE_ALLOC, order);
 	return (unsigned long) page_address(page);
 }
 
diff -urN linux-2.5.34/mm/page_io.c linux-2.5.34-ltt/mm/page_io.c
--- linux-2.5.34/mm/page_io.c	Mon Sep  9 13:35:03 2002
+++ linux-2.5.34-ltt/mm/page_io.c	Mon Sep  9 19:06:35 2002
@@ -18,6 +18,7 @@
 #include <linux/swapops.h>
 #include <linux/buffer_head.h>	/* for block_sync_page() */
 #include <linux/mpage.h>
+#include <linux/trace.h>
 #include <asm/pgtable.h>
 
 static struct bio *
@@ -95,6 +96,7 @@
 	kstat.pswpout++;
 	SetPageWriteback(page);
 	unlock_page(page);
+	TRACE_MEMORY(TRACE_EV_MEMORY_SWAP_OUT, (unsigned long) page);
 	submit_bio(WRITE, bio);
 out:
 	return ret;
diff -urN linux-2.5.34/net/core/dev.c linux-2.5.34-ltt/net/core/dev.c
--- linux-2.5.34/net/core/dev.c	Mon Sep  9 13:35:12 2002
+++ linux-2.5.34-ltt/net/core/dev.c	Mon Sep  9 19:06:35 2002
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
@@ -1007,6 +1009,8 @@
 			goto out;
 	}
 
+	TRACE_NETWORK(TRACE_EV_NETWORK_PACKET_OUT, skb->protocol);
+
 	/* Grab device queue */
 	spin_lock_bh(&dev->queue_lock);
 	q = dev->qdisc;
@@ -1439,6 +1443,8 @@
 	skb_bond(skb);
 
 	netdev_rx_stat[smp_processor_id()].total++;
+
+	TRACE_NETWORK(TRACE_EV_NETWORK_PACKET_IN, skb->protocol);
 
 #ifdef CONFIG_NET_FASTROUTE
 	if (skb->pkt_type == PACKET_FASTROUTE) {
diff -urN linux-2.5.34/net/socket.c linux-2.5.34-ltt/net/socket.c
--- linux-2.5.34/net/socket.c	Mon Sep  9 13:35:08 2002
+++ linux-2.5.34-ltt/net/socket.c	Mon Sep  9 19:06:35 2002
@@ -75,6 +75,8 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 
+#include <linux/trace.h>
+
 #if defined(CONFIG_KMOD) && defined(CONFIG_NET)
 #include <linux/kmod.h>
 #endif
@@ -518,6 +520,8 @@
 	int err;
 	struct scm_cookie scm;
 
+	TRACE_SOCKET(TRACE_EV_SOCKET_SEND, sock->type, size);
+
 	err = scm_send(sock, msg, &scm);
 	if (err >= 0) {
 		err = sock->ops->sendmsg(sock, msg, size, &scm);
@@ -532,6 +536,8 @@
 
 	memset(&scm, 0, sizeof(scm));
 
+	TRACE_SOCKET(TRACE_EV_SOCKET_RECEIVE, sock->type, size);
+
 	size = sock->ops->recvmsg(sock, msg, size, flags, &scm);
 	if (size >= 0)
 		scm_recv(sock, msg, &scm, flags);
@@ -927,6 +933,8 @@
 	if (retval < 0)
 		goto out_release;
 
+	TRACE_SOCKET(TRACE_EV_SOCKET_CREATE, retval, type);
+
 out:
 	/* It may be already another descriptor 8) Not kernel problem. */
 	return retval;
@@ -1546,6 +1554,8 @@
 		
 	a0=a[0];
 	a1=a[1];
+
+	TRACE_SOCKET(TRACE_EV_SOCKET_CALL, call, a0);
 	
 	switch(call) 
 	{
