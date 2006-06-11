Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWFKLWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWFKLWi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 07:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWFKLWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 07:22:35 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:58479 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751088AbWFKLWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 07:22:00 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Date: Sun, 11 Jun 2006 12:21:56 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060611112156.8641.94787.stgit@localhost.localdomain>
In-Reply-To: <20060611111815.8641.7879.stgit@localhost.localdomain>
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
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
 drivers/hwmon/w83627hf.c |    1 +
 drivers/scsi/hosts.c     |    1 +
 fs/ext3/dir.c            |    1 +
 ipc/util.c               |    2 ++
 kernel/params.c          |    7 +++++--
 mm/slab.c                |    1 +
 net/core/dev.c           |    1 +
 net/sched/sch_generic.c  |    1 +
 10 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index dd6b0e3..0866fcf 100644
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
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 71fb7f1..4208d37 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1065,6 +1065,7 @@ static int w83627hf_detect(struct i2c_ad
 		err = -ENOMEM;
 		goto ERROR1;
 	}
+	memleak_container(struct w83627hf_data, client);
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index dfcb96f..0a05151 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -297,6 +297,7 @@ struct Scsi_Host *scsi_host_alloc(struct
 	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, gfp_mask);
 	if (!shost)
 		return NULL;
+	memleak_padding(shost, 0, sizeof(struct Scsi_Host));
 
 	spin_lock_init(&shost->default_lock);
 	scsi_assign_lock(shost, &shost->default_lock);
diff --git a/fs/ext3/dir.c b/fs/ext3/dir.c
index f37528e..f66fbed 100644
--- a/fs/ext3/dir.c
+++ b/fs/ext3/dir.c
@@ -346,6 +346,7 @@ int ext3_htree_store_dirent(struct file 
 	new_fn = kmalloc(len, GFP_KERNEL);
 	if (!new_fn)
 		return -ENOMEM;
+	memleak_padding(new_fn, 0, sizeof(struct fname));
 	memset(new_fn, 0, len);
 	new_fn->hash = hash;
 	new_fn->minor_hash = minor_hash;
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
