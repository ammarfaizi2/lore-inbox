Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264912AbSJOWrs>; Tue, 15 Oct 2002 18:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSJOWqq>; Tue, 15 Oct 2002 18:46:46 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:39434 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265049AbSJOW1l>; Tue, 15 Oct 2002 18:27:41 -0400
Date: Tue, 15 Oct 2002 23:33:33 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [6/7] oprofile - core
Message-ID: <20021015223333.GF41906@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add the oprofile core. The core design is very similar to that we
discussed in private mail. The nasty details should be documented in the
patch below.


diff -Naur -X dontdiff linux-linus/drivers/oprofile/buffer_sync.c linux/drivers/oprofile/buffer_sync.c
--- linux-linus/drivers/oprofile/buffer_sync.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/buffer_sync.c	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,394 @@
+/**
+ * @file buffer_sync.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ *
+ * This is the core of the buffer management. Each
+ * CPU buffer is processed and entered into the
+ * global event buffer. Such processing is necessary
+ * in several circumstances, mentioned below.
+ *
+ * The processing does the job of converting the
+ * transitory EIP value into a persistent dentry/offset
+ * value that the profiler can record at its leisure.
+ *
+ * See fs/dcookies.c for a description of the dentry/offset
+ * objects.
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/timer.h>
+#include <linux/dcookies.h>
+#include <linux/notifier.h>
+#include <linux/profile.h>
+#include <linux/workqueue.h>
+
+#include "event_buffer.h"
+#include "cpu_buffer.h"
+#include "oprofile_stats.h"
+ 
+#define DEFAULT_EXPIRE (HZ / 4)
+ 
+static void wq_sync_buffers(void *);
+static DECLARE_WORK(sync_wq, wq_sync_buffers, 0);
+ 
+static struct timer_list sync_timer;
+static void timer_ping(unsigned long data);
+static void sync_cpu_buffers(void);
+
+ 
+/* We must make sure to process every entry in the CPU buffers
+ * before a task got the PF_EXITING flag, otherwise we will hold
+ * references to a possibly freed task_struct. We are safe with
+ * samples past the PF_EXITING point in do_exit(), because we
+ * explicitly check for that in cpu_buffer.c 
+ */
+static int exit_task_notify(struct notifier_block * self, unsigned long val, void * data)
+{
+	sync_cpu_buffers();
+	return 0;
+}
+ 
+/* There are two cases of tasks modifying task->mm->mmap list we
+ * must concern ourselves with. First, when a task is about to
+ * exit (exit_mmap()), we should process the buffer to deal with
+ * any samples in the CPU buffer, before we lose the ->mmap information
+ * we need. Second, a task may unmap (part of) an executable mmap,
+ * so we want to process samples before that happens too
+ */
+static int mm_notify(struct notifier_block * self, unsigned long val, void * data)
+{
+	sync_cpu_buffers();
+	return 0;
+}
+
+ 
+static struct notifier_block exit_task_nb = {
+	.notifier_call	= exit_task_notify,
+};
+
+static struct notifier_block exec_unmap_nb = {
+	.notifier_call	= mm_notify,
+};
+
+static struct notifier_block exit_mmap_nb = {
+	.notifier_call	= mm_notify,
+};
+ 
+ 
+int sync_start(void)
+{
+	int err = profile_event_register(EXIT_TASK, &exit_task_nb);
+	if (err)
+		goto out;
+	err = profile_event_register(EXIT_MMAP, &exit_mmap_nb);
+	if (err)
+		goto out2;
+	err = profile_event_register(EXEC_UNMAP, &exec_unmap_nb);
+	if (err)
+		goto out3;
+ 
+	sync_timer.function = timer_ping;
+	sync_timer.expires = jiffies + DEFAULT_EXPIRE;
+	add_timer(&sync_timer);
+out:
+	return err;
+out3:
+	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
+out2:
+	profile_event_unregister(EXIT_TASK, &exit_task_nb);
+	goto out;
+}
+
+
+void sync_stop(void)
+{
+	profile_event_unregister(EXIT_TASK, &exit_task_nb);
+	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
+	profile_event_unregister(EXEC_UNMAP, &exec_unmap_nb);
+	del_timer_sync(&sync_timer);
+}
+
+ 
+/* Optimisation. We can manage without taking the dcookie sem
+ * because we cannot reach this code without at least one
+ * dcookie user still being registered (namely, the reader
+ * of the event buffer). */
+static inline unsigned long fast_get_dcookie(struct dentry * dentry,
+	struct vfsmount * vfsmnt)
+{
+	unsigned long cookie;
+ 
+	if (dentry->d_cookie)
+		return (unsigned long)dentry;
+	get_dcookie(dentry, vfsmnt, &cookie);
+	return cookie;
+}
+
+ 
+/* Look up the dcookie for the task's first VM_EXECUTABLE mapping,
+ * which corresponds loosely to "application name". This is
+ * not strictly necessary but allows oprofile to associate
+ * shared-library samples with particular applications
+ */
+static unsigned long get_exec_dcookie(struct mm_struct * mm)
+{
+	unsigned long cookie = 0;
+	struct vm_area_struct * vma;
+ 
+	if (!mm)
+		goto out;
+ 
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		if (!vma->vm_file)
+			continue;
+		if (!vma->vm_flags & VM_EXECUTABLE)		
+			continue;
+		cookie = fast_get_dcookie(vma->vm_file->f_dentry,
+			vma->vm_file->f_vfsmnt);
+		break;
+	}
+
+out:
+	return cookie;
+}
+
+
+/* Convert the EIP value of a sample into a persistent dentry/offset
+ * pair that can then be added to the global event buffer. We make
+ * sure to do this lookup before a mm->mmap modification happens so
+ * we don't lose track.
+ */
+static unsigned long lookup_dcookie(struct mm_struct * mm, unsigned long addr, off_t * offset)
+{
+	unsigned long cookie = 0;
+	struct vm_area_struct * vma;
+
+	for (vma = find_vma(mm, addr); vma; vma = vma->vm_next) {
+		if (!vma)
+			goto out;
+ 
+		if (!vma->vm_file)
+			continue;
+
+		if (addr < vma->vm_start || addr >= vma->vm_end)
+			continue;
+
+		cookie = fast_get_dcookie(vma->vm_file->f_dentry,
+			vma->vm_file->f_vfsmnt);
+		*offset = (vma->vm_pgoff << PAGE_SHIFT) + addr - vma->vm_start; 
+		break;
+	}
+out:
+	return cookie;
+}
+
+
+static unsigned long last_cookie = ~0UL;
+ 
+static void add_cpu_switch(int i)
+{
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(CPU_SWITCH_CODE);
+	add_event_entry(i);
+	last_cookie = ~0UL;
+}
+
+ 
+static void add_ctx_switch(pid_t pid, unsigned long cookie)
+{
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(CTX_SWITCH_CODE); 
+	add_event_entry(pid);
+	add_event_entry(cookie);
+}
+
+ 
+static void add_cookie_switch(unsigned long cookie)
+{
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(COOKIE_SWITCH_CODE);
+	add_event_entry(cookie);
+}
+
+ 
+static void add_sample_entry(unsigned long offset, unsigned long event)
+{
+	add_event_entry(offset);
+	add_event_entry(event);
+}
+
+
+static void add_us_sample(struct mm_struct * mm, struct op_sample * s)
+{
+	unsigned long cookie;
+	off_t offset;
+ 
+ 	cookie = lookup_dcookie(mm, s->eip, &offset);
+ 
+	if (!cookie)
+		return;
+
+	if (cookie != last_cookie) {
+		add_cookie_switch(cookie);
+		last_cookie = cookie;
+	}
+
+	add_sample_entry(offset, s->event);
+}
+
+ 
+static inline int is_kernel(unsigned long val)
+{
+	return val > __PAGE_OFFSET;
+}
+
+
+/* Add a sample to the global event buffer. If possible the
+ * sample is converted into a persistent dentry/offset pair
+ * for later lookup from userspace.
+ */
+static void add_sample(struct mm_struct * mm, struct op_sample * s)
+{
+	if (is_kernel(s->eip)) {
+		add_sample_entry(s->eip, s->event);
+	} else if (mm) {
+		add_us_sample(mm, s);
+	}
+}
+ 
+ 
+static void release_mm(struct mm_struct * mm)
+{
+	if (mm)
+		up_read(&mm->mmap_sem);
+}
+
+
+/* Take the task's mmap_sem to protect ourselves from
+ * races when we do lookup_dcookie().
+ */
+static struct mm_struct * take_task_mm(struct task_struct * task)
+{
+	struct mm_struct * mm;
+	task_lock(task);
+	mm = task->mm;
+	task_unlock(task);
+ 
+	/* if task->mm !NULL, mm_count must be at least 1. It cannot
+	 * drop to 0 without the task exiting, which will have to sleep
+	 * on buffer_sem first. So we do not need to mark mm_count
+	 * ourselves.
+	 */
+	if (mm) {
+		/* More ugliness. If a task took its mmap
+		 * sem then came to sleep on buffer_sem we
+		 * will deadlock waiting for it. So we can
+		 * but try. This will lose samples :/
+		 */
+		if (!down_read_trylock(&mm->mmap_sem)) {
+			/* FIXME: this underestimates samples lost */
+			atomic_inc(&oprofile_stats.sample_lost_mmap_sem);
+			mm = NULL;
+		}
+	}
+ 
+	return mm;
+}
+ 
+ 
+static inline int is_ctx_switch(unsigned long val)
+{
+	return val == ~0UL;
+}
+ 
+
+/* Sync one of the CPU's buffers into the global event buffer.
+ * Here we need to go through each batch of samples punctuated
+ * by context switch notes, taking the task's mmap_sem and doing
+ * lookup in task->mm->mmap to convert EIP into dcookie/offset
+ * value.
+ */
+static void sync_buffer(struct oprofile_cpu_buffer * cpu_buf)
+{
+	struct mm_struct * mm = 0;
+	struct task_struct * new;
+	unsigned long cookie;
+	int i;
+ 
+	for (i=0; i < cpu_buf->pos; ++i) {
+		struct op_sample * s = &cpu_buf->buffer[i];
+ 
+		if (is_ctx_switch(s->eip)) {
+			new = (struct task_struct *)s->event;
+ 
+			release_mm(mm);
+			mm = take_task_mm(new);
+ 
+			cookie = get_exec_dcookie(mm);
+			add_ctx_switch(new->pid, cookie);
+		} else {
+			add_sample(mm, s);
+		}
+	}
+	release_mm(mm);
+
+	cpu_buf->pos = 0;
+}
+ 
+ 
+/* Process each CPU's local buffer into the global
+ * event buffer.
+ */
+static void sync_cpu_buffers(void)
+{
+	int i;
+
+	down(&buffer_sem);
+ 
+	for (i = 0; i < NR_CPUS; ++i) {
+		struct oprofile_cpu_buffer * cpu_buf;
+ 
+		if (!cpu_possible(i))
+			continue;
+ 
+		cpu_buf = &cpu_buffer[i];
+ 
+		/* We take a spin lock even though we might
+		 * sleep. It's OK because other users are try
+		 * lockers only, and this region is already
+		 * protected by buffer_sem. It's raw to prevent
+		 * the preempt bogometer firing. Fruity, huh ? */
+		_raw_spin_lock(&cpu_buf->int_lock);
+		add_cpu_switch(i);
+		sync_buffer(cpu_buf);
+		_raw_spin_unlock(&cpu_buf->int_lock);
+	}
+
+	up(&buffer_sem);
+ 
+	mod_timer(&sync_timer, jiffies + DEFAULT_EXPIRE);
+}
+ 
+
+static void wq_sync_buffers(void * data)
+{
+	sync_cpu_buffers();
+}
+ 
+ 
+/* It is possible that we could have no munmap() or
+ * other events for a period of time. This will lead
+ * the CPU buffers to overflow and lose samples and
+ * context switches. We try to reduce the problem
+ * by timing out when nothing happens for a while.
+ */
+static void timer_ping(unsigned long data)
+{
+	schedule_work(&sync_wq);
+	/* timer is re-added by the scheduled task */
+}
diff -Naur -X dontdiff linux-linus/drivers/oprofile/buffer_sync.h linux/drivers/oprofile/buffer_sync.h
--- linux-linus/drivers/oprofile/buffer_sync.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/buffer_sync.h	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,19 @@
+/**
+ * @file buffer_sync.h
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#ifndef OPROFILE_BUFFER_SYNC_H
+#define OPROFILE_BUFFER_SYNC_H
+ 
+/* add the necessary profiling hooks */
+int sync_start(void);
+
+/* remove the hooks */
+void sync_stop(void);
+ 
+#endif /* OPROFILE_BUFFER_SYNC_H */
diff -Naur -X dontdiff linux-linus/drivers/oprofile/cpu_buffer.c linux/drivers/oprofile/cpu_buffer.c
--- linux-linus/drivers/oprofile/cpu_buffer.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/cpu_buffer.c	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,135 @@
+/**
+ * @file cpu_buffer.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ *
+ * Each CPU has a local buffer that stores PC value/event
+ * pairs. We also log context switches when we notice them.
+ * Eventually each CPU's buffer is processed into the global
+ * event buffer by sync_cpu_buffers().
+ *
+ * We use a local buffer for two reasons: an NMI or similar
+ * interrupt cannot synchronise, and high sampling rates
+ * would lead to catastrophic global synchronisation if
+ * a global buffer was used.
+ */
+
+#include <linux/sched.h>
+#include <linux/vmalloc.h>
+#include <linux/smp.h>
+ 
+#include "cpu_buffer.h"
+#include "oprof.h"
+#include "oprofile_stats.h"
+
+struct oprofile_cpu_buffer cpu_buffer[NR_CPUS] __cacheline_aligned;
+
+static unsigned long buffer_size;
+ 
+static void __free_cpu_buffers(int num)
+{
+	int i;
+ 
+	for (i=0; i < num; ++i) {
+		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
+ 
+		if (!cpu_possible(i)) 
+			continue;
+ 
+		vfree(b->buffer);
+	}
+}
+ 
+ 
+int alloc_cpu_buffers(void)
+{
+	int i;
+ 
+	buffer_size = fs_cpu_buffer_size;
+ 
+	for (i=0; i < NR_CPUS; ++i) {
+		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
+ 
+		if (!cpu_possible(i)) 
+			continue;
+ 
+		b->buffer = vmalloc(sizeof(struct op_sample) * buffer_size);
+		if (!b->buffer)
+			goto fail;
+ 
+		spin_lock_init(&b->int_lock);
+		b->pos = 0;
+		b->last_task = 0;
+		b->sample_received = 0;
+		b->sample_lost_locked = 0;
+		b->sample_lost_overflow = 0;
+	}
+	return 0;
+fail:
+	__free_cpu_buffers(i);
+	return -ENOMEM;
+}
+ 
+
+void free_cpu_buffers(void)
+{
+	__free_cpu_buffers(NR_CPUS);
+}
+
+ 
+/* Note we can't use a semaphore here as this is supposed to
+ * be safe from any context. Instead we trylock the CPU's int_lock.
+ * int_lock is taken by the processing code in sync_cpu_buffers()
+ * so we avoid disturbing that.
+ */
+void oprofile_add_sample(unsigned long eip, unsigned long event, int cpu)
+{
+	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[cpu];
+	struct task_struct * task;
+
+	/* temporary ? */
+	BUG_ON(!oprofile_started);
+ 
+	cpu_buf->sample_received++;
+ 
+	if (!spin_trylock(&cpu_buf->int_lock)) {
+		cpu_buf->sample_lost_locked++;
+		return;
+	}
+
+	if (cpu_buf->pos > buffer_size - 2) {
+		cpu_buf->sample_lost_overflow++;
+		goto out;
+	}
+ 
+	task = current;
+
+	/* notice a task switch */
+	if (cpu_buf->last_task != task) {
+		cpu_buf->last_task = task;
+		if (!(task->flags & PF_EXITING)) {
+			cpu_buf->buffer[cpu_buf->pos].eip = ~0UL;
+			cpu_buf->buffer[cpu_buf->pos].event = (unsigned long)task;
+			cpu_buf->pos++;
+		}
+	}
+ 
+	/* If the task is exiting it's not safe to take a sample
+	 * as the task_struct is about to be freed. We can't just
+	 * notify at release_task() time because of CLONE_DETACHED
+	 * tasks that release_task() themselves.
+	 */
+	if (task->flags & PF_EXITING) {
+		cpu_buf->sample_lost_task_exit++;
+		goto out;
+	}
+ 
+	cpu_buf->buffer[cpu_buf->pos].eip = eip;
+	cpu_buf->buffer[cpu_buf->pos].event = event;
+	cpu_buf->pos++;
+out:
+	spin_unlock(&cpu_buf->int_lock);
+}
diff -Naur -X dontdiff linux-linus/drivers/oprofile/cpu_buffer.h linux/drivers/oprofile/cpu_buffer.h
--- linux-linus/drivers/oprofile/cpu_buffer.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/cpu_buffer.h	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,45 @@
+/**
+ * @file cpu_buffer.h
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#ifndef OPROFILE_CPU_BUFFER_H
+#define OPROFILE_CPU_BUFFER_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+ 
+struct task_struct;
+ 
+/* allocate a sample buffer for each CPU */
+int alloc_cpu_buffers(void);
+
+void free_cpu_buffers(void);
+ 
+/* CPU buffer is composed of such entries (which are
+ * also used for context switch notes)
+ */
+struct op_sample {
+	unsigned long eip;
+	unsigned long event;
+};
+ 
+struct oprofile_cpu_buffer {
+	spinlock_t int_lock;
+	/* protected by int_lock */
+	unsigned long pos;
+	struct task_struct * last_task;
+	struct op_sample * buffer;
+	unsigned long sample_received;
+	unsigned long sample_lost_locked;
+	unsigned long sample_lost_overflow;
+	unsigned long sample_lost_task_exit;
+} ____cacheline_aligned;
+
+extern struct oprofile_cpu_buffer cpu_buffer[];
+
+#endif /* OPROFILE_CPU_BUFFER_H */
diff -Naur -X dontdiff linux-linus/drivers/oprofile/event_buffer.c linux/drivers/oprofile/event_buffer.c
--- linux-linus/drivers/oprofile/event_buffer.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/event_buffer.c	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,186 @@
+/**
+ * @file event_buffer.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ *
+ * This is the global event buffer that the user-space
+ * daemon reads from. The event buffer is an untyped array
+ * of unsigned longs. Entries are prefixed by the
+ * escape value ESCAPE_CODE followed by an identifying code.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/vmalloc.h>
+#include <linux/smp.h>
+#include <linux/dcookies.h>
+#include <linux/oprofile.h>
+#include <asm/uaccess.h>
+#include <asm/atomic.h>
+
+#include "event_buffer.h"
+#include "cpu_buffer.h"
+#include "oprof.h"
+#include "oprofile_stats.h"
+
+DECLARE_MUTEX(buffer_sem);
+ 
+static unsigned long buffer_opened;
+static DECLARE_WAIT_QUEUE_HEAD(buffer_wait);
+static unsigned long * event_buffer;
+static unsigned long buffer_size;
+static unsigned long buffer_watershed;
+static size_t buffer_pos;
+/* atomic_t because wait_event checks it outside of buffer_sem */
+static atomic_t buffer_ready = ATOMIC_INIT(0);
+
+/* Add an entry to the event buffer. When we
+ * get near to the end we wake up the process
+ * sleeping on the read() of the file.
+ */
+void add_event_entry(unsigned long value)
+{
+	if (buffer_pos == buffer_size) {
+		atomic_inc(&oprofile_stats.event_lost_overflow);
+		return;
+	}
+
+	event_buffer[buffer_pos] = value;
+	if (++buffer_pos == buffer_size - buffer_watershed) {
+		atomic_set(&buffer_ready, 1);
+		wake_up(&buffer_wait);
+	}
+}
+
+
+/* Wake up the waiting process if any. This happens
+ * on "echo 0 >/dev/oprofile/enable" so the daemon
+ * processes the data remaining in the event buffer.
+ */
+void wake_up_buffer_waiter(void)
+{
+	down(&buffer_sem);
+	atomic_set(&buffer_ready, 1);
+	wake_up(&buffer_wait);
+	up(&buffer_sem);
+}
+
+ 
+int alloc_event_buffer(void)
+{
+	int err = -ENOMEM;
+
+	spin_lock(&oprofilefs_lock);
+	buffer_size = fs_buffer_size;
+	buffer_watershed = fs_buffer_watershed;
+	spin_unlock(&oprofilefs_lock);
+ 
+	if (buffer_watershed >= buffer_size)
+		return -EINVAL;
+ 
+	event_buffer = vmalloc(sizeof(unsigned long) * buffer_size);
+	if (!event_buffer)
+		goto out; 
+
+	err = 0;
+out:
+	return err;
+}
+
+
+void free_event_buffer(void)
+{
+	vfree(event_buffer);
+}
+
+ 
+int event_buffer_open(struct inode * inode, struct file * file)
+{
+	int err = -EPERM;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (test_and_set_bit(0, &buffer_opened))
+		return -EBUSY;
+
+	/* Register as a user of dcookies
+	 * to ensure they persist for the lifetime of
+	 * the open event file
+	 */
+	err = -EINVAL;
+	file->private_data = dcookie_register();
+	if (!file->private_data)
+		goto out;
+		 
+	if ((err = oprofile_setup()))
+		goto fail;
+
+	/* NB: the actual start happens from userspace
+	 * echo 1 >/dev/oprofile/enable
+	 */
+ 
+	return 0;
+
+fail:
+	dcookie_unregister(file->private_data);
+out:
+	clear_bit(0, &buffer_opened);
+	return err;
+}
+
+
+int event_buffer_release(struct inode * inode, struct file * file)
+{
+	oprofile_stop();
+	oprofile_shutdown();
+	dcookie_unregister(file->private_data);
+	buffer_pos = 0;
+	atomic_set(&buffer_ready, 0);
+	clear_bit(0, &buffer_opened);
+	return 0;
+}
+
+
+ssize_t event_buffer_read(struct file * file, char * buf, size_t count, loff_t * offset)
+{
+	int retval = -EINVAL;
+	size_t const max = buffer_size * sizeof(unsigned long);
+
+	/* handling partial reads is more trouble than it's worth */
+	if (count != max || *offset)
+		return -EINVAL;
+
+	/* wait for the event buffer to fill up with some data */
+	wait_event_interruptible(buffer_wait, atomic_read(&buffer_ready));
+	if (signal_pending(current))
+		return -EINTR;
+
+	down(&buffer_sem);
+
+	atomic_set(&buffer_ready, 0);
+
+	retval = -EFAULT;
+
+	count = buffer_pos * sizeof(unsigned long);
+ 
+	if (copy_to_user(buf, event_buffer, count))
+		goto out;
+
+	retval = count;
+	buffer_pos = 0;
+ 
+out:
+	up(&buffer_sem);
+	return retval;
+}
+ 
+struct file_operations event_buffer_fops = {
+	.open		= event_buffer_open,
+	.release	= event_buffer_release,
+	.read		= event_buffer_read,
+};
diff -Naur -X dontdiff linux-linus/drivers/oprofile/event_buffer.h linux/drivers/oprofile/event_buffer.h
--- linux-linus/drivers/oprofile/event_buffer.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/event_buffer.h	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,42 @@
+/**
+ * @file event_buffer.h
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#ifndef EVENT_BUFFER_H
+#define EVENT_BUFFER_H
+
+#include <linux/types.h> 
+#include <linux/sem.h>
+ 
+int alloc_event_buffer(void);
+
+void free_event_buffer(void);
+ 
+/* wake up the process sleeping on the event file */
+void wake_up_buffer_waiter(void);
+ 
+/* Each escaped entry is prefixed by ESCAPE_CODE
+ * then one of the following codes, then the
+ * relevant data.
+ */
+#define ESCAPE_CODE		~0UL
+#define CTX_SWITCH_CODE 	1
+#define CPU_SWITCH_CODE 	2
+#define COOKIE_SWITCH_CODE 	3
+ 
+/* add data to the event buffer */
+void add_event_entry(unsigned long data);
+ 
+extern struct file_operations event_buffer_fops;
+ 
+/* mutex between sync_cpu_buffers() and the
+ * file reading code.
+ */
+extern struct semaphore buffer_sem;
+ 
+#endif /* EVENT_BUFFER_H */
diff -Naur -X dontdiff linux-linus/drivers/oprofile/oprof.c linux/drivers/oprofile/oprof.c
--- linux-linus/drivers/oprofile/oprof.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/oprof.c	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,154 @@
+/**
+ * @file oprof.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/dcookies.h>
+#include <linux/notifier.h>
+#include <linux/profile.h>
+#include <linux/oprofile.h>
+
+#include "oprof.h"
+#include "event_buffer.h"
+#include "cpu_buffer.h"
+#include "buffer_sync.h"
+#include "oprofile_stats.h"
+ 
+struct oprofile_operations * oprofile_ops;
+enum oprofile_cpu oprofile_cpu_type;
+unsigned long oprofile_started;
+static unsigned long is_setup;
+static DECLARE_MUTEX(start_sem);
+
+int oprofile_setup(void)
+{
+	int err;
+ 
+	if ((err = alloc_cpu_buffers()))
+		goto out;
+
+	if ((err = alloc_event_buffer()))
+		goto out1;
+ 
+	if (oprofile_ops->setup && (err = oprofile_ops->setup()))
+		goto out2;
+ 
+	/* Note even though this starts part of the
+	 * profiling overhead, it's necessary to prevent
+	 * us missing task deaths and eventually oopsing
+	 * when trying to process the event buffer.
+	 */
+	if ((err = sync_start()))
+		goto out3;
+
+	down(&start_sem);
+	is_setup = 1;
+	up(&start_sem);
+	return 0;
+ 
+out3:
+	if (oprofile_ops->shutdown)
+		oprofile_ops->shutdown();
+out2:
+	free_event_buffer();
+out1:
+	free_cpu_buffers();
+out:
+	return err;
+}
+
+
+/* Actually start profiling (echo 1>/dev/oprofile/enable) */
+int oprofile_start(void)
+{
+	int err = -EINVAL;
+ 
+	down(&start_sem);
+ 
+	if (!is_setup)
+		goto out;
+
+	err = 0; 
+ 
+	if (oprofile_started)
+		goto out;
+ 
+	if ((err = oprofile_ops->start()))
+		goto out;
+
+	oprofile_started = 1;
+	oprofile_reset_stats();
+out:
+	up(&start_sem); 
+	return err;
+}
+
+ 
+/* echo 0>/dev/oprofile/enable */
+void oprofile_stop(void)
+{
+	down(&start_sem);
+	if (!oprofile_started)
+		goto out;
+	oprofile_ops->stop();
+	oprofile_started = 0;
+	/* wake up the daemon to read what remains */
+	wake_up_buffer_waiter();
+out:
+	up(&start_sem);
+}
+
+
+void oprofile_shutdown(void)
+{
+	sync_stop();
+	if (oprofile_ops->shutdown)
+		oprofile_ops->shutdown(); 
+	/* down() is also necessary to synchronise all pending events
+	 * before freeing */
+	down(&buffer_sem);
+	is_setup = 0;
+	up(&buffer_sem);
+	free_event_buffer();
+	free_cpu_buffers();
+}
+
+ 
+static int __init oprofile_init(void)
+{
+	int err;
+
+	/* Architecture must fill in the interrupt ops and the
+	 * logical CPU type.
+	 */
+	err = oprofile_arch_init(&oprofile_ops, &oprofile_cpu_type);
+	if (err)
+		goto out;
+
+	err = oprofilefs_register();
+	if (err)
+		goto out;
+ 
+out:
+	return err;
+}
+
+
+static void __exit oprofile_exit(void)
+{
+	oprofilefs_unregister();
+}
+
+MODULE_LICENSE("GPL");
+module_init(oprofile_init);
+module_exit(oprofile_exit);
diff -Naur -X dontdiff linux-linus/drivers/oprofile/oprof.h linux/drivers/oprofile/oprof.h
--- linux-linus/drivers/oprofile/oprof.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/oprof.h	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,34 @@
+/**
+ * @file oprof.h
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#ifndef OPROF_H
+#define OPROF_H
+
+#include <linux/spinlock.h>
+#include <linux/oprofile.h>
+ 
+int oprofile_setup(void);
+void oprofile_shutdown(void); 
+
+int oprofilefs_register(void);
+void oprofilefs_unregister(void);
+
+int oprofile_start(void);
+void oprofile_stop(void);
+
+extern unsigned long fs_buffer_size;
+extern unsigned long fs_cpu_buffer_size;
+extern unsigned long fs_buffer_watershed;
+extern enum oprofile_cpu oprofile_cpu_type;
+extern struct oprofile_operations * oprofile_ops;
+extern unsigned long oprofile_started;
+ 
+void oprofile_create_files(struct super_block * sb, struct dentry * root);
+ 
+#endif /* OPROF_H */
diff -Naur -X dontdiff linux-linus/drivers/oprofile/oprofile_files.c linux/drivers/oprofile/oprofile_files.c
--- linux-linus/drivers/oprofile/oprofile_files.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/oprofile_files.c	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,91 @@
+/**
+ * @file oprofile_files.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/oprofile.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <asm/uaccess.h>
+ 
+#include "oprof.h"
+#include "event_buffer.h"
+#include "oprofile_stats.h"
+ 
+unsigned long fs_buffer_size = 131072;
+unsigned long fs_cpu_buffer_size = 8192;
+unsigned long fs_buffer_watershed = 32768; /* FIXME: tune */
+
+ 
+static int simple_open(struct inode * inode, struct file * filp)
+{
+	return 0;
+}
+
+
+static ssize_t cpu_type_read(struct file * file, char * buf, size_t count, loff_t * offset)
+{
+	unsigned long cpu_type = oprofile_cpu_type;
+
+	return oprofilefs_ulong_to_user(&cpu_type, buf, count, offset);
+}
+ 
+ 
+static struct file_operations cpu_type_fops = {
+	.open		= simple_open,
+	.read		= cpu_type_read,
+};
+ 
+ 
+static ssize_t enable_read(struct file * file, char * buf, size_t count, loff_t * offset)
+{
+	return oprofilefs_ulong_to_user(&oprofile_started, buf, count, offset);
+}
+
+
+static ssize_t enable_write(struct file *file, char const * buf, size_t count, loff_t * offset)
+{
+	unsigned long val;
+	int retval;
+
+	if (*offset)
+		return -EINVAL;
+
+	retval = oprofilefs_ulong_from_user(&val, buf, count);
+	if (retval)
+		return retval;
+ 
+	if (val)
+		retval = oprofile_start();
+	else
+		oprofile_stop();
+
+	if (retval)
+		return retval;
+	return count;
+}
+
+ 
+static struct file_operations enable_fops = {
+	.open		= simple_open,
+	.read		= enable_read,
+	.write		= enable_write,
+};
+
+ 
+void oprofile_create_files(struct super_block * sb, struct dentry * root)
+{
+	oprofilefs_create_file(sb, root, "enable", &enable_fops);
+	oprofilefs_create_file(sb, root, "buffer", &event_buffer_fops);
+	oprofilefs_create_ulong(sb, root, "buffer_size", &fs_buffer_size);
+	oprofilefs_create_ulong(sb, root, "buffer_watershed", &fs_buffer_watershed);
+	oprofilefs_create_ulong(sb, root, "cpu_buffer_size", &fs_cpu_buffer_size);
+	oprofilefs_create_file(sb, root, "cpu_type", &cpu_type_fops); 
+	oprofile_create_stats_files(sb, root);
+	if (oprofile_ops->create_files)
+		oprofile_ops->create_files(sb, root);
+}
diff -Naur -X dontdiff linux-linus/drivers/oprofile/oprofile_stats.c linux/drivers/oprofile/oprofile_stats.c
--- linux-linus/drivers/oprofile/oprofile_stats.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/oprofile_stats.c	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,77 @@
+/**
+ * @file oprofile_stats.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon
+ */
+
+#include <linux/oprofile.h>
+#include <linux/smp.h>
+ 
+#include "oprofile_stats.h"
+#include "cpu_buffer.h"
+ 
+struct oprofile_stat_struct oprofile_stats;
+ 
+void oprofile_reset_stats(void)
+{
+	struct oprofile_cpu_buffer * cpu_buf; 
+	int i;
+ 
+	for (i = 0; i < NR_CPUS; ++i) {
+		if (!cpu_possible(i))
+			continue;
+
+		cpu_buf = &cpu_buffer[i]; 
+		cpu_buf->sample_received = 0;
+		cpu_buf->sample_lost_locked = 0;
+		cpu_buf->sample_lost_overflow = 0;
+		cpu_buf->sample_lost_task_exit = 0;
+	}
+ 
+	atomic_set(&oprofile_stats.sample_lost_mmap_sem, 0);
+	atomic_set(&oprofile_stats.event_lost_overflow, 0);
+}
+
+
+void oprofile_create_stats_files(struct super_block * sb, struct dentry * root)
+{
+	struct oprofile_cpu_buffer * cpu_buf;
+	struct dentry * cpudir;
+	struct dentry * dir;
+	char buf[10];
+	int i;
+
+	dir = oprofilefs_mkdir(sb, root, "stats");
+	if (!dir)
+		return;
+
+	for (i = 0; i < NR_CPUS; ++i) {
+		if (!cpu_possible(i))
+			continue;
+
+		cpu_buf = &cpu_buffer[i]; 
+		snprintf(buf, 6, "cpu%d", i);
+		cpudir = oprofilefs_mkdir(sb, dir, buf);
+ 
+		/* Strictly speaking access to these ulongs is racy,
+		 * but we can't simply lock them, and they are
+		 * informational only.
+		 */
+		oprofilefs_create_ro_ulong(sb, cpudir, "sample_received",
+			&cpu_buf->sample_received);
+		oprofilefs_create_ro_ulong(sb, cpudir, "sample_lost_locked",
+			&cpu_buf->sample_lost_locked);
+		oprofilefs_create_ro_ulong(sb, cpudir, "sample_lost_overflow",
+			&cpu_buf->sample_lost_overflow);
+		oprofilefs_create_ro_ulong(sb, cpudir, "sample_lost_task_exit",
+			&cpu_buf->sample_lost_task_exit);
+	}
+ 
+	oprofilefs_create_ro_atomic(sb, dir, "sample_lost_mmap_sem",
+		&oprofile_stats.sample_lost_mmap_sem);
+	oprofilefs_create_ro_atomic(sb, dir, "event_lost_overflow",
+		&oprofile_stats.event_lost_overflow);
+}
diff -Naur -X dontdiff linux-linus/drivers/oprofile/oprofile_stats.h linux/drivers/oprofile/oprofile_stats.h
--- linux-linus/drivers/oprofile/oprofile_stats.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/oprofile_stats.h	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,31 @@
+/**
+ * @file oprofile_stats.h
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon
+ */
+
+#ifndef OPROFILE_STATS_H
+#define OPROFILE_STATS_H
+
+#include <asm/atomic.h>
+ 
+struct oprofile_stat_struct {
+	atomic_t sample_lost_mmap_sem;
+	atomic_t event_lost_overflow;
+};
+
+extern struct oprofile_stat_struct oprofile_stats;
+ 
+/* reset all stats to zero */
+void oprofile_reset_stats(void);
+ 
+struct super_block;
+struct dentry;
+ 
+/* create the stats/ dir */
+void oprofile_create_stats_files(struct super_block * sb, struct dentry * root);
+
+#endif /* OPROFILE_STATS_H */
diff -Naur -X dontdiff linux-linus/drivers/oprofile/oprofilefs.c linux/drivers/oprofile/oprofilefs.c
--- linux-linus/drivers/oprofile/oprofilefs.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/oprofile/oprofilefs.c	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,306 @@
+/**
+ * @file oprofilefs.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon
+ *
+ * A simple filesystem for configuration and
+ * access of oprofile.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/fs.h>
+#include <linux/dcache.h>
+#include <linux/file.h>
+#include <linux/namei.h>
+#include <linux/oprofile.h>
+#include <asm/uaccess.h>
+
+#include "oprof.h"
+
+#define OPROFILEFS_MAGIC 0x6f70726f
+
+spinlock_t oprofilefs_lock = SPIN_LOCK_UNLOCKED;
+
+static struct inode * oprofilefs_get_inode(struct super_block * sb, int mode)
+{
+	struct inode * inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = 0;
+		inode->i_gid = 0;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	}
+	return inode;
+}
+
+
+static struct super_operations s_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode 	= generic_delete_inode,
+};
+
+#define TMPBUFSIZE 50
+
+ssize_t oprofilefs_ulong_to_user(unsigned long * val, char * buf, size_t count, loff_t * offset)
+{
+	char tmpbuf[TMPBUFSIZE];
+	size_t maxlen;
+
+	if (!count)
+		return 0;
+
+	spin_lock(&oprofilefs_lock);
+	maxlen = snprintf(tmpbuf, TMPBUFSIZE, "%lu\n", *val);
+	spin_unlock(&oprofilefs_lock);
+	if (maxlen > TMPBUFSIZE)
+		maxlen = TMPBUFSIZE;
+
+	if (*offset > maxlen)
+		return 0;
+
+	if (count > maxlen - *offset)
+		count = maxlen - *offset;
+
+	if (copy_to_user(buf, tmpbuf + *offset, count))
+		return -EFAULT;
+
+	*offset += count;
+
+	return count;
+}
+
+
+int oprofilefs_ulong_from_user(unsigned long * val, char const * buf, size_t count)
+{
+	char tmpbuf[TMPBUFSIZE];
+
+	if (!count)
+		return 0;
+
+	if (count > TMPBUFSIZE - 1)
+		return -EINVAL;
+
+	memset(tmpbuf, 0x0, TMPBUFSIZE);
+
+	if (copy_from_user(tmpbuf, buf, count))
+		return -EFAULT;
+
+	spin_lock(&oprofilefs_lock);
+	*val = simple_strtoul(tmpbuf, NULL, 10);
+	spin_unlock(&oprofilefs_lock);
+	return 0;
+}
+
+
+static ssize_t ulong_read_file(struct file * file, char * buf, size_t count, loff_t * offset)
+{
+	return oprofilefs_ulong_to_user(file->private_data, buf, count, offset);
+}
+
+
+static ssize_t ulong_write_file(struct file * file, char const * buf, size_t count, loff_t * offset)
+{
+	unsigned long * value = file->private_data;
+	int retval;
+
+	if (*offset)
+		return -EINVAL;
+
+	retval = oprofilefs_ulong_from_user(value, buf, count);
+
+	if (retval)
+		return retval;
+	return count;
+}
+
+
+static int default_open(struct inode * inode, struct file * filp)
+{
+	if (inode->u.generic_ip)
+		filp->private_data = inode->u.generic_ip;
+	return 0;
+}
+
+
+static struct file_operations ulong_fops = {
+	.read		= ulong_read_file,
+	.write		= ulong_write_file,
+	.open		= default_open,
+};
+
+
+static struct file_operations ulong_ro_fops = {
+	.read		= ulong_read_file,
+	.open		= default_open,
+};
+
+
+static struct dentry * __oprofilefs_create_file(struct super_block * sb,
+	struct dentry * root, char const * name, struct file_operations * fops)
+{
+	struct dentry * dentry;
+	struct inode * inode;
+	struct qstr qname;
+	qname.name = name;
+	qname.len = strlen(name);
+	qname.hash = full_name_hash(qname.name, qname.len);
+	dentry = d_alloc(root, &qname);
+	if (!dentry)
+		return 0;
+	inode = oprofilefs_get_inode(sb, S_IFREG | 0644);
+	if (!inode) {
+		dput(dentry);
+		return 0;
+	}
+	inode->i_fop = fops;
+	d_add(dentry, inode);
+	return dentry;
+}
+
+
+int oprofilefs_create_ulong(struct super_block * sb, struct dentry * root,
+	char const * name, unsigned long * val)
+{
+	struct dentry * d = __oprofilefs_create_file(sb, root, name, &ulong_fops);
+	if (!d)
+		return -EFAULT;
+
+	d->d_inode->u.generic_ip = val;
+	return 0;
+}
+
+
+int oprofilefs_create_ro_ulong(struct super_block * sb, struct dentry * root,
+	char const * name, unsigned long * val)
+{
+	struct dentry * d = __oprofilefs_create_file(sb, root, name, &ulong_ro_fops);
+	if (!d)
+		return -EFAULT;
+
+	d->d_inode->u.generic_ip = val;
+	return 0;
+}
+
+
+static ssize_t atomic_read_file(struct file * file, char * buf, size_t count, loff_t * offset)
+{
+	atomic_t * aval = file->private_data;
+	unsigned long val = atomic_read(aval);
+	return oprofilefs_ulong_to_user(&val, buf, count, offset);
+}
+ 
+
+static struct file_operations atomic_ro_fops = {
+	.read		= atomic_read_file,
+	.open		= default_open,
+};
+ 
+
+int oprofilefs_create_ro_atomic(struct super_block * sb, struct dentry * root,
+	char const * name, atomic_t * val)
+{
+	struct dentry * d = __oprofilefs_create_file(sb, root, name, &atomic_ro_fops);
+	if (!d)
+		return -EFAULT;
+
+	d->d_inode->u.generic_ip = val;
+	return 0;
+}
+
+ 
+int oprofilefs_create_file(struct super_block * sb, struct dentry * root,
+	char const * name, struct file_operations * fops)
+{
+	if (!__oprofilefs_create_file(sb, root, name, fops))
+		return -EFAULT;
+	return 0;
+}
+
+
+struct dentry * oprofilefs_mkdir(struct super_block * sb,
+	struct dentry * root, char const * name)
+{
+	struct dentry * dentry;
+	struct inode * inode;
+	struct qstr qname;
+	qname.name = name;
+	qname.len = strlen(name);
+	qname.hash = full_name_hash(qname.name, qname.len);
+	dentry = d_alloc(root, &qname);
+	if (!dentry)
+		return 0;
+	inode = oprofilefs_get_inode(sb, S_IFDIR | 0755);
+	if (!inode) {
+		dput(dentry);
+		return 0;
+	}
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	d_add(dentry, inode);
+	return dentry;
+}
+
+
+static int oprofilefs_fill_super(struct super_block * sb, void * data, int silent)
+{
+	struct inode * root_inode;
+	struct dentry * root_dentry;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = OPROFILEFS_MAGIC;
+	sb->s_op = &s_ops;
+
+	root_inode = oprofilefs_get_inode(sb, S_IFDIR | 0755);
+	if (!root_inode)
+		return -ENOMEM;
+	root_inode->i_op = &simple_dir_inode_operations;
+	root_inode->i_fop = &simple_dir_operations;
+	root_dentry = d_alloc_root(root_inode);
+	if (!root_dentry) {
+		iput(root_inode);
+		return -ENOMEM;
+	}
+
+	sb->s_root = root_dentry;
+
+	oprofile_create_files(sb, root_dentry);
+
+	// FIXME: verify kill_litter_super removes our dentries
+	return 0;
+}
+
+
+static struct super_block * oprofilefs_get_sb(struct file_system_type * fs_type,
+	int flags, char * dev_name, void * data)
+{
+	return get_sb_single(fs_type, flags, data, oprofilefs_fill_super);
+}
+
+
+static struct file_system_type oprofilefs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "oprofilefs",
+	.get_sb		= oprofilefs_get_sb,
+	.kill_sb	= kill_litter_super,
+};
+
+
+int __init oprofilefs_register(void)
+{
+	return register_filesystem(&oprofilefs_type);
+}
+
+
+void __exit oprofilefs_unregister(void)
+{
+	unregister_filesystem(&oprofilefs_type);
+}
diff -Naur -X dontdiff linux-linus/include/linux/oprofile.h linux/include/linux/oprofile.h
--- linux-linus/include/linux/oprofile.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/oprofile.h	Tue Oct 15 21:45:52 2002
@@ -0,0 +1,98 @@
+/**
+ * @file oprofile.h
+ *
+ * API for machine-specific interrupts to interface
+ * to oprofile.
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#ifndef OPROFILE_H
+#define OPROFILE_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+ 
+struct super_block;
+struct dentry;
+struct file_operations;
+ 
+enum oprofile_cpu {
+	OPROFILE_CPU_PPRO,
+	OPROFILE_CPU_PII,
+	OPROFILE_CPU_PIII,
+	OPROFILE_CPU_ATHLON,
+	OPROFILE_CPU_TIMER
+};
+
+/* Operations structure to be filled in */
+struct oprofile_operations {
+	/* create any necessary configuration files in the oprofile fs.
+	 * Optional. */
+	int (*create_files)(struct super_block * sb, struct dentry * root);
+	/* Do any necessary interrupt setup. Optional. */
+	int (*setup)(void);
+	/* Do any necessary interrupt shutdown. Optional. */
+	void (*shutdown)(void);
+	/* Start delivering interrupts. */
+	int (*start)(void);
+	/* Stop delivering interrupts. */
+	void (*stop)(void);
+};
+
+/**
+ * One-time initialisation. *ops must be set to a filled-in
+ * operations structure. oprofile_cpu_type must be set.
+ * Return 0 on success.
+ */
+int oprofile_arch_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu);
+ 
+/**
+ * Add a sample. This may be called from any context. Pass
+ * smp_processor_id() as cpu.
+ */
+extern void FASTCALL(oprofile_add_sample(unsigned long eip, unsigned long event, int cpu));
+
+/**
+ * Create a file of the given name as a child of the given root, with
+ * the specified file operations.
+ */
+int oprofilefs_create_file(struct super_block * sb, struct dentry * root,
+	char const * name, struct file_operations * fops);
+ 
+/** Create a file for read/write access to an unsigned long. */
+int oprofilefs_create_ulong(struct super_block * sb, struct dentry * root,
+	char const * name, ulong * val);
+ 
+/** Create a file for read-only access to an unsigned long. */
+int oprofilefs_create_ro_ulong(struct super_block * sb, struct dentry * root,
+	char const * name, ulong * val);
+ 
+/** Create a file for read-only access to an atomic_t. */
+int oprofilefs_create_ro_atomic(struct super_block * sb, struct dentry * root,
+	char const * name, atomic_t * val);
+ 
+/** create a directory */
+struct dentry * oprofilefs_mkdir(struct super_block * sb, struct dentry * root,
+	char const * name);
+
+/**
+ * Convert an unsigned long value into ASCII and copy it to the user buffer @buf,
+ * updating *offset appropriately. Returns bytes written or -EFAULT.
+ */
+ssize_t oprofilefs_ulong_to_user(unsigned long * val, char * buf, size_t count, loff_t * offset);
+
+/**
+ * Read an ASCII string for a number from a userspace buffer and fill *val on success.
+ * Returns 0 on success, < 0 on error.
+ */
+int oprofilefs_ulong_from_user(unsigned long * val, char const * buf, size_t count);
+
+/** lock for read/write safety */
+extern spinlock_t oprofilefs_lock;
+ 
+#endif /* OPROFILE_H */

