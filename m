Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbSLDMbn>; Wed, 4 Dec 2002 07:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266460AbSLDMbn>; Wed, 4 Dec 2002 07:31:43 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28562 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266456AbSLDMbi>;
	Wed, 4 Dec 2002 07:31:38 -0500
Date: Wed, 4 Dec 2002 18:07:32 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: netdev <netdev@oss.sgi.com>, "David S. Miller " <davem@redhat.com>,
       Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com
Subject: Re: [patch] Change Networking mibs to use kmalloc_percpu -- 2/3
Message-ID: <20021204180732.D17375@in.ibm.com>
References: <20021204180510.C17375@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021204180510.C17375@in.ibm.com>; from kiran@in.ibm.com on Wed, Dec 04, 2002 at 06:05:10PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is 2 of 3
 
D: Name: ipv6mibs-2.5.50-1.patch
D: Author: Ravikiran Thirumalai
D: Description: Changes ipv6 stats to use kmalloc_percpu from the traditional
D:              padded NR_CPUS arrays


 include/net/ipv6.h       |   11 ++++--
 net/ipv6/af_inet6.c      |   83 +++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv6/icmp.c          |    8 ++--
 net/ipv6/ipv6_sockglue.c |    2 -
 net/ipv6/proc.c          |   38 ++++++++++++---------
 net/ipv6/udp.c           |    2 -
 6 files changed, 119 insertions(+), 25 deletions(-)


diff -ruN -X dontdiff linux-2.5.50/include/net/ipv6.h mibstats-2.5.50/include/net/ipv6.h
--- linux-2.5.50/include/net/ipv6.h	Thu Nov 28 04:06:17 2002
+++ mibstats-2.5.50/include/net/ipv6.h	Wed Dec  4 12:13:33 2002
@@ -19,6 +19,7 @@
 #include <asm/hardirq.h>
 #include <net/ndisc.h>
 #include <net/flow.h>
+#include <net/snmp.h>
 
 #define SIN6_LEN_RFC2133	24
 
@@ -105,15 +106,19 @@
 /* sysctls */
 extern int sysctl_ipv6_bindv6only;
 
-extern struct ipv6_mib		ipv6_statistics[NR_CPUS*2];
+DECLARE_SNMP_STAT(struct ipv6_mib, ipv6_statistics);
 #define IP6_INC_STATS(field)		SNMP_INC_STATS(ipv6_statistics, field)
 #define IP6_INC_STATS_BH(field)		SNMP_INC_STATS_BH(ipv6_statistics, field)
 #define IP6_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(ipv6_statistics, field)
-extern struct icmpv6_mib	icmpv6_statistics[NR_CPUS*2];
+DECLARE_SNMP_STAT(struct icmpv6_mib, icmpv6_statistics);
 #define ICMP6_INC_STATS(field)		SNMP_INC_STATS(icmpv6_statistics, field)
 #define ICMP6_INC_STATS_BH(field)	SNMP_INC_STATS_BH(icmpv6_statistics, field)
 #define ICMP6_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(icmpv6_statistics, field)
-extern struct udp_mib		udp_stats_in6[NR_CPUS*2];
+#define ICMP6_STATS_PTR_BH(field) 					\
+	(&								\
+	 ((per_cpu_ptr(icmpv6_statistics[0], smp_processor_id()))->	\
+	  field))
+DECLARE_SNMP_STAT(struct udp_mib, udp_stats_in6);
 #define UDP6_INC_STATS(field)		SNMP_INC_STATS(udp_stats_in6, field)
 #define UDP6_INC_STATS_BH(field)	SNMP_INC_STATS_BH(udp_stats_in6, field)
 #define UDP6_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(udp_stats_in6, field)
diff -ruN -X dontdiff linux-2.5.50/net/ipv6/af_inet6.c mibstats-2.5.50/net/ipv6/af_inet6.c
--- linux-2.5.50/net/ipv6/af_inet6.c	Thu Nov 28 04:06:02 2002
+++ mibstats-2.5.50/net/ipv6/af_inet6.c	Wed Dec  4 12:13:33 2002
@@ -619,6 +619,81 @@
 	inet_unregister_protosw(p);
 }
 
+static int __init init_ipv6_mibs(void)
+{
+	int i;
+ 
+	ipv6_statistics[0] = kmalloc_percpu(sizeof (struct ipv6_mib),
+						GFP_KERNEL);
+	if (!ipv6_statistics[0])
+		goto err_ip_mib0;
+	ipv6_statistics[1] = kmalloc_percpu(sizeof (struct ipv6_mib),
+						GFP_KERNEL);
+	if (!ipv6_statistics[1])
+		goto err_ip_mib1;
+	
+	icmpv6_statistics[0] = kmalloc_percpu(sizeof (struct icmpv6_mib),
+						GFP_KERNEL);
+	if (!icmpv6_statistics[0])
+		goto err_icmp_mib0;
+	icmpv6_statistics[1] = kmalloc_percpu(sizeof (struct icmpv6_mib),
+						GFP_KERNEL);
+	if (!icmpv6_statistics[1])
+		goto err_icmp_mib1;
+	
+	udp_stats_in6[0] = kmalloc_percpu(sizeof (struct udp_mib),
+						GFP_KERNEL);
+	if (!udp_stats_in6[0])
+		goto err_udp_mib0;
+	udp_stats_in6[1] = kmalloc_percpu(sizeof (struct udp_mib),
+						GFP_KERNEL);
+	if (!udp_stats_in6[1])
+		goto err_udp_mib1;
+
+	/* Zero all percpu versions of the mibs */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_possible(i)) {
+		memset(per_cpu_ptr(ipv6_statistics[0], i), 0,
+				sizeof (struct ipv6_mib));
+		memset(per_cpu_ptr(ipv6_statistics[1], i), 0,
+				sizeof (struct ipv6_mib));
+		memset(per_cpu_ptr(icmpv6_statistics[0], i), 0,
+				sizeof (struct icmpv6_mib));
+		memset(per_cpu_ptr(icmpv6_statistics[1], i), 0,
+				sizeof (struct icmpv6_mib));
+		memset(per_cpu_ptr(udp_stats_in6[0], i), 0,
+				sizeof (struct udp_mib));
+		memset(per_cpu_ptr(udp_stats_in6[1], i), 0,
+				sizeof (struct udp_mib));
+		}
+	}
+	return 0;
+
+err_udp_mib1:
+	kfree_percpu(udp_stats_in6[0]);
+err_udp_mib0:
+	kfree_percpu(icmpv6_statistics[1]);
+err_icmp_mib1:
+	kfree_percpu(icmpv6_statistics[0]);
+err_icmp_mib0:
+	kfree_percpu(ipv6_statistics[1]);
+err_ip_mib1:
+	kfree_percpu(ipv6_statistics[0]);
+err_ip_mib0:
+	return -ENOMEM;
+	
+}
+
+static void __exit cleanup_ipv6_mibs(void)
+{
+	kfree_percpu(ipv6_statistics[0]);
+	kfree_percpu(ipv6_statistics[1]);
+	kfree_percpu(icmpv6_statistics[0]);
+	kfree_percpu(icmpv6_statistics[1]);
+	kfree_percpu(udp_stats_in6[0]);
+	kfree_percpu(udp_stats_in6[1]);
+}
+	
 static int __init inet6_init(void)
 {
 	struct sk_buff *dummy_skb;
@@ -668,6 +743,11 @@
 	 * be able to create sockets. (?? is this dangerous ??)
 	 */
 	(void) sock_register(&inet6_family_ops);
+
+	/* Initialise ipv6 mibs */
+	err = init_ipv6_mibs();
+	if (err)
+		goto init_mib_fail;
 	
 	/*
 	 *	ipngwg API draft makes clear that the correct semantics
@@ -735,6 +815,8 @@
 #if defined(MODULE) && defined(CONFIG_SYSCTL)
 	ipv6_sysctl_unregister();
 #endif
+	cleanup_ipv6_mibs();
+init_mib_fail:
 	return err;
 }
 module_init(inet6_init);
@@ -765,6 +847,7 @@
 #ifdef CONFIG_SYSCTL
 	ipv6_sysctl_unregister();	
 #endif
+	cleanup_ipv6_mibs();
 }
 module_exit(inet6_exit);
 #endif /* MODULE */
diff -ruN -X dontdiff linux-2.5.50/net/ipv6/icmp.c mibstats-2.5.50/net/ipv6/icmp.c
--- linux-2.5.50/net/ipv6/icmp.c	Thu Nov 28 04:05:55 2002
+++ mibstats-2.5.50/net/ipv6/icmp.c	Wed Dec  4 12:13:33 2002
@@ -65,7 +65,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-struct icmpv6_mib icmpv6_statistics[NR_CPUS*2];
+DEFINE_SNMP_STAT(struct icmpv6_mib, icmpv6_statistics);
 
 /*
  *	ICMP socket for flow control.
@@ -377,7 +377,7 @@
 	ip6_build_xmit(sk, icmpv6_getfrag, &msg, &fl, len, NULL, -1,
 		       MSG_DONTWAIT);
 	if (type >= ICMPV6_DEST_UNREACH && type <= ICMPV6_PARAMPROB)
-		(&(icmpv6_statistics[smp_processor_id()*2].Icmp6OutDestUnreachs))[type-1]++;
+		ICMP6_STATS_PTR_BH(Icmp6OutDestUnreachs) [type-1]++;
 	ICMP6_INC_STATS_BH(Icmp6OutMsgs);
 out:
 	icmpv6_xmit_unlock();
@@ -539,9 +539,9 @@
 	type = hdr->icmp6_type;
 
 	if (type >= ICMPV6_DEST_UNREACH && type <= ICMPV6_PARAMPROB)
-		(&icmpv6_statistics[smp_processor_id()*2].Icmp6InDestUnreachs)[type-ICMPV6_DEST_UNREACH]++;
+		ICMP6_STATS_PTR_BH(Icmp6InDestUnreachs)[type-ICMPV6_DEST_UNREACH]++;
 	else if (type >= ICMPV6_ECHO_REQUEST && type <= NDISC_REDIRECT)
-		(&icmpv6_statistics[smp_processor_id()*2].Icmp6InEchos)[type-ICMPV6_ECHO_REQUEST]++;
+		ICMP6_STATS_PTR_BH(Icmp6InEchos)[type-ICMPV6_ECHO_REQUEST]++;
 
 	switch (type) {
 	case ICMPV6_ECHO_REQUEST:
diff -ruN -X dontdiff linux-2.5.50/net/ipv6/ipv6_sockglue.c mibstats-2.5.50/net/ipv6/ipv6_sockglue.c
--- linux-2.5.50/net/ipv6/ipv6_sockglue.c	Thu Nov 28 04:05:49 2002
+++ mibstats-2.5.50/net/ipv6/ipv6_sockglue.c	Wed Dec  4 12:13:33 2002
@@ -51,7 +51,7 @@
 
 #include <asm/uaccess.h>
 
-struct ipv6_mib ipv6_statistics[NR_CPUS*2];
+DEFINE_SNMP_STAT(struct ipv6_mib, ipv6_statistics);
 
 static struct packet_type ipv6_packet_type =
 {
diff -ruN -X dontdiff linux-2.5.50/net/ipv6/proc.c mibstats-2.5.50/net/ipv6/proc.c
--- linux-2.5.50/net/ipv6/proc.c	Thu Nov 28 04:05:58 2002
+++ mibstats-2.5.50/net/ipv6/proc.c	Wed Dec  4 12:13:33 2002
@@ -59,11 +59,11 @@
 static struct snmp6_item
 {
 	char *name;
-	unsigned long *ptr;
-	int   mibsize;
+	void **mib;
+	int   offset;
 } snmp6_list[] = {
 /* ipv6 mib according to draft-ietf-ipngwg-ipv6-mib-04 */
-#define SNMP6_GEN(x) { #x , &ipv6_statistics[0].x, sizeof(struct ipv6_mib)/sizeof(unsigned long) }
+#define SNMP6_GEN(x) { #x , (void **)ipv6_statistics, offsetof(struct ipv6_mib, x) }
 	SNMP6_GEN(Ip6InReceives),
 	SNMP6_GEN(Ip6InHdrErrors),
 	SNMP6_GEN(Ip6InTooBigErrors),
@@ -97,7 +97,7 @@
 		OutRouterAdvertisements too.
 		OutGroupMembQueries too.
  */
-#define SNMP6_GEN(x) { #x , &icmpv6_statistics[0].x, sizeof(struct icmpv6_mib)/sizeof(unsigned long) }
+#define SNMP6_GEN(x) { #x , (void **)icmpv6_statistics, offsetof(struct icmpv6_mib, x) }
 	SNMP6_GEN(Icmp6InMsgs),
 	SNMP6_GEN(Icmp6InErrors),
 	SNMP6_GEN(Icmp6InDestUnreachs),
@@ -127,7 +127,7 @@
 	SNMP6_GEN(Icmp6OutGroupMembResponses),
 	SNMP6_GEN(Icmp6OutGroupMembReductions),
 #undef SNMP6_GEN
-#define SNMP6_GEN(x) { "Udp6" #x , &udp_stats_in6[0].Udp##x, sizeof(struct udp_mib)/sizeof(unsigned long) }
+#define SNMP6_GEN(x) { "Udp6" #x , (void **)udp_stats_in6, offsetof(struct udp_mib, Udp##x) }
 	SNMP6_GEN(InDatagrams),
 	SNMP6_GEN(NoPorts),
 	SNMP6_GEN(InErrors),
@@ -135,17 +135,23 @@
 #undef SNMP6_GEN
 };
 
-static unsigned long fold_field(unsigned long *ptr, int size)
+static unsigned long
+fold_field(void *mib[], int offt)
 {
-	unsigned long res = 0;
-	int i;
-
-	for (i=0; i<NR_CPUS; i++) {
-		res += ptr[2*i*size];
-		res += ptr[(2*i+1)*size];
-	}
-
-	return res;
+        unsigned long res = 0;
+        int i;
+ 
+        for (i = 0; i < NR_CPUS; i++) {
+                if (!cpu_possible(i))
+                        continue;
+                res +=
+                    *((unsigned long *) (((void *)per_cpu_ptr(mib[0], i)) +
+                                         offt));
+                res +=
+                    *((unsigned long *) (((void *)per_cpu_ptr(mib[1], i)) +
+                                         offt));
+        }
+        return res;
 }
 
 int afinet6_get_snmp(char *buffer, char **start, off_t offset, int length)
@@ -155,7 +161,7 @@
 
 	for (i=0; i<sizeof(snmp6_list)/sizeof(snmp6_list[0]); i++)
 		len += sprintf(buffer+len, "%-32s\t%ld\n", snmp6_list[i].name,
-			       fold_field(snmp6_list[i].ptr, snmp6_list[i].mibsize));
+			       fold_field(snmp6_list[i].mib, snmp6_list[i].offset));
 
 	len -= offset;
 
diff -ruN -X dontdiff linux-2.5.50/net/ipv6/udp.c mibstats-2.5.50/net/ipv6/udp.c
--- linux-2.5.50/net/ipv6/udp.c	Thu Nov 28 04:06:17 2002
+++ mibstats-2.5.50/net/ipv6/udp.c	Wed Dec  4 12:13:33 2002
@@ -51,7 +51,7 @@
 
 #include <net/checksum.h>
 
-struct udp_mib udp_stats_in6[NR_CPUS*2];
+DEFINE_SNMP_STAT(struct udp_mib, udp_stats_in6);
 
 /* XXX This is identical to tcp_ipv6.c:ipv6_rcv_saddr_equal, put
  * XXX it somewhere common. -DaveM
