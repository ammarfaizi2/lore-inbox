Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWH1SMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWH1SMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWH1SMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:12:44 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:33177 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S1751231AbWH1SMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:12:42 -0400
From: gerrit@erg.abdn.ac.uk
To: davem@davemloft.net
Subject: [RFC][PATCHv2 2.6.18-rc4-mm3 3/3] net/ipv4:  misc. support files
Date: Mon, 28 Aug 2006 19:10:50 +0100
User-Agent: KMail/1.8.3
Cc: jmorris@namei.org, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, kaber@coreworks.de, yoshfuji@linux-ipv6.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200608231150.37895@strip-the-willow> <39e6f6c70608280548p5ba363d7o18cfd3bdb2f9e894@mail.gmail.com> <200608281513.49959@strip-the-willow>
In-Reply-To: <200608281513.49959@strip-the-willow>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200608281910.50647@strip-the-willow>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Net/IPv4]: REVISED Miscellaneous changes which complete the 
            v4 support for UDP-Lite.


Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>
---

 include/linux/in.h     |    1 +
 include/linux/socket.h |    1 +
 include/net/snmp.h     |    2 ++
 include/net/xfrm.h     |    2 ++
 net/ipv4/af_inet.c     |   15 ++++++++++++++-
 net/ipv4/proc.c        |   16 ++++++++++++++--
 net/ipv6/udp.c         |    1 +
 7 files changed, 35 insertions(+), 3 deletions(-)


diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 877e5b3..43faef2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1223,10 +1223,14 @@ static int __init init_ipv4_mibs(void)
 	tcp_statistics[1] = alloc_percpu(struct tcp_mib);
 	udp_statistics[0] = alloc_percpu(struct udp_mib);
 	udp_statistics[1] = alloc_percpu(struct udp_mib);
+	udplite_statistics[0] = alloc_percpu(struct udp_mib);
+	udplite_statistics[1] = alloc_percpu(struct udp_mib);
+
 	if (!
 	    (net_statistics[0] && net_statistics[1] && ip_statistics[0]
 	     && ip_statistics[1] && tcp_statistics[0] && tcp_statistics[1]
-	     && udp_statistics[0] && udp_statistics[1]))
+	     && udp_statistics[0] && udp_statistics[1]
+	     && udplite_statistics[0] && udplite_statistics[1]             ) )
 		return -ENOMEM;
 
 	(void) tcp_mib_init();
@@ -1300,6 +1304,11 @@ #endif
 		inet_register_protosw(q);
 
 	/*
+	 * 	Add UDP-Lite (RFC 3828)
+	 */
+	udplite4_register();
+
+	/*
 	 *	Set the ARP module up
 	 */
 
@@ -1367,6 +1376,8 @@ static int __init ipv4_proc_init(void)
 		goto out_tcp;
 	if (udp4_proc_init())
 		goto out_udp;
+	if (udplite4_proc_init())
+		goto out_udplite;
 	if (fib_proc_init())
 		goto out_fib;
 	if (ip_misc_proc_init())
@@ -1376,6 +1387,8 @@ out:
 out_misc:
 	fib_proc_exit();
 out_fib:
+	udplite4_proc_exit();
+out_udplite:
 	udp4_proc_exit();
 out_udp:
 	tcp4_proc_exit();
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 9c6cbe3..608fe34 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -66,9 +66,10 @@ static int sockstat_seq_show(struct seq_
 		   tcp_death_row.tw_count, atomic_read(&tcp_sockets_allocated),
 		   atomic_read(&tcp_memory_allocated));
 	seq_printf(seq, "UDP: inuse %d\n", fold_prot_inuse(&udp_prot));
+	seq_printf(seq, "UDPLITE: inuse %d\n", fold_prot_inuse(&udplite_prot));
 	seq_printf(seq, "RAW: inuse %d\n", fold_prot_inuse(&raw_prot));
-	seq_printf(seq,  "FRAG: inuse %d memory %d\n", ip_frag_nqueues,
-		   atomic_read(&ip_frag_mem));
+	seq_printf(seq, "FRAG: inuse %d memory %d\n", ip_frag_nqueues,
+		             atomic_read(&ip_frag_mem));
 	return 0;
 }
 
@@ -304,6 +305,17 @@ static int snmp_seq_show(struct seq_file
 			   fold_field((void **) udp_statistics, 
 				      snmp4_udp_list[i].entry));
 
+	/* the UDP and UDP-Lite MIBs are the same */
+	seq_puts(seq, "\nUdpLite:");
+	for (i = 0; snmp4_udp_list[i].name != NULL; i++)
+		seq_printf(seq, " %s", snmp4_udp_list[i].name);
+
+	seq_puts(seq, "\nUdpLite:");
+	for (i = 0; snmp4_udp_list[i].name != NULL; i++)
+		seq_printf(seq, " %lu",
+			   fold_field((void **) udplite_statistics,
+				      snmp4_udp_list[i].entry)     );
+
 	seq_putc(seq, '\n');
 	return 0;
 }
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index b9cc55c..b72540b 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1073,6 +1073,7 @@ static struct udp_seq_afinfo udp6_seq_af
 	.owner		= THIS_MODULE,
 	.name		= "udp6",
 	.family		= AF_INET6,
+	.hashtable	= udp_hash,
 	.seq_show	= udp6_seq_show,
 	.seq_fops	= &udp6_seq_fops,
 };
diff --git a/include/linux/in.h b/include/linux/in.h
index 94f557f..5ada82e 100644
--- a/include/linux/in.h
+++ b/include/linux/in.h
@@ -44,6 +44,7 @@ enum {
 
   IPPROTO_COMP   = 108,                /* Compression Header protocol */
   IPPROTO_SCTP   = 132,		/* Stream Control Transport Protocol	*/
+  IPPROTO_UDPLITE = 136,	/* UDP-Lite (RFC 3828)			*/
 
   IPPROTO_RAW	 = 255,		/* Raw IP packets			*/
   IPPROTO_MAX
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 3614090..592b666 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -264,6 +264,7 @@ #define SOL_UDP		17
 #define SOL_IPV6	41
 #define SOL_ICMPV6	58
 #define SOL_SCTP	132
+#define SOL_UDPLITE	136     /* UDP-Lite (RFC 3828) */
 #define SOL_RAW		255
 #define SOL_IPX		256
 #define SOL_AX25	257
diff --git a/include/net/snmp.h b/include/net/snmp.h
index 464970e..34183aa 100644
--- a/include/net/snmp.h
+++ b/include/net/snmp.h
@@ -131,6 +131,8 @@ #define SNMP_INC_STATS(mib, field) 	\
 	(per_cpu_ptr(mib[!in_softirq()], raw_smp_processor_id())->mibs[field]++)
 #define SNMP_DEC_STATS(mib, field) 	\
 	(per_cpu_ptr(mib[!in_softirq()], raw_smp_processor_id())->mibs[field]--)
+#define SNMP_DEC_STATS_BH(mib, field) 	\
+	(per_cpu_ptr(mib[0], raw_smp_processor_id())->mibs[field]--)
 #define SNMP_ADD_STATS_BH(mib, field, addend) 	\
 	(per_cpu_ptr(mib[0], raw_smp_processor_id())->mibs[field] += addend)
 #define SNMP_ADD_STATS_USER(mib, field, addend) 	\
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 6df3ecb..7f9913e 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -467,6 +467,7 @@ u16 xfrm_flowi_sport(struct flowi *fl)
 	switch(fl->proto) {
 	case IPPROTO_TCP:
 	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
 	case IPPROTO_SCTP:
 		port = fl->fl_ip_sport;
 		break;
@@ -492,6 +493,7 @@ u16 xfrm_flowi_dport(struct flowi *fl)
 	switch(fl->proto) {
 	case IPPROTO_TCP:
 	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
 	case IPPROTO_SCTP:
 		port = fl->fl_ip_dport;
 		break;

