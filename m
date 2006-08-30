Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWH3XSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWH3XSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWH3XSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:18:45 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:23439 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751624AbWH3XSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:18:43 -0400
Date: Wed, 30 Aug 2006 19:18:36 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 8/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830231836.GI17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-21507-1156979917-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:17:42 up 7 days, 20:26,  9 users,  load average: 1.06, 0.61, 0.35
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-21507-1156979917-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

8- LTTng architecture independant instrumentation
patch-2.6.17-lttng-0.5.95-instrumentation.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-21507-1156979917-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-instrumentation.diff"

--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -18,6 +18,7 @@
  * async buffer flushing, 1999 Andrea Arcangeli <andrea@suse.de>
  */
 
+#include <linux/ltt/ltt-facility-fs.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/syscalls.h>
@@ -90,7 +91,9 @@ void fastcall unlock_buffer(struct buffe
  */
 void __wait_on_buffer(struct buffer_head * bh)
 {
+	trace_fs_buf_wait_start((void*)bh);
 	wait_on_bit(&bh->b_state, BH_Lock, sync_buffer, TASK_UNINTERRUPTIBLE);
+	trace_fs_buf_wait_end((void*)bh);
 }
 
 static void
diff --git a/fs/compat.c b/fs/compat.c
index b1f6478..1d0831c 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -46,6 +46,7 @@ #include <linux/personality.h>
 #include <linux/rwsem.h>
 #include <linux/acct.h>
 #include <linux/mm.h>
+#include <linux/ltt/ltt-facility-fs.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
@@ -1498,6 +1499,7 @@ int compat_do_execve(char * filename,
 	struct file *file;
 	int retval;
 	int i;
+	lttng_sequence_fs_exec_filename lttng_name;
 
 	retval = -ENOMEM;
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
@@ -1509,6 +1511,10 @@ int compat_do_execve(char * filename,
 	if (IS_ERR(file))
 		goto out_kfree;
 
+	lttng_name.len = file->f_dentry->d_name.len;
+	lttng_name.array = file->f_dentry->d_name.name;
+	trace_fs_exec(&lttng_name);
+
 	sched_exec();
 
 	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
@@ -1555,6 +1561,16 @@ int compat_do_execve(char * filename,
 
 	retval = search_binary_handler(bprm, regs);
 	if (retval >= 0) {
+#ifdef CONFIG_LTT_USERSPACE_GENERIC
+		{
+			int i;
+			for(i=0; i<LTT_FAC_PER_PROCESS; i++) {
+				if(current->ltt_facilities[i] == 0) break;
+				WARN_ON(ltt_facility_unregister(
+						current->ltt_facilities[i]));
+			}
+		}
+#endif //CONFIG_LTT_USERSPACE_GENERIC
 		free_arg_pages(bprm);
 
 		/* execve success */
diff --git a/fs/exec.c b/fs/exec.c
index 3a79d97..b847e30 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -22,6 +22,9 @@
  * formats. 
  */
 
+#include <linux/ltt/ltt-facility-fs.h>
+#include <linux/ltt-core.h>
+#include <linux/ltt-facilities.h>
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/file.h>
@@ -1147,6 +1150,7 @@ int do_execve(char * filename,
 	struct file *file;
 	int retval;
 	int i;
+	lttng_sequence_fs_exec_filename lttng_name;
 
 	retval = -ENOMEM;
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
@@ -1158,6 +1162,10 @@ int do_execve(char * filename,
 	if (IS_ERR(file))
 		goto out_kfree;
 
+	lttng_name.len = file->f_dentry->d_name.len;
+	lttng_name.array = file->f_dentry->d_name.name;
+	trace_fs_exec(&lttng_name);
+
 	sched_exec();
 
 	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
@@ -1205,6 +1213,16 @@ int do_execve(char * filename,
 
 	retval = search_binary_handler(bprm,regs);
 	if (retval >= 0) {
+#ifdef CONFIG_LTT_USERSPACE_GENERIC
+		{
+			int i;
+			for(i=0; i<LTT_FAC_PER_PROCESS; i++) {
+				if(current->ltt_facilities[i] == 0) break;
+				WARN_ON(ltt_facility_unregister(
+						current->ltt_facilities[i]));
+			}
+		}
+#endif //CONFIG_LTT_USERSPACE_GENERIC
 		free_arg_pages(bprm);
 
 		/* execve success */
diff --git a/fs/ioctl.c b/fs/ioctl.c
index f8aeec3..e45c738 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/ltt/ltt-facility-fs.h>
 #include <linux/config.h>
 #include <linux/syscalls.h>
 #include <linux/mm.h>
@@ -61,7 +62,6 @@ static int file_ioctl(struct file *filp,
 				return -EPERM;
 			if ((error = get_user(block, p)) != 0)
 				return error;
-
 			lock_kernel();
 			res = mapping->a_ops->bmap(mapping, block);
 			unlock_kernel();
@@ -167,6 +167,8 @@ asmlinkage long sys_ioctl(unsigned int f
 	if (!filp)
 		goto out;
 
+	trace_fs_ioctl(fd, cmd, arg);
+
 	error = security_file_ioctl(filp, cmd, arg);
 	if (error)
 		goto out_fput;
diff --git a/fs/open.c b/fs/open.c
index 317b7c7..ab5ce50 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/ltt/ltt-facility-fs.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/utime.h>
@@ -1080,6 +1081,8 @@ long do_sys_open(int dfd, const char __u
 	char *tmp = getname(filename);
 	int fd = PTR_ERR(tmp);
 
+	lttng_sequence_fs_open_filename lttng_name;
+
 	if (!IS_ERR(tmp)) {
 		fd = get_unused_fd();
 		if (fd >= 0) {
@@ -1091,6 +1094,9 @@ long do_sys_open(int dfd, const char __u
 				fsnotify_open(f->f_dentry);
 				fd_install(fd, f);
 			}
+			lttng_name.len = strlen(tmp);
+			lttng_name.array = tmp;
+			trace_fs_open(&lttng_name, fd);
 		}
 		putname(tmp);
 	}
@@ -1180,6 +1186,7 @@ asmlinkage long sys_close(unsigned int f
 	filp = fdt->fd[fd];
 	if (!filp)
 		goto out_unlock;
+	trace_fs_close(fd);
 	rcu_assign_pointer(fdt->fd[fd], NULL);
 	FD_CLR(fd, fdt->close_on_exec);
 	__put_unused_fd(files, fd);
diff --git a/fs/read_write.c b/fs/read_write.c
index 5bc0e92..121236f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -4,6 +4,9 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/ltt/ltt-facility-fs.h>
+#include <linux/ltt/ltt-facility-custom-fs_data.h>
+#include <linux/ltt/ltt-facility-fs_data.h>
 #include <linux/slab.h> 
 #include <linux/stat.h>
 #include <linux/fcntl.h>
@@ -143,6 +146,9 @@ asmlinkage off_t sys_lseek(unsigned int 
 		if (res != (loff_t)retval)
 			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
 	}
+
+	trace_fs_seek(fd, offset, origin);
+
 	fput_light(file, fput_needed);
 bad:
 	return retval;
@@ -170,6 +176,8 @@ asmlinkage long sys_llseek(unsigned int 
 	offset = vfs_llseek(file, ((loff_t) offset_high << 32) | offset_low,
 			origin);
 
+	trace_fs_seek(fd, offset, origin);
+
 	retval = (int)offset;
 	if (offset >= 0) {
 		retval = -EFAULT;
@@ -348,7 +356,16 @@ asmlinkage ssize_t sys_read(unsigned int
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
+		trace_fs_read(fd, count);
 		ret = vfs_read(file, buf, count, &pos);
+#ifdef CONFIG_LTT_FACILITY_FS_DATA
+		if(ret > 0) {
+			lttng_sequence_fs_data_read_data lttng_data;
+			lttng_data.len = min(LTT_LOG_RW_SIZE, ret);
+			lttng_data.array = buf;
+			trace_fs_data_read(fd, count, &lttng_data);
+		}
+#endif //CONFIG_LTT_FACILITY_FS_DATA
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
 	}
@@ -366,7 +383,16 @@ asmlinkage ssize_t sys_write(unsigned in
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
+		trace_fs_write(fd, count);
 		ret = vfs_write(file, buf, count, &pos);
+#ifdef CONFIG_LTT_FACILITY_FS_DATA
+		if(ret > 0) {
+			lttng_sequence_fs_data_write_data lttng_data;
+			lttng_data.len = min(LTT_LOG_RW_SIZE, ret);
+			lttng_data.array = buf;
+			trace_fs_data_write(fd, count, &lttng_data);
+		}
+#endif //CONFIG_LTT_FACILITY_FS_DATA
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
 	}
@@ -387,8 +413,11 @@ asmlinkage ssize_t sys_pread64(unsigned 
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		ret = -ESPIPE;
-		if (file->f_mode & FMODE_PREAD)
+		if (file->f_mode & FMODE_PREAD) {
+			trace_fs_read(fd, count);
 			ret = vfs_read(file, buf, count, &pos);
+		}
+
 		fput_light(file, fput_needed);
 	}
 
@@ -408,8 +437,10 @@ asmlinkage ssize_t sys_pwrite64(unsigned
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		ret = -ESPIPE;
-		if (file->f_mode & FMODE_PWRITE)  
+ 		if (file->f_mode & FMODE_PWRITE) {
+			trace_fs_write(fd, count);
 			ret = vfs_write(file, buf, count, &pos);
+		}
 		fput_light(file, fput_needed);
 	}
 
@@ -604,6 +635,7 @@ sys_readv(unsigned long fd, const struct
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
+		trace_fs_read(fd, vlen);
 		ret = vfs_readv(file, vec, vlen, &pos);
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
@@ -625,6 +657,7 @@ sys_writev(unsigned long fd, const struc
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
+		trace_fs_write(fd, vlen);
 		ret = vfs_writev(file, vec, vlen, &pos);
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
diff --git a/fs/relayfs/Makefile b/fs/relayfs/Makefile
new file mode 100644
index 0000000..1794912
--- a/fs/select.c
+++ b/fs/select.c
@@ -14,6 +14,7 @@
  *     of fds to overcome nfds < 16390 descriptors limit (Tigran Aivazian).
  */
 
+#include <linux/ltt/ltt-facility-fs.h>
 #include <linux/syscalls.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -239,6 +240,8 @@ int do_select(int n, fd_set_bits *fds, s
 				file = fget_light(i, &fput_needed);
 				if (file) {
 					f_op = file->f_op;
+					trace_fs_select(i, /* The fd */
+													*timeout);
 					mask = DEFAULT_POLLMASK;
 					if (f_op && f_op->poll)
 						mask = (*f_op->poll)(file, retval ? NULL : wait);
@@ -564,6 +567,7 @@ static void do_pollfd(unsigned int num, 
 			struct file * file = fget_light(fd, &fput_needed);
 			mask = POLLNVAL;
 			if (file != NULL) {
+				trace_fs_poll(fd);
 				mask = DEFAULT_POLLMASK;
 				if (file->f_op && file->f_op->poll)
 					mask = file->f_op->poll(file, *pwait);
diff --git a/include/asm-alpha/ltt.h b/include/asm-alpha/ltt.h
new file mode 100644
index 0000000..ed64656
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -35,6 +35,7 @@ #include <linux/mutex.h>
 
 #include <asm/current.h>
 #include <asm/uaccess.h>
+#include <linux/ltt/ltt-facility-ipc.h>
 #include "util.h"
 
 /* sysctl: */
@@ -237,6 +238,8 @@ asmlinkage long sys_msgget (key_t key, i
 		msg_unlock(msq);
 	}
 	mutex_unlock(&msg_ids.mutex);
+	
+	trace_ipc_msg_create(ret, msgflg);
 	return ret;
 }
 
diff --git a/ipc/sem.c b/ipc/sem.c
index 7919f8e..8cb817b 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -79,6 +79,7 @@ #include <linux/audit.h>
 #include <linux/capability.h>
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
+#include <linux/ltt/ltt-facility-ipc.h>
 
 #include <asm/uaccess.h>
 #include "util.h"
@@ -247,6 +248,7 @@ asmlinkage long sys_semget (key_t key, i
 	}
 
 	mutex_unlock(&sem_ids.mutex);
+	trace_ipc_sem_create(err, semflg);
 	return err;
 }
 
diff --git a/ipc/shm.c b/ipc/shm.c
index 8098968..718bdb5 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -33,6 +33,7 @@ #include <linux/capability.h>
 #include <linux/ptrace.h>
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
+#include <linux/ltt/ltt-facility-ipc.h>
 
 #include <asm/uaccess.h>
 
@@ -302,6 +303,7 @@ asmlinkage long sys_shmget (key_t key, s
 	}
 	mutex_unlock(&shm_ids.mutex);
 
+	trace_ipc_shm_create(err, shmflg);
 	return err;
 }
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 58908f9..1210b37 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -11,6 +11,7 @@ #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/ltt/ltt-facility-kernel.h>
 
 #include "internals.h"
 
@@ -36,6 +37,8 @@ irq_desc_t irq_desc[NR_IRQS] __cacheline
 	}
 };
 
+EXPORT_SYMBOL_GPL(irq_desc);
+
 /*
  * Generic 'no controller' code
  */
@@ -81,6 +84,8 @@ fastcall int handle_IRQ_event(unsigned i
 {
 	int ret, retval = 0, status = 0;
 
+	trace_kernel_irq_entry(irq, !(user_mode(regs)));
+
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
@@ -96,6 +101,8 @@ fastcall int handle_IRQ_event(unsigned i
 		add_interrupt_randomness(irq);
 	local_irq_disable();
 
+	trace_kernel_irq_exit();
+
 	return retval;
 }
 
diff --git a/kernel/itimer.c b/kernel/itimer.c
index 204ed79..730563b 100644
--- a/kernel/itimer.c
+++ b/kernel/itimer.c
@@ -13,6 +13,7 @@ #include <linux/syscalls.h>
 #include <linux/time.h>
 #include <linux/posix-timers.h>
 #include <linux/hrtimer.h>
+#include <linux/ltt/ltt-facility-timer.h>
 
 #include <asm/uaccess.h>
 
@@ -133,6 +134,8 @@ int it_real_fn(struct hrtimer *timer)
 	struct signal_struct *sig =
 	    container_of(timer, struct signal_struct, real_timer);
 
+	trace_timer_expired(sig->tsk->pid);
+
 	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, sig->tsk);
 
 	if (sig->it_real_incr.tv64 != 0) {
@@ -216,6 +219,12 @@ int do_setitimer(int which, struct itime
 	 */
 	check_itimerval(value);
 
+	trace_timer_set_itimer(which,
+			value->it_interval.tv_sec,
+			value->it_interval.tv_usec,
+			value->it_value.tv_sec,
+			value->it_value.tv_usec);
+
 	switch (which) {
 	case ITIMER_REAL:
 again:
diff --git a/kernel/ltt-base.c b/kernel/ltt-base.c
new file mode 100644
index 0000000..21ad18f
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -50,6 +50,7 @@ #include <linux/syscalls.h>
 #include <linux/times.h>
 #include <linux/acct.h>
 #include <linux/kprobes.h>
+#include <linux/ltt/ltt-facility-process.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -360,6 +361,8 @@ static inline runqueue_t *task_rq_lock(t
 {
 	struct runqueue *rq;
 
+	trace_process_wakeup(p->pid, p->state);
+
 repeat_lock_task:
 	local_irq_save(*flags);
 	rq = task_rq(p);
@@ -3053,6 +3056,7 @@ switch_tasks:
 		++*switch_count;
 
 		prepare_task_switch(rq, next);
+		trace_process_schedchange(prev->pid, next->pid, prev->state);
 		prev = context_switch(rq, prev, next);
 		barrier();
 		/*
diff --git a/kernel/signal.c b/kernel/signal.c
index e5f8aea..bbe9ddf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -25,6 +25,7 @@ #include <linux/ptrace.h>
 #include <linux/signal.h>
 #include <linux/audit.h>
 #include <linux/capability.h>
+#include <linux/ltt/ltt-facility-process.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -776,6 +777,8 @@ specific_send_sig_info(int sig, struct s
 	if (sig_ignored(t, sig))
 		goto out;
 
+	trace_process_signal(t->pid, sig);
+
 	/* Support queueing exactly one non-rt signal, so that we
 	   can get more detailed information about the cause of
 	   the signal. */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 336f92d..061900d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -17,6 +17,7 @@ #include <linux/cpu.h>
 #include <linux/kthread.h>
 #include <linux/rcupdate.h>
 #include <linux/smp.h>
+#include <linux/ltt/ltt-facility-kernel.h>
 
 #include <asm/irq.h>
 /*
@@ -93,7 +94,9 @@ restart:
 
 	do {
 		if (pending & 1) {
+			trace_kernel_soft_irq_entry((void*)(h - softirq_vec));
 			h->action(h);
+			trace_kernel_soft_irq_exit((void*)(h - softirq_vec));
 			rcu_bh_qsctr_inc(cpu);
 		}
 		h++;
@@ -263,9 +266,14 @@ static void tasklet_action(struct softir
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
+						&t->state))
 					BUG();
+				trace_kernel_tasklet_entry(
+						LTTNG_LOW, t->func, t->data);
 				t->func(t->data);
+				trace_kernel_tasklet_exit(
+						LTTNG_LOW, t->func, t->data);
 				tasklet_unlock(t);
 				continue;
 			}
@@ -296,9 +304,14 @@ static void tasklet_hi_action(struct sof
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
+						&t->state))
 					BUG();
+				trace_kernel_tasklet_entry(
+						LTTNG_HIGH, t->func, t->data);
 				t->func(t->data);
+				trace_kernel_tasklet_exit(
+						LTTNG_HIGH, t->func, t->data);
 				tasklet_unlock(t);
 				continue;
 			}
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 5433195..1a910f9 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -34,6 +34,8 @@ #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
 #include <linux/delay.h>
+#include <linux/ltt/ltt-facility-timer.h>
+#include <linux/ltt/ltt-facility-custom-stack.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -130,6 +132,7 @@ static void internal_add_timer(tvec_base
 		i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
 		vec = base->tv5.vec + i;
 	}
+	trace_timer_set_timer(expires, timer->function, timer->data);
 	/*
 	 * Timers are FIFO:
 	 */
@@ -896,7 +899,9 @@ static void run_timer_softirq(struct sof
 {
 	tvec_base_t *base = __get_cpu_var(tvec_bases);
 
+	trace_timer_softirq();
  	hrtimer_run_queues();
+
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
 }
@@ -934,6 +939,9 @@ static inline void update_times(void)
 
 void do_timer(struct pt_regs *regs)
 {
+#ifdef CONFIG_LTT_STACK_INTERRUPT
+	trace_stack_dump(regs);
+#endif //CONFIG_LTT_STACK_INTERRUPT
 	jiffies_64++;
 	/* prevent loading jiffies before storing new jiffies_64 value. */
 	barrier();
@@ -1046,6 +1054,7 @@ #endif
 
 static void process_timeout(unsigned long __data)
 {
+	trace_timer_expired(((task_t *)__data)->pid);
 	wake_up_process((task_t *)__data);
 }
 
diff --git a/ltt/Kconfig b/ltt/Kconfig
new file mode 100644
index 0000000..f74f63d
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -40,6 +40,7 @@ #include <linux/device.h>
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
+#include <linux/ltt/ltt-facility-statedump.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
@@ -2041,6 +2042,27 @@ struct seq_operations modules_op = {
 	.show	= m_show
 };
 
+int ltt_enumerate_modules(void)
+{
+	/* Enumerate loaded modules */
+	struct list_head	*i;
+	struct module		*mod;
+	unsigned long refcount = 0;
+	
+	mutex_lock(&module_mutex);
+	list_for_each(i, &modules) {
+		mod = list_entry(i, struct module, list);
+#ifdef CONFIG_MODULE_UNLOAD
+		refcount = local_read(&mod->ref[0].count);
+#endif //CONFIG_MODULE_UNLOAD
+		trace_statedump_enumerate_modules(
+				mod->name, mod->state, refcount);
+	}
+	mutex_unlock(&module_mutex);
+	return 0;
+}
+EXPORT_SYMBOL(ltt_enumerate_modules);
+
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned long addr)
 {
diff --git a/kernel/sched.c b/kernel/sched.c
index c13f1bd..865e54d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -30,6 +30,7 @@ #include <linux/blkdev.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/cpuset.h>
+#include <linux/ltt/ltt-facility-memory.h>
 #include "filemap.h"
 #include "internal.h"
 
@@ -482,9 +483,13 @@ void fastcall wait_on_page_bit(struct pa
 {
 	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);
 
+	trace_memory_page_wait_start(page_address(page));
+
 	if (test_bit(bit_nr, &page->flags))
 		__wait_on_bit(page_waitqueue(page), &wait, sync_page,
 							TASK_UNINTERRUPTIBLE);
+
+	trace_memory_page_wait_end(page_address(page));
 }
 EXPORT_SYMBOL(wait_on_page_bit);
 
diff --git a/mm/memory.c b/mm/memory.c
index 0ec7bc6..6c9ec65 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -48,6 +48,7 @@ #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/ltt/ltt-facility-memory.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -1882,6 +1883,7 @@ static int do_swap_page(struct mm_struct
 again:
 	page = lookup_swap_cache(entry);
 	if (!page) {
+		trace_memory_swap_in((void*)address);
  		swapin_readahead(entry, address, vma);
  		page = read_swap_cache_async(entry, vma, address);
 		if (!page) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 253a450..c3c02e8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -37,6 +37,7 @@ #include <linux/memory_hotplug.h>
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
+#include <linux/ltt/ltt-facility-memory.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -438,6 +439,8 @@ static void __free_pages_ok(struct page 
 	int i;
 	int reserved = 0;
 
+	trace_memory_page_free(order, page_address(page));
+
 	arch_free_page(page, order);
 	if (!PageHighMem(page))
 		mutex_debug_check_no_locks_freed(page_address(page),
@@ -1087,6 +1090,7 @@ fastcall unsigned long __get_free_pages(
 	page = alloc_pages(gfp_mask, order);
 	if (!page)
 		return 0;
+	trace_memory_page_alloc(order, page_address(page));
 	return (unsigned long) page_address(page);
 }
 
diff --git a/mm/page_io.c b/mm/page_io.c
index bb2b0d5..b286318 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -17,6 +17,7 @@ #include <linux/swap.h>
 #include <linux/bio.h>
 #include <linux/swapops.h>
 #include <linux/writeback.h>
+#include <linux/ltt/ltt-facility-memory.h>
 #include <asm/pgtable.h>
 
 static struct bio *get_swap_bio(gfp_t gfp_flags, pgoff_t index,
@@ -103,6 +104,7 @@ int swap_writepage(struct page *page, st
 		rw |= (1 << BIO_RW_SYNC);
 	inc_page_state(pswpout);
 	set_page_writeback(page);
+	trace_memory_swap_out(page_address(page));
 	unlock_page(page);
 	submit_bio(rw, bio);
 out:
diff --git a/net/core/dev.c b/net/core/dev.c
index 4fba549..514e145 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -115,6 +115,7 @@ #include <linux/wireless.h>
 #include <net/iw_handler.h>
 #include <asm/current.h>
 #include <linux/audit.h>
+#include <linux/ltt/ltt-facility-network.h>
 
 /*
  *	The list of packet types we will receive (as opposed to discard)
@@ -1343,6 +1344,8 @@ int dev_queue_xmit(struct sk_buff *skb)
 	      	if (skb_checksum_help(skb, 0))
 	      		goto out_kfree_skb;
 
+	trace_network_packet_out(skb, skb->protocol);
+
 	spin_lock_prefetch(&dev->queue_lock);
 
 	/* Disable soft irqs for various locks below. Also 
@@ -1692,6 +1695,8 @@ int netif_receive_skb(struct sk_buff *sk
 
 	__get_cpu_var(netdev_rx_stat).total++;
 
+	trace_network_packet_in(skb, skb->protocol);
+
 	skb->h.raw = skb->nh.raw = skb->data;
 	skb->mac_len = skb->nh.raw - skb->mac.raw;
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 54419b2..7e0aba5 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -58,6 +58,7 @@ #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif
 #include <linux/kmod.h>
+#include <linux/ltt/ltt-facility-network_ip_interface.h>
 
 #include <net/arp.h>
 #include <net/ip.h>
@@ -1020,8 +1021,19 @@ static int inetdev_event(struct notifier
 			}
 		}
 		ip_mc_up(in_dev);
+
+		{
+		 	struct in_ifaddr **ifap = NULL;
+		 	struct in_ifaddr *ifa = NULL;
+			for (ifap = &in_dev->ifa_list; (ifa = *ifap) != NULL;
+			     				ifap = &ifa->ifa_next) 
+			  trace_network_ip_interface_dev_up(ifa->ifa_label, 
+							ifa->ifa_address);
+		}
 		break;
 	case NETDEV_DOWN:
+		trace_network_ip_interface_dev_down(dev->name);
+
 		ip_mc_down(in_dev);
 		break;
 	case NETDEV_CHANGEMTU:
diff --git a/net/socket.c b/net/socket.c
index 02948b6..09828f3 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -86,6 +86,7 @@ #include <linux/compat.h>
 #include <linux/kmod.h>
 #include <linux/audit.h>
 #include <linux/wireless.h>
+#include <linux/ltt/ltt-facility-socket.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -602,6 +603,11 @@ int sock_sendmsg(struct socket *sock, st
 	struct sock_iocb siocb;
 	int ret;
 
+	trace_socket_sendmsg(sock, sock->sk->sk_family,
+		sock->sk->sk_type,
+		sock->sk->sk_protocol,
+		size);
+
 	init_sync_kiocb(&iocb, NULL);
 	iocb.private = &siocb;
 	ret = __sock_sendmsg(&iocb, sock, msg, size);
@@ -654,6 +660,11 @@ int sock_recvmsg(struct socket *sock, st
 	struct sock_iocb siocb;
 	int ret;
 
+	trace_socket_recvmsg(sock, sock->sk->sk_family,
+		sock->sk->sk_type,
+		sock->sk->sk_protocol,
+		size);
+
         init_sync_kiocb(&iocb, NULL);
 	iocb.private = &siocb;
 	ret = __sock_recvmsg(&iocb, sock, msg, size, flags);
@@ -1248,6 +1259,11 @@ asmlinkage long sys_socket(int family, i
 	if (retval < 0)
 		goto out_release;
 
+	trace_socket_create(sock, family,
+		type,
+		protocol,
+		retval);
+
 out:
 	/* It may be already another descriptor 8) Not kernel problem. */
 	return retval;
@@ -1986,6 +2002,8 @@ asmlinkage long sys_socketcall(int call,
 
 	a0=a[0];
 	a1=a[1];
+
+	trace_socket_call(call, a0);
 	
 	switch(call) 
 	{

--=_Krystal-21507-1156979917-0001-2--
