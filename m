Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWJPHbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWJPHbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 03:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWJPHbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 03:31:43 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:30179 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030321AbWJPHbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 03:31:42 -0400
Date: Mon, 16 Oct 2006 09:31:26 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Cornelia Huck <cornelia.huck@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [patch] cpu topology: consider sysfs_create_group return value
Message-ID: <20061016073126.GA9409@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[patch] cpu topology: consider sysfs_create_group return value.

Take return value of sysfs_create_group() into account. That function got
called in case of CPU_ONLINE notification. Since callbacks are not allowed
to fail on CPU_ONLINE notification do the sysfs group creation on
CPU_UP_PREPARE notification.
Also remember if creation succeeded in a bitmask. So it's possible to know
wether it's legal to call sysfs_remove_group or not.

In addition some other minor stuff:

- since CPU_UP_PREPARE might fail add CPU_UP_CANCELED handling as well.
- use hotcpu_notifier instead of register_hotcpu_notifier.
- #ifdef code that isn't needed in the !CONFIG_HOTPLUG_CPU case.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/base/topology.c |   56 +++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

Index: linux-2.6/drivers/base/topology.c
===================================================================
--- linux-2.6.orig/drivers/base/topology.c
+++ linux-2.6/drivers/base/topology.c
@@ -94,55 +94,63 @@ static struct attribute_group topology_a
 	.name = "topology"
 };
 
+static cpumask_t topology_dev_map = CPU_MASK_NONE;
+
 /* Add/Remove cpu_topology interface for CPU device */
-static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
+static int __cpuinit topology_add_dev(unsigned int cpu)
 {
-	sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
-	return 0;
+	int rc;
+	struct sys_device *sys_dev = get_cpu_sysdev(cpu);
+
+	rc = sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
+	if (!rc)
+		cpu_set(cpu, topology_dev_map);
+	return rc;
 }
 
-static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
+#ifdef CONFIG_HOTPLUG_CPU
+static void __cpuinit topology_remove_dev(unsigned int cpu)
 {
+	struct sys_device *sys_dev = get_cpu_sysdev(cpu);
+
+	if (!cpu_isset(cpu, topology_dev_map))
+		return;
+	cpu_clear(cpu, topology_dev_map);
 	sysfs_remove_group(&sys_dev->kobj, &topology_attr_group);
-	return 0;
 }
 
 static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
-		unsigned long action, void *hcpu)
+					   unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
-	struct sys_device *sys_dev;
+	int rc = 0;
 
-	sys_dev = get_cpu_sysdev(cpu);
 	switch (action) {
-	case CPU_ONLINE:
-		topology_add_dev(sys_dev);
+	case CPU_UP_PREPARE:
+		rc = topology_add_dev(cpu);
 		break;
+	case CPU_UP_CANCELED:
 	case CPU_DEAD:
-		topology_remove_dev(sys_dev);
+		topology_remove_dev(cpu);
 		break;
 	}
-	return NOTIFY_OK;
+	return rc ? NOTIFY_BAD : NOTIFY_OK;
 }
-
-static struct notifier_block __cpuinitdata topology_cpu_notifier =
-{
-	.notifier_call = topology_cpu_callback,
-};
+#endif
 
 static int __cpuinit topology_sysfs_init(void)
 {
-	int i;
+	int cpu;
+	int rc;
 
-	for_each_online_cpu(i) {
-		topology_cpu_callback(&topology_cpu_notifier, CPU_ONLINE,
-				(void *)(long)i);
+	for_each_online_cpu(cpu) {
+		rc = topology_add_dev(cpu);
+		if (rc)
+			return rc;
 	}
-
-	register_hotcpu_notifier(&topology_cpu_notifier);
+	hotcpu_notifier(topology_cpu_callback, 0);
 
 	return 0;
 }
 
 device_initcall(topology_sysfs_init);
-
