Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTILCTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTILCTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:19:48 -0400
Received: from fmr06.intel.com ([134.134.136.7]:54496 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261190AbTILCTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:19:42 -0400
Date: Thu, 11 Sep 2003 19:19:10 -0700
Message-Id: <200309120219.h8C2JANc004514@penguin.co.intel.com>
From: Rusty Lynch <rusty@penguin.co.intel.com>
To: riel@conectiva.com.br
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Reply-To: rusty@linux.co.intel.com
Subject: [RFC] Enabling other oom schemes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Over the years I have encountered various usage needs where the standard
oom_kill.c version of memory recovery was not the most ideal approach.
For example, some times it is better to just restart the system and 
let a front end load balancer hand off the server load to another system.
Sometimes it might be worth the effort to write a very solution specific
oom handler.

Every now and then I hear rumblings of changing the way oom is handled by
using modules, or something.  Since I was not able to uncover any actual
proposals, here is my quick attempt.

The patch below uses a notifier list for other components to register
to be called when an out of memory condition occurs.  Basically:

* Added include/linux/oom_notifier.h and mm/oom_notifier.c
  which add (un)registration functions and also provide the 
  out_of_memory() entry function that use to be held in mm/oom_kill.c

* Tweaked mm/oom_kill.c so that it can be enabled at build time.
  (I wasn't able to make it build as a module because it is using
   a few non-exported symbols in linux/mm/*)

* Added a very simple (in fact I'm sure too simple) mm/om_panic.c that
  will panic on any oom condition

The patch works (although by looking over oom_kill.c, I'm sure oom_panic.c
will panic too soon), but it is really only a quick hack to see how people
feel about such an approach.

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1284  -> 1.1285 
#	include/linux/notifier.h	1.4     -> 1.5    
#	       mm/oom_kill.c	1.24    -> 1.25   
#	         mm/Makefile	1.24    -> 1.25   
#	        init/Kconfig	1.28    -> 1.29   
#	               (new)	        -> 1.1     mm/oom_panic.c 
#	               (new)	        -> 1.1     include/linux/oom_notifier.h
#	               (new)	        -> 1.1     mm/oom_notifier.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/11	rusty@penguin.co.intel.com	1.1285
# Initial attempt at an oom notifier
# --------------------------------------------
#
diff -Nru a/include/linux/notifier.h b/include/linux/notifier.h
--- a/include/linux/notifier.h	Thu Sep 11 18:34:47 2003
+++ b/include/linux/notifier.h	Thu Sep 11 18:34:47 2003
@@ -66,5 +66,7 @@
 #define CPU_OFFLINE	0x0005 /* CPU (unsigned)v offline (still scheduling) */
 #define CPU_DEAD	0x0006 /* CPU (unsigned)v dead */
 
+#define OUT_OF_MEMORY  0x00007 /* Notify of critical memory shortage */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
diff -Nru a/include/linux/oom_notifier.h b/include/linux/oom_notifier.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/oom_notifier.h	Thu Sep 11 18:34:47 2003
@@ -0,0 +1,7 @@
+#ifndef _LINUX_OOM_NOTIFIER_H
+#define _LINUX_OOM_NOTIFIER_H
+
+int register_oom_notifier(struct notifier_block * nb);
+int unregister_oom_notifier(struct notifier_block * nb);
+
+#endif /* _LINUX_OOM_NOTIFIER_H */
diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	Thu Sep 11 18:34:47 2003
+++ b/init/Kconfig	Thu Sep 11 18:34:47 2003
@@ -162,6 +162,21 @@
 	  This option enables access to kernel configuration file and build
 	  information through /proc/config.gz.
 
+config OOM_KILL
+        bool "Kill process on out-of-memory conditions"
+	---help---
+	 This option enables the traditional oom_kill.c mechanism for
+         killing processes in an attempt to recover from an out-of-memory
+         condition.
+
+config OOM_PANIC
+	tristate "Panic on out-of-memory conditions"
+	---help---
+	 This option enables panic() to be called when a system is out of
+         memory.  This feature along with /proc/sys/kernel/panic allows a
+         different behavior on out-of-memory conditions when the standard
+         behavior (killing processes in an attempt to recover) does not 
+         make sense.
 
 menuconfig EMBEDDED
 	bool "Remove kernel features (for embedded systems)"
diff -Nru a/mm/Makefile b/mm/Makefile
--- a/mm/Makefile	Thu Sep 11 18:34:47 2003
+++ b/mm/Makefile	Thu Sep 11 18:34:47 2003
@@ -7,8 +7,11 @@
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
 			   shmem.o vmalloc.o
 
-obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
+obj-y			:= bootmem.o filemap.o mempool.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
-			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
+			   slab.o swap.o truncate.o vmscan.o oom_notifier.o \
+                           $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_OOM_PANIC) += oom_panic.o
+obj-$(CONFIG_OOM_KILL)  += oom_kill.o
diff -Nru a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c	Thu Sep 11 18:34:47 2003
+++ b/mm/oom_kill.c	Thu Sep 11 18:34:47 2003
@@ -20,6 +20,10 @@
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/oom_notifier.h>
 
 /* #define DEBUG */
 
@@ -230,7 +234,7 @@
 /**
  * out_of_memory - is the system out of memory?
  */
-void out_of_memory(void)
+static void out_of_memory_killer(void)
 {
 	/*
 	 * oom_lock protects out_of_memory()'s static variables.
@@ -305,3 +309,20 @@
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
+static int __init init_oom_kill(void)
+{
+	printk("Registering oom_kill handler\n");
+	return register_oom_notifier(&oom_nb);
+}
+module_init(init_oom_kill);
diff -Nru a/mm/oom_notifier.c b/mm/oom_notifier.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/mm/oom_notifier.c	Thu Sep 11 18:34:47 2003
@@ -0,0 +1,38 @@
+/*
+ * linux/mm/oom_notifier.c
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/vermagic.h>
+#include <linux/notifier.h>
+
+static DECLARE_MUTEX(notify_mutex);
+static struct notifier_block * oom_notify_list = 0;
+
+int register_oom_notifier(struct notifier_block * nb)
+{
+	int err;
+	down(&notify_mutex);
+	err = notifier_chain_register(&oom_notify_list, nb);
+	up(&notify_mutex);
+	return err;
+}
+EXPORT_SYMBOL(register_oom_notifier);
+
+int unregister_oom_notifier(struct notifier_block * nb)
+{
+	int err;
+	down(&notify_mutex);
+	err = notifier_chain_unregister(&oom_notify_list, nb);
+	up(&notify_mutex);
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
diff -Nru a/mm/oom_panic.c b/mm/oom_panic.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/mm/oom_panic.c	Thu Sep 11 18:34:47 2003
@@ -0,0 +1,42 @@
+/*
+ * linux/mm/oom_panic.c
+ *
+ * This is a very simple component that will cause the kernel to 
+ * panic on out-of-memory conditions.  The behavior of panic can be
+ * further controlled with /proc/sys/kernel/panic.
+ *       
+ *       --rustyl <rusty@linux.intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/oom_notifier.h>
+
+static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
+{
+	panic("Out-Of-Memory");
+	return 0;
+}
+
+static struct notifier_block oom_nb = {
+	.notifier_call = oom_notify,
+};
+
+static int __init init_oom_panic(void)
+{
+	int err;
+	printk(KERN_INFO "Installing oom_panic handler\n");
+	err = register_oom_notifier(&oom_nb);
+	if (err) printk(KERN_ERR "Error installing oom_panic handler\n");
+	return err;
+}
+
+static void __exit exit_oom_panic(void)
+{
+	unregister_oom_notifier(&oom_nb);
+}
+
+module_init(init_oom_panic);
+module_exit(exit_oom_panic);
+MODULE_LICENSE("GPL");
