Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933441AbWKNN15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933441AbWKNN15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 08:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933442AbWKNN14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 08:27:56 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:14813 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S933441AbWKNN14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 08:27:56 -0500
Message-ID: <4559CF39.8090908@in.ibm.com>
Date: Tue, 14 Nov 2006 19:44:17 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Srinivasa Ds <srinivasa@in.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, anton@au1.ibm.com,
       paulus@samba.org, linuxppc-dev@ozlabs.org, ego@in.ibm.com,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cpu_hotplug on IBM JS20 system
References: <45586EB5.40409@in.ibm.com> <1163453995.5940.11.camel@localhost.localdomain> <4559C6A9.4070204@in.ibm.com>
In-Reply-To: <4559C6A9.4070204@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050203040909020402000004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050203040909020402000004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Srinivasa Ds wrote:
>
> Since we are not supported by hardware for cpu hotplug. I have 
> developed the patch which will disable cpu hotplug on IBM bladecentre 
> JS20.  Please let me know your comments on this please.
>
  Iam sorry, Just resending the patch after formatting it again.
 
    Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>



--------------050203040909020402000004
Content-Type: text/plain;
 name="cpu_hotplug.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu_hotplug.fix"

 arch/powerpc/kernel/rtas.c |    3 +++
 include/linux/cpu.h        |    4 ++++
 kernel/cpu.c               |   24 ++++++++++++++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc5/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/powerpc/kernel/rtas.c
+++ linux-2.6.19-rc5/arch/powerpc/kernel/rtas.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/capability.h>
 #include <linux/delay.h>
+#include <linux/cpu.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -881,6 +882,8 @@ void __init rtas_initialize(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 	rtas_stop_self_args.token = rtas_token("stop-self");
+	if(rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE)
+		disable_cpu_hotplug_perm();
 #endif /* CONFIG_HOTPLUG_CPU */
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 	rtas_last_error_token = rtas_token("rtas-last-error");
Index: linux-2.6.19-rc5/kernel/cpu.c
===================================================================
--- linux-2.6.19-rc5.orig/kernel/cpu.c
+++ linux-2.6.19-rc5/kernel/cpu.c
@@ -63,8 +63,20 @@ void unlock_cpu_hotplug(void)
 }
 EXPORT_SYMBOL_GPL(unlock_cpu_hotplug);
 
+void disable_cpu_hotplug_perm(void)
+{
+	mutex_lock(&cpu_add_remove_lock);
+	cpu_hotplug_disabled = PERM_DISABLED_CPU_HOTPLUG;
+	mutex_unlock(&cpu_add_remove_lock);
+}
+
 #endif	/* CONFIG_HOTPLUG_CPU */
 
+static int is_cpu_hotplug_perm_disabled()
+{
+	return cpu_hotplug_disabled == PERM_DISABLED_CPU_HOTPLUG;
+}
+
 /* Need to know about CPUs going up/down? */
 int __cpuinit register_cpu_notifier(struct notifier_block *nb)
 {
@@ -193,7 +205,7 @@ int cpu_down(unsigned int cpu)
 	int err = 0;
 
 	mutex_lock(&cpu_add_remove_lock);
-	if (cpu_hotplug_disabled)
+	if (cpu_hotplug_disabled || is_cpu_hotplug_perm_disabled())
 		err = -EBUSY;
 	else
 		err = _cpu_down(cpu);
@@ -244,7 +256,7 @@ int __devinit cpu_up(unsigned int cpu)
 	int err = 0;
 
 	mutex_lock(&cpu_add_remove_lock);
-	if (cpu_hotplug_disabled)
+	if (cpu_hotplug_disabled || is_cpu_hotplug_perm_disabled())
 		err = -EBUSY;
 	else
 		err = _cpu_up(cpu);
@@ -261,6 +273,10 @@ int disable_nonboot_cpus(void)
 	int cpu, first_cpu, error;
 
 	mutex_lock(&cpu_add_remove_lock);
+	if(is_cpu_hotplug_perm_disabled()) {
+		error = -EBUSY;
+		goto out;
+	}
 	first_cpu = first_cpu(cpu_present_map);
 	if (!cpu_online(first_cpu)) {
 		error = _cpu_up(first_cpu);
@@ -311,6 +327,10 @@ void enable_nonboot_cpus(void)
 
 	/* Allow everyone to use the CPU hotplug again */
 	mutex_lock(&cpu_add_remove_lock);
+	if(is_cpu_hotplug_perm_disabled()) {
+		mutex_unlock(&cpu_add_remove_lock);
+		return;
+	}
 	cpu_hotplug_disabled = 0;
 	mutex_unlock(&cpu_add_remove_lock);
 
Index: linux-2.6.19-rc5/include/linux/cpu.h
===================================================================
--- linux-2.6.19-rc5.orig/include/linux/cpu.h
+++ linux-2.6.19-rc5/include/linux/cpu.h
@@ -31,6 +31,8 @@ struct cpu {
 	struct sys_device sysdev;
 };
 
+#define  PERM_DISABLED_CPU_HOTPLUG -1
+
 extern int register_cpu(struct cpu *cpu, int num);
 extern struct sys_device *get_cpu_sysdev(unsigned cpu);
 #ifdef CONFIG_HOTPLUG_CPU
@@ -68,6 +70,7 @@ extern struct sysdev_class cpu_sysdev_cl
 /* Stop CPUs going up and down. */
 extern void lock_cpu_hotplug(void);
 extern void unlock_cpu_hotplug(void);
+extern void disable_cpu_hotplug_perm(void);
 #define hotcpu_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
 		{ .notifier_call = fn, .priority = pri };	\
@@ -80,6 +83,7 @@ int cpu_down(unsigned int cpu);
 #else
 #define lock_cpu_hotplug()	do { } while (0)
 #define unlock_cpu_hotplug()	do { } while (0)
+#define disable_cpu_hotplug_perm()     do { } while (0)
 #define lock_cpu_hotplug_interruptible() 0
 #define hotcpu_notifier(fn, pri)	do { } while (0)
 #define register_hotcpu_notifier(nb)	do { } while (0)

--------------050203040909020402000004--
