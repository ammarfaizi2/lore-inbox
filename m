Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbUKOT4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUKOT4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 14:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUKOT4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 14:56:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61593 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261670AbUKOTxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:53:07 -0500
Date: Mon, 15 Nov 2004 14:51:51 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] SELinux scalability - AVC statistics and tuning
In-Reply-To: <Xine.LNX.4.44.0411151448580.21180@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0411151450070.21180-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an selinuxfs based API to the AVC, to allow monitoring of the
cache, and tuning of the cache size.  The latter is mediated via the new
setsecparam permission.

AVC statistics may be monitored via the avcstat utility:
http://people.redhat.com/jmorris/selinux/perf/avcstat.c

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>

---
 security/selinux/Kconfig                     |    9 +
 security/selinux/avc.c                       |   90 ++++------
 security/selinux/include/av_perm_to_string.h |    1 
 security/selinux/include/av_permissions.h    |    1 
 security/selinux/include/avc.h               |   26 ++-
 security/selinux/selinuxfs.c                 |  227 ++++++++++++++++++++++++++-
 6 files changed, 290 insertions(+), 64 deletions(-)

diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/avc.c linux-2.6.10-rc1-mm1.w/security/selinux/avc.c
--- linux-2.6.10-rc1-mm1.p/security/selinux/avc.c	2004-11-05 19:46:02.086952656 -0500
+++ linux-2.6.10-rc1-mm1.w/security/selinux/avc.c	2004-11-05 19:45:44.135681664 -0500
@@ -21,6 +21,7 @@
 #include <linux/dcache.h>
 #include <linux/init.h>
 #include <linux/skbuff.h>
+#include <linux/percpu.h>
 #include <net/sock.h>
 #include <linux/un.h>
 #include <net/af_unix.h>
@@ -38,9 +39,19 @@
 #include "av_perm_to_string.h"
 #include "objsec.h"
 
-#define AVC_CACHE_SLOTS		512
-#define AVC_CACHE_THRESHOLD	512
-#define AVC_CACHE_RECLAIM	16
+#define AVC_CACHE_SLOTS			512
+#define AVC_DEF_CACHE_THRESHOLD		512
+#define AVC_CACHE_RECLAIM		16
+
+#ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
+#define avc_cache_stats_incr(field) 				\
+do {								\
+	per_cpu(avc_cache_stats, get_cpu()).field++;		\
+	put_cpu();						\
+} while (0)
+#else
+#define avc_cache_stats_incr(field)	do {} while (0)
+#endif
 
 struct avc_entry {
 	u32			ssid;
@@ -76,8 +87,14 @@ struct avc_callback_node {
 	struct avc_callback_node *next;
 };
 
+/* Exported via selinufs */
+unsigned int avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
+
+#ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
+DEFINE_PER_CPU(struct avc_cache_stats, avc_cache_stats) = { 0 };
+#endif
+
 static struct avc_cache avc_cache;
-static unsigned avc_cache_stats[AVC_NSTATS];
 static struct avc_callback_node *avc_callbacks;
 static kmem_cache_t *avc_node_cachep;
 
@@ -86,24 +103,6 @@ static inline int avc_hash(u32 ssid, u32
 	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
 }
 
-#ifdef AVC_CACHE_STATS
-static inline void avc_cache_stats_incr(int type)
-{
-	avc_cache_stats[type]++;
-}
-
-static inline void avc_cache_stats_add(int type, unsigned val)
-{
-	avc_cache_stats[type] += val;
-}
-#else
-static inline void avc_cache_stats_incr(int type)
-{ }
-
-static inline void avc_cache_stats_add(int type, unsigned val)
-{ }
-#endif
-
 /**
  * avc_dump_av - Display an access vector in human-readable form.
  * @tclass: target security class
@@ -208,8 +207,7 @@ void __init avc_init(void)
 	audit_log(current->audit_context, "AVC INITIALIZED\n");
 }
 
-#if 0
-static void avc_hash_eval(char *tag)
+int avc_get_hash_stats(char *page)
 {
 	int i, chain_len, max_chain_len, slots_used;
 	struct avc_node *node;
@@ -231,20 +229,17 @@ static void avc_hash_eval(char *tag)
 
 	rcu_read_unlock();
 
-	printk(KERN_INFO "\n");
-	printk(KERN_INFO "%s avc:  %d entries and %d/%d buckets used, longest "
-	       "chain length %d\n", tag, atomic_read(&avc_cache.active_nodes),
-		slots_used, AVC_CACHE_SLOTS, max_chain_len);
+	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
+			 "longest chain: %d\n",
+			 atomic_read(&avc_cache.active_nodes),
+			 slots_used, AVC_CACHE_SLOTS, max_chain_len);
 }
-#else
-static inline void avc_hash_eval(char *tag)
-{ }
-#endif
 
 static void avc_node_free(struct rcu_head *rhead)
 {
 	struct avc_node *node = container_of(rhead, struct avc_node, rhead);
 	kmem_cache_free(avc_node_cachep, node);
+	avc_cache_stats_incr(frees);
 }
 
 static void avc_node_delete(struct avc_node *node)
@@ -277,6 +272,7 @@ static inline int avc_reclaim_node(void)
 			if (!atomic_dec_and_test(&node->ae.used)) {
 				/* Recently Unused */
 				avc_node_delete(node);
+				avc_cache_stats_incr(reclaims);
 				ecx++;
 				if (ecx >= AVC_CACHE_RECLAIM) {
 					spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flags);
@@ -301,9 +297,10 @@ static struct avc_node *avc_alloc_node(v
 	memset(node, 0, sizeof(*node));
 	INIT_RCU_HEAD(&node->rhead);
 	INIT_LIST_HEAD(&node->list);
-	atomic_set(&node->ae.used, 1);	
-
-	if (atomic_inc_return(&avc_cache.active_nodes) > AVC_CACHE_THRESHOLD)
+	atomic_set(&node->ae.used, 1);
+	avc_cache_stats_incr(allocations);
+	
+	if (atomic_inc_return(&avc_cache.active_nodes) > avc_cache_threshold)
 		avc_reclaim_node();
 
 out:
@@ -318,12 +315,10 @@ static void avc_node_populate(struct avc
 	memcpy(&node->ae.avd, &ae->avd, sizeof(node->ae.avd));
 }
 
-static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid,
-                                               u16 tclass, int *probes)
+static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
 {
 	struct avc_node *node, *ret = NULL;
 	int hvalue;
-	int tprobes = 1;
 
 	hvalue = avc_hash(ssid, tsid, tclass);
 	list_for_each_entry_rcu(node, &avc_cache.slots[hvalue], list) {
@@ -333,7 +328,6 @@ static inline struct avc_node *avc_searc
 			ret = node;
 			break;
 		}
-		tprobes++;
 	}
 
 	if (ret == NULL) {
@@ -342,8 +336,6 @@ static inline struct avc_node *avc_searc
 	}
 
 	/* cache hit */
-	if (probes)
-		*probes = tprobes;
 	if (atomic_read(&ret->ae.used) != 1)
 		atomic_set(&ret->ae.used, 1);
 out:
@@ -367,19 +359,17 @@ out:
 static struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass, u32 requested)
 {
 	struct avc_node *node;
-	int probes;
 
-	avc_cache_stats_incr(AVC_CAV_LOOKUPS);
-	node = avc_search_node(ssid, tsid, tclass,&probes);
+	avc_cache_stats_incr(lookups);
+	node = avc_search_node(ssid, tsid, tclass);
 
 	if (node && ((node->ae.avd.decided & requested) == requested)) {
-		avc_cache_stats_incr(AVC_CAV_HITS);
-		avc_cache_stats_add(AVC_CAV_PROBES,probes);
+		avc_cache_stats_incr(hits);
 		goto out;
 	}
 
 	node = NULL;
-	avc_cache_stats_incr(AVC_CAV_MISSES);
+	avc_cache_stats_incr(misses);
 out:
 	return node;
 }
@@ -930,8 +920,6 @@ int avc_ss_reset(u32 seqno)
 	unsigned long flag;
 	struct avc_node *node;
 
-	avc_hash_eval("reset");
-
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
 		spin_lock_irqsave(&avc_cache.slots_lock[i], flag);
 		list_for_each_entry(node, &avc_cache.slots[i], list)
@@ -939,9 +927,6 @@ int avc_ss_reset(u32 seqno)
 		spin_unlock_irqrestore(&avc_cache.slots_lock[i], flag);
 	}
 
-	for (i = 0; i < AVC_NSTATS; i++)
-		avc_cache_stats[i] = 0;
-
 	for (c = avc_callbacks; c; c = c->next) {
 		if (c->events & AVC_CALLBACK_RESET) {
 			rc = c->callback(AVC_CALLBACK_RESET,
@@ -1025,7 +1010,6 @@ int avc_has_perm_noaudit(u32 ssid, u32 t
 	u32 denied;
 
 	rcu_read_lock();
-	avc_cache_stats_incr(AVC_ENTRY_LOOKUPS);
 
 	node = avc_lookup(ssid, tsid, tclass, requested);
 	if (!node) {
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/include/avc.h linux-2.6.10-rc1-mm1.w/security/selinux/include/avc.h
--- linux-2.6.10-rc1-mm1.p/security/selinux/include/avc.h	2004-11-05 19:46:02.087952504 -0500
+++ linux-2.6.10-rc1-mm1.w/security/selinux/include/avc.h	2004-11-03 23:21:55.000000000 -0500
@@ -82,15 +82,15 @@ struct avc_audit_data {
 /*
  * AVC statistics
  */
-#define AVC_ENTRY_LOOKUPS        0
-#define AVC_ENTRY_HITS	         1
-#define AVC_ENTRY_MISSES         2
-#define AVC_ENTRY_DISCARDS       3
-#define AVC_CAV_LOOKUPS          4
-#define AVC_CAV_HITS             5
-#define AVC_CAV_PROBES           6
-#define AVC_CAV_MISSES           7
-#define AVC_NSTATS               8
+struct avc_cache_stats
+{
+	unsigned int lookups;
+	unsigned int hits;
+	unsigned int misses;
+	unsigned int allocations;
+	unsigned int reclaims;
+	unsigned int frees;
+};
 
 /*
  * AVC display support
@@ -132,5 +132,13 @@ int avc_add_callback(int (*callback)(u32
 		     u32 events, u32 ssid, u32 tsid,
 		     u16 tclass, u32 perms);
 
+/* Exported to selinuxfs */
+int avc_get_hash_stats(char *page);
+extern unsigned int avc_cache_threshold;
+
+#ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
+DECLARE_PER_CPU(struct avc_cache_stats, avc_cache_stats);
+#endif
+
 #endif /* _SELINUX_AVC_H_ */
 
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/include/av_permissions.h linux-2.6.10-rc1-mm1.w/security/selinux/include/av_permissions.h
--- linux-2.6.10-rc1-mm1.p/security/selinux/include/av_permissions.h	2004-11-05 19:46:02.088952352 -0500
+++ linux-2.6.10-rc1-mm1.w/security/selinux/include/av_permissions.h	2004-11-05 19:23:06.000000000 -0500
@@ -515,6 +515,7 @@
 #define SECURITY__COMPUTE_USER                    0x00000040UL
 #define SECURITY__SETENFORCE                      0x00000080UL
 #define SECURITY__SETBOOL                         0x00000100UL
+#define SECURITY__SETSECPARAM                     0x00000200UL
 
 #define SYSTEM__IPC_INFO                          0x00000001UL
 #define SYSTEM__SYSLOG_READ                       0x00000002UL
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/include/av_perm_to_string.h linux-2.6.10-rc1-mm1.w/security/selinux/include/av_perm_to_string.h
--- linux-2.6.10-rc1-mm1.p/security/selinux/include/av_perm_to_string.h	2004-11-05 19:46:02.089952200 -0500
+++ linux-2.6.10-rc1-mm1.w/security/selinux/include/av_perm_to_string.h	2004-11-05 19:05:33.000000000 -0500
@@ -85,6 +85,7 @@ static struct av_perm_to_string av_perm_
    { SECCLASS_SECURITY, SECURITY__COMPUTE_USER, "compute_user" },
    { SECCLASS_SECURITY, SECURITY__SETENFORCE, "setenforce" },
    { SECCLASS_SECURITY, SECURITY__SETBOOL, "setbool" },
+   { SECCLASS_SECURITY, SECURITY__SETSECPARAM, "setsecparam" },
    { SECCLASS_SYSTEM, SYSTEM__IPC_INFO, "ipc_info" },
    { SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, "syslog_read" },
    { SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, "syslog_mod" },
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/Kconfig linux-2.6.10-rc1-mm1.w/security/selinux/Kconfig
--- linux-2.6.10-rc1-mm1.p/security/selinux/Kconfig	2004-11-05 19:46:02.089952200 -0500
+++ linux-2.6.10-rc1-mm1.w/security/selinux/Kconfig	2004-11-05 01:41:08.000000000 -0500
@@ -67,6 +67,15 @@ config SECURITY_SELINUX_DEVELOP
 	  can interactively toggle the kernel between enforcing mode and
 	  permissive mode (if permitted by the policy) via /selinux/enforce.
 
+config SECURITY_SELINUX_AVC_STATS
+	bool "NSA SELinux AVC Statistics"
+	depends on SECURITY_SELINUX
+	default y
+	help
+	  This option collects access vector cache statistics to
+	  /selinux/avc/cache_stats, which may be monitored via
+	  tools such as avcstat.
+	
 config SECURITY_SELINUX_MLS
 	bool "NSA SELinux MLS policy (EXPERIMENTAL)"
 	depends on SECURITY_SELINUX && EXPERIMENTAL
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/selinuxfs.c linux-2.6.10-rc1-mm1.w/security/selinux/selinuxfs.c
--- linux-2.6.10-rc1-mm1.p/security/selinux/selinuxfs.c	2004-11-05 19:46:02.091951896 -0500
+++ linux-2.6.10-rc1-mm1.w/security/selinux/selinuxfs.c	2004-11-05 19:09:18.000000000 -0500
@@ -3,6 +3,7 @@
  * 	Added conditional policy language extensions
  *
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
@@ -18,6 +19,8 @@
 #include <linux/string.h>
 #include <linux/security.h>
 #include <linux/major.h>
+#include <linux/seq_file.h>
+#include <linux/percpu.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -66,7 +69,8 @@ enum sel_inos {
 	SEL_POLICYVERS,	/* return policy version for this kernel */
 	SEL_COMMIT_BOOLS, /* commit new boolean values */
 	SEL_MLS,	/* return if MLS policy is enabled */
-	SEL_DISABLE	/* disable SELinux until next reboot */
+	SEL_DISABLE,	/* disable SELinux until next reboot */
+	SEL_AVC,	/* AVC management directory */
 };
 
 #define TMPBUFLEN	12
@@ -887,6 +891,213 @@ err:
 
 struct dentry *selinux_null = NULL;
 
+static ssize_t sel_read_avc_cache_threshold(struct file *filp, char __user *buf,
+					    size_t count, loff_t *ppos)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", avc_cache_threshold);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static ssize_t sel_write_avc_cache_threshold(struct file * file,
+					     const char __user * buf,
+					     size_t count, loff_t *ppos)
+
+{
+	char *page;
+	ssize_t ret;
+	int new_value;
+
+	if (count < 0 || count >= PAGE_SIZE) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (*ppos != 0) {
+		/* No partial writes. */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	page = (char*)get_zeroed_page(GFP_KERNEL);
+	if (!page) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (copy_from_user(page, buf, count)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	if (sscanf(page, "%u", &new_value) != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (new_value != avc_cache_threshold) {
+		ret = task_has_security(current, SECURITY__SETSECPARAM);
+		if (ret)
+			goto out_free;
+		avc_cache_threshold = new_value;
+	}
+	ret = count;
+out_free:
+	free_page((unsigned long)page);
+out:	
+	return ret;
+}
+
+static ssize_t sel_read_avc_hash_stats(struct file *filp, char __user *buf,
+				       size_t count, loff_t *ppos)
+{
+	char *page;
+	ssize_t ret = 0;
+	
+	page = (char *)__get_free_page(GFP_KERNEL);
+	if (!page) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = avc_get_hash_stats(page);
+	if (ret >= 0)
+		ret = simple_read_from_buffer(buf, count, ppos, page, ret);
+	free_page((unsigned long)page);
+out:
+	return ret;
+}
+
+static struct file_operations sel_avc_cache_threshold_ops = {
+	.read		= sel_read_avc_cache_threshold,
+	.write		= sel_write_avc_cache_threshold,
+};
+
+static struct file_operations sel_avc_hash_stats_ops = {
+	.read		= sel_read_avc_hash_stats,
+};
+
+#ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
+static struct avc_cache_stats *sel_avc_get_stat_idx(loff_t *idx)
+{
+	int cpu;
+	
+	for (cpu = *idx; cpu < NR_CPUS; ++cpu) {
+		if (!cpu_possible(cpu))
+			continue;
+		*idx = cpu + 1;
+		return &per_cpu(avc_cache_stats, cpu);
+	}
+	return NULL;
+}
+
+static void *sel_avc_stats_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	loff_t n = *pos - 1;
+
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+	
+	return sel_avc_get_stat_idx(&n);
+}
+
+static void *sel_avc_stats_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return sel_avc_get_stat_idx(pos);
+}
+
+static int sel_avc_stats_seq_show(struct seq_file *seq, void *v)
+{
+	struct avc_cache_stats *st = v;
+	
+	if (v == SEQ_START_TOKEN)
+		seq_printf(seq, "lookups hits misses allocations reclaims "
+			   "frees\n");
+	else
+		seq_printf(seq, "%u %u %u %u %u %u\n", st->lookups,
+			   st->hits, st->misses, st->allocations,
+			   st->reclaims, st->frees);
+	return 0;
+}
+
+static void sel_avc_stats_seq_stop(struct seq_file *seq, void *v)
+{ }
+
+static struct seq_operations sel_avc_cache_stats_seq_ops = {
+	.start		= sel_avc_stats_seq_start,
+	.next		= sel_avc_stats_seq_next,
+	.show		= sel_avc_stats_seq_show,
+	.stop		= sel_avc_stats_seq_stop,
+};
+
+static int sel_open_avc_cache_stats(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &sel_avc_cache_stats_seq_ops);
+}
+
+static struct file_operations sel_avc_cache_stats_ops = {
+	.open		= sel_open_avc_cache_stats,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+#endif
+
+static int sel_make_avc_files(struct dentry *dir)
+{
+	int i, ret = 0;
+	static struct tree_descr files[] = {
+		{ "cache_threshold",
+		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
+		{ "hash_stats", &sel_avc_hash_stats_ops, S_IRUGO },
+#ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
+		{ "cache_stats", &sel_avc_cache_stats_ops, S_IRUGO },
+#endif
+	};
+
+	for (i = 0; i < sizeof (files) / sizeof (files[0]); i++) {
+		struct inode *inode;
+		struct dentry *dentry;
+
+		dentry = d_alloc_name(dir, files[i].name);
+		if (!dentry) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
+		if (!inode) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		inode->i_fop = files[i].ops;
+		d_add(dentry, inode);
+	}
+out:
+	return ret;
+err:
+	d_genocide(dir);
+	goto out;
+}
+
+static int sel_make_dir(struct super_block *sb, struct dentry *dentry)
+{
+	int ret = 0;
+	struct inode *inode;
+
+	inode = sel_make_inode(sb, S_IFDIR | S_IRUGO | S_IXUGO);
+	if (!inode) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	d_add(dentry, inode);
+out:	
+	return ret;
+}
+
 static int sel_fill_super(struct super_block * sb, void * data, int silent)
 {
 	int ret;
@@ -942,7 +1153,19 @@ static int sel_fill_super(struct super_b
 	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, MKDEV(MEM_MAJOR, 3));
 	d_add(dentry, inode);
 	selinux_null = dentry;
-
+	
+	dentry = d_alloc_name(sb->s_root, "avc");
+	if (!dentry)
+		return -ENOMEM;
+		
+	ret = sel_make_dir(sb, dentry);
+	if (ret)
+		goto out;
+		
+	ret = sel_make_avc_files(dentry);
+	if (ret)
+		goto out;
+	
 	return 0;
 out:
 	dput(dentry);


