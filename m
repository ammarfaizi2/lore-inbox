Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTBPQCO>; Sun, 16 Feb 2003 11:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbTBPQCO>; Sun, 16 Feb 2003 11:02:14 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:47806 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267104AbTBPQCC>;
	Sun, 16 Feb 2003 11:02:02 -0500
Message-ID: <3E4FB7C0.8070900@colorfullife.com>
Date: Sun, 16 Feb 2003 17:09:36 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, davem@redhat.com,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re:  lockups with 2.4.20 (tg3? net/core/dev.c|deliver_to_old_ones)
Content-Type: multipart/mixed;
 boundary="------------070909050204060601000404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070909050204060601000404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pete wrote:

>I think the best resolution would be an instrumentation patch
>which records lock takers, and prints them when the thing is
>forcefuly oopsed. I should come with it eventually, if someone
>does not beat me to it (I wish they did, actually :-)
>  
What about the attached patch?
I'm not 100% that I've catched everyone that does 
spin_lock();_raw_spin_unlock(), and print_events() is not yet called 
from the oops/nmi codepath (How should it handle bust_spinlocks?)

Not really tested - boots bochs, print_events() output looks sane when 
manually triggered.

--
	Manfred

--------------070909050204060601000404
Content-Type: text/plain;
 name="patch-eventlog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-eventlog"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 61
//  EXTRAVERSION =
--- 2.5/arch/i386/Kconfig	2003-02-15 10:29:10.000000000 +0100
+++ build-2.5/arch/i386/Kconfig	2003-02-16 16:34:58.000000000 +0100
@@ -1623,6 +1623,15 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config DEBUG_EVENTLOG
+	bool "Eventlog for deadlock analysis"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to log spinlock and rwlock calls of all cpus. This is
+	  best used in conjunction with the NMI watchlog or a kernel debugger
+	  so that the event log is actually accessable. This option causes a
+	  noticable overhead, disable for production systems.
+
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
--- 2.5/include/asm-i386/processor.h	2003-01-03 22:37:44.000000000 +0100
+++ build-2.5/include/asm-i386/processor.h	2003-02-16 16:34:58.000000000 +0100
@@ -472,7 +472,11 @@
 	__asm__ __volatile__("rep;nop": : :"memory");
 }
 
-#define cpu_relax()	rep_nop()
+#define cpu_relax()	\
+		do { \
+			save_event(EVENT_CPU_RELAX, NULL); \
+			rep_nop(); \
+		} while(0)
 
 /* Prefetch instructions for Pentium III and AMD Athlon */
 #ifdef 	CONFIG_X86_PREFETCH
--- 2.5/kernel/exit.c	2003-02-15 10:29:24.000000000 +0100
+++ build-2.5/kernel/exit.c	2003-02-16 16:34:58.000000000 +0100
@@ -709,6 +709,7 @@
 	 * preempt here).
 	 */
 	_raw_write_unlock(&tasklist_lock);
+	save_event(EVENT_WRITE_LOCK_RELEASE,&tasklist_lock);
 }
 
 NORET_TYPE void do_exit(long code)
--- 2.5/kernel/sched.c	2003-02-15 10:29:24.000000000 +0100
+++ build-2.5/kernel/sched.c	2003-02-16 16:34:58.000000000 +0100
@@ -1888,6 +1888,7 @@
 	 * no need to preempt:
 	 */
 	_raw_spin_unlock(&rq->lock);
+	save_event(EVENT_SPINLOCK_RELEASE,&rq->lock);
 	preempt_enable_no_resched();
 
 	schedule();
diff -uN --exclude autoconf.h --exclude compile.h --exclude version.h 2.5/include/linux/brlock.h build-2.5/include/linux/brlock.h
--- 2.5/include/linux/brlock.h	2002-11-04 23:30:22.000000000 +0100
+++ build-2.5/include/linux/brlock.h	2003-02-16 16:34:58.000000000 +0100
@@ -86,7 +86,9 @@
 		__br_lock_usage_bug();
 
 	preempt_disable();
+	save_event(EVENT_READ_LOCK_BEFORE,&__brlock_array[smp_processor_id()][idx]);
 	_raw_read_lock(&__brlock_array[smp_processor_id()][idx]);
+	save_event(EVENT_READ_LOCK,&__brlock_array[smp_processor_id()][idx]);
 }
 
 static inline void br_read_unlock (enum brlock_indices idx)
diff -uN --exclude autoconf.h --exclude compile.h --exclude version.h 2.5/include/linux/eventlog.h build-2.5/include/linux/eventlog.h
--- 2.5/include/linux/eventlog.h	1970-01-01 01:00:00.000000000 +0100
+++ build-2.5/include/linux/eventlog.h	2003-02-16 16:34:58.000000000 +0100
@@ -0,0 +1,75 @@
+#ifndef __LINUX_EVENTLOG_H
+#define __LINUX_EVENTLOG_H
+/*
+ * eventlog.h - log deadlock prone events, to simplify deadlock diagnostics
+ *
+ * Copyright (C) 2003 Manfred Spraul
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+#include <linux/stringify.h>
+
+/* events that are pushed/poped on the eventstack */
+#define EVENT_STACK_PUSH		0x10000
+#define EVENT_STACK_POP			0x20000
+#define EVENT_STACK_REPLACE		0x40000
+
+#define EVENT_SPINLOCK_BEFORE		(0x0011|EVENT_STACK_PUSH)
+#define EVENT_SPINLOCK			(0x0012|EVENT_STACK_REPLACE)
+#define EVENT_SPIN_TRYLOCK_SUCCESS	(0x0013|EVENT_STACK_PUSH)
+#define EVENT_SPIN_TRYLOCK_FAILED	(0x0014)
+#define EVENT_SPINLOCK_RELEASE		(0x0015|EVENT_STACK_POP)
+#define EVENT_READ_LOCK_BEFORE		(0x0021|EVENT_STACK_PUSH)
+#define EVENT_READ_LOCK			(0x0022|EVENT_STACK_REPLACE)
+#define EVENT_READ_LOCK_RELEASE		(0x0023|EVENT_STACK_POP)
+#define EVENT_WRITE_LOCK_BEFORE		(0x0031|EVENT_STACK_PUSH)
+#define EVENT_WRITE_TRYLOCK_SUCCESS	(0x0032|EVENT_STACK_PUSH)
+#define EVENT_WRITE_TRYLOCK_FAILED	(0x0033)
+#define EVENT_WRITE_LOCK		(0x0034|EVENT_STACK_REPLACE)
+#define EVENT_WRITE_LOCK_RELEASE	(0x0035|EVENT_STACK_POP)
+#define EVENT_CPU_RELAX			(0x0041)
+
+#ifdef CONFIG_DEBUG_EVENTLOG
+
+#define save_event(type,object) \
+		do { \
+			store_event(type, __FILE__, __LINE__, __stringify(object), object); \
+		} while(0)
+
+void store_event(int type, char *file, int line, char *object_name, void *object_addr);
+void print_events(void);
+
+#else
+#define save_event(type,object) \
+		do { } while(0)
+static inline void print_events(void) { }
+#endif
+/*
+ * Tunables:
+ * MAX_DEPTH: maximum spinlock recursion level that can be stored.
+ * 		Increasing the number increases the memory consumption.
+ * RECENT_LEN: number of recent events that are logged.
+ * 		This log contains the last few events that were logged.
+ * 		Increasing this number is only possible with a serial
+ * 		console, otherwise the log will scroll of your screen.
+ * Hint: Boot with vga=ask and select a video mode with 60 lines,
+ * 	that should be sufficient for dual-cpu systems with RECENT_LEN
+ * 	16.
+ */
+#define MAX_DEPTH	128
+#define RECENT_LEN	16
+
+#endif /* __LINUX_EVENTLOG_H */
diff -uN --exclude autoconf.h --exclude compile.h --exclude version.h 2.5/include/linux/sched.h build-2.5/include/linux/sched.h
--- 2.5/include/linux/sched.h	2003-02-15 10:29:23.000000000 +0100
+++ build-2.5/include/linux/sched.h	2003-02-16 16:34:58.000000000 +0100
@@ -775,6 +775,7 @@
 {
 	if (need_resched()) {
 		_raw_spin_unlock(lock);
+		save_event(EVENT_SPINLOCK_RELEASE,lock);
 		preempt_enable_no_resched();
 		__cond_resched();
 		spin_lock(lock);
diff -uN --exclude autoconf.h --exclude compile.h --exclude version.h 2.5/include/linux/spinlock.h build-2.5/include/linux/spinlock.h
--- 2.5/include/linux/spinlock.h	2003-02-15 10:29:23.000000000 +0100
+++ build-2.5/include/linux/spinlock.h	2003-02-16 16:34:58.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/thread_info.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
+#include <linux/eventlog.h>
 
 #include <asm/system.h>
 
@@ -189,14 +190,18 @@
  * methods are defined as nops in the case they are not required.
  */
 #define spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
+				({save_event(EVENT_SPIN_TRYLOCK_SUCCESS, lock); 1;}) \
+				: ({save_event(EVENT_SPIN_TRYLOCK_FAILED, lock); \
+				      preempt_enable(); 0;});})
 
 #define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
+				({save_event(EVENT_WRITE_TRYLOCK_SUCCESS, lock); 1;}) \
+			       	: ({save_event(EVENT_WRITE_TRYLOCK_FAILED, lock); \
+				      preempt_enable(); 0;});})
 
 /* Where's read_trylock? */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_EVENTLOG)
 void __preempt_spin_lock(spinlock_t *lock);
 void __preempt_write_lock(rwlock_t *lock);
 
@@ -218,37 +223,46 @@
 #define spin_lock(lock)	\
 do { \
 	preempt_disable(); \
+	save_event(EVENT_SPINLOCK_BEFORE, lock); \
 	_raw_spin_lock(lock); \
+	save_event(EVENT_SPINLOCK, lock); \
 } while(0)
 
 #define write_lock(lock) \
 do { \
 	preempt_disable(); \
+	save_event(EVENT_WRITE_LOCK_BEFORE, lock); \
 	_raw_write_lock(lock); \
+	save_event(EVENT_WRITE_LOCK, lock); \
 } while(0)
 #endif
 
 #define read_lock(lock)	\
 do { \
 	preempt_disable(); \
+	save_event(EVENT_READ_LOCK_BEFORE, lock); \
 	_raw_read_lock(lock); \
+	save_event(EVENT_READ_LOCK, lock); \
 } while(0)
 
 #define spin_unlock(lock) \
 do { \
 	_raw_spin_unlock(lock); \
+	save_event(EVENT_SPINLOCK_RELEASE, lock); \
 	preempt_enable(); \
 } while (0)
 
 #define write_unlock(lock) \
 do { \
 	_raw_write_unlock(lock); \
+	save_event(EVENT_WRITE_LOCK_RELEASE, lock); \
 	preempt_enable(); \
 } while(0)
 
 #define read_unlock(lock) \
 do { \
 	_raw_read_unlock(lock); \
+	save_event(EVENT_READ_LOCK_RELEASE, lock); \
 	preempt_enable(); \
 } while(0)
 
@@ -256,81 +270,95 @@
 do { \
 	local_irq_save(flags); \
 	preempt_disable(); \
+	save_event(EVENT_SPINLOCK_BEFORE, lock); \
 	_raw_spin_lock(lock); \
+	save_event(EVENT_SPINLOCK, lock); \
 } while (0)
 
 #define spin_lock_irq(lock) \
 do { \
 	local_irq_disable(); \
 	preempt_disable(); \
+	save_event(EVENT_SPINLOCK_BEFORE, lock); \
 	_raw_spin_lock(lock); \
+	save_event(EVENT_SPINLOCK, lock); \
 } while (0)
 
 #define spin_lock_bh(lock) \
 do { \
 	local_bh_disable(); \
 	preempt_disable(); \
+	save_event(EVENT_SPINLOCK_BEFORE, lock); \
 	_raw_spin_lock(lock); \
+	save_event(EVENT_SPINLOCK, lock); \
 } while (0)
 
 #define read_lock_irqsave(lock, flags) \
 do { \
 	local_irq_save(flags); \
 	preempt_disable(); \
+	save_event(EVENT_READ_LOCK_BEFORE, lock); \
 	_raw_read_lock(lock); \
+	save_event(EVENT_READ_LOCK, lock); \
 } while (0)
 
 #define read_lock_irq(lock) \
 do { \
 	local_irq_disable(); \
 	preempt_disable(); \
+	save_event(EVENT_READ_LOCK_BEFORE, lock); \
 	_raw_read_lock(lock); \
+	save_event(EVENT_READ_LOCK, lock); \
 } while (0)
 
 #define read_lock_bh(lock) \
 do { \
 	local_bh_disable(); \
 	preempt_disable(); \
+	save_event(EVENT_READ_LOCK_BEFORE, lock); \
 	_raw_read_lock(lock); \
+	save_event(EVENT_READ_LOCK, lock); \
 } while (0)
 
 #define write_lock_irqsave(lock, flags) \
 do { \
 	local_irq_save(flags); \
 	preempt_disable(); \
+	save_event(EVENT_WRITE_LOCK_BEFORE, lock); \
 	_raw_write_lock(lock); \
+	save_event(EVENT_WRITE_LOCK, lock); \
 } while (0)
 
 #define write_lock_irq(lock) \
 do { \
 	local_irq_disable(); \
 	preempt_disable(); \
+	save_event(EVENT_WRITE_LOCK_BEFORE, lock); \
 	_raw_write_lock(lock); \
+	save_event(EVENT_WRITE_LOCK, lock); \
 } while (0)
 
 #define write_lock_bh(lock) \
 do { \
 	local_bh_disable(); \
 	preempt_disable(); \
+	save_event(EVENT_WRITE_LOCK_BEFORE, lock); \
 	_raw_write_lock(lock); \
+	save_event(EVENT_WRITE_LOCK, lock); \
 } while (0)
 
 #define spin_unlock_irqrestore(lock, flags) \
 do { \
 	_raw_spin_unlock(lock); \
+	save_event(EVENT_SPINLOCK_RELEASE, lock); \
 	local_irq_restore(flags); \
 	preempt_enable(); \
 } while (0)
 
-#define _raw_spin_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_spin_unlock(lock); \
-	local_irq_restore(flags); \
-} while (0)
-
 #define spin_unlock_irq(lock) \
 do { \
 	_raw_spin_unlock(lock); \
+	save_event(EVENT_SPINLOCK_RELEASE, lock); \
 	local_irq_enable(); \
 	preempt_enable(); \
 } while (0)
@@ -338,6 +366,7 @@
 #define spin_unlock_bh(lock) \
 do { \
 	_raw_spin_unlock(lock); \
+	save_event(EVENT_SPINLOCK_RELEASE, lock); \
 	preempt_enable(); \
 	local_bh_enable(); \
 } while (0)
@@ -345,6 +374,7 @@
 #define read_unlock_irqrestore(lock, flags) \
 do { \
 	_raw_read_unlock(lock); \
+	save_event(EVENT_READ_LOCK_RELEASE, lock); \
 	local_irq_restore(flags); \
 	preempt_enable(); \
 } while (0)
@@ -352,6 +382,7 @@
 #define read_unlock_irq(lock) \
 do { \
 	_raw_read_unlock(lock); \
+	save_event(EVENT_READ_LOCK_RELEASE, lock); \
 	local_irq_enable(); \
 	preempt_enable(); \
 } while (0)
@@ -359,6 +390,7 @@
 #define read_unlock_bh(lock) \
 do { \
 	_raw_read_unlock(lock); \
+	save_event(EVENT_READ_LOCK_RELEASE, lock); \
 	preempt_enable(); \
 	local_bh_enable(); \
 } while (0)
@@ -366,6 +398,7 @@
 #define write_unlock_irqrestore(lock, flags) \
 do { \
 	_raw_write_unlock(lock); \
+	save_event(EVENT_WRITE_LOCK_RELEASE, lock); \
 	local_irq_restore(flags); \
 	preempt_enable(); \
 } while (0)
@@ -373,6 +406,7 @@
 #define write_unlock_irq(lock) \
 do { \
 	_raw_write_unlock(lock); \
+	save_event(EVENT_WRITE_LOCK_RELEASE, lock); \
 	local_irq_enable(); \
 	preempt_enable(); \
 } while (0)
@@ -380,13 +414,16 @@
 #define write_unlock_bh(lock) \
 do { \
 	_raw_write_unlock(lock); \
+	save_event(EVENT_WRITE_LOCK_RELEASE, lock); \
 	preempt_enable(); \
 	local_bh_enable(); \
 } while (0)
 
 #define spin_trylock_bh(lock)	({ local_bh_disable(); preempt_disable(); \
-				_raw_spin_trylock(lock) ? 1 : \
-				({preempt_enable(); local_bh_enable(); 0;});})
+				_raw_spin_trylock(lock) ? \
+				({save_event(EVENT_SPIN_TRYLOCK_SUCCESS, lock); 1;}) \
+				: ({save_event(EVENT_SPIN_TRYLOCK_FAILED,lock); \
+				  preempt_enable(); local_bh_enable(); 0;});})
 
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK
diff -uN --exclude '*.cmd' --exclude crc32table.h 2.5/lib/eventlog.c build-2.5/lib/eventlog.c
--- 2.5/lib/eventlog.c	1970-01-01 01:00:00.000000000 +0100
+++ build-2.5/lib/eventlog.c	2003-02-16 16:35:11.000000000 +0100
@@ -0,0 +1,158 @@
+/*
+ * eventlog.c - log deadlock prone events, to simplify deadlock diagnostics
+ *
+ * Copyright (C) 2003 Manfred Spraul
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+#include <linux/config.h>
+#include <linux/thread_info.h>
+#include <linux/preempt.h>
+#include <linux/smp.h>
+#include <linux/eventlog.h>
+#include <linux/module.h>
+#include <asm/atomic.h>
+
+struct eventdata {
+	int depth;
+	int type;
+	char *file;
+	int line;
+	char *object_name;
+	void *object_addr;
+};
+
+static struct eventdata event_stack[NR_CPUS][MAX_DEPTH];
+static struct eventdata event_recent[NR_CPUS][RECENT_LEN];
+static int event_stackpos[NR_CPUS];
+static unsigned int event_recentpos[NR_CPUS];
+static atomic_t log_off = ATOMIC_INIT(0);
+
+void store_event(int type, char *file, int line, char *object_name, void *object_addr)
+{
+	unsigned long flags;
+	int cpu;
+	int enabled;
+	struct eventdata* ped = NULL;
+
+	local_irq_save(flags);
+	cpu = get_cpu(); 
+	enabled = !atomic_read(&log_off);
+
+	if (enabled) {
+		ped = &event_recent[cpu][event_recentpos[cpu]%RECENT_LEN];
+		ped->depth = event_stackpos[cpu];
+		ped->type = type;
+		ped->file = file;
+		ped->line = line;
+		ped->object_name = object_name;
+		ped->object_addr = object_addr;
+	}
+
+	if (type & EVENT_STACK_PUSH) {
+		if (event_stackpos[cpu] < MAX_DEPTH && enabled) {
+			event_stack[cpu][event_stackpos[cpu]] = *ped;
+		}
+		event_stackpos[cpu]++;
+	} else if (type & EVENT_STACK_POP) {
+		event_stackpos[cpu]--;
+		BUG_ON(event_stackpos[cpu] < 0);
+	} else if (type & EVENT_STACK_REPLACE) {
+		BUG_ON(event_stackpos[cpu] <= 0);
+		if (event_stackpos[cpu]-1 < MAX_DEPTH && enabled) {
+			event_stack[cpu][event_stackpos[cpu]-1] = *ped;
+		}
+	}
+	if (enabled) {
+		event_recentpos[cpu]++;
+	}
+	put_cpu();
+	local_irq_restore(flags);
+}
+
+static void print_one_event(int no, struct eventdata *ped)
+{
+	char *name;
+	switch(ped->type) {
+		case EVENT_SPINLOCK_BEFORE:		name = "spinlock_before";	break;
+		case EVENT_SPINLOCK:			name = "spinlock";	break;
+		case EVENT_SPIN_TRYLOCK_SUCCESS:	name = "spin_trylock_success";	break;
+		case EVENT_SPIN_TRYLOCK_FAILED:		name = "spin_trylock_failed";	break;
+		case EVENT_SPINLOCK_RELEASE:		name = "spinlock_release";	break;
+		case EVENT_READ_LOCK_BEFORE:		name = "read_lock_before";	break;
+		case EVENT_READ_LOCK:			name = "read_lock";	break;
+		case EVENT_READ_LOCK_RELEASE:		name = "read_lock_release";	break;
+		case EVENT_WRITE_LOCK_BEFORE:		name = "write_lock_before";	break;
+		case EVENT_WRITE_LOCK:			name = "write_lock";	break;
+		case EVENT_WRITE_TRYLOCK_SUCCESS:	name = "write_trylock_success";	break;
+		case EVENT_WRITE_TRYLOCK_FAILED:	name = "write_trylock_failed";	break;
+		case EVENT_WRITE_LOCK_RELEASE:		name = "write_lock_release";	break;
+		case EVENT_CPU_RELAX:			name = "cpu_relax";	break;
+		default:
+			printk(KERN_INFO"%3d: unknown type %xh.\n",no, ped->type);
+			name="Duh";
+			break;
+	}
+	printk(KERN_INFO"%3d(%d): %s from %s/%d on %s(%p)\n",
+			no, ped->depth, name, ped->file, ped->line, ped->object_name,
+			ped->object_addr);
+}
+
+void print_events(void)
+{
+	unsigned long flags;
+	int cpu;
+	int i;
+	local_irq_save(flags);
+	cpu = get_cpu();
+	atomic_inc(&log_off);
+
+	for(i=0;i<NR_CPUS;i++) {
+		int j;
+		unsigned int lastpos;
+		if (!cpu_possible(i))
+			continue;
+		printk(KERN_INFO "Events of cpu %d%s.\n",
+				i, (i==cpu)?" (current)":"");
+		lastpos = event_recentpos[i];
+		if (lastpos == 0)  {
+			printk(KERN_INFO"  No events recorded.\n");
+			continue;
+		}
+		printk(KERN_INFO "recent events: (old to new)\n");
+		j=0;
+		if (lastpos < RECENT_LEN)
+			j = RECENT_LEN-lastpos;
+
+		for (;j<RECENT_LEN;j++) {
+			print_one_event(lastpos-RECENT_LEN+j, &event_recent[i][(lastpos-RECENT_LEN+j)%RECENT_LEN]);
+		}
+
+		lastpos = event_stackpos[i];
+		printk(KERN_INFO "event stack: (bottom to top, %u total)\n",
+				lastpos);
+		if(lastpos > MAX_DEPTH)
+			lastpos = MAX_DEPTH;
+		for (j=0;j<lastpos;j++) {
+			print_one_event(j, &event_stack[i][j]);
+		}
+	}
+	atomic_dec(&log_off);
+	put_cpu();
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(store_event);
+EXPORT_SYMBOL(print_events);
diff -uN --exclude '*.cmd' --exclude crc32table.h 2.5/lib/Makefile build-2.5/lib/Makefile
--- 2.5/lib/Makefile	2003-02-10 20:27:29.000000000 +0100
+++ build-2.5/lib/Makefile	2003-02-16 16:34:58.000000000 +0100
@@ -20,6 +20,7 @@
 endif
 
 obj-$(CONFIG_CRC32)	+= crc32.o
+obj-$(CONFIG_DEBUG_EVENTLOG) += eventlog.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/

--------------070909050204060601000404--


