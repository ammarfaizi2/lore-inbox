Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbUKAIoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUKAIoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 03:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUKAIoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 03:44:25 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:43000 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261736AbUKAIn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 03:43:58 -0500
Date: Mon, 1 Nov 2004 09:43:37 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: [PATCH] [CPU-HOTPLUG] convert cpucontrol to be a rwsem
Message-ID: <20041101084337.GA7824@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
	Zwane Mwaikambo <zwane@linuxpower.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CPU-HOTPLUG] Use a rw-semaphore for serializing and locking

Currently, lock_cpu_hotplug serializes multiple calls to cpufreq->target()
on multiple CPUs even though that's unneccessary. Even further, it
serializes these calls with totally unrelated other parts of the kernel...
some ppc64 event reporting, some cache management, and so on. In my opinion
locking should be done subsystem (and normally data-)specific, and disabling
CPU hotplug should just do that.

This patch converts the semaphore cpucontrol to be a rwsem which allows us 
to use it for _both_ variants: locking (write) and (multiple) other parts 
disabling CPU hotplug (read).

Only problem I see with this approach is that lock_cpu_hotplug_interruptible()
needs to disappear as there is no down_write_interruptible() for rw-semaphores.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>

 include/linux/cpu.h |   19 ++++++++++++++-----
 kernel/cpu.c        |   19 ++++++++-----------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff -ruN linux-original/include/linux/cpu.h linux/include/linux/cpu.h
--- linux-original/include/linux/cpu.h	2004-10-29 17:16:59.000000000 +0200
+++ linux/include/linux/cpu.h	2004-11-01 08:57:07.000000000 +0100
@@ -59,10 +59,18 @@
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* Stop CPUs going up and down. */
-extern struct semaphore cpucontrol;
-#define lock_cpu_hotplug()	down(&cpucontrol)
-#define unlock_cpu_hotplug()	up(&cpucontrol)
-#define lock_cpu_hotplug_interruptible() down_interruptible(&cpucontrol)
+extern struct rw_semaphore cpucontrol;
+/* these just disable CPU hotplug events but don't
+ * serialize following code */
+#define disable_cpu_hotplug()	down_read(&cpucontrol)
+#define enable_cpu_hotplug()	up_read(&cpucontrol)
+
+/* these disable CPU hotplug events _and_ serialize
+ * any following code.
+ */
+#define lock_cpu_hotplug()	down_write(&cpucontrol)
+#define unlock_cpu_hotplug()	up_write(&cpucontrol)
+
 #define hotcpu_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
 		{ .notifier_call = fn, .priority = pri };	\
@@ -71,9 +79,10 @@
 int cpu_down(unsigned int cpu);
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
+#define disable_cpu_hotplug()	do { } while (0)
+#define enable_cpu_hotplug()	do { } while (0)
 #define lock_cpu_hotplug()	do { } while (0)
 #define unlock_cpu_hotplug()	do { } while (0)
-#define lock_cpu_hotplug_interruptible() 0
 #define hotcpu_notifier(fn, pri)
 
 /* CPUs don't go offline once they're online w/o CONFIG_HOTPLUG_CPU */
diff -ruN linux-original/kernel/cpu.c linux/kernel/cpu.c
--- linux-original/kernel/cpu.c	2004-10-29 17:17:11.000000000 +0200
+++ linux/kernel/cpu.c	2004-11-01 09:00:22.000000000 +0100
@@ -17,7 +17,7 @@
 #include <asm/semaphore.h>
 
 /* This protects CPUs going up and down... */
-DECLARE_MUTEX(cpucontrol);
+DECLARE_RWSEM(cpucontrol);
 
 static struct notifier_block *cpu_chain;
 
@@ -26,19 +26,18 @@
 {
 	int ret;
 
-	if ((ret = down_interruptible(&cpucontrol)) != 0)
-		return ret;
+	down_write(&cpucontrol);
 	ret = notifier_chain_register(&cpu_chain, nb);
-	up(&cpucontrol);
+	up_write(&cpucontrol);
 	return ret;
 }
 EXPORT_SYMBOL(register_cpu_notifier);
 
 void unregister_cpu_notifier(struct notifier_block *nb)
 {
-	down(&cpucontrol);
+	down_write(&cpucontrol);
 	notifier_chain_unregister(&cpu_chain, nb);
-	up(&cpucontrol);
+	up_write(&cpucontrol);
 }
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
@@ -81,8 +80,7 @@
 	struct task_struct *p;
 	cpumask_t old_allowed, tmp;
 
-	if ((err = lock_cpu_hotplug_interruptible()) != 0)
-		return err;
+	lock_cpu_hotplug();
 
 	if (num_online_cpus() == 1) {
 		err = -EBUSY;
@@ -156,8 +154,7 @@
 	int ret;
 	void *hcpu = (void *)(long)cpu;
 
-	if ((ret = down_interruptible(&cpucontrol)) != 0)
-		return ret;
+	down_write(&cpucontrol);
 
 	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
@@ -185,6 +182,6 @@
 	if (ret != 0)
 		notifier_call_chain(&cpu_chain, CPU_UP_CANCELED, hcpu);
 out:
-	up(&cpucontrol);
+	up_write(&cpucontrol);
 	return ret;
 }
