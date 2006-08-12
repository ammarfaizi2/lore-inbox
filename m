Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWHLWBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWHLWBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 18:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWHLWAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 18:00:55 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:49973 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932624AbWHLWAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 18:00:47 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc4 07/10] Remove some of the kmemleak false positives
Date: Sat, 12 Aug 2006 23:00:42 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060812220041.17709.72008.stgit@localhost.localdomain>
In-Reply-To: <20060812215857.17709.79502.stgit@localhost.localdomain>
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

There are allocations for which the main pointer cannot be found but they
are not memory leaks. This patch fixes some of them.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 drivers/base/platform.c                |    3 +++
 drivers/hwmon/w83627hf.c               |    4 ++++
 drivers/scsi/hosts.c                   |    3 +++
 fs/ext3/dir.c                          |    3 +++
 ipc/util.c                             |    6 ++++++
 kernel/params.c                        |    8 +++++++-
 mm/slab.c                              |    4 ++++
 net/core/dev.c                         |    6 ++++++
 net/core/skbuff.c                      |    3 +++
 net/ipv4/netfilter/ip_conntrack_core.c |    5 +++++
 net/sched/sch_generic.c                |    6 ++++++
 11 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 2b8755d..1521fe4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -166,6 +166,9 @@ struct platform_device *platform_device_
 	struct platform_object *pa;
 
 	pa = kzalloc(sizeof(struct platform_object) + strlen(name), GFP_KERNEL);
+	/* kmemleak cannot guess the object type because the block
+	 * size is different from the object size */
+	memleak_typeid(pa, struct platform_object);
 	if (pa) {
 		strcpy(pa->name, name);
 		pa->pdev.name = pa->name;
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 79368d5..f952f02 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1065,6 +1065,10 @@ static int w83627hf_detect(struct i2c_ad
 		err = -ENOMEM;
 		goto ERROR1;
 	}
+	/* the pointer to member is stored but the code doesn't use
+	 * container_of for access and the alias need to be
+	 * explicitely declared here */
+	memleak_container(struct w83627hf_data, client);
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index dfcb96f..9516d37 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -297,6 +297,9 @@ struct Scsi_Host *scsi_host_alloc(struct
 	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, gfp_mask);
 	if (!shost)
 		return NULL;
+	/* kmemleak cannot guess the object type because the block
+	 * size is different from the object size */
+	memleak_typeid(shost, struct Scsi_Host);
 
 	spin_lock_init(&shost->default_lock);
 	scsi_assign_lock(shost, &shost->default_lock);
diff --git a/fs/ext3/dir.c b/fs/ext3/dir.c
index fbb0d4e..a34814d 100644
--- a/fs/ext3/dir.c
+++ b/fs/ext3/dir.c
@@ -346,6 +346,9 @@ int ext3_htree_store_dirent(struct file 
 	new_fn = kmalloc(len, GFP_KERNEL);
 	if (!new_fn)
 		return -ENOMEM;
+	/* kmemleak cannot guess the object type because the block
+	 * size is different from the object size */
+	memleak_typeid(new_fn, struct fname);
 	memset(new_fn, 0, len);
 	new_fn->hash = hash;
 	new_fn->minor_hash = minor_hash;
diff --git a/ipc/util.c b/ipc/util.c
index 67b6d17..17cc294 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -388,6 +388,9 @@ void* ipc_rcu_alloc(int size)
 	 */
 	if (rcu_use_vmalloc(size)) {
 		out = vmalloc(HDRLEN_VMALLOC + size);
+		/* the stored pointer is different from the address of
+		 * the allocated block because of padding */
+		memleak_padding(out, HDRLEN_VMALLOC, size);
 		if (out) {
 			out += HDRLEN_VMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 1;
@@ -395,6 +398,9 @@ void* ipc_rcu_alloc(int size)
 		}
 	} else {
 		out = kmalloc(HDRLEN_KMALLOC + size, GFP_KERNEL);
+		/* the stored pointer is different from the address of
+		 * the allocated block because of padding */
+		memleak_padding(out, HDRLEN_KMALLOC, size);
 		if (out) {
 			out += HDRLEN_KMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 0;
diff --git a/kernel/params.c b/kernel/params.c
index 91aea7a..b957b86 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -547,6 +547,7 @@ static void __init kernel_param_sysfs_se
 					    unsigned int name_skip)
 {
 	struct module_kobject *mk;
+	struct module_param_attrs *mp;
 
 	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
 	BUG_ON(!mk);
@@ -556,8 +557,13 @@ static void __init kernel_param_sysfs_se
 	kobject_set_name(&mk->kobj, name);
 	kobject_register(&mk->kobj);
 
+	mp = param_sysfs_setup(mk, kparam, num_params, name_skip);
+	/* this structure is not freed but the pointer is
+	 * lost. However, there are other pointers to its members and
+	 * the object has to be kept */
+	memleak_not_leak(mp);
 	/* no need to keep the kobject if no parameter is exported */
-	if (!param_sysfs_setup(mk, kparam, num_params, name_skip)) {
+	if (!mp) {
 		kobject_unregister(&mk->kobj);
 		kfree(mk);
 	}
diff --git a/mm/slab.c b/mm/slab.c
index 42c90aa..b29662e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3421,6 +3421,10 @@ void *__alloc_percpu(size_t size)
 		memset(pdata->ptrs[i], 0, size);
 	}
 
+	/* the code below changes the value of the returned pointer
+	 * and kmemleak cannot find the original value during
+	 * scanning. It is marked as not being a leak */
+	memleak_not_leak(pdata);
 	/* Catch derefs w/o wrappers */
 	return (void *)(~(unsigned long)pdata);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index d95e262..3c1bcac 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3211,6 +3211,12 @@ struct net_device *alloc_netdev(int size
 	dev = (struct net_device *)
 		(((long)p + NETDEV_ALIGN_CONST) & ~NETDEV_ALIGN_CONST);
 	dev->padded = (char *)dev - (char *)p;
+	/* kmemleak cannot guess the object type because the block
+	 * size is different from the object size. The stored pointer
+	 * is also different from the address of the allocated block
+	 * because of padding */
+	memleak_padding(p, dev->padded, alloc_size - dev->padded);
+	memleak_typeid(p, struct net_device);
 
 	if (sizeof_priv)
 		dev->priv = netdev_priv(dev);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 022d889..7b511e6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -151,6 +151,9 @@ struct sk_buff *__alloc_skb(unsigned int
 
 	/* Get the HEAD */
 	skb = kmem_cache_alloc(cache, gfp_mask & ~__GFP_DMA);
+	/* the skbuff_fclone_cache contains objects larger than
+	 * "struct sk_buff" and kmemleak cannot guess the type */
+	memleak_typeid(skb, struct sk_buff);
 	if (!skb)
 		goto out;
 
diff --git a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
index aa45917..7e64fe0 100644
--- a/net/ipv4/netfilter/ip_conntrack_core.c
+++ b/net/ipv4/netfilter/ip_conntrack_core.c
@@ -654,6 +654,11 @@ struct ip_conntrack *ip_conntrack_alloc(
 	}
 
 	conntrack = kmem_cache_alloc(ip_conntrack_cachep, GFP_ATOMIC);
+	/* tuplehash_to_ctrack doesn't pass a constant argument to
+	 * container_of and therefore the conntrack->tuplehash[].list
+	 * aliases are ignored */
+	memleak_container(struct ip_conntrack, tuplehash[IP_CT_DIR_ORIGINAL]);
+	memleak_container(struct ip_conntrack, tuplehash[IP_CT_DIR_REPLY]);
 	if (!conntrack) {
 		DEBUGP("Can't allocate conntrack.\n");
 		return ERR_PTR(-ENOMEM);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 0834c2e..7fa6aab 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -437,6 +437,12 @@ struct Qdisc *qdisc_alloc(struct net_dev
 		goto errout;
 	sch = (struct Qdisc *) QDISC_ALIGN((unsigned long) p);
 	sch->padded = (char *) sch - (char *) p;
+	/* kmemleak cannot guess the object type because the block
+	 * size is different from the object size. The stored pointer
+	 * is also different from the address of the allocated block
+	 * because of padding */
+	memleak_padding(p, sch->padded, sizeof(struct Qdisc));
+	memleak_typeid(p, struct Qdisc);
 
 	INIT_LIST_HEAD(&sch->list);
 	skb_queue_head_init(&sch->q);
