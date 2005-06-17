Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVFQXZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVFQXZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 19:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFQXZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 19:25:59 -0400
Received: from soufre.accelance.net ([213.162.48.15]:62960 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261750AbVFQXVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 19:21:46 -0400
Message-ID: <42B35B07.7080703@xenomai.org>
Date: Sat, 18 Jun 2005 01:21:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] I-pipe: Core implementation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diffstat:
  include/linux/hardirq.h                          |   13
  linux-2.6.12-rc6-ipipe-0.5/Makefile              |    2
  linux-2.6.12-rc6-ipipe-0.5/include/linux/ipipe.h |  368 +++++++++++++++++
  linux-2.6.12-rc6-ipipe-0.5/include/linux/sched.h |    1
  linux-2.6.12-rc6-ipipe-0.5/init/Kconfig          |    1
  linux-2.6.12-rc6-ipipe-0.5/init/main.c           |    3
  linux-2.6.12-rc6-ipipe-0.5/ipipe/Kconfig         |   12
  linux-2.6.12-rc6-ipipe-0.5/ipipe/Makefile        |    9
  linux-2.6.12-rc6-ipipe-0.5/ipipe/generic.c       |  265 ++++++++++++
  linux-2.6.12-rc6-ipipe-0.5/kernel/Makefile       |    1
  linux-2.6.12-rc6-ipipe-0.5/kernel/ipipe.c        |  479 
+++++++++++++++++++++++
  linux-2.6.12-rc6-ipipe-0.5/kernel/irq/handle.c   |    9
  linux-2.6.12-rc6-ipipe-0.5/kernel/printk.c       |  102 +++-
  linux-2.6.12-rc6-ipipe-0.5/kernel/sysctl.c       |    3
  linux-2.6.12-rc6-ipipe-0.5/lib/kernel_lock.c     |    4
  linux-2.6.12-rc6-ipipe-0.5/mm/vmalloc.c          |    4
  16 files changed, 1254 insertions(+), 22 deletions(-)


Signed-off-by: Philippe Gerum <rpm@xenomai.org>


diff -uNrp linux-2.6.12-rc6/Makefile linux-2.6.12-rc6-ipipe-0.5/Makefile
--- linux-2.6.12-rc6/Makefile	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/Makefile	2005-06-15 17:35:32.000000000 +0200
@@ -564,6 +564,8 @@ export MODLIB
  ifeq ($(KBUILD_EXTMOD),)
  core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/

+core-$(CONFIG_IPIPE) += ipipe/
+
  vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
  		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
  		     $(net-y) $(net-m) $(libs-y) $(libs-m)))
--- linux-2.6.12-rc6/include/linux/hardirq.h	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/include/linux/hardirq.h	2005-06-15 
17:35:32.000000000 +0200
@@ -86,8 +86,21 @@ extern void synchronize_irq(unsigned int
  # define synchronize_irq(irq)	barrier()
  #endif

+#ifdef CONFIG_IPIPE_CORE
+#define nmi_enter() \
+do { \
+    if (ipipe_current_domain == ipipe_root_domain) \
+	irq_enter(); \
+} while(0)
+#define nmi_exit() \
+do { \
+    if (ipipe_current_domain == ipipe_root_domain) \
+	sub_preempt_count(HARDIRQ_OFFSET); \
+} while(0)
+#else /* !CONFIG_IPIPE_CORE */
  #define nmi_enter()		irq_enter()
  #define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
+#endif /* CONFIG_IPIPE_CORE */

  #ifndef CONFIG_VIRT_CPU_ACCOUNTING
  static inline void account_user_vtime(struct task_struct *tsk)
diff -uNrp linux-2.6.12-rc6/include/linux/ipipe.h 
linux-2.6.12-rc6-ipipe-0.5/include/linux/ipipe.h
--- linux-2.6.12-rc6/include/linux/ipipe.h	1970-01-01 01:00:00.000000000 
+0100
+++ linux-2.6.12-rc6-ipipe-0.5/include/linux/ipipe.h	2005-06-17 
12:08:46.000000000 +0200
@@ -0,0 +1,368 @@
+/*   -*- linux-c -*-
+ *   include/linux/ipipe.h
+ *
+ *   Copyright (C) 2002-2005 Philippe Gerum.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 
02111-1307, USA.
+ */
+
+#ifndef __LINUX_IPIPE_H
+#define __LINUX_IPIPE_H
+
+#ifdef CONFIG_IPIPE_CORE
+
+#include <linux/spinlock.h>
+#include <asm/ipipe.h>
+
+#define IPIPE_VERSION_STRING  IPIPE_ARCH_STRING
+#define IPIPE_RELEASE_NUMBER 
(0x02060000|((IPIPE_MAJOR_NUMBER&0xff)<<8)|(IPIPE_MINOR_NUMBER&0xff))
+
+#define IPIPE_ROOT_PRI       100
+#define IPIPE_ROOT_ID        0
+
+#define IPIPE_SAME_HANDLER ((void (*)(unsigned))(-1))
+
+/* Global domain flags */
+#define IPIPE_SPRINTK_FLAG 0	/* Synchronous printk() allowed */
+#define IPIPE_PPRINTK_FLAG 1	/* Asynchronous printk() request pending */
+
+#define IPIPE_STALL_FLAG   0	/* Stalls a pipeline stage */
+#define IPIPE_SYNC_FLAG    1	/* The interrupt syncer is running for the 
domain */
+
+#define IPIPE_HANDLE_FLAG    0
+#define IPIPE_PASS_FLAG      1
+#define IPIPE_ENABLE_FLAG    2
+#define IPIPE_DYNAMIC_FLAG   IPIPE_HANDLE_FLAG
+#define IPIPE_EXCLUSIVE_FLAG 3
+#define IPIPE_STICKY_FLAG    4
+#define IPIPE_SYSTEM_FLAG    5
+#define IPIPE_LOCK_FLAG      6
+#define IPIPE_SHARED_FLAG    7
+#define IPIPE_CALLASM_FLAG   8	/* Arch-dependent -- might be unused. */
+
+#define IPIPE_HANDLE_MASK    (1 << IPIPE_HANDLE_FLAG)
+#define IPIPE_PASS_MASK      (1 << IPIPE_PASS_FLAG)
+#define IPIPE_ENABLE_MASK    (1 << IPIPE_ENABLE_FLAG)
+#define IPIPE_DYNAMIC_MASK   IPIPE_HANDLE_MASK
+#define IPIPE_EXCLUSIVE_MASK (1 << IPIPE_EXCLUSIVE_FLAG)
+#define IPIPE_STICKY_MASK    (1 << IPIPE_STICKY_FLAG)
+#define IPIPE_SYSTEM_MASK    (1 << IPIPE_SYSTEM_FLAG)
+#define IPIPE_LOCK_MASK      (1 << IPIPE_LOCK_FLAG)
+#define IPIPE_SHARED_MASK    (1 << IPIPE_SHARED_FLAG)
+#define IPIPE_SYNC_MASK      (1 << IPIPE_SYNC_FLAG)
+#define IPIPE_CALLASM_MASK   (1 << IPIPE_CALLASM_FLAG)
+
+#define IPIPE_DEFAULT_MASK  (IPIPE_HANDLE_MASK|IPIPE_PASS_MASK)
+
+struct ipipe_domain_attr {
+
+	unsigned domid;		/* Domain identifier -- Magic value set by caller */
+	const char *name;	/* Domain name -- Warning: won't be dup'ed! */
+	int priority;		/* Priority in interrupt pipeline */
+	void (*entry) (void);	/* Domain entry point */
+	void *pdd;		/* Per-domain (opaque) data pointer */
+};
+
+extern int ipipe_running;
+
+extern struct ipipe_domain *ipipe_percpu_domain[], *ipipe_root_domain;
+
+extern unsigned __ipipe_printk_virq;
+
+extern unsigned long __ipipe_virtual_irq_map;
+
+extern struct list_head __ipipe_pipeline;
+
+extern raw_spinlock_t __ipipe_pipelock;
+
+/* Private interface */
+
+void ipipe_init(void);
+
+#ifdef CONFIG_PROC_FS
+void __ipipe_init_proc(void);
+#endif	/* CONFIG_PROC_FS */
+
+void __ipipe_sync_console(unsigned irq);
+
+void __ipipe_stall_root(void);
+
+void __ipipe_unstall_root(void);
+
+unsigned long __ipipe_test_root(void);
+
+unsigned long __ipipe_test_and_stall_root(void);
+
+void fastcall __ipipe_restore_root(unsigned long flags);
+
+int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head);
+
+#define __ipipe_pipeline_head_p(ipd) (&(ipd)->p_link == 
__ipipe_pipeline.next)
+
+/* Called with hw interrupts off. */
+static inline void __ipipe_switch_to(struct ipipe_domain *out,
+				     struct ipipe_domain *in, int cpuid)
+{
+	void ipipe_suspend_domain(void);
+
+	/* "in" is guaranteed to be closer than "out" from the head of the
+	   pipeline (and obviously different). */
+
+	ipipe_percpu_domain[cpuid] = in;
+
+	ipipe_suspend_domain();	/* Sync stage and propagate interrupts. */
+	ipipe_load_cpuid();	/* Processor might have changed. */
+
+	if (ipipe_percpu_domain[cpuid] == in)
+		/* Otherwise, something has changed the current domain under
+		   our feet recycling the register set; do not override. */
+		ipipe_percpu_domain[cpuid] = out;
+}
+
+/* Public interface */
+
+int ipipe_register_domain(struct ipipe_domain *ipd,
+			  struct ipipe_domain_attr *attr);
+
+int ipipe_unregister_domain(struct ipipe_domain *ipd);
+
+void ipipe_suspend_domain(void);
+
+int ipipe_virtualize_irq_from(struct ipipe_domain *ipd,
+			      unsigned irq,
+			      void (*handler) (unsigned irq),
+			      int (*acknowledge) (unsigned irq),
+			      unsigned modemask);
+
+static inline int ipipe_virtualize_irq(unsigned irq,
+				       void (*handler) (unsigned irq),
+				       int (*acknowledge) (unsigned irq),
+				       unsigned modemask)
+{
+	return ipipe_virtualize_irq_from(ipipe_current_domain,
+					 irq, handler, acknowledge, modemask);
+}
+
+static inline int ipipe_share_irq(unsigned irq,
+				  int (*acknowledge) (unsigned irq))
+{
+	return ipipe_virtualize_irq(irq,
+				    IPIPE_SAME_HANDLER,
+				    acknowledge,
+				    IPIPE_SHARED_MASK | IPIPE_HANDLE_MASK |
+				    IPIPE_PASS_MASK);
+}
+
+int ipipe_control_irq(unsigned irq,
+		      unsigned clrmask,
+		      unsigned setmask);
+
+unsigned ipipe_alloc_virq(void);
+
+int ipipe_free_virq(unsigned virq);
+
+int fastcall ipipe_trigger_irq(unsigned irq);
+
+static inline int ipipe_propagate_irq(unsigned irq)
+{
+
+	return __ipipe_schedule_irq(irq, ipipe_current_domain->p_link.next);
+}
+
+static inline int ipipe_schedule_irq(unsigned irq)
+{
+
+	return __ipipe_schedule_irq(irq, &ipipe_current_domain->p_link);
+}
+
+static inline void ipipe_stall_pipeline_from(struct ipipe_domain *ipd)
+{
+	ipipe_declare_cpuid;
+#ifdef CONFIG_SMP
+	unsigned long flags;
+
+	ipipe_lock_cpu(flags); /* Care for migration. */
+
+	__set_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+
+	if (!__ipipe_pipeline_head_p(ipd))
+		ipipe_unlock_cpu(flags);
+#else	/* CONFIG_SMP */
+	set_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+
+	if (__ipipe_pipeline_head_p(ipd))
+		local_irq_disable_hw();
+#endif	/* CONFIG_SMP */
+}
+
+static inline unsigned long ipipe_test_pipeline_from(struct 
ipipe_domain *ipd)
+{
+	unsigned long flags, s;
+	ipipe_declare_cpuid;
+
+	ipipe_get_cpu(flags);
+	s = test_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+	ipipe_put_cpu(flags);
+
+	return s;
+}
+
+static inline unsigned long ipipe_test_and_stall_pipeline_from(struct
+							       ipipe_domain
+							       *ipd)
+{
+	ipipe_declare_cpuid;
+	unsigned long s;
+#ifdef CONFIG_SMP
+	unsigned long flags;
+
+	ipipe_lock_cpu(flags); /* Care for migration. */
+
+	s = __test_and_set_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+
+	if (!__ipipe_pipeline_head_p(ipd))
+		ipipe_unlock_cpu(flags);
+#else	/* CONFIG_SMP */
+	s = test_and_set_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+
+	if (__ipipe_pipeline_head_p(ipd))
+		local_irq_disable_hw();
+#endif	/* CONFIG_SMP */
+
+	return s;
+}
+
+void fastcall ipipe_unstall_pipeline_from(struct ipipe_domain *ipd);
+
+static inline unsigned long ipipe_test_and_unstall_pipeline_from(struct
+								 ipipe_domain
+								 *ipd)
+{
+	unsigned long flags, s;
+	ipipe_declare_cpuid;
+
+	ipipe_get_cpu(flags);
+	s = test_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+	ipipe_unstall_pipeline_from(ipd);
+	ipipe_put_cpu(flags);
+
+	return s;
+}
+
+static inline void ipipe_unstall_pipeline(void)
+{
+	ipipe_unstall_pipeline_from(ipipe_current_domain);
+}
+
+static inline unsigned long ipipe_test_and_unstall_pipeline(void)
+{
+	return ipipe_test_and_unstall_pipeline_from(ipipe_current_domain);
+}
+
+static inline unsigned long ipipe_test_pipeline(void)
+{
+	return ipipe_test_pipeline_from(ipipe_current_domain);
+}
+
+static inline unsigned long ipipe_test_and_stall_pipeline(void)
+{
+	return ipipe_test_and_stall_pipeline_from(ipipe_current_domain);
+}
+
+static inline void ipipe_restore_pipeline_from(struct ipipe_domain *ipd,
+					       unsigned long flags)
+{
+	if (flags)
+		ipipe_stall_pipeline_from(ipd);
+	else
+		ipipe_unstall_pipeline_from(ipd);
+}
+
+static inline void ipipe_stall_pipeline(void)
+{
+	ipipe_stall_pipeline_from(ipipe_current_domain);
+}
+
+static inline void ipipe_restore_pipeline(unsigned long flags)
+{
+	ipipe_restore_pipeline_from(ipipe_current_domain, flags);
+}
+
+static inline void ipipe_restore_pipeline_nosync(struct ipipe_domain *ipd,
+						 unsigned long flags, int cpuid)
+{
+	/* If cpuid is current, then it must be held on entry
+	   (ipipe_get_cpu/local_irq_save_hw/local_irq_disable_hw). */
+
+	if (flags)
+		__set_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+	else
+		__clear_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+}
+
+void ipipe_init_attr(struct ipipe_domain_attr *attr);
+
+int ipipe_get_sysinfo(struct ipipe_sysinfo *sysinfo);
+
+unsigned long ipipe_critical_enter(void (*syncfn) (void));
+
+void ipipe_critical_exit(unsigned long flags);
+
+static inline void ipipe_set_printk_sync(struct ipipe_domain *ipd)
+{
+	set_bit(IPIPE_SPRINTK_FLAG, &ipd->flags);
+}
+
+static inline void ipipe_set_printk_async(struct ipipe_domain *ipd)
+{
+	clear_bit(IPIPE_SPRINTK_FLAG, &ipd->flags);
+}
+
+#define local_irq_enable_hw_cond()                 local_irq_enable_hw()
+#define local_irq_save_hw_cond(flags)              local_irq_save_hw(flags)
+#define local_irq_restore_hw_cond(flags) 
local_irq_restore_hw(flags)
+#define spin_lock_irqsave_hw_cond(lock,flags) 
spin_lock_irqsave_hw(lock,flags)
+#define spin_unlock_irqrestore_hw_cond(lock,flags) 
spin_unlock_irqrestore_hw(lock,flags)
+
+#else	/* !CONFIG_IPIPE_CORE */
+
+#define ipipe_init()              do { } while(0)
+#define ipipe_suspend_domain()    do { } while(0)
+
+#define spin_lock_hw(lock)                    spin_lock(lock)
+#define spin_unlock_hw(lock)                  spin_unlock(lock)
+#define spin_lock_irq_hw(lock)                spin_lock_irq(lock)
+#define spin_unlock_irq_hw(lock)              spin_unlock_irq(lock)
+#define spin_lock_irqsave_hw(lock,flags)      spin_lock_irqsave(lock, 
flags)
+#define spin_unlock_irqrestore_hw(lock,flags) 
spin_unlock_irqrestore(lock, flags)
+#define local_irq_save_hw(flags)              local_irq_save(flags)
+#define local_irq_restore_hw(flags)           local_irq_restore(flags)
+
+#define local_irq_enable_hw_cond()                 do { } while(0)
+#define local_irq_save_hw_cond(flags)              do { flags = 0; /* 
Optimized out */ } while(0)
+#define local_irq_restore_hw_cond(flags)           do { } while(0)
+#define spin_lock_irqsave_hw_cond(lock,flags)      do { flags = 0; 
spin_lock(lock); } while(0)
+#define spin_unlock_irqrestore_hw_cond(lock,flags) spin_unlock(lock)
+
+#endif	/* CONFIG_IPIPE_CORE */
+
+#ifdef CONFIG_IPIPE
+void ipipe_takeover(void);
+#else	/* CONFIG_IPIPE */
+#define ipipe_takeover()  do { } while(0)
+#endif	/* CONFIG_IPIPE */
+
+#endif	/* !__LINUX_IPIPE_H */
diff -uNrp linux-2.6.12-rc6/include/linux/sched.h 
linux-2.6.12-rc6-ipipe-0.5/include/linux/sched.h
--- linux-2.6.12-rc6/include/linux/sched.h	2005-06-06 17:22:29.000000000 
+0200
+++ linux-2.6.12-rc6-ipipe-0.5/include/linux/sched.h	2005-06-16 
17:37:37.000000000 +0200
@@ -4,6 +4,7 @@
  #include <asm/param.h>	/* for HZ */

  #include <linux/config.h>
+#include <linux/ipipe.h>
  #include <linux/capability.h>
  #include <linux/threads.h>
  #include <linux/kernel.h>
diff -uNrp linux-2.6.12-rc6/init/Kconfig 
linux-2.6.12-rc6-ipipe-0.5/init/Kconfig
--- linux-2.6.12-rc6/init/Kconfig	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/init/Kconfig	2005-06-15 
17:35:32.000000000 +0200
@@ -69,6 +69,7 @@ menu "General setup"

  config LOCALVERSION
  	string "Local version - append to kernel release"
+	default "-ipipe"
  	help
  	  Append an extra string to the end of your kernel version.
  	  This will show up when you type uname, for example.
diff -uNrp linux-2.6.12-rc6/init/main.c 
linux-2.6.12-rc6-ipipe-0.5/init/main.c
--- linux-2.6.12-rc6/init/main.c	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/init/main.c	2005-06-16 17:36:43.000000000 
+0200
@@ -464,6 +464,7 @@ asmlinkage void __init start_kernel(void
  	trap_init();
  	rcu_init();
  	init_IRQ();
+ 	ipipe_init();
  	pidhash_init();
  	init_timers();
  	softirq_init();
@@ -596,6 +597,8 @@ static void __init do_basic_setup(void)
  	sock_init();

  	do_initcalls();
+
+	ipipe_takeover();
  }

  static void do_pre_smp_initcalls(void)
diff -uNrp linux-2.6.12-rc6/ipipe/Kconfig 
linux-2.6.12-rc6-ipipe-0.5/ipipe/Kconfig
--- linux-2.6.12-rc6/ipipe/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc6-ipipe-0.5/ipipe/Kconfig	2005-06-15 
17:57:16.000000000 +0200
@@ -0,0 +1,12 @@
+config IPIPE
+	tristate "Interrupt pipeline"
+	default y
+	---help---
+	  Activate this option if you want the interrupt pipeline to be
+	  compiled in.
+
+config IPIPE_CORE
+	def_bool IPIPE
+
+config IPIPE_PREEMPT_RT
+	def_bool PREEMPT_NONE || PREEMPT_VOLUNTARY || PREEMPT_DESKTOP || 
PREEMPT_RT
diff -uNrp linux-2.6.12-rc6/ipipe/Makefile 
linux-2.6.12-rc6-ipipe-0.5/ipipe/Makefile
--- linux-2.6.12-rc6/ipipe/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc6-ipipe-0.5/ipipe/Makefile	2005-06-15 
17:35:32.000000000 +0200
@@ -0,0 +1,9 @@
+#
+# Makefile for the I-pipe support.
+#
+
+obj-$(CONFIG_IPIPE)	+= ipipe.o
+
+ipipe-objs		:= generic.o
+
+ipipe-$(CONFIG_X86)	+= x86.o
diff -uNrp linux-2.6.12-rc6/ipipe/generic.c 
linux-2.6.12-rc6-ipipe-0.5/ipipe/generic.c
--- linux-2.6.12-rc6/ipipe/generic.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc6-ipipe-0.5/ipipe/generic.c	2005-06-17 
17:40:30.000000000 +0200
@@ -0,0 +1,265 @@
+/*   -*- linux-c -*-
+ *   linux/ipipe/generic.c
+ *
+ *   Copyright (C) 2002-2005 Philippe Gerum.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 
02111-1307, USA.
+ *
+ *   Architecture-independent I-PIPE services.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/irq.h>
+
+MODULE_DESCRIPTION("I-pipe");
+MODULE_LICENSE("GPL");
+
+/* ipipe_register_domain() -- Link a new domain to the pipeline. */
+
+int ipipe_register_domain(struct ipipe_domain *ipd,
+			  struct ipipe_domain_attr *attr)
+{
+	struct list_head *pos;
+	unsigned long flags;
+
+	if (ipipe_current_domain != ipipe_root_domain) {
+		printk(KERN_WARNING
+		       "I-pipe: Only the root domain may register a new domain.\n");
+		return -EPERM;
+	}
+
+	flags = ipipe_critical_enter(NULL);
+
+	list_for_each(pos, &__ipipe_pipeline) {
+		struct ipipe_domain *_ipd =
+		    list_entry(pos, struct ipipe_domain, p_link);
+		if (_ipd->domid == attr->domid)
+			break;
+	}
+
+	ipipe_critical_exit(flags);
+
+	if (pos != &__ipipe_pipeline)
+		/* A domain with the given id already exists -- fail. */
+		return -EBUSY;
+
+	ipd->name = attr->name;
+	ipd->priority = attr->priority;
+	ipd->domid = attr->domid;
+	ipd->pdd = attr->pdd;
+	ipd->flags = 0;
+
+	__ipipe_init_stage(ipd);
+
+	INIT_LIST_HEAD(&ipd->p_link);
+
+	flags = ipipe_critical_enter(NULL);
+
+	list_for_each(pos, &__ipipe_pipeline) {
+		struct ipipe_domain *_ipd =
+		    list_entry(pos, struct ipipe_domain, p_link);
+		if (ipd->priority > _ipd->priority)
+			break;
+	}
+
+	list_add_tail(&ipd->p_link, pos);
+
+	ipipe_critical_exit(flags);
+
+	printk(KERN_WARNING "I-pipe: Domain %s registered.\n", ipd->name);
+
+	/* Finally, allow the new domain to perform its initialization
+	   chores. */
+
+	if (attr->entry != NULL) {
+		ipipe_declare_cpuid;
+
+		ipipe_lock_cpu(flags);
+
+		ipipe_percpu_domain[cpuid] = ipd;
+		attr->entry();
+		ipipe_percpu_domain[cpuid] = ipipe_root_domain;
+
+		ipipe_load_cpuid();	/* Processor might have changed. */
+
+		if (ipipe_root_domain->cpudata[cpuid].irq_pending_hi != 0 &&
+		    !test_bit(IPIPE_STALL_FLAG,
+			      &ipipe_root_domain->cpudata[cpuid].status))
+			__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+
+		ipipe_unlock_cpu(flags);
+	}
+
+	return 0;
+}
+
+/* ipipe_unregister_domain() -- Remove a domain from the pipeline. */
+
+int ipipe_unregister_domain(struct ipipe_domain *ipd)
+{
+	unsigned long flags;
+
+	if (ipipe_current_domain != ipipe_root_domain) {
+		printk(KERN_WARNING
+		       "I-pipe: Only the root domain may unregister a domain.\n");
+		return -EPERM;
+	}
+
+	if (ipd == ipipe_root_domain) {
+		printk(KERN_WARNING
+		       "I-pipe: Cannot unregister the root domain.\n");
+		return -EPERM;
+	}
+#ifdef CONFIG_SMP
+	{
+		int nr_cpus = num_online_cpus(), _cpuid;
+		unsigned irq;
+
+		/* In the SMP case, wait for the logged events to drain on other
+		   processors before eventually removing the domain from the
+		   pipeline. */
+
+		ipipe_unstall_pipeline_from(ipd);
+
+		flags = ipipe_critical_enter(NULL);
+
+		for (irq = 0; irq < IPIPE_NR_IRQS; irq++) {
+			clear_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control);
+			clear_bit(IPIPE_STICKY_FLAG, &ipd->irqs[irq].control);
+			set_bit(IPIPE_PASS_FLAG, &ipd->irqs[irq].control);
+		}
+
+		ipipe_critical_exit(flags);
+
+		for (_cpuid = 0; _cpuid < nr_cpus; _cpuid++)
+			for (irq = 0; irq < IPIPE_NR_IRQS; irq++)
+				while (ipd->cpudata[_cpuid].irq_hits[irq] > 0)
+					cpu_relax();
+	}
+#endif	/* CONFIG_SMP */
+
+	/* Simply remove the domain from the pipeline and we are almost
+	   done. */
+
+	flags = ipipe_critical_enter(NULL);
+	list_del_init(&ipd->p_link);
+	ipipe_critical_exit(flags);
+
+	__ipipe_cleanup_domain(ipd);
+
+	printk(KERN_WARNING "I-pipe: Domain %s unregistered.\n", ipd->name);
+
+	return 0;
+}
+
+/* ipipe_propagate_irq() -- Force a given IRQ propagation on behalf of
+   a running interrupt handler to the next domain down the pipeline.
+   ipipe_schedule_irq() -- Does almost the same as above, but attempts
+   to pend the interrupt for the current domain first. */
+
+int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head)
+{
+	struct list_head *ln;
+	unsigned long flags;
+	ipipe_declare_cpuid;
+
+	if (irq >= IPIPE_NR_IRQS ||
+	    (ipipe_virtual_irq_p(irq)
+	     && !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map)))
+		return -EINVAL;
+
+	ipipe_lock_cpu(flags);
+
+	ln = head;
+
+	while (ln != &__ipipe_pipeline) {
+		struct ipipe_domain *ipd =
+		    list_entry(ln, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control)) {
+			ipd->cpudata[cpuid].irq_hits[irq]++;
+			__ipipe_set_irq_bit(ipd, cpuid, irq);
+			ipipe_unlock_cpu(flags);
+			return 1;
+		}
+
+		ln = ipd->p_link.next;
+	}
+
+	ipipe_unlock_cpu(flags);
+
+	return 0;
+}
+
+/* ipipe_free_virq() -- Release a virtual/soft interrupt. */
+
+int ipipe_free_virq(unsigned virq)
+{
+	if (!ipipe_virtual_irq_p(virq))
+		return -EINVAL;
+
+	clear_bit(virq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map);
+
+	return 0;
+}
+
+void ipipe_init_attr(struct ipipe_domain_attr *attr)
+{
+	attr->name = "anon";
+	attr->domid = 1;
+	attr->entry = NULL;
+	attr->priority = IPIPE_ROOT_PRI;
+	attr->pdd = NULL;
+}
+
+#ifdef CONFIG_IPIPE_MODULE
+
+static int __init ipipe_init_module(void)
+{
+	__ipipe_enable_pipeline();
+	return 0;
+}
+
+static void __exit ipipe_exit_module(void)
+{
+	__ipipe_disable_pipeline();
+}
+
+module_init(ipipe_init_module);
+module_exit(ipipe_exit_module);
+
+#else	/* !CONFIG_IPIPE_MODULE */
+
+void ipipe_takeover(void)
+{
+	/* Take over the box at boot time. */
+	__ipipe_enable_pipeline();
+}
+
+#endif	/* CONFIG_IPIPE_MODULE */
+
+EXPORT_SYMBOL(ipipe_register_domain);
+EXPORT_SYMBOL(ipipe_unregister_domain);
+EXPORT_SYMBOL(ipipe_virtualize_irq_from);
+EXPORT_SYMBOL(ipipe_control_irq);
+EXPORT_SYMBOL(ipipe_free_virq);
+EXPORT_SYMBOL(ipipe_init_attr);
+EXPORT_SYMBOL(ipipe_get_sysinfo);
+EXPORT_SYMBOL(__ipipe_schedule_irq);
diff -uNrp linux-2.6.12-rc6/ipipe/x86.c 
linux-2.6.12-rc6-ipipe-0.5/ipipe/x86.c
diff -uNrp linux-2.6.12-rc6/kernel/Makefile 
linux-2.6.12-rc6-ipipe-0.5/kernel/Makefile
--- linux-2.6.12-rc6/kernel/Makefile	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/kernel/Makefile	2005-06-15 
17:35:32.000000000 +0200
@@ -9,6 +9,7 @@ obj-y     = sched.o fork.o exec_domain.o
  	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
  	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o

+obj-$(CONFIG_IPIPE_CORE) += ipipe.o
  obj-$(CONFIG_FUTEX) += futex.o
  obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
  obj-$(CONFIG_SMP) += cpu.o spinlock.o
diff -uNrp linux-2.6.12-rc6/kernel/ipipe.c 
linux-2.6.12-rc6-ipipe-0.5/kernel/ipipe.c
--- linux-2.6.12-rc6/kernel/ipipe.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc6-ipipe-0.5/kernel/ipipe.c	2005-06-16 
16:10:40.000000000 +0200
@@ -0,0 +1,479 @@
+/*   -*- linux-c -*-
+ *   linux/kernel/ipipe.c
+ *
+ *   Copyright (C) 2002-2005 Philippe Gerum.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 
02111-1307, USA.
+ *
+ *   Architecture-independent I-PIPE core support.
+ */
+
+#include <linux/sched.h>
+#include <linux/module.h>
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#endif	/* CONFIG_PROC_FS */
+
+static struct ipipe_domain ipipe_root;
+
+struct ipipe_domain *ipipe_root_domain = &ipipe_root;
+
+struct ipipe_domain *ipipe_percpu_domain[IPIPE_NR_CPUS] =
+    {[0 ... IPIPE_NR_CPUS - 1] = &ipipe_root };
+
+raw_spinlock_t __ipipe_pipelock = RAW_SPIN_LOCK_UNLOCKED;
+
+struct list_head __ipipe_pipeline;
+
+int ipipe_running;
+
+unsigned long __ipipe_virtual_irq_map = 0;
+
+unsigned __ipipe_printk_virq;
+
+/* ipipe_init() -- Initialization routine of the IPIPE layer. Called
+   by the host kernel early during the boot procedure. */
+
+void ipipe_init(void)
+{
+	struct ipipe_domain *ipd = &ipipe_root;
+
+	__ipipe_check_platform();	/* Do platform dependent checks first. */
+
+	/*
+	   A lightweight registration code for the root domain. We are
+	   running on the boot CPU, and secondary CPUs are still lost
+	   in space.
+	 */
+
+	INIT_LIST_HEAD(&__ipipe_pipeline);
+
+	ipd->name = "Linux";
+	ipd->domid = IPIPE_ROOT_ID;
+	ipd->priority = IPIPE_ROOT_PRI;
+
+	__ipipe_init_stage(ipd);
+
+	INIT_LIST_HEAD(&ipd->p_link);
+	list_add_tail(&ipd->p_link, &__ipipe_pipeline);
+
+	__ipipe_init_platform();
+
+	__ipipe_printk_virq = ipipe_alloc_virq();	/* Cannot fail here. */
+	ipd->irqs[__ipipe_printk_virq].handler = &__ipipe_sync_console;
+	ipd->irqs[__ipipe_printk_virq].acknowledge = NULL;
+	ipd->irqs[__ipipe_printk_virq].control = IPIPE_HANDLE_MASK;
+
+	printk(KERN_INFO "I-pipe %s: Root domain %s registered.\n",
+	       IPIPE_VERSION_STRING, ipd->name);
+}
+
+void __ipipe_stall_root(void)
+{
+	if (ipipe_running) {
+		ipipe_declare_cpuid;
+
+#ifdef CONFIG_SMP
+		unsigned long flags;
+		ipipe_lock_cpu(flags); /* Care for migration. */
+		__set_bit(IPIPE_STALL_FLAG,
+			  &ipipe_root_domain->cpudata[cpuid].status);
+		ipipe_unlock_cpu(flags);
+#else	/* !CONFIG_SMP */
+		set_bit(IPIPE_STALL_FLAG,
+			&ipipe_root_domain->cpudata[cpuid].status);
+#endif	/* CONFIG_SMP */
+	} else
+		local_irq_disable_hw();
+}
+
+void __ipipe_unstall_root(void)
+{
+	if (ipipe_running) {
+		ipipe_declare_cpuid;
+
+		local_irq_disable_hw();
+
+		ipipe_load_cpuid();
+
+		__clear_bit(IPIPE_STALL_FLAG,
+			    &ipipe_root_domain->cpudata[cpuid].status);
+
+		if (ipipe_root_domain->cpudata[cpuid].irq_pending_hi != 0)
+			__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+	}
+
+	local_irq_enable_hw();	/* Needed in both cases. */
+}
+
+unsigned long __ipipe_test_root(void)
+{
+	if (ipipe_running) {
+		ipipe_declare_cpuid;
+		unsigned long s;
+
+#ifdef CONFIG_SMP
+		unsigned long flags;
+		ipipe_lock_cpu(flags); /* Care for migration. */
+		s = test_bit(IPIPE_STALL_FLAG,
+			     &ipipe_root_domain->cpudata[cpuid].status);
+		ipipe_unlock_cpu(flags);
+#else	/* !CONFIG_SMP */
+		s = test_bit(IPIPE_STALL_FLAG,
+			     &ipipe_root_domain->cpudata[cpuid].status);
+#endif	/* CONFIG_SMP */
+
+		return s;
+	}
+
+	return irqs_disabled_hw();
+}
+
+unsigned long __ipipe_test_and_stall_root(void)
+{
+	unsigned long flags;
+
+	if (ipipe_running) {
+		ipipe_declare_cpuid;
+		unsigned long s;
+
+#ifdef CONFIG_SMP
+		ipipe_lock_cpu(flags); /* Care for migration. */
+		s = __test_and_set_bit(IPIPE_STALL_FLAG,
+				       &ipipe_root_domain->cpudata[cpuid].
+				       status);
+		ipipe_unlock_cpu(flags);
+#else	/* !CONFIG_SMP */
+		s = test_and_set_bit(IPIPE_STALL_FLAG,
+				     &ipipe_root_domain->cpudata[cpuid].status);
+#endif	/* CONFIG_SMP */
+
+		return s;
+	}
+
+	local_irq_save_hw(flags);
+
+	return !local_test_iflag_hw(flags);
+}
+
+void fastcall __ipipe_restore_root(unsigned long flags)
+{
+	if (flags)
+		__ipipe_stall_root();
+	else
+		__ipipe_unstall_root();
+}
+
+/* ipipe_unstall_pipeline_from() -- Unstall the pipeline and
+   synchronize pending interrupts for a given domain. See
+   __ipipe_walk_pipeline() for more information. */
+
+void fastcall ipipe_unstall_pipeline_from(struct ipipe_domain *ipd)
+{
+	struct ipipe_domain *this_domain;
+	struct list_head *pos;
+	unsigned long flags;
+	ipipe_declare_cpuid;
+
+	ipipe_lock_cpu(flags);
+
+	__clear_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+
+	this_domain = ipipe_percpu_domain[cpuid];
+
+	if (ipd == this_domain) {
+		if (ipd->cpudata[cpuid].irq_pending_hi != 0)
+			__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+
+		goto release_cpu_and_exit;
+	}
+
+	list_for_each(pos, &__ipipe_pipeline) {
+
+		struct ipipe_domain *next_domain =
+		    list_entry(pos, struct ipipe_domain, p_link);
+
+		if (test_bit
+		    (IPIPE_STALL_FLAG, &next_domain->cpudata[cpuid].status))
+			break;	/* Stalled stage -- do not go further. */
+
+		if (next_domain->cpudata[cpuid].irq_pending_hi != 0) {
+
+			if (next_domain == this_domain)
+				__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+			else {
+				__ipipe_switch_to(this_domain, next_domain,
+						  cpuid);
+
+				ipipe_load_cpuid();	/* Processor might have changed. */
+
+				if (this_domain->cpudata[cpuid].
+				    irq_pending_hi != 0
+				    && !test_bit(IPIPE_STALL_FLAG,
+						 &this_domain->cpudata[cpuid].
+						 status)
+				    && !test_bit(IPIPE_SYNC_FLAG,
+						 &this_domain->cpudata[cpuid].
+						 status))
+					__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+			}
+
+			break;
+		} else if (next_domain == this_domain)
+			break;
+	}
+
+      release_cpu_and_exit:
+
+	if (__ipipe_pipeline_head_p(ipd))
+		local_irq_enable_hw();
+	else
+		ipipe_unlock_cpu(flags);
+}
+
+/* ipipe_suspend_domain() -- Suspend the current domain, switching to
+   the next one which has pending work down the pipeline. */
+
+void ipipe_suspend_domain(void)
+{
+	struct ipipe_domain *this_domain, *next_domain;
+	struct list_head *ln;
+	unsigned long flags;
+	ipipe_declare_cpuid;
+
+	ipipe_lock_cpu(flags);
+
+	this_domain = next_domain = ipipe_percpu_domain[cpuid];
+
+	__clear_bit(IPIPE_STALL_FLAG, &this_domain->cpudata[cpuid].status);
+
+	if (this_domain->cpudata[cpuid].irq_pending_hi != 0)
+		goto sync_stage;
+
+	for (;;) {
+		ln = next_domain->p_link.next;
+
+		if (ln == &__ipipe_pipeline)
+			break;
+
+		next_domain = list_entry(ln, struct ipipe_domain, p_link);
+
+		if (test_bit
+		    (IPIPE_STALL_FLAG, &next_domain->cpudata[cpuid].status))
+			break;
+
+		if (next_domain->cpudata[cpuid].irq_pending_hi == 0)
+			continue;
+
+		ipipe_percpu_domain[cpuid] = next_domain;
+
+	      sync_stage:
+
+		__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+
+		ipipe_load_cpuid();	/* Processor might have changed. */
+
+		if (ipipe_percpu_domain[cpuid] != next_domain)
+			/* Something has changed the current domain under our feet
+			   recycling the register set; take note. */
+			this_domain = ipipe_percpu_domain[cpuid];
+	}
+
+	ipipe_percpu_domain[cpuid] = this_domain;
+
+	ipipe_unlock_cpu(flags);
+}
+
+/* ipipe_alloc_virq() -- Allocate a pipelined virtual/soft interrupt.
+   Virtual interrupts are handled in exactly the same way than their
+   hw-generated counterparts wrt pipelining. */
+
+unsigned ipipe_alloc_virq(void)
+{
+	unsigned long flags, irq = 0;
+	int ipos;
+
+	spin_lock_irqsave_hw(&__ipipe_pipelock, flags);
+
+	if (__ipipe_virtual_irq_map != ~0) {
+		ipos = ffz(__ipipe_virtual_irq_map);
+		set_bit(ipos, &__ipipe_virtual_irq_map);
+		irq = ipos + IPIPE_VIRQ_BASE;
+	}
+
+	spin_unlock_irqrestore_hw(&__ipipe_pipelock, flags);
+
+	return irq;
+}
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/proc_fs.h>
+
+static struct proc_dir_entry *ipipe_proc_entry;
+
+static int __ipipe_read_proc(char *page,
+			     char **start,
+			     off_t off, int count, int *eof, void *data)
+{
+	unsigned long ctlbits;
+	struct list_head *pos;
+	unsigned irq, _irq;
+	char *p = page;
+	int len;
+
+#ifdef CONFIG_IPIPE_MODULE
+	p += sprintf(p, "%s -- Pipelining: %s\n", IPIPE_VERSION_STRING,
+		     ipipe_running ? "active" : "stopped");
+#else	/* !CONFIG_IPIPE_MODULE */
+	p += sprintf(p, "%s -- Pipelining: permanent\n", IPIPE_VERSION_STRING);
+#endif	/* CONFIG_IPIPE_MODULE */
+
+	spin_lock(&__ipipe_pipelock);
+
+	list_for_each(pos, &__ipipe_pipeline) {
+
+		struct ipipe_domain *ipd =
+		    list_entry(pos, struct ipipe_domain, p_link);
+
+		p += sprintf(p, "%8s: priority=%d, id=0x%.8x\n",
+			     ipd->name, ipd->priority, ipd->domid);
+		irq = 0;
+
+		while (irq < IPIPE_NR_IRQS) {
+			ctlbits =
+			    (ipd->irqs[irq].
+			     control & (IPIPE_HANDLE_MASK | IPIPE_PASS_MASK |
+					IPIPE_STICKY_MASK));
+
+			if (irq >= IPIPE_NR_XIRQS && !ipipe_virtual_irq_p(irq)) {
+				/* There might be a hole between the last external IRQ
+				   and the first virtual one; skip it. */
+				irq++;
+				continue;
+			}
+
+			if (ipipe_virtual_irq_p(irq)
+			    && !test_bit(irq - IPIPE_VIRQ_BASE,
+					 &__ipipe_virtual_irq_map)) {
+				/* Non-allocated virtual IRQ; skip it. */
+				irq++;
+				continue;
+			}
+
+			/* Attempt to group consecutive IRQ numbers having the
+			   same virtualization settings in a single line. */
+
+			_irq = irq;
+
+			while (++_irq < IPIPE_NR_IRQS) {
+				if (ipipe_virtual_irq_p(_irq) !=
+				    ipipe_virtual_irq_p(irq)
+				    || (ipipe_virtual_irq_p(_irq)
+					&& !test_bit(_irq - IPIPE_VIRQ_BASE,
+						     &__ipipe_virtual_irq_map))
+				    || ctlbits !=
+				    (ipd->irqs[_irq].
+				     control & (IPIPE_HANDLE_MASK |
+						IPIPE_PASS_MASK |
+						IPIPE_STICKY_MASK)))
+					break;
+			}
+
+			if (_irq == irq + 1)
+				p += sprintf(p, "\tirq%u: ", irq);
+			else
+				p += sprintf(p, "\tirq%u-%u: ", irq, _irq - 1);
+
+			/* Statuses are as follows:
+			   o "accepted" means handled _and_ passed down the
+			   pipeline.
+			   o "grabbed" means handled, but the interrupt might be
+			   terminated _or_ passed down the pipeline depending on
+			   what the domain handler asks for to the I-pipe.
+			   o "passed" means unhandled by the domain but passed
+			   down the pipeline.
+			   o "discarded" means unhandled and _not_ passed down the
+			   pipeline. The interrupt merely disappears from the
+			   current domain down to the end of the pipeline. */
+
+			if (ctlbits & IPIPE_HANDLE_MASK) {
+				if (ctlbits & IPIPE_PASS_MASK)
+					p += sprintf(p, "accepted");
+				else
+					p += sprintf(p, "grabbed");
+			} else if (ctlbits & IPIPE_PASS_MASK)
+				p += sprintf(p, "passed");
+			else
+				p += sprintf(p, "discarded");
+
+			if (ctlbits & IPIPE_STICKY_MASK)
+				p += sprintf(p, ", sticky");
+
+			if (ipipe_virtual_irq_p(irq))
+				p += sprintf(p, ", virtual");
+
+			p += sprintf(p, "\n");
+
+			irq = _irq;
+		}
+	}
+
+	spin_unlock(&__ipipe_pipelock);
+
+	len = p - page;
+
+	if (len <= off + count)
+		*eof = 1;
+
+	*start = page + off;
+
+	len -= off;
+
+	if (len > count)
+		len = count;
+
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+
+void __ipipe_init_proc(void)
+{
+
+	ipipe_proc_entry = create_proc_read_entry("ipipe",
+						  0444,
+						  NULL,
+						  &__ipipe_read_proc, NULL);
+}
+
+#endif	/* CONFIG_PROC_FS */
+
+EXPORT_SYMBOL(ipipe_suspend_domain);
+EXPORT_SYMBOL(ipipe_alloc_virq);
+EXPORT_SYMBOL(ipipe_unstall_pipeline_from);
+EXPORT_SYMBOL(ipipe_percpu_domain);
+EXPORT_SYMBOL(ipipe_root_domain);
+EXPORT_SYMBOL(ipipe_running);
+EXPORT_SYMBOL(__ipipe_unstall_root);
+EXPORT_SYMBOL(__ipipe_stall_root);
+EXPORT_SYMBOL(__ipipe_restore_root);
+EXPORT_SYMBOL(__ipipe_test_and_stall_root);
+EXPORT_SYMBOL(__ipipe_test_root);
+EXPORT_SYMBOL(__ipipe_pipeline);
+EXPORT_SYMBOL(__ipipe_pipelock);
+EXPORT_SYMBOL(__ipipe_virtual_irq_map);
diff -uNrp linux-2.6.12-rc6/kernel/irq/handle.c 
linux-2.6.12-rc6-ipipe-0.5/kernel/irq/handle.c
--- linux-2.6.12-rc6/kernel/irq/handle.c	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/kernel/irq/handle.c	2005-06-15 
22:16:53.000000000 +0200
@@ -81,6 +81,15 @@ fastcall int handle_IRQ_event(unsigned i
  {
  	int ret, retval = 0, status = 0;

+#ifdef CONFIG_IPIPE_CORE
+	/* If processing a timer tick, pass the original regs as
+	   collected during preemption and not our phony - always
+	   kernel-originated - frame, so that we don't wreck the
+	   profiling code. */
+	if (ipipe_running && __ipipe_tick_irq == irq)
+		regs = __ipipe_tick_regs + smp_processor_id();
+#endif /* CONFIG_IPIPE_CORE */
+
  	if (!(action->flags & SA_INTERRUPT))
  		local_irq_enable();

diff -uNrp linux-2.6.12-rc6/kernel/printk.c 
linux-2.6.12-rc6-ipipe-0.5/kernel/printk.c
--- linux-2.6.12-rc6/kernel/printk.c	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/kernel/printk.c	2005-06-15 
20:40:29.000000000 +0200
@@ -248,18 +248,18 @@ int do_syslog(int type, char __user * bu
  		if (error)
  			goto out;
  		i = 0;
-		spin_lock_irq(&logbuf_lock);
+		spin_lock_irq_hw(&logbuf_lock);
  		while (!error && (log_start != log_end) && i < len) {
  			c = LOG_BUF(log_start);
  			log_start++;
-			spin_unlock_irq(&logbuf_lock);
+			spin_unlock_irq_hw(&logbuf_lock);
  			error = __put_user(c,buf);
  			buf++;
  			i++;
  			cond_resched();
-			spin_lock_irq(&logbuf_lock);
+			spin_lock_irq_hw(&logbuf_lock);
  		}
-		spin_unlock_irq(&logbuf_lock);
+		spin_unlock_irq_hw(&logbuf_lock);
  		if (!error)
  			error = i;
  		break;
@@ -280,7 +280,7 @@ int do_syslog(int type, char __user * bu
  		count = len;
  		if (count > log_buf_len)
  			count = log_buf_len;
-		spin_lock_irq(&logbuf_lock);
+		spin_lock_irq_hw(&logbuf_lock);
  		if (count > logged_chars)
  			count = logged_chars;
  		if (do_clear)
@@ -297,12 +297,12 @@ int do_syslog(int type, char __user * bu
  			if (j + log_buf_len < log_end)
  				break;
  			c = LOG_BUF(j);
-			spin_unlock_irq(&logbuf_lock);
+			spin_unlock_irq_hw(&logbuf_lock);
  			error = __put_user(c,&buf[count-1-i]);
  			cond_resched();
-			spin_lock_irq(&logbuf_lock);
+			spin_lock_irq_hw(&logbuf_lock);
  		}
-		spin_unlock_irq(&logbuf_lock);
+		spin_unlock_irq_hw(&logbuf_lock);
  		if (error)
  			break;
  		error = i;
@@ -526,7 +526,7 @@ asmlinkage int vprintk(const char *fmt,
  		zap_locks();

  	/* This stops the holder of console_sem just where we want him */
-	spin_lock_irqsave(&logbuf_lock, flags);
+	spin_lock_irqsave_hw(&logbuf_lock, flags);

  	/* Emit the output into the temporary buffer */
  	printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt, args);
@@ -588,6 +588,26 @@ asmlinkage int vprintk(const char *fmt,
  			log_level_unknown = 1;
  	}

+#ifdef CONFIG_IPIPE_CORE
+	if (ipipe_current_domain != ipipe_root_domain &&
+	    !test_bit(IPIPE_SPRINTK_FLAG,&ipipe_current_domain->flags) &&
+	    !oops_in_progress) {
+	/* When operating in asynchronous printk() mode, ensure the
+	   console drivers and klogd wakeup are only run by Linux,
+	   delegating the actual output to the root domain by mean of
+	   a virtual IRQ kicking our sync handler. If the current
+	   domain has a lower priority than Linux, then we'll get
+	   immediately preempted by it. In synchronous printk() mode,
+	   immediately call the console drivers. Oopsing overrides the
+	   mode to synchronous. */
+ 	    spin_unlock_irqrestore_hw(&logbuf_lock, flags);
+
+ 	    if (!test_and_set_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags))
+ 		ipipe_trigger_irq(__ipipe_printk_virq);
+
+ 	    goto out;
+ 	}
+#endif /* CONFIG_IPIPE_CORE */
  	if (!cpu_online(smp_processor_id()) &&
  	    system_state != SYSTEM_RUNNING) {
  		/*
@@ -596,16 +616,20 @@ asmlinkage int vprintk(const char *fmt,
  		 * CPU until it is officially up.  We shouldn't be calling into
  		 * random console drivers on a CPU which doesn't exist yet..
  		 */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock_irqrestore_hw(&logbuf_lock, flags);
  		goto out;
  	}
-	if (!down_trylock(&console_sem)) {
+#ifdef CONFIG_IPIPE_CORE
+ 	if (ipipe_current_domain != ipipe_root_domain || 
!down_trylock(&console_sem)) {
+#else /* !CONFIG_IPIPE_CORE */
+ 	if (!down_trylock(&console_sem)) {
+#endif /* CONFIG_IPIPE_CORE */
  		console_locked = 1;
  		/*
  		 * We own the drivers.  We can drop the spinlock and let
  		 * release_console_sem() print the text
  		 */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock_irqrestore_hw(&logbuf_lock, flags);
  		console_may_schedule = 0;
  		release_console_sem();
  	} else {
@@ -614,7 +638,7 @@ asmlinkage int vprintk(const char *fmt,
  		 * allows the semaphore holder to proceed and to call the
  		 * console drivers with the output which we just produced.
  		 */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock_irqrestore_hw(&logbuf_lock, flags);
  	}
  out:
  	return printed_len;
@@ -725,26 +749,60 @@ void release_console_sem(void)
  	unsigned long wake_klogd = 0;

  	for ( ; ; ) {
-		spin_lock_irqsave(&logbuf_lock, flags);
+		spin_lock_irqsave_hw(&logbuf_lock, flags);
  		wake_klogd |= log_start - log_end;
  		if (con_start == log_end)
  			break;			/* Nothing to print */
  		_con_start = con_start;
  		_log_end = log_end;
  		con_start = log_end;		/* Flush */
-		spin_unlock(&logbuf_lock);
+		spin_unlock_hw(&logbuf_lock);
  		call_console_drivers(_con_start, _log_end);
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
  	}
  	console_locked = 0;
  	console_may_schedule = 0;
+#ifdef CONFIG_IPIPE_CORE
+	if (ipipe_root_domain != ipipe_current_domain) {
+	    spin_unlock_irqrestore_hw(&logbuf_lock, flags);
+	    return;
+	}
+	spin_unlock_irqrestore_hw(&logbuf_lock, flags);
+	up(&console_sem);
+#else /* !CONFIG_IPIPE_CORE */
  	up(&console_sem);
-	spin_unlock_irqrestore(&logbuf_lock, flags);
+	spin_unlock_irqrestore_hw(&logbuf_lock, flags);
+#endif /* CONFIG_IPIPE_CORE */
  	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
  		wake_up_interruptible(&log_wait);
  }
  EXPORT_SYMBOL(release_console_sem);

+#ifdef CONFIG_IPIPE_CORE
+void __ipipe_sync_console (unsigned virq) {
+
+    /* This handler always runs on behalf of the root (Linux) domain. */
+
+    unsigned long flags;
+
+    spin_lock_irqsave_hw(&logbuf_lock, flags);
+
+    /* Not absolutely atomic wrt to the triggering point, but this is
+       harmless. We only try to reduce the useless triggers by a cheap
+       trick here. */
+
+    clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
+
+    if (cpu_online(smp_processor_id()) && system_state == 
SYSTEM_RUNNING && !down_trylock(&console_sem)) {
+        console_locked = 1;
+	spin_unlock_irqrestore_hw(&logbuf_lock, flags);
+        console_may_schedule = 0;
+	release_console_sem();
+    } else
+	spin_unlock_irqrestore_hw(&logbuf_lock, flags);
+}
+#endif /* CONFIG_IPIPE_CORE */
+
  /** console_conditional_schedule - yield the CPU if required
   *
   * If the console code is currently allowed to sleep, and
@@ -906,9 +964,9 @@ void register_console(struct console * c
  		 * release_console_sem() will print out the buffered messages
  		 * for us.
  		 */
-		spin_lock_irqsave(&logbuf_lock, flags);
+		spin_lock_irqsave_hw(&logbuf_lock, flags);
  		con_start = log_start;
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock_irqrestore_hw(&logbuf_lock, flags);
  	}
  	release_console_sem();
  }
@@ -977,7 +1035,7 @@ int __printk_ratelimit(int ratelimit_jif
  	unsigned long flags;
  	unsigned long now = jiffies;

-	spin_lock_irqsave(&ratelimit_lock, flags);
+	spin_lock_irqsave_hw(&ratelimit_lock, flags);
  	toks += now - last_msg;
  	last_msg = now;
  	if (toks > (ratelimit_burst * ratelimit_jiffies))
@@ -986,13 +1044,13 @@ int __printk_ratelimit(int ratelimit_jif
  		int lost = missed;
  		missed = 0;
  		toks -= ratelimit_jiffies;
-		spin_unlock_irqrestore(&ratelimit_lock, flags);
+		spin_unlock_irqrestore_hw(&ratelimit_lock, flags);
  		if (lost)
  			printk(KERN_WARNING "printk: %d messages suppressed.\n", lost);
  		return 1;
  	}
  	missed++;
-	spin_unlock_irqrestore(&ratelimit_lock, flags);
+	spin_unlock_irqrestore_hw(&ratelimit_lock, flags);
  	return 0;
  }
  EXPORT_SYMBOL(__printk_ratelimit);
diff -uNrp linux-2.6.12-rc6/kernel/sysctl.c 
linux-2.6.12-rc6-ipipe-0.5/kernel/sysctl.c
--- linux-2.6.12-rc6/kernel/sysctl.c	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/kernel/sysctl.c	2005-06-15 
17:35:32.000000000 +0200
@@ -968,6 +968,9 @@ void __init sysctl_init(void)
  #ifdef CONFIG_PROC_FS
  	register_proc_table(root_table, proc_sys_root);
  	init_irq_proc();
+#ifdef CONFIG_IPIPE_CORE
+	__ipipe_init_proc();
+#endif /* CONFIG_IPIPE_CORE */
  #endif
  }

diff -uNrp linux-2.6.12-rc6/lib/kernel_lock.c 
linux-2.6.12-rc6-ipipe-0.5/lib/kernel_lock.c
--- linux-2.6.12-rc6/lib/kernel_lock.c	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/lib/kernel_lock.c	2005-06-15 
17:35:32.000000000 +0200
@@ -20,6 +20,10 @@ unsigned int smp_processor_id(void)
  	unsigned long preempt_count = preempt_count();
  	int this_cpu = __smp_processor_id();
  	cpumask_t this_mask;
+#ifdef CONFIG_IPIPE_CORE
+	if (ipipe_current_domain != ipipe_root_domain)
+	    return this_cpu;
+#endif /* CONFIG_IPIPE_CORE */

  	if (likely(preempt_count))
  		goto out;
diff -uNrp linux-2.6.12-rc6/mm/vmalloc.c 
linux-2.6.12-rc6-ipipe-0.5/mm/vmalloc.c
--- linux-2.6.12-rc6/mm/vmalloc.c	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/mm/vmalloc.c	2005-06-15 
18:31:22.000000000 +0200
@@ -18,6 +18,7 @@

  #include <asm/uaccess.h>
  #include <asm/tlbflush.h>
+#include <asm/pgalloc.h>


  DEFINE_RWLOCK(vmlist_lock);
@@ -148,10 +149,13 @@ int map_vm_area(struct vm_struct *area,
  	pgd = pgd_offset_k(addr);
  	spin_lock(&init_mm.page_table_lock);
  	do {
+		pgd_t oldpgd = *pgd;
  		next = pgd_addr_end(addr, end);
  		err = vmap_pud_range(pgd, addr, next, prot, pages);
  		if (err)
  			break;
+		if (pgd_val(oldpgd) != pgd_val(*pgd))
+			set_pgdir(addr, *pgd);
  	} while (pgd++, addr = next, addr != end);
  	spin_unlock(&init_mm.page_table_lock);
  	flush_cache_vmap((unsigned long) area->addr, end);
-- 

Philippe.

