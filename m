Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264803AbSIWCvD>; Sun, 22 Sep 2002 22:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264834AbSIWCvD>; Sun, 22 Sep 2002 22:51:03 -0400
Received: from nameservices.net ([208.234.25.16]:13317 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264803AbSIWCur>;
	Sun, 22 Sep 2002 22:50:47 -0400
Message-ID: <3D8E8371.D2070D87@opersys.com>
Date: Sun, 22 Sep 2002 22:58:57 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Adeos <adeos-main@mail.freesoftware.fsf.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a patch for adding the Adeos nanokernel to the Linux kernel as
described earlier:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102309348817485&w=2

Here are the files added:
 include/linux/adeos.h     |  188 ++++++++++++
 kernel/adeos.c            |  712 ++++++++++++++++++++++++++++++++++++++++++++++

Here are the files modified:
 include/linux/init_task.h |   51 +++
 include/linux/sched.h     |    4
 init/Config.in            |    1
 init/main.c               |    3
 kernel/Makefile           |    3
 kernel/fork.c             |    8
 kernel/ksyms.c            |   32 ++
 kernel/printk.c           |  114 +++++++
 kernel/sched.c            |    8
 kernel/sysctl.c           |    3
 12 files changed, 1125 insertions, 2 deletions   

These modifications are only aimed at making sure that Linux plays nice
with the other domains in the pipeline.

The project's web site is located here:
http://www.nongnu.org/adeos/

Any feedback is appreciated.

diff -urpN linux-2.5.38/include/linux/adeos.h linux-2.5.38-adeos/include/linux/adeos.h
--- linux-2.5.38/include/linux/adeos.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.38-adeos/include/linux/adeos.h	Sun Sep 22 21:57:19 2002
@@ -0,0 +1,188 @@
+/*
+ *   include/linux/adeos.h
+ *
+ *   Copyright (C) 2002 Philippe Gerum.
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
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __LINUX_ADEOS_H
+#define __LINUX_ADEOS_H
+
+#include <asm/adeos.h>
+
+#define ADEOS_VERSION_STRING "2.5r1c4/x86"
+
+#define ADEOS_ROOT_PRI       100
+#define ADEOS_ROOT_ID        0
+#define ADEOS_ROOT_NPTDKEYS  4	/* Must be <= 32 */
+
+#define ADEOS_OTHER_CPUS   (-1)
+#define ADEOS_RESET_TIMER  0x1
+
+#define IPIPE_STALL_FLAG   0	/* Stalls a pipeline stage */
+#define IPIPE_SYNC_FLAG    1	/* IRQ sync is undergoing */
+#define IPIPE_XPEND_FLAG   2	/* Exception notification is pending */
+#define IPIPE_SLEEP_FLAG   3	/* Domain has suspended itself */
+
+#define IPIPE_HANDLE_FLAG    0
+#define IPIPE_PASS_FLAG      1
+#define IPIPE_CALLASM_FLAG   2
+#define IPIPE_ENABLE_FLAG    3
+#define IPIPE_DYNAMIC_FLAG   IPIPE_HANDLE_FLAG
+#define IPIPE_EXCLUSIVE_FLAG 4
+
+#define IPIPE_HANDLE_MASK    (1 << IPIPE_HANDLE_FLAG)
+#define IPIPE_PASS_MASK      (1 << IPIPE_PASS_FLAG)
+#define IPIPE_CALLASM_MASK   (1 << IPIPE_CALLASM_FLAG)
+#define IPIPE_ENABLE_MASK    (1 << IPIPE_ENABLE_FLAG)
+#define IPIPE_DYNAMIC_MASK   IPIPE_HANDLE_MASK
+#define IPIPE_EXCLUSIVE_MASK (1 << IPIPE_EXCLUSIVE_FLAG)
+
+#define IPIPE_DEFAULT_MASK  (IPIPE_HANDLE_MASK|IPIPE_PASS_MASK)
+
+typedef struct adattr {
+
+    unsigned domid;		/* Domain identifier -- Magic value set by caller */
+    const char *name;		/* Domain name -- Warning: won't be dup'ed! */
+    int priority;		/* Priority in interrupt pipeline */
+    void (*entry)(void);	/* Domain entry point */
+    int estacksz;		/* Stack size for entry context -- 0 means unspec */
+    void (*dswitch)(void);	/* Handler called each time the domain is switched in */
+    int nptdkeys;		/* Max. number of per-thread data keys */
+    void (*ptdset)(int,void *);	/* Routine to set pt values */
+    void *(*ptdget)(int);	/* Routine to get pt values */
+
+} adattr_t;
+
+extern adomain_t *adp_cpu_current[],
+                 *adp_root;
+
+#define adp_current (adp_cpu_current[adeos_processor_id()])
+
+int adeos_register_domain(adomain_t *adp,
+			  adattr_t *attr);
+
+int adeos_unregister_domain(adomain_t *adp);
+
+void adeos_renice_domain(adomain_t *adp,
+			 int newpri);
+
+void adeos_suspend_domain(void);
+
+int adeos_virtualize_irq(unsigned irq,
+			 void (*handler)(unsigned irq),
+			 int (*acknowledge)(unsigned irq),
+			 unsigned modemask);
+
+int adeos_control_irq(unsigned irq,
+		      unsigned clrmask,
+		      unsigned setmask);
+
+int FASTCALL(adeos_propagate_irq(unsigned irq));
+
+unsigned adeos_alloc_irq(void);
+
+int adeos_free_irq(unsigned irq);
+
+int FASTCALL(adeos_trigger_irq(unsigned irq));
+
+int FASTCALL(adeos_trigger_ipi(int cpuid));
+
+void adeos_stall_ipipe(void);
+
+static inline void adeos_stall_ipipe_from (adomain_t *adp) {
+
+    ipipe_declare_cpuid;
+    set_bit(IPIPE_STALL_FLAG,&adp->cpudata[cpuid].status);
+}
+
+void adeos_unstall_ipipe(void);
+
+void adeos_unstall_ipipe_from(adomain_t *adp);
+
+static inline unsigned long adeos_test_ipipe_from (adomain_t *adp) {
+
+    return test_bit(IPIPE_STALL_FLAG,&adp->cpudata[adeos_processor_id()].status);
+}
+
+static inline unsigned long adeos_test_ipipe (void) {
+
+    return adeos_test_ipipe_from(adp_current);
+}
+
+static inline unsigned long adeos_test_and_stall_ipipe_from (adomain_t *adp) {
+    
+    return test_and_set_bit(IPIPE_STALL_FLAG,&adp->cpudata[adeos_processor_id()].status);
+}
+
+static inline unsigned long adeos_test_and_stall_ipipe (void) {
+    
+    return adeos_test_and_stall_ipipe_from(adp_current);
+}
+
+static inline void adeos_restore_ipipe_from (adomain_t *adp, unsigned long flags) {
+
+    ipipe_declare_cpuid;
+
+    if (flags)
+	set_bit(IPIPE_STALL_FLAG,&adp->cpudata[cpuid].status);
+    else
+	{
+	clear_bit(IPIPE_STALL_FLAG,&adp->cpudata[cpuid].status);
+
+	if (adp == adp_current &&
+	    adp->cpudata[cpuid].irq_pending_hi != 0)
+	    ipipe_sync_irqs();
+	}
+}
+
+static inline void adeos_restore_ipipe (unsigned long flags) {
+
+    adeos_restore_ipipe_from(adp_current,flags);
+}
+
+int adeos_catch_event(unsigned event,
+		      void (*handler)(adevinfo_t *));
+
+static inline void adeos_propagate_event(adevinfo_t *evinfo) {
+
+    evinfo->propagate = 1;
+}
+
+void (*adeos_hook_dswitch(void (*handler)(void)))(void);
+
+void adeos_init_attr(adattr_t *attr);
+
+int adeos_get_sysinfo(adsysinfo_t *sysinfo);
+
+int adeos_tune_timer(unsigned long ns,
+		     int flags);
+
+int adeos_alloc_ptdkey(void);
+
+int adeos_free_ptdkey(int key);
+
+int adeos_set_ptd(int key,
+		  void *value);
+
+void *adeos_get_ptd(int key);
+
+unsigned long adeos_critical_enter(void (*syncfn)(void));
+
+void adeos_critical_exit(unsigned long flags);
+
+#endif /* !__LINUX_ADEOS_H */
diff -urpN linux-2.5.38/include/linux/init_task.h linux-2.5.38-adeos/include/linux/init_task.h
--- linux-2.5.38/include/linux/init_task.h	Sun Sep 22 00:25:00 2002
+++ linux-2.5.38-adeos/include/linux/init_task.h	Sun Sep 22 21:57:19 2002
@@ -54,6 +54,8 @@
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
  */
+#ifdef CONFIG_ADEOS
+
 #define INIT_TASK(tsk)	\
 {									\
 	.state		= 0,						\
@@ -98,8 +100,57 @@
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+        .ptd            = { [ 0 ... ADEOS_ROOT_NPTDKEYS - 1] = 0 },     \
 }
 
+#else /* !CONFIG_ADEOS */
+
+#define INIT_TASK(tsk)	\
+{									\
+	.state		= 0,						\
+	.thread_info	= &init_thread_info,				\
+	.flags		= 0,						\
+	.lock_depth	= -1,						\
+	.prio		= MAX_PRIO-20,					\
+	.static_prio	= MAX_PRIO-20,					\
+	.policy		= SCHED_NORMAL,					\
+	.cpus_allowed	= -1,						\
+	.mm		= NULL,						\
+	.active_mm	= &init_mm,					\
+	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
+	.time_slice	= HZ,						\
+	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
+	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
+	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
+	.real_parent	= &tsk,						\
+	.parent		= &tsk,						\
+	.children	= LIST_HEAD_INIT(tsk.children),			\
+	.sibling	= LIST_HEAD_INIT(tsk.sibling),			\
+	.group_leader	= &tsk,						\
+	.thread_group	= LIST_HEAD_INIT(tsk.thread_group),		\
+	.wait_chldexit	= __WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
+	.real_timer	= {						\
+		.function	= it_real_fn				\
+	},								\
+	.cap_effective	= CAP_INIT_EFF_SET,				\
+	.cap_inheritable = CAP_INIT_INH_SET,				\
+	.cap_permitted	= CAP_FULL_SET,					\
+	.keep_capabilities = 0,						\
+	.rlim		= INIT_RLIMITS,					\
+	.user		= INIT_USER,					\
+	.comm		= "swapper",					\
+	.thread		= INIT_THREAD,					\
+	.fs		= &init_fs,					\
+	.files		= &init_files,					\
+	.sigmask_lock	= SPIN_LOCK_UNLOCKED,				\
+	.sig		= &init_signals,				\
+	.pending	= { NULL, &tsk.pending.head, {{0}}},		\
+	.blocked	= {{0}},					\
+	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
+	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
+	.journal_info	= NULL,						\
+}
 
+#endif /* CONFIG_ADEOS */
 
 #endif
diff -urpN linux-2.5.38/include/linux/sched.h linux-2.5.38-adeos/include/linux/sched.h
--- linux-2.5.38/include/linux/sched.h	Sun Sep 22 00:25:00 2002
+++ linux-2.5.38-adeos/include/linux/sched.h	Sun Sep 22 21:57:19 2002
@@ -398,6 +398,10 @@ struct task_struct {
 /* journalling filesystem info */
 	void *journal_info;
 	struct dentry *proc_dentry;
+
+#ifdef CONFIG_ADEOS
+        void *ptd[ADEOS_ROOT_NPTDKEYS];
+#endif /* CONFIG_ADEOS */
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
diff -urpN linux-2.5.38/init/Config.in linux-2.5.38-adeos/init/Config.in
--- linux-2.5.38/init/Config.in	Sun Sep 22 00:25:01 2002
+++ linux-2.5.38-adeos/init/Config.in	Sun Sep 22 21:57:19 2002
@@ -5,6 +5,7 @@ endmenu
 
 mainmenu_option next_comment
 comment 'General setup'
+bool 'Adaptive Domain Environment support' CONFIG_ADEOS
 bool 'Networking support' CONFIG_NET
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
diff -urpN linux-2.5.38/init/main.c linux-2.5.38-adeos/init/main.c
--- linux-2.5.38/init/main.c	Sun Sep 22 00:25:02 2002
+++ linux-2.5.38-adeos/init/main.c	Sun Sep 22 21:57:19 2002
@@ -396,6 +396,9 @@ asmlinkage void __init start_kernel(void
 	build_all_zonelists();
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
+#ifdef CONFIG_ADEOS
+	__adeos_init();
+#endif /* CONFIG_ADEOS */
 	trap_init();
 	init_IRQ();
 	sched_init();
diff -urpN linux-2.5.38/kernel/Makefile linux-2.5.38-adeos/kernel/Makefile
--- linux-2.5.38/kernel/Makefile	Sun Sep 22 00:25:03 2002
+++ linux-2.5.38-adeos/kernel/Makefile	Sun Sep 22 21:57:19 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o adeos.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
@@ -17,6 +17,7 @@ obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_ADEOS) += adeos.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urpN linux-2.5.38/kernel/adeos.c linux-2.5.38-adeos/kernel/adeos.c
--- linux-2.5.38/kernel/adeos.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5.38-adeos/kernel/adeos.c	Sun Sep 22 21:57:19 2002
@@ -0,0 +1,712 @@
+/*
+ *   linux/kernel/adeos.c
+ *
+ *   Copyright (C) 2002 Philippe Gerum.
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
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *   This code implements the architecture-independent ADEOS support.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <asm/system.h>
+
+/* The pre-defined domain slot for the root domain. */
+static adomain_t adeos_root_domain;
+
+/* A constant pointer to the root domain. */
+adomain_t *adp_root = &adeos_root_domain;
+
+/* A pointer to the current domain. */
+adomain_t *adp_cpu_current[ADEOS_NR_CPUS] = { [ 0 ... ADEOS_NR_CPUS - 1] = &adeos_root_domain };
+
+/* The spinlock protecting from races while modifying the pipeline. */
+spinlock_t adeos_pipelock = SPIN_LOCK_UNLOCKED;
+
+/* The pipeline data structure. Enqueues adomain_t objects by priority. */
+struct list_head adeos_pipeline;
+
+/* An array of global counters tracking domains monitoring events. */
+int __adeos_event_monitors[ADEOS_NR_EVENTS] = { [ 0 ... ADEOS_NR_EVENTS - 1] = 0 };
+
+/* Number of on-line CPUS. */
+int __adeos_online_cpus = 1;
+
+/* adeos_init() -- Initialization routine of the ADEOS layer. Called
+   by the host kernel early during the boot procedure. */
+
+void __adeos_init (void)
+
+{
+    adattr_t attr;
+
+    printk("ADEOS %s enabled.\n",ADEOS_VERSION_STRING);
+
+    INIT_LIST_HEAD(&adeos_pipeline);
+    __adeos_online_cpus = smp_num_cpus;
+
+    attr.domid = ADEOS_ROOT_ID;
+    attr.name = "Linux";
+    attr.entry = NULL;
+    attr.priority = ADEOS_ROOT_PRI;
+    attr.estacksz = 0;	/* Unused. */
+    attr.dswitch = NULL;
+    attr.nptdkeys = ADEOS_ROOT_NPTDKEYS;
+    attr.ptdset = &__adeos_set_root_ptd;
+    attr.ptdget = &__adeos_get_root_ptd;
+
+    adeos_register_domain(&adeos_root_domain,&attr);
+}
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/proc_fs.h>
+
+static struct proc_dir_entry *adeos_proc_entry;
+
+static int __adeos_read_proc (char *page,
+			      char **start,
+			      off_t off,
+			      int count,
+			      int *eof,
+			      void *data)
+{
+    struct list_head *pos;
+    unsigned long flags;
+    char *p = page;
+    int len;
+
+    p += sprintf(p,"Prio\tID\t\tDomain\n\n");
+
+    ipipe_hw_save_flags_and_cli(flags);
+
+    list_for_each(pos,&adeos_pipeline) {
+    	adomain_t *adp = list_entry(pos,adomain_t,link);
+	p += sprintf(p," %d\t0x%.8x\t%s\n",
+		     adp->priority,
+		     adp->domid,
+		     adp->name);
+    }
+
+    ipipe_hw_restore_flags(flags);
+
+    len = p - page;
+
+    if (len <= off + count)
+	*eof = 1;
+
+    *start = page + off;
+
+    len -= off;
+
+    if (len > count)
+	len = count;
+
+    if (len < 0)
+	len = 0;
+
+    return len;
+}
+
+void __adeos_init_proc (void) {
+
+    adeos_proc_entry = create_proc_read_entry("adeos",
+					      0444,
+					      NULL,
+					      &__adeos_read_proc,
+					      NULL);
+}
+
+#endif /* CONFIG_PROC_FS */
+
+/* adeos_register_domain() -- Add a new domain to the system. All
+   client domains must call this routine to register themselves to
+   ADEOS before using its services. */
+
+int adeos_register_domain (adomain_t *adp, adattr_t *attr)
+
+{
+    struct list_head *pos;
+    unsigned long flags;
+    ipipe_declare_cpuid;
+    int n;
+
+    if (adp_current != adp_root)
+	{
+	printk(KERN_WARNING "ADEOS: Only the root domain may register a new domain.\n");
+	return -EPERM;
+	}
+
+    for (n = 0; n < ADEOS_NR_CPUS; n++)
+	{
+	adp->cpudata[n].status = 0;
+
+	/* A special case for domains who won't process events. We
+	   need to act as if they had suspended themselves. */
+
+	if (attr->entry == NULL && adp != adp_root)
+	    set_bit(IPIPE_SLEEP_FLAG,&adp->cpudata[n].status);
+	}
+
+    /* A special case for domains who won't process events (i.e. no
+       entry). We have to mark them as suspended so that
+       adeos_suspend_domain() won't consider them, unless they
+       _actually_ receive events, which would lead to a panic
+       situation since they have no stack context... :o> */
+
+    if (attr->entry == NULL && adp != adp_root)
+	for (n = 0; n < ADEOS_NR_CPUS; n++)
+	    set_bit(IPIPE_SLEEP_FLAG,&adp->cpudata[n].status);
+
+    adp->name = attr->name;
+    adp->priority = attr->priority;
+    adp->domid = attr->domid;
+    adp->dswitch = attr->dswitch;
+    adp->ptd_setfun = attr->ptdset;
+    adp->ptd_getfun = attr->ptdget;
+    adp->ptd_keymap = 0;
+    adp->ptd_keycount = 0;
+    adp->ptd_keymax = attr->nptdkeys;
+
+    for (n = 0; n < ADEOS_NR_EVENTS; n++)
+	/* Event handlers must be cleared before the i-pipe stage is
+	   inserted since an exception may occur on behalf of the new
+	   emerging domain. */
+	adp->events[n].handler = NULL;
+
+    if (attr->entry != NULL)
+	__adeos_bootstrap_domain(adp,attr);
+
+    printk("ADEOS: Domain %s registered.\n",adp->name);
+
+    /* Insert the domain in the interrupt pipeline last, so it won't
+       be resumed for processing interrupts until it has a valid stack
+       context. */
+
+    ipipe_init_stage(adp);
+
+    INIT_LIST_HEAD(&adp->link);
+
+    flags = __adeos_critical_enter(NULL);
+
+    list_for_each(pos,&adeos_pipeline) {
+    	adomain_t *_adp = list_entry(pos,adomain_t,link);
+	if (adp->priority > _adp->priority)
+            break;
+    }
+
+    list_add_tail(&adp->link,pos);
+
+    __adeos_critical_exit(flags);
+
+    /* Finally, allow the new domain to perform its initialization
+       chores on behalf of its own stack context. */
+
+    if (attr->entry != NULL)
+	{
+	__adeos_switch_domain(adp);
+
+	ipipe_reload_cpuid();	/* Processor might have changed. */
+
+	if (!test_bit(IPIPE_STALL_FLAG,&adp_root->cpudata[cpuid].status) &&
+	    adp_root->cpudata[cpuid].irq_pending_hi != 0)
+	    ipipe_sync_irqs();
+	}
+
+    return 0;
+}
+
+/* adeos_unregister_domain() -- Remove a domain from the system. All
+   client domains must call this routine to unregister themselves from
+   the ADEOS layer. */
+
+int adeos_unregister_domain (adomain_t *adp)
+
+{
+    unsigned long flags;
+    unsigned event;
+
+    if (adp_current != adp_root)
+	{
+	printk(KERN_WARNING "ADEOS: Only the root domain may unregister a domain.\n");
+	return -EPERM;
+	}
+
+    if (adp == adp_root)
+	{
+	printk(KERN_WARNING "ADEOS: Cannot unregister the root domain.\n");
+	return -EPERM;
+	}
+
+    for (event = 0; event < ADEOS_NR_EVENTS; event++)
+	/* Need this to update the monitor count. */
+	adeos_catch_event(event,NULL);
+
+    /* Simply remove the domain from the pipeline and we are almost
+       done. */
+
+    flags = __adeos_critical_enter(NULL);
+    list_del_init(&adp->link);
+    __adeos_critical_exit(flags);
+
+    __adeos_cleanup_domain(adp);
+
+    printk("ADEOS: Domain %s unregistered.\n",adp->name);
+
+    return 0;
+}
+
+/* adeos_renice_domain() -- Change a domain's priority. This affects
+   the position of the domain in the interrupt pipeline. The greater
+   the priority value, the earlier the domain is informed of incoming
+   events when the pipeline is processed. */
+
+void adeos_renice_domain (adomain_t *adp, int newpri)
+
+{
+    struct list_head *pos;
+    unsigned long flags;
+
+    /* Allows round-robin effect if newpri == oldpri. */
+
+    flags = __adeos_critical_enter(NULL);
+
+    list_del_init(&adp->link);
+
+    list_for_each(pos,&adeos_pipeline) {
+    	adomain_t *_adp = list_entry(pos,adomain_t,link);
+	if (newpri > _adp->priority)
+            break;
+    }
+
+    list_add_tail(&adp->link,pos);
+    adp->priority = newpri;
+
+    __adeos_critical_exit(flags);
+}
+
+/* adeos_suspend_domain() -- tell the ADEOS layer that the current
+   domain is now dormant. The calling domain is switched out, while
+   the next domain with work in progress or pending in the pipeline is
+   switched in. */
+
+void adeos_suspend_domain (void)
+
+{
+    struct adcpudata *cpudata;
+    adomain_t *adp, *nadp;
+    struct list_head *ln;
+    unsigned long flags;
+    ipipe_declare_cpuid;
+
+    adp = nadp = adp_cpu_current[cpuid];
+    cpudata = &adp->cpudata[cpuid];
+
+    ipipe_hw_local_irq_save(flags);
+
+    for (;;)
+	{
+	ln = nadp->link.next;
+
+	if (ln == &adeos_pipeline)	/* End of pipeline reached? */
+	    {
+	    /* Caller should loop on its idle task on return. */
+	    ipipe_hw_local_irq_restore(flags);
+
+	    if (test_and_clear_bit(IPIPE_STALL_FLAG,&cpudata->status) &&
+		cpudata->irq_pending_hi != 0)
+		ipipe_sync_irqs();
+
+	    return;
+	    }
+
+	nadp = list_entry(ln,adomain_t,link);
+
+	/* Make sure the domain was preempted (i.e. not sleeping) or
+	   has some event to process before switching to it. */
+
+	if (!test_bit(IPIPE_SLEEP_FLAG,&nadp->cpudata[cpuid].status) ||
+	    nadp->cpudata[cpuid].irq_pending_hi != 0 ||
+	    test_bit(IPIPE_XPEND_FLAG,&nadp->cpudata[cpuid].status))
+	    break;
+	}
+
+    /* A suspending domain implicitely unstalls the pipeline. */
+    clear_bit(IPIPE_STALL_FLAG,&cpudata->status);
+
+    /* Mark the outgoing domain as aslept (i.e. not preempted). */
+    set_bit(IPIPE_SLEEP_FLAG,&cpudata->status);
+
+    /* Conversely, clear the sleep bit for the incoming domain. */
+    clear_bit(IPIPE_SLEEP_FLAG,&nadp->cpudata[cpuid].status);
+
+    /* Suspend the calling domain, switching to the next one. */
+    __adeos_switch_domain(nadp);
+
+    ipipe_hw_local_irq_restore(flags);
+
+#ifdef CONFIG_SMP
+    ipipe_reload_cpuid();	/* Processor might have changed. */
+    adp = adp_cpu_current[cpuid];
+    cpudata = &adp->cpudata[cpuid];
+#endif
+
+    /* Now, we are back into the calling domain. Flush the interrupt
+       log and fire the event interposition handler if needed. */
+
+    if (cpudata->irq_pending_hi != 0)
+	ipipe_sync_irqs();
+
+    /* Caution: CPU migration is allowed in SMP-mode on behalf of an
+       event handler provided that the current domain raised
+       it. Otherwise, it's not. */
+
+    if (test_and_clear_bit(IPIPE_XPEND_FLAG,&cpudata->status))
+	adp->events[cpudata->event_data.event].handler(&cpudata->event_data);
+
+    /* Return to the point of suspension in the calling domain. */
+}
+
+/* adeos_virtualize_irq() -- Attach a handler (and optionally an hw
+   acknowledge routine) to an interrupt for the current domain. */
+
+int adeos_virtualize_irq (unsigned irq,
+			  void (*handler)(unsigned irq),
+			  int (*acknowledge)(unsigned irq),
+			  unsigned modemask)
+{
+    if (irq >= IPIPE_NR_IRQS)
+	return -EINVAL;
+
+    return ipipe_hook_irq(irq,handler,acknowledge,modemask);
+}
+
+/* adeos_control_irq() -- Change an interrupt mode. This affects the
+   way a given interrupt is handled by ADEOS for the current
+   domain. setmask is a bitmask telling whether:
+   - the interrupt should be passed to the domain (IPIPE_HANDLE_MASK),
+     and/or
+   - the interrupt should be passed down to the lower priority domain(s)
+     in the pipeline (IPIPE_PASS_MASK).
+   This leads to four possibilities:
+   - PASS only => Ignore the interrupt
+   - HANDLE only => Terminate the interrupt (process but don't pass down)
+   - PASS + HANDLE => Accept the interrupt (process and pass down)
+   - <none> => Discard the interrupt
+   - DYNAMIC is currently an alias of HANDLE since it marks an interrupt
+   which is processed by the current domain but not implicitely passed
+   down to the pipeline, letting the domain's handler choose on a case-
+   by-case basis whether the interrupt propagation should be forced
+   using adeos_propagate_irq().
+   clrmask clears the corresponding bits from the control field before
+   setmask is applied.
+*/
+
+int adeos_control_irq (unsigned irq,
+		       unsigned clrmask,
+		       unsigned setmask) {
+
+    if (irq >= IPIPE_NR_IRQS)
+	return -EINVAL;
+
+    return ipipe_control_irq(irq,clrmask,setmask);
+}
+
+/* adeos_propagate_irq() -- Force a given IRQ propagation on behalf of
+   a running interrupt handler to the next domain down the pipeline.
+   Returns non-zero if a domain has received the interrupt
+   notification, zero otherwise.
+   This call is useful for handling shared interrupts among domains.
+   e.g. pipeline = [domain-A]---[domain-B]...
+   Both domains share IRQ #X.
+   - domain-A handles IRQ #X but does not pass it down (i.e. Terminate
+   or Dynamic interrupt control mode)
+   - domain-B handles IRQ #X (i.e. Terminate or Accept interrupt
+   control modes).
+   When IRQ #X is raised, domain-A's handler determines whether it
+   should process the interrupt by identifying its source. If not,
+   adeos_propagate_irq() is called so that the next domain down the
+   pipeline which handles IRQ #X is given a chance to process it. This
+   process can be repeated until the end of the pipeline is
+   reached. */
+
+int adeos_propagate_irq (unsigned irq) {
+
+    return irq < IPIPE_NR_IRQS ? ipipe_propagate_irq(irq) : -EINVAL;
+}
+
+/* adeos_alloc_irq() -- Allocate a virtual/soft pipelined interrupt.
+   Virtual interrupts are handled in exactly the same way than their
+   hw-generated counterparts. This is a very basic, one-way only,
+   inter-domain communication system (see adeos_trigger_irq()).  Note:
+   it is not necessary for a domain to allocate a virtual interrupt to
+   trap it using adeos_virtualize_irq(). The newly allocated VIRQ
+   number which can be passed to other IRQ-related services is
+   returned on success, zero otherwise (i.e. no more virtual interrupt
+   channel is available). */
+
+unsigned adeos_alloc_irq (void) {
+
+    return ipipe_alloc_irq();
+}
+
+/* adeos_free_irq() -- Return a previously allocated virtual/soft
+   pipelined interrupt to the pool of allocatable interrupts. */
+
+int adeos_free_irq (unsigned irq)
+
+{
+    if (irq >= IPIPE_NR_IRQS)
+	return -EINVAL;
+
+    ipipe_free_irq(irq);
+
+    return 0;
+}
+
+/* adeos_trigger_irq() -- Push the interrupt to the pipeline entry
+   just like if it has been actually received from a hw source. This
+   both works for real and virtual interrupts. This also means that
+   the current domain might be immediately preempted by a more
+   prioritary domain who happens to handle this interrupt. */
+
+int adeos_trigger_irq (unsigned irq) {
+
+    return irq < IPIPE_NR_IRQS ? ipipe_trigger_irq(irq) : -EINVAL;
+}
+
+/* adeos_trigger_ipi() -- Send the ADEOS service IPI to other
+   processors. This leads to */
+
+int adeos_trigger_ipi (int cpuid) {
+
+    return ipipe_trigger_ipi(cpuid);
+}
+
+int adeos_get_sysinfo (adsysinfo_t *info) {
+
+    return __adeos_get_sysinfo(info);
+}
+
+/* adeos_stall_ipipe() -- Stall the interrupt pipeline.  Must be
+   callable from C and assembly language. */
+
+void adeos_stall_ipipe (void) {
+
+    ipipe_declare_cpuid;
+
+    set_bit(IPIPE_STALL_FLAG,&adp_current->cpudata[cpuid].status);
+}
+
+/* adeos_unstall_ipipe() -- Unstall the interrupt pipeline and
+   synchronize pending events. Must be callable from C and assembly
+   language. */
+
+void adeos_unstall_ipipe (void)
+
+{
+    ipipe_declare_cpuid;
+
+    clear_bit(IPIPE_STALL_FLAG,&adp_current->cpudata[cpuid].status);
+    ipipe_hw_sti();
+
+    if (adp_current->cpudata[cpuid].irq_pending_hi != 0)
+	ipipe_sync_irqs();
+}
+
+/* adeos_unstall_ipipe() -- Unstall the interrupt pipeline and
+   synchronize pending events from a given domain. */
+
+void adeos_unstall_ipipe_from (adomain_t *adp)
+
+{
+    struct list_head *pos;
+    ipipe_declare_cpuid;
+
+    clear_bit(IPIPE_STALL_FLAG,&adp->cpudata[cpuid].status);
+
+    if (adp == adp_cpu_current[cpuid])
+	{
+	ipipe_hw_sti();
+
+	if (adp->cpudata[cpuid].irq_pending_hi != 0)
+	    ipipe_sync_irqs();
+
+	return;
+	}
+
+    /* Attempt to flush all events that might be pending at the
+       unstalled domain level. This code is roughly lifted from
+       ipipe.c:ipipe_handle_irq(). */
+
+    list_for_each(pos,&adeos_pipeline) {
+
+    	adomain_t *_adp = list_entry(pos,adomain_t,link);
+
+	if (test_bit(IPIPE_STALL_FLAG,&_adp->cpudata[cpuid].status))
+	    break; /* Stalled stage -- do not go further. */
+
+	if (_adp->cpudata[cpuid].irq_pending_hi != 0)
+	    {
+	    /* Since the critical IPI might be serviced by the
+	       following actions, the current domain might not be
+	       linked to the pipeline anymore after its handler
+	       returns on SMP boxes, even if the domain remains valid
+	       (see adeos_unregister_domain()), so don't make any
+	       hazardous assumptions here. */
+
+	    ipipe_hw_sti();
+
+	    if (_adp == adp_cpu_current[cpuid])
+		ipipe_sync_irqs();
+	    else
+		{
+		__adeos_switch_domain(_adp);
+		ipipe_reload_cpuid(); /* Processor might have changed. */
+		}
+	    
+	    break;
+	    }
+	else if (_adp == adp_cpu_current[cpuid])
+	    break;
+    }
+}
+
+/* adeos_catch_event() -- Interpose an event handler for the
+   current domain. */
+
+int adeos_catch_event (unsigned event, void (*handler)(adevinfo_t *))
+
+{
+    if (event >= ADEOS_NR_EVENTS)
+	return -EINVAL;
+
+    if (!xchg(&adp_current->events[event].handler,handler))
+	{
+	if (handler)
+	    __adeos_event_monitors[event]++;
+	}
+    else if (!handler)
+	__adeos_event_monitors[event]--;
+
+    return 0;
+}
+
+void (*adeos_hook_dswitch(void (*handler)(void))) (void) {
+
+    return (void (*)(void))xchg(&adp_current->dswitch,handler);
+}
+
+void adeos_init_attr (adattr_t *attr)
+
+{
+    attr->name = "Anonymous";
+    attr->domid = 1;
+    attr->entry = NULL;
+    attr->estacksz = 0;	/* Let ADEOS choose a reasonable stack size */
+    attr->priority = ADEOS_ROOT_PRI;
+    attr->dswitch = NULL;
+    attr->nptdkeys = 0;
+    attr->ptdset = NULL;
+    attr->ptdget = NULL;
+}
+
+int adeos_tune_timer (unsigned long ns, int flags) {
+
+    return __adeos_tune_timer(ns,flags);
+}
+
+int adeos_alloc_ptdkey (void)
+
+{
+    unsigned long flags;
+    int key = -1;
+
+    ipipe_hw_spin_lock(&adeos_pipelock,flags);
+
+    if (adp_current->ptd_keycount < adp_current->ptd_keymax)
+	{
+	key = ffz(adp_current->ptd_keymap);
+	set_bit(key,&adp_current->ptd_keymap);
+	adp_current->ptd_keycount++;
+	}
+
+    ipipe_hw_spin_unlock(&adeos_pipelock,flags);
+
+    return key;
+}
+
+int adeos_free_ptdkey (int key)
+
+{
+    unsigned long flags; 
+
+    if (key < 0 || key >= adp_current->ptd_keymax)
+	return -EINVAL;
+
+    ipipe_hw_spin_lock(&adeos_pipelock,flags);
+
+    if (test_and_clear_bit(key,&adp_current->ptd_keymap))
+	adp_current->ptd_keycount--;
+
+    ipipe_hw_spin_unlock(&adeos_pipelock,flags);
+
+    return 0;
+}
+
+int adeos_set_ptd (int key, void *value)
+
+{
+    if (key < 0 || key >= adp_current->ptd_keymax)
+	return -EINVAL;
+
+    if (!adp_current->ptd_setfun)
+	{
+	printk(KERN_WARNING "ADEOS: not ptdset hook for %s\n",adp_current->name);
+	return -EINVAL;
+	}
+
+    adp_current->ptd_setfun(key,value);
+
+    return 0;
+}
+
+void *adeos_get_ptd (int key)
+
+{
+    if (key < 0 || key >= adp_current->ptd_keymax)
+	return NULL;
+
+    if (!adp_current->ptd_getfun)
+	{
+	printk(KERN_WARNING "ADEOS: not ptdget hook for %s\n",adp_current->name);
+	return NULL;
+	}
+
+    return adp_current->ptd_getfun(key);
+}
+
+unsigned long adeos_critical_enter (void (*syncfn)(void)) {
+
+    return __adeos_critical_enter(syncfn);
+}
+
+void adeos_critical_exit (unsigned long flags) {
+
+    __adeos_critical_exit(flags);
+}
diff -urpN linux-2.5.38/kernel/fork.c linux-2.5.38-adeos/kernel/fork.c
--- linux-2.5.38/kernel/fork.c	Sun Sep 22 00:25:00 2002
+++ linux-2.5.38-adeos/kernel/fork.c	Sun Sep 22 21:57:19 2002
@@ -846,6 +846,14 @@ static struct task_struct *copy_process(
 
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
+#ifdef CONFIG_ADEOS
+	{
+	int k;
+
+	for (k = 0; k < ADEOS_ROOT_NPTDKEYS; k++)
+	    p->ptd[k] = NULL;
+	}
+#endif /* CONFIG_ADEOS */
 	retval = 0;
 
 fork_out:
diff -urpN linux-2.5.38/kernel/ksyms.c linux-2.5.38-adeos/kernel/ksyms.c
--- linux-2.5.38/kernel/ksyms.c	Sun Sep 22 00:24:58 2002
+++ linux-2.5.38-adeos/kernel/ksyms.c	Sun Sep 22 21:57:19 2002
@@ -612,3 +612,35 @@ EXPORT_SYMBOL(__per_cpu_offset);
 
 /* debug */
 EXPORT_SYMBOL(dump_stack);
+
+#ifdef CONFIG_ADEOS
+EXPORT_SYMBOL(adeos_register_domain);
+EXPORT_SYMBOL(adeos_unregister_domain);
+EXPORT_SYMBOL(adeos_renice_domain);
+EXPORT_SYMBOL(adeos_suspend_domain);
+EXPORT_SYMBOL(adeos_virtualize_irq);
+EXPORT_SYMBOL(adeos_control_irq);
+EXPORT_SYMBOL(adeos_propagate_irq);
+EXPORT_SYMBOL(adeos_alloc_irq);
+EXPORT_SYMBOL(adeos_free_irq);
+EXPORT_SYMBOL(adeos_trigger_irq);
+EXPORT_SYMBOL(adeos_trigger_ipi);
+EXPORT_SYMBOL(adeos_stall_ipipe);
+EXPORT_SYMBOL(adeos_unstall_ipipe);
+EXPORT_SYMBOL(adeos_unstall_ipipe_from);
+EXPORT_SYMBOL(adeos_catch_event);
+EXPORT_SYMBOL(adeos_hook_dswitch);
+EXPORT_SYMBOL(adeos_init_attr);
+EXPORT_SYMBOL(adeos_get_sysinfo);
+EXPORT_SYMBOL(adeos_tune_timer);
+EXPORT_SYMBOL(adeos_alloc_ptdkey);
+EXPORT_SYMBOL(adeos_free_ptdkey);
+EXPORT_SYMBOL(adeos_set_ptd);
+EXPORT_SYMBOL(adeos_get_ptd);
+EXPORT_SYMBOL(adeos_critical_enter);
+EXPORT_SYMBOL(adeos_critical_exit);
+EXPORT_SYMBOL(adp_cpu_current);
+EXPORT_SYMBOL(adp_root);
+/* Private symbols. */
+EXPORT_SYMBOL(__adeos_online_cpus);
+#endif /* CONFIG_ADEOS */
diff -urpN linux-2.5.38/kernel/printk.c linux-2.5.38-adeos/kernel/printk.c
--- linux-2.5.38/kernel/printk.c	Sun Sep 22 00:25:31 2002
+++ linux-2.5.38-adeos/kernel/printk.c	Sun Sep 22 21:57:19 2002
@@ -194,17 +194,33 @@ int do_syslog(int type, char * buf, int 
 		if (error)
 			goto out;
 		i = 0;
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_lock_disable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_lock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		while ((log_start != log_end) && i < len) {
 			c = LOG_BUF(log_start);
 			log_start++;
+#ifdef CONFIG_ADEOS
+			ipipe_hw_spin_unlock_enable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 			spin_unlock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 			__put_user(c,buf);
 			buf++;
 			i++;
+#ifdef CONFIG_ADEOS
+			ipipe_hw_spin_lock_disable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 			spin_lock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		}
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_unlock_enable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_unlock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		error = i;
 		break;
 	case 4:		/* Read/clear last kernel messages */
@@ -223,7 +239,11 @@ int do_syslog(int type, char * buf, int 
 		count = len;
 		if (count > LOG_BUF_LEN)
 			count = LOG_BUF_LEN;
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_lock_disable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_lock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		if (count > logged_chars)
 			count = logged_chars;
 		if (do_clear)
@@ -240,11 +260,23 @@ int do_syslog(int type, char * buf, int 
 			if (j+LOG_BUF_LEN < log_end)
 				break;
 			c = LOG_BUF(j);
+#ifdef CONFIG_ADEOS
+			ipipe_hw_spin_unlock_enable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 			spin_unlock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 			__put_user(c,&buf[count-1-i]);
+#ifdef CONFIG_ADEOS
+			ipipe_hw_spin_lock_disable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 			spin_lock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		}
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_unlock_enable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_unlock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		error = i;
 		if(i != count) {
 			int offset = count-error;
@@ -257,19 +289,43 @@ int do_syslog(int type, char * buf, int 
 
 		break;
 	case 5:		/* Clear ring buffer */
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_lock_disable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_lock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		logged_chars = 0;
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_unlock_enable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_unlock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		break;
 	case 6:		/* Disable logging to console */
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_lock_disable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_lock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		console_loglevel = minimum_console_loglevel;
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_unlock_enable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_unlock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		break;
 	case 7:		/* Enable logging to console */
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_lock_disable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_lock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		console_loglevel = default_console_loglevel;
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_unlock_enable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_unlock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		break;
 	case 8:		/* Set level of messages printed to console */
 		error = -EINVAL;
@@ -277,15 +333,31 @@ int do_syslog(int type, char * buf, int 
 			goto out;
 		if (len < minimum_console_loglevel)
 			len = minimum_console_loglevel;
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_lock_disable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_lock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		console_loglevel = len;
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_unlock_enable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_unlock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		error = 0;
 		break;
 	case 9:		/* Number of chars in the log buffer */
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_lock_disable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_lock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		error = log_end - log_start;
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_unlock_enable(&logbuf_lock);
+#else  /* !CONFIG_ADEOS */
 		spin_unlock_irq(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		break;
 	case 10:
 		lbuf = kmalloc(len + 1, GFP_KERNEL);
@@ -430,13 +502,21 @@ asmlinkage int printk(const char *fmt, .
 
 	if (oops_in_progress) {
 		/* If a crash is occurring, make sure we can't deadlock */
+#ifdef CONFIG_ADEOS
+	        ipipe_hw_spin_lock_init(&logbuf_lock);
+#else /* !CONFIG_ADEOS */
 		spin_lock_init(&logbuf_lock);
+#endif /* CONFIG_ADEOS */
 		/* And make sure that we print immediately */
 		init_MUTEX(&console_sem);
 	}
 
 	/* This stops the holder of console_sem just where we want him */
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_lock(&logbuf_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_lock_irqsave(&logbuf_lock, flags);
+#endif /* CONFIG_ADEOS */
 
 	/* Emit the output into the temporary buffer */
 	va_start(args, fmt);
@@ -466,7 +546,11 @@ asmlinkage int printk(const char *fmt, .
 		 * On some architectures, the consoles are not usable
 		 * on secondary CPUs early in the boot process.
 		 */
+#ifdef CONFIG_ADEOS
+	        ipipe_hw_spin_unlock(&logbuf_lock, flags);
+#else /* !CONFIG_ADEOS */
 		spin_unlock_irqrestore(&logbuf_lock, flags);
+#endif /* CONFIG_ADEOS */
 		goto out;
 	}
 	if (!down_trylock(&console_sem)) {
@@ -474,7 +558,11 @@ asmlinkage int printk(const char *fmt, .
 		 * We own the drivers.  We can drop the spinlock and let
 		 * release_console_sem() print the text
 		 */
+#ifdef CONFIG_ADEOS
+	        ipipe_hw_spin_unlock(&logbuf_lock, flags);
+#else /* !CONFIG_ADEOS */
 		spin_unlock_irqrestore(&logbuf_lock, flags);
+#endif /* CONFIG_ADEOS */
 		console_may_schedule = 0;
 		release_console_sem();
 	} else {
@@ -483,7 +571,11 @@ asmlinkage int printk(const char *fmt, .
 		 * allows the semaphore holder to proceed and to call the
 		 * console drivers with the output which we just produced.
 		 */
+#ifdef CONFIG_ADEOS
+	        ipipe_hw_spin_unlock(&logbuf_lock, flags);
+#else /* !CONFIG_ADEOS */
 		spin_unlock_irqrestore(&logbuf_lock, flags);
+#endif /* CONFIG_ADEOS */
 	}
 out:
 	return printed_len;
@@ -528,19 +620,31 @@ void release_console_sem(void)
 	unsigned long wake_klogd = 0;
 
 	for ( ; ; ) {
+#ifdef CONFIG_ADEOS
+	        ipipe_hw_spin_lock(&logbuf_lock, flags);
+#else /* !CONFIG_ADEOS */
 		spin_lock_irqsave(&logbuf_lock, flags);
+#endif /* CONFIG_ADEOS */
 		wake_klogd |= log_start - log_end;
 		if (con_start == log_end)
 			break;			/* Nothing to print */
 		_con_start = con_start;
 		_log_end = log_end;
 		con_start = log_end;		/* Flush */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+#ifdef CONFIG_ADEOS
+ 	        ipipe_hw_spin_unlock(&logbuf_lock, flags);
+#else /* !CONFIG_ADEOS */
+  		spin_unlock_irqrestore(&logbuf_lock, flags);
+#endif /* CONFIG_ADEOS */
 		call_console_drivers(_con_start, _log_end);
 	}
 	console_may_schedule = 0;
 	up(&console_sem);
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_unlock(&logbuf_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_unlock_irqrestore(&logbuf_lock, flags);
+#endif /* CONFIG_ADEOS */
 	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
 		wake_up_interruptible(&log_wait);
 }
@@ -653,9 +757,17 @@ void register_console(struct console * c
 		/*
 		 * release_cosole_sem() will print out the buffered messages for us.
 		 */
+#ifdef CONFIG_ADEOS
+	        ipipe_hw_spin_lock(&logbuf_lock, flags);
+#else /* !CONFIG_ADEOS */
 		spin_lock_irqsave(&logbuf_lock, flags);
+#endif /* CONFIG_ADEOS */
 		con_start = log_start;
+#ifdef CONFIG_ADEOS
+	        ipipe_hw_spin_unlock(&logbuf_lock, flags);
+#else /* !CONFIG_ADEOS */
 		spin_unlock_irqrestore(&logbuf_lock, flags);
+#endif /* CONFIG_ADEOS */
 	}
 	release_console_sem();
 }
diff -urpN linux-2.5.38/kernel/sched.c linux-2.5.38-adeos/kernel/sched.c
--- linux-2.5.38/kernel/sched.c	Sun Sep 22 00:25:17 2002
+++ linux-2.5.38-adeos/kernel/sched.c	Sun Sep 22 21:57:19 2002
@@ -1041,6 +1041,14 @@ asmlinkage void preempt_schedule(void)
 {
 	struct thread_info *ti = current_thread_info();
 
+#ifdef CONFIG_ADEOS
+ 	/* The in-kernel preemption routine might be indirectly called
+ 	   from code running in other domains, so we must ensure that
+ 	   scheduling only takes place on behalf of the root (Linux)
+ 	   one. */
+	if (adp_current != adp_root)
+	    return;
+#endif /* CONFIG_ADEOS */
 	/*
 	 * If there is a non-zero preempt_count or interrupts are disabled,
 	 * we do not want to preempt the current task.  Just return..
diff -urpN linux-2.5.38/kernel/sysctl.c linux-2.5.38-adeos/kernel/sysctl.c
--- linux-2.5.38/kernel/sysctl.c	Sun Sep 22 00:25:00 2002
+++ linux-2.5.38-adeos/kernel/sysctl.c	Sun Sep 22 21:57:19 2002
@@ -362,6 +362,9 @@ void __init sysctl_init(void)
 #ifdef CONFIG_PROC_FS
 	register_proc_table(root_table, proc_sys_root);
 	init_irq_proc();
+#ifdef CONFIG_ADEOS
+	__adeos_init_proc();
+#endif /* CONFIG_ADEOS */
 #endif
 }
