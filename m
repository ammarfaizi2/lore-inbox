Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWJIHbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWJIHbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWJIHbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:31:53 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:46032 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932290AbWJIHbw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:31:52 -0400
Date: Mon, 9 Oct 2006 09:30:23 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Greg KH <greg@kroah.com>,
       Ashok Raj <ashok.raj@intel.com>, Nathan Lynch <nathanl@austin.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 2/2] cpu topology: various fixes/cleanups
Message-ID: <20061009073023.GC6936@osiris.boeblingen.de.ibm.com>
References: <20061004130554.GA25974@havoc.gtf.org> <20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com> <20061005081705.GA6920@osiris.boeblingen.de.ibm.com> <4524E983.6010208@garzik.org> <20061005124848.GB6920@osiris.boeblingen.de.ibm.com> <45250161.4060002@garzik.org> <20061005131623.GC6920@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005131623.GC6920@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

- take return valie sysfs_create_group into account.
- don't call code that might fail on CPU_ONLINE notification. Instead call
  it on CPU_UP_PREPARE and check it's return value.
- since CPU_UP_PREPARE might fail add a CPU_UP_CANCELED handling as well.
- use hotcpu_notifier instead of register_hotcpu_notifier
- #ifdef code that isn't needed in the !CONFIG_HOTPLUG_CPU case.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Could be split up into a bunch of several patches if really needed.

 drivers/base/topology.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/base/topology.c
===================================================================
--- linux-2.6.orig/drivers/base/topology.c	2006-10-09 09:15:27.000000000 +0200
+++ linux-2.6/drivers/base/topology.c	2006-10-09 09:25:05.000000000 +0200
@@ -97,10 +97,10 @@
 /* Add/Remove cpu_topology interface for CPU device */
 static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
 {
-	sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
-	return 0;
+	return sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
 {
 	sysfs_remove_group(&sys_dev->kobj, &topology_attr_group);
@@ -112,34 +112,35 @@
 {
 	unsigned int cpu = (unsigned long)hcpu;
 	struct sys_device *sys_dev;
+	int rc = 0;
 
 	sys_dev = get_cpu_sysdev(cpu);
 	switch (action) {
-	case CPU_ONLINE:
-		topology_add_dev(sys_dev);
+	case CPU_UP_PREPARE:
+		rc = topology_add_dev(sys_dev);
 		break;
+	case CPU_UP_CANCELED:
 	case CPU_DEAD:
 		topology_remove_dev(sys_dev);
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
+	struct sys_device *sys_dev;
+	int cpu;
+	int rc;
 
-	for_each_online_cpu(i) {
-		topology_cpu_callback(&topology_cpu_notifier, CPU_ONLINE,
-				(void *)(long)i);
+	for_each_online_cpu(cpu) {
+		sys_dev = get_cpu_sysdev(cpu);
+		rc = topology_add_dev(sys_dev);
+		if (rc)
+			return rc;
 	}
-
-	register_hotcpu_notifier(&topology_cpu_notifier);
+	hotcpu_notifier(topology_cpu_callback, 0);
 
 	return 0;
 }
