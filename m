Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266460AbSLDMcx>; Wed, 4 Dec 2002 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266464AbSLDMcw>; Wed, 4 Dec 2002 07:32:52 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41866 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266460AbSLDMcc>;
	Wed, 4 Dec 2002 07:32:32 -0500
Date: Wed, 4 Dec 2002 18:05:10 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: netdev <netdev@oss.sgi.com>, "David S. Miller " <davem@redhat.com>,
       Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com
Subject: [patch] Change Networking mibs to use kmalloc_percpu -- 1/3
Message-ID: <20021204180510.C17375@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patchset to enable networking mibs to use kmalloc_percpu instead
of the traditional padded NR_CPUS arrays.

Advantages:
1. Removes NR_CPUS bloat due to static definition
2. Can support node local allocation
3. Will work with modules

The changes have been split for ipv4, ipv6 and sctp.  We can later do away
with the __pad and associated logic duing proc reporting (in the mibs) 
if this patchset is acceptable.

This patch is 1 of 3

D: Name: ipv4mibs-2.5.50-1.patch
D: Author: Ravikiran Thirumalai
D: Description: Changes ipv4 stats to use kmalloc_percpu from the traditional
D: 		padded NR_CPUS arrays


 include/net/icmp.h       |   15 ++++++-
 include/net/ip.h         |    6 +-
 include/net/snmp.h       |   39 +++++++++++++------
 include/net/tcp.h        |    6 +-
 include/net/udp.h        |    2 
 net/ipv4/af_inet.c       |   61 +++++++++++++++++++++++++++++
 net/ipv4/icmp.c          |   96 ++++++++++++++++++++++-------------------------
 net/ipv4/ip_input.c      |    2 
 net/ipv4/proc.c          |   37 +++++++++---------
 net/ipv4/tcp.c           |   13 +++---
 net/ipv4/tcp_input.c     |    4 -
 net/ipv4/tcp_minisocks.c |    4 -
 net/ipv4/tcp_timer.c     |    3 -
 net/ipv4/udp.c           |    2 
 14 files changed, 190 insertions(+), 100 deletions(-)


diff -ruN -X dontdiff linux-2.5.50/include/net/icmp.h mibstats-2.5.50/include/net/icmp.h
--- linux-2.5.50/include/net/icmp.h	Thu Nov 28 04:06:18 2002
+++ mibstats-2.5.50/include/net/icmp.h	Wed Dec  4 12:13:33 2002
@@ -23,6 +23,7 @@
 
 #include <net/sock.h>
 #include <net/protocol.h>
+#include <net/snmp.h>
 #include <linux/ip.h>
 
 struct icmp_err {
@@ -31,10 +32,22 @@
 };
 
 extern struct icmp_err icmp_err_convert[];
-extern struct icmp_mib icmp_statistics[NR_CPUS*2];
+DECLARE_SNMP_STAT(struct icmp_mib, icmp_statistics);
 #define ICMP_INC_STATS(field)		SNMP_INC_STATS(icmp_statistics, field)
 #define ICMP_INC_STATS_BH(field)	SNMP_INC_STATS_BH(icmp_statistics, field)
 #define ICMP_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(icmp_statistics, field)
+#define ICMP_INC_STATS_FIELD(offt)					\
+	(*((unsigned long *) ((void *)					\
+			     per_cpu_ptr(icmp_statistics[!in_softirq()],\
+					 smp_processor_id())) + offt))++;
+#define ICMP_INC_STATS_BH_FIELD(offt)					\
+	(*((unsigned long *) ((void *)					\
+			     per_cpu_ptr(icmp_statistics[0],		\
+					 smp_processor_id())) + offt))++;
+#define ICMP_INC_STATS_USER_FIELD(offt)					\
+	(*((unsigned long *) ((void *)					\
+			     per_cpu_ptr(icmp_statistics[1],		\
+					 smp_processor_id())) + offt))++;
 
 extern void	icmp_send(struct sk_buff *skb_in,  int type, int code, u32 info);
 extern int	icmp_rcv(struct sk_buff *skb);
diff -ruN -X dontdiff linux-2.5.50/include/net/ip.h mibstats-2.5.50/include/net/ip.h
--- linux-2.5.50/include/net/ip.h	Thu Nov 28 04:06:15 2002
+++ mibstats-2.5.50/include/net/ip.h	Wed Dec  4 12:13:33 2002
@@ -149,14 +149,16 @@
 };
 
 extern struct ipv4_config ipv4_config;
-extern struct ip_mib	ip_statistics[NR_CPUS*2];
+DECLARE_SNMP_STAT(struct ip_mib, ip_statistics);
 #define IP_INC_STATS(field)		SNMP_INC_STATS(ip_statistics, field)
 #define IP_INC_STATS_BH(field)		SNMP_INC_STATS_BH(ip_statistics, field)
 #define IP_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(ip_statistics, field)
-extern struct linux_mib	net_statistics[NR_CPUS*2];
+DECLARE_SNMP_STAT(struct linux_mib, net_statistics);
 #define NET_INC_STATS(field)		SNMP_INC_STATS(net_statistics, field)
 #define NET_INC_STATS_BH(field)		SNMP_INC_STATS_BH(net_statistics, field)
 #define NET_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(net_statistics, field)
+#define NET_ADD_STATS_BH(field, adnd)	SNMP_ADD_STATS_BH(net_statistics, field, adnd)
+#define NET_ADD_STATS_USER(field, adnd)	SNMP_ADD_STATS_USER(net_statistics, field, adnd)
 
 extern int sysctl_local_port_range[2];
 extern int sysctl_ip_default_ttl;
diff -ruN -X dontdiff linux-2.5.50/include/net/snmp.h mibstats-2.5.50/include/net/snmp.h
--- linux-2.5.50/include/net/snmp.h	Thu Nov 28 04:05:57 2002
+++ mibstats-2.5.50/include/net/snmp.h	Wed Dec  4 12:13:33 2002
@@ -62,7 +62,7 @@
  	unsigned long	IpFragFails;
  	unsigned long	IpFragCreates;
 	unsigned long   __pad[0]; 
-} ____cacheline_aligned;
+};
  
 struct ipv6_mib
 {
@@ -89,7 +89,7 @@
  	unsigned long	Ip6InMcastPkts;
  	unsigned long	Ip6OutMcastPkts;
 	unsigned long   __pad[0]; 
-} ____cacheline_aligned;
+};
  
 struct icmp_mib
 {
@@ -121,7 +121,7 @@
  	unsigned long	IcmpOutAddrMaskReps;
 	unsigned long	dummy;
 	unsigned long   __pad[0]; 
-} ____cacheline_aligned;
+};
 
 struct icmpv6_mib
 {
@@ -159,7 +159,7 @@
 	unsigned long	Icmp6OutGroupMembResponses;
 	unsigned long	Icmp6OutGroupMembReductions;
 	unsigned long   __pad[0]; 
-} ____cacheline_aligned;
+};
  
 struct tcp_mib
 {
@@ -178,7 +178,7 @@
  	unsigned long	TcpInErrs;
  	unsigned long	TcpOutRsts;
 	unsigned long   __pad[0]; 
-} ____cacheline_aligned;
+};
  
 struct udp_mib
 {
@@ -187,7 +187,7 @@
  	unsigned long	UdpInErrors;
  	unsigned long	UdpOutDatagrams;
 	unsigned long   __pad[0];
-} ____cacheline_aligned; 
+}; 
 
 /* draft-ietf-sigtran-sctp-mib-07.txt */
 struct sctp_mib
@@ -216,7 +216,7 @@
 	unsigned long   SctpValCookieLife;
 	unsigned long   SctpMaxInitRetr;
 	unsigned long   __pad[0];
-} ____cacheline_aligned;
+};
 
 struct linux_mib 
 {
@@ -286,7 +286,7 @@
 	unsigned long	TCPAbortFailed;
 	unsigned long	TCPMemoryPressures;
 	unsigned long   __pad[0];
-} ____cacheline_aligned;
+};
 
 
 /* 
@@ -294,8 +294,25 @@
  * addl $1,memory is atomic against interrupts (but atomic_inc would be overkill because of the lock 
  * cycles). Wants new nonlocked_atomic_inc() primitives -AK
  */ 
-#define SNMP_INC_STATS(mib, field) ((mib)[2*smp_processor_id()+!in_softirq()].field++)
-#define SNMP_INC_STATS_BH(mib, field) ((mib)[2*smp_processor_id()].field++)
-#define SNMP_INC_STATS_USER(mib, field) ((mib)[2*smp_processor_id()+1].field++)
+#define DEFINE_SNMP_STAT(type, name)	\
+	__typeof__(type) *name[2]
+#define DECLARE_SNMP_STAT(type, name)	\
+	extern __typeof__(type) *name[2]
+
+#define SNMP_STAT_USRPTR(name)	(name[0])
+#define SNMP_STAT_BHPTR(name)	(name[1])
+
+#define SNMP_INC_STATS_BH(mib, field) 	\
+	(per_cpu_ptr(mib[0], smp_processor_id())->field++)
+#define SNMP_INC_STATS_USER(mib, field) \
+	(per_cpu_ptr(mib[1], smp_processor_id())->field++)
+#define SNMP_INC_STATS(mib, field) 	\
+	(per_cpu_ptr(mib[!in_softirq()], smp_processor_id())->field++)
+#define SNMP_DEC_STATS(mib, field) 	\
+	(per_cpu_ptr(mib[!in_softirq()], smp_processor_id())->field--)
+#define SNMP_ADD_STATS_BH(mib, field, addend) 	\
+	(per_cpu_ptr(mib[0], smp_processor_id())->field += addend)
+#define SNMP_ADD_STATS_USER(mib, field, addend) 	\
+	(per_cpu_ptr(mib[1], smp_processor_id())->field += addend)
  	
 #endif
diff -ruN -X dontdiff linux-2.5.50/include/net/tcp.h mibstats-2.5.50/include/net/tcp.h
--- linux-2.5.50/include/net/tcp.h	Thu Nov 28 04:05:50 2002
+++ mibstats-2.5.50/include/net/tcp.h	Wed Dec  4 12:13:33 2002
@@ -28,6 +28,7 @@
 #include <linux/tcp.h>
 #include <linux/slab.h>
 #include <linux/cache.h>
+#include <linux/percpu.h>
 #include <net/checksum.h>
 #include <net/sock.h>
 #if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
@@ -630,10 +631,11 @@
 
 extern struct proto tcp_prot;
 
-extern struct tcp_mib tcp_statistics[NR_CPUS*2];
+DECLARE_SNMP_STAT(struct tcp_mib, tcp_statistics);
 #define TCP_INC_STATS(field)		SNMP_INC_STATS(tcp_statistics, field)
 #define TCP_INC_STATS_BH(field)		SNMP_INC_STATS_BH(tcp_statistics, field)
 #define TCP_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(tcp_statistics, field)
+#define TCP_DEC_STATS(field)		SNMP_DEC_STATS(tcp_statistics, field)
 
 extern void			tcp_put_port(struct sock *sk);
 extern void			__tcp_put_port(struct sock *sk);
@@ -1399,7 +1401,7 @@
 		/* fall through */
 	default:
 		if (oldstate==TCP_ESTABLISHED)
-			tcp_statistics[smp_processor_id()*2+!in_softirq()].TcpCurrEstab--;
+			TCP_DEC_STATS(TcpCurrEstab);
 	}
 
 	/* Change state AFTER socket is unhashed to avoid closed
diff -ruN -X dontdiff linux-2.5.50/include/net/udp.h mibstats-2.5.50/include/net/udp.h
--- linux-2.5.50/include/net/udp.h	Thu Nov 28 04:06:17 2002
+++ mibstats-2.5.50/include/net/udp.h	Wed Dec  4 12:13:33 2002
@@ -71,7 +71,7 @@
 extern int	udp_ioctl(struct sock *sk, int cmd, unsigned long arg);
 extern int	udp_disconnect(struct sock *sk, int flags);
 
-extern struct udp_mib udp_statistics[NR_CPUS*2];
+DECLARE_SNMP_STAT(struct udp_mib, udp_statistics);
 #define UDP_INC_STATS(field)		SNMP_INC_STATS(udp_statistics, field)
 #define UDP_INC_STATS_BH(field)		SNMP_INC_STATS_BH(udp_statistics, field)
 #define UDP_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(udp_statistics, field)
diff -ruN -X dontdiff linux-2.5.50/net/ipv4/af_inet.c mibstats-2.5.50/net/ipv4/af_inet.c
--- linux-2.5.50/net/ipv4/af_inet.c	Thu Nov 28 04:05:50 2002
+++ mibstats-2.5.50/net/ipv4/af_inet.c	Wed Dec  4 12:13:33 2002
@@ -115,7 +115,7 @@
 #include <linux/mroute.h>
 #endif
 
-struct linux_mib net_statistics[NR_CPUS * 2];
+DEFINE_SNMP_STAT(struct linux_mib, net_statistics);
 
 #ifdef INET_REFCNT_DEBUG
 atomic_t inet_sock_nr;
@@ -1055,6 +1055,59 @@
 	.handler =	icmp_rcv,
 };
 
+static int __init init_ipv4_mibs(void)
+{
+	int i;
+
+	net_statistics[0] =
+	    kmalloc_percpu(sizeof (struct linux_mib), GFP_KERNEL);
+	net_statistics[1] =
+	    kmalloc_percpu(sizeof (struct linux_mib), GFP_KERNEL);
+	ip_statistics[0] = kmalloc_percpu(sizeof (struct ip_mib), GFP_KERNEL);
+	ip_statistics[1] = kmalloc_percpu(sizeof (struct ip_mib), GFP_KERNEL);
+	icmp_statistics[0] =
+	    kmalloc_percpu(sizeof (struct icmp_mib), GFP_KERNEL);
+	icmp_statistics[1] =
+	    kmalloc_percpu(sizeof (struct icmp_mib), GFP_KERNEL);
+	tcp_statistics[0] = kmalloc_percpu(sizeof (struct tcp_mib), GFP_KERNEL);
+	tcp_statistics[1] = kmalloc_percpu(sizeof (struct tcp_mib), GFP_KERNEL);
+	udp_statistics[0] = kmalloc_percpu(sizeof (struct udp_mib), GFP_KERNEL);
+	udp_statistics[1] = kmalloc_percpu(sizeof (struct udp_mib), GFP_KERNEL);
+	if (!
+	    (net_statistics[0] && net_statistics[1] && ip_statistics[0]
+	     && ip_statistics[1] && tcp_statistics[0] && tcp_statistics[1]
+	     && udp_statistics[0] && udp_statistics[1]))
+		return -ENOMEM;
+
+	/* Set all the per cpu copies of the mibs to zero */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_possible(i)) {
+			memset(per_cpu_ptr(net_statistics[0], i), 0,
+			       sizeof (struct linux_mib));
+			memset(per_cpu_ptr(net_statistics[1], i), 0,
+			       sizeof (struct linux_mib));
+			memset(per_cpu_ptr(ip_statistics[0], i), 0,
+			       sizeof (struct ip_mib));
+			memset(per_cpu_ptr(ip_statistics[1], i), 0,
+			       sizeof (struct ip_mib));
+			memset(per_cpu_ptr(icmp_statistics[0], i), 0,
+			       sizeof (struct icmp_mib));
+			memset(per_cpu_ptr(icmp_statistics[1], i), 0,
+			       sizeof (struct icmp_mib));
+			memset(per_cpu_ptr(tcp_statistics[0], i), 0,
+			       sizeof (struct tcp_mib));
+			memset(per_cpu_ptr(tcp_statistics[1], i), 0,
+			       sizeof (struct tcp_mib));
+			memset(per_cpu_ptr(udp_statistics[0], i), 0,
+			       sizeof (struct udp_mib));
+			memset(per_cpu_ptr(udp_statistics[1], i), 0,
+			       sizeof (struct udp_mib));
+		}
+	}
+
+	return 0;
+}
+
 int ipv4_proc_init(void);
 
 static int __init inet_init(void)
@@ -1150,7 +1203,13 @@
 #if defined(CONFIG_IP_MROUTE)
 	ip_mr_init();
 #endif
+	/*
+	 *	Initialise per-cpu ipv4 mibs
+	 */ 
 
+	if(init_ipv4_mibs())
+		printk(KERN_CRIT "inet_init: Cannot init ipv4 mibs\n"); ;
+	
 	ipv4_proc_init();
 	return 0;
 }
diff -ruN -X dontdiff linux-2.5.50/net/ipv4/icmp.c mibstats-2.5.50/net/ipv4/icmp.c
--- linux-2.5.50/net/ipv4/icmp.c	Thu Nov 28 04:06:20 2002
+++ mibstats-2.5.50/net/ipv4/icmp.c	Wed Dec  4 12:13:33 2002
@@ -113,7 +113,7 @@
 /*
  *	Statistics
  */
-struct icmp_mib icmp_statistics[NR_CPUS * 2];
+DEFINE_SNMP_STAT(struct icmp_mib, icmp_statistics);
 
 /* An array of errno for error messages from dest unreach. */
 /* RFC 1122: 3.2.2.1 States that NET_UNREACH, HOS_UNREACH and SR_FAIELD MUST be considered 'transient errs'. */
@@ -213,12 +213,11 @@
  *	ICMP control array. This specifies what to do with each ICMP.
  */
 
-struct icmp_control
-{
-	unsigned long *output;		/* Address to increment on output */
-	unsigned long *input;		/* Address to increment on input */
+struct icmp_control {
+	int output_off;		/* Field offset for increment on output */
+	int input_off;		/* Field offset for increment on input */
 	void (*handler)(struct sk_buff *skb);
-	short	error;		/* This ICMP is classed as an error message */
+	short   error;		/* This ICMP is classed as an error message */
 };
 
 static struct icmp_control icmp_pointers[NR_ICMP_TYPES+1];
@@ -343,10 +342,7 @@
 static void icmp_out_count(int type)
 {
 	if (type <= NR_ICMP_TYPES) {
-		(icmp_pointers[type].output)[(smp_processor_id() * 2 +
-					      !in_softirq()) *
-					     sizeof(struct icmp_mib) /
-					     sizeof(unsigned long)]++;
+		ICMP_INC_STATS_FIELD(icmp_pointers[type].output_off);
 		ICMP_INC_STATS(IcmpOutMsgs);
 	}
 }
@@ -1005,9 +1001,7 @@
   		}
 	}
 
-	icmp_pointers[icmph->type].input[smp_processor_id() * 2 *
-					 sizeof(struct icmp_mib) /
-					 sizeof(unsigned long)]++;
+	ICMP_INC_STATS_BH_FIELD(icmp_pointers[icmph->type].input_off);
 	(icmp_pointers[icmph->type].handler)(skb);
 
 drop:
@@ -1024,122 +1018,122 @@
 static struct icmp_control icmp_pointers[NR_ICMP_TYPES + 1] = {
 	/* ECHO REPLY (0) */
 	[0] = {
-		.output =	 &icmp_statistics[0].IcmpOutEchoReps,
-		.input = &icmp_statistics[0].IcmpInEchoReps,
+		.output_off = offsetof(struct icmp_mib, IcmpOutEchoReps),
+		.input_off = offsetof(struct icmp_mib, IcmpInEchoReps),
 		.handler = icmp_discard,
 	},
 	[1] = {
-		.output =	 &icmp_statistics[0].dummy,
-		.input = &icmp_statistics[0].IcmpInErrors,
+		.output_off = offsetof(struct icmp_mib, dummy),
+		.input_off = offsetof(struct icmp_mib,IcmpInErrors),
 		.handler = icmp_discard,
 		.error = 1,
 	},
 	[2] = {
-		.output =	 &icmp_statistics[0].dummy,
-		.input = &icmp_statistics[0].IcmpInErrors,
+		.output_off = offsetof(struct icmp_mib, dummy),
+		.input_off = offsetof(struct icmp_mib,IcmpInErrors),
 		.handler = icmp_discard,
 		.error = 1,
 	},
 	/* DEST UNREACH (3) */
 	[3] = {
-		.output =	 &icmp_statistics[0].IcmpOutDestUnreachs,
-		.input = &icmp_statistics[0].IcmpInDestUnreachs,
+		.output_off = offsetof(struct icmp_mib, IcmpOutDestUnreachs),
+		.input_off = offsetof(struct icmp_mib, IcmpInDestUnreachs),
 		.handler = icmp_unreach,
 		.error = 1,
 	},
 	/* SOURCE QUENCH (4) */
 	[4] = {
-		.output =	 &icmp_statistics[0].IcmpOutSrcQuenchs,
-		.input = &icmp_statistics[0].IcmpInSrcQuenchs,
+		.output_off = offsetof(struct icmp_mib, IcmpOutSrcQuenchs),
+		.input_off = offsetof(struct icmp_mib, IcmpInSrcQuenchs),
 		icmp_unreach,
 		.error = 1,
 	},
 	/* REDIRECT (5) */
 	[5] = {
-		.output =	 &icmp_statistics[0].IcmpOutRedirects,
-		.input = &icmp_statistics[0].IcmpInRedirects,
+		.output_off = offsetof(struct icmp_mib, IcmpOutRedirects),
+		.input_off = offsetof(struct icmp_mib, IcmpInRedirects),
 		.handler = icmp_redirect,
 		.error = 1,
 	},
 	[6] = {
-		.output =	 &icmp_statistics[0].dummy,
-		.input = &icmp_statistics[0].IcmpInErrors,
+		.output_off = offsetof(struct icmp_mib, dummy),
+		.input_off = offsetof(struct icmp_mib, IcmpInErrors),
 		.handler = icmp_discard,
 		.error = 1,
 	},
 	[7] = {
-		.output =	 &icmp_statistics[0].dummy,
-		.input = &icmp_statistics[0].IcmpInErrors,
+		.output_off = offsetof(struct icmp_mib, dummy),
+		.input_off = offsetof(struct icmp_mib, IcmpInErrors),
 		.handler = icmp_discard,
 		.error = 1,
 	},
 	/* ECHO (8) */
 	[8] = {
-		.output =	 &icmp_statistics[0].IcmpOutEchos,
-		.input = &icmp_statistics[0].IcmpInEchos,
+		.output_off = offsetof(struct icmp_mib, IcmpOutEchos),
+		.input_off = offsetof(struct icmp_mib, IcmpInEchos),
 		.handler = icmp_echo,
 		.error = 0,
 	},
 	[9] = {
-		.output =	 &icmp_statistics[0].dummy,
-		.input = &icmp_statistics[0].IcmpInErrors,
+		.output_off = offsetof(struct icmp_mib, dummy),
+		.input_off = offsetof(struct icmp_mib, IcmpInErrors),
 		.handler = icmp_discard,
 		.error = 1,
 	},
 	[10] = {
-		.output =	 &icmp_statistics[0].dummy,
-		.input = &icmp_statistics[0].IcmpInErrors,
+		.output_off = offsetof(struct icmp_mib, dummy),
+		.input_off = offsetof(struct icmp_mib, IcmpInErrors),
 		.handler = icmp_discard,
 		.error = 1,
 	},
 	/* TIME EXCEEDED (11) */
 	[11] = {
-		.output =	 &icmp_statistics[0].IcmpOutTimeExcds,
-		.input = &icmp_statistics[0].IcmpInTimeExcds,
+		.output_off = offsetof(struct icmp_mib, IcmpOutTimeExcds),
+		.input_off = offsetof(struct icmp_mib,IcmpInTimeExcds),
 		.handler = icmp_unreach,
 		.error = 1,
 	},
 	/* PARAMETER PROBLEM (12) */
 	[12] = {
-		.output =	 &icmp_statistics[0].IcmpOutParmProbs,
-		.input = &icmp_statistics[0].IcmpInParmProbs,
+		.output_off = offsetof(struct icmp_mib, IcmpOutParmProbs),
+		.input_off = offsetof(struct icmp_mib, IcmpInParmProbs),
 		.handler = icmp_unreach,
 		.error = 1,
 	},
 	/* TIMESTAMP (13) */
 	[13] = {
-		.output =	 &icmp_statistics[0].IcmpOutTimestamps,
-		.input = &icmp_statistics[0].IcmpInTimestamps,
+		.output_off = offsetof(struct icmp_mib, IcmpOutTimestamps),
+		.input_off = offsetof(struct icmp_mib, IcmpInTimestamps),
 		.handler = icmp_timestamp,
 	},
 	/* TIMESTAMP REPLY (14) */
 	[14] = {
-		.output =	 &icmp_statistics[0].IcmpOutTimestampReps,
-		.input = &icmp_statistics[0].IcmpInTimestampReps,
+		.output_off = offsetof(struct icmp_mib, IcmpOutTimestampReps),
+		.input_off = offsetof(struct icmp_mib, IcmpInTimestampReps),
 		.handler = icmp_discard,
 	},
 	/* INFO (15) */
 	[15] = {
-		.output =	 &icmp_statistics[0].dummy,
-		.input = &icmp_statistics[0].dummy,
+		.output_off = offsetof(struct icmp_mib, dummy),
+		.input_off = offsetof(struct icmp_mib, dummy),
 		.handler = icmp_discard,
 	},
 	/* INFO REPLY (16) */
  	[16] = {
-		.output =	 &icmp_statistics[0].dummy,
-		.input = &icmp_statistics[0].dummy,
+		.output_off = offsetof(struct icmp_mib, dummy),
+		.input_off = offsetof(struct icmp_mib, dummy),
 		.handler = icmp_discard,
 	},
 	/* ADDR MASK (17) */
 	[17] = {
-		.output =	 &icmp_statistics[0].IcmpOutAddrMasks,
-		.input = &icmp_statistics[0].IcmpInAddrMasks,
+		.output_off = offsetof(struct icmp_mib, IcmpOutAddrMasks),
+		.input_off = offsetof(struct icmp_mib, IcmpInAddrMasks),
 		.handler = icmp_address,
 	},
 	/* ADDR MASK REPLY (18) */
 	[18] = {
-		.output =	 &icmp_statistics[0].IcmpOutAddrMaskReps,
-		.input = &icmp_statistics[0].IcmpInAddrMaskReps,
+		.output_off = offsetof(struct icmp_mib, IcmpOutAddrMaskReps),
+		.input_off = offsetof(struct icmp_mib, IcmpInAddrMaskReps),
 		.handler = icmp_address_reply,
 	}
 };
diff -ruN -X dontdiff linux-2.5.50/net/ipv4/ip_input.c mibstats-2.5.50/net/ipv4/ip_input.c
--- linux-2.5.50/net/ipv4/ip_input.c	Thu Nov 28 04:05:49 2002
+++ mibstats-2.5.50/net/ipv4/ip_input.c	Wed Dec  4 12:13:33 2002
@@ -149,7 +149,7 @@
  *	SNMP management statistics
  */
 
-struct ip_mib ip_statistics[NR_CPUS*2];
+DEFINE_SNMP_STAT(struct ip_mib, ip_statistics);
 
 /*
  *	Process Router Attention IP option
diff -ruN -X dontdiff linux-2.5.50/net/ipv4/proc.c mibstats-2.5.50/net/ipv4/proc.c
--- linux-2.5.50/net/ipv4/proc.c	Thu Nov 28 04:05:48 2002
+++ mibstats-2.5.50/net/ipv4/proc.c	Wed Dec  4 12:13:33 2002
@@ -86,16 +86,21 @@
 	.release = single_release,
 };
 
-static unsigned long fold_field(unsigned long *begin, int sz, int nr)
+static unsigned long
+fold_field(void *mib[], int nr)
 {
 	unsigned long res = 0;
 	int i;
 
-	sz /= sizeof(unsigned long);
-
 	for (i = 0; i < NR_CPUS; i++) {
-		res += begin[2 * i * sz + nr];
-		res += begin[(2 * i + 1) * sz + nr];
+		if (!cpu_possible(i))
+			continue;
+		res +=
+		    *((unsigned long *) (((void *) per_cpu_ptr(mib[0], i)) +
+					 sizeof (unsigned long) * nr));
+		res +=
+		    *((unsigned long *) (((void *) per_cpu_ptr(mib[0], i)) +
+					 sizeof (unsigned long) * nr));
 	}
 	return res;
 }
@@ -118,8 +123,7 @@
 	for (i = 0;
 	     i < offsetof(struct ip_mib, __pad) / sizeof(unsigned long); i++)
 		seq_printf(seq, " %lu",
-			   fold_field((unsigned long *)ip_statistics,
-				      sizeof(struct ip_mib), i));
+			   fold_field((void **) ip_statistics, i));
 
 	seq_printf(seq, "\nIcmp: InMsgs InErrors InDestUnreachs InTimeExcds "
 			"InParmProbs InSrcQuenchs InRedirects InEchos "
@@ -132,8 +136,7 @@
 	for (i = 0;
 	     i < offsetof(struct icmp_mib, dummy) / sizeof(unsigned long); i++)
 		seq_printf(seq, " %lu",
-			   fold_field((unsigned long *)icmp_statistics,
-				      sizeof(struct icmp_mib), i));
+			   fold_field((void **) icmp_statistics, i)); 
 
 	seq_printf(seq, "\nTcp: RtoAlgorithm RtoMin RtoMax MaxConn ActiveOpens "
 			"PassiveOpens AttemptFails EstabResets CurrEstab "
@@ -142,17 +145,15 @@
 	for (i = 0;
 	     i < offsetof(struct tcp_mib, __pad) / sizeof(unsigned long); i++)
 		seq_printf(seq, " %lu",
-			   fold_field((unsigned long *)tcp_statistics,
-				      sizeof(struct tcp_mib), i));
+			   fold_field((void **) tcp_statistics, i));
 
 	seq_printf(seq, "\nUdp: InDatagrams NoPorts InErrors OutDatagrams\n"
 			"Udp:");
 
 	for (i = 0;
 	     i < offsetof(struct udp_mib, __pad) / sizeof(unsigned long); i++)
-		seq_printf(seq, " %lu",
-			   fold_field((unsigned long *)udp_statistics,
-				      sizeof(struct udp_mib), i));
+		seq_printf(seq, " %lu", 
+				fold_field((void **) udp_statistics, i));
 
 	seq_putc(seq, '\n');
 	return 0;
@@ -206,10 +207,10 @@
 		      " TCPAbortFailed TCPMemoryPressures\n"
 		      "TcpExt:");
 	for (i = 0;
-	     i < offsetof(struct linux_mib, __pad) / sizeof(unsigned long); i++)
-		seq_printf(seq, " %lu",
-			   fold_field((unsigned long *)net_statistics,
-				      sizeof(struct linux_mib), i));
+	     i < offsetof(struct linux_mib, __pad) / sizeof(unsigned long); 
+	     i++)
+		seq_printf(seq, " %lu", 
+		 	   fold_field((void **) net_statistics, i)); 
 	seq_putc(seq, '\n');
 	return 0;
 }
diff -ruN -X dontdiff linux-2.5.50/net/ipv4/tcp.c mibstats-2.5.50/net/ipv4/tcp.c
--- linux-2.5.50/net/ipv4/tcp.c	Thu Nov 28 04:05:54 2002
+++ mibstats-2.5.50/net/ipv4/tcp.c	Wed Dec  4 12:13:33 2002
@@ -258,13 +258,15 @@
 #include <net/icmp.h>
 #include <net/tcp.h>
 #include <net/xfrm.h>
+#include <net/ip.h>
+
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
 int sysctl_tcp_fin_timeout = TCP_FIN_TIMEOUT;
 
-struct tcp_mib	tcp_statistics[NR_CPUS * 2];
+DEFINE_SNMP_STAT(struct tcp_mib, tcp_statistics);
 
 kmem_cache_t *tcp_openreq_cachep;
 kmem_cache_t *tcp_bucket_cachep;
@@ -1395,8 +1397,7 @@
 	struct sk_buff *skb;
 	struct tcp_opt *tp = tcp_sk(sk);
 
-	net_statistics[smp_processor_id() * 2 + 1].TCPPrequeued +=
-					    skb_queue_len(&tp->ucopy.prequeue);
+	NET_ADD_STATS_USER(TCPPrequeued, skb_queue_len(&tp->ucopy.prequeue));
 
 	/* RX process wants to run with disabled BHs, though it is not
 	 * necessary */
@@ -1676,7 +1677,7 @@
 			/* __ Restore normal policy in scheduler __ */
 
 			if ((chunk = len - tp->ucopy.len) != 0) {
-				net_statistics[smp_processor_id() * 2 + 1].TCPDirectCopyFromBacklog += chunk;
+				NET_ADD_STATS_USER(TCPDirectCopyFromBacklog, chunk);
 				len -= chunk;
 				copied += chunk;
 			}
@@ -1687,7 +1688,7 @@
 				tcp_prequeue_process(sk);
 
 				if ((chunk = len - tp->ucopy.len) != 0) {
-					net_statistics[smp_processor_id() * 2 + 1].TCPDirectCopyFromPrequeue += chunk;
+					NET_ADD_STATS_USER(TCPDirectCopyFromPrequeue, chunk);
 					len -= chunk;
 					copied += chunk;
 				}
@@ -1770,7 +1771,7 @@
 			tcp_prequeue_process(sk);
 
 			if (copied > 0 && (chunk = len - tp->ucopy.len) != 0) {
-				net_statistics[smp_processor_id() * 2 + 1].TCPDirectCopyFromPrequeue += chunk;
+				NET_ADD_STATS_USER(TCPDirectCopyFromPrequeue, chunk);
 				len -= chunk;
 				copied += chunk;
 			}
diff -ruN -X dontdiff linux-2.5.50/net/ipv4/tcp_input.c mibstats-2.5.50/net/ipv4/tcp_input.c
--- linux-2.5.50/net/ipv4/tcp_input.c	Thu Nov 28 04:06:16 2002
+++ mibstats-2.5.50/net/ipv4/tcp_input.c	Wed Dec  4 12:13:33 2002
@@ -3043,8 +3043,8 @@
 
 	/* First, purge the out_of_order queue. */
 	if (skb_queue_len(&tp->out_of_order_queue)) {
-		net_statistics[smp_processor_id() * 2].OfoPruned +=
-					skb_queue_len(&tp->out_of_order_queue);
+		NET_ADD_STATS_BH(OfoPruned,
+				 skb_queue_len(&tp->out_of_order_queue));
 		__skb_queue_purge(&tp->out_of_order_queue);
 
 		/* Reset SACK state.  A conforming SACK implementation will
diff -ruN -X dontdiff linux-2.5.50/net/ipv4/tcp_minisocks.c mibstats-2.5.50/net/ipv4/tcp_minisocks.c
--- linux-2.5.50/net/ipv4/tcp_minisocks.c	Thu Nov 28 04:06:16 2002
+++ mibstats-2.5.50/net/ipv4/tcp_minisocks.c	Wed Dec  4 12:13:33 2002
@@ -464,7 +464,7 @@
 
 	if ((tcp_tw_count -= killed) != 0)
 		mod_timer(&tcp_tw_timer, jiffies+TCP_TWKILL_PERIOD);
-	net_statistics[smp_processor_id()*2].TimeWaited += killed;
+	NET_ADD_STATS_BH(TimeWaited, killed);
 out:
 	spin_unlock(&tw_death_lock);
 }
@@ -628,7 +628,7 @@
 out:
 	if ((tcp_tw_count -= killed) == 0)
 		del_timer(&tcp_tw_timer);
-	net_statistics[smp_processor_id()*2].TimeWaitKilled += killed;
+	NET_ADD_STATS_BH(TimeWaitKilled, killed);
 	spin_unlock(&tw_death_lock);
 }
 
diff -ruN -X dontdiff linux-2.5.50/net/ipv4/tcp_timer.c mibstats-2.5.50/net/ipv4/tcp_timer.c
--- linux-2.5.50/net/ipv4/tcp_timer.c	Thu Nov 28 04:06:19 2002
+++ mibstats-2.5.50/net/ipv4/tcp_timer.c	Wed Dec  4 12:13:33 2002
@@ -237,7 +237,8 @@
 	if (skb_queue_len(&tp->ucopy.prequeue)) {
 		struct sk_buff *skb;
 
-		net_statistics[smp_processor_id()*2].TCPSchedulerFailed += skb_queue_len(&tp->ucopy.prequeue);
+		NET_ADD_STATS_BH(TCPSchedulerFailed,
+				  skb_queue_len(&tp->ucopy.prequeue));
 
 		while ((skb = __skb_dequeue(&tp->ucopy.prequeue)) != NULL)
 			sk->backlog_rcv(sk, skb);
diff -ruN -X dontdiff linux-2.5.50/net/ipv4/udp.c mibstats-2.5.50/net/ipv4/udp.c
--- linux-2.5.50/net/ipv4/udp.c	Thu Nov 28 04:05:51 2002
+++ mibstats-2.5.50/net/ipv4/udp.c	Wed Dec  4 12:13:33 2002
@@ -110,7 +110,7 @@
  *	Snmp MIB for the UDP layer
  */
 
-struct udp_mib		udp_statistics[NR_CPUS*2];
+DEFINE_SNMP_STAT(struct udp_mib, udp_statistics);
 
 struct sock *udp_hash[UDP_HTABLE_SIZE];
 rwlock_t udp_hash_lock = RW_LOCK_UNLOCKED;
