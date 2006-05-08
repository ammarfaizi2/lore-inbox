Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWEHFsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWEHFsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWEHFsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:48:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:22651 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932331AbWEHFr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:47:27 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32948579:sNHT772745113"
Subject: [PATCH 10/10] cpu bulk removal interface
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:45:58 +0800
Message-Id: <1147067158.2760.90.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Interface for bulk cpu removal. It's /sys/devices/system/cpu/cpu_bulk_remove

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc3-root/drivers/base/cpu.c  |   47 +++++++++++++++++++++++++++++-
 linux-2.6.17-rc3-root/include/linux/cpu.h |    3 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff -puN drivers/base/cpu.c~bulk_cpu_remove_interface drivers/base/cpu.c
--- linux-2.6.17-rc3/drivers/base/cpu.c~bulk_cpu_remove_interface	2006-05-07 07:47:02.000000000 +0800
+++ linux-2.6.17-rc3-root/drivers/base/cpu.c	2006-05-07 09:29:54.000000000 +0800
@@ -76,6 +76,46 @@ static inline void register_cpu_control(
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_BULK_CPU_REMOVE
+static ssize_t cpu_bulk_remove_show(struct sysdev_class *c, char *buf)
+{
+	int len;
+
+	len = cpulist_scnprintf(buf, PAGE_SIZE-1, cpu_online_map);
+	len += sprintf(buf + len, "\n");
+	return len;
+}
+
+static ssize_t cpu_bulk_remove_store(struct sysdev_class *c,
+	const char *buf, size_t count)
+{
+	int err;
+	cpumask_t removed_cpus;
+
+	if ((err = lock_cpu_hotplug_interruptible() != 0))
+		return err;
+	err = cpulist_parse(buf, removed_cpus);
+	if (err) {
+		unlock_cpu_hotplug();
+		return err;
+	}
+
+	unlock_cpu_hotplug();
+	cpu_down_mask(removed_cpus);
+	return count;
+}
+
+static SYSDEV_CLASS_ATTR(cpu_bulk_remove, 0600, cpu_bulk_remove_show,
+	cpu_bulk_remove_store);
+
+void __init cpu_bulk_remove_sysfs_init(void)
+{
+	sysdev_class_create_file(&cpu_sysdev_class, &attr_cpu_bulk_remove);
+}
+#else
+#define cpu_bulk_remove_sysfs_init()
+#endif
+
 #ifdef CONFIG_KEXEC
 #include <linux/kexec.h>
 
@@ -145,5 +185,10 @@ EXPORT_SYMBOL_GPL(get_cpu_sysdev);
 
 int __init cpu_dev_init(void)
 {
-	return sysdev_class_register(&cpu_sysdev_class);
+	int ret;
+
+	ret = sysdev_class_register(&cpu_sysdev_class);
+	if (!ret)
+		cpu_bulk_remove_sysfs_init();
+	return ret;
 }
diff -puN include/linux/cpu.h~bulk_cpu_remove_interface include/linux/cpu.h
--- linux-2.6.17-rc3/include/linux/cpu.h~bulk_cpu_remove_interface	2006-05-07 07:47:02.000000000 +0800
+++ linux-2.6.17-rc3-root/include/linux/cpu.h	2006-05-07 07:47:02.000000000 +0800
@@ -74,6 +74,9 @@ extern int lock_cpu_hotplug_interruptibl
 	register_cpu_notifier(&fn##_nb);			\
 }
 int cpu_down(unsigned int cpu);
+#ifdef CONFIG_BULK_CPU_REMOVE
+int cpu_down_mask(cpumask_t remove_mask);
+#endif
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
 #define lock_cpu_hotplug()	do { } while (0)
_
