Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWJ0Sre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWJ0Sre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 14:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWJ0Sre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 14:47:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55450 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750768AbWJ0Srd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 14:47:33 -0400
Date: Fri, 27 Oct 2006 11:42:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [patch] drivers: wait for threaded probes between initcall levels
Message-Id: <20061027114237.d577c153.akpm@osdl.org>
In-Reply-To: <20061027114144.f8a5addc.akpm@osdl.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061026224541.GQ27968@stusta.de>
	<20061027010252.GV27968@stusta.de>
	<20061027012058.GH5591@parisc-linux.org>
	<20061026182838.ac2c7e20.akpm@osdl.org>
	<20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027172219.GC30416@elf.ucw.cz>
	<20061027113908.4a82c28a.akpm@osdl.org>
	<20061027114144.f8a5addc.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

The multithreaded-probing code has a problem: after one initcall level (eg,
core_initcall) has been processed, we will then start processing the next
level (postcore_initcall) while the kernel threads which are handling
core_initcall are still executing.  This breaks the guarantees which the
layered initcalls previously gave us.

IOW, we want to be multithreaded _within_ an initcall level, but not between
different levels.

Fix that up by causing the probing code to wait for all outstanding probes at
one level to complete before we start processing the next level.

Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/base/dd.c                 |   30 ++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |    9 +++++++-
 include/linux/init.h              |   28 +++++++++++++++++---------
 3 files changed, 57 insertions(+), 10 deletions(-)

diff -puN drivers/base/dd.c~drivers-wait-for-threaded-probes-between-initcall-levels drivers/base/dd.c
--- a/drivers/base/dd.c~drivers-wait-for-threaded-probes-between-initcall-levels
+++ a/drivers/base/dd.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
+#include <linux/wait.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -70,6 +71,8 @@ struct stupid_thread_structure {
 };
 
 static atomic_t probe_count = ATOMIC_INIT(0);
+static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
+
 static int really_probe(void *void_data)
 {
 	struct stupid_thread_structure *data = void_data;
@@ -121,6 +124,7 @@ probe_failed:
 done:
 	kfree(data);
 	atomic_dec(&probe_count);
+	wake_up(&probe_waitqueue);
 	return ret;
 }
 
@@ -337,6 +341,32 @@ void driver_detach(struct device_driver 
 	}
 }
 
+#ifdef CONFIG_PCI_MULTITHREAD_PROBE
+static int __init wait_for_probes(void)
+{
+	DEFINE_WAIT(wait);
+
+	printk(KERN_INFO "%s: waiting for %d threads\n", __FUNCTION__,
+			atomic_read(&probe_count));
+	if (!atomic_read(&probe_count))
+		return 0;
+	while (atomic_read(&probe_count)) {
+		prepare_to_wait(&probe_waitqueue, &wait, TASK_UNINTERRUPTIBLE);
+		if (atomic_read(&probe_count))
+			schedule();
+	}
+	finish_wait(&probe_waitqueue, &wait);
+	return 0;
+}
+
+core_initcall_sync(wait_for_probes);
+postcore_initcall_sync(wait_for_probes);
+arch_initcall_sync(wait_for_probes);
+subsys_initcall_sync(wait_for_probes);
+fs_initcall_sync(wait_for_probes);
+device_initcall_sync(wait_for_probes);
+late_initcall_sync(wait_for_probes);
+#endif
 
 EXPORT_SYMBOL_GPL(device_bind_driver);
 EXPORT_SYMBOL_GPL(device_release_driver);
diff -puN include/asm-generic/vmlinux.lds.h~drivers-wait-for-threaded-probes-between-initcall-levels include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h~drivers-wait-for-threaded-probes-between-initcall-levels
+++ a/include/asm-generic/vmlinux.lds.h
@@ -216,10 +216,17 @@
 
 #define INITCALLS							\
   	*(.initcall1.init)						\
+  	*(.initcall1s.init)						\
   	*(.initcall2.init)						\
+  	*(.initcall2s.init)						\
   	*(.initcall3.init)						\
+  	*(.initcall3s.init)						\
   	*(.initcall4.init)						\
+  	*(.initcall4s.init)						\
   	*(.initcall5.init)						\
+  	*(.initcall5s.init)						\
   	*(.initcall6.init)						\
-  	*(.initcall7.init)
+  	*(.initcall6s.init)						\
+  	*(.initcall7.init)						\
+  	*(.initcall7s.init)
 
diff -puN include/linux/init.h~drivers-wait-for-threaded-probes-between-initcall-levels include/linux/init.h
--- a/include/linux/init.h~drivers-wait-for-threaded-probes-between-initcall-levels
+++ a/include/linux/init.h
@@ -84,19 +84,29 @@ extern void setup_arch(char **);
  * by link order. 
  * For backwards compatibility, initcall() puts the call in 
  * the device init subsection.
+ *
+ * The `id' arg to __define_initcall() is needed so that multiple initcalls
+ * can point at the same handler without causing duplicate-symbol build errors.
  */
 
-#define __define_initcall(level,fn) \
-	static initcall_t __initcall_##fn __attribute_used__ \
+#define __define_initcall(level,fn,id) \
+	static initcall_t __initcall_##fn##id __attribute_used__ \
 	__attribute__((__section__(".initcall" level ".init"))) = fn
 
-#define core_initcall(fn)		__define_initcall("1",fn)
-#define postcore_initcall(fn)		__define_initcall("2",fn)
-#define arch_initcall(fn)		__define_initcall("3",fn)
-#define subsys_initcall(fn)		__define_initcall("4",fn)
-#define fs_initcall(fn)			__define_initcall("5",fn)
-#define device_initcall(fn)		__define_initcall("6",fn)
-#define late_initcall(fn)		__define_initcall("7",fn)
+#define core_initcall(fn)		__define_initcall("1",fn,1)
+#define core_initcall_sync(fn)		__define_initcall("1s",fn,1s)
+#define postcore_initcall(fn)		__define_initcall("2",fn,2)
+#define postcore_initcall_sync(fn)	__define_initcall("2s",fn,2s)
+#define arch_initcall(fn)		__define_initcall("3",fn,3)
+#define arch_initcall_sync(fn)		__define_initcall("3s",fn,3s)
+#define subsys_initcall(fn)		__define_initcall("4",fn,4)
+#define subsys_initcall_sync(fn)	__define_initcall("4s",fn,4s)
+#define fs_initcall(fn)			__define_initcall("5",fn,5)
+#define fs_initcall_sync(fn)		__define_initcall("5s",fn,5s)
+#define device_initcall(fn)		__define_initcall("6",fn,6)
+#define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
+#define late_initcall(fn)		__define_initcall("7",fn,7)
+#define late_initcall_sync(fn)		__define_initcall("7s",fn,7s)
 
 #define __initcall(fn) device_initcall(fn)
 
_

