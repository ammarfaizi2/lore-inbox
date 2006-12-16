Return-Path: <linux-kernel-owner+w=401wt.eu-S1161074AbWLPPrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWLPPrf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWLPPrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:47:35 -0500
Received: from queue02-winn.ispmail.ntl.com ([81.103.221.56]:11466 "EHLO
	queue02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161074AbWLPPrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:47:14 -0500
X-Greylist: delayed 773 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 10:47:09 EST
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.20-rc1 07/10] Remove some of the kmemleak false positives
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2006 15:35:29 +0000
Message-ID: <20061216153528.18200.21155.stgit@localhost.localdomain>
In-Reply-To: <20061216153346.18200.51408.stgit@localhost.localdomain>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are allocations for which the main pointer cannot be found but
they are not memory leaks. This patch fixes some of them. For more
information on false positives, see Documentation/kmemleak.txt.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 arch/i386/kernel/setup.c               |    2 ++
 drivers/base/platform.c                |    3 +++
 drivers/char/vt.c                      |    4 ++++
 drivers/hwmon/w83627hf.c               |    4 ++++
 drivers/scsi/hosts.c                   |    3 +++
 drivers/video/console/fbcon.c          |    3 +++
 fs/ext3/dir.c                          |    3 +++
 include/linux/percpu.h                 |    5 +++++
 ipc/util.c                             |    6 ++++++
 kernel/params.c                        |    8 +++++++-
 net/core/dev.c                         |    6 ++++++
 net/core/skbuff.c                      |    3 +++
 net/ipv4/netfilter/ip_conntrack_core.c |    5 +++++
 net/sched/sch_generic.c                |    5 +++++
 14 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 79df6e6..9f159d9 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -658,6 +658,8 @@ static __init int add_pcspkr(void)
 	int ret;
 
 	pd = platform_device_alloc("pcspkr", -1);
+	/* mark it as not a leak since this device doesn't need to be freed */
+	memleak_not_leak(pd);
 	if (!pd)
 		return -ENOMEM;
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f9c903b..0e03452 100644
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
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 06c32a3..1d74ffe 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2640,6 +2640,10 @@ static int __init con_init(void)
 	 */
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d = vc = alloc_bootmem(sizeof(struct vc_data));
+		/* kmemleak does not track the memory allocated via
+		 * alloc_bootmem() but this block contains pointers to
+		 * other blocks allocated via kmalloc */
+		memleak_alloc(vc, sizeof(struct vc_data), 1);
 		visual_init(vc, currcons, 1);
 		vc->vc_screenbuf = (unsigned short *)alloc_bootmem(vc->vc_screenbuf_size);
 		vc->vc_kmalloced = 0;
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index dfdc29c..6f5c70f 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1097,6 +1097,10 @@ static int w83627hf_detect(struct i2c_ad
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
index 38c3a29..965dd14 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -304,6 +304,9 @@ struct Scsi_Host *scsi_host_alloc(struct
 	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, gfp_mask);
 	if (!shost)
 		return NULL;
+	/* kmemleak cannot guess the object type because the block
+	 * size is different from the object size */
+	memleak_typeid(shost, struct Scsi_Host);
 
 	shost->host_lock = &shost->default_lock;
 	spin_lock_init(shost->host_lock);
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 31f476a..1949f2c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2485,6 +2485,9 @@ static int fbcon_set_font(struct vc_data
 	size = h * pitch * charcount;
 
 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
+	/* the stored pointer is different from the address of the
+	 * allocated block because of padding */
+	memleak_padding(new_data, FONT_EXTRA_WORDS * sizeof(int), size);
 
 	if (!new_data)
 		return -ENOMEM;
diff --git a/fs/ext3/dir.c b/fs/ext3/dir.c
index 665adee..13d2888 100644
--- a/fs/ext3/dir.c
+++ b/fs/ext3/dir.c
@@ -352,6 +352,9 @@ int ext3_htree_store_dirent(struct file
 	new_fn = kzalloc(len, GFP_KERNEL);
 	if (!new_fn)
 		return -ENOMEM;
+	/* kmemleak cannot guess the object type because the block
+	 * size is different from the object size */
+	memleak_typeid(new_fn, struct fname);
 	new_fn->hash = hash;
 	new_fn->minor_hash = minor_hash;
 	new_fn->inode = le32_to_cpu(dirent->inode);
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 600e3d3..899776c 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -30,7 +30,12 @@ struct percpu_data {
 	void *ptrs[NR_CPUS];
 };
 
+/* pointer disguising messes up the kmemleak objects tracking */
+#ifndef CONFIG_DEBUG_MEMLEAK
 #define __percpu_disguise(pdata) (struct percpu_data *)~(unsigned long)(pdata)
+#else
+#define __percpu_disguise(pdata) (struct percpu_data *)(pdata)
+#endif
 /* 
  * Use this to get to a cpu's version of the per-cpu object dynamically
  * allocated. Non-atomic access to the current CPU's version should
diff --git a/ipc/util.c b/ipc/util.c
index a9b7a22..7088618 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -492,6 +492,9 @@ void* ipc_rcu_alloc(int size)
 	 */
 	if (rcu_use_vmalloc(size)) {
 		out = vmalloc(HDRLEN_VMALLOC + size);
+		/* the stored pointer is different from the address of
+		 * the allocated block because of padding */
+		memleak_padding(out, HDRLEN_VMALLOC, size);
 		if (out) {
 			out += HDRLEN_VMALLOC;
 			container_of(out, struct ipc_rcu_hdr, data)->is_vmalloc = 1;
@@ -499,6 +502,9 @@ void* ipc_rcu_alloc(int size)
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
index f406655..1510d89 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -548,6 +548,7 @@ static void __init kernel_param_sysfs_se
 {
 	struct module_kobject *mk;
 	int ret;
+	struct module_param_attrs *mp;
 
 	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
 	BUG_ON(!mk);
@@ -558,8 +559,13 @@ static void __init kernel_param_sysfs_se
 	ret = kobject_register(&mk->kobj);
 	BUG_ON(ret < 0);
 
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
diff --git a/net/core/dev.c b/net/core/dev.c
index e660cb5..96fbe2c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3191,6 +3191,12 @@ struct net_device *alloc_netdev(int size
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
index de7801d..14de9cb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -153,6 +153,9 @@ struct sk_buff *__alloc_skb(unsigned int
 
 	/* Get the HEAD */
 	skb = kmem_cache_alloc_node(cache, gfp_mask & ~__GFP_DMA, node);
+	/* the skbuff_fclone_cache contains objects larger than
+	 * "struct sk_buff" and kmemleak cannot guess the type */
+	memleak_typeid(skb, struct sk_buff);
 	if (!skb)
 		goto out;
 
diff --git a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
index 8556a4f..0bcd3a5 100644
--- a/net/ipv4/netfilter/ip_conntrack_core.c
+++ b/net/ipv4/netfilter/ip_conntrack_core.c
@@ -639,6 +639,11 @@ struct ip_conntrack *ip_conntrack_alloc(
 	}
 
 	conntrack = kmem_cache_alloc(ip_conntrack_cachep, GFP_ATOMIC);
+	/* tuplehash_to_ctrack doesn't pass a constant argument to
+	 * container_of and therefore the conntrack->tuplehash[].list
+	 * aliases are ignored */
+	memleak_container(struct ip_conntrack, tuplehash[IP_CT_DIR_ORIGINAL]);
+	memleak_container(struct ip_conntrack, tuplehash[IP_CT_DIR_REPLY]);
 	if (!conntrack) {
 		DEBUGP("Can't allocate conntrack.\n");
 		atomic_dec(&ip_conntrack_count);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index bc116bd..eef15c4 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -434,6 +434,11 @@ struct Qdisc *qdisc_alloc(struct net_dev
 		goto errout;
 	sch = (struct Qdisc *) QDISC_ALIGN((unsigned long) p);
 	sch->padded = (char *) sch - (char *) p;
+	/* kmemleak cannot guess the object type because the block
+	 * size is different from the object size. The stored pointer
+	 * is also different from the address of the allocated block
+	 * because of padding */
+	memleak_padding(p, sch->padded, sizeof(struct Qdisc));
 
 	INIT_LIST_HEAD(&sch->list);
 	skb_queue_head_init(&sch->q);
