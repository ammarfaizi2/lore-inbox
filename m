Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVKQNVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVKQNVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVKQNVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:21:46 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:54955 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750809AbVKQNVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:21:45 -0500
Date: Thu, 17 Nov 2005 18:51:38 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/10] kdump: export per cpu crash notes pointer through sysfs
Message-ID: <20051117132138.GG3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117132004.GF3981@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Kexec on panic functionality allocates memory for saving cpu registers
  in case of system crash event. Address of this allocated memory needs to
  be exported to user space, which is used by kexec-tools.

o Previously, a single /sys/kernel/crash_notes entry was being exported as
  memory allocated was a single continuous array. Now memory allocation being 
  dyanmic and per cpu based, address of per cpu buffer is exported through
  "/sys/devices/system/cpu/cpuX/crash_notes"

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---


diff -puN drivers/base/cpu.c~kdump-export-crash-notes-through-sysfs drivers/base/cpu.c
--- linux-2.6.15-rc1-16M-dynamic/drivers/base/cpu.c~kdump-export-crash-notes-through-sysfs	2005-11-17 08:47:10.000000000 -0800
+++ linux-2.6.15-rc1-16M-dynamic-root/drivers/base/cpu.c	2005-11-17 08:49:33.000000000 -0800
@@ -83,6 +83,33 @@ static inline void register_cpu_control(
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_KEXEC
+#include <linux/kexec.h>
+
+static ssize_t show_crash_notes(struct sys_device *dev, char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
+	ssize_t rc;
+	unsigned long long addr;
+	int cpunum;
+
+	cpunum = cpu->sysdev.id;
+
+	/*
+	 * Might be reading other cpu's data based on which cpu read thread
+	 * has been scheduled. But cpu data (memory) is allocated once during
+	 * boot up and this data does not change there after. Hence this
+	 * operation should be safe. No locking required.
+	 */
+	get_cpu();
+	addr = __pa(per_cpu_ptr(crash_notes, cpunum));
+	rc = sprintf(buf, "%Lx\n", addr);
+	put_cpu();
+	return rc;
+}
+static SYSDEV_ATTR(crash_notes, 0400, show_crash_notes, NULL);
+#endif
+
 /*
  * register_cpu - Setup a driverfs device for a CPU.
  * @cpu - Callers can set the cpu->no_control field to 1, to indicate not to
@@ -108,6 +135,11 @@ int __devinit register_cpu(struct cpu *c
 		register_cpu_control(cpu);
 	if (!error)
 		cpu_sys_devices[num] = &cpu->sysdev;
+
+#ifdef CONFIG_KEXEC
+	if (!error)
+		error = sysdev_create_file(&cpu->sysdev, &attr_crash_notes);
+#endif
 	return error;
 }
 
diff -puN kernel/ksysfs.c~kdump-export-crash-notes-through-sysfs kernel/ksysfs.c
--- linux-2.6.15-rc1-16M-dynamic/kernel/ksysfs.c~kdump-export-crash-notes-through-sysfs	2005-11-17 08:47:10.000000000 -0800
+++ linux-2.6.15-rc1-16M-dynamic-root/kernel/ksysfs.c	2005-11-17 08:47:10.000000000 -0800
@@ -30,16 +30,6 @@ static ssize_t hotplug_seqnum_show(struc
 KERNEL_ATTR_RO(hotplug_seqnum);
 #endif
 
-#ifdef CONFIG_KEXEC
-#include <asm/kexec.h>
-
-static ssize_t crash_notes_show(struct subsystem *subsys, char *page)
-{
-	return sprintf(page, "%p\n", (void *)crash_notes);
-}
-KERNEL_ATTR_RO(crash_notes);
-#endif
-
 decl_subsys(kernel, NULL, NULL);
 EXPORT_SYMBOL_GPL(kernel_subsys);
 
@@ -47,9 +37,6 @@ static struct attribute * kernel_attrs[]
 #ifdef CONFIG_HOTPLUG
 	&hotplug_seqnum_attr.attr,
 #endif
-#ifdef CONFIG_KEXEC
-	&crash_notes_attr.attr,
-#endif
 	NULL
 };
 
_
