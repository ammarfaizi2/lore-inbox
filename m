Return-Path: <linux-kernel-owner+w=401wt.eu-S1751001AbXANBCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbXANBCf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbXANBCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:02:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52775 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbXANBCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:02:04 -0500
Subject: [patch 07/12] mark struct file_operations const 7
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:56:00 -0800
Message-Id: <1168736160.3123.331.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 07/12] mark struct file_operations const

Many struct file_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6/ipc/mqueue.c
===================================================================
--- linux-2.6.orig/ipc/mqueue.c
+++ linux-2.6/ipc/mqueue.c
@@ -85,7 +85,7 @@ struct mqueue_inode_info {
 };
 
 static struct inode_operations mqueue_dir_inode_operations;
-static struct file_operations mqueue_file_operations;
+static const struct file_operations mqueue_file_operations;
 static struct super_operations mqueue_super_ops;
 static void remove_notification(struct mqueue_inode_info *info);
 
@@ -1166,7 +1166,7 @@ static struct inode_operations mqueue_di
 	.unlink = mqueue_unlink,
 };
 
-static struct file_operations mqueue_file_operations = {
+static const struct file_operations mqueue_file_operations = {
 	.flush = mqueue_flush_file,
 	.poll = mqueue_poll_file,
 	.read = mqueue_read_file,
Index: linux-2.6/ipc/shm.c
===================================================================
--- linux-2.6.orig/ipc/shm.c
+++ linux-2.6/ipc/shm.c
@@ -42,7 +42,7 @@
 
 #include "util.h"
 
-static struct file_operations shm_file_operations;
+static const struct file_operations shm_file_operations;
 static struct vm_operations_struct shm_vm_ops;
 
 static struct ipc_ids init_shm_ids;
@@ -249,7 +249,7 @@ static int shm_release(struct inode *ino
 	return 0;
 }
 
-static struct file_operations shm_file_operations = {
+static const struct file_operations shm_file_operations = {
 	.mmap		= shm_mmap,
 	.release	= shm_release,
 #ifndef CONFIG_MMU
Index: linux-2.6/ipc/util.c
===================================================================
--- linux-2.6.orig/ipc/util.c
+++ linux-2.6/ipc/util.c
@@ -205,7 +205,7 @@ void __ipc_init ipc_init_ids(struct ipc_
 }
 
 #ifdef CONFIG_PROC_FS
-static struct file_operations sysvipc_proc_fops;
+static const struct file_operations sysvipc_proc_fops;
 /**
  *	ipc_init_proc_interface	-  Create a proc interface for sysipc types
  *				   using a seq_file interface.
@@ -848,7 +848,7 @@ static int sysvipc_proc_open(struct inod
 	return ret;
 }
 
-static struct file_operations sysvipc_proc_fops = {
+static const struct file_operations sysvipc_proc_fops = {
 	.open    = sysvipc_proc_open,
 	.read    = seq_read,
 	.llseek  = seq_lseek,
Index: linux-2.6/kernel/cpuset.c
===================================================================
--- linux-2.6.orig/kernel/cpuset.c
+++ linux-2.6/kernel/cpuset.c
@@ -2656,7 +2656,7 @@ static int cpuset_open(struct inode *ino
 	return single_open(file, proc_cpuset_show, pid);
 }
 
-struct file_operations proc_cpuset_operations = {
+const struct file_operations proc_cpuset_operations = {
 	.open		= cpuset_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/net/802/tr.c
===================================================================
--- linux-2.6.orig/net/802/tr.c
+++ linux-2.6/net/802/tr.c
@@ -576,7 +576,7 @@ static int rif_seq_open(struct inode *in
 	return seq_open(file, &rif_seq_ops);
 }
 
-static struct file_operations rif_seq_fops = {
+static const struct file_operations rif_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = rif_seq_open,
 	.read    = seq_read,
Index: linux-2.6/net/8021q/vlanproc.c
===================================================================
--- linux-2.6.orig/net/8021q/vlanproc.c
+++ linux-2.6/net/8021q/vlanproc.c
@@ -81,7 +81,7 @@ static int vlan_seq_open(struct inode *i
 	return seq_open(file, &vlan_seq_ops);
 }
 
-static struct file_operations vlan_fops = {
+static const struct file_operations vlan_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = vlan_seq_open,
 	.read    = seq_read,
@@ -98,7 +98,7 @@ static int vlandev_seq_open(struct inode
 	return single_open(file, vlandev_seq_show, PDE(inode)->data);
 }
 
-static struct file_operations vlandev_fops = {
+static const struct file_operations vlandev_fops = {
 	.owner = THIS_MODULE,
 	.open    = vlandev_seq_open,
 	.read    = seq_read,
Index: linux-2.6/net/appletalk/aarp.c
===================================================================
--- linux-2.6.orig/net/appletalk/aarp.c
+++ linux-2.6/net/appletalk/aarp.c
@@ -1048,7 +1048,7 @@ out_kfree:
 	goto out;
 }
 
-struct file_operations atalk_seq_arp_fops = {
+const struct file_operations atalk_seq_arp_fops = {
 	.owner		= THIS_MODULE,
 	.open           = aarp_seq_open,
 	.read           = seq_read,
Index: linux-2.6/net/appletalk/atalk_proc.c
===================================================================
--- linux-2.6.orig/net/appletalk/atalk_proc.c
+++ linux-2.6/net/appletalk/atalk_proc.c
@@ -240,7 +240,7 @@ static int atalk_seq_socket_open(struct 
 	return seq_open(file, &atalk_seq_socket_ops);
 }
 
-static struct file_operations atalk_seq_interface_fops = {
+static const struct file_operations atalk_seq_interface_fops = {
 	.owner		= THIS_MODULE,
 	.open		= atalk_seq_interface_open,
 	.read		= seq_read,
@@ -248,7 +248,7 @@ static struct file_operations atalk_seq_
 	.release	= seq_release,
 };
 
-static struct file_operations atalk_seq_route_fops = {
+static const struct file_operations atalk_seq_route_fops = {
 	.owner		= THIS_MODULE,
 	.open		= atalk_seq_route_open,
 	.read		= seq_read,
@@ -256,7 +256,7 @@ static struct file_operations atalk_seq_
 	.release	= seq_release,
 };
 
-static struct file_operations atalk_seq_socket_fops = {
+static const struct file_operations atalk_seq_socket_fops = {
 	.owner		= THIS_MODULE,
 	.open		= atalk_seq_socket_open,
 	.read		= seq_read,
Index: linux-2.6/net/atm/br2684.c
===================================================================
--- linux-2.6.orig/net/atm/br2684.c
+++ linux-2.6/net/atm/br2684.c
@@ -784,7 +784,7 @@ static int br2684_proc_open(struct inode
 	return seq_open(file, &br2684_seq_ops);
 }
 
-static struct file_operations br2684_proc_ops = {
+static const struct file_operations br2684_proc_ops = {
 	.owner   = THIS_MODULE,
 	.open    = br2684_proc_open,
 	.read    = seq_read,
Index: linux-2.6/net/atm/clip.c
===================================================================
--- linux-2.6.orig/net/atm/clip.c
+++ linux-2.6/net/atm/clip.c
@@ -971,7 +971,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations arp_seq_fops = {
+static const struct file_operations arp_seq_fops = {
 	.open		= arp_seq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/net/atm/lec.c
===================================================================
--- linux-2.6.orig/net/atm/lec.c
+++ linux-2.6/net/atm/lec.c
@@ -1212,7 +1212,7 @@ static int lec_seq_release(struct inode 
 	return seq_release_private(inode, file);
 }
 
-static struct file_operations lec_seq_fops = {
+static const struct file_operations lec_seq_fops = {
 	.owner = THIS_MODULE,
 	.open = lec_seq_open,
 	.read = seq_read,
Index: linux-2.6/net/atm/mpoa_proc.c
===================================================================
--- linux-2.6.orig/net/atm/mpoa_proc.c
+++ linux-2.6/net/atm/mpoa_proc.c
@@ -39,7 +39,7 @@ static int parse_qos(const char *buff);
 /*
  *   Define allowed FILE OPERATIONS
  */
-static struct file_operations mpc_file_operations = {
+static const struct file_operations mpc_file_operations = {
 	.owner =	THIS_MODULE,
 	.open =		proc_mpc_open,
 	.read =		seq_read,
Index: linux-2.6/net/atm/proc.c
===================================================================
--- linux-2.6.orig/net/atm/proc.c
+++ linux-2.6/net/atm/proc.c
@@ -33,7 +33,7 @@
 static ssize_t proc_dev_atm_read(struct file *file,char __user *buf,size_t count,
     loff_t *pos);
 
-static struct file_operations proc_atm_dev_ops = {
+static const struct file_operations proc_atm_dev_ops = {
 	.owner =	THIS_MODULE,
 	.read =		proc_dev_atm_read,
 };
@@ -272,7 +272,7 @@ static int atm_dev_seq_open(struct inode
 	return seq_open(file, &atm_dev_seq_ops);
 }
  
-static struct file_operations devices_seq_fops = {
+static const struct file_operations devices_seq_fops = {
 	.open		= atm_dev_seq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -307,7 +307,7 @@ static int pvc_seq_open(struct inode *in
 	return __vcc_seq_open(inode, file, PF_ATMPVC, &pvc_seq_ops);
 }
 
-static struct file_operations pvc_seq_fops = {
+static const struct file_operations pvc_seq_fops = {
 	.open		= pvc_seq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -341,7 +341,7 @@ static int vcc_seq_open(struct inode *in
  	return __vcc_seq_open(inode, file, 0, &vcc_seq_ops);
 }
  
-static struct file_operations vcc_seq_fops = {
+static const struct file_operations vcc_seq_fops = {
 	.open		= vcc_seq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -376,7 +376,7 @@ static int svc_seq_open(struct inode *in
 	return __vcc_seq_open(inode, file, PF_ATMSVC, &svc_seq_ops);
 }
 
-static struct file_operations svc_seq_fops = {
+static const struct file_operations svc_seq_fops = {
 	.open		= svc_seq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -457,7 +457,7 @@ void atm_proc_dev_deregister(struct atm_
 
 static struct atm_proc_entry {
 	char *name;
-	struct file_operations *proc_fops;
+	const struct file_operations *proc_fops;
 	struct proc_dir_entry *dirent;
 } atm_proc_ents[] = {
 	{ .name = "devices",	.proc_fops = &devices_seq_fops },
Index: linux-2.6/net/ax25/af_ax25.c
===================================================================
--- linux-2.6.orig/net/ax25/af_ax25.c
+++ linux-2.6/net/ax25/af_ax25.c
@@ -1938,7 +1938,7 @@ static int ax25_info_open(struct inode *
 	return seq_open(file, &ax25_info_seqops);
 }
 
-static struct file_operations ax25_info_fops = {
+static const struct file_operations ax25_info_fops = {
 	.owner = THIS_MODULE,
 	.open = ax25_info_open,
 	.read = seq_read,
Index: linux-2.6/net/ax25/ax25_route.c
===================================================================
--- linux-2.6.orig/net/ax25/ax25_route.c
+++ linux-2.6/net/ax25/ax25_route.c
@@ -332,7 +332,7 @@ static int ax25_rt_info_open(struct inod
 	return seq_open(file, &ax25_rt_seqops);
 }
 
-struct file_operations ax25_route_fops = {
+const struct file_operations ax25_route_fops = {
 	.owner = THIS_MODULE,
 	.open = ax25_rt_info_open,
 	.read = seq_read,
Index: linux-2.6/net/ax25/ax25_uid.c
===================================================================
--- linux-2.6.orig/net/ax25/ax25_uid.c
+++ linux-2.6/net/ax25/ax25_uid.c
@@ -198,7 +198,7 @@ static int ax25_uid_info_open(struct ino
 	return seq_open(file, &ax25_uid_seqops);
 }
 
-struct file_operations ax25_uid_fops = {
+const struct file_operations ax25_uid_fops = {
 	.owner = THIS_MODULE,
 	.open = ax25_uid_info_open,
 	.read = seq_read,
Index: linux-2.6/net/core/dev.c
===================================================================
--- linux-2.6.orig/net/core/dev.c
+++ linux-2.6/net/core/dev.c
@@ -2200,7 +2200,7 @@ static int dev_seq_open(struct inode *in
 	return seq_open(file, &dev_seq_ops);
 }
 
-static struct file_operations dev_seq_fops = {
+static const struct file_operations dev_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = dev_seq_open,
 	.read    = seq_read,
@@ -2220,7 +2220,7 @@ static int softnet_seq_open(struct inode
 	return seq_open(file, &softnet_seq_ops);
 }
 
-static struct file_operations softnet_seq_fops = {
+static const struct file_operations softnet_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = softnet_seq_open,
 	.read    = seq_read,
Index: linux-2.6/net/core/dev_mcast.c
===================================================================
--- linux-2.6.orig/net/core/dev_mcast.c
+++ linux-2.6/net/core/dev_mcast.c
@@ -277,7 +277,7 @@ static int dev_mc_seq_open(struct inode 
 	return seq_open(file, &dev_mc_seq_ops);
 }
 
-static struct file_operations dev_mc_seq_fops = {
+static const struct file_operations dev_mc_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = dev_mc_seq_open,
 	.read    = seq_read,
Index: linux-2.6/net/core/neighbour.c
===================================================================
--- linux-2.6.orig/net/core/neighbour.c
+++ linux-2.6/net/core/neighbour.c
@@ -63,7 +63,7 @@ void neigh_changeaddr(struct neigh_table
 
 static struct neigh_table *neigh_tables;
 #ifdef CONFIG_PROC_FS
-static struct file_operations neigh_stat_seq_fops;
+static const struct file_operations neigh_stat_seq_fops;
 #endif
 
 /*
@@ -2399,7 +2399,7 @@ static int neigh_stat_seq_open(struct in
 	return ret;
 };
 
-static struct file_operations neigh_stat_seq_fops = {
+static const struct file_operations neigh_stat_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open 	 = neigh_stat_seq_open,
 	.read	 = seq_read,
Index: linux-2.6/net/core/pktgen.c
===================================================================
--- linux-2.6.orig/net/core/pktgen.c
+++ linux-2.6/net/core/pktgen.c
@@ -579,7 +579,7 @@ static int pgctrl_open(struct inode *ino
 	return single_open(file, pgctrl_show, PDE(inode)->data);
 }
 
-static struct file_operations pktgen_fops = {
+static const struct file_operations pktgen_fops = {
 	.owner   = THIS_MODULE,
 	.open    = pgctrl_open,
 	.read    = seq_read,
@@ -1672,7 +1672,7 @@ static int pktgen_if_open(struct inode *
 	return single_open(file, pktgen_if_show, PDE(inode)->data);
 }
 
-static struct file_operations pktgen_if_fops = {
+static const struct file_operations pktgen_if_fops = {
 	.owner   = THIS_MODULE,
 	.open    = pktgen_if_open,
 	.read    = seq_read,
@@ -1815,7 +1815,7 @@ static int pktgen_thread_open(struct ino
 	return single_open(file, pktgen_thread_show, PDE(inode)->data);
 }
 
-static struct file_operations pktgen_thread_fops = {
+static const struct file_operations pktgen_thread_fops = {
 	.owner   = THIS_MODULE,
 	.open    = pktgen_thread_open,
 	.read    = seq_read,
Index: linux-2.6/net/core/sock.c
===================================================================
--- linux-2.6.orig/net/core/sock.c
+++ linux-2.6/net/core/sock.c
@@ -1911,7 +1911,7 @@ static int proto_seq_open(struct inode *
 	return seq_open(file, &proto_seq_ops);
 }
 
-static struct file_operations proto_seq_fops = {
+static const struct file_operations proto_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= proto_seq_open,
 	.read		= seq_read,
Index: linux-2.6/net/core/wireless.c
===================================================================
--- linux-2.6.orig/net/core/wireless.c
+++ linux-2.6/net/core/wireless.c
@@ -674,7 +674,7 @@ static int wireless_seq_open(struct inod
 	return seq_open(file, &wireless_seq_ops);
 }
 
-static struct file_operations wireless_seq_fops = {
+static const struct file_operations wireless_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = wireless_seq_open,
 	.read    = seq_read,
Index: linux-2.6/net/dccp/probe.c
===================================================================
--- linux-2.6.orig/net/dccp/probe.c
+++ linux-2.6/net/dccp/probe.c
@@ -149,7 +149,7 @@ out_free:
 	return error ? error : cnt;
 }
 
-static struct file_operations dccpprobe_fops = {
+static const struct file_operations dccpprobe_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = dccpprobe_open,
 	.read    = dccpprobe_read,
Index: linux-2.6/net/decnet/af_decnet.c
===================================================================
--- linux-2.6.orig/net/decnet/af_decnet.c
+++ linux-2.6/net/decnet/af_decnet.c
@@ -2331,7 +2331,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations dn_socket_seq_fops = {
+static const struct file_operations dn_socket_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= dn_socket_seq_open,
 	.read		= seq_read,
Index: linux-2.6/net/decnet/dn_dev.c
===================================================================
--- linux-2.6.orig/net/decnet/dn_dev.c
+++ linux-2.6/net/decnet/dn_dev.c
@@ -1431,7 +1431,7 @@ static int dn_dev_seq_open(struct inode 
 	return seq_open(file, &dn_dev_seq_ops);
 }
 
-static struct file_operations dn_dev_seq_fops = {
+static const struct file_operations dn_dev_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = dn_dev_seq_open,
 	.read	 = seq_read,
Index: linux-2.6/net/decnet/dn_neigh.c
===================================================================
--- linux-2.6.orig/net/decnet/dn_neigh.c
+++ linux-2.6/net/decnet/dn_neigh.c
@@ -598,7 +598,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations dn_neigh_seq_fops = {
+static const struct file_operations dn_neigh_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= dn_neigh_seq_open,
 	.read		= seq_read,
Index: linux-2.6/net/decnet/dn_route.c
===================================================================
--- linux-2.6.orig/net/decnet/dn_route.c
+++ linux-2.6/net/decnet/dn_route.c
@@ -1751,7 +1751,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations dn_rt_cache_seq_fops = {
+static const struct file_operations dn_rt_cache_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = dn_rt_cache_seq_open,
 	.read	 = seq_read,
Index: linux-2.6/net/ipv4/arp.c
===================================================================
--- linux-2.6.orig/net/ipv4/arp.c
+++ linux-2.6/net/ipv4/arp.c
@@ -1390,7 +1390,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations arp_seq_fops = {
+static const struct file_operations arp_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open           = arp_seq_open,
 	.read           = seq_read,
Index: linux-2.6/net/ipv4/fib_hash.c
===================================================================
--- linux-2.6.orig/net/ipv4/fib_hash.c
+++ linux-2.6/net/ipv4/fib_hash.c
@@ -1057,7 +1057,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations fib_seq_fops = {
+static const struct file_operations fib_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open           = fib_seq_open,
 	.read           = seq_read,
Index: linux-2.6/net/ipv4/fib_trie.c
===================================================================
--- linux-2.6.orig/net/ipv4/fib_trie.c
+++ linux-2.6/net/ipv4/fib_trie.c
@@ -2162,7 +2162,7 @@ static int fib_triestat_seq_open(struct 
 	return single_open(file, fib_triestat_seq_show, NULL);
 }
 
-static struct file_operations fib_triestat_fops = {
+static const struct file_operations fib_triestat_fops = {
 	.owner	= THIS_MODULE,
 	.open	= fib_triestat_seq_open,
 	.read	= seq_read,
@@ -2352,7 +2352,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations fib_trie_fops = {
+static const struct file_operations fib_trie_fops = {
 	.owner  = THIS_MODULE,
 	.open   = fib_trie_seq_open,
 	.read   = seq_read,
@@ -2473,7 +2473,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations fib_route_fops = {
+static const struct file_operations fib_route_fops = {
 	.owner  = THIS_MODULE,
 	.open   = fib_route_seq_open,
 	.read   = seq_read,
Index: linux-2.6/net/ipv4/igmp.c
===================================================================
--- linux-2.6.orig/net/ipv4/igmp.c
+++ linux-2.6/net/ipv4/igmp.c
@@ -2401,7 +2401,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations igmp_mc_seq_fops = {
+static const struct file_operations igmp_mc_seq_fops = {
 	.owner		=	THIS_MODULE,
 	.open		=	igmp_mc_seq_open,
 	.read		=	seq_read,
@@ -2575,7 +2575,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations igmp_mcf_seq_fops = {
+static const struct file_operations igmp_mcf_seq_fops = {
 	.owner		=	THIS_MODULE,
 	.open		=	igmp_mcf_seq_open,
 	.read		=	seq_read,
Index: linux-2.6/net/ipv4/ipconfig.c
===================================================================
--- linux-2.6.orig/net/ipv4/ipconfig.c
+++ linux-2.6/net/ipv4/ipconfig.c
@@ -1200,7 +1200,7 @@ static int pnp_seq_open(struct inode *in
 	return single_open(file, pnp_seq_show, NULL);
 }
 
-static struct file_operations pnp_seq_fops = {
+static const struct file_operations pnp_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= pnp_seq_open,
 	.read		= seq_read,
Index: linux-2.6/net/ipv4/ipmr.c
===================================================================
--- linux-2.6.orig/net/ipv4/ipmr.c
+++ linux-2.6/net/ipv4/ipmr.c
@@ -1714,7 +1714,7 @@ out_kfree:
 
 }
 
-static struct file_operations ipmr_vif_fops = {
+static const struct file_operations ipmr_vif_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = ipmr_vif_open,
 	.read    = seq_read,
@@ -1876,7 +1876,7 @@ out_kfree:
 
 }
 
-static struct file_operations ipmr_mfc_fops = {
+static const struct file_operations ipmr_mfc_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = ipmr_mfc_open,
 	.read    = seq_read,
Index: linux-2.6/net/ipv4/ipvs/ip_vs_app.c
===================================================================
--- linux-2.6.orig/net/ipv4/ipvs/ip_vs_app.c
+++ linux-2.6/net/ipv4/ipvs/ip_vs_app.c
@@ -561,7 +561,7 @@ static int ip_vs_app_open(struct inode *
 	return seq_open(file, &ip_vs_app_seq_ops);
 }
 
-static struct file_operations ip_vs_app_fops = {
+static const struct file_operations ip_vs_app_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = ip_vs_app_open,
 	.read	 = seq_read,
Index: linux-2.6/net/ipv4/ipvs/ip_vs_conn.c
===================================================================
--- linux-2.6.orig/net/ipv4/ipvs/ip_vs_conn.c
+++ linux-2.6/net/ipv4/ipvs/ip_vs_conn.c
@@ -758,7 +758,7 @@ static int ip_vs_conn_open(struct inode 
 	return seq_open(file, &ip_vs_conn_seq_ops);
 }
 
-static struct file_operations ip_vs_conn_fops = {
+static const struct file_operations ip_vs_conn_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = ip_vs_conn_open,
 	.read    = seq_read,
Index: linux-2.6/net/ipv4/ipvs/ip_vs_ctl.c
===================================================================
--- linux-2.6.orig/net/ipv4/ipvs/ip_vs_ctl.c
+++ linux-2.6/net/ipv4/ipvs/ip_vs_ctl.c
@@ -1812,7 +1812,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations ip_vs_info_fops = {
+static const struct file_operations ip_vs_info_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = ip_vs_info_open,
 	.read    = seq_read,
@@ -1859,7 +1859,7 @@ static int ip_vs_stats_seq_open(struct i
 	return single_open(file, ip_vs_stats_show, NULL);
 }
 
-static struct file_operations ip_vs_stats_fops = {
+static const struct file_operations ip_vs_stats_fops = {
 	.owner = THIS_MODULE,
 	.open = ip_vs_stats_seq_open,
 	.read = seq_read,
Index: linux-2.6/net/ipv4/netfilter/ip_conntrack_standalone.c
===================================================================
--- linux-2.6.orig/net/ipv4/netfilter/ip_conntrack_standalone.c
+++ linux-2.6/net/ipv4/netfilter/ip_conntrack_standalone.c
@@ -222,7 +222,7 @@ out_free:
 	return ret;
 }
 
-static struct file_operations ct_file_ops = {
+static const struct file_operations ct_file_ops = {
 	.owner   = THIS_MODULE,
 	.open    = ct_open,
 	.read    = seq_read,
@@ -298,7 +298,7 @@ static int exp_open(struct inode *inode,
 	return seq_open(file, &exp_seq_ops);
 }
   
-static struct file_operations exp_file_ops = {
+static const struct file_operations exp_file_ops = {
 	.owner   = THIS_MODULE,
 	.open    = exp_open,
 	.read    = seq_read,
@@ -386,7 +386,7 @@ static int ct_cpu_seq_open(struct inode 
 	return seq_open(file, &ct_cpu_seq_ops);
 }
 
-static struct file_operations ct_cpu_seq_fops = {
+static const struct file_operations ct_cpu_seq_fops = {
 	.owner   = THIS_MODULE,
 	.open    = ct_cpu_seq_open,
 	.read    = seq_read,
Index: linux-2.6/net/ipv4/netfilter/ipt_CLUSTERIP.c
===================================================================
--- linux-2.6.orig/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ linux-2.6/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -69,7 +69,7 @@ static LIST_HEAD(clusterip_configs);
 static DEFINE_RWLOCK(clusterip_lock);
 
 #ifdef CONFIG_PROC_FS
-static struct file_operations clusterip_proc_fops;
+static const struct file_operations clusterip_proc_fops;
 static struct proc_dir_entry *clusterip_procdir;
 #endif
 
@@ -712,7 +712,7 @@ static ssize_t clusterip_proc_write(stru
 	return size;
 }
 
-static struct file_operations clusterip_proc_fops = {
+static const struct file_operations clusterip_proc_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = clusterip_proc_open,
 	.read	 = seq_read,
Index: linux-2.6/net/ipv4/netfilter/ipt_recent.c
===================================================================
--- linux-2.6.orig/net/ipv4/netfilter/ipt_recent.c
+++ linux-2.6/net/ipv4/netfilter/ipt_recent.c
@@ -78,7 +78,7 @@ static DEFINE_MUTEX(recent_mutex);
 
 #ifdef CONFIG_PROC_FS
 static struct proc_dir_entry	*proc_dir;
-static struct file_operations	recent_fops;
+static const struct file_operations	recent_fops;
 #endif
 
 static u_int32_t hash_rnd;
@@ -453,7 +453,7 @@ static ssize_t recent_proc_write(struct 
 	return size;
 }
 
-static struct file_operations recent_fops = {
+static const struct file_operations recent_fops = {
 	.open		= recent_seq_open,
 	.read		= seq_read,
 	.write		= recent_proc_write,
Index: linux-2.6/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4_compat.c
===================================================================
--- linux-2.6.orig/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4_compat.c
+++ linux-2.6/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4_compat.c
@@ -197,7 +197,7 @@ out_free:
 	return ret;
 }
 
-static struct file_operations ct_file_ops = {
+static const struct file_operations ct_file_ops = {
 	.owner   = THIS_MODULE,
 	.open    = ct_open,
 	.read    = seq_read,
@@ -278,7 +278,7 @@ static int exp_open(struct inode *inode,
 	return seq_open(file, &exp_seq_ops);
 }
 
-static struct file_operations ip_exp_file_ops = {
+static const struct file_operations ip_exp_file_ops = {
 	.owner   = THIS_MODULE,
 	.open    = exp_open,
 	.read    = seq_read,
@@ -366,7 +366,7 @@ static int ct_cpu_seq_open(struct inode 
 	return seq_open(file, &ct_cpu_seq_ops);
 }
 
-static struct file_operations ct_cpu_seq_fops = {
+static const struct file_operations ct_cpu_seq_fops = {
 	.owner   = THIS_MODULE,
 	.open    = ct_cpu_seq_open,
 	.read    = seq_read,
Index: linux-2.6/net/ipv4/proc.c
===================================================================
--- linux-2.6.orig/net/ipv4/proc.c
+++ linux-2.6/net/ipv4/proc.c
@@ -79,7 +79,7 @@ static int sockstat_seq_open(struct inod
 	return single_open(file, sockstat_seq_show, NULL);
 }
 
-static struct file_operations sockstat_seq_fops = {
+static const struct file_operations sockstat_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = sockstat_seq_open,
 	.read	 = seq_read,
@@ -326,7 +326,7 @@ static int snmp_seq_open(struct inode *i
 	return single_open(file, snmp_seq_show, NULL);
 }
 
-static struct file_operations snmp_seq_fops = {
+static const struct file_operations snmp_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = snmp_seq_open,
 	.read	 = seq_read,
@@ -360,7 +360,7 @@ static int netstat_seq_open(struct inode
 	return single_open(file, netstat_seq_show, NULL);
 }
 
-static struct file_operations netstat_seq_fops = {
+static const struct file_operations netstat_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = netstat_seq_open,
 	.read	 = seq_read,
Index: linux-2.6/net/ipv4/raw.c
===================================================================
--- linux-2.6.orig/net/ipv4/raw.c
+++ linux-2.6/net/ipv4/raw.c
@@ -916,7 +916,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations raw_seq_fops = {
+static const struct file_operations raw_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = raw_seq_open,
 	.read	 = seq_read,
Index: linux-2.6/net/ipv4/route.c
===================================================================
--- linux-2.6.orig/net/ipv4/route.c
+++ linux-2.6/net/ipv4/route.c
@@ -393,7 +393,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations rt_cache_seq_fops = {
+static const struct file_operations rt_cache_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = rt_cache_seq_open,
 	.read	 = seq_read,
@@ -484,7 +484,7 @@ static int rt_cpu_seq_open(struct inode 
 	return seq_open(file, &rt_cpu_seq_ops);
 }
 
-static struct file_operations rt_cpu_seq_fops = {
+static const struct file_operations rt_cpu_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = rt_cpu_seq_open,
 	.read	 = seq_read,
Index: linux-2.6/net/ipv4/tcp_probe.c
===================================================================
--- linux-2.6.orig/net/ipv4/tcp_probe.c
+++ linux-2.6/net/ipv4/tcp_probe.c
@@ -143,7 +143,7 @@ out_free:
 	return error ? error : cnt;
 }
 
-static struct file_operations tcpprobe_fops = {
+static const struct file_operations tcpprobe_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = tcpprobe_open,
 	.read    = tcpprobe_read,
Index: linux-2.6/net/ipv6/addrconf.c
===================================================================
--- linux-2.6.orig/net/ipv6/addrconf.c
+++ linux-2.6/net/ipv6/addrconf.c
@@ -2770,7 +2770,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations if6_fops = {
+static const struct file_operations if6_fops = {
 	.owner		= THIS_MODULE,
 	.open		= if6_seq_open,
 	.read		= seq_read,
Index: linux-2.6/net/ipv6/anycast.c
===================================================================
--- linux-2.6.orig/net/ipv6/anycast.c
+++ linux-2.6/net/ipv6/anycast.c
@@ -565,7 +565,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations ac6_seq_fops = {
+static const struct file_operations ac6_seq_fops = {
 	.owner		=	THIS_MODULE,
 	.open		=	ac6_seq_open,
 	.read		=	seq_read,
Index: linux-2.6/net/ipv6/ip6_flowlabel.c
===================================================================
--- linux-2.6.orig/net/ipv6/ip6_flowlabel.c
+++ linux-2.6/net/ipv6/ip6_flowlabel.c
@@ -677,7 +677,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations ip6fl_seq_fops = {
+static const struct file_operations ip6fl_seq_fops = {
 	.owner		=	THIS_MODULE,
 	.open		=	ip6fl_seq_open,
 	.read		=	seq_read,
Index: linux-2.6/net/ipv6/mcast.c
===================================================================
--- linux-2.6.orig/net/ipv6/mcast.c
+++ linux-2.6/net/ipv6/mcast.c
@@ -2455,7 +2455,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations igmp6_mc_seq_fops = {
+static const struct file_operations igmp6_mc_seq_fops = {
 	.owner		=	THIS_MODULE,
 	.open		=	igmp6_mc_seq_open,
 	.read		=	seq_read,
@@ -2629,7 +2629,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations igmp6_mcf_seq_fops = {
+static const struct file_operations igmp6_mcf_seq_fops = {
 	.owner		=	THIS_MODULE,
 	.open		=	igmp6_mcf_seq_open,
 	.read		=	seq_read,
Index: linux-2.6/net/ipv6/proc.c
===================================================================
--- linux-2.6.orig/net/ipv6/proc.c
+++ linux-2.6/net/ipv6/proc.c
@@ -187,7 +187,7 @@ static int sockstat6_seq_open(struct ino
 	return single_open(file, sockstat6_seq_show, NULL);
 }
 
-static struct file_operations sockstat6_seq_fops = {
+static const struct file_operations sockstat6_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = sockstat6_seq_open,
 	.read	 = seq_read,
@@ -200,7 +200,7 @@ static int snmp6_seq_open(struct inode *
 	return single_open(file, snmp6_seq_show, PDE(inode)->data);
 }
 
-static struct file_operations snmp6_seq_fops = {
+static const struct file_operations snmp6_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = snmp6_seq_open,
 	.read	 = seq_read,
Index: linux-2.6/net/ipv6/raw.c
===================================================================
--- linux-2.6.orig/net/ipv6/raw.c
+++ linux-2.6/net/ipv6/raw.c
@@ -1264,7 +1264,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations raw6_seq_fops = {
+static const struct file_operations raw6_seq_fops = {
 	.owner =	THIS_MODULE,
 	.open =		raw6_seq_open,
 	.read =		seq_read,
Index: linux-2.6/net/ipv6/route.c
===================================================================
--- linux-2.6.orig/net/ipv6/route.c
+++ linux-2.6/net/ipv6/route.c
@@ -2331,7 +2331,7 @@ static int rt6_stats_seq_open(struct ino
 	return single_open(file, rt6_stats_seq_show, NULL);
 }
 
-static struct file_operations rt6_stats_seq_fops = {
+static const struct file_operations rt6_stats_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = rt6_stats_seq_open,
 	.read	 = seq_read,
Index: linux-2.6/net/ipx/ipx_proc.c
===================================================================
--- linux-2.6.orig/net/ipx/ipx_proc.c
+++ linux-2.6/net/ipx/ipx_proc.c
@@ -322,7 +322,7 @@ static int ipx_seq_socket_open(struct in
 	return seq_open(file, &ipx_seq_socket_ops);
 }
 
-static struct file_operations ipx_seq_interface_fops = {
+static const struct file_operations ipx_seq_interface_fops = {
 	.owner		= THIS_MODULE,
 	.open           = ipx_seq_interface_open,
 	.read           = seq_read,
@@ -330,7 +330,7 @@ static struct file_operations ipx_seq_in
 	.release        = seq_release,
 };
 
-static struct file_operations ipx_seq_route_fops = {
+static const struct file_operations ipx_seq_route_fops = {
 	.owner		= THIS_MODULE,
 	.open           = ipx_seq_route_open,
 	.read           = seq_read,
@@ -338,7 +338,7 @@ static struct file_operations ipx_seq_ro
 	.release        = seq_release,
 };
 
-static struct file_operations ipx_seq_socket_fops = {
+static const struct file_operations ipx_seq_socket_fops = {
 	.owner		= THIS_MODULE,
 	.open           = ipx_seq_socket_open,
 	.read           = seq_read,
Index: linux-2.6/net/irda/discovery.c
===================================================================
--- linux-2.6.orig/net/irda/discovery.c
+++ linux-2.6/net/irda/discovery.c
@@ -409,7 +409,7 @@ static int discovery_seq_open(struct ino
 	return seq_open(file, &discovery_seq_ops);
 }
 
-struct file_operations discovery_seq_fops = {
+const struct file_operations discovery_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open           = discovery_seq_open,
 	.read           = seq_read,


