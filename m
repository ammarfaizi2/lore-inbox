Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbUJXJoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUJXJoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUJXJnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:43:01 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:40849 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261407AbUJXJmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:42:47 -0400
Date: Sun, 24 Oct 2004 05:42:31 -0400
From: Nathan Lynch <nathanl@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, rusty@rustcorp.com.au,
       Nathan Lynch <nathanl@austin.ibm.com>, mochel@digitalimplant.org,
       anton@samba.org
Message-Id: <20041024094613.28808.17748.71291@biclops>
In-Reply-To: <20041024094551.28808.28284.87316@biclops>
References: <20041024094551.28808.28284.87316@biclops>
Subject: [RFC/PATCH 3/4] introduce cpu_add and cpu_remove
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These functions safely update cpu_present_map (i.e. with the
cpucontrol semaphore held) and register or unregister the cpu device
as needed.  These are needed by systems which can add or remove cpus
from the system after boot (e.g. ppc64 and ia64), and are intended to
be called from the platform-specific code such as the ACPI or Open
Firmware layers.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN include/linux/cpu.h~introduce-cpu_add-and-cpu_remove include/linux/cpu.h
--- 2.6.10-rc1/include/linux/cpu.h~introduce-cpu_add-and-cpu_remove	2004-10-24 03:52:59.000000000 -0500
+++ 2.6.10-rc1-nathanl/include/linux/cpu.h	2004-10-24 03:52:59.000000000 -0500
@@ -67,6 +67,8 @@ extern struct semaphore cpucontrol;
 	register_cpu_notifier(&fn##_nb);			\
 }
 int cpu_down(unsigned int cpu);
+unsigned int cpu_add(void);
+void cpu_remove(unsigned int);
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
 #define lock_cpu_hotplug()	do { } while (0)
diff -puN kernel/cpu.c~introduce-cpu_add-and-cpu_remove kernel/cpu.c
--- 2.6.10-rc1/kernel/cpu.c~introduce-cpu_add-and-cpu_remove	2004-10-24 03:52:59.000000000 -0500
+++ 2.6.10-rc1-nathanl/kernel/cpu.c	2004-10-24 03:52:59.000000000 -0500
@@ -180,6 +180,49 @@ out:
 	unlock_cpu_hotplug();
 	return err;
 }
+
+/*
+ * Add a cpu to the system.  Return the number of the cpu added,
+ * or NR_CPUS if no more slots available.
+ */
+unsigned int cpu_add(void)
+{
+	unsigned int cpu = NR_CPUS;
+
+	lock_cpu_hotplug();
+
+	if (num_present_cpus() == num_possible_cpus())
+		goto out;
+
+	for_each_cpu(cpu)
+		if (!cpu_present(cpu))
+			break;
+
+	if (register_cpu(cpu)) {
+		cpu = NR_CPUS;
+		goto out;
+	}
+	cpu_set(cpu, cpu_present_map);
+out:
+	unlock_cpu_hotplug();
+	return cpu;
+}
+
+/*
+ * Remove a cpu from the system.
+ */
+void cpu_remove(unsigned int cpu)
+{
+	lock_cpu_hotplug();
+
+	BUG_ON(cpu_present(cpu));
+
+	unregister_cpu(cpu);
+
+	cpu_clear(cpu, cpu_present_map);
+
+	unlock_cpu_hotplug();
+}
 #else
 static inline int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
 {

_
