Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbUKHQUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUKHQUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUKHQUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:20:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60354 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261866AbUKHOfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:02 -0500
Date: Mon, 8 Nov 2004 14:34:18 GMT
Message-Id: <200411081434.iA8EYImg023537@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 8/20] FRV: Fujitsu FR-V CPU arch implementation part 6
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patches provides part 6 of an architecture implementation
for the Fujitsu FR-V CPU series, configurably as Linux or uClinux.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-arch_6-2610rc1mm3.diff
 sys_frv.c |  210 ++++++++++++++++++++++++++++++
 sysctl.c  |  206 +++++++++++++++++++++++++++++
 time.c    |  234 +++++++++++++++++++++++++++++++++
 traps.c   |  431 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 uaccess.c |   95 +++++++++++++
 5 files changed, 1176 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/sysctl.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/sysctl.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/sysctl.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/sysctl.c	2004-11-05 14:13:03.233552359 +0000
@@ -0,0 +1,206 @@
+/* sysctl.c: implementation of /proc/sys files relating to FRV specifically
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/sysctl.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+
+static const char frv_cache_wback[] = "wback";
+static const char frv_cache_wthru[] = "wthru";
+
+static void frv_change_dcache_mode(unsigned long newmode)
+{
+	unsigned long flags, hsr0;
+
+	local_irq_save(flags);
+
+	hsr0 = __get_HSR(0);
+	hsr0 &= ~HSR0_DCE;
+	__set_HSR(0, hsr0);
+
+	asm volatile("	dcef	@(gr0,gr0),#1	\n"
+		     "	membar			\n"
+		     : : : "memory"
+		     );
+
+	hsr0 = (hsr0 & ~HSR0_CBM) | newmode;
+	__set_HSR(0, hsr0);
+	hsr0 |= HSR0_DCE;
+	__set_HSR(0, hsr0);
+
+	local_irq_restore(flags);
+
+	//printk("HSR0 now %08lx\n", hsr0);
+}
+
+/*****************************************************************************/
+/*
+ * handle requests to dynamically switch the write caching mode delivered by /proc
+ */
+static int procctl_frv_cachemode(ctl_table *table, int write, struct file *filp,
+				 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	unsigned long hsr0;
+	char buff[8];
+	int len;
+
+	len = *lenp;
+
+	if (write) {
+		/* potential state change */
+		if (len <= 1 || len > sizeof(buff) - 1)
+			return -EINVAL;
+
+		if (copy_from_user(buff, buffer, len) != 0)
+			return -EFAULT;
+
+		if (buff[len - 1] == '\n')
+			buff[len - 1] = '\0';
+		else
+			buff[len] = '\0';
+
+		if (strcmp(buff, frv_cache_wback) == 0) {
+			/* switch dcache into write-back mode */
+			frv_change_dcache_mode(HSR0_CBM_COPY_BACK);
+			return 0;
+		}
+
+		if (strcmp(buff, frv_cache_wthru) == 0) {
+			/* switch dcache into write-through mode */
+			frv_change_dcache_mode(HSR0_CBM_WRITE_THRU);
+			return 0;
+		}
+
+		return -EINVAL;
+	}
+
+	/* read the state */
+	if (filp->f_pos > 0) {
+		*lenp = 0;
+		return 0;
+	}
+
+	hsr0 = __get_HSR(0);
+	switch (hsr0 & HSR0_CBM) {
+	case HSR0_CBM_WRITE_THRU:
+		memcpy(buff, frv_cache_wthru, sizeof(frv_cache_wthru) - 1);
+		buff[sizeof(frv_cache_wthru) - 1] = '\n';
+		len = sizeof(frv_cache_wthru);
+		break;
+	default:
+		memcpy(buff, frv_cache_wback, sizeof(frv_cache_wback) - 1);
+		buff[sizeof(frv_cache_wback) - 1] = '\n';
+		len = sizeof(frv_cache_wback);
+		break;
+	}
+
+	if (len > *lenp)
+		len = *lenp;
+
+	if (copy_to_user(buffer, buff, len) != 0)
+		return -EFAULT;
+
+	*lenp = len;
+	filp->f_pos = len;
+	return 0;
+
+} /* end procctl_frv_cachemode() */
+
+/*****************************************************************************/
+/*
+ * permit the mm_struct the nominated process is using have its MMU context ID pinned
+ */
+#ifdef CONFIG_MMU
+static int procctl_frv_pin_cxnr(ctl_table *table, int write, struct file *filp,
+				void *buffer, size_t *lenp, loff_t *ppos)
+{
+	pid_t pid;
+	char buff[16], *p;
+	int len;
+
+	len = *lenp;
+
+	if (write) {
+		/* potential state change */
+		if (len <= 1 || len > sizeof(buff) - 1)
+			return -EINVAL;
+
+		if (copy_from_user(buff, buffer, len) != 0)
+			return -EFAULT;
+
+		if (buff[len - 1] == '\n')
+			buff[len - 1] = '\0';
+		else
+			buff[len] = '\0';
+
+		pid = simple_strtoul(buff, &p, 10);
+		if (*p)
+			return -EINVAL;
+
+		return cxn_pin_by_pid(pid);
+	}
+
+	/* read the currently pinned CXN */
+	if (filp->f_pos > 0) {
+		*lenp = 0;
+		return 0;
+	}
+
+	len = snprintf(buff, sizeof(buff), "%d\n", cxn_pinned);
+	if (len > *lenp)
+		len = *lenp;
+
+	if (copy_to_user(buffer, buff, len) != 0)
+		return -EFAULT;
+
+	*lenp = len;
+	filp->f_pos = len;
+	return 0;
+
+} /* end procctl_frv_pin_cxnr() */
+#endif
+
+/*
+ * FR-V specific sysctls
+ */
+static struct ctl_table frv_table[] =
+{
+	{ 1, "cache-mode",	NULL, 0, 0644, NULL, &procctl_frv_cachemode },
+#ifdef CONFIG_MMU
+	{ 2, "pin-cxnr",	NULL, 0, 0644, NULL, &procctl_frv_pin_cxnr },
+#endif
+	{ 0 }
+};
+
+/*
+ * Use a temporary sysctl number. Horrid, but will be cleaned up in 2.6
+ * when all the PM interfaces exist nicely.
+ */
+#define CTL_FRV 9898
+static struct ctl_table frv_dir_table[] =
+{
+	{CTL_FRV, "frv", NULL, 0, 0555, frv_table},
+	{0}
+};
+
+/*
+ * Initialize power interface
+ */
+static int __init frv_sysctl_init(void)
+{
+	register_sysctl_table(frv_dir_table, 1);
+	return 0;
+}
+
+__initcall(frv_sysctl_init);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/sys_frv.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/sys_frv.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/sys_frv.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/sys_frv.c	2004-11-05 14:13:03.237552021 +0000
@@ -0,0 +1,210 @@
+/*
+ * linux/arch/frvnommu/kernel/sys_frv.c
+ *
+ * This file contains various random system calls that
+ * have a non-standard calling sequence on the Linux/FRV
+ * platform.
+ */
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/sem.h>
+#include <linux/msg.h>
+#include <linux/shm.h>
+#include <linux/stat.h>
+#include <linux/mman.h>
+#include <linux/file.h>
+#include <linux/utsname.h>
+#include <linux/syscalls.h>
+
+#include <asm/setup.h>
+#include <asm/uaccess.h>
+#include <asm/ipc.h>
+
+/*
+ * sys_pipe() is the normal C calling standard for creating
+ * a pipe. It's not the way unix traditionally does this, though.
+ */
+asmlinkage long sys_pipe(unsigned long * fildes)
+{
+	int fd[2];
+	int error;
+
+	error = do_pipe(fd);
+	if (!error) {
+		if (copy_to_user(fildes, fd, 2*sizeof(int)))
+			error = -EFAULT;
+	}
+	return error;
+}
+
+asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
+			  unsigned long prot, unsigned long flags,
+			  unsigned long fd, unsigned long pgoff)
+{
+	int error = -EBADF;
+	struct file * file = NULL;
+
+	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	if (!(flags & MAP_ANONYMOUS)) {
+		file = fget(fd);
+		if (!file)
+			goto out;
+	}
+
+	/* As with sparc32, make sure the shift for mmap2 is constant
+	   (12), no matter what PAGE_SIZE we have.... */
+
+	/* But unlike sparc32, don't just silently break if we're
+	   trying to map something we can't */
+	if (pgoff & ((1<<(PAGE_SHIFT-12))-1))
+		return -EINVAL;
+
+	pgoff >>= (PAGE_SHIFT - 12);
+
+	down_write(&current->mm->mmap_sem);
+	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	up_write(&current->mm->mmap_sem);
+
+	if (file)
+		fput(file);
+out:
+	return error;
+}
+
+#if 0 /* DAVIDM - do we want this */
+struct mmap_arg_struct64 {
+	__u32 addr;
+	__u32 len;
+	__u32 prot;
+	__u32 flags;
+	__u64 offset; /* 64 bits */
+	__u32 fd;
+};
+
+asmlinkage long sys_mmap64(struct mmap_arg_struct64 *arg)
+{
+	int error = -EFAULT;
+	struct file * file = NULL;
+	struct mmap_arg_struct64 a;
+	unsigned long pgoff;
+
+	if (copy_from_user(&a, arg, sizeof(a)))
+		return -EFAULT;
+
+	if ((long)a.offset & ~PAGE_MASK)
+		return -EINVAL;
+
+	pgoff = a.offset >> PAGE_SHIFT;
+	if ((a.offset >> PAGE_SHIFT) != pgoff)
+		return -EINVAL;
+
+	if (!(a.flags & MAP_ANONYMOUS)) {
+		error = -EBADF;
+		file = fget(a.fd);
+		if (!file)
+			goto out;
+	}
+	a.flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+
+	down_write(&current->mm->mmap_sem);
+	error = do_mmap_pgoff(file, a.addr, a.len, a.prot, a.flags, pgoff);
+	up_write(&current->mm->mmap_sem);
+	if (file)
+		fput(file);
+out:
+	return error;
+}
+#endif
+
+/*
+ * sys_ipc() is the de-multiplexer for the SysV IPC calls..
+ *
+ * This is really horribly ugly.
+ */
+asmlinkage long sys_ipc(unsigned long call,
+			unsigned long first,
+			unsigned long second,
+			unsigned long third,
+			void __user *ptr,
+			unsigned long fifth)
+{
+	int version, ret;
+
+	version = call >> 16; /* hack for backward compatibility */
+	call &= 0xffff;
+
+	switch (call) {
+	case SEMOP:
+		return sys_semtimedop(first, (struct sembuf __user *)ptr, second, NULL);
+	case SEMTIMEDOP:
+		return sys_semtimedop(first, (struct sembuf __user *)ptr, second,
+				      (const struct timespec __user *)fifth);
+
+	case SEMGET:
+		return sys_semget (first, second, third);
+	case SEMCTL: {
+		union semun fourth;
+		if (!ptr)
+			return -EINVAL;
+		if (get_user(fourth.__pad, (void * __user *) ptr))
+			return -EFAULT;
+		return sys_semctl (first, second, third, fourth);
+	}
+
+	case MSGSND:
+		return sys_msgsnd (first, (struct msgbuf __user *) ptr, 
+				   second, third);
+	case MSGRCV:
+		switch (version) {
+		case 0: {
+			struct ipc_kludge tmp;
+			if (!ptr)
+				return -EINVAL;
+			
+			if (copy_from_user(&tmp,
+					   (struct ipc_kludge __user *) ptr, 
+					   sizeof (tmp)))
+				return -EFAULT;
+			return sys_msgrcv (first, tmp.msgp, second,
+					   tmp.msgtyp, third);
+		}
+		default:
+			return sys_msgrcv (first,
+					   (struct msgbuf __user *) ptr,
+					   second, fifth, third);
+		}
+	case MSGGET:
+		return sys_msgget ((key_t) first, second);
+	case MSGCTL:
+		return sys_msgctl (first, second, (struct msqid_ds __user *) ptr);
+
+	case SHMAT:
+		switch (version) {
+		default: {
+			ulong raddr;
+			ret = do_shmat (first, (char __user *) ptr, second, &raddr);
+			if (ret)
+				return ret;
+			return put_user (raddr, (ulong __user *) third);
+		}
+		case 1:	/* iBCS2 emulator entry point */
+			if (!segment_eq(get_fs(), get_ds()))
+				return -EINVAL;
+			/* The "(ulong *) third" is valid _only_ because of the kernel segment thing */
+			return do_shmat (first, (char __user *) ptr, second, (ulong *) third);
+		}
+	case SHMDT: 
+		return sys_shmdt ((char __user *)ptr);
+	case SHMGET:
+		return sys_shmget (first, second, third);
+	case SHMCTL:
+		return sys_shmctl (first, second,
+				   (struct shmid_ds __user *) ptr);
+	default:
+		return -ENOSYS;
+	}
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/time.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/time.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/time.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/time.c	2004-11-05 14:13:03.242551599 +0000
@@ -0,0 +1,234 @@
+/*
+ *  linux/arch/m68k/kernel/time.c
+ *
+ *  Copyright (C) 1991, 1992, 1995  Linus Torvalds
+ *
+ * This file contains the m68k-specific time handling details.
+ * Most of the stuff is located in the machine specific files.
+ *
+ * 1997-09-10	Updated NTP code according to technical memorandum Jan '96
+ *		"A Kernel Model for Precision Timekeeping" by Dave Mills
+ */
+
+#include <linux/config.h> /* CONFIG_HEARTBEAT */
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <linux/profile.h>
+#include <linux/irq.h>
+#include <linux/mm.h>
+
+#include <asm/io.h>
+#include <asm/timer-regs.h>
+#include <asm/mb-regs.h>
+#include <asm/mb86943a.h>
+#include <asm/irq-routing.h>
+
+#include <linux/timex.h>
+
+#define TICK_SIZE (tick_nsec / 1000)
+
+extern unsigned long wall_jiffies;
+
+u64 jiffies_64 = INITIAL_JIFFIES;
+EXPORT_SYMBOL(jiffies_64);
+
+unsigned long __nongprelbss __clkin_clock_speed_HZ;
+unsigned long __nongprelbss __ext_bus_clock_speed_HZ;
+unsigned long __nongprelbss __res_bus_clock_speed_HZ;
+unsigned long __nongprelbss __sdram_clock_speed_HZ;
+unsigned long __nongprelbss __core_bus_clock_speed_HZ;
+unsigned long __nongprelbss __core_clock_speed_HZ;
+unsigned long __nongprelbss __dsu_clock_speed_HZ;
+unsigned long __nongprelbss __serial_clock_speed_HZ;
+unsigned long __delay_loops_MHz;
+
+static irqreturn_t timer_interrupt(int irq, void *dummy, struct pt_regs *regs);
+
+static struct irqaction timer_irq  = {
+	timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL
+};
+
+static inline int set_rtc_mmss(unsigned long nowtime)
+{
+	return -1;
+}
+
+/*
+ * timer_interrupt() needs to keep up the real-time clock,
+ * as well as call the "do_timer()" routine every clocktick
+ */
+static irqreturn_t timer_interrupt(int irq, void *dummy, struct pt_regs * regs)
+{
+	/* last time the cmos clock got updated */
+	static long last_rtc_update = 0;
+
+	/*
+	 * Here we are in the timer irq handler. We just have irqs locally
+	 * disabled but we don't know if the timer_bh is running on the other
+	 * CPU. We need to avoid to SMP race with it. NOTE: we don' t need
+	 * the irq version of write_lock because as just said we have irq
+	 * locally disabled. -arca
+	 */
+	write_seqlock(&xtime_lock);
+
+	do_timer(regs);
+	update_process_times(user_mode(regs));
+	profile_tick(CPU_PROFILING, regs);
+
+	/*
+	 * If we have an externally synchronized Linux clock, then update
+	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
+	 * called as close as possible to 500 ms before the new second starts.
+	 */
+	if ((time_status & STA_UNSYNC) == 0 &&
+	    xtime.tv_sec > last_rtc_update + 660 &&
+	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
+	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2
+	    ) {
+		if (set_rtc_mmss(xtime.tv_sec) == 0)
+			last_rtc_update = xtime.tv_sec;
+		else
+			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
+	}
+
+#ifdef CONFIG_HEARTBEAT
+	static unsigned short n;
+	n++;
+	__set_LEDS(n);
+#endif /* CONFIG_HEARTBEAT */
+
+	write_sequnlock(&xtime_lock);
+	return IRQ_HANDLED;
+}
+
+void time_divisor_init(void)
+{
+	unsigned short base, pre, prediv;
+
+	/* set the scheduling timer going */
+	pre = 1;
+	prediv = 4;
+	base = __res_bus_clock_speed_HZ / pre / HZ / (1 << prediv);
+
+	__set_TPRV(pre);
+	__set_TxCKSL_DATA(0, prediv);
+	__set_TCTR(TCTR_SC_CTR0 | TCTR_RL_RW_LH8 | TCTR_MODE_2);
+	__set_TCSR_DATA(0, base & 0xff);
+	__set_TCSR_DATA(0, base >> 8);
+}
+
+void time_init(void)
+{
+	unsigned int year, mon, day, hour, min, sec;
+
+	extern void arch_gettod(int *year, int *mon, int *day, int *hour, int *min, int *sec);
+
+	/* FIX by dqg : Set to zero for platforms that don't have tod */
+	/* without this time is undefined and can overflow time_t, causing  */
+	/* very stange errors */
+	year = 1980;
+	mon = day = 1;
+	hour = min = sec = 0;
+	arch_gettod (&year, &mon, &day, &hour, &min, &sec);
+
+	if ((year += 1900) < 1970)
+		year += 100;
+	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
+	xtime.tv_nsec = 0;
+
+	/* install scheduling interrupt handler */
+	setup_irq(IRQ_CPU_TIMER0, &timer_irq);
+
+	time_divisor_init();
+}
+
+/*
+ * This version of gettimeofday has near microsecond resolution.
+ */
+void do_gettimeofday(struct timeval *tv)
+{
+	unsigned long seq;
+	unsigned long usec, sec;
+	unsigned long max_ntp_tick;
+
+	do {
+		unsigned long lost;
+
+		seq = read_seqbegin(&xtime_lock);
+
+		usec = 0;
+		lost = jiffies - wall_jiffies;
+
+		/*
+		 * If time_adjust is negative then NTP is slowing the clock
+		 * so make sure not to go into next possible interval.
+		 * Better to lose some accuracy than have time go backwards..
+		 */
+		if (unlikely(time_adjust < 0)) {
+			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
+			usec = min(usec, max_ntp_tick);
+
+			if (lost)
+				usec += lost * max_ntp_tick;
+		}
+		else if (unlikely(lost))
+			usec += lost * (USEC_PER_SEC / HZ);
+
+		sec = xtime.tv_sec;
+		usec += (xtime.tv_nsec / 1000);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	while (usec >= 1000000) {
+		usec -= 1000000;
+		sec++;
+	}
+
+	tv->tv_sec = sec;
+	tv->tv_usec = usec;
+}
+
+int do_settimeofday(struct timespec *tv)
+{
+	time_t wtm_sec, sec = tv->tv_sec;
+	long wtm_nsec, nsec = tv->tv_nsec;
+
+	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
+		return -EINVAL;
+
+	write_seqlock_irq(&xtime_lock);
+	/*
+	 * This is revolting. We need to set "xtime" correctly. However, the
+	 * value in this location is the value at the most recent update of
+	 * wall time.  Discover what correction gettimeofday() would have
+	 * made, and then undo it!
+	 */
+	nsec -= 0 * NSEC_PER_USEC;
+	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
+
+	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
+	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
+
+	set_normalized_timespec(&xtime, sec, nsec);
+	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
+
+	time_adjust = 0;		/* stop active adjtime() */
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
+	write_sequnlock_irq(&xtime_lock);
+	clock_was_set();
+	return 0;
+}
+
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ */
+unsigned long long sched_clock(void)
+{
+	return jiffies_64 * (1000000000 / HZ);
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/traps.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/traps.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/traps.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/traps.c	2004-11-05 14:13:03.247551176 +0000
@@ -0,0 +1,431 @@
+/* traps.c: high-level exception handler for FR-V
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/types.h>
+#include <linux/user.h>
+#include <linux/string.h>
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+#include <asm/setup.h>
+#include <asm/fpu.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+#include <asm/pgtable.h>
+#include <asm/siginfo.h>
+#include <asm/unaligned.h>
+
+void show_backtrace(struct pt_regs *, unsigned long);
+
+extern asmlinkage void __break_hijack_kernel_event(void);
+
+/*****************************************************************************/
+/*
+ * instruction access error
+ */
+asmlinkage void insn_access_error(unsigned long esfr1, unsigned long epcr0, unsigned long esr0)
+{
+	siginfo_t info;
+
+	die_if_kernel("-- Insn Access Error --\n"
+		      "EPCR0 : %08lx\n"
+		      "ESR0  : %08lx\n",
+		      epcr0, esr0);
+
+	info.si_signo	= SIGSEGV;
+	info.si_code	= SEGV_ACCERR;
+	info.si_errno	= 0;
+	info.si_addr	= (void *) ((epcr0 & EPCR0_V) ? (epcr0 & EPCR0_PC) : __frame->pc);
+
+	force_sig_info(info.si_signo, &info, current);
+} /* end insn_access_error() */
+
+/*****************************************************************************/
+/*
+ * handler for:
+ * - illegal instruction
+ * - privileged instruction
+ * - unsupported trap
+ * - debug exceptions
+ */
+asmlinkage void illegal_instruction(unsigned long esfr1, unsigned long epcr0, unsigned long esr0)
+{
+	siginfo_t info;
+
+	die_if_kernel("-- Illegal Instruction --\n"
+		      "EPCR0 : %08lx\n"
+		      "ESR0  : %08lx\n"
+		      "ESFR1 : %08lx\n",
+		      epcr0, esr0, esfr1);
+
+	info.si_errno	= 0;
+	info.si_addr	= (void *) ((epcr0 & EPCR0_PC) ? (epcr0 & EPCR0_PC) : __frame->pc);
+
+	switch (__frame->tbr & TBR_TT) {
+	case TBR_TT_ILLEGAL_INSTR:
+		info.si_signo	= SIGILL;
+		info.si_code	= ILL_ILLOPC;
+		break;
+	case TBR_TT_PRIV_INSTR:
+		info.si_signo	= SIGILL;
+		info.si_code	= ILL_PRVOPC;
+		break;
+	case TBR_TT_TRAP2 ... TBR_TT_TRAP126:
+		info.si_signo	= SIGILL;
+		info.si_code	= ILL_ILLTRP;
+		break;
+	/* GDB uses "tira gr0, #1" as a breakpoint instruction.  */
+	case TBR_TT_TRAP1:
+	case TBR_TT_BREAK:
+		info.si_signo	= SIGTRAP;
+		info.si_code	=
+			(__frame->__status & REG__STATUS_STEPPED) ? TRAP_TRACE : TRAP_BRKPT;
+		break;
+	}
+
+	force_sig_info(info.si_signo, &info, current);
+} /* end illegal_instruction() */
+
+/*****************************************************************************/
+/*
+ * 
+ */
+asmlinkage void media_exception(unsigned long msr0, unsigned long msr1)
+{
+	siginfo_t info;
+
+	die_if_kernel("-- Media Exception --\n"
+		      "MSR0 : %08lx\n"
+		      "MSR1 : %08lx\n",
+		      msr0, msr1);
+
+	info.si_signo	= SIGFPE;
+	info.si_code	= FPE_MDAOVF;
+	info.si_errno	= 0;
+	info.si_addr	= (void *) __frame->pc;
+
+	force_sig_info(info.si_signo, &info, current);
+} /* end media_exception() */
+
+/*****************************************************************************/
+/*
+ * instruction or data access exception
+ */
+asmlinkage void memory_access_exception(unsigned long esr0,
+					unsigned long ear0,
+					unsigned long epcr0)
+{
+	siginfo_t info;
+
+#ifdef CONFIG_MMU
+	unsigned long fixup;
+
+	if ((esr0 & ESRx_EC) == ESRx_EC_DATA_ACCESS)
+		if (handle_misalignment(esr0, ear0, epcr0) == 0)
+			return;
+
+	if ((fixup = search_exception_table(__frame->pc)) != 0) {
+		__frame->pc = fixup;
+		return;
+	}
+#endif
+
+	die_if_kernel("-- Memory Access Exception --\n"
+		      "ESR0  : %08lx\n"
+		      "EAR0  : %08lx\n"
+		      "EPCR0 : %08lx\n",
+		      esr0, ear0, epcr0);
+
+	info.si_signo	= SIGSEGV;
+	info.si_code	= SEGV_ACCERR;
+	info.si_errno	= 0;
+	info.si_addr	= NULL;
+
+	if ((esr0 & (ESRx_VALID | ESR0_EAV)) == (ESRx_VALID | ESR0_EAV))
+		info.si_addr = (void *) ear0;
+
+	force_sig_info(info.si_signo, &info, current);
+
+} /* end memory_access_exception() */
+
+/*****************************************************************************/
+/*
+ * data access error
+ * - double-word data load from CPU control area (0xFExxxxxx)
+ * - read performed on inactive or self-refreshing SDRAM
+ * - error notification from slave device
+ * - misaligned address
+ * - access to out of bounds memory region
+ * - user mode accessing privileged memory region
+ * - write to R/O memory region
+ */
+asmlinkage void data_access_error(unsigned long esfr1, unsigned long esr15, unsigned long ear15)
+{
+	siginfo_t info;
+
+	die_if_kernel("-- Data Access Error --\n"
+		      "ESR15 : %08lx\n"
+		      "EAR15 : %08lx\n",
+		      esr15, ear15);
+
+	info.si_signo	= SIGSEGV;
+	info.si_code	= SEGV_ACCERR;
+	info.si_errno	= 0;
+	info.si_addr	= (void *)
+		(((esr15 & (ESRx_VALID|ESR15_EAV)) == (ESRx_VALID|ESR15_EAV)) ? ear15 : 0);
+
+	force_sig_info(info.si_signo, &info, current);
+} /* end data_access_error() */
+
+/*****************************************************************************/
+/*
+ * data store error - should only happen if accessing inactive or self-refreshing SDRAM
+ */
+asmlinkage void data_store_error(unsigned long esfr1, unsigned long esr15)
+{
+	die_if_kernel("-- Data Store Error --\n"
+		      "ESR15 : %08lx\n",
+		      esr15);
+	BUG();
+} /* end data_store_error() */
+
+/*****************************************************************************/
+/*
+ * 
+ */
+asmlinkage void division_exception(unsigned long esfr1, unsigned long esr0, unsigned long isr)
+{
+	siginfo_t info;
+
+	die_if_kernel("-- Division Exception --\n"
+		      "ESR0 : %08lx\n"
+		      "ISR  : %08lx\n",
+		      esr0, isr);
+
+	info.si_signo	= SIGFPE;
+	info.si_code	= FPE_INTDIV;
+	info.si_errno	= 0;
+	info.si_addr	= (void *) __frame->pc;
+
+	force_sig_info(info.si_signo, &info, current);
+} /* end division_exception() */
+
+/*****************************************************************************/
+/*
+ * 
+ */
+asmlinkage void compound_exception(unsigned long esfr1,
+				   unsigned long esr0, unsigned long esr14, unsigned long esr15,
+				   unsigned long msr0, unsigned long msr1)
+{
+	die_if_kernel("-- Compound Exception --\n"
+		      "ESR0  : %08lx\n"
+		      "ESR15 : %08lx\n"
+		      "ESR15 : %08lx\n"
+		      "MSR0  : %08lx\n"
+		      "MSR1  : %08lx\n",
+		      esr0, esr14, esr15, msr0, msr1);
+	BUG();
+} /* end compound_exception() */
+
+/*****************************************************************************/
+/*
+ * The architecture-independent backtrace generator
+ */
+void dump_stack(void)
+{
+	show_stack(NULL, NULL);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+}
+
+void show_trace_task(struct task_struct *tsk)
+{
+	printk("CONTEXT: stack=0x%lx frame=0x%p LR=0x%lx RET=0x%lx\n",
+	       tsk->thread.sp, tsk->thread.frame, tsk->thread.lr, tsk->thread.sched_lr);
+}
+
+static const char *regnames[] = {
+	"PSR ", "ISR ", "CCR ", "CCCR",
+	"LR  ", "LCR ", "PC  ", "_stt",
+	"sys ", "GR8*", "GNE0", "GNE1",
+	"IACH", "IACL",
+	"TBR ", "SP  ", "FP  ", "GR3 ",
+	"GR4 ", "GR5 ", "GR6 ", "GR7 ",
+	"GR8 ", "GR9 ", "GR10", "GR11",
+	"GR12", "GR13", "GR14", "GR15",
+	"GR16", "GR17", "GR18", "GR19",
+	"GR20", "GR21", "GR22", "GR23",
+	"GR24", "GR25", "GR26", "GR27",
+	"EFRM", "CURR", "GR30", "BFRM"
+};
+
+void show_regs(struct pt_regs *regs)
+{
+	uint32_t *reg;
+	int loop;
+
+	printk("\n");
+
+	printk("Frame: @%08x [%s]\n",
+	       (uint32_t) regs,
+	       regs->psr & PSR_S ? "kernel" : "user");
+
+	reg = (uint32_t *) regs;
+	for (loop = 0; loop < REG__END; loop++) {
+		printk("%s %08x", regnames[loop + 0], reg[loop + 0]);
+
+		if (loop == REG__END - 1 || loop % 5 == 4)
+			printk("\n");
+		else
+			printk(" | ");
+	}
+
+	printk("Process %s (pid: %d)\n", current->comm, current->pid);
+}
+
+void die_if_kernel(const char *str, ...)
+{
+	char buffer[256];
+	va_list va;
+
+	if (user_mode(__frame))
+		return;
+
+	va_start(va, str);
+	vsprintf(buffer, str, va);
+	va_end(va);
+
+	console_verbose();
+	printk("\n===================================\n");
+	printk("%s\n", buffer);
+	show_backtrace(__frame, 0);
+
+	__break_hijack_kernel_event();
+	do_exit(SIGSEGV);
+}
+
+/*****************************************************************************/
+/*
+ * dump the contents of an exception frame
+ */
+static void show_backtrace_regs(struct pt_regs *frame)
+{
+	uint32_t *reg;
+	int loop;
+
+	/* print the registers for this frame */
+	printk("<-- %s Frame: @%p -->\n",
+	       frame->psr & PSR_S ? "Kernel Mode" : "User Mode",
+	       frame);
+
+	reg = (uint32_t *) frame;
+	for (loop = 0; loop < REG__END; loop++) {
+		printk("%s %08x", regnames[loop + 0], reg[loop + 0]);
+
+		if (loop == REG__END - 1 || loop % 5 == 4)
+			printk("\n");
+		else
+			printk(" | ");
+	}
+
+	printk("--------\n");
+} /* end show_backtrace_regs() */
+
+/*****************************************************************************/
+/*
+ * generate a backtrace of the kernel stack
+ */
+void show_backtrace(struct pt_regs *frame, unsigned long sp)
+{
+	struct pt_regs *frame0;
+	unsigned long tos = 0, stop = 0, base;
+	int format;
+
+	base = ((((unsigned long) frame) + 8191) & ~8191) - sizeof(struct user_context);
+	frame0 = (struct pt_regs *) base;
+
+	if (sp) {
+		tos = sp;
+		stop = (unsigned long) frame;
+	}
+
+	printk("\nProcess %s (pid: %d)\n\n", current->comm, current->pid);
+
+	for (;;) {
+		/* dump stack segment between frames */
+		//printk("%08lx -> %08lx\n", tos, stop);
+		format = 0;
+		while (tos < stop) {
+			if (format == 0)
+				printk(" %04lx :", tos & 0xffff);
+
+			printk(" %08lx", *(unsigned long *) tos);
+
+			tos += 4;
+			format++;
+			if (format == 8) {
+				printk("\n");
+				format = 0;
+			}
+		}
+
+		if (format > 0)
+			printk("\n");
+
+		/* dump frame 0 outside of the loop */
+		if (frame == frame0)
+			break;
+
+		tos = frame->sp;
+		if (((unsigned long) frame) + sizeof(*frame) != tos) {
+			printk("-- TOS %08lx does not follow frame %p --\n",
+			       tos, frame);
+			break;
+		}
+
+		show_backtrace_regs(frame);
+
+		/* dump the stack between this frame and the next */
+		stop = (unsigned long) frame->next_frame;
+		if (stop != base &&
+		    (stop < tos ||
+		     stop > base ||
+		     (stop < base && stop + sizeof(*frame) > base) ||
+		     stop & 3)) {
+			printk("-- next_frame %08lx is invalid (range %08lx-%08lx) --\n",
+			       stop, tos, base);
+			break;
+		}
+
+		/* move to next frame */
+		frame = frame->next_frame;
+	}
+
+	/* we can always dump frame 0, even if the rest of the stack is corrupt */
+	show_backtrace_regs(frame0);
+
+} /* end show_backtrace() */
+
+/*****************************************************************************/
+/*
+ * initialise traps 
+ */
+void __init trap_init (void)
+{
+} /* end trap_init() */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/uaccess.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/uaccess.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/uaccess.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/uaccess.c	2004-11-05 14:13:03.254550585 +0000
@@ -0,0 +1,95 @@
+/* uaccess.c: userspace access functions
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/mm.h>
+#include <asm/uaccess.h>
+
+/*****************************************************************************/
+/*
+ * copy a null terminated string from userspace
+ */
+long strncpy_from_user(char *dst, const char *src, long count)
+{
+	unsigned long max;
+	char *p, ch;
+	long err = -EFAULT;
+
+	if (count < 0)
+		BUG();
+
+	p = dst;
+
+#ifndef CONFIG_MMU
+	if ((unsigned long) src < memory_start)
+		goto error;
+#endif
+
+	if ((unsigned long) src >= get_addr_limit())
+		goto error;
+
+	max = get_addr_limit() - (unsigned long) src;
+	if ((unsigned long) count > max) {
+		memset(dst + max, 0, count - max);
+		count = max;
+	}
+	
+	err = 0;
+	for (; count > 0; count--, p++, src++) {
+		__get_user_asm(err, ch, src, "ub", "=r");
+		if (err < 0)
+			goto error;
+		if (!ch)
+			break;
+		*p = ch;
+	}
+
+	err = p - dst; /* return length excluding NUL */
+
+ error:
+	if (count > 0)
+		memset(p, 0, count); /* clear remainder of buffer [security] */
+
+	return err;
+} /* end strncpy_from_user() */
+
+/*****************************************************************************/
+/*
+ * Return the size of a string (including the ending 0)
+ *
+ * Return 0 on exception, a value greater than N if too long
+ */
+long strnlen_user(const char *src, long count)
+{
+	const char *p;
+	long err = 0;
+	char ch;
+
+	if (count < 0)
+		BUG();
+
+#ifndef CONFIG_MMU
+	if ((unsigned long) src < memory_start)
+		return 0;
+#endif
+
+	if ((unsigned long) src >= get_addr_limit())
+		return 0;
+
+	for (p = src; count > 0; count--, p++) {
+		__get_user_asm(err, ch, p, "ub", "=r");
+		if (err < 0)
+			return 0;
+		if (!ch)
+			break;
+	}
+
+	return p - src + 1; /* return length including NUL */
+} /* end strnlen_user() */
