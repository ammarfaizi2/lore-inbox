Return-Path: <linux-kernel-owner+w=401wt.eu-S1750899AbXANBAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbXANBAB (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbXANBAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:00:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50888 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbXANBAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:00:00 -0500
Subject: [patch 01/12] mark struct file_operations const 1
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:52:36 -0800
Message-Id: <1168735956.3123.319.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 01/12] mark struct file_operations const

Many struct file_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Index: linux-2.6/include/linux/atalk.h
===================================================================
--- linux-2.6.orig/include/linux/atalk.h
+++ linux-2.6/include/linux/atalk.h
@@ -182,7 +182,7 @@ extern rwlock_t atalk_interfaces_lock;
 
 extern struct atalk_route atrtr_default;
 
-extern struct file_operations atalk_seq_arp_fops;
+extern const struct file_operations atalk_seq_arp_fops;
 
 extern int sysctl_aarp_expiry_time;
 extern int sysctl_aarp_tick_time;
Index: linux-2.6/include/linux/cpuset.h
===================================================================
--- linux-2.6.orig/include/linux/cpuset.h
+++ linux-2.6/include/linux/cpuset.h
@@ -55,7 +55,7 @@ extern int cpuset_excl_nodes_overlap(con
 extern int cpuset_memory_pressure_enabled;
 extern void __cpuset_memory_pressure_bump(void);
 
-extern struct file_operations proc_cpuset_operations;
+extern const struct file_operations proc_cpuset_operations;
 extern char *cpuset_task_status_allowed(struct task_struct *task, char *buffer);
 
 extern void cpuset_lock(void);
Index: linux-2.6/include/linux/random.h
===================================================================
--- linux-2.6.orig/include/linux/random.h
+++ linux-2.6/include/linux/random.h
@@ -63,7 +63,7 @@ extern u64 secure_dccp_sequence_number(_
 				       __be16 sport, __be16 dport);
 
 #ifndef MODULE
-extern struct file_operations random_fops, urandom_fops;
+extern const struct file_operations random_fops, urandom_fops;
 #endif
 
 unsigned int get_random_int(void);
Index: linux-2.6/include/linux/security.h
===================================================================
--- linux-2.6.orig/include/linux/security.h
+++ linux-2.6/include/linux/security.h
@@ -2130,7 +2130,7 @@ extern int mod_reg_security	(const char 
 extern int mod_unreg_security	(const char *name, struct security_operations *ops);
 extern struct dentry *securityfs_create_file(const char *name, mode_t mode,
 					     struct dentry *parent, void *data,
-					     struct file_operations *fops);
+					     const struct file_operations *fops);
 extern struct dentry *securityfs_create_dir(const char *name, struct dentry *parent);
 extern void securityfs_remove(struct dentry *dentry);
 
Index: linux-2.6/include/net/ax25.h
===================================================================
--- linux-2.6.orig/include/net/ax25.h
+++ linux-2.6/include/net/ax25.h
@@ -377,7 +377,7 @@ extern int  ax25_check_iframes_acked(ax2
 /* ax25_route.c */
 extern void ax25_rt_device_down(struct net_device *);
 extern int  ax25_rt_ioctl(unsigned int, void __user *);
-extern struct file_operations ax25_route_fops;
+extern const struct file_operations ax25_route_fops;
 extern ax25_route *ax25_get_route(ax25_address *addr, struct net_device *dev);
 extern int  ax25_rt_autobind(ax25_cb *, ax25_address *);
 extern struct sk_buff *ax25_rt_build_path(struct sk_buff *, ax25_address *, ax25_address *, ax25_digi *);
@@ -430,7 +430,7 @@ extern unsigned long ax25_display_timer(
 extern int  ax25_uid_policy;
 extern ax25_uid_assoc *ax25_findbyuid(uid_t);
 extern int __must_check ax25_uid_ioctl(int, struct sockaddr_ax25 *);
-extern struct file_operations ax25_uid_fops;
+extern const struct file_operations ax25_uid_fops;
 extern void ax25_uid_free(void);
 
 /* sysctl_net_ax25.c */
Index: linux-2.6/include/net/netfilter/nf_conntrack_expect.h
===================================================================
--- linux-2.6.orig/include/net/netfilter/nf_conntrack_expect.h
+++ linux-2.6/include/net/netfilter/nf_conntrack_expect.h
@@ -8,7 +8,7 @@
 
 extern struct list_head nf_conntrack_expect_list;
 extern struct kmem_cache *nf_conntrack_expect_cachep;
-extern struct file_operations exp_file_ops;
+extern const struct file_operations exp_file_ops;
 
 struct nf_conntrack_expect
 {
Index: linux-2.6/include/net/netrom.h
===================================================================
--- linux-2.6.orig/include/net/netrom.h
+++ linux-2.6/include/net/netrom.h
@@ -215,8 +215,8 @@ extern struct net_device *nr_dev_get(ax2
 extern int  nr_rt_ioctl(unsigned int, void __user *);
 extern void nr_link_failed(ax25_cb *, int);
 extern int  nr_route_frame(struct sk_buff *, ax25_cb *);
-extern struct file_operations nr_nodes_fops;
-extern struct file_operations nr_neigh_fops;
+extern const struct file_operations nr_nodes_fops;
+extern const struct file_operations nr_neigh_fops;
 extern void nr_rt_free(void);
 
 /* nr_subr.c */
Index: linux-2.6/include/net/rose.h
===================================================================
--- linux-2.6.orig/include/net/rose.h
+++ linux-2.6/include/net/rose.h
@@ -189,9 +189,9 @@ extern void rose_enquiry_response(struct
 
 /* rose_route.c */
 extern struct rose_neigh rose_loopback_neigh;
-extern struct file_operations rose_neigh_fops;
-extern struct file_operations rose_nodes_fops;
-extern struct file_operations rose_routes_fops;
+extern const struct file_operations rose_neigh_fops;
+extern const struct file_operations rose_nodes_fops;
+extern const struct file_operations rose_routes_fops;
 
 extern void rose_add_loopback_neigh(void);
 extern int __must_check rose_add_loopback_node(rose_address *);
Index: linux-2.6/include/sound/pcm.h
===================================================================
--- linux-2.6.orig/include/sound/pcm.h
+++ linux-2.6/include/sound/pcm.h
@@ -443,7 +443,7 @@ struct snd_pcm_notify {
  *  Registering
  */
 
-extern struct file_operations snd_pcm_f_ops[2];
+extern const struct file_operations snd_pcm_f_ops[2];
 
 int snd_pcm_new(struct snd_card *card, char *id, int device,
 		int playback_count, int capture_count,


