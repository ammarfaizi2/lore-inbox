Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267699AbUHPQB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267699AbUHPQB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbUHPQB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:01:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:4251 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267699AbUHPPzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:55:01 -0400
Date: Mon, 16 Aug 2004 21:25:39 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: [4/4] Network packet tracer module using kprobes interface.
Message-ID: <20040816155539.GA18652@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20040811162212.GF24460@in.ibm.com> <20040812123541.GD2925@in.ibm.com> <20040812132021.GB39944@muc.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20040812132021.GB39944@muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi,

Please find the updated patch below. The patch includes following updates as per 
your suggestions.

1. Module parameters can be modified at runtime using sysfs interface.
2. iph = (struct iphdr *)skb->data; is valid at few routines netif_rx, netif_receive_skb, ip_rcv, ip_local_deliver. Modified to dump packet header accordingly.
3. Other routines dump the network packet header from the skb->nh.iph, skb->h.th, skb->h.uh, skb->h.icmp.
4. IP/TCP header is not initialized at ip_queue_xmit() probe.

Please provide your comments.

Thanks
Prasanna
 

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

This patch  demonistrates network packet tracing for specific source and 
target ports.
Network packet tracing is achived using kernel probes allowing you
to see the network packets while moving up and down the stack. This
module uses kprobes mechanism which is highly efficient for dynamic
tracing.


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kprobes-netpkt-tracer-268-rc4.patch"


---

 linux-2.6.8-rc4-prasanna/drivers/net/Kconfig                    |   12 
 linux-2.6.8-rc4-prasanna/drivers/net/Makefile                   |    3 
 linux-2.6.8-rc4-prasanna/include/linux/netfilter_ipv4/ipt_LOG.h |    2 
 linux-2.6.8-rc4-prasanna/kernel/kallsyms.c                      |    1 
 linux-2.6.8-rc4-prasanna/net/ipv4/netfilter/ipt_LOG.c           |    3 



---

 linux-2.6.8-rc4-prasanna/drivers/net/Kconfig                    |   12 
 linux-2.6.8-rc4-prasanna/drivers/net/Makefile                   |    3 
 linux-2.6.8-rc4-prasanna/drivers/net/netpktlog.c                |  672 ++++++++++
 linux-2.6.8-rc4-prasanna/include/linux/netfilter_ipv4/ipt_LOG.h |    2 
 linux-2.6.8-rc4-prasanna/kernel/kallsyms.c                      |    1 
 linux-2.6.8-rc4-prasanna/net/ipv4/netfilter/ipt_LOG.c           |    3 
 6 files changed, 692 insertions(+), 1 deletion(-)

diff -puN drivers/net/Kconfig~kprobes-netpkt-tracer-268-rc4 drivers/net/Kconfig
--- linux-2.6.8-rc4/drivers/net/Kconfig~kprobes-netpkt-tracer-268-rc4	2004-08-16 20:43:21.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/drivers/net/Kconfig	2004-08-16 20:43:21.000000000 +0530
@@ -2598,3 +2598,15 @@ config NETCONSOLE
 	If you want to log kernel messages over the network, enable this.
 	See Documentation/networking/netconsole.txt for details.
 
+config NETPKTLOG
+	tristate "Network packet Tracer using kernel probes(EXPERIMENTAL)"
+	depends on KPROBES && IP_NF_TARGET_LOG
+	---help---
+	Network packet tracing is achived using kernel probes allowing you
+	to see the network packets while moving up and down the stack. This
+	module uses kprobes mechanism which is highly efficient for dynamic
+	tracing.
+
+	See driver/net/netpktlog.c for details.
+	To compile this driver as a module, choose M.If unsure, say N.
+
diff -puN drivers/net/Makefile~kprobes-netpkt-tracer-268-rc4 drivers/net/Makefile
--- linux-2.6.8-rc4/drivers/net/Makefile~kprobes-netpkt-tracer-268-rc4	2004-08-16 20:43:21.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/drivers/net/Makefile	2004-08-16 20:43:21.000000000 +0530
@@ -191,3 +191,6 @@ obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
 
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+ifeq ($(CONFIG_NETPKTLOG),y)
+ obj-m += netpktlog.o
+endif
diff -puN /dev/null drivers/net/netpktlog.c
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/drivers/net/netpktlog.c	2004-08-16 20:43:35.000000000 +0530
@@ -0,0 +1,672 @@
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
+#include <linux/inet.h>
+#include <linux/ip.h>
+#include <linux/netdevice.h>
+#include <linux/netfilter_ipv4/ipt_LOG.h>
+#include <net/ip.h>
+#include <net/tcp.h>
+#include <net/udp.h>
+#include <net/icmp.h>
+
+static unsigned short source_port, target_port;
+module_param(source_port, ushort, S_IRUSR | S_IWUSR);
+module_param(target_port, ushort, S_IRUSR | S_IWUSR);
+
+void dump_packet_hdr(const struct ipt_log_info *info, struct sk_buff *skb)
+{
+	struct iphdr iph;
+
+	if (memcpy(&iph, skb->nh.iph, sizeof(iph)) < 0) {
+		printk("TRUNCATED");
+		return;
+	}
+
+	/* Important fields:
+	 * TOS, len, DF/MF, fragment offset, TTL, src, dst, options. */
+	/* Max length: 40 "SRC=255.255.255.255 DST=255.255.255.255 " */
+	printk("SRC=%u.%u.%u.%u DST=%u.%u.%u.%u ",
+	       NIPQUAD(iph.saddr), NIPQUAD(iph.daddr));
+
+	/* Max length: 46 "LEN=65535 TOS=0xFF PREC=0xFF TTL=255 ID=65535 " */
+	printk("LEN=%u TOS=0x%02X PREC=0x%02X TTL=%u ID=%u ",
+	       ntohs(iph.tot_len), iph.tos & IPTOS_TOS_MASK,
+	       iph.tos & IPTOS_PREC_MASK, iph.ttl, ntohs(iph.id));
+
+	/* Max length: 6 "CE DF MF " */
+	if (ntohs(iph.frag_off) & IP_CE)
+		printk("CE ");
+	if (ntohs(iph.frag_off) & IP_DF)
+		printk("DF ");
+	if (ntohs(iph.frag_off) & IP_MF)
+		printk("MF ");
+
+	/* Max length: 11 "FRAG:65535 " */
+	if (ntohs(iph.frag_off) & IP_OFFSET)
+		printk("FRAG:%u ", ntohs(iph.frag_off) & IP_OFFSET);
+
+	if ((info->logflags & IPT_LOG_IPOPT)
+	    && iph.ihl * 4 > sizeof(struct iphdr)) {
+		unsigned char opt[4 * 15 - sizeof(struct iphdr)];
+		unsigned int i, optsize;
+
+		optsize = iph.ihl * 4 - sizeof(struct iphdr);
+		if (memcpy(opt, skb->nh.iph + sizeof(iph), optsize) < 0) {
+			printk("TRUNCATED");
+			return;
+		}
+
+		/* Max length: 127 "OPT (" 15*4*2chars ") " */
+		printk("OPT (");
+		for (i = 0; i < optsize; i++)
+			printk("%02X", opt[i]);
+		printk(") ");
+	}
+
+	switch (iph.protocol) {
+	case IPPROTO_TCP:{
+			struct tcphdr tcph;
+
+			/* Max length: 10 "PROTO=TCP " */
+			printk("PROTO=TCP ");
+
+			if (ntohs(iph.frag_off) & IP_OFFSET)
+				break;
+
+			/* Max length: 25 "INCOMPLETE [65535 bytes] " */
+			if (memcpy(&tcph, skb->h.th, sizeof(tcph))
+			    < 0) {
+				printk("INCOMPLETE [%u bytes] ", iph.ihl * 4);
+				break;
+			}
+
+			/* Max length: 20 "SPT=65535 DPT=65535 " */
+			printk("SPT=%u DPT=%u ",
+			       ntohs(tcph.source), ntohs(tcph.dest));
+			/* Max length: 30 "SEQ=4294967295 ACK=4294967295 " */
+			if (info->logflags & IPT_LOG_TCPSEQ)
+				printk("SEQ=%u ACK=%u ",
+				       ntohl(tcph.seq), ntohl(tcph.ack_seq));
+			/* Max length: 13 "WINDOW=65535 " */
+			printk("WINDOW=%u ", ntohs(tcph.window));
+			/* Max length: 9 "RES=0x3F " */
+			printk("RES=0x%02x ",
+			       (u8) (ntohl
+				     (tcp_flag_word(&tcph) & TCP_RESERVED_BITS)
+				     >> 22));
+			/* Max length: 32 "CWR ECE URG ACK PSH RST SYN FIN " */
+			if (tcph.cwr)
+				printk("CWR ");
+			if (tcph.ece)
+				printk("ECE ");
+			if (tcph.urg)
+				printk("URG ");
+			if (tcph.ack)
+				printk("ACK ");
+			if (tcph.psh)
+				printk("PSH ");
+			if (tcph.rst)
+				printk("RST ");
+			if (tcph.syn)
+				printk("SYN ");
+			if (tcph.fin)
+				printk("FIN ");
+			/* Max length: 11 "URGP=65535 " */
+			printk("URGP=%u ", ntohs(tcph.urg_ptr));
+
+			if ((info->logflags & IPT_LOG_TCPOPT)
+			    && tcph.doff * 4 > sizeof(struct tcphdr)) {
+				unsigned char opt[4 * 15 -
+						  sizeof(struct tcphdr)];
+				unsigned int i, optsize;
+
+				optsize = tcph.doff * 4 - sizeof(struct tcphdr);
+				if (memcpy(opt, skb->h.th + sizeof(tcph),
+					   optsize) < 0) {
+					printk("TRUNCATED");
+					return;
+				}
+
+				/* Max length: 127 "OPT (" 15*4*2chars ") " */
+				printk("OPT (");
+				for (i = 0; i < optsize; i++)
+					printk("%02X", opt[i]);
+				printk(") ");
+			}
+			break;
+		}
+	case IPPROTO_UDP:{
+			struct udphdr udph;
+
+			/* Max length: 10 "PROTO=UDP " */
+			printk("PROTO=UDP ");
+
+			if (ntohs(iph.frag_off) & IP_OFFSET)
+				break;
+
+			/* Max length: 25 "INCOMPLETE [65535 bytes] " */
+			if (memcpy(&udph, skb->h.uh, sizeof(udph))
+			    < 0) {
+				printk("INCOMPLETE [%u bytes] ", iph.ihl * 4);
+				break;
+			}
+
+			/* Max length: 20 "SPT=65535 DPT=65535 " */
+			printk("SPT=%u DPT=%u LEN=%u ",
+			       ntohs(udph.source), ntohs(udph.dest),
+			       ntohs(udph.len));
+			break;
+		}
+	case IPPROTO_ICMP:{
+			struct icmphdr icmph;
+			/* Max length: 11 "PROTO=ICMP " */
+			printk("PROTO=ICMP ");
+
+			if (ntohs(iph.frag_off) & IP_OFFSET)
+				break;
+
+			/* Max length: 25 "INCOMPLETE [65535 bytes] " */
+			if (memcpy(&icmph, skb->h.icmph, sizeof(icmph))
+			    < 0) {
+				printk("INCOMPLETE [bytes] ");
+				break;
+			}
+
+			/* Max length: 18 "TYPE=255 CODE=255 " */
+			printk("TYPE=%u CODE=%u ", icmph.type, icmph.code);
+
+			switch (icmph.type) {
+			case ICMP_ECHOREPLY:
+			case ICMP_ECHO:
+				/* Max length: 19 "ID=65535 SEQ=65535 " */
+				printk("ID=%u SEQ=%u ",
+				       ntohs(icmph.un.echo.id),
+				       ntohs(icmph.un.echo.sequence));
+				break;
+
+			case ICMP_PARAMETERPROB:
+				/* Max length: 14 "PARAMETER=255 " */
+				printk("PARAMETER=%u ",
+				       ntohl(icmph.un.gateway) >> 24);
+				break;
+			case ICMP_REDIRECT:
+				/* Max length: 24 "GATEWAY=255.255.255.255 " */
+				printk("GATEWAY=%u.%u.%u.%u ",
+				       NIPQUAD(icmph.un.gateway));
+				/* Fall through */
+			case ICMP_DEST_UNREACH:
+			case ICMP_SOURCE_QUENCH:
+			case ICMP_TIME_EXCEEDED:
+				/* Max length: 10 "MTU=65535 " */
+				if (icmph.type == ICMP_DEST_UNREACH
+				    && icmph.code == ICMP_FRAG_NEEDED)
+					printk("MTU=%u ",
+					       ntohs(icmph.un.frag.mtu));
+			}
+			break;
+		}
+		/* Max Length */
+	case IPPROTO_AH:{
+			struct ip_auth_hdr ah;
+
+			if (ntohs(iph.frag_off) & IP_OFFSET)
+				break;
+
+			/* Max length: 9 "PROTO=AH " */
+			printk("PROTO=AH ");
+
+			/* Max length: 25 "INCOMPLETE [65535 bytes] " */
+			if (memcpy
+			    (&ah, skb->h.icmph + sizeof(struct icmphdr),
+			     sizeof(ah)) < 0) {
+				printk("INCOMPLETE [bytes] ");
+				break;
+			}
+
+			/* Length: 15 "SPI=0xF1234567 " */
+			printk("SPI=0x%x ", ntohl(ah.spi));
+			break;
+		}
+	case IPPROTO_ESP:{
+			struct ip_esp_hdr esph;
+
+			/* Max length: 10 "PROTO=ESP " */
+			printk("PROTO=ESP ");
+
+			if (ntohs(iph.frag_off) & IP_OFFSET)
+				break;
+
+			/* Max length: 25 "INCOMPLETE [65535 bytes] " */
+			if (memcpy
+			    (&esph, skb->h.icmph + sizeof(struct icmphdr),
+			     sizeof(esph))
+			    < 0) {
+				printk("INCOMPLETE [bytes] ");
+				break;
+			}
+
+			/* Length: 15 "SPI=0xF1234567 " */
+			printk("SPI=0x%x ", ntohl(esph.spi));
+			break;
+		}
+		/* Max length: 10 "PROTO 255 " */
+	default:
+		printk("PROTO=%u ", iph.protocol);
+	}
+
+	/* Proto    Max log string length */
+	/* IP:      40+46+6+11+127 = 230 */
+	/* TCP:     10+max(25,20+30+13+9+32+11+127) = 252 */
+	/* UDP:     10+max(25,20) = 35 */
+	/* ICMP:    11+max(25, 18+25+max(19,14,24+3+n+10,3+n+10)) = 91+n */
+	/* ESP:     10+max(25)+15 = 50 */
+	/* AH:      9+max(25)+15 = 49 */
+	/* unknown: 10 */
+
+	/* (ICMP allows recursion one level deep) */
+	/* maxlen =  IP + ICMP +  IP + max(TCP,UDP,ICMP,unknown) */
+	/* maxlen = 230+   91  + 230 + 252 = 803 */
+}
+
+/*
+ * nettrace_port: This is a generic routine that can be used to dump the
+ * network packet for a given source and destination port numbers.
+ * Network packet filtering is done based on source/target port or
+ * both source and target ports.
+ */
+
+static inline int nettrace_port(unsigned short source, unsigned short dest)
+{
+	if (((!source_port) && (!target_port))
+	    || ((!source_port) && (dest == target_port))
+	    || ((!target_port) && (source == source_port))
+	    || ((source == source_port) && (dest == target_port)))
+		return 0;
+
+	return 1;
+}
+
+static void get_ports_skb(struct sk_buff *skb, unsigned short *source,
+			  unsigned short *dest)
+{
+	struct iphdr *iph;
+	struct tcphdr *tcph;
+	struct udphdr *udph;
+	iph = (struct iphdr *)skb->data;
+
+	switch (iph->protocol) {
+	case IPPROTO_TCP:
+		tcph = (struct tcphdr *)((unsigned long)iph + iph->ihl * 4);
+		*source = ntohs(tcph->source);
+		*dest = ntohs(tcph->dest);
+		break;
+	case IPPROTO_UDP:
+		udph = (struct udphdr *)((unsigned long)iph + iph->ihl * 4);
+		*source = ntohs(udph->source);
+		*dest = ntohs(udph->dest);
+		break;
+	}
+}
+
+static void get_ports_net(struct sk_buff *skb, unsigned short *source,
+			  unsigned short *dest)
+{
+	struct iphdr *iph;
+	struct tcphdr *tcph;
+	struct udphdr *udph;
+
+	iph = (struct iphdr *)skb->nh.iph;
+	switch (iph->protocol) {
+	case IPPROTO_TCP:
+		tcph = (struct tcphdr *)skb->h.th;
+		*source = ntohs(tcph->source);
+		*dest = ntohs(tcph->dest);
+		break;
+	case IPPROTO_UDP:
+		udph = (struct udphdr *)skb->h.uh;
+		*source = ntohs(udph->source);
+		*dest = ntohs(udph->dest);
+		break;
+	}
+}
+
+/*
+ * Compile the kernel with options CONFIG_KPROBES, CONFIG_NETPKTLOG,
+ * CONFIG_NETFILTER, CONFIG_IP_NF_IPTABLES and CONFIG_IP_NF_TARGET_LOG enabled.
+ * You need to specify the parameters to the netpktlog module.
+ * To trace the network packets based on source and target ports, insert the
+ * module with source and target ports.
+ *	Example insmod netpktlog.ko source_port=35707 target_port=22
+ * To trace the network packets based on only source port, insert module
+ * with source port. Example insmod netpktlog.ko source_port=35707
+ * To trace network packets based on target port, insert module with
+ * target port.	Example insmod netpktlog.ko target_port=22
+ */
+static void jnetif_rx(struct sk_buff *skb)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	if ((skb->protocol == htons(ETH_P_IP))
+	    && (iph = (struct iphdr *)skb->data)) {
+		get_ports_skb(skb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("netif_rx: ");
+			dump_packet((struct ipt_log_info *)&info, skb, 0);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+}
+
+static void j__kfree_skb(struct sk_buff *skb)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	if ((skb->protocol == htons(ETH_P_IP))
+	    && (iph = (struct iphdr *)skb->nh.iph)) {
+		get_ports_net(skb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("__kfree_skb: ");
+			dump_packet_hdr((struct ipt_log_info *)&info, skb);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+}
+
+static int jnetif_receive_skb(struct sk_buff *skb)
+{
+	struct iphdr *iph;
+	unsigned short source, dest;
+	struct ipt_log_info info;
+	info.logflags = IPT_LOG_IPOPT;
+
+	if ((skb->protocol == htons(ETH_P_IP))
+	    && (iph = (struct iphdr *)skb->data)) {
+		get_ports_skb(skb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("netif_receive_skb: ");
+			dump_packet((struct ipt_log_info *)&info, skb, 0);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+	return 0;
+}
+
+static int jip_rcv(struct sk_buff *skb, struct net_device *dev,
+		   struct packet_type *pt)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	if ((skb->protocol == htons(ETH_P_IP))
+	    && (iph = (struct iphdr *)skb->data)) {
+		get_ports_skb(skb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("ip_rcv: ");
+			dump_packet((struct ipt_log_info *)&info, skb, 0);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+	return 0;
+}
+
+static int jip_local_deliver(struct sk_buff *skb)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	if ((skb->protocol == htons(ETH_P_IP))
+	    && (iph = (struct iphdr *)skb->data)) {
+		get_ports_skb(skb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("ip_local_deliver: ");
+			dump_packet((struct ipt_log_info *)&info, skb, 0);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+	return 0;
+}
+
+static int jip_output(struct sk_buff **pskb)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	iph = (struct iphdr *)(*pskb)->nh.iph;
+	if (iph) {
+		get_ports_net(*pskb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("ip_output: ");
+			dump_packet_hdr((struct ipt_log_info *)&info, (*pskb));
+			printk("\n");
+		}
+	}
+	jprobe_return();
+	return 0;
+}
+
+static int jtcp_v4_rcv(struct sk_buff *skb)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	if ((skb->protocol == htons(ETH_P_IP))
+	    && (iph = (struct iphdr *)skb->nh.iph)) {
+		get_ports_net(skb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("tcp_v4_rcv: ");
+			dump_packet_hdr((struct ipt_log_info *)&info, skb);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+	return 0;
+}
+
+static int jtcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	if ((skb->protocol == htons(ETH_P_IP))
+	    && (iph = (struct iphdr *)skb->nh.iph)) {
+		get_ports_net(skb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("tcp_v4_do_rcv: ");
+			dump_packet_hdr((struct ipt_log_info *)&info, skb);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+	return 0;
+}
+
+static int jtcp_rcv_established(struct sock *sk, struct sk_buff *skb,
+				struct tcphdr *th, unsigned len)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	if ((skb->protocol == htons(ETH_P_IP))
+	    && (iph = (struct iphdr *)skb->nh.iph)) {
+		get_ports_net(skb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("tcp_rcv_established: ");
+			dump_packet_hdr((struct ipt_log_info *)&info, skb);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+	return 0;
+}
+
+static int jskb_copy_datagram_iovec(struct sk_buff *from, int offset,
+				    struct iovec *to, int size)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	if ((from->protocol == htons(ETH_P_IP))
+	    && (iph = (struct iphdr *)from->nh.iph)) {
+		get_ports_net(from, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("skb_copy_datagram_iovec: ");
+			dump_packet_hdr((struct ipt_log_info *)&info, from);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+	return 0;
+}
+
+static void jtcp_send_dupack(struct sock *sk, struct sk_buff *skb)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	iph = (struct iphdr *)skb->nh.iph;
+	if (iph) {
+		get_ports_net(skb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("tcp_send_dupack: ");
+			dump_packet_hdr((struct ipt_log_info *)&info, skb);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+}
+
+static int jip_forward(struct sk_buff *skb)
+{
+	struct iphdr *iph;
+	struct ipt_log_info info;
+	unsigned short source, dest;
+	info.logflags = IPT_LOG_IPOPT;
+
+	iph = (struct iphdr *)skb->nh.iph;
+	if (iph) {
+		get_ports_net(skb, &source, &dest);
+		if (!nettrace_port(source, dest)) {
+			printk("ip_forward: ");
+			dump_packet_hdr((struct ipt_log_info *)&info, skb);
+			printk("\n");
+		}
+	}
+	jprobe_return();
+	return 0;
+}
+
+struct nettrace_obj {
+	const char *funcname;
+	struct jprobe jp;
+};
+
+#define NTOBJ(func) \
+	{ .funcname = #func, .jp = { .entry = (kprobe_opcode_t*)j##func }}
+static struct nettrace_obj nettrace_objs[] = {
+	NTOBJ(netif_rx),
+	NTOBJ(__kfree_skb),
+	NTOBJ(netif_receive_skb),
+	NTOBJ(ip_rcv),
+	NTOBJ(ip_local_deliver),
+	NTOBJ(ip_output),
+	NTOBJ(ip_forward),
+	NTOBJ(tcp_v4_rcv),
+	NTOBJ(tcp_v4_do_rcv),
+	NTOBJ(tcp_rcv_established),
+	NTOBJ(skb_copy_datagram_iovec),
+	NTOBJ(tcp_send_dupack)
+};
+
+#define MAX_NETTRACE_ROUTINE (sizeof(nettrace_objs)/sizeof(nettrace_objs[0]))
+
+static int init_netpktlog(void)
+{
+	int i;
+	struct nettrace_obj *nt;
+
+	/* first time invokation to initialize probe handler */
+	/* now we are all set to register the probe */
+	for (i = 0, nt = nettrace_objs; i < MAX_NETTRACE_ROUTINE; i++, nt++) {
+		nt = &nettrace_objs[i];
+		nt->jp.kp.addr = (kprobe_opcode_t *)
+		    kallsyms_lookup_name(nt->funcname);
+		if (nt->jp.kp.addr) {
+			printk("plant jprobe at %s (%p), handler addr %p\n",
+			       nt->funcname, nt->jp.kp.addr, nt->jp.entry);
+			register_jprobe(&nt->jp);
+		} else {
+			printk("couldn't find %s to plant jprobe\n",
+			       nt->funcname);
+		}
+	}
+
+	printk("Network packets tracing is enabled...\n");
+	return 0;
+}
+
+static void cleanup_netpktlog(void)
+{
+	int i;
+	for (i = 0; i < MAX_NETTRACE_ROUTINE; i++) {
+		if (nettrace_objs[i].jp.kp.addr)
+			unregister_jprobe(&nettrace_objs[i].jp);
+	}
+	printk("Network packets tracing is disabled...\n");
+}
+
+module_init(init_netpktlog);
+module_exit(cleanup_netpktlog);
+MODULE_LICENSE("GPL");
diff -puN include/linux/netfilter_ipv4/ipt_LOG.h~kprobes-netpkt-tracer-268-rc4 include/linux/netfilter_ipv4/ipt_LOG.h
--- linux-2.6.8-rc4/include/linux/netfilter_ipv4/ipt_LOG.h~kprobes-netpkt-tracer-268-rc4	2004-08-16 20:43:21.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/include/linux/netfilter_ipv4/ipt_LOG.h	2004-08-16 20:43:21.000000000 +0530
@@ -11,5 +11,7 @@ struct ipt_log_info {
 	unsigned char logflags;
 	char prefix[30];
 };
+void dump_packet(const struct ipt_log_info *info, const struct sk_buff *skb,
+			unsigned int iphoff);
 
 #endif /*_IPT_LOG_H*/
diff -puN kernel/kallsyms.c~kprobes-netpkt-tracer-268-rc4 kernel/kallsyms.c
--- linux-2.6.8-rc4/kernel/kallsyms.c~kprobes-netpkt-tracer-268-rc4	2004-08-16 20:43:21.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/kernel/kallsyms.c	2004-08-16 20:43:21.000000000 +0530
@@ -310,3 +310,4 @@ int __init kallsyms_init(void)
 __initcall(kallsyms_init);
 
 EXPORT_SYMBOL(__print_symbol);
+EXPORT_SYMBOL(kallsyms_lookup_name);
diff -puN net/ipv4/netfilter/ipt_LOG.c~kprobes-netpkt-tracer-268-rc4 net/ipv4/netfilter/ipt_LOG.c
--- linux-2.6.8-rc4/net/ipv4/netfilter/ipt_LOG.c~kprobes-netpkt-tracer-268-rc4	2004-08-16 20:43:21.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/net/ipv4/netfilter/ipt_LOG.c	2004-08-16 20:43:21.000000000 +0530
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

--wac7ysb48OaltWcw--
