Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUHEKJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUHEKJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUHEKJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:09:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:27833 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267619AbUHEKJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:09:00 -0400
Date: Thu, 5 Aug 2004 15:41:43 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@muc.de, akpm@osdl.org,
       suparna@in.ibm.com
Subject: [3/3] kprobes-netpktlog-268-rc3.patch
Message-ID: <20040805101143.GC2303@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Below is the [3/3] kprobes-netpktlog-268-rc3.patch

This patch provides network packet tracing using source and destination IP by
trapping at various routines in the network stack.It demonstrates how
a packet travels through the network stack, as suggested by Andi Kleen.

Usage: 
	Compile the kernel with options CONFIG_KPROBES, CONFIG_NETPKTLOG,
CONFIG_NETFILTER, CONFIG_IP_NF_IPTABLES and CONFIG_IP_NF_TARGET_LOG enabled.
You need to specify the parameters to the netpktlog module.
To filter packets based on source and target ip, insert the module with
source and target ip.
	$insmod netpktlog.ko netpktlog=@9.182.15.133,9.182.15.188
To filter packets based on only source ip, insert module with source ip.
	$insmod netpktlog.ko netpktlog=@9.182.15.133,
To filter packets based on target ip, insert module with target ip.
	$insmod netpktlog.ko netpktlog=@,9.182.15.188


Please see the description of the patch for more details.

Your comments are welcome!


Thanks
prasanna

-- 
Have a Nice Day!

Thanks & Regards
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kprobes-netpktlog-268-rc3.patch"



This patch provides network packet tracing using source and destination IP by
trapping at various routines in the network stack. It demonstrates how
a packet travels through the network stack, as suggested by Andi Kleen.

---



---


diff -puN drivers/net/Kconfig~kprobes-netpktlog-268-rc3 drivers/net/Kconfig
--- linux-2.6.8-rc3/drivers/net/Kconfig~kprobes-netpktlog-268-rc3	2004-08-06 04:41:40.945715952 -0700
+++ linux-2.6.8-rc3-root/drivers/net/Kconfig	2004-08-06 04:42:27.301668776 -0700
@@ -2598,3 +2598,16 @@ config NETCONSOLE
 	If you want to log kernel messages over the network, enable this.
 	See Documentation/networking/netconsole.txt for details.
 
+config NETPKTLOG
+	tristate "Network packet Tracer using kernel probes(EXPERIMENTAL)"
+	depends on KPROBES && IP_NF_TARGET_LOG
+	---help---
+	Network packet tracering is achived using kernel probes allowing you
+	to see the network packets while moving up and down the stack. This
+	module uses kprobes mechanism which is highly efficient for dynamic
+	tracing.
+
+	See driver/net/netpktlog.c for details.
+	To compile this driver as a module, choose M.If unsure, say N.
+	This driver will be always compiled as kernel module.
+
diff -puN drivers/net/Makefile~kprobes-netpktlog-268-rc3 drivers/net/Makefile
--- linux-2.6.8-rc3/drivers/net/Makefile~kprobes-netpktlog-268-rc3	2004-08-06 04:41:40.949715344 -0700
+++ linux-2.6.8-rc3-root/drivers/net/Makefile	2004-08-06 04:41:40.988709416 -0700
@@ -191,3 +191,7 @@ obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
 
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+ifeq ($(CONFIG_NETPKTLOG),y)
+ obj-m += netpktlog.o
+endif
+
diff -puN /dev/null drivers/net/netpktlog.c
--- /dev/null	2004-06-16 06:40:55.000000000 -0700
+++ linux-2.6.8-rc3-root/drivers/net/netpktlog.c	2004-08-06 04:41:40.989709264 -0700
@@ -0,0 +1,237 @@
+/*
+ *  Network Packet Tracer using Kernel Probes (KProbes)
+ *  net/driver/netpktlog.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2004
+ *
+ * 2004-Aug	Created by Prasanna S Panchamukhi <prasanna@in.ibm.com>
+ *		for network packet tracing using kernel probes interface.
+ * 		Suggested by Andi Kleen.
+ *
+ */
+#include <linux/module.h>
+#include <linux/kprobes.h>
+
+static char config[256];
+static unsigned long src_ip, tgt_ip;
+module_param_string(netpktlog, config, 256, 0);
+MODULE_PARM_DESC(netpktlog, " netpktlog=@<source-ip>,<target-ip>\n");
+
+#include <linux/netpktlog.h>
+
+/*
+ * Compile the kernel with options CONFIG_KPROBES, CONFIG_NETPKTLOG,
+ * CONFIG_NETFILTER, CONFIG_IP_NF_IPTABLES and CONFIG_IP_NF_TARGET_LOG enabled.
+ * You need to specify the parameters to the netpktlog module.
+ * To filter packets based on source and target ip, insert the module with
+ * source and target ip.
+ * 	Example insmod netpktlog.ko netpktlog=@9.182.15.133,9.182.15.188
+ * To filter packets based on only source ip, insert module with source ip.
+ * 	Example insmod netpktlog.ko netpktlog=@9.182.15.133,
+ * To filter packets based on target ip, insert module with target ip.
+ * 	Example insmod netpktlog.ko netpktlog=@,9.182.15.188
+ */
+
+static void jnetif_rx(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+}
+
+static void j__kfree_skb(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+}
+
+static int jnetif_receive_skb(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+	return 0;
+}
+
+static int jip_rcv(struct sk_buff *skb, struct net_device *dev,
+		struct packet_type *pt)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+	return 0;
+}
+
+static int jip_local_deliver(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+	return 0;
+}
+
+static int jip_queue_xmit(struct sk_buff *skb, int ipfragok)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+	return 0;
+}
+
+static int jip_output(struct sk_buff **pskb)
+{
+	netfilter_ip(*pskb);
+	jprobe_return();
+	/*No tailcalls please */
+	return 0;
+}
+
+static int jtcp_v4_rcv(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+	return 0;
+}
+
+static int jtcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+	return 0;
+}
+
+static int jtcp_rcv_established(struct sock *sk, struct sk_buff *skb,
+			struct tcphdr *th, unsigned len)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+	return 0;
+}
+
+static int jskb_copy_datagram_iovec(struct sk_buff *from, int offset,
+			struct iovec *to, int size)
+{
+	netfilter_ip(from);
+	jprobe_return();
+	/*No tailcalls please */
+	return 0;
+}
+
+static void jtcp_send_dupack(struct sock *sk, struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+}
+
+static int jip_forward(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	/*No tailcalls please */
+	return 0;
+}
+
+static struct jprobe netpkt[] = {
+	{
+		{.addr = (kprobe_opcode_t *) netif_rx},
+		.entry = (kprobe_opcode_t *) jnetif_rx
+	},
+	{
+		{.addr = (kprobe_opcode_t *) __kfree_skb},
+		.entry = (kprobe_opcode_t *) j__kfree_skb
+	},
+	{
+		{.addr = (kprobe_opcode_t *) netif_receive_skb},
+		.entry = (kprobe_opcode_t *) jnetif_receive_skb
+	},
+	{
+		{.addr = (kprobe_opcode_t *) ip_rcv},
+		.entry = (kprobe_opcode_t *) jip_rcv
+	},
+	{
+		{.addr = (kprobe_opcode_t *) ip_local_deliver},
+		.entry = (kprobe_opcode_t *) jip_local_deliver
+	},
+	{
+		{.addr = (kprobe_opcode_t *) ip_queue_xmit},
+		.entry = (kprobe_opcode_t *) jip_queue_xmit
+	},
+	{
+		{.addr = (kprobe_opcode_t *) ip_output},
+		.entry = (kprobe_opcode_t *) jip_output
+	},
+	{
+		{.addr = (kprobe_opcode_t *) ip_forward},
+		.entry = (kprobe_opcode_t *) jip_forward
+	},
+	{
+		{.addr = (kprobe_opcode_t *) tcp_v4_rcv},
+		.entry = (kprobe_opcode_t *) jtcp_v4_rcv
+	},
+	{
+		{.addr = (kprobe_opcode_t *) tcp_v4_do_rcv},
+		.entry = (kprobe_opcode_t *) jtcp_v4_do_rcv
+	},
+	{
+		{.addr = (kprobe_opcode_t *) tcp_rcv_established},
+		.entry = (kprobe_opcode_t *) jtcp_rcv_established
+	},
+	{
+		{.addr = (kprobe_opcode_t *) skb_copy_datagram_iovec},
+		.entry = (kprobe_opcode_t *) jskb_copy_datagram_iovec
+	},
+	{
+		{.addr = (kprobe_opcode_t *) tcp_send_dupack},
+		.entry = (kprobe_opcode_t *) jtcp_send_dupack
+	}
+
+};
+
+static int init_netpktlog(void)
+{
+	int i;
+	if (strlen(config))
+		option_setup(config);
+
+        /* first time invokation to initialize probe handler */
+        /* now we are all set to register the probe */
+	for (i = 0;i < MAX_NETPKT_ROUTINE; i++) {
+        	printk("plant jprobe at %p, handler addr %p\n",
+			netpkt[i].kp.addr, netpkt[i].entry);
+        	register_jprobe(&netpkt[i]);
+	}
+
+	printk("Filtering of network packets enabled...\n");
+	return 0;
+}
+
+static void cleanup_netpktlog(void)
+{
+	int i;
+	for (i = 0;i < MAX_NETPKT_ROUTINE; i++)
+		unregister_jprobe(&netpkt[i]);
+	printk("Filtering of network packets disabled...\n");
+}
+
+module_init(init_netpktlog);
+module_exit(cleanup_netpktlog);
+MODULE_LICENSE("GPL");
diff -puN /dev/null include/linux/netpktlog.h
--- /dev/null	2004-06-16 06:40:55.000000000 -0700
+++ linux-2.6.8-rc3-root/include/linux/netpktlog.h	2004-08-06 04:41:40.990709112 -0700
@@ -0,0 +1,87 @@
+/*
+ *  Network Packet Tracer using Kernel Probes (KProbes)
+ *  include/linux/netpktlog.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2004
+ *
+ * 2004-Aug 	Created by Prasanna S Panchamukhi <prasanna@in.ibm.com>
+ *		for network packet tracing using kernel probes interface.
+ *		Suggested by Andi Kleen.
+ */
+#include <linux/inet.h>
+#include <linux/ip.h>
+#include <linux/netdevice.h>
+#include <linux/netfilter_ipv4/ipt_LOG.h>
+#include <net/ip.h>
+#include <net/tcp.h>
+
+
+void tcp_send_dupack(struct sock *sk, struct sk_buff *skb);
+#define MAX_NETPKT_ROUTINE (sizeof(netpkt)/sizeof(struct jprobe))
+
+static inline void option_setup(char *opt)
+{
+	char *cur = opt, *delim;
+
+	if (*cur != '@')
+	{
+		printk("Wrong format\n");
+		return;
+	}
+	cur++;
+	if ((delim = strchr(cur, ',')) == NULL)
+	{
+		printk("No ipaddress found\n");
+		return;
+	}
+	*delim = 0;
+	src_ip = in_aton(cur);
+	delim++;
+	tgt_ip = in_aton(delim);
+}
+
+/*
+ * netfilter_ip: This is a generic routine that can be used to dump the
+ * network packet for a given source and destination ip address.
+ * Network packet filtering is done based on source/target ip or both source and
+ * target ip.
+ */
+
+static inline void netfilter_ip(struct sk_buff *skb)
+{
+	struct ipt_log_info info;
+	struct iphdr *iph;
+	/* Log IP options */
+	info.logflags = IPT_LOG_IPOPT;
+
+	/*
+	 * Check if the protocol is IP before dumping the packet.
+	 */
+	if (skb->protocol == htons(ETH_P_IP) )
+	{
+		iph = (struct iphdr *) skb->data;
+
+		if ((src_ip == 0 && iph->daddr == tgt_ip)
+			|| (tgt_ip == 0 && iph->saddr == src_ip)
+			|| (iph->saddr == src_ip && iph->daddr == tgt_ip))
+		{
+
+			dump_packet((struct ipt_log_info *)&info, skb, 0);
+			printk("\n");
+		}
+	}
+}
diff -puN net/ipv4/ip_forward.c~kprobes-netpktlog-268-rc3 net/ipv4/ip_forward.c
--- linux-2.6.8-rc3/net/ipv4/ip_forward.c~kprobes-netpktlog-268-rc3	2004-08-06 04:41:40.955714432 -0700
+++ linux-2.6.8-rc3-root/net/ipv4/ip_forward.c	2004-08-06 04:41:40.991708960 -0700
@@ -125,3 +125,4 @@ drop:
 	kfree_skb(skb);
 	return NET_RX_DROP;
 }
+EXPORT_SYMBOL(ip_forward);
diff -puN net/ipv4/ip_input.c~kprobes-netpktlog-268-rc3 net/ipv4/ip_input.c
--- linux-2.6.8-rc3/net/ipv4/ip_input.c~kprobes-netpktlog-268-rc3	2004-08-06 04:41:40.959713824 -0700
+++ linux-2.6.8-rc3-root/net/ipv4/ip_input.c	2004-08-06 04:41:40.991708960 -0700
@@ -431,3 +431,4 @@ out:
 
 EXPORT_SYMBOL(ip_rcv);
 EXPORT_SYMBOL(ip_statistics);
+EXPORT_SYMBOL(ip_local_deliver);
diff -puN net/ipv4/ip_output.c~kprobes-netpktlog-268-rc3 net/ipv4/ip_output.c
--- linux-2.6.8-rc3/net/ipv4/ip_output.c~kprobes-netpktlog-268-rc3	2004-08-06 04:41:40.963713216 -0700
+++ linux-2.6.8-rc3-root/net/ipv4/ip_output.c	2004-08-06 04:41:40.993708656 -0700
@@ -1326,6 +1326,7 @@ EXPORT_SYMBOL(ip_fragment);
 EXPORT_SYMBOL(ip_generic_getfrag);
 EXPORT_SYMBOL(ip_queue_xmit);
 EXPORT_SYMBOL(ip_send_check);
+EXPORT_SYMBOL(ip_output);
 
 #ifdef CONFIG_SYSCTL
 EXPORT_SYMBOL(sysctl_ip_default_ttl);
diff -puN net/ipv4/tcp_input.c~kprobes-netpktlog-268-rc3 net/ipv4/tcp_input.c
--- linux-2.6.8-rc3/net/ipv4/tcp_input.c~kprobes-netpktlog-268-rc3	2004-08-06 04:41:40.969712304 -0700
+++ linux-2.6.8-rc3-root/net/ipv4/tcp_input.c	2004-08-06 04:41:41.000707592 -0700
@@ -3229,7 +3229,7 @@ static __inline__ void tcp_dsack_extend(
 		tcp_sack_extend(tp->duplicate_sack, seq, end_seq);
 }
 
-static void tcp_send_dupack(struct sock *sk, struct sk_buff *skb)
+void tcp_send_dupack(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_opt *tp = tcp_sk(sk);
 
@@ -4864,3 +4864,4 @@ EXPORT_SYMBOL(tcp_cwnd_application_limit
 EXPORT_SYMBOL(tcp_parse_options);
 EXPORT_SYMBOL(tcp_rcv_established);
 EXPORT_SYMBOL(tcp_rcv_state_process);
+EXPORT_SYMBOL(tcp_send_dupack);
diff -puN net/ipv4/tcp_ipv4.c~kprobes-netpktlog-268-rc3 net/ipv4/tcp_ipv4.c
--- linux-2.6.8-rc3/net/ipv4/tcp_ipv4.c~kprobes-netpktlog-268-rc3	2004-08-06 04:41:40.974711544 -0700
+++ linux-2.6.8-rc3-root/net/ipv4/tcp_ipv4.c	2004-08-06 04:41:41.004706984 -0700
@@ -2646,6 +2646,7 @@ EXPORT_SYMBOL(tcp_v4_rebuild_header);
 EXPORT_SYMBOL(tcp_v4_remember_stamp);
 EXPORT_SYMBOL(tcp_v4_send_check);
 EXPORT_SYMBOL(tcp_v4_syn_recv_sock);
+EXPORT_SYMBOL(tcp_v4_rcv);
 
 #ifdef CONFIG_PROC_FS
 EXPORT_SYMBOL(tcp_proc_register);

_

--7qSK/uQB79J36Y4o--
