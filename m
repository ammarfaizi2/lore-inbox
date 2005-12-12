Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVLLXuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVLLXuE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVLLXqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:46:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932252AbVLLXqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:31 -0500
Date: Mon, 12 Dec 2005 23:45:47 GMT
Message-Id: <200512122345.jBCNjlpg009035@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 5/19] MUTEX: Core kernel changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the core files of the kernel to use the new mutex
functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-core-2615rc5.diff
 kernel/cpu.c                    |    2 +-
 kernel/cpuset.c                 |    2 +-
 kernel/kexec.c                  |    2 +-
 kernel/kthread.c                |    4 ++--
 kernel/module.c                 |    2 +-
 kernel/posix-timers.c           |    2 +-
 kernel/power/power.h            |    3 ++-
 kernel/printk.c                 |   32 ++++++++++++++++----------------
 kernel/profile.c                |    2 +-
 kernel/stop_machine.c           |    2 +-
 lib/reed_solomon/reed_solomon.c |    2 +-
 mm/slab.c                       |    2 +-
 12 files changed, 29 insertions(+), 28 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/kernel/cpu.c linux-2.6.15-rc5-mutex/kernel/cpu.c
--- /warthog/kernels/linux-2.6.15-rc5/kernel/cpu.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/cpu.c	2005-12-12 22:12:50.000000000 +0000
@@ -13,7 +13,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/stop_machine.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /* This protects CPUs going up and down... */
 static DECLARE_MUTEX(cpucontrol);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/kernel/cpuset.c linux-2.6.15-rc5-mutex/kernel/cpuset.c
--- /warthog/kernels/linux-2.6.15-rc5/kernel/cpuset.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/cpuset.c	2005-12-12 22:12:50.000000000 +0000
@@ -52,7 +52,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #define CPUSET_SUPER_MAGIC 		0x27e0eb
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/kernel/kexec.c linux-2.6.15-rc5-mutex/kernel/kexec.c
--- /warthog/kernels/linux-2.6.15-rc5/kernel/kexec.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/kexec.c	2005-12-12 22:12:50.000000000 +0000
@@ -19,12 +19,12 @@
 #include <linux/syscalls.h>
 #include <linux/ioport.h>
 #include <linux/hardirq.h>
+#include <linux/semaphore.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/semaphore.h>
 
 /* Location of the reserved area for the crash kernel */
 struct resource crashk_res = {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/kernel/kthread.c linux-2.6.15-rc5-mutex/kernel/kthread.c
--- /warthog/kernels/linux-2.6.15-rc5/kernel/kthread.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/kthread.c	2005-12-12 22:12:50.000000000 +0000
@@ -12,7 +12,7 @@
 #include <linux/unistd.h>
 #include <linux/file.h>
 #include <linux/module.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /*
  * We dont want to execute off keventd since it might
@@ -169,7 +169,7 @@ int kthread_stop(struct task_struct *k)
 }
 EXPORT_SYMBOL(kthread_stop);
 
-int kthread_stop_sem(struct task_struct *k, struct semaphore *s)
+int kthread_stop_sem(struct task_struct *k, struct mutex *s)
 {
 	int ret;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/kernel/module.c linux-2.6.15-rc5-mutex/kernel/module.c
--- /warthog/kernels/linux-2.6.15-rc5/kernel/module.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/module.c	2005-12-12 22:12:50.000000000 +0000
@@ -38,8 +38,8 @@
 #include <linux/device.h>
 #include <linux/string.h>
 #include <linux/sched.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 #include <asm/cacheflush.h>
 
 #if 0
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/kernel/posix-timers.c linux-2.6.15-rc5-mutex/kernel/posix-timers.c
--- /warthog/kernels/linux-2.6.15-rc5/kernel/posix-timers.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/posix-timers.c	2005-12-12 22:12:50.000000000 +0000
@@ -37,7 +37,7 @@
 #include <linux/time.h>
 
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/compiler.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/kernel/power/power.h linux-2.6.15-rc5-mutex/kernel/power/power.h
--- /warthog/kernels/linux-2.6.15-rc5/kernel/power/power.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/power/power.h	2005-12-12 22:12:50.000000000 +0000
@@ -1,5 +1,6 @@
 #include <linux/suspend.h>
 #include <linux/utsname.h>
+#include <linux/semaphore.h>
 
 /* With SUSPEND_CONSOLE defined suspend looks *really* cool, but
    we probably do not take enough locks for switching consoles, etc,
@@ -35,7 +36,7 @@ static inline int pm_suspend_disk(void)
 	return -EPERM;
 }
 #endif
-extern struct semaphore pm_sem;
+extern struct mutex pm_sem;
 #define power_attr(_name) \
 static struct subsys_attribute _name##_attr = {	\
 	.attr	= {				\
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/kernel/printk.c linux-2.6.15-rc5-mutex/kernel/printk.c
--- /warthog/kernels/linux-2.6.15-rc5/kernel/printk.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/printk.c	2005-12-12 18:29:14.000000000 +0000
@@ -62,11 +62,11 @@ int oops_in_progress;
 EXPORT_SYMBOL(oops_in_progress);
 
 /*
- * console_sem protects the console_drivers list, and also
+ * console_mutex protects the console_drivers list, and also
  * provides serialisation for access to the entire console
  * driver system.
  */
-static DECLARE_MUTEX(console_sem);
+static DECLARE_MUTEX(console_mutex);
 struct console *console_drivers;
 /*
  * This is used for debugging the mess that is the VT code by
@@ -81,7 +81,7 @@ static int console_locked;
 /*
  * logbuf_lock protects log_buf, log_start, log_end, con_start and logged_chars
  * It is also used in interesting ways to provide interlocking in
- * release_console_sem().
+ * release_console_mutex().
  */
 static DEFINE_SPINLOCK(logbuf_lock);
 
@@ -391,7 +391,7 @@ static void _call_console_drivers(unsign
 /*
  * Call the console drivers, asking them to write out
  * log_buf[start] to log_buf[end - 1].
- * The console_sem must be held.
+ * The console_mutex must be held.
  */
 static void call_console_drivers(unsigned long start, unsigned long end)
 {
@@ -467,7 +467,7 @@ static void zap_locks(void)
 	/* If a crash is occurring, make sure we can't deadlock */
 	spin_lock_init(&logbuf_lock);
 	/* And make sure that we print immediately */
-	init_MUTEX(&console_sem);
+	init_MUTEX(&console_mutex);
 }
 
 #if defined(CONFIG_PRINTK_TIME)
@@ -497,10 +497,10 @@ __attribute__((weak)) unsigned long long
  *
  * This is printk.  It can be called from any context.  We want it to work.
  *
- * We try to grab the console_sem.  If we succeed, it's easy - we log the output and
+ * We try to grab the console_mutex.  If we succeed, it's easy - we log the output and
  * call the console drivers.  If we fail to get the semaphore we place the output
- * into the log buffer and return.  The current holder of the console_sem will
- * notice the new output in release_console_sem() and will send it to the
+ * into the log buffer and return.  The current holder of the console_mutex will
+ * notice the new output in release_console_mutex() and will send it to the
  * consoles before releasing the semaphore.
  *
  * One effect of this deferred printing is that code which calls printk() and
@@ -540,7 +540,7 @@ asmlinkage int vprintk(const char *fmt, 
 		 * make sure we can't deadlock */
 		zap_locks();
 
-	/* This stops the holder of console_sem just where we want him */
+	/* This stops the holder of console_mutex just where we want him */
 	spin_lock_irqsave(&logbuf_lock, flags);
 	printk_cpu = smp_processor_id();
 
@@ -615,11 +615,11 @@ asmlinkage int vprintk(const char *fmt, 
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 		goto out;
 	}
-	if (!down_trylock(&console_sem)) {
+	if (!down_trylock(&console_mutex)) {
 		console_locked = 1;
 		/*
 		 * We own the drivers.  We can drop the spinlock and let
-		 * release_console_sem() print the text
+		 * release_console_mutex() print the text
 		 */
 		printk_cpu = UINT_MAX;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
@@ -710,7 +710,7 @@ void acquire_console_sem(void)
 {
 	if (in_interrupt())
 		BUG();
-	down(&console_sem);
+	down(&console_mutex);
 	console_locked = 1;
 	console_may_schedule = 1;
 }
@@ -718,7 +718,7 @@ EXPORT_SYMBOL(acquire_console_sem);
 
 int try_acquire_console_sem(void)
 {
-	if (down_trylock(&console_sem))
+	if (down_trylock(&console_mutex))
 		return -1;
 	console_locked = 1;
 	console_may_schedule = 0;
@@ -739,7 +739,7 @@ EXPORT_SYMBOL(is_console_locked);
  * and the console driver list.
  *
  * While the semaphore was held, console output may have been buffered
- * by printk().  If this is the case, release_console_sem() emits
+ * by printk().  If this is the case, release_console_mutex() emits
  * the output prior to releasing the semaphore.
  *
  * If there is output waiting for klogd, we wake it up.
@@ -766,7 +766,7 @@ void release_console_sem(void)
 	}
 	console_locked = 0;
 	console_may_schedule = 0;
-	up(&console_sem);
+	up(&console_mutex);
 	spin_unlock_irqrestore(&logbuf_lock, flags);
 	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
 		wake_up_interruptible(&log_wait);
@@ -804,7 +804,7 @@ void console_unblank(void)
 	 * oops_in_progress is set to 1..
 	 */
 	if (oops_in_progress) {
-		if (down_trylock(&console_sem) != 0)
+		if (down_trylock(&console_mutex) != 0)
 			return;
 	} else
 		acquire_console_sem();
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/kernel/profile.c linux-2.6.15-rc5-mutex/kernel/profile.c
--- /warthog/kernels/linux-2.6.15-rc5/kernel/profile.c	2005-08-30 13:56:40.000000000 +0100
+++ linux-2.6.15-rc5-mutex/kernel/profile.c	2005-12-12 22:12:50.000000000 +0000
@@ -24,7 +24,7 @@
 #include <linux/profile.h>
 #include <linux/highmem.h>
 #include <asm/sections.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 struct profile_hit {
 	u32 pc, hits;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/kernel/stop_machine.c linux-2.6.15-rc5-mutex/kernel/stop_machine.c
--- /warthog/kernels/linux-2.6.15-rc5/kernel/stop_machine.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/stop_machine.c	2005-12-12 22:12:50.000000000 +0000
@@ -5,7 +5,7 @@
 #include <linux/err.h>
 #include <linux/syscalls.h>
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 /* Since we effect priority and affinity (both of which are visible
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/lib/reed_solomon/reed_solomon.c linux-2.6.15-rc5-mutex/lib/reed_solomon/reed_solomon.c
--- /warthog/kernels/linux-2.6.15-rc5/lib/reed_solomon/reed_solomon.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/lib/reed_solomon/reed_solomon.c	2005-12-12 22:12:50.000000000 +0000
@@ -44,7 +44,7 @@
 #include <linux/module.h>
 #include <linux/rslib.h>
 #include <linux/slab.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /* This list holds all currently allocated rs control structures */
 static LIST_HEAD (rslist);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/mm/slab.c linux-2.6.15-rc5-mutex/mm/slab.c
--- /warthog/kernels/linux-2.6.15-rc5/mm/slab.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/mm/slab.c	2005-12-12 17:25:08.000000000 +0000
@@ -631,7 +631,7 @@ static kmem_cache_t cache_cache = {
 };
 
 /* Guard access to the cache-chain. */
-static struct semaphore	cache_chain_sem;
+static struct mutex	cache_chain_sem;
 static struct list_head cache_chain;
 
 /*
