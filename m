Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWFFWZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWFFWZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWFFWZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:25:03 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:13223 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751243AbWFFWZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:25:01 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc6 7/8] Remove some of the kmemleak false positives
Date: Tue, 06 Jun 2006 23:24:17 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060606222416.23913.70577.stgit@localhost.localdomain>
In-Reply-To: <20060606221825.23913.43029.stgit@localhost.localdomain>
References: <20060606221825.23913.43029.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

There are allocations for which the main pointer cannot be found but they
are not memory leaks. This patch fixes some of them.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/i386/kernel/setup.c |    1 +
 drivers/base/platform.c  |    1 +
 ipc/util.c               |    2 ++
 kernel/params.c          |    7 +++++--
 mm/slab.c                |    1 +
 net/core/dev.c           |    1 +
 net/sched/sch_generic.c  |    1 +
 7 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 846e163..7c18c88 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -1323,6 +1323,7 @@ legacy_init_iomem_resources(struct resou
 		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
 			continue;
 		res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
+		memleak_not_leak(res);
 		switch (e820.map[i].type) {
 		case E820_RAM:	res->name = "System RAM"; break;
 		case E820_ACPI:	res->name = "ACPI Tables"; break;
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 83f5c59..f818909 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -166,6 +166,7 @@ struct platform_device *platform_device_
 	struct platform_object *pa;
 
 	pa = kzalloc(sizeof(struct platform_object) + strlen(name), GFP_KERNEL);
+	memleak_padding(pa, 0, sizeof(struct platform_object));
 	if (pa) {
 		strcpy(pa->name, name);
 		pa->pdev.name = pa->name;
diff --git a/ipc/util.c b/ipc/util.c
index 8193299..dcf3e2d 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -389,6 +389,7 @@ void* ipc_rcu_alloc(int size)
 	 */
 	if (rcu_use_vmalloc(size)) {
 		out = vmalloc(HDRLEN_VMALLOC + size);
+		memleak_not_leak(out);
 		if (out) {
 			out += HDRLEN_VMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 1;
@@ -396,6 +397,7 @@ void* ipc_rcu_alloc(int size)
 		}
 	} else {
 		out = kmalloc(HDRLEN_KMALLOC + size, GFP_KERNEL);
+		memleak_not_leak(out);
 		if (out) {
 			out += HDRLEN_KMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 0;
diff --git a/kernel/params.c b/kernel/params.c
index af43ecd..a30beaf 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -548,6 +548,7 @@ static void __init kernel_param_sysfs_se
 					    unsigned int name_skip)
 {
 	struct module_kobject *mk;
+	struct module_param_attrs *mp;
 
 	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
 	BUG_ON(!mk);
@@ -557,11 +558,13 @@ static void __init kernel_param_sysfs_se
 	kobject_set_name(&mk->kobj, name);
 	kobject_register(&mk->kobj);
 
+	mp = param_sysfs_setup(mk, kparam, num_params, name_skip);
 	/* no need to keep the kobject if no parameter is exported */
-	if (!param_sysfs_setup(mk, kparam, num_params, name_skip)) {
+	if (!mp) {
 		kobject_unregister(&mk->kobj);
 		kfree(mk);
-	}
+	} else
+		memleak_not_leak(mp);
 }
 
 /*
diff --git a/mm/slab.c b/mm/slab.c
index 0d38f74..395e7bb 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3357,6 +3357,7 @@ void *__alloc_percpu(size_t size)
 		memset(pdata->ptrs[i], 0, size);
 	}
 
+	memleak_not_leak(pdata);
 	/* Catch derefs w/o wrappers */
 	return (void *)(~(unsigned long)pdata);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 4fba549..2ab745f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3103,6 +3103,7 @@ struct net_device *alloc_netdev(int size
 	dev = (struct net_device *)
 		(((long)p + NETDEV_ALIGN_CONST) & ~NETDEV_ALIGN_CONST);
 	dev->padded = (char *)dev - (char *)p;
+	memleak_padding(p, dev->padded, sizeof(struct net_device));
 
 	if (sizeof_priv)
 		dev->priv = netdev_priv(dev);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 138ea92..5422889 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -427,6 +427,7 @@ struct Qdisc *qdisc_alloc(struct net_dev
 	memset(p, 0, size);
 	sch = (struct Qdisc *) QDISC_ALIGN((unsigned long) p);
 	sch->padded = (char *) sch - (char *) p;
+	memleak_padding(p, sch->padded, sizeof(struct Qdisc));
 
 	INIT_LIST_HEAD(&sch->list);
 	skb_queue_head_init(&sch->q);
