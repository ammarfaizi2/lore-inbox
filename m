Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268094AbUHKQVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268094AbUHKQVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUHKQVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:21:53 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7350 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S268094AbUHKQTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:19:41 -0400
Date: Wed, 11 Aug 2004 21:52:12 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@muc.de, akpm@osdl.org,
       suparna@in.ibm.com, shemminger@osdl.org
Cc: prasanna@in.ibm.com
Subject: [4/4] Network packet tracer module using kprobes interface.
Message-ID: <20040811162212.GF24460@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Below is [4/4]kprobes-netptk-tracer-268-rc4.patch

This patch provides network packet tracing feature using kernel
space probes mechanism, which is efficient for dynamic tracing. Network
packet traceing allows you to see the network packets while moving up
and down the stack.
	Network packet tracing was suggested by Andi Kleen.
To trace the network packets based on source and target ports, insert the
module with source and target ports.
        Example insmod netpktlog.ko netpktlog=@62333,254
To trace the network packets based on only source port, insert module
with source port.
        Example insmod netpktlog.ko netpktlog=@62333,
To trace network packets based on target port, insert module with
target port.
        Example insmod netpktlog.ko netpktlog=@,254

Your comments are welcome!

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kprobes-netptk-tracer-268-rc4.patch"


	This patch provides network packet tracing feature using kernel
space probes mechanism, which is efficient for dynamic tracing. Network 
packet traceing allows you to see the network packets while moving up 
and down the stack.
To trace the network packets based on source and target ports, insert the
module with source and target ports.
	Example insmod netpktlog.ko netpktlog=@62333,254
To trace the network packets based on only source port, insert module
with source port.
	Example insmod netpktlog.ko netpktlog=@62333,
To trace network packets based on target port, insert module with
target port.
	Example insmod netpktlog.ko netpktlog=@,254

---

---

---

---

 linux-2.6.8-rc4-prasanna/drivers/net/Kconfig                    |   12 
 linux-2.6.8-rc4-prasanna/drivers/net/Makefile                   |    3 
 linux-2.6.8-rc4-prasanna/include/linux/netfilter_ipv4/ipt_LOG.h |    2 
 linux-2.6.8-rc4-prasanna/kernel/kallsyms.c                      |    1 
 linux-2.6.8-rc4-prasanna/net/ipv4/netfilter/ipt_LOG.c           |    3 



---

 linux-2.6.8-rc4-prasanna/drivers/net/Kconfig                    |   12 
 linux-2.6.8-rc4-prasanna/drivers/net/Makefile                   |    3 
 linux-2.6.8-rc4-prasanna/drivers/net/netpktlog.c                |  216 ++++++++++
 linux-2.6.8-rc4-prasanna/include/linux/netfilter_ipv4/ipt_LOG.h |    2 
 linux-2.6.8-rc4-prasanna/include/linux/netpktlog.h              |  114 +++++
 linux-2.6.8-rc4-prasanna/kernel/kallsyms.c                      |    1 
 linux-2.6.8-rc4-prasanna/net/ipv4/netfilter/ipt_LOG.c           |    3 
 7 files changed, 350 insertions(+), 1 deletion(-)

diff -puN drivers/net/Kconfig~kprobes-netptk-tracer-268-rc4 drivers/net/Kconfig
--- linux-2.6.8-rc4/drivers/net/Kconfig~kprobes-netptk-tracer-268-rc4	2004-08-11 21:02:39.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/drivers/net/Kconfig	2004-08-11 21:02:39.000000000 +0530
@@ -2598,3 +2598,15 @@ config NETCONSOLE
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
+
diff -puN drivers/net/Makefile~kprobes-netptk-tracer-268-rc4 drivers/net/Makefile
--- linux-2.6.8-rc4/drivers/net/Makefile~kprobes-netptk-tracer-268-rc4	2004-08-11 21:02:39.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/drivers/net/Makefile	2004-08-11 21:02:39.000000000 +0530
@@ -191,3 +191,6 @@ obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
 
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+ifeq ($(CONFIG_NETPKTLOG),y)
+ obj-m += netpktlog.o
+endif
diff -puN /dev/null drivers/net/netpktlog.c
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/drivers/net/netpktlog.c	2004-08-11 21:03:13.000000000 +0530
@@ -0,0 +1,216 @@
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
+#include <linux/kallsyms.h>
+
+static char config[256];
+static unsigned short src_port, tgt_port;
+module_param_string(netpktlog, config, 256, 0);
+MODULE_PARM_DESC(netpktlog, " netpktlog=@<source-port>,<target-port>\n");
+
+#include <linux/netpktlog.h>
+
+/*
+ * Compile the kernel with options CONFIG_KPROBES, CONFIG_NETPKTLOG,
+ * CONFIG_NETFILTER, CONFIG_IP_NF_IPTABLES and CONFIG_IP_NF_TARGET_LOG enabled.
+ * You need to specify the parameters to the netpktlog module.
+ * To trace the network packets based on source and target ports, insert the
+ * module with source and target ports.
+ *	Example insmod netpktlog.ko netpktlog=@62333,254
+ * To trace the network packets based on only source port, insert module
+ * with source port. Example insmod netpktlog.ko netpktlog=@62333,
+ * To trace network packets based on target port, insert module with
+ * target port.	Example insmod netpktlog.ko netpktlog=@,254
+ */
+
+static void jnetif_rx(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+}
+
+static void j__kfree_skb(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+}
+
+static int jnetif_receive_skb(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	return 0;
+}
+
+static int jip_rcv(struct sk_buff *skb, struct net_device *dev,
+		   struct packet_type *pt)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	return 0;
+}
+
+static int jip_local_deliver(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	return 0;
+}
+
+static int jip_queue_xmit(struct sk_buff *skb, int ipfragok)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	return 0;
+}
+
+static int jip_output(struct sk_buff **pskb)
+{
+	netfilter_ip(*pskb);
+	jprobe_return();
+	return 0;
+}
+
+static int jtcp_v4_rcv(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	return 0;
+}
+
+static int jtcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	return 0;
+}
+
+static int jtcp_rcv_established(struct sock *sk, struct sk_buff *skb,
+				struct tcphdr *th, unsigned len)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	return 0;
+}
+
+static int jskb_copy_datagram_iovec(struct sk_buff *from, int offset,
+				    struct iovec *to, int size)
+{
+	netfilter_ip(from);
+	jprobe_return();
+	return 0;
+}
+
+static void jtcp_send_dupack(struct sock *sk, struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+}
+
+static int jip_forward(struct sk_buff *skb)
+{
+	netfilter_ip(skb);
+	jprobe_return();
+	return 0;
+}
+
+static char *nettrace_routines[] = {
+	"netif_rx",
+	"__kfree_skb",
+	"netif_receive_skb",
+	"ip_rcv",
+	"ip_local_deliver",
+	"ip_queue_xmit",
+	"ip_output",
+	"ip_forward",
+	"tcp_v4_rcv",
+	"tcp_v4_do_rcv",
+	"tcp_rcv_established",
+	"skb_copy_datagram_iovec",
+	"tcp_send_dupack"
+};
+static struct jprobe netpkt[] = {
+	{
+	 .entry = (kprobe_opcode_t *) jnetif_rx},
+	{
+	 .entry = (kprobe_opcode_t *) j__kfree_skb},
+	{
+	 .entry = (kprobe_opcode_t *) jnetif_receive_skb},
+	{
+	 .entry = (kprobe_opcode_t *) jip_rcv},
+	{
+	 .entry = (kprobe_opcode_t *) jip_local_deliver},
+	{
+	 .entry = (kprobe_opcode_t *) jip_queue_xmit},
+	{
+	 .entry = (kprobe_opcode_t *) jip_output},
+	{
+	 .entry = (kprobe_opcode_t *) jip_forward},
+	{
+	 .entry = (kprobe_opcode_t *) jtcp_v4_rcv},
+	{
+	 .entry = (kprobe_opcode_t *) jtcp_v4_do_rcv},
+	{
+	 .entry = (kprobe_opcode_t *) jtcp_rcv_established},
+	{
+	 .entry = (kprobe_opcode_t *) jskb_copy_datagram_iovec},
+	{
+	 .entry = (kprobe_opcode_t *) jtcp_send_dupack}
+};
+
+static int init_netpktlog(void)
+{
+	int i;
+	if (strlen(config))
+		option_setup(config);
+
+	/* first time invokation to initialize probe handler */
+	/* now we are all set to register the probe */
+	for (i = 0; i < MAX_NETPKT_ROUTINE; i++) {
+		netpkt[i].kp.addr =
+		    (kprobe_opcode_t *)
+		    kallsyms_lookup_name(nettrace_routines[i]);
+		printk("plant jprobe at %p, handler addr %p\n",
+		       netpkt[i].kp.addr, netpkt[i].entry);
+		register_jprobe(&netpkt[i]);
+	}
+
+	printk("Network packets tracing is enabled...\n");
+	return 0;
+}
+
+static void cleanup_netpktlog(void)
+{
+	int i;
+	for (i = 0; i < MAX_NETPKT_ROUTINE; i++)
+		unregister_jprobe(&netpkt[i]);
+	printk("Network packets tracing is disabled...\n");
+}
+
+module_init(init_netpktlog);
+module_exit(cleanup_netpktlog);
+MODULE_LICENSE("GPL");
diff -puN include/linux/netfilter_ipv4/ipt_LOG.h~kprobes-netptk-tracer-268-rc4 include/linux/netfilter_ipv4/ipt_LOG.h
--- linux-2.6.8-rc4/include/linux/netfilter_ipv4/ipt_LOG.h~kprobes-netptk-tracer-268-rc4	2004-08-11 21:02:39.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/include/linux/netfilter_ipv4/ipt_LOG.h	2004-08-11 21:02:39.000000000 +0530
@@ -11,5 +11,7 @@ struct ipt_log_info {
 	unsigned char logflags;
 	char prefix[30];
 };
+void dump_packet(const struct ipt_log_info *info, const struct sk_buff *skb,
+			unsigned int iphoff);
 
 #endif /*_IPT_LOG_H*/
diff -puN /dev/null include/linux/netpktlog.h
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/include/linux/netpktlog.h	2004-08-11 21:02:39.000000000 +0530
@@ -0,0 +1,114 @@
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
+#include <net/udp.h>
+
+void tcp_send_dupack(struct sock *sk, struct sk_buff *skb);
+#define MAX_NETPKT_ROUTINE (sizeof(netpkt)/sizeof(struct jprobe))
+
+static inline void option_setup(char *opt)
+{
+	char *cur = opt, *delim;
+
+	if (*cur != '@') {
+		printk("Wrong format\n");
+		return;
+	}
+	cur++;
+	if ((delim = strchr(cur, ',')) == NULL) {
+		printk("No ipaddress found\n");
+		return;
+	}
+	*delim = 0;
+	src_port = in_aton(cur);
+	delim++;
+	tgt_port = in_aton(delim);
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
+	struct tcphdr *tcph;
+	struct udphdr *udph;
+	/* Log IP options */
+	info.logflags = IPT_LOG_IPOPT;
+
+	/*
+	 * Check if the protocol is IP before dumping the packet.
+	 */
+	if (skb->protocol == htons(ETH_P_IP)) {
+		iph = (struct iphdr *)skb->nh.iph;
+
+		if (iph == NULL)
+			return;
+		switch (iph->protocol) {
+		case IPPROTO_TCP:{
+				tcph = (struct tcphdr *)(unsigned long)iph
+				    + iph->ihl * 4;
+				if ((src_port == 0
+				     && ntohs(tcph->dest) == tgt_port)
+				    || (tgt_port == 0
+					&& ntohs(tcph->source) == src_port)
+				    || (ntohs(tcph->source) == src_port
+					&& ntohs(tcph->dest) == tgt_port)) {
+					dump_packet((struct ipt_log_info *)
+						    &info, skb, 0);
+					printk("\n");
+				}
+				break;
+			}
+		case IPPROTO_UDP:{
+				udph = (struct udphdr *)(unsigned long)iph
+				    + iph->ihl * 4;
+				if ((src_port == 0
+				     && ntohs(udph->dest) == tgt_port)
+				    || (tgt_port == 0
+					&& ntohs(udph->source) == src_port)
+				    || (ntohs(udph->source) == src_port
+					&& ntohs(udph->dest) == tgt_port)) {
+					dump_packet((struct ipt_log_info *)
+						    &info, skb, 0);
+					printk("\n");
+				}
+				break;
+			}
+		default:
+			break;
+		}
+	}
+}
diff -puN kernel/kallsyms.c~kprobes-netptk-tracer-268-rc4 kernel/kallsyms.c
--- linux-2.6.8-rc4/kernel/kallsyms.c~kprobes-netptk-tracer-268-rc4	2004-08-11 21:02:39.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/kernel/kallsyms.c	2004-08-11 21:02:39.000000000 +0530
@@ -310,3 +310,4 @@ int __init kallsyms_init(void)
 __initcall(kallsyms_init);
 
 EXPORT_SYMBOL(__print_symbol);
+EXPORT_SYMBOL(kallsyms_lookup_name);
diff -puN net/ipv4/netfilter/ipt_LOG.c~kprobes-netptk-tracer-268-rc4 net/ipv4/netfilter/ipt_LOG.c
--- linux-2.6.8-rc4/net/ipv4/netfilter/ipt_LOG.c~kprobes-netptk-tracer-268-rc4	2004-08-11 21:02:39.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/net/ipv4/netfilter/ipt_LOG.c	2004-08-11 21:02:39.000000000 +0530
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(nflog, "register as int
 static spinlock_t log_lock = SPIN_LOCK_UNLOCKED;
 
 /* One level of recursion won't kill us */
-static void dump_packet(const struct ipt_log_info *info,
+void dump_packet(const struct ipt_log_info *info,
 			const struct sk_buff *skb,
 			unsigned int iphoff)
 {
@@ -461,5 +461,6 @@ static void __exit fini(void)
 	ipt_unregister_target(&ipt_log_reg);
 }
 
+EXPORT_SYMBOL_GPL(dump_packet);
 module_init(init);
 module_exit(fini);

_

--GyRA7555PLgSTuth--
