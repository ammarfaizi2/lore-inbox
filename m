Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315853AbSEWCsU>; Wed, 22 May 2002 22:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315858AbSEWCsT>; Wed, 22 May 2002 22:48:19 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:51897 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S315853AbSEWCsF>;
	Wed, 22 May 2002 22:48:05 -0400
Message-ID: <3CEC5861.6050607@acm.org>
Date: Wed, 22 May 2002 21:48:01 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Patch] Accurate CPU utilization patch
Content-Type: multipart/mixed;
 boundary="------------020904090207000704070500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904090207000704070500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The current system of measuring CPU used by a process/the system is 
crude (at best).  Basically, if you get a timer tick when your 
application is running, then you get a whole timer tick's work of CPU 
added to your process's usage.  That's actually just fine for most 
applications, but some applications need tight bounds and more accurate 
accounting.  This patch addresses this concern.

This patch adds a configuration option that causes the kernel to measure 
the CPU used by a process at microsecond resolution.  This affects 
general CPU usage measurement, rusage, and virtual itimers.  The patch 
is against 2.4.17.  It touches some pretty fundamental data structures 
and ties in to all the exception (including interrupt and system call) 
handlers, so it's pretty invasive.  It shouldn't slow things down when 
the patch is turned off, but it will slow down all exceptions when it is 
turned on.  The patch currently works on PowerPC and x86 (although it 
won't work on earlier x86 processors due to lack of a high-resolution 
clock source).  It has seen extensive testing (around 9 months of heavy 
usage) in the lab on an older kernel.

I'm curious if this patch is interesting enough to work to include it in 
the mainstream kernel release.  If so, I'll gladly work to get it in to 
shape to go into 2.5 or whatever.  (I'll also gladly take comments on 
how to improve it :-).

-Corey

--------------020904090207000704070500
Content-Type: text/plain;
 name="highres.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="highres.patch"

--- ./fs/proc/proc_misc.c.highres	Tue Nov 20 23:29:09 2001
+++ ./fs/proc/proc_misc.c	Sat Feb  9 17:30:04 2002
@@ -101,7 +101,8 @@
 	int len;
 
 	uptime = jiffies;
-	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;
+	idle = (tms_time_to_ticks(init_tasks[0]->times.tms_utime)
+		+ tms_time_to_ticks(init_tasks[0]->times.tms_stime));
 
 	/* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
 	   that would overflow about every five days at HZ == 100.
--- ./fs/proc/array.c.highres	Thu Oct 11 11:00:01 2001
+++ ./fs/proc/array.c	Sat Feb  9 17:30:04 2002
@@ -358,10 +358,10 @@
 		task->cmin_flt,
 		task->maj_flt,
 		task->cmaj_flt,
-		task->times.tms_utime,
-		task->times.tms_stime,
-		task->times.tms_cutime,
-		task->times.tms_cstime,
+		tms_time_to_ticks(task->times.tms_utime),
+		tms_time_to_ticks(task->times.tms_stime),
+		tms_time_to_ticks(task->times.tms_cutime),
+		tms_time_to_ticks(task->times.tms_cstime),
 		priority,
 		nice,
 		0UL /* removed */,
@@ -682,8 +682,8 @@
 
 	len = sprintf(buffer,
 		"cpu  %lu %lu\n",
-		task->times.tms_utime,
-		task->times.tms_stime);
+		tms_time_to_ticks(task->times.tms_utime),
+		tms_time_to_ticks(task->times.tms_stime));
 		
 	for (i = 0 ; i < smp_num_cpus; i++)
 		len += sprintf(buffer + len, "cpu%d %lu %lu\n",
--- ./fs/binfmt_elf.c.highres	Thu Jan 10 15:52:13 2002
+++ ./fs/binfmt_elf.c	Sat Feb  9 17:30:04 2002
@@ -1105,14 +1105,10 @@
 	psinfo.pr_ppid = prstatus.pr_ppid = current->p_pptr->pid;
 	psinfo.pr_pgrp = prstatus.pr_pgrp = current->pgrp;
 	psinfo.pr_sid = prstatus.pr_sid = current->session;
-	prstatus.pr_utime.tv_sec = CT_TO_SECS(current->times.tms_utime);
-	prstatus.pr_utime.tv_usec = CT_TO_USECS(current->times.tms_utime);
-	prstatus.pr_stime.tv_sec = CT_TO_SECS(current->times.tms_stime);
-	prstatus.pr_stime.tv_usec = CT_TO_USECS(current->times.tms_stime);
-	prstatus.pr_cutime.tv_sec = CT_TO_SECS(current->times.tms_cutime);
-	prstatus.pr_cutime.tv_usec = CT_TO_USECS(current->times.tms_cutime);
-	prstatus.pr_cstime.tv_sec = CT_TO_SECS(current->times.tms_cstime);
-	prstatus.pr_cstime.tv_usec = CT_TO_USECS(current->times.tms_cstime);
+	prstatus.pr_utime = tms_time_to_timeval(current->times.tms_utime);
+	prstatus.pr_stime = tms_time_to_timeval(current->times.tms_stime);
+	prstatus.pr_cutime = tms_time_to_timeval(current->times.tms_cutime);
+	prstatus.pr_cstime = tms_time_to_timeval(current->times.tms_cstime);
 
 	/*
 	 * This transfers the registers from regs into the standard
--- ./mm/oom_kill.c.highres	Sat Nov  3 19:05:25 2001
+++ ./mm/oom_kill.c	Sat Feb  9 17:30:04 2002
@@ -72,7 +72,9 @@
 	 * very well in practice. This is not safe against jiffie wraps
 	 * but we don't care _that_ much...
 	 */
-	cpu_time = (p->times.tms_utime + p->times.tms_stime) >> (SHIFT_HZ + 3);
+	cpu_time = (tms_time_to_ticks(p->times.tms_utime)
+		    + tms_time_to_ticks(p->times.tms_stime))
+			>> (SHIFT_HZ + 3);
 	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
 
 	points /= int_sqrt(cpu_time);
--- ./arch/ppc/config.in.highres	Fri Nov 16 12:10:08 2001
+++ ./arch/ppc/config.in	Sat Feb  9 17:30:04 2002
@@ -237,6 +237,11 @@
   source drivers/zorro/Config.in
 fi
 
+bool 'High resolution CPU usage and virtual itimers' CONFIG_HIGHRES_CPU_USAGE
+if [ "$CONFIG_HIGHRES_CPU_USAGE" = "y" ]; then
+  bool 'Does the virtual itimer count system CPU usage?' CONFIG_VIRT_ITIMER_COUNTS_SYSTEM
+fi
+
 endmenu
 source drivers/mtd/Config.in
 source drivers/pnp/Config.in
--- ./arch/ppc/kernel/entry.S.highres	Mon Nov 26 07:29:17 2001
+++ ./arch/ppc/kernel/entry.S	Sat Feb  9 17:30:04 2002
@@ -298,6 +298,10 @@
 ret_to_user_hook:
 	nop
 restore:
+#ifdef CONFIG_HIGHRES_CPU_USAGE
+	mr	r3,r2
+	bl	tms_leave_system
+#endif
 	lwz	r3,_XER(r1)
 	mtspr	XER,r3
 	REST_10GPRS(9,r1)
--- ./arch/ppc/kernel/time.c.highres	Mon Oct  8 13:43:01 2001
+++ ./arch/ppc/kernel/time.c	Sat Feb  9 17:30:04 2002
@@ -243,6 +243,35 @@
 	tv->tv_usec = usec;
 }
 
+#ifdef CONFIG_HIGHRES_CPU_USAGE
+unsigned long curr_timestamp(void)
+{
+        return get_native_tbl();
+}
+
+unsigned long timestamp_usec_diff(unsigned long ts1, unsigned long ts2)
+{
+        unsigned long val;
+	unsigned long usec;
+
+	if (__USE_RTC()) {
+	        int delta = ts1 - ts2;
+		val = delta<0 ? delta + 1000000000 : delta;
+	} else {
+        	val = ts1 - ts2;
+	}
+	usec = mulhwu(tb_to_us, val);
+	if (usec > 1000000) {
+		/* We had some wierd overflow due to the timebases being
+		   changed, just ignore it. */
+		printk("tb went backwards? ts1=%lu, ts2=%ld\n", ts1, ts2);
+		usec = 0;
+	}
+
+	return usec;
+}
+#endif
+
 void do_settimeofday(struct timeval *tv)
 {
 	unsigned long flags;
--- ./arch/ppc/kernel/head.S.highres	Fri Nov  2 19:43:54 2001
+++ ./arch/ppc/kernel/head.S	Sat Feb  9 17:30:04 2002
@@ -771,6 +771,12 @@
 2:	addi	r2,r23,-THREAD		/* set r2 to current */
 	tovirt(r2,r2)
 	mflr	r23
+#ifdef CONFIG_HIGHRES_CPU_USAGE
+	bl	3f
+	.long	highres_start
+3:	mflr	r25
+	lwz	r25,0(r25)
+#endif
 	andi.	r24,r23,0x3f00		/* get vector offset */
 	stw	r24,TRAP(r21)
 	li	r22,0
@@ -784,11 +790,50 @@
 	lwz	r24,0(r23)		/* virtual address of handler */
 	lwz	r23,4(r23)		/* where to go when done */
 	FIX_SRR1(r20,r22)
+#ifdef CONFIG_HIGHRES_CPU_USAGE
+	mtspr	SRR0,r25
+#else
 	mtspr	SRR0,r24
+#endif
 	mtspr	SRR1,r20
+#ifndef CONFIG_HIGHRES_CPU_USAGE
 	mtlr	r23
+#endif
 	SYNC
 	RFI				/* jump to handler, enable MMU */
+
+#ifdef CONFIG_HIGHRES_CPU_USAGE
+highres_start:
+	subi	r1,r1,52
+	stw	r12,44(r1)
+	stw	r11,40(r1)
+	stw	r10,36(r1)
+	stw	r9,32(r1)
+	stw	r8,28(r1)
+	stw	r7,24(r1)
+	stw	r6,20(r1)
+	stw	r5,16(r1)
+	stw	r4,12(r1)
+	stw	r3,8(r1)
+	stw	r0,48(r1)
+	mr	r3,r2
+	bl	tms_enter_system
+	mtlr	r23
+	mtctr	r24
+	lwz	r12,44(r1)
+	lwz	r11,40(r1)
+	lwz	r10,36(r1)
+	lwz	r9,32(r1)
+	lwz	r8,28(r1)
+	lwz	r7,24(r1)
+	lwz	r6,20(r1)
+	lwz	r5,16(r1)
+	lwz	r4,12(r1)
+	lwz	r3,8(r1)
+	lwz	r0,48(r1)
+	addi	r1,r1,52
+	bctr
+#endif
 
 /*
  * On kernel stack overflow, load up an initial stack pointer
--- ./arch/i386/config.in.highres	Sat Feb  9 20:48:32 2002
+++ ./arch/i386/config.in	Sat Feb  9 21:04:26 2002
@@ -279,6 +279,9 @@
    bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
 fi
 
+dep_bool 'High resolution CPU usage and virtual itimers' CONFIG_HIGHRES_CPU_USAGE $CONFIG_X86_TSC
+dep_bool 'Does the virtual itimer count system CPU usage?' CONFIG_VIRT_ITIMER_COUNTS_SYSTEM $CONFIG_HIGHRES_CPU_USAGE
+
 endmenu
 
 source drivers/mtd/Config.in
--- ./arch/i386/kernel/entry.S.highres	Sat Feb  9 20:48:02 2002
+++ ./arch/i386/kernel/entry.S	Mon Feb 11 14:55:52 2002
@@ -81,6 +81,27 @@
 
 ENOSYS = 38
 
+#define GET_CURRENT(reg) \
+	movl $-8192, reg; \
+	andl %esp, reg
+
+#ifdef CONFIG_HIGHRES_CPU_USAGE
+#define HIGHRES_START_CODE \
+	pushl %eax;        \
+	GET_CURRENT(%ebx); \
+	pushl %ebx;        \
+	call  SYMBOL_NAME(tms_enter_system); \
+	addl  $4,%esp;     \
+	popl %eax; 
+#define HIGHRES_END_CODE \
+	GET_CURRENT(%ebx); \
+	pushl %ebx;        \
+	call  SYMBOL_NAME(tms_leave_system); \
+	addl  $4,%esp; 
+#else
+#define HIGHRES_START_CODE
+#define HIGHRES_END_CODE
+#endif
 
 #define SAVE_ALL \
 	cld; \
@@ -95,9 +116,11 @@
 	pushl %ebx; \
 	movl $(__KERNEL_DS),%edx; \
 	movl %edx,%ds; \
-	movl %edx,%es;
+	movl %edx,%es; \
+	HIGHRES_START_CODE;
 
 #define RESTORE_ALL	\
+	HIGHRES_END_CODE; \
 	popl %ebx;	\
 	popl %ecx;	\
 	popl %edx;	\
@@ -128,10 +151,6 @@
 	.long 3b,6b;	\
 .previous
 
-#define GET_CURRENT(reg) \
-	movl $-8192, reg; \
-	andl %esp, reg
-
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call gates,
 	pushl %eax		# which has to be cleaned up later..
@@ -286,6 +305,9 @@
 	movl $(__KERNEL_DS),%edx
 	movl %edx,%ds
 	movl %edx,%es
+	pushl %edi
+	HIGHRES_START_CODE
+	popl %edi
 	GET_CURRENT(%ebx)
 	call *%edi
 	addl $8,%esp
--- ./arch/i386/kernel/time.c.highres	Sat Feb  9 20:46:39 2002
+++ ./arch/i386/kernel/time.c	Mon Feb 11 10:13:28 2002
@@ -715,3 +715,34 @@
 	setup_irq(0, &irq0);
 #endif
 }
+
+#ifdef CONFIG_HIGHRES_CPU_USAGE
+unsigned long curr_timestamp(void)
+{
+	register unsigned long eax, edx;
+	rdtsc(eax,edx);
+	return eax;
+}
+
+unsigned long timestamp_usec_diff(unsigned long ts1, unsigned long ts2)
+{
+	register unsigned long eax, rv;
+
+	/* Read the Time Stamp Counter */
+
+	eax = ts1 - ts2;
+	__asm__("mull %2"
+		:"=a" (eax), "=d" (rv)
+		:"rm" (fast_gettimeoffset_quotient),
+		 "0" (eax));
+
+	if (rv >= 1000000) {
+		/* We had some wierd overflow due to the timebases being
+		   changed, just ignore it. */
+		printk("tb went backwards? ts1=%lu, ts2=%ld\n", ts1, ts2);
+		rv = 0;
+	}
+
+	return rv;
+}
+#endif
--- ./kernel/acct.c.highres	Mon Mar 19 14:35:08 2001
+++ ./kernel/acct.c	Sat Feb  9 17:30:04 2002
@@ -296,8 +296,8 @@
 
 	ac.ac_btime = CT_TO_SECS(current->start_time) + (xtime.tv_sec - (jiffies / HZ));
 	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
-	ac.ac_utime = encode_comp_t(current->times.tms_utime);
-	ac.ac_stime = encode_comp_t(current->times.tms_stime);
+	ac.ac_utime = encode_comp_t(tms_time_to_ticks(current->times.tms_utime));
+	ac.ac_stime = encode_comp_t(tms_time_to_ticks(current->times.tms_stime));
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
 	ac.ac_tty = (current->tty) ? kdev_t_to_nr(current->tty->device) : 0;
--- ./kernel/timer.c.highres	Mon Oct  8 12:41:41 2001
+++ ./kernel/timer.c	Mon Feb 11 15:23:55 2002
@@ -518,6 +518,8 @@
 	}
 }
 
+#ifndef CONFIG_HIGHRES_CPU_USAGE
+
 static inline void do_process_times(struct task_struct *p,
 	unsigned long user, unsigned long system)
 {
@@ -549,6 +551,144 @@
 	}
 }
 
+#else /* CONFIG_HIGHRES_CPU_USAGE */
+
+/* This spin lock protects the virtual itimer and tms structures while
+   we are messing with it. */
+rwlock_t virt_itimer_lock = RW_LOCK_UNLOCKED;
+
+/* This is assumed to be called more than once a second. */
+static inline void add_usec_to_timeval(struct timeval *tv,
+				       unsigned long  usecs)
+{
+	tv->tv_usec += usecs;
+	if (tv->tv_usec >= 1000000) {
+		tv->tv_usec -= 1000000;
+		tv->tv_sec += 1;
+	}
+}
+
+/* virt_itimer_lock should be held when this is called. */
+static inline void tms_check_virt(struct task_struct *p,
+				  unsigned long      usecs)
+{
+	struct timeval *it_virt = &(p->it_virt_value);
+
+	if (it_virt->tv_sec || it_virt->tv_usec) {
+		/* This is called every tick, so we don't have to
+                   worry about large values of usecs.  It should be
+                   less than 12ms or so, certainly less than a
+                   second. */
+		if ((it_virt->tv_sec == 0) && (it_virt->tv_usec <= usecs)) {
+			*it_virt = p->it_virt_incr;
+			send_sig(SIGVTALRM, p, 1);
+		} else {
+			it_virt->tv_usec -= usecs;
+			if (it_virt->tv_usec < 0) {
+				it_virt->tv_usec += 1000000;
+				it_virt->tv_sec--;
+			}
+		}
+	}
+}
+
+void tms_task_stopped_running(struct task_struct *p)
+{
+	unsigned long timestamp;
+	unsigned long usecs;
+	unsigned long flags;
+
+	write_lock_irqsave(&virt_itimer_lock, flags);
+	timestamp = curr_timestamp();
+
+	/* We have to be running in system code to call this.  But
+	   when called from a kernel thread, the nest count won't be
+	   correct, so fix it. */
+	if (!p->system_code_nest)
+		p->system_code_nest++;
+
+	usecs = timestamp_usec_diff(timestamp, p->last_timestamp);
+	add_usec_to_timeval(&p->times.tms_stime, usecs);
+
+#ifdef CONFIG_VIRT_ITIMER_COUNTS_SYSTEM
+	tms_check_virt(p, usecs);
+#endif
+	write_unlock_irqrestore(&virt_itimer_lock, flags);
+}
+
+void tms_task_started_running(struct task_struct *p)
+{
+	unsigned long flags;
+
+	write_lock_irqsave(&virt_itimer_lock, flags);
+	p->last_timestamp = curr_timestamp();
+	write_unlock_irqrestore(&virt_itimer_lock, flags);
+}
+
+void tms_update_task_times(struct task_struct *p)
+{
+	unsigned long timestamp;
+	unsigned long usecs;
+	unsigned long flags;
+
+	write_lock_irqsave(&virt_itimer_lock, flags);
+	timestamp = curr_timestamp();
+
+	/* We have to be running in system code to call this. */
+	usecs = timestamp_usec_diff(timestamp, p->last_timestamp);
+	add_usec_to_timeval(&p->times.tms_stime, usecs);
+#ifdef CONFIG_VIRT_ITIMER_COUNTS_SYSTEM
+	tms_check_virt(p, usecs);
+#endif
+	p->last_timestamp = timestamp;
+	write_unlock_irqrestore(&virt_itimer_lock, flags);
+}
+
+asmlinkage void tms_enter_system(struct task_struct *p)
+{
+	unsigned long timestamp;
+	unsigned long usecs;
+	unsigned long flags;
+
+	write_lock_irqsave(&virt_itimer_lock, flags);
+	timestamp = curr_timestamp();
+	if (p->system_code_nest) {
+		p->system_code_nest++;
+	} else {
+		/* Leaving userland. */
+		usecs = timestamp_usec_diff(timestamp, p->last_timestamp);
+		
+		add_usec_to_timeval(&p->times.tms_utime, usecs);
+		tms_check_virt(p, usecs);
+		p->last_timestamp = timestamp;
+		p->system_code_nest = 1;
+	}
+	write_unlock_irqrestore(&virt_itimer_lock, flags);
+}
+
+asmlinkage void tms_leave_system(struct task_struct *p)
+{
+	unsigned long timestamp;
+	unsigned long usecs;
+	unsigned long flags;
+
+	write_lock_irqsave(&virt_itimer_lock, flags);
+	timestamp = curr_timestamp();
+
+	p->system_code_nest--;
+	if (! p->system_code_nest) {
+		/* Returning to userland. */
+		usecs = timestamp_usec_diff(timestamp, p->last_timestamp);
+		add_usec_to_timeval(&p->times.tms_stime, usecs);
+#ifdef CONFIG_VIRT_ITIMER_COUNTS_SYSTEM
+		tms_check_virt(p, usecs);
+#endif
+		p->last_timestamp = timestamp;
+	}
+	write_unlock_irqrestore(&virt_itimer_lock, flags);
+}
+#endif /* CONFIG_HIGHRES_CPU_USAGE */
+
 static inline void do_it_prof(struct task_struct *p)
 {
 	unsigned long it_prof = p->it_prof_value;
@@ -567,8 +707,12 @@
 {
 	p->per_cpu_utime[cpu] += user;
 	p->per_cpu_stime[cpu] += system;
+#ifndef CONFIG_HIGHRES_CPU_USAGE
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
+#else
+	tms_update_task_times(p);
+#endif
 	do_it_prof(p);
 }	
 
--- ./kernel/fork.c.highres	Wed Nov 21 12:18:42 2001
+++ ./kernel/fork.c	Sat Feb  9 17:30:04 2002
@@ -626,15 +626,25 @@
 	p->sigpending = 0;
 	init_sigpending(&p->pending);
 
-	p->it_real_value = p->it_virt_value = p->it_prof_value = 0;
-	p->it_real_incr = p->it_virt_incr = p->it_prof_incr = 0;
+	p->it_real_value = p->it_prof_value = 0;
+	p->it_real_incr = p->it_prof_incr = 0;
+#ifndef CONFIG_HIGHRES_CPU_USAGE
+	p->it_virt_value = p->it_virt_incr = 0;
+#else
+	p->it_virt_value.tv_sec = p->it_virt_value.tv_usec = 0;
+	p->it_virt_incr.tv_sec = p->it_virt_incr.tv_usec = 0;
+	/* We start out in system code. */
+	p->system_code_nest = 1;
+#endif
 	init_timer(&p->real_timer);
 	p->real_timer.data = (unsigned long) p;
 
 	p->leader = 0;		/* session leadership doesn't inherit */
 	p->tty_old_pgrp = 0;
-	p->times.tms_utime = p->times.tms_stime = 0;
-	p->times.tms_cutime = p->times.tms_cstime = 0;
+	init_tms_time(&(p->times.tms_utime));
+	init_tms_time(&(p->times.tms_stime));
+	init_tms_time(&(p->times.tms_cutime));
+	init_tms_time(&(p->times.tms_cstime));
 #ifdef CONFIG_SMP
 	{
 		int i;
--- ./kernel/sys.c.highres	Tue Sep 18 16:10:43 2001
+++ ./kernel/sys.c	Sat Feb  9 17:30:04 2002
@@ -789,6 +789,15 @@
 	return old_fsgid;
 }
 
+static inline void tms_internal_to_tms(struct internal_tms *internal,
+				       struct tms          *external)
+{
+	external->tms_utime = tms_time_to_ticks(internal->tms_utime);
+	external->tms_stime = tms_time_to_ticks(internal->tms_stime);
+	external->tms_cutime = tms_time_to_ticks(internal->tms_cutime);
+	external->tms_cstime = tms_time_to_ticks(internal->tms_cstime);
+}
+
 asmlinkage long sys_times(struct tms * tbuf)
 {
 	/*
@@ -797,9 +806,12 @@
 	 *	atomically safe type this is just fine. Conceptually its
 	 *	as if the syscall took an instant longer to occur.
 	 */
-	if (tbuf)
-		if (copy_to_user(tbuf, &current->times, sizeof(struct tms)))
+	if (tbuf) {
+		struct tms external;
+		tms_internal_to_tms(&current->times, &external);
+		if (copy_to_user(tbuf, &external, sizeof(struct tms)))
 			return -EFAULT;
+	}
 	return jiffies;
 }
 
@@ -1157,32 +1169,35 @@
 	memset((char *) &r, 0, sizeof(r));
 	switch (who) {
 		case RUSAGE_SELF:
-			r.ru_utime.tv_sec = CT_TO_SECS(p->times.tms_utime);
-			r.ru_utime.tv_usec = CT_TO_USECS(p->times.tms_utime);
-			r.ru_stime.tv_sec = CT_TO_SECS(p->times.tms_stime);
-			r.ru_stime.tv_usec = CT_TO_USECS(p->times.tms_stime);
+		        r.ru_utime = tms_time_to_timeval(p->times.tms_utime);
+		        r.ru_stime = tms_time_to_timeval(p->times.tms_stime);
 			r.ru_minflt = p->min_flt;
 			r.ru_majflt = p->maj_flt;
 			r.ru_nswap = p->nswap;
 			break;
 		case RUSAGE_CHILDREN:
-			r.ru_utime.tv_sec = CT_TO_SECS(p->times.tms_cutime);
-			r.ru_utime.tv_usec = CT_TO_USECS(p->times.tms_cutime);
-			r.ru_stime.tv_sec = CT_TO_SECS(p->times.tms_cstime);
-			r.ru_stime.tv_usec = CT_TO_USECS(p->times.tms_cstime);
+		        r.ru_utime = tms_time_to_timeval(p->times.tms_cutime);
+		        r.ru_stime = tms_time_to_timeval(p->times.tms_cstime);
 			r.ru_minflt = p->cmin_flt;
 			r.ru_majflt = p->cmaj_flt;
 			r.ru_nswap = p->cnswap;
 			break;
 		default:
-			r.ru_utime.tv_sec = CT_TO_SECS(p->times.tms_utime + p->times.tms_cutime);
-			r.ru_utime.tv_usec = CT_TO_USECS(p->times.tms_utime + p->times.tms_cutime);
-			r.ru_stime.tv_sec = CT_TO_SECS(p->times.tms_stime + p->times.tms_cstime);
-			r.ru_stime.tv_usec = CT_TO_USECS(p->times.tms_stime + p->times.tms_cstime);
+		{
+		        tms_time tmsv;
+
+			tmsv = add_tms_times(p->times.tms_utime,
+					     p->times.tms_cutime);
+		        r.ru_utime = tms_time_to_timeval(tmsv);
+			tmsv = add_tms_times(p->times.tms_stime,
+					     p->times.tms_cstime);
+		        r.ru_stime = tms_time_to_timeval(tmsv);
+
 			r.ru_minflt = p->min_flt + p->cmin_flt;
 			r.ru_majflt = p->maj_flt + p->cmaj_flt;
 			r.ru_nswap = p->nswap + p->cnswap;
 			break;
+		}
 	}
 	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
 }
--- ./kernel/itimer.c.highres	Thu Jun 29 12:07:36 2000
+++ ./kernel/itimer.c	Sat Feb  9 17:30:04 2002
@@ -58,20 +58,35 @@
 			if ((long) val <= 0)
 				val = 1;
 		}
+		jiffiestotv(val, &value->it_value);
+		jiffiestotv(interval, &value->it_interval);
 		break;
 	case ITIMER_VIRTUAL:
+#ifndef CONFIG_HIGHRES_CPU_USAGE
 		val = current->it_virt_value;
 		interval = current->it_virt_incr;
+		jiffiestotv(val, &value->it_value);
+		jiffiestotv(interval, &value->it_interval);
+#else
+		{
+			unsigned long flags;
+
+			read_lock_irqsave(&virt_itimer_lock, flags);
+			value->it_value = current->it_virt_value;
+			value->it_interval = current->it_virt_incr;
+			read_unlock_irqrestore(&virt_itimer_lock, flags);
+		}
+#endif
 		break;
 	case ITIMER_PROF:
 		val = current->it_prof_value;
 		interval = current->it_prof_incr;
+		jiffiestotv(val, &value->it_value);
+		jiffiestotv(interval, &value->it_interval);
 		break;
 	default:
 		return(-EINVAL);
 	}
-	jiffiestotv(val, &value->it_value);
-	jiffiestotv(interval, &value->it_interval);
 	return 0;
 }
 
@@ -110,12 +125,12 @@
 	register unsigned long i, j;
 	int k;
 
-	i = tvtojiffies(&value->it_interval);
-	j = tvtojiffies(&value->it_value);
 	if (ovalue && (k = do_getitimer(which, ovalue)) < 0)
 		return k;
 	switch (which) {
 		case ITIMER_REAL:
+			i = tvtojiffies(&value->it_interval);
+			j = tvtojiffies(&value->it_value);
 			del_timer_sync(&current->real_timer);
 			current->it_real_value = j;
 			current->it_real_incr = i;
@@ -128,12 +143,28 @@
 			add_timer(&current->real_timer);
 			break;
 		case ITIMER_VIRTUAL:
+#ifndef CONFIG_HIGHRES_CPU_USAGE
+			i = tvtojiffies(&value->it_interval);
+			j = tvtojiffies(&value->it_value);
 			if (j)
 				j++;
 			current->it_virt_value = j;
 			current->it_virt_incr = i;
+#else
+			{
+				unsigned long flags;
+
+				write_lock_irqsave(&virt_itimer_lock, flags);
+				current->it_virt_value = value->it_value;
+				current->it_virt_incr = value->it_interval;
+				write_unlock_irqrestore(&virt_itimer_lock,
+							flags);
+			}
+#endif
 			break;
 		case ITIMER_PROF:
+			i = tvtojiffies(&value->it_interval);
+			j = tvtojiffies(&value->it_value);
 			if (j)
 				j++;
 			current->it_prof_value = j;
--- ./kernel/exit.c.highres	Wed Nov 21 16:42:27 2001
+++ ./kernel/exit.c	Sat Feb  9 17:30:04 2002
@@ -535,8 +535,19 @@
 				}
 				goto end_wait4;
 			case TASK_ZOMBIE:
-				current->times.tms_cutime += p->times.tms_utime + p->times.tms_cutime;
-				current->times.tms_cstime += p->times.tms_stime + p->times.tms_cstime;
+				current->times.tms_cutime
+				    = add_tms_times(current->times.tms_utime,
+						    p->times.tms_utime);
+				current->times.tms_cutime
+				    = add_tms_times(current->times.tms_cutime,
+						    p->times.tms_cutime);
+				current->times.tms_cstime
+				    = add_tms_times(current->times.tms_stime,
+						    p->times.tms_stime);
+				current->times.tms_cstime
+				    = add_tms_times(current->times.tms_cstime,
+						    p->times.tms_cstime);
+
 				read_unlock(&tasklist_lock);
 				retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
 				if (!retval && stat_addr)
--- ./kernel/signal.c.highres	Wed Nov 21 18:26:27 2001
+++ ./kernel/signal.c	Sat Feb  9 17:30:04 2002
@@ -742,8 +742,8 @@
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
-	info.si_utime = tsk->times.tms_utime;
-	info.si_stime = tsk->times.tms_stime;
+	info.si_utime = tms_time_to_ticks(tsk->times.tms_utime);
+	info.si_stime = tms_time_to_ticks(tsk->times.tms_stime);
 
 	status = tsk->exit_code & 0x7f;
 	why = SI_KERNEL;	/* shouldn't happen */
--- ./kernel/sched.c.highres	Thu Jan 10 15:52:14 2002
+++ ./kernel/sched.c	Sat Feb  9 17:30:04 2002
@@ -694,6 +694,8 @@
 	 * This just switches the register state and the
 	 * stack.
 	 */
+	tms_task_stopped_running(prev);
+	tms_task_started_running(next);
 	switch_to(prev, next, prev);
 	__schedule_tail(prev);
 
--- ./Documentation/Configure.help.highres	Thu Jan 10 15:52:12 2002
+++ ./Documentation/Configure.help	Sat Feb  9 17:30:04 2002
@@ -19794,6 +19794,19 @@
 
   "Area6" will work for most boards. For ADX, select "Area5".
 
+High resolution CPU usage and virtual itimers
+CONFIG_HIGHRES_CPU_USAGE
+  If you say Y here, the cpu usage tracked for programs and virtual itimers
+  will be much higher precision.  The downside of this is that the system
+  call overhead will go up some (every entry into and out of the kernel must
+  be tracked).  Also, the architecture must support high-res timers of
+  some kind and the support must be added to the architecture code.
+
+Does the virtual itimer count system CPU usage?
+CONFIG_VIRT_ITIMER_COUNTS_SYSTEM
+  If highres CPU is counted, this sets whether virtual itimers count system
+  CPU used towards the amount of CPU until the virtual timer goes off.
+
 #
 # m68k-specific kernel options
 # Documented by Chris Lawrence <mailto:quango@themall.net> et al.
--- ./include/linux/sched.h.highres	Sun Jan 13 14:52:51 2002
+++ ./include/linux/sched.h	Sun Feb 10 20:19:05 2002
@@ -278,6 +278,124 @@
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
+#ifndef CONFIG_HIGHRES_CPU_USAGE
+typedef clock_t tms_time;
+#else
+typedef struct timeval tms_time;
+#endif
+
+struct internal_tms {
+        tms_time tms_utime;
+	tms_time tms_stime;
+	tms_time tms_cutime;
+	tms_time tms_cstime;
+};
+
+#ifndef CONFIG_HIGHRES_CPU_USAGE
+static inline clock_t tms_time_to_ticks(tms_time tv)
+{
+	return tv;
+}
+
+static inline tms_time add_tms_times(tms_time tv1, tms_time tv2)
+{
+	return tv1 + tv2;
+}
+
+static inline void init_tms_time(tms_time *tv)
+{
+	*tv = 0;
+}
+
+static inline struct timeval tms_time_to_timeval(tms_time tv)
+{
+	struct timeval rv;
+
+	rv.tv_sec = CT_TO_SECS(tv);
+	rv.tv_usec = CT_TO_USECS(tv);
+	return rv;
+}
+
+/* Called when a running task is stopped. */
+#define tms_task_stopped_running(p)
+
+/* Called when a task that was not running is started. */
+#define tms_task_started_running(p)
+
+/* Called periodically in case a task is taking all the CPU to avoid
+   curr_usec_time() overflowing. */
+#define tms_update_task_times(p)
+
+#else
+
+/* This spin lock protects the virtual itimer structure while we are
+   messing with it. */
+extern rwlock_t virt_itimer_lock;
+
+static inline clock_t tms_time_to_ticks(tms_time tv)
+{
+	clock_t ticks;
+
+	ticks = tv.tv_sec * HZ;
+	ticks += tv.tv_usec / (1000000 / HZ);
+	return ticks;
+}
+
+static inline tms_time add_tms_times(tms_time tv1,
+				     tms_time tv2)
+{
+	tms_time rv;
+
+	rv.tv_sec = tv1.tv_sec + tv2.tv_sec;
+	rv.tv_usec = tv1.tv_usec + tv2.tv_usec;
+	if (rv.tv_usec >= 1000000) {
+		rv.tv_usec -= 1000000;
+		rv.tv_sec += 1;
+	}
+
+	return rv;
+}
+
+static inline void init_tms_time(tms_time *tv)
+{
+	tv->tv_sec = 0;
+	tv->tv_usec = 0;
+}
+
+static inline struct timeval tms_time_to_timeval(tms_time tv)
+{
+	return tv;
+}
+
+/* Return a current timestamp from the architecture. */
+extern unsigned long curr_timestamp(void);
+
+/* Return the difference in microseconds of ts1-ts2.  This is called
+   by the highres usage time code to get microsecond resolution from
+   some highres clock. */
+extern unsigned long timestamp_usec_diff(unsigned long ts1, unsigned long ts2);
+
+struct task_struct;
+
+/* Called when a running task is stopped. */
+void tms_task_stopped_running(struct task_struct *p);
+
+/* Called when a task that was not running is started. */
+void tms_task_started_running(struct task_struct *p);
+
+/* Called periodically in case a task is taking all the CPU to avoid
+   curr_usec_time() overflowing. */
+void tms_update_task_times(struct task_struct *p);
+
+/* Called when we enter system code for a process. */
+void tms_enter_system(struct task_struct *p);
+
+/* Called when leave system code for a process. */
+void tms_leave_system(struct task_struct *p);
+
+#endif
+
+
 struct task_struct {
 	/*
 	 * offsets of these are hardcoded elsewhere - touch with care
@@ -355,10 +473,22 @@
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
 	unsigned long rt_priority;
-	unsigned long it_real_value, it_prof_value, it_virt_value;
-	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
+	unsigned long it_real_value, it_prof_value;
+#ifndef CONFIG_HIGHRES_CPU_USAGE
+        unsigned long it_virt_value;
+#else
+        struct timeval it_virt_value;
+        unsigned long last_timestamp;   /* The last usec time taken for the process. */
+        unsigned long system_code_nest; /* How nested am I in system code? */
+#endif
+        unsigned long it_real_incr, it_prof_incr;
+#ifndef CONFIG_HIGHRES_CPU_USAGE
+        unsigned long it_virt_incr;
+#else
+        struct timeval it_virt_incr;
+#endif
 	struct timer_list real_timer;
-	struct tms times;
+	struct internal_tms times;
 	unsigned long start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
@@ -451,6 +581,12 @@
 #define DEF_NICE	(0)
 
 
+#ifdef CONFIG_HIGHRES_CPU_USAGE
+#define INIT_SYSTEM_CODE_NEST	system_code_nest:		1,
+#else
+#define INIT_SYSTEM_CODE_NEST
+#endif
+
 /*
  * The default (Linux) execution domain.
  */
@@ -501,6 +637,7 @@
     blocked:		{{0}},						\
     alloc_lock:		SPIN_LOCK_UNLOCKED,				\
     journal_info:	NULL,						\
+    INIT_SYSTEM_CODE_NEST						\
 }
 
 
--- ./include/asm-i386/hw_irq.h.highres	Mon Feb 11 15:10:39 2002
+++ ./include/asm-i386/hw_irq.h	Mon Feb 11 15:19:50 2002
@@ -95,6 +95,22 @@
 #define __STR(x) #x
 #define STR(x) __STR(x)
 
+#define GET_CURRENT \
+	"movl %esp, %ebx\n\t" \
+	"andl $-8192, %ebx\n\t"
+
+#ifdef CONFIG_HIGHRES_CPU_USAGE
+#define HIGHRES_START_CODE \
+	"pushl %eax\n\t"		          \
+	GET_CURRENT				  \
+	"pushl %ebx\n\t"			  \
+	"call  " SYMBOL_NAME_STR(tms_enter_system) "\n\t" \
+	"addl  $4,%esp\n\t"			  \
+	"popl %eax\n\t" 
+#else
+#define HIGHRES_START_CODE
+#endif
+
 #define SAVE_ALL \
 	"cld\n\t" \
 	"pushl %es\n\t" \
@@ -108,14 +124,11 @@
 	"pushl %ebx\n\t" \
 	"movl $" STR(__KERNEL_DS) ",%edx\n\t" \
 	"movl %edx,%ds\n\t" \
-	"movl %edx,%es\n\t"
+	"movl %edx,%es\n\t" \
+        HIGHRES_START_CODE
 
 #define IRQ_NAME2(nr) nr##_interrupt(void)
 #define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)
-
-#define GET_CURRENT \
-	"movl %esp, %ebx\n\t" \
-	"andl $-8192, %ebx\n\t"
 
 /*
  *	SMP has a few special interrupts for IPI messages

--------------020904090207000704070500--

