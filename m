Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268217AbRG2WzO>; Sun, 29 Jul 2001 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268221AbRG2WzE>; Sun, 29 Jul 2001 18:55:04 -0400
Received: from juicer03.bigpond.com ([139.134.6.79]:63973 "EHLO
	mailin6.bigpond.com") by vger.kernel.org with ESMTP
	id <S268217AbRG2Wyw>; Sun, 29 Jul 2001 18:54:52 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: Matt Bernstein <matt@theBachChoir.org.uk>
Subject: Re: 2.4.7 crash with ipchains/netfilter as modules 
In-Reply-To: Your message of "Wed, 25 Jul 2001 20:03:34 +1000."
             <m15PLVv-000CDBC@localhost> 
Date: Mon, 30 Jul 2001 06:57:04 +1000
Message-Id: <E15QxcZ-0001fC-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In message <m15PLVv-000CDBC@localhost> you write:
> > "modprobe -r ipchains" gives the following (possibly meaningless) oops.
> 
> Known issue (usage count stays at 0, independent of usage).
> 
> Try ipchains -L -n to get your output.
> 
> I'll look into the removal code (Al found some loading problems before
> which I want to fix anyway)...

It looks like you unloaded the module while ipchains was reading
/proc.  That's fixed too (and the same bug in the other code).

Please test this patch (v2.4.7), and see if it's any better...
Thanks,
Rusty.
--
Premature optmztion is rt of all evl. --DK

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/net/ipv4/netfilter/ip_conntrack_standalone.c working-2.4.7-unclean/net/ipv4/netfilter/ip_conntrack_standalone.c
--- linux-2.4.7-official/net/ipv4/netfilter/ip_conntrack_standalone.c	Sat Apr 28 07:15:01 2001
+++ working-2.4.7-unclean/net/ipv4/netfilter/ip_conntrack_standalone.c	Sun Jul 29 14:58:23 2001
@@ -226,6 +226,7 @@
 
 static int init_or_cleanup(int init)
 {
+	struct proc_dir_entry *proc;
 	int ret = 0;
 
 	if (!init) goto cleanup;
@@ -234,11 +235,14 @@
 	if (ret < 0)
 		goto cleanup_nothing;
 
-	proc_net_create("ip_conntrack",0,list_conntracks);
+	proc = proc_net_create("ip_conntrack",0,list_conntracks);
+	if (!proc) goto cleanup_init;
+	proc->owner = THIS_MODULE;
+
 	ret = nf_register_hook(&ip_conntrack_in_ops);
 	if (ret < 0) {
 		printk("ip_conntrack: can't register in hook.\n");
-		goto cleanup_init;
+		goto cleanup_proc;
 	}
 	ret = nf_register_hook(&ip_conntrack_local_out_ops);
 	if (ret < 0) {
@@ -266,8 +270,9 @@
 	nf_unregister_hook(&ip_conntrack_local_out_ops);
  cleanup_inops:
 	nf_unregister_hook(&ip_conntrack_in_ops);
- cleanup_init:
+ cleanup_proc:
 	proc_net_remove("ip_conntrack");
+ cleanup_init:
 	ip_conntrack_cleanup();
  cleanup_nothing:
 	return ret;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/net/ipv4/netfilter/ip_fw_compat_masq.c working-2.4.7-unclean/net/ipv4/netfilter/ip_fw_compat_masq.c
--- linux-2.4.7-official/net/ipv4/netfilter/ip_fw_compat_masq.c	Tue Sep 19 09:09:55 2000
+++ working-2.4.7-unclean/net/ipv4/netfilter/ip_fw_compat_masq.c	Sun Jul 29 18:49:28 2001
@@ -14,6 +14,7 @@
 #include <linux/inetdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/version.h>
+#include <linux/module.h>
 #include <net/route.h>
 
 #define ASSERT_READ_LOCK(x) MUST_BE_READ_LOCKED(&ip_conntrack_lock)
@@ -302,13 +303,22 @@
 int __init masq_init(void)
 {
 	int ret;
+	struct proc_dir_entry *proc;
 
 	ret = ip_conntrack_init();
 	if (ret == 0) {
 		ret = ip_nat_init();
-		if (ret == 0)
-			proc_net_create("ip_masquerade", 0, masq_procinfo);
-		else
+		if (ret == 0) {
+			proc = proc_net_create("ip_masquerade",
+					       0, masq_procinfo);
+			if (proc)
+				proc->owner = THIS_MODULE;
+			else {
+				ip_nat_cleanup();
+				ip_conntrack_cleanup();
+				ret = -ENOMEM;
+			}
+		} else
 			ip_conntrack_cleanup();
 	}
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/net/ipv4/netfilter/ip_queue.c working-2.4.7-unclean/net/ipv4/netfilter/ip_queue.c
--- linux-2.4.7-official/net/ipv4/netfilter/ip_queue.c	Sun Jul 22 13:13:27 2001
+++ working-2.4.7-unclean/net/ipv4/netfilter/ip_queue.c	Sun Jul 29 17:33:24 2001
@@ -647,6 +647,7 @@
 static int __init init(void)
 {
 	int status = 0;
+	struct proc_dir_entry *proc;
 	
 	nfnl = netlink_kernel_create(NETLINK_FIREWALL, netlink_receive_user_sk);
 	if (nfnl == NULL) {
@@ -662,8 +663,14 @@
 		sock_release(nfnl->socket);
 		return status;
 	}
+	proc = proc_net_create(IPQ_PROC_FS_NAME, 0, ipq_get_info);
+	if (proc) proc->owner = THIS_MODULE;
+	else {
+		ipq_destroy_queue(nlq);
+		sock_release(nfnl->socket);
+		return -ENOMEM;
+	}
 	register_netdevice_notifier(&ipq_dev_notifier);
-	proc_net_create(IPQ_PROC_FS_NAME, 0, ipq_get_info);
 	ipq_sysctl_header = register_sysctl_table(ipq_root_table, 0);
 	return status;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/net/ipv4/netfilter/ip_tables.c working-2.4.7-unclean/net/ipv4/netfilter/ip_tables.c
--- linux-2.4.7-official/net/ipv4/netfilter/ip_tables.c	Tue May 15 18:29:35 2001
+++ working-2.4.7-unclean/net/ipv4/netfilter/ip_tables.c	Sun Jul 29 18:52:33 2001
@@ -1730,9 +1730,15 @@
 	}
 
 #ifdef CONFIG_PROC_FS
-	if (!proc_net_create("ip_tables_names", 0, ipt_get_tables)) {
+	{
+	struct proc_dir_entry *proc;
+
+	proc = proc_net_create("ip_tables_names", 0, ipt_get_tables);
+	if (!proc) {
 		nf_unregister_sockopt(&ipt_sockopts);
 		return -ENOMEM;
+	}
+	proc->owner = THIS_MODULE;
 	}
 #endif
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/net/ipv4/netfilter/ipchains_core.c working-2.4.7-unclean/net/ipv4/netfilter/ipchains_core.c
--- linux-2.4.7-official/net/ipv4/netfilter/ipchains_core.c	Fri Apr 13 05:11:39 2001
+++ working-2.4.7-unclean/net/ipv4/netfilter/ipchains_core.c	Sun Jul 29 18:56:20 2001
@@ -74,6 +74,7 @@
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/module.h>
 
 #include <linux/socket.h>
 #include <linux/sockios.h>
@@ -1100,9 +1101,9 @@
 {
 	unsigned int i;
 	struct ip_chain *label
-		= kmalloc(SIZEOF_STRUCT_IP_CHAIN, GFP_KERNEL);
+		= kmalloc(SIZEOF_STRUCT_IP_CHAIN, GFP_ATOMIC);
 	if (label == NULL)
-		panic("Can't kmalloc for firewall chains.\n");
+		return NULL;
 	strcpy(label->label,name);
 	label->next = NULL;
 	label->chain = NULL;
@@ -1140,7 +1141,7 @@
 					      * user defined chain *
 					      * and therefore can be
 					      * deleted */
-	return 0;
+	return tmp->next ? 0 : ENOMEM;
 }
 
 /* This function simply changes the policy on one of the built in
@@ -1706,11 +1707,10 @@
 
 int ipfw_init_or_cleanup(int init)
 {
+	struct proc_dir_entry *proc;
 	int ret = 0;
 	unsigned long flags;
 
-	FWC_WRITE_LOCK_IRQ(&ip_fw_lock, flags);
-
 	if (!init) goto cleanup;
 
 #ifdef DEBUG_IP_FIREWALL_LOCKING
@@ -1727,17 +1727,24 @@
 	if (ret < 0)
 		goto cleanup_netlink;
 
-	proc_net_create(IP_FW_PROC_CHAINS, S_IFREG | S_IRUSR | S_IWUSR, ip_chain_procinfo);
-	proc_net_create(IP_FW_PROC_CHAIN_NAMES, S_IFREG | S_IRUSR | S_IWUSR, ip_chain_name_procinfo);
+	proc = proc_net_create(IP_FW_PROC_CHAINS, S_IFREG | S_IRUSR | S_IWUSR,
+			       ip_chain_procinfo);
+	if (proc) proc->owner = THIS_MODULE;
+	proc = proc_net_create(IP_FW_PROC_CHAIN_NAMES,
+			       S_IFREG | S_IRUSR | S_IWUSR,
+			       ip_chain_name_procinfo);
+	if (proc) proc->owner = THIS_MODULE;
 
 	IP_FW_INPUT_CHAIN = ip_init_chain(IP_FW_LABEL_INPUT, 1, FW_ACCEPT);
 	IP_FW_FORWARD_CHAIN = ip_init_chain(IP_FW_LABEL_FORWARD, 1, FW_ACCEPT);
 	IP_FW_OUTPUT_CHAIN = ip_init_chain(IP_FW_LABEL_OUTPUT, 1, FW_ACCEPT);
 
-	FWC_WRITE_UNLOCK_IRQ(&ip_fw_lock, flags);
 	return ret;
 
  cleanup:
+	unregister_firewall(PF_INET, &ipfw_ops);
+
+	FWC_WRITE_LOCK_IRQ(&ip_fw_lock, flags);
 	while (ip_fw_chains) {
 		struct ip_chain *next = ip_fw_chains->next;
 
@@ -1745,18 +1752,16 @@
 		kfree(ip_fw_chains);
 		ip_fw_chains = next;
 	}
+	FWC_WRITE_UNLOCK_IRQ(&ip_fw_lock, flags);
 
 	proc_net_remove(IP_FW_PROC_CHAINS);
 	proc_net_remove(IP_FW_PROC_CHAIN_NAMES);
 
-	unregister_firewall(PF_INET, &ipfw_ops);
-
  cleanup_netlink:
 #if defined(CONFIG_NETLINK_DEV) || defined(CONFIG_NETLINK_DEV_MODULE)
 	sock_release(ipfwsk->socket);
 
  cleanup_nothing:
 #endif
-	FWC_WRITE_UNLOCK_IRQ(&ip_fw_lock, flags);
 	return ret;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/net/ipv4/netfilter/ipfwadm_core.c working-2.4.7-unclean/net/ipv4/netfilter/ipfwadm_core.c
--- linux-2.4.7-official/net/ipv4/netfilter/ipfwadm_core.c	Sat Jul  7 07:49:55 2001
+++ working-2.4.7-unclean/net/ipv4/netfilter/ipfwadm_core.c	Sun Jul 29 18:59:08 2001
@@ -3,6 +3,7 @@
 */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #define CONFIG_IP_FIREWALL
 #define CONFIG_IP_FIREWALL_VERBOSE
 #define CONFIG_IP_MASQUERADE
@@ -1358,6 +1359,7 @@
 
 int ipfw_init_or_cleanup(int init)
 {
+	struct proc_dir_entry *proc;
 	int ret = 0;
 
 	if (!init)
@@ -1368,11 +1370,15 @@
 		goto cleanup_nothing;
 
 #ifdef CONFIG_IP_ACCT
-	proc_net_create("ip_acct", S_IFREG | S_IRUGO | S_IWUSR, ip_acct_procinfo);
+	proc = proc_net_create("ip_acct", S_IFREG | S_IRUGO | S_IWUSR, ip_acct_procinfo);
+	if (proc) proc->owner = THIS_MODULE;
 #endif
-	proc_net_create("ip_input", S_IFREG | S_IRUGO | S_IWUSR, ip_fw_in_procinfo);
-	proc_net_create("ip_output", S_IFREG | S_IRUGO | S_IWUSR, ip_fw_out_procinfo);
-	proc_net_create("ip_forward", S_IFREG | S_IRUGO | S_IWUSR, ip_fw_fwd_procinfo);
+	proc = proc_net_create("ip_input", S_IFREG | S_IRUGO | S_IWUSR, ip_fw_in_procinfo);
+	if (proc) proc->owner = THIS_MODULE;
+	proc = proc_net_create("ip_output", S_IFREG | S_IRUGO | S_IWUSR, ip_fw_out_procinfo);
+	if (proc) proc->owner = THIS_MODULE;
+	proc = proc_net_create("ip_forward", S_IFREG | S_IRUGO | S_IWUSR, ip_fw_fwd_procinfo);
+	if (proc) proc->owner = THIS_MODULE;
 
 	/* Register for device up/down reports */
 	register_netdevice_notifier(&ipfw_dev_notifier);
@@ -1383,6 +1389,7 @@
 	return ret;
 
  cleanup:
+	unregister_firewall(PF_INET, &ipfw_ops);
 #ifdef CONFIG_IP_FIREWALL_NETLINK
 	sock_release(ipfwsk->socket);
 #endif
@@ -1399,8 +1406,6 @@
 	free_fw_chain(chains[IP_FW_IN]);
 	free_fw_chain(chains[IP_FW_OUT]);
 	free_fw_chain(chains[IP_FW_ACCT]);
-
-	unregister_firewall(PF_INET, &ipfw_ops);
 
  cleanup_nothing:
 	return ret;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/net/ipv4/netfilter/ipt_unclean.c working-2.4.7-unclean/net/ipv4/netfilter/ipt_unclean.c
--- linux-2.4.7-official/net/ipv4/netfilter/ipt_unclean.c	Sun Jul 22 13:13:27 2001
+++ working-2.4.7-unclean/net/ipv4/netfilter/ipt_unclean.c	Mon Jul 23 18:29:11 2001
@@ -331,6 +331,7 @@
 	tcpflags = ((u_int8_t *)tcph)[13];
 	if (tcpflags != TH_SYN
 	    && tcpflags != (TH_SYN|TH_ACK)
+	    && tcpflags != TH_RST
 	    && tcpflags != (TH_RST|TH_ACK)
 	    && tcpflags != (TH_RST|TH_ACK|TH_PUSH)
 	    && tcpflags != (TH_FIN|TH_ACK)
