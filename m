Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162228AbWLAX2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162228AbWLAX2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162324AbWLAX2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:28:08 -0500
Received: from mail.suse.de ([195.135.220.2]:48269 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162271AbWLAXXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:50 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 28/36] cpu topology: consider sysfs_create_group return value
Date: Fri,  1 Dec 2006 15:21:58 -0800
Message-Id: <11650154181661-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <1165015415131-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com> <11650154032080-git-send-email-greg@kroah.com> <11650154071138-git-send-email-greg@kroah.com> <11650154123942-git-send-email-greg@kroah.com> <1165015415131-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Take return value of sysfs_create_group() into account.  That function got
called in case of CPU_ONLINE notification.  Since callbacks are not allowed
to fail on CPU_ONLINE notification do the sysfs group creation on
CPU_UP_PREPARE notification.

Also remember if creation succeeded in a bitmask.  So it's possible to know
whether it's legal to call sysfs_remove_group or not.

In addition some other minor stuff:

- since CPU_UP_PREPARE might fail add CPU_UP_CANCELED handling as well.
- use hotcpu_notifier instead of register_hotcpu_notifier.
- #ifdef code that isn't needed in the !CONFIG_HOTPLUG_CPU case.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/topology.c |   55 +++++++++++++++++++++++++++-------------------
 1 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 28dccb7..3d12b85 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -94,54 +94,63 @@ static struct attribute_group topology_a
 	.name = "topology"
 };
 
+static cpumask_t topology_dev_map = CPU_MASK_NONE;
+
 /* Add/Remove cpu_topology interface for CPU device */
-static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
+static int __cpuinit topology_add_dev(unsigned int cpu)
 {
-	return sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
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
-- 
1.4.4.1

