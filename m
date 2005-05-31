Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVEaPHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVEaPHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVEaPHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:07:44 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:5208 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261598AbVEaPGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:06:31 -0400
Message-ID: <429C7D6E.7080803@tls.msk.ru>
Date: Tue, 31 May 2005 19:06:22 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] implement "blackhole" option for TCP and UDP
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------060802080407000305070007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060802080407000305070007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The patch below is an RFC only.  It implements "blackhole"
interface option for IPv4 (for now) TCP and UDP protocols,
adding a boolean "blackhole" in /proc/sys/net/ipv4/conf/*/
(per-interface).  The intent is to be able to ignore common
"invalid" IP traffic on (usually high-loaded) internet
servers, to stop such machines to participate in several
kinds of [D]DoS attacks and to reduce the load and bandwidth
utilisation.

Before someone asks: no, this feature isn't easily doable
using iptables, because of the following reasons:

 o iptables are somewhat heavy-weight esp for high-traffic sites

 o it is not possible to allow outgoing connections to pass
   with iptables, without ip_conntrack module

 o ip_conntrack has alot of its own limitations, again esp.
   for high-traffic sites

The patch below adds a simple check into the non-speed-critical
path, when, after realizing the destination port isn't listening,
ICMP port unreach (for UDP) or RST (for TCP) packet is generated.

This feature is similar to the one found on eg FreeBSD, with several
differences:

 o FreeBSD have global flags, while this patch implements the
   feature per-interface

 o FreeBSD uses two different flags for TCP and UDP, and distinguishes
   between TCP SYN packets (initial TCP handshake) and the rest,
   while this patch has one boolean (per interface) for both
   UDP and TCP.

There's an implementation question I have unanswered, too.  When,
having an skb pointer, we're checking if a corresponding (input)
interface has 'blackhole' option set, we should reference
skb->input_dev.  All accesses to this variable are done with a
lock set, using in_dev_get().  In this patch, I used lockless
__in_dev_get() variant, which does not seem to be right..  Is
it the only way here to use in_dev_get() and in_dev_put()?

Thanks.

/mjt

--------------060802080407000305070007
Content-Type: text/plain;
 name="72.net-ipv4-conf-blackhole.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="72.net-ipv4-conf-blackhole.diff"

This patch adds a sys/ipv4/conf/*/blackhole
boolean option.  When set, it makes the
interface in question to be a "black hole",
that is, the interface does not answer to
network packets sent to ports without a
listener (or corresponding to established
connections).

BOLD NOTE: the patch uses __in_dev_get()
routine incorrectly (but proper usage,
with in_dev_get(), requires locking in
a fast path) -- it can oops SMP kernel
if a device gets removed right when we're
desciding if we should send an ICMP/RST.

Another note: probably should test if
__in_dev_get() returned something != NULL,
too.

--- linux-2.6.11.orig/include/linux/inetdevice.h	Wed Mar  2 10:38:13 2005
+++ linux-2.6.11/include/linux/inetdevice.h	Tue May 17 19:21:11 2005
@@ -29,6 +29,7 @@ struct ipv4_devconf
 	int	no_xfrm;
 	int	no_policy;
 	int	force_igmp_version;
+	int	blackhole;
 	void	*sysctl;
 };
 
@@ -71,6 +72,7 @@ struct in_device
 #define IN_DEV_SEC_REDIRECTS(in_dev)	(ipv4_devconf.secure_redirects || (in_dev)->cnf.secure_redirects)
 #define IN_DEV_IDTAG(in_dev)		((in_dev)->cnf.tag)
 #define IN_DEV_MEDIUM_ID(in_dev)	((in_dev)->cnf.medium_id)
+#define IN_DEV_BLACKHOLE(in_dev)	(ipv4_devconf.blackhole || ((in_dev) && (in_dev)->cnf.blackhole))
 
 #define IN_DEV_RX_REDIRECTS(in_dev) \
 	((IN_DEV_FORWARD(in_dev) && \
--- linux-2.6.11.orig/include/linux/sysctl.h	Tue May 17 19:04:21 2005
+++ linux-2.6.11/include/linux/sysctl.h	Tue May 17 19:22:58 2005
@@ -399,6 +399,7 @@ enum
 	NET_IPV4_CONF_FORCE_IGMP_VERSION=17,
 	NET_IPV4_CONF_ARP_ANNOUNCE=18,
 	NET_IPV4_CONF_ARP_IGNORE=19,
+	NET_IPV4_CONF_BLACKHOLE=20,
 };
 
 /* /proc/sys/net/ipv4/netfilter */
--- linux-2.6.11.orig/net/ipv4/devinet.c	Wed Mar  2 10:37:50 2005
+++ linux-2.6.11/net/ipv4/devinet.c	Tue May 17 20:20:21 2005
@@ -1212,7 +1212,7 @@ int ipv4_doint_and_flush_strategy(ctl_ta
 
 static struct devinet_sysctl_table {
 	struct ctl_table_header *sysctl_header;
-	ctl_table		devinet_vars[20];
+	ctl_table		devinet_vars[21];
 	ctl_table		devinet_dev[2];
 	ctl_table		devinet_conf_dir[2];
 	ctl_table		devinet_proto_dir[2];
@@ -1373,6 +1373,14 @@ static struct devinet_sysctl_table {
 			.mode		= 0644,
 			.proc_handler	= &ipv4_doint_and_flush,
 			.strategy	= &ipv4_doint_and_flush_strategy,
+		},
+		{
+			.ctl_name	= NET_IPV4_CONF_BLACKHOLE,
+			.procname	= "blackhole",
+			.data		= &ipv4_devconf.blackhole,
+			.maxlen		= sizeof(int),
+			.mode		= 0644,
+			.proc_handler	= &proc_dointvec,
 		},
 	},
 	.devinet_dev = {
--- linux-2.6.11.orig/net/ipv4/tcp_ipv4.c	Wed Mar  2 10:37:54 2005
+++ linux-2.6.11/net/ipv4/tcp_ipv4.c	Tue May 17 20:34:13 2005
@@ -1166,6 +1166,9 @@ static void tcp_v4_send_reset(struct sk_
 	if (((struct rtable *)skb->dst)->rt_type != RTN_LOCAL)
 		return;
 
+	if (IN_DEV_BLACKHOLE(__in_dev_get(skb->input_dev)))
+		return;
+
 	/* Swap the send and the receive. */
 	memset(&rth, 0, sizeof(struct tcphdr));
 	rth.dest   = th->source;
--- linux-2.6.11.orig/net/ipv4/udp.c	Wed Mar  2 10:37:49 2005
+++ linux-2.6.11/net/ipv4/udp.c	Tue May 17 20:23:42 2005
@@ -1168,7 +1168,8 @@ int udp_rcv(struct sk_buff *skb)
 		goto csum_error;
 
 	UDP_INC_STATS_BH(UDP_MIB_NOPORTS);
-	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
+	if (!IN_DEV_BLACKHOLE(__in_dev_get(skb->input_dev)))
+		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
 
 	/*
 	 * Hmm.  We got an UDP packet to a port to which we

--------------060802080407000305070007--
