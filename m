Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S.rDI7.156825>; Sat, 15 May 1999 05:45:36 -0400
Received: by vger.rutgers.edu id <S.rDGY9156912>; Sat, 15 May 1999 03:58:03 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:17126 "EHLO sgi.com") by vger.rutgers.edu with ESMTP id <S.rDAA4157284>; Fri, 14 May 1999 20:42:46 -0400
Date: Fri, 14 May 1999 18:29:45 -0700
From: Dimitris Michailidis <dimitris@darkside.engr.sgi.com>
Message-Id: <199905150129.SAA16446@darkside.engr.sgi.com>
To: linux-kernel@vger.rutgers.edu
Subject: [PATCH] kernel profiling with gprof
Sender: owner-linux-kernel@vger.rutgers.edu
X-UIDL: 926761530.215558.21086

On behalf of SGI we are pleased to make available this patch that allows 
kernel profiling with gprof.  This allows call graph profiling that may be
more useful than statistical PC sampling.  The patch has two components, a
kernel part that collects call arc data and makes it available under /proc,
and a user level command, kernprof, that controls kernel profiling and creates
the data file for gprof.  Collection of call arc data is based on gcc's -pg
option that instruments the kernel with calls to mcount().

****
IMPORTANT:  Due to bugs in all versions of gcc/egcs I am aware of, unmodified
kernels compiled by unmodified compilers do not work with this patch.  The 
fault is with gcc, see 
http://egcs.cygnus.com/ml/egcs-patches/2000-04/msg00332.html for a description
of the problem.  To use this patch there are two options.  Either patch the
compiler as suggested in the above posting (an incomplete but adequate for our
purposes patch) or remove the FASTCALLs from linux as done by the IKB patch.
I personally prefer the compiler patch so the patch below does not mess with
FASTCALLs.
****

With this patch gprof profiling typically goes like this.  You use kernprof
to select gprof profiling, the sampling rate and to enable data collection.
You then run your experiment and finally you use kernprof again to stop data
gathering and to generate a data file for gprof (gmon.out by default).  Then
you run gprof on the kernel binary (the vmlinux one) and the file produced by
kernprof.

kernprof itself is an extension of readprofile (and does what readprofile
does in addition to the gprof stuff).  We apologize for the lack of a manpage
at this time, one will be made available shortly.

Comments and suggestions are welcome.

---
Dimitris Michailidis
SGI Linux Group
dimitris@engr.sgi.com

diff -ruN /usr/src/linux-2.2.8/linux/Documentation/Configure.help /build2/dm/2.2.8-profile/Documentation/Configure.help
--- /usr/src/linux-2.2.8/linux/Documentation/Configure.help	Tue May 11 09:57:14 1999
+++ /build2/dm/2.2.8-profile/Documentation/Configure.help	Fri May 14 13:28:45 1999
@@ -9750,6 +9750,17 @@
   keys are documented in Documentation/sysrq.txt. Don't say Y unless
   you really know what this hack does.
 
+Extended Profiling Support
+CONFIG_EXTENDED_PROFILING
+  This option makes the kernel produce profiling data to support 
+  call graph profiling (with gprof) or stack trace profiling (future work).
+  When this option is enabled, the kernel is compiled with frame pointers.
+
+Kernel mcount() Instrumentation
+CONFIG_PROF_MCOUNT
+  This option arranges for the compiler to instrument the kernel with calls
+  to mcount().  This is needed to profile with gprof.
+
 ISDN subsystem
 CONFIG_ISDN
   ISDN ("Integrated Services Digital Networks", called RNIS in France)
diff -ruN /usr/src/linux-2.2.8/linux/Makefile /build2/dm/2.2.8-profile/Makefile
--- /usr/src/linux-2.2.8/linux/Makefile	Wed Apr 28 11:38:52 1999
+++ /build2/dm/2.2.8-profile/Makefile	Fri May 14 13:12:31 1999
@@ -86,7 +86,13 @@
 # standard CFLAGS
 #
 
-CFLAGS = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+CFLAGS = -Wall -Wstrict-prototypes -O2
+
+ifdef CONFIG_PROF_MCOUNT
+  CFLAGS += -pg
+else
+  CFLAGS += -fomit-frame-pointer
+endif
 
 ifdef CONFIG_SMP
 CFLAGS += -D__SMP__
diff -ruN /usr/src/linux-2.2.8/linux/arch/i386/config.in /build2/dm/2.2.8-profile/arch/i386/config.in
--- /usr/src/linux-2.2.8/linux/arch/i386/config.in	Mon Apr 26 13:49:17 1999
+++ /build2/dm/2.2.8-profile/arch/i386/config.in	Fri May 14 12:16:30 1999
@@ -199,5 +199,9 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Extended Profiling' CONFIG_EXTENDED_PROFILING
+if [ "$CONFIG_EXTENDED_PROFILING" = "y" ]; then
+  bool 'Instrument the kernel with calls to mcount()' CONFIG_PROF_MCOUNT y
+fi
 endmenu
 
diff -ruN /usr/src/linux-2.2.8/linux/arch/i386/kernel/Makefile /build2/dm/2.2.8-profile/arch/i386/kernel/Makefile
--- /usr/src/linux-2.2.8/linux/arch/i386/kernel/Makefile	Wed Jan 20 10:18:53 1999
+++ /build2/dm/2.2.8-profile/arch/i386/kernel/Makefile	Fri May 14 13:14:16 1999
@@ -18,6 +18,10 @@
 OX_OBJS  := i386_ksyms.o
 MX_OBJS  :=
 
+ifdef CONFIG_EXTENDED_PROFILING
+O_OBJS += profile.o
+endif
+
 ifdef CONFIG_PCI
 O_OBJS += bios32.o
 endif
@@ -52,5 +56,8 @@
 
 head.o: head.S $(TOPDIR)/include/linux/tasks.h
 	$(CC) -D__ASSEMBLY__ $(AFLAGS) -traditional -c $*.S -o $*.o
+
+profile.o: profile.c $(TOPDIR)/include/linux/profile.h
+	$(CC) $(subst -pg,,$(CFLAGS)) -c $<
 
 include $(TOPDIR)/Rules.make
diff -ruN /usr/src/linux-2.2.8/linux/arch/i386/kernel/irq.h /build2/dm/2.2.8-profile/arch/i386/kernel/irq.h
--- /usr/src/linux-2.2.8/linux/arch/i386/kernel/irq.h	Tue May 11 15:36:22 1999
+++ /build2/dm/2.2.8-profile/arch/i386/kernel/irq.h	Fri May 14 13:52:49 1999
@@ -3,6 +3,10 @@
 
 #include <asm/irq.h>
 
+#ifdef CONFIG_EXTENDED_PROFILING
+#include <linux/profile.h>
+#endif
+
 /*
  * Interrupt controller descriptor. This is all we need
  * to describe about the low-level hardware.
@@ -238,7 +242,12 @@
  */
 static inline void x86_do_profile (unsigned long eip)
 {
+#ifdef CONFIG_EXTENDED_PROFILING
+	if ((prof_params.state & (PROFILE_ON | PROF_PC)) == (PROFILE_ON | PROF_PC) &&
+	    current->pid) {
+#else
 	if (prof_buffer && current->pid) {
+#endif
 		eip -= (unsigned long) &_stext;
 		eip >>= prof_shift;
 		/*
diff -ruN /usr/src/linux-2.2.8/linux/arch/i386/kernel/profile.c /build2/dm/2.2.8-profile/arch/i386/kernel/profile.c
--- /usr/src/linux-2.2.8/linux/arch/i386/kernel/profile.c	Wed Dec 31 16:00:00 1969
+++ /build2/dm/2.2.8-profile/arch/i386/kernel/profile.c	Fri May 14 16:24:23 1999
@@ -0,0 +1,133 @@
+/*
+ * This file implements mcount().
+ *
+ * Copyright 1999, SGI
+ *
+ * Written by Dimitris Michailidis (dimitris@engr.sgi.com)
+ */
+
+#include <linux/profile.h>
+#include <asm/atomic.h>
+#include <asm/system.h>
+#include <asm/spinlock.h>
+#include <linux/tasks.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/config.h>
+
+struct profparam prof_params = { PROFILE_OFF };
+
+#ifdef CONFIG_PROF_MCOUNT
+
+#define NR_PROFILE_SPINLOCKS 	(1 << 10)
+#define PROFILE_SPINLOCK_MASK	(NR_PROFILE_SPINLOCKS - 1)
+
+static spinlock_t profile_locks[NR_PROFILE_SPINLOCKS];
+
+/*
+ * Atomically read "*lockaddr", add "inc" to that, write it back
+ * into "*lockaddr", and return the new value written.
+ */
+static __inline__ unsigned short
+atomicAddUShort(volatile unsigned short *lockaddr, unsigned short inc)
+{
+        register unsigned short oldval;
+
+        __asm__ __volatile__(
+                LOCK "xaddw %2,%0"
+                :"=m" (__atomic_fool_gcc(lockaddr)), "=r" (oldval)
+                :"1" (inc)
+                :"memory");
+        return(oldval + inc);
+}
+#define atomicIncUShort(x) atomicAddUShort(x, 1)
+
+void mcount(void)
+{
+	struct profparam *p;
+	struct tostruct *top;
+	unsigned long frompc, topc, flags;
+	int toindex;
+	spinlock_t *lock;
+	
+	__asm__ (
+		"pushl %eax\n\t"
+		"pushl %ecx\n\t"
+		"pushl %edx\n\t");
+	p = &prof_params;
+	if ((p->state & (PROFILE_ON | PROF_MCOUNT)) != (PROFILE_ON | PROF_MCOUNT))
+		goto done;
+
+	frompc = (unsigned long) __builtin_return_address(1) - p->lowpc;
+	if (frompc > p->textsize)
+		goto done;
+	frompc >>= LOG_HASHFRACTION;
+	topc = (unsigned long) __builtin_return_address(0);
+	for (toindex = p->froms[frompc]; toindex != 0; ) {
+		top = &p->tos[toindex];
+		if (top->selfpc == topc) {
+			atomic_inc((atomic_t *) &top->count);
+			goto done;
+		}
+		toindex = top->link;
+	}
+	
+	/* Need to add a new arc for this pc */
+	if (p->state & PROF_MCOUNT_OVERFLOW) goto done;
+	toindex = atomicIncUShort(&p->tos[0].link);
+	if (toindex >= p->tolimit) {
+		/* We have run out of space for arcs.  We'll keep
+		 * incrementing the existing arcs but we won't try to
+		 * add any more
+		 */
+		p->state |= PROF_MCOUNT_OVERFLOW;
+		p->tos[0].link = p->tolimit - 1;
+		goto done;
+	}
+	lock = &profile_locks[frompc & PROFILE_SPINLOCK_MASK];
+	top = &p->tos[toindex];
+	top->selfpc = topc;
+	top->count = 1;
+	spin_lock_irqsave(lock, flags);
+	top->link = p->froms[frompc];  // these two must happen atomically
+	p->froms[frompc] = toindex;
+	spin_unlock_irqrestore(lock, flags);
+	
+ done:  __asm__ (
+		"popl %edx\n\t"
+		"popl %ecx\n\t"
+		"popl %eax\n\t");
+}
+#endif
+
+long __init prof_init(long kmem_start, long kmem_end)
+{
+#ifdef CONFIG_PROF_MCOUNT
+	int i;
+	struct profparam *p = &prof_params;
+	extern char _stext, _etext;
+
+	p->freq = 1;
+	p->lowpc = ROUNDDOWN((unsigned long) &_stext, sizeof(long));
+	p->highpc = ROUNDUP((unsigned long) &_etext, sizeof(long));
+	p->textsize = p->highpc - p->lowpc;
+	p->fromssize = p->textsize / HASHFRACTION;
+	p->tolimit = p->textsize * ARCDENSITY / 100;
+	if (p->tolimit < MINARCS)
+		p->tolimit = MINARCS;
+	else if (p->tolimit > MAXARCS)
+		p->tolimit = MAXARCS;
+	p->tossize = p->tolimit * sizeof(struct tostruct);
+	p->tos = (struct tostruct *) kmem_start;
+	kmem_start += p->tossize;
+	memset(p->tos, 0, p->tossize);
+	p->froms = (unsigned short *) kmem_start;
+	kmem_start += p->fromssize;
+	memset((char *)p->froms, 0, p->fromssize);
+
+	for (i = 0; i < NR_PROFILE_SPINLOCKS; ++i)
+		profile_locks[i] = SPIN_LOCK_UNLOCKED;
+#endif
+
+	return kmem_start;
+}
diff -ruN /usr/src/linux-2.2.8/linux/arch/i386/kernel/smp.c /build2/dm/2.2.8-profile/arch/i386/kernel/smp.c
--- /usr/src/linux-2.2.8/linux/arch/i386/kernel/smp.c	Mon May 10 10:32:45 1999
+++ /build2/dm/2.2.8-profile/arch/i386/kernel/smp.c	Fri May 14 12:54:57 1999
@@ -1164,6 +1164,7 @@
 }
 
 unsigned int prof_multiplier[NR_CPUS];
+unsigned int prof_old_multiplier[NR_CPUS];
 unsigned int prof_counter[NR_CPUS];
 
 /*
@@ -1188,6 +1189,7 @@
 		cpu_number_map[i] = -1;
 		prof_counter[i] = 1;
 		prof_multiplier[i] = 1;
+		prof_old_multiplier[i] = 1;
 	}
 
 	/*
@@ -1733,6 +1735,10 @@
 	return 0;
 }
 
+static unsigned int calibration_result;
+
+void setup_APIC_timer(unsigned int clocks);
+
 /*
  * Local timer interrupt handler. It does both profiling and
  * process statistics/rescheduling.
@@ -1745,6 +1751,7 @@
 
 void smp_local_timer_interrupt(struct pt_regs * regs)
 {
+	int user = (user_mode(regs) != 0);
 	int cpu = smp_processor_id();
 
 	/*
@@ -1753,12 +1760,25 @@
 	 * updated with atomic operations). This is especially
 	 * useful with a profiling multiplier != 1
 	 */
-	if (!user_mode(regs))
+	if (!user)
 		x86_do_profile(regs->eip);
 
 	if (!--prof_counter[cpu]) {
-		int user=0,system=0;
+		int system = 1 - user;
 		struct task_struct * p = current;
+		
+		/* The multiplier may have changed since the last time we got
+		 * to this point as a result of the user writing to
+		 * /proc/profile.  In this case we need to adjust the APIC
+		 * timer accordingly.
+		 *
+		 * Interrupts are already masked off at this point.
+		 */
+		prof_counter[cpu] = prof_multiplier[cpu];
+		if (prof_counter[cpu] != prof_old_multiplier[cpu]) {
+			setup_APIC_timer(calibration_result/prof_counter[cpu]);
+			prof_old_multiplier[cpu] = prof_counter[cpu];
+		}
 
 		/*
 		 * After doing the above, we need to make like
@@ -1767,11 +1787,6 @@
 		 * WrongThing (tm) to do.
 		 */
 
-		if (user_mode(regs))
-			user=1;
-		else
-			system=1;
-
  		irq_enter(cpu, 0);
 		update_one_process(p, 1, user, system, cpu);
 		if (p->pid) {
@@ -1791,7 +1806,6 @@
 			kstat.per_cpu_system[cpu] += system;
 
 		}
-		prof_counter[cpu]=prof_multiplier[cpu];
 		irq_exit(cpu, 0);
 	}
 
@@ -2064,8 +2078,6 @@
 	return calibration_result;
 }
 
-static unsigned int calibration_result;
-
 void __init setup_APIC_clock(void)
 {
 	unsigned long flags;
@@ -2122,9 +2134,8 @@
  */
 int setup_profiling_timer(unsigned int multiplier)
 {
-	int cpu = smp_processor_id();
-	unsigned long flags;
-
+	int i;
+	
 	/*
 	 * Sanity check. [at least 500 APIC cycles should be
 	 * between APIC interrupts as a rule of thumb, to avoid
@@ -2133,11 +2144,14 @@
 	if ( (!multiplier) || (calibration_result/multiplier < 500))
 		return -EINVAL;
 
-	save_flags(flags);
-	cli();
-	setup_APIC_timer(calibration_result/multiplier);
-	prof_multiplier[cpu]=multiplier;
-	restore_flags(flags);
+	/* 
+	 * Set the new multiplier for each CPU.  CPUs don't start using the
+	 * new values until the next timer interrupt in which they do process
+	 * accounting.  At that time they also adjust their APIC timers
+	 * accordingly.
+	 */
+	for (i = 0; i < NR_CPUS; ++i)
+		prof_multiplier[i] = multiplier;
 
 	return 0;
 }
diff -ruN /usr/src/linux-2.2.8/linux/fs/proc/array.c /build2/dm/2.2.8-profile/fs/proc/array.c
--- /usr/src/linux-2.2.8/linux/fs/proc/array.c	Mon May 10 10:05:18 1999
+++ /build2/dm/2.2.8-profile/fs/proc/array.c	Fri May 14 14:28:18 1999
@@ -68,6 +68,10 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_EXTENDED_PROFILING
+#include <linux/profile.h>
+#endif
+
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 
@@ -149,6 +153,35 @@
  * buffer. Use of the program readprofile is recommended in order to
  * get meaningful info out of these data.
  */
+#ifdef CONFIG_EXTENDED_PROFILING
+static ssize_t read_profile(struct file *file, char *buf,
+			    size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	ssize_t read;
+	char * pnt;
+	unsigned int params[2];
+
+	if (p >= (prof_len + 2) * sizeof(unsigned int))
+		return 0;
+	if (count > (prof_len + 2) * sizeof(unsigned int) - p)
+		count = (prof_len + 2) * sizeof(unsigned int) - p;
+	read = 0;
+
+	params[0] = 1 << prof_shift;
+	params[1] = prof_params.freq;
+	
+	while (p < 2 * sizeof(unsigned int) && count > 0) {
+		put_user(*((char *)(&params) + p), buf);
+		buf++; p++; count--; read++;
+	}
+	pnt = (char *)prof_buffer + p - 2 * sizeof(unsigned int);
+	copy_to_user(buf, (void *)pnt, count);
+	read += count;
+	*ppos += read;
+	return read;
+}
+#else
 static ssize_t read_profile(struct file *file, char *buf,
 			    size_t count, loff_t *ppos)
 {
@@ -173,6 +206,7 @@
 	*ppos += read;
 	return read;
 }
+#endif
 
 /*
  * Writing to /proc/profile resets the counters
@@ -180,6 +214,60 @@
  * Writing a 'profiling multiplier' value into it also re-sets the profiling
  * interrupt frequency, on architectures that support this.
  */
+#ifdef CONFIG_EXTENDED_PROFILING
+static ssize_t write_profile(struct file * file, const char * buf,
+			     size_t count, loff_t *ppos)
+{
+	if (count==sizeof(int)) {
+		unsigned int cmd, val;
+		struct profparam *p = &prof_params;
+		
+		if (copy_from_user(&cmd, buf, sizeof(int)))
+			return -EFAULT;
+		val = cmd & 0xFFFFFF;
+		switch (cmd & 0xFF000000) {
+#ifdef __SMP__
+			case PROF_SET_FREQ:
+			{
+				extern int setup_profiling_timer (unsigned int multiplier);
+				
+				if (setup_profiling_timer(val))
+					return -EINVAL;
+				prof_params.freq = val;
+				break;
+			}
+#endif
+			case PROF_ENABLE:
+				p->state |= PROFILE_ON;
+				break;
+			case PROF_DISABLE:
+				p->state &= ~PROFILE_ON;
+				break;
+			case PROF_RESET:
+				memset(prof_buffer, 0, prof_len * sizeof(*prof_buffer));
+				memset(p->tos, 0, p->tossize);
+				memset((char *)p->froms, 0, p->fromssize);
+				p->state &= ~PROF_MCOUNT_OVERFLOW;
+				break;
+			case PROF_TYPE:
+				p->state &= ~PROF_TYPE_ALL;
+				if (val & PROF_PC) {
+					p->state |= PROF_PC;
+					if (val & PROF_MCOUNT)
+						p->state |= PROF_MCOUNT;
+				} else if (val & PROF_CALL_TRACE)
+					p->state |= PROF_CALL_TRACE;
+				break;
+			case PROF_DOMAIN:
+				break;
+			default:
+				return -EINVAL;
+		}
+	} else
+		memset(prof_buffer, 0, prof_len * sizeof(*prof_buffer));
+	return count;
+}
+#else
 static ssize_t write_profile(struct file * file, const char * buf,
 			     size_t count, loff_t *ppos)
 {
@@ -200,6 +288,7 @@
 	memset(prof_buffer, 0, prof_len * sizeof(*prof_buffer));
 	return count;
 }
+#endif
 
 static struct file_operations proc_profile_operations = {
 	NULL,           /* lseek */
@@ -211,6 +300,53 @@
 	&proc_profile_operations,
 };
 
+#ifdef CONFIG_PROF_MCOUNT
+
+static ssize_t read_froms(struct file *file, char *buf,
+			  size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+
+	if (p >= prof_params.fromssize) return 0;
+	if (count > prof_params.fromssize - p)
+		count = prof_params.fromssize - p;
+	copy_to_user(buf, (char *) prof_params.froms + p, count);
+	*ppos += count;
+	return count;
+}
+
+static struct file_operations proc_froms_operations = {
+	NULL,           /* lseek */
+	read_froms,
+};
+
+struct inode_operations proc_froms_inode_operations = {
+	&proc_froms_operations,
+};
+
+static ssize_t read_tos(struct file *file, char *buf,
+			size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+
+	if (p >= prof_params.tossize) return 0;
+	if (count > prof_params.tossize - p)
+		count = prof_params.tossize - p;
+	copy_to_user(buf, (char *) prof_params.tos + p, count);
+	*ppos += count;
+	return count;
+}
+
+static struct file_operations proc_tos_operations = {
+	NULL,           /* lseek */
+	read_tos,
+};
+
+struct inode_operations proc_tos_inode_operations = {
+	&proc_tos_operations,
+};
+
+#endif
 
 static int get_loadavg(char * buffer)
 {
diff -ruN /usr/src/linux-2.2.8/linux/fs/proc/root.c /build2/dm/2.2.8-profile/fs/proc/root.c
--- /usr/src/linux-2.2.8/linux/fs/proc/root.c	Wed Apr 28 08:47:39 1999
+++ /build2/dm/2.2.8-profile/fs/proc/root.c	Fri May 14 13:41:59 1999
@@ -21,6 +21,9 @@
 #ifdef CONFIG_ZORRO
 #include <linux/zorro.h>
 #endif
+#ifdef CONFIG_EXTENDED_PROFILING
+#include <linux/profile.h>
+#endif
 
 /*
  * Offset of the first process in the /proc root directory..
@@ -178,6 +181,16 @@
 };
 #endif
 
+#ifdef CONFIG_EXTENDED_PROFILING
+struct proc_dir_entry proc_prof_root = {
+	PROC_PROF, 4, "prof",
+	S_IFDIR | S_IRUGO | S_IXUGO, 2, 0, 0,
+	0, &proc_dir_inode_operations,
+	NULL, NULL,
+	NULL, &proc_root, NULL
+};
+#endif
+
 #if defined(CONFIG_SUN_OPENPROMFS) || defined(CONFIG_SUN_OPENPROMFS_MODULE)
 
 static int (*proc_openprom_defreaddir_ptr)(struct file *, void *, filldir_t);
@@ -653,6 +666,18 @@
 	S_IFREG | S_IRUGO | S_IWUSR, 1, 0, 0,
 	0, &proc_profile_inode_operations
 };
+#ifdef CONFIG_PROF_MCOUNT
+static struct proc_dir_entry proc_prof_froms = {
+	PROC_PROF_FROMS, 11, "gprof_froms",
+	S_IFREG | S_IRUGO, 1, 0, 0,
+	0, &proc_froms_inode_operations
+};
+static struct proc_dir_entry proc_prof_tos = {
+	PROC_PROF_TOS, 9, "gprof_tos",
+	S_IFREG | S_IRUGO, 1, 0, 0,
+	0, &proc_tos_inode_operations
+};
+#endif
 static struct proc_dir_entry proc_root_slab = {
 	PROC_SLABINFO, 8, "slabinfo",
 	S_IFREG | S_IRUGO, 1, 0, 0,
@@ -732,6 +757,15 @@
 	if (prof_shift) {
 		proc_register(&proc_root, &proc_root_profile);
 		proc_root_profile.size = (1+prof_len) * sizeof(unsigned int);
+#ifdef CONFIG_EXTENDED_PROFILING
+		proc_register(&proc_root, &proc_prof_root);
+#ifdef CONFIG_PROF_MCOUNT
+		proc_register(&proc_prof_root, &proc_prof_froms);
+		proc_prof_froms.size = prof_params.fromssize;
+		proc_register(&proc_prof_root, &proc_prof_tos);
+		proc_prof_tos.size = prof_params.tossize;
+#endif
+#endif
 	}
 
 	proc_tty_init();
diff -ruN /usr/src/linux-2.2.8/linux/include/linux/proc_fs.h /build2/dm/2.2.8-profile/include/linux/proc_fs.h
--- /usr/src/linux-2.2.8/linux/include/linux/proc_fs.h	Thu May 13 14:24:58 1999
+++ /build2/dm/2.2.8-profile/include/linux/proc_fs.h	Fri May 14 13:45:56 1999
@@ -52,6 +52,9 @@
 	PROC_STRAM,
 	PROC_SOUND,
 	PROC_MTRR, /* whether enabled or not */
+#ifdef CONFIG_EXTENDED_PROFILING
+	PROC_PROF,
+#endif
 	PROC_FS
 };
 
@@ -242,6 +245,15 @@
 	PROC_CODA_FS_LAST
 };
 
+#ifdef CONFIG_EXTENDED_PROFILING
+
+enum prof_directory_inos {
+	PROC_PROF_FROMS = PROC_CODA_FS_LAST,
+	PROC_PROF_TOS,
+	PROC_PROF_LAST
+};
+#endif
+
 /* Finally, the dynamically allocatable proc entries are reserved: */
 
 #define PROC_DYNAMIC_FIRST 4096
@@ -312,6 +324,9 @@
 extern struct proc_dir_entry proc_pid_fd;
 extern struct proc_dir_entry proc_mca;
 extern struct proc_dir_entry *proc_bus;
+#ifdef CONFIG_EXTENDED_PROFILING
+extern struct proc_dir_entry proc_prof_root;
+#endif
 
 extern struct inode_operations proc_scsi_inode_operations;
 
@@ -421,6 +436,10 @@
 #endif
 extern struct inode_operations proc_omirr_inode_operations;
 extern struct inode_operations proc_ppc_htab_inode_operations;
+#ifdef CONFIG_PROF_MCOUNT
+extern struct inode_operations proc_froms_inode_operations;
+extern struct inode_operations proc_tos_inode_operations;
+#endif
 
 /*
  * generic.c
diff -ruN /usr/src/linux-2.2.8/linux/include/linux/profile.h /build2/dm/2.2.8-profile/include/linux/profile.h
--- /usr/src/linux-2.2.8/linux/include/linux/profile.h	Wed Dec 31 16:00:00 1969
+++ /build2/dm/2.2.8-profile/include/linux/profile.h	Fri May 14 16:31:24 1999
@@ -0,0 +1,168 @@
+/*
+ * Copyright 1999, SGI
+ *
+ * Written by Dimitris Michailidis (dimitris@engr.sgi.com)
+ *
+ * Parts of this file are covered by the copyright below.
+ */
+
+/*
+ * Copyright (c) 1982, 1986, 1992, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Berkeley and its contributors.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ */
+
+#ifndef	_PROFILE_H_
+#define	_PROFILE_H_	1
+
+#include <linux/types.h>
+
+/*
+ * histogram counters are unsigned shorts (according to the kernel).
+ */
+#define	HISTCOUNTER	unsigned short
+
+/*
+ * fraction of text space to allocate for histogram counters here, 1/2
+ */
+#define	HISTFRACTION	2
+
+struct tostruct {
+	u_long	selfpc;
+	long	count;
+	u_short	link;
+	u_short pad;
+};
+
+/*
+ * a raw arc, with pointers to the calling site and
+ * the called site and a count.
+ */
+struct rawarc {
+	u_long	raw_frompc;
+	u_long	raw_selfpc;
+	long	raw_count;
+};
+
+/*
+ * general rounding functions.
+ */
+#define ROUNDDOWN(x,y)	(((x)/(y))*(y))
+#define ROUNDUP(x,y)	((((x)+(y)-1)/(y))*(y))
+
+/*
+ * Fraction of text space to allocate for from hash buckets.
+ * The value of HASHFRACTION is based on the minimum number of bytes
+ * of separation between two subroutine call points in the object code.
+ * Given MIN_SUBR_SEPARATION bytes of separation the value of
+ * HASHFRACTION is calculated as:
+ *
+ *	HASHFRACTION = MIN_SUBR_SEPARATION / (2 * sizeof(short) - 1);
+ *
+ * For example, on the VAX, the shortest two call sequence is:
+ *
+ *	calls	$0,(r0)
+ *	calls	$0,(r0)
+ *
+ * which is separated by only three bytes, thus HASHFRACTION is
+ * calculated as:
+ *
+ *	HASHFRACTION = 3 / (2 * 2 - 1) = 1
+ *
+ * Note that the division above rounds down, thus if MIN_SUBR_FRACTION
+ * is less than three, this algorithm will not work!
+ *
+ * In practice, however, call instructions are rarely at a minimal
+ * distance.  Hence, we will define HASHFRACTION to be 2 across all
+ * architectures.  This saves a reasonable amount of space for
+ * profiling data structures without (in practice) sacrificing
+ * any granularity.
+ */
+#define	HASHFRACTION		2
+
+#ifdef __KERNEL__
+
+/* This constant is the base 2 log of (HASHFRACTION * sizeof(u_short)) */
+#define LOG_HASHFRACTION	2
+
+/*
+ * Maximum number of processors we can handle.  This is important for the 
+ * proper operation of mcount, so if we ever need more processore we must
+ * inrease this.
+ */
+#define MAX_PROCS	256
+
+/*
+ * percent of text space to allocate for tostructs with a minimum.
+ */
+#define ARCDENSITY	2
+#define MINARCS		50
+#define MAXARCS		((1 << (8 * sizeof(HISTCOUNTER))) - (MAX_PROCS + 1))
+
+/*
+ * The profiling data structures are housed in this structure.
+ */
+struct profparam {
+	int		 state;           /* this is a bitfield */
+	unsigned int	 freq;		  /* multiplier for local APIC */
+	volatile u_short *froms;
+	u_long		 fromssize;
+	struct tostruct	 *tos;
+	u_long		 tossize;
+	long		 tolimit;
+	u_long		 lowpc;
+	u_long		 highpc;
+	u_long		 textsize;
+};
+extern struct profparam prof_params;
+
+#endif
+
+/*
+ * Possible states of profiling.
+ */
+#define PROFILE_OFF		0
+#define PROFILE_ON		1
+#define PROF_MCOUNT_OVERFLOW	128
+#define PROF_MCOUNT		256
+#define PROF_PC			512
+#define PROF_CALL_TRACE		1024
+
+#define PROF_TYPE_ALL	(PROF_MCOUNT | PROF_PC | PROF_CALL_TRACE)
+
+#define PROF_SET_FREQ	0x0
+#define PROF_ENABLE	0x01000000	
+#define PROF_DISABLE	0x02000000
+#define PROF_RESET	0x03000000
+#define PROF_TYPE	0x04000000
+#define PROF_DOMAIN	0x05000000
+
+#endif /* !_PROFILE_H_ */
diff -ruN /usr/src/linux-2.2.8/linux/init/main.c /build2/dm/2.2.8-profile/init/main.c
--- /usr/src/linux-2.2.8/linux/init/main.c	Tue May 11 09:57:14 1999
+++ /build2/dm/2.2.8-profile/init/main.c	Fri May 14 13:00:18 1999
@@ -50,6 +50,10 @@
 extern void nubus_init(void);
 #endif
 
+#ifdef CONFIG_EXTENDED_PROFILING
+#include <linux/profile.h>
+#endif
+
 /*
  * Versions of gcc older than that listed below may actually compile
  * and link okay, but the end product can have subtle run time bugs.
@@ -344,6 +348,10 @@
 extern void md_setup(char *str,int *ints) __init;
 #endif
 
+#ifdef CONFIG_EXTENDED_PROFILING
+extern long prof_init(long, long);
+#endif
+
 /*
  * Boot command-line arguments
  */
@@ -1153,8 +1161,13 @@
 		/* only text is profiled */
 		prof_len = (unsigned long) &_etext - (unsigned long) &_stext;
 		prof_len >>= prof_shift;
+		/* add one bucket for symbols past _etext, e.g. for modules */
+		prof_len++;
 		memory_start += prof_len * sizeof(unsigned int);
 		memset(prof_buffer, 0, prof_len * sizeof(unsigned int));
+#ifdef CONFIG_EXTENDED_PROFILING
+                memory_start = prof_init(memory_start, memory_end);
+#endif
 	}
 
 	memory_start = kmem_cache_init(memory_start, memory_end);
diff -ruN /usr/src/linux-2.2.8/linux/scripts/gmon_out.h /build2/dm/2.2.8-profile/scripts/gmon_out.h
--- /usr/src/linux-2.2.8/linux/scripts/gmon_out.h	Wed Dec 31 16:00:00 1969
+++ /build2/dm/2.2.8-profile/scripts/gmon_out.h	Fri May 14 13:29:51 1999
@@ -0,0 +1,77 @@
+/* Copyright (C) 1996, 1997 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by David Mosberger <davidm@cs.arizona.edu>.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Library General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Library General Public License for more details.
+
+   You should have received a copy of the GNU Library General Public
+   License along with the GNU C Library; see the file COPYING.LIB.  If not,
+   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+   Boston, MA 02111-1307, USA.  */
+
+/* This file specifies the format of gmon.out files.  It should have
+   as few external dependencies as possible as it is going to be included
+   in many different programs.  That is, minimize the number of #include's.
+
+   A gmon.out file consists of a header (defined by gmon_hdr) followed by
+   a sequence of records.  Each record starts with a one-byte tag
+   identifying the type of records, followed by records specific data. */
+
+#ifndef _SYS_GMON_OUT_H
+
+#define _SYS_GMON_OUT_H	1
+#include <features.h>
+
+#define	GMON_MAGIC	"gmon"	/* magic cookie */
+#define GMON_VERSION	1	/* version number */
+
+__BEGIN_DECLS
+
+/*
+ * Raw header as it appears on file (without padding).  This header
+ * always comes first in gmon.out and is then followed by a series
+ * records defined below.
+ */
+struct gmon_hdr
+  {
+    char cookie[4];
+    char version[4];
+    char spare[3 * 4];
+  };
+
+/* types of records in this file: */
+typedef enum
+  {
+    GMON_TAG_TIME_HIST = 0,
+    GMON_TAG_CG_ARC = 1,
+    GMON_TAG_BB_COUNT = 2
+  } GMON_Record_Tag;
+
+struct gmon_hist_hdr
+  {
+    char low_pc[sizeof (char *)];	/* base pc address of sample buffer */
+    char high_pc[sizeof (char *)];	/* max pc address of sampled buffer */
+    char hist_size[4];			/* size of sample buffer */
+    char prof_rate[4];			/* profiling clock rate */
+    char dimen[15];			/* phys. dim., usually "seconds" */
+    char dimen_abbrev;			/* usually 's' for "seconds" */
+  };
+
+struct gmon_cg_arc_record
+  {
+    char from_pc[sizeof (char *)];	/* address within caller's body */
+    char self_pc[sizeof (char *)];	/* address within callee's body */
+    char count[4];			/* number of arc traversals */
+};
+
+__END_DECLS
+
+#endif /* _SYS_GMON_OUT_H */
diff -ruN /usr/src/linux-2.2.8/linux/scripts/kernprof.c /build2/dm/2.2.8-profile/scripts/kernprof.c
--- /usr/src/linux-2.2.8/linux/scripts/kernprof.c	Wed Dec 31 16:00:00 1969
+++ /build2/dm/2.2.8-profile/scripts/kernprof.c	Fri May 14 16:37:17 1999
@@ -0,0 +1,571 @@
+/*
+ *  kernprof.c - control kernel profiling.
+ *
+ *  Copyright (C) 1999 SGI
+ *
+ *  Written by Dimitris Michailidis (dimitris@engr.sgi.com)
+ *
+ *  Based on readprofile by Alessandro Rubini.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/uio.h>
+#include <fcntl.h>
+#include <time.h>
+
+#include "../include/linux/profile.h"
+#include "../include/asm/param.h"
+#include "gmon_out.h"
+
+#define S_LEN 128
+
+static char *prgname;
+
+/* These are the defaults */
+static char defaultmap[] = "/usr/src/linux/System.map";
+static char defaultpro[] = "/proc/profile";
+
+void usage()
+{
+   fprintf(stderr,
+	   "Usage: \"%s [options]\n"
+	   "\t -f <sample_freq> (default = 1)\n"
+	   "\t -m <mapfile>     (default = \"%s\")\n"
+	   "\t -o <out file>\n"
+	   "\t -p <pro-file>    (default = \"%s\")\n"
+	   "\t -t [pc | gprof]  select profiling type\n"
+	   "\t -b               start profiling (root only)\n"
+	   "\t -c               output prof profiling data\n"
+	   "\t -e               stop profiling (root only)\n"
+	   "\t -g               output gprof profiling data\n"
+	   "\t -i               output PC profiling data\n"
+	   "\t -r               reset profiling counters (root only)\n"
+	   "\t -s               print the PC sampling step\n",
+	   prgname, defaultmap, defaultpro);
+   exit(1);
+}
+
+FILE *myopen(const char *name, const char *mode, int *flag)
+{
+   static char cmdline[S_LEN];
+   
+   if (!strcmp(name + strlen(name) - 3, ".gz"))
+   {
+      *flag=1;
+      sprintf(cmdline, "zcat %s", name);
+      return popen(cmdline, mode);
+   }
+   *flag = 0;
+   return fopen(name, mode);
+}
+
+static void write_prf_cmd(int pro_fd, int cmd)
+{
+   if (write(pro_fd, &cmd, sizeof(int)) != sizeof(int)) {
+      perror(defaultpro);
+      exit(1);
+   }
+}
+
+static int open_prf(const char *name, int mode)
+{
+   int f;
+   
+   setuid(0);                    /* try to become root, just in case */
+   if ((f = open(name, mode)) == -1) {
+      perror(name);
+      exit(1);
+   }
+   return f;
+}
+
+static void start_profile()
+{
+   int pro = open_prf(defaultpro, O_WRONLY);
+   
+   write_prf_cmd(pro, PROF_ENABLE);
+   close(pro);
+}
+
+static void stop_profile()
+{
+   int pro = open_prf(defaultpro, O_WRONLY);
+   
+   write_prf_cmd(pro, PROF_DISABLE);
+   close(pro);
+}
+
+static void reset_profile_info()
+{
+   int pro;
+   struct timespec t;
+   
+   pro = open_prf(defaultpro, O_WRONLY);
+   write_prf_cmd(pro, PROF_DISABLE);
+   t.tv_sec = 0;
+   t.tv_nsec = 10000;
+   nanosleep(&t, NULL);          /* to avoid race conditions */
+   write_prf_cmd(pro, PROF_RESET);
+   close(pro);
+}
+
+static void set_profile_freq(unsigned int mult)
+{
+   int pro = open_prf(defaultpro, O_WRONLY);
+   
+   write_prf_cmd(pro, (mult & 0xFFFFFF) | PROF_SET_FREQ);
+   close(pro);
+}
+
+static void set_prof_type(unsigned int type)
+{
+   int pro;
+   
+   reset_profile_info();  /* setting the type resets all profiling info */
+   pro = open_prf(defaultpro, O_WRONLY);
+   write_prf_cmd(pro, type | PROF_TYPE);
+   close(pro);
+}
+
+static void show_sampling_step(const char *proFile)
+{
+   int pro, step;
+   
+   pro = open_prf(proFile, O_RDONLY);
+   if (read(pro, (char *) &step, sizeof(int)) != sizeof(int)) {
+      perror(proFile);
+      exit(1);
+   }
+   printf("PC sampling step is %i\n", step);
+}
+
+static int get_prof_freq(const char *proFile)
+{
+   int pro, mult;
+   
+   pro = open_prf(proFile, O_RDONLY);
+   if (lseek(pro, sizeof(int), SEEK_SET) < 0 || 
+       read(pro, (char *) &mult, sizeof(int)) != sizeof(int)) {
+      perror(proFile);
+      exit(1);
+   }
+   return mult * HZ;
+}
+
+static void show_sampling_freq(const char *proFile)
+{
+  printf("sampling frequency is %iHz\n", get_prof_freq(proFile));
+}
+
+static unsigned int *read_PC_profiling_data(const char *proFile, int *lenp)
+{
+   unsigned int *buf;
+   int pro, len;
+   
+   if (((pro = open(proFile, O_RDONLY)) < 0)
+       || ((int)(len = lseek(pro, 0, SEEK_END)) < 0)
+       || (lseek(pro, 0, SEEK_SET) < 0)) {
+      perror(proFile);
+      exit(1);
+   }
+  
+   if ((buf = malloc(len)) == NULL) {
+      perror("malloc");
+      exit(1);
+   }
+
+   if (read(pro, buf, len) != len)
+   {
+      perror(proFile);
+      exit(1);
+   }
+   close(pro);
+   *lenp = len;
+   return buf;
+}
+
+static unsigned int get_symbol_address(FILE *fp, const char *name)
+{
+   char mapline[S_LEN], fn_name[S_LEN], mode[8];
+   unsigned int fn_add;
+   
+   while (fgets(mapline, S_LEN, fp)) {
+      if (sscanf(mapline, "%x %s %s", &fn_add, mode, fn_name) != 3) {
+	 fprintf(stderr,"%s: corrupt map file\n", prgname);
+	 exit(1);
+      }
+      if (!strcmp(fn_name, name))
+	 return fn_add;
+   }
+   return 0;
+}
+
+static void output_pc_profile(const char *proFile, const char *mapFile,
+			      const char *outFile)
+{
+   int len;
+   int popenMap;                /* flag to tell if popen() has been used */
+   char mapline[S_LEN];
+   unsigned int add0 = 0, step;
+   unsigned int index = 1;      /* skip the profiling frequency */
+   unsigned int *buf, fn_len;
+   unsigned int fn_add, next_add;           /* current and next address */
+   char fn_name[S_LEN], next_name[S_LEN];   /* current and next name */
+   char mode[8];
+   FILE *map, *out;
+   
+   buf = read_PC_profiling_data(proFile, &len);
+   
+   if ((map = myopen(mapFile, "r", &popenMap)) == NULL) {
+      perror(mapFile);
+      exit(1);
+   }
+   if (outFile == NULL)
+      out = stdout;
+   else if ((out = fopen(outFile, "w")) == NULL) {
+      perror(outFile);
+      exit(1);
+   }
+   
+   strcpy(fn_name, "_stext");
+   add0 = fn_add = get_symbol_address(map, fn_name);
+   if (!add0) {
+      fprintf(stderr, "%s: can't find \"_stext\" in %s\n", prgname, mapFile);
+      exit(1);
+   }
+   step = buf[0];
+
+   /*
+    * Main loop.
+    */
+   while(fgets(mapline, S_LEN, map))
+   {
+      unsigned int this = 0;
+      unsigned int start_index;
+     
+      if (sscanf(mapline, "%x %s %s", &next_add, mode, next_name) != 3) {
+	 fprintf(stderr, "%s: corrupt map file\n", prgname);
+	 exit(1);
+      }
+      
+      /* We process the bins twice so we can report totals for each function */
+      start_index = index;
+      while (index < (next_add - add0) / step) {
+	 this += buf[++index];
+      }
+      if (this > 0) {
+	 index = start_index;
+	 fprintf(out, "%s [%08X]: %u\n", fn_name, fn_add, this);
+	
+	 while (index < (next_add - add0) / step) {
+	    if (buf[index + 1] != 0) {
+	       fprintf(out, "    %08X\t%d\n", add0 + index * step, buf[index + 1]);
+	    }
+	    ++index;
+	 }
+      }
+      
+      fn_len = next_add - fn_add;
+      fn_add = next_add;
+      strcpy(fn_name, next_name);
+      if (*mode != 'T' && *mode != 't') break; /* only text is profiled */
+   }
+  
+   /* The last bucket represents all the addresses past _etext, eg modules */
+   if (buf[(len / sizeof(unsigned int)) - 1])
+      fprintf(out, "Other: %u\n", buf[(len / sizeof(unsigned int)) - 1]);
+  
+   popenMap ? pclose(map) : fclose(map);
+   free(buf);
+}
+
+static void write_gprof_pc_hist(int fd, u_int lowpc, u_int highpc)
+{
+   u_char tag = GMON_TAG_TIME_HIST;
+   struct gmon_hist_hdr thdr __attribute__ ((aligned (__alignof__ (char *))));
+   unsigned int *buf, *p;
+   int i, len, hist_size;
+   HISTCOUNTER *b;
+   
+   buf = read_PC_profiling_data(defaultpro, &len);
+   
+   /* drop the first two and the last entries of buf */
+   len -= 3 * sizeof(unsigned long);
+   hist_size = len / sizeof(unsigned long);
+   
+#ifdef DEBUG
+   printf("gprof lowpc = %0x, highpc = %0x, %i buckets\n",
+	  lowpc, highpc, hist_size);
+#endif
+
+   /* gprof history buckets are of type HISTCOUNTER so we need to convert
+    * our data */
+   b = (HISTCOUNTER *) p = &buf[2];
+#ifdef DEBUG
+   for (i = 0; i < hist_size; ++i)
+      printf("bucket %i has %i hits\n", i, p[i]);
+#endif
+   for (i = 0; i < hist_size; ++i)
+      b[i] = p[i];
+#ifdef DEBUG
+   for (i = 0; i < hist_size; ++i)
+      printf("bucket %i has %hi hits\n", i, b[i]);
+#endif
+   
+   {
+      struct iovec iov[3] = {
+	 { &tag, sizeof(tag) },
+	 { &thdr, sizeof(struct gmon_hist_hdr) },
+	 { &buf[2], hist_size * sizeof(HISTCOUNTER) }
+      };
+      
+      *(char **) thdr.low_pc = (char *) lowpc;
+      *(char **) thdr.high_pc = (char *) highpc;
+      *(int *) thdr.hist_size = hist_size;
+      *(int *) thdr.prof_rate = get_prof_freq(defaultpro);
+      strncpy(thdr.dimen, "seconds", sizeof(thdr.dimen));
+      thdr.dimen_abbrev = 's';
+      
+      writev (fd, iov, 3);
+   }
+   free(buf);
+}
+
+static char *read_gprof_data(const char *name, int *lenp)
+{
+   char *buf;
+   int fd, len;
+   
+   if (((fd = open(name, O_RDONLY)) < 0)
+       || ((int)(len = lseek(fd, 0, SEEK_END)) < 0)
+       || (lseek(fd, 0, SEEK_SET) < 0)) {
+      perror(name);
+      exit(1);
+   }
+  
+   if ((buf = malloc(len)) == NULL) {
+      perror("malloc");
+      exit(1);
+   }
+
+   if (read(fd, buf, len) != len)
+   {
+      perror(name);
+      exit(1);
+   }
+   close(fd);
+   if (lenp) *lenp = len;
+   return buf;
+}
+
+#define GPROF_FROMS_NAME "/proc/prof/gprof_froms"
+#define GPROF_TOS_NAME	 "/proc/prof/gprof_tos"
+
+static void write_gprof_call_graph(int fd, u_int lowpc) 
+{
+   u_char tag = GMON_TAG_CG_ARC;
+   struct gmon_cg_arc_record raw_arc[4]
+      __attribute__ ((aligned (__alignof__ (char*))));
+   int from_index, to_index, from_len;
+   u_long frompc;
+   unsigned short *froms;
+   struct tostruct *tos;
+
+   struct iovec iov[8] = {
+      { &tag, sizeof(tag) },
+      { &raw_arc[0], sizeof(struct gmon_cg_arc_record) },
+      { &tag, sizeof(tag) },
+      { &raw_arc[1], sizeof(struct gmon_cg_arc_record) },
+      { &tag, sizeof(tag) },
+      { &raw_arc[2], sizeof(struct gmon_cg_arc_record) },
+      { &tag, sizeof(tag) },
+      { &raw_arc[3], sizeof(struct gmon_cg_arc_record) },
+   };
+   int nfilled = 0;
+
+   froms = (u_short *) read_gprof_data(GPROF_FROMS_NAME, &from_len);
+   from_len /= sizeof(unsigned short);
+
+   tos = (struct tostruct *) read_gprof_data(GPROF_TOS_NAME, NULL);
+#ifdef DEBUG
+   printf("%hi arcs recorded\n", tos[0].link);
+#endif
+
+   for (from_index = 0; from_index < from_len; ++from_index) {
+      if (froms[from_index] == 0)
+	 continue;
+
+      frompc = lowpc + from_index * HASHFRACTION * sizeof(unsigned short);
+#ifdef DEBUG
+      printf("calls made from address %0x\n", frompc);
+#endif
+      for (to_index = froms[from_index]; to_index != 0;
+	   to_index = tos[to_index].link) {
+	 if (nfilled > 3) {
+	    writev (fd, iov, 2 * nfilled);
+	    nfilled = 0;
+	 }
+	 *(char **) raw_arc[nfilled].from_pc = (char *)frompc;
+	 *(char **) raw_arc[nfilled].self_pc =
+	    (char *)tos[to_index].selfpc;
+	 *(int *) raw_arc[nfilled].count = tos[to_index].count;
+	 ++nfilled;
+      }
+   }
+   writev (fd, iov, 2 * nfilled);
+}
+
+static void write_gprof_hdr(int fd)
+{
+    struct gmon_hdr ghdr __attribute__ ((aligned (__alignof__ (int))));
+
+    /* write gmon.out header: */
+    memset (&ghdr, 0, sizeof (struct gmon_hdr));
+    memcpy (&ghdr.cookie[0], GMON_MAGIC, sizeof (ghdr.cookie));
+    *(int *) ghdr.version = GMON_VERSION;
+    write (fd, &ghdr, sizeof (struct gmon_hdr));
+}
+
+static char defaultGprofOutFile[] = "gmon.out";
+
+static void output_gprof_profile(const char *outFile, const char *mapFile)
+{
+   int fd, popenMap;
+   unsigned int lowpc, highpc;
+   FILE *map;
+   
+   if ((map = myopen(mapFile, "r", &popenMap)) == NULL) {
+      perror(mapFile);
+      exit(1);
+   }
+   if ((lowpc = get_symbol_address(map, "_stext")) == 0) {
+      fprintf(stderr, "%s: can't find \"_stext\" in %s\n", prgname, mapFile);
+      exit(1);
+   }
+   if ((highpc = get_symbol_address(map, "_etext")) == 0) {
+      fprintf(stderr, "%s: can't find \"_etext\" in %s\n", prgname, mapFile);
+      exit(1);
+   }
+   popenMap ? pclose(map) : fclose(map);
+
+   if ((fd = creat(outFile, 0666)) == 0) {
+      perror(outFile);
+      exit(1);
+   }
+   stop_profile();     /* to avoid any race conditions and freeze the data */
+   write_gprof_hdr(fd);
+   write_gprof_pc_hist(fd, lowpc, highpc);
+   write_gprof_call_graph(fd, lowpc);
+   close(fd);
+}
+
+int main (int argc, char **argv)
+{
+   static char optstring[] = "m:p:f:o:t:bceigrs";
+
+   char *mapFile, *proFile, *outFile;
+   char *freq = NULL, *type = NULL;
+   int c;
+   int optInfo = 0, optReset = 0, optPC = 0, optStart = 0, optStop = 0;
+   int optGprof = 0, optProf = 0;
+   
+   prgname = argv[0];
+   proFile = defaultpro;
+   mapFile = defaultmap;
+   outFile = NULL;
+   
+   while ((c = getopt(argc, argv, optstring)) != -1)
+   {
+      switch(c)
+      {
+	 case 'm': mapFile = optarg; break;
+	 case 'o': outFile = optarg; break;
+	 case 'p': proFile = optarg; break;
+	 case 't': type = optarg;    break;
+	 case 'b': optStart++;       break;
+	 case 'e': optStop++;        break;
+	 case 'f': freq = optarg;    break;
+	 case 's': optInfo++;        break;
+	 case 'r': optReset++;       break;
+	 case 'i': optPC++;          break;
+	 case 'g': optGprof++;       break;
+	 case 'c': optProf++;        break;
+	 default: usage();
+      }
+   }
+   
+   if (optStop) {
+      stop_profile();
+   }
+   
+   if (optReset) {
+      reset_profile_info();
+   }
+   
+   if (type) {
+      if (!strcmp(type, "pc"))
+	 set_prof_type(PROF_PC);
+      else if (!strcmp(type, "gprof"))
+	 set_prof_type(PROF_PC | PROF_MCOUNT);
+      else if (!strcmp(type, "prof"))
+	 set_prof_type(PROF_CALL_TRACE);
+      else {
+	 fprintf(stderr, "%s: unsupported profiling type %s\n", prgname, type);
+	 exit(1);
+      }
+   }
+	 
+   if (freq) {
+      unsigned int step;
+      char *endp;
+      
+      if ((step = strtoul(freq, &endp, 10)) == 0 || *endp) {
+	 fprintf(stderr, "%s: -f takes an unsigned integer\n", prgname);
+	 exit(1);
+      }
+      set_profile_freq(step);
+   }
+   
+   if (optStart) {
+      start_profile();
+   }
+   
+   if (optInfo) {
+      show_sampling_step(proFile);
+      show_sampling_freq(proFile);
+   }
+   
+   if (optPC) {
+      output_pc_profile(proFile, mapFile, outFile);
+      exit(0);
+   }
+
+   if (optGprof) {
+      if (!outFile)
+	 outFile = defaultGprofOutFile;
+      output_gprof_profile(outFile, mapFile);
+      exit(0);
+   }
+}
+
+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
