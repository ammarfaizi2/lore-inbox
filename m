Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVASVoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVASVoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVASVmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:42:53 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:27860 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261911AbVASViQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:38:16 -0500
Date: Wed, 19 Jan 2005 22:38:47 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: dhowells@redhat.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
       zwane@linuxpower.ca
Subject: [RFC][PATCH 3/4] use a rwsem for cpucontrol
Message-ID: <20050119213847.GD8471@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	dhowells@redhat.com, linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au, zwane@linuxpower.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, lock_cpu_hotplug serializes multiple calls to cpufreq->target()
on multiple CPUs even though that's unnecessary. Even further, it
serializes these calls with totally unrelated other parts of the kernel...
some ppc64 event reporting, some cache management, and so on. In my opinion
locking should be done subsystem (and normally data-)specific, and disabling
CPU hotplug should just do that.

This patch converts the semaphore cpucontrol to be a rwsem which allows us
to use it for _both_ variants: locking (write) and (multiple) other parts
disabling CPU hotplug (read).

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>

---

 include/linux/cpu.h |   18 ++++++++++++++----
 kernel/cpu.c        |   14 +++++++-------
 2 files changed, 21 insertions(+), 11 deletions(-)

Index: 2.6.11-rc1+/include/linux/cpu.h
===================================================================
--- 2.6.11-rc1+.orig/include/linux/cpu.h	2005-01-16 23:15:30.000000000 +0100
+++ 2.6.11-rc1+/include/linux/cpu.h	2005-01-18 19:36:47.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/node.h>
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
+#include <linux/rwsem.h>
 #include <asm/semaphore.h>
 
 struct cpu {
@@ -59,10 +60,17 @@
 
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
+ * any following code */
+#define lock_cpu_hotplug()	down_write(&cpucontrol)
+#define unlock_cpu_hotplug()	up_write(&cpucontrol)
+#define lock_cpu_hotplug_interruptible() down_write_interruptible(&cpucontrol)
 #define hotcpu_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
 		{ .notifier_call = fn, .priority = pri };	\
@@ -71,6 +79,8 @@
 int cpu_down(unsigned int cpu);
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
+#define disable_cpu_hotplug()	do { } while (0)
+#define enable_cpu_hotplug()	do { } while (0)
 #define lock_cpu_hotplug()	do { } while (0)
 #define unlock_cpu_hotplug()	do { } while (0)
 #define lock_cpu_hotplug_interruptible() 0
Index: 2.6.11-rc1+/kernel/cpu.c
===================================================================
--- 2.6.11-rc1+.orig/kernel/cpu.c	2005-01-16 23:15:30.000000000 +0100
+++ 2.6.11-rc1+/kernel/cpu.c	2005-01-18 19:33:34.000000000 +0100
@@ -16,7 +16,7 @@
 #include <asm/semaphore.h>
 
 /* This protects CPUs going up and down... */
-DECLARE_MUTEX(cpucontrol);
+DECLARE_RWSEM(cpucontrol);
 
 static struct notifier_block *cpu_chain;
 
@@ -25,19 +25,19 @@
 {
 	int ret;
 
-	if ((ret = down_interruptible(&cpucontrol)) != 0)
+	if ((ret = down_write_interruptible(&cpucontrol)) != 0)
 		return ret;
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
 
@@ -159,7 +159,7 @@
 	int ret;
 	void *hcpu = (void *)(long)cpu;
 
-	if ((ret = down_interruptible(&cpucontrol)) != 0)
+	if ((ret = down_write_interruptible(&cpucontrol)) != 0)
 		return ret;
 
 	if (cpu_online(cpu) || !cpu_present(cpu)) {
@@ -188,6 +188,6 @@
 	if (ret != 0)
 		notifier_call_chain(&cpu_chain, CPU_UP_CANCELED, hcpu);
 out:
-	up(&cpucontrol);
+	up_write(&cpucontrol);
 	return ret;
 }
