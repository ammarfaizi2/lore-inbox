Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUCPMbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 07:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUCPMbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 07:31:33 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:65214 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261207AbUCPMbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 07:31:21 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Modular OOM handlers for 2.6.4 (1/2)
Date: Tue, 16 Mar 2004 13:35:44 +0100
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gSvVAlaYHKHV7Rs"
Message-Id: <200403161335.44755.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gSvVAlaYHKHV7Rs
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hello to all!

Here goes my effort in making modular infrastructure for OOM handling.

Config is added under "General options" and it defaults to same behavior as so 
far. Don't know what else to write here.. I guess you will look at the patch 
and that will tell you everything.

Base patch contains only the infrastructure with existing handler which is 
called classic OOM killer.

Regards,
Tvrtko

--Boundary-00=_gSvVAlaYHKHV7Rs
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="moom-2.6.4-base.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="moom-2.6.4-base.patch"

diff -Naur linux-2.6.4/include/linux/notifier.h linux-2.6.4-moom/include/linux/notifier.h
--- linux-2.6.4/include/linux/notifier.h	2004-01-09 07:59:08.000000000 +0100
+++ linux-2.6.4-moom/include/linux/notifier.h	2004-03-16 11:39:47.000000000 +0100
@@ -58,6 +58,8 @@
 #define SYS_HALT	0x0002	/* Notify of system halt */
 #define SYS_POWER_OFF	0x0003	/* Notify of system power off */
 
+#define OUT_OF_MEMORY  0x00001 /* Notify of critical memory shortage */
+
 #define NETLINK_URELEASE	0x0001	/* Unicast netlink socket released */
 
 #define CPU_ONLINE	0x0002 /* CPU (unsigned)v is up */
diff -Naur linux-2.6.4/include/linux/oom_notify.h linux-2.6.4-moom/include/linux/oom_notify.h
--- linux-2.6.4/include/linux/oom_notify.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.4-moom/include/linux/oom_notify.h	2004-03-16 11:25:23.000000000 +0100
@@ -0,0 +1,40 @@
+#ifndef _LINUX_OOM_NOTIFY_H
+#define _LINUX_OOM_NOTIFY_H
+
+
+#ifdef debug
+#undef dbg
+#endif
+#define dbg(format, arg...)					\
+do {							\
+		printk (KERN_DEBUG "Out of memory: " format "\n",	## arg);                        \
+} while(0)
+
+#ifdef warn
+#undef warn
+#endif
+#define warn(format, arg...)					  \
+do {							  \
+		printk (KERN_WARNING "Out of memory: " format "\n", ## arg);                          \
+} while(0)
+
+#ifdef info
+#undef info
+#endif
+#define info(format, arg...)					  \
+do {							  \
+		printk (KERN_INFO "Out of Memory: " format "\n", ## arg);                          \
+} while(0)
+
+#ifdef error
+#undef error
+#endif
+#define error(format, arg...)					        \
+do {							        \
+		printk (KERN_ERR "Out of Memory: " format "\n",	## arg);                                \
+} while(0)
+
+int register_oom_notifier(struct notifier_block * nb);
+int unregister_oom_notifier(struct notifier_block * nb);
+
+#endif /* _LINUX_OOM_NOTIFY_H */
diff -Naur linux-2.6.4/include/linux/sysctl.h linux-2.6.4-moom/include/linux/sysctl.h
--- linux-2.6.4/include/linux/sysctl.h	2004-03-16 10:42:38.000000000 +0100
+++ linux-2.6.4-moom/include/linux/sysctl.h	2004-03-16 11:40:10.000000000 +0100
@@ -158,6 +158,7 @@
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
+	VM_OOM=22,   /* Out of memory */
 };
 
 
diff -Naur linux-2.6.4/init/Kconfig linux-2.6.4-moom/init/Kconfig
--- linux-2.6.4/init/Kconfig	2004-03-16 10:42:38.000000000 +0100
+++ linux-2.6.4-moom/init/Kconfig	2004-03-16 11:09:10.000000000 +0100
@@ -181,7 +181,32 @@
 	  This option enables access to kernel configuration file and build
 	  information through /proc/config.gz.
 
+menuconfig OOM_KILLER
+	bool "Select task to kill on out of memory condition"
+	default y
+	help
+	  This option selects the kernel behaviour during total out of memory
+	  condition.
+
+	  The default behaviour is to, as soon as no freeable memory and no swap
+	  space are available, kill the task which tries to allocate memory.
+	  The default behaviour is very reliable.
 
+	  If you select this option, as soon as no freeable memory is available,
+	  the kernel will try to select the "best" task to be killed.
+
+	  If unsure, say Y.
+
+config OOM_KILLER_CLASSIC	  
+	tristate "Classic OOM killer" if OOM_KILLER
+	default y
+	help
+	  This option enables the traditional oom_kill.c mechanism for
+	  killing processes in an attempt to recover from an out-of-memory
+	  condition.
+  
+	  If unsure, say Y.
+			  	  
 menuconfig EMBEDDED
 	bool "Remove kernel features (for embedded systems)"
 	help
diff -Naur linux-2.6.4/kernel/fork.c linux-2.6.4-moom/kernel/fork.c
--- linux-2.6.4/kernel/fork.c	2004-03-16 10:42:38.000000000 +0100
+++ linux-2.6.4-moom/kernel/fork.c	2004-03-16 12:16:23.077838424 +0100
@@ -1,4 +1,3 @@
-/*
  *  linux/kernel/fork.c
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
@@ -450,6 +449,8 @@
 	}
 }
 
+EXPORT_SYMBOL_GPL(mmput);
+
 /*
  * Checks if the use count of an mm is non-zero and if so
  * returns a reference to it after bumping up the use count.
@@ -467,6 +468,8 @@
 	return mm;
 }
 
+EXPORT_SYMBOL_GPL(mmgrab);
+
 /* Please note the differences between mmput and mm_release.
  * mmput is called whenever we stop holding onto a mm_struct,
  * error success whatever.
diff -Naur linux-2.6.4/mm/Makefile linux-2.6.4-moom/mm/Makefile
--- linux-2.6.4/mm/Makefile	2004-01-09 07:59:45.000000000 +0100
+++ linux-2.6.4-moom/mm/Makefile	2004-03-16 11:23:54.000000000 +0100
@@ -7,8 +7,11 @@
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
 			   shmem.o vmalloc.o
 
-obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
+obj-y			:= bootmem.o filemap.o mempool.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
 			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+
+obj-$(CONFIG_OOM_KILLER)  += oom_notify.o
+obj-$(CONFIG_OOM_KILLER_CLASSIC)  += oom_kill.o
diff -Naur linux-2.6.4/mm/oom_kill.c linux-2.6.4-moom/mm/oom_kill.c
--- linux-2.6.4/mm/oom_kill.c	2004-01-09 07:59:43.000000000 +0100
+++ linux-2.6.4-moom/mm/oom_kill.c	2004-03-16 12:17:39.000000000 +0100
@@ -13,6 +13,10 @@
  *  machine) this file will double as a 'coding guide' and a signpost
  *  for newbie kernel hackers. It features several pointers to major
  *  kernel subsystems and hints as to where to find out what things do.
+ *
+ * Modularized by using notifies by --rustyl <rusty@linux.intel.com>
+ * Final modularization (C) 2003,2004  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
+ *
  */
 
 #include <linux/mm.h>
@@ -20,6 +24,10 @@
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/oom_notify.h>
 
 /* #define DEBUG */
 
@@ -93,10 +101,9 @@
 	 */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
 		points /= 4;
-#ifdef DEBUG
-	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
-	p->pid, p->comm, points);
-#endif
+	#ifdef DEBUG
+	dbg("Task %d (%s) got %d points",p->pid, p->comm, points);
+	#endif
 	return points;
 }
 
@@ -136,12 +143,12 @@
 	task_lock(p);
 	if (!p->mm || p->mm == &init_mm) {
 		WARN_ON(1);
-		printk(KERN_WARNING "tried to kill an mm-less task!\n");
+		warn("Tried to kill an mm-less task!");
 		task_unlock(p);
 		return;
 	}
 	task_unlock(p);
-	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
+	err("Killed process %d (%s).", p->pid, p->comm);
 
 	/*
 	 * We give our sacrificial lamb high priority and access to
@@ -204,7 +211,7 @@
 			__oom_kill_task(q);
 	while_each_thread(g, q);
 	if (!p->mm)
-		printk(KERN_INFO "Fixed up OOM kill of mm-less task\n");
+		info("Fixed up OOM kill of mm-less task");
 	read_unlock(&tasklist_lock);
 	mmput(mm);
 
@@ -220,7 +227,7 @@
 /**
  * out_of_memory - is the system out of memory?
  */
-void out_of_memory(void)
+static void out_of_memory_killer(void)
 {
 	/*
 	 * oom_lock protects out_of_memory()'s static variables.
@@ -295,3 +302,36 @@
 out_unlock:
 	spin_unlock(&oom_lock);
 }
+
+static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
+{
+	out_of_memory_killer();
+	return 0;
+}
+
+static struct notifier_block oom_nb = {
+	.notifier_call = oom_notify,
+};
+
+static int __init init_classic_oom_kill(void)
+{
+	int err;
+
+	info("Installing classic out of memory killer");
+	err = register_oom_notifier(&oom_nb);
+	if (err)
+		error("Error installing classic out of memory killer!");
+
+	return err;
+}
+
+static void __exit exit_classic_oom_kill(void)
+{
+	unregister_oom_notifier(&oom_nb);
+	info("Unregistered classic out of memory killer");
+}
+
+MODULE_LICENSE("GPL");
+
+module_init(init_classic_oom_kill);
+module_exit(exit_classic_oom_kill);
diff -Naur linux-2.6.4/mm/oom_notify.c linux-2.6.4-moom/mm/oom_notify.c
--- linux-2.6.4/mm/oom_notify.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.4-moom/mm/oom_notify.c	2004-03-16 11:11:40.000000000 +0100
@@ -0,0 +1,44 @@
+/*
+ * linux/mm/oom_notify.c
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <asm/semaphore.h>
+
+static DECLARE_MUTEX(notify_mutex);
+static struct notifier_block * oom_notify_list = 0;
+
+int register_oom_notifier(struct notifier_block * nb)
+{
+	int err;
+
+	down(&notify_mutex);
+	err = notifier_chain_register(&oom_notify_list, nb);
+	up(&notify_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL(register_oom_notifier);
+
+int unregister_oom_notifier(struct notifier_block * nb)
+{
+	int err;
+
+	down(&notify_mutex);
+	err = notifier_chain_unregister(&oom_notify_list, nb);
+	up(&notify_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL(unregister_oom_notifier);
+
+void out_of_memory(void)
+{
+	down(&notify_mutex);
+	notifier_call_chain(&oom_notify_list, OUT_OF_MEMORY, 0);
+	up(&notify_mutex);
+}
+EXPORT_SYMBOL(out_of_memory);
diff -Naur linux-2.6.4/mm/page_alloc.c linux-2.6.4-moom/mm/page_alloc.c
--- linux-2.6.4/mm/page_alloc.c	2004-03-16 10:42:38.000000000 +0100
+++ linux-2.6.4-moom/mm/page_alloc.c	2004-03-16 12:17:27.000000000 +0100
@@ -1058,6 +1058,8 @@
 	show_swap_cache_info();
 }
 
+EXPORT_SYMBOL_GPL(show_free_areas);
+
 /*
  * Builds allocation fallback zone lists.
  */
diff -Naur linux-2.6.4/mm/vmscan.c linux-2.6.4-moom/mm/vmscan.c
--- linux-2.6.4/mm/vmscan.c	2004-03-16 10:42:11.000000000 +0100
+++ linux-2.6.4-moom/mm/vmscan.c	2004-03-16 11:10:18.000000000 +0100
@@ -893,8 +893,11 @@
 			}
 		}
 	}
+#ifdef CONFIG_OOM_KILLER	
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
 		out_of_memory();
+#endif
+
 out:
 	for (i = 0; zones[i] != 0; i++)
 		zones[i]->prev_priority = zones[i]->temp_priority;

--Boundary-00=_gSvVAlaYHKHV7Rs--
