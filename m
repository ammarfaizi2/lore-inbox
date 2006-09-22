Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWIVBI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWIVBI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 21:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWIVBI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 21:08:56 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:18878 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932162AbWIVBIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 21:08:55 -0400
Date: Fri, 22 Sep 2006 10:12:18 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [BUGFIX][PATCH] node hotplug : symblic link between node and cpu
 fixup
Message-Id: <20060922101218.d6a22e41.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is tesed in my environment, but I want a review form other people,
who does node-hotplug (maybe x86_64...?).
=
When adding cpu to the NUMA system, node-id for it should be determined.
But at boot time, possible cpu may not belongs to any node if cpu is physically
offlined. (found in ia64)

This patch does:
1. avoid creating symbolic link from a node to the cpu if node_to_cpu_mask is
   not set. (cpu_to_node_map[] is initialized by '0', not useful here)
2. register cpu_hotplug_notifier to bind a cpu to a node.
   Because cpu is up here, cpu-to-node relationship must be fixed before here.
3. at cpu offlining, remove symbolic link to cpu from node.

Tested on ia64/NUMA system, which supports physical node-hot-plug.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


 drivers/base/node.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

Index: linux-2.6.18/drivers/base/node.c
===================================================================
--- linux-2.6.18.orig/drivers/base/node.c	2006-09-22 09:30:25.000000000 +0900
+++ linux-2.6.18/drivers/base/node.c	2006-09-22 09:42:22.000000000 +0900
@@ -169,19 +169,26 @@
 }
 
 struct node node_devices[MAX_NUMNODES];
+cpumask_t registered_cpus;
 
 /*
  * register cpu under node
  */
 int register_cpu_under_node(unsigned int cpu, unsigned int nid)
 {
-	if (node_online(nid)) {
+	int err;
+	if (node_online(nid) &&
+	    cpu_isset(cpu, node_to_cpumask(nid)) &&
+	    !cpu_isset(cpu, registered_cpus)) {
 		struct sys_device *obj = get_cpu_sysdev(cpu);
 		if (!obj)
 			return 0;
-		return sysfs_create_link(&node_devices[nid].sysdev.kobj,
+		err = sysfs_create_link(&node_devices[nid].sysdev.kobj,
 					 &obj->kobj,
 					 kobject_name(&obj->kobj));
+		if (!err)
+			cpu_set(cpu, registered_cpus);
+		return err;
 	 }
 
 	return 0;
@@ -191,9 +198,11 @@
 {
 	if (node_online(nid)) {
 		struct sys_device *obj = get_cpu_sysdev(cpu);
+		WARN_ON(!cpu_isset(cpu, registered_cpus));
 		if (obj)
 			sysfs_remove_link(&node_devices[nid].sysdev.kobj,
 					 kobject_name(&obj->kobj));
+		cpu_clear(cpu, registered_cpus);
 	}
 	return 0;
 }
@@ -223,6 +232,28 @@
 
 }
 
+static int
+cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
+{
+	long cpu = (long)hcpu;
+	int nid = cpu_to_node(cpu);
+
+	switch(action) {
+		case CPU_ONLINE:
+			register_cpu_under_node(cpu, nid);
+			break;
+		case CPU_DEAD:
+			unregister_cpu_under_node(cpu, nid);
+			break;
+		default:
+			break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block node_cpu_notifier = { &cpu_callback, NULL, 0};
+
+
 void unregister_one_node(int nid)
 {
 	unregister_node(&node_devices[nid]);
@@ -230,6 +261,8 @@
 
 static int __init register_node_type(void)
 {
+	register_cpu_notifier(&node_cpu_notifier);
 	return sysdev_class_register(&node_class);
 }
+
 postcore_initcall(register_node_type);

