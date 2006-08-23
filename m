Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWHWKxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWHWKxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWHWKwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:52:11 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:20920 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S964841AbWHWKwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:52:09 -0400
From: gerrit@erg.abdn.ac.uk
To: davem@davemloft.net
Subject: [RFC][PATCH 1/3] net/ipv4: UDP-Lite extensions
Date: Wed, 23 Aug 2006 11:50:41 +0100
User-Agent: KMail/1.8.3
Cc: jmorris@namei.org, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, kaber@coreworks.de, yoshfuji@linux-ipv6.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200608231150.42039@strip-the-willow>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Net/IPv4]: UDP-Lite standalone support and shared UDP/-Lite socket structure.


Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>
---

 include/linux/udp.h   |   19 ++++
 include/net/udplite.h |   35 ++++++++
 net/ipv4/udplite.c    |  209 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+), 1 deletion(-)


diff --git a/include/linux/udp.h b/include/linux/udp.h
index 90223f0..76fb1a1 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -19,6 +19,12 @@ #define _LINUX_UDP_H
 
 #include <linux/types.h>
 
+/**
+ *   struct udphdr  -  UDP/-Lite header
+ *
+ *   UDP (RFC 768) and UDP-Lite (RFC 3828) share the same header structure,
+ *   the only difference is that UDP-Lite interprets `len' as checksum coverage.
+ */
 struct udphdr {
 	__u16	source;
 	__u16	dest;
@@ -50,13 +56,24 @@ struct udp_sock {
 	 * when the socket is uncorked.
 	 */
 	__u16		 len;		/* total length of pending frames */
+/*
+ * 	Fields specific to UDP-Lite.
+ */
+	__u16		 pcslen;
+	__u16		 pcrlen;
+/* indicator bits used by pcflag: */
+#define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
+#define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
+#define UDPLITE_RECV_CC  0x4		/* set via udplite setsocktopt        */
+	__u8		 pcflag;        /* marks socket as UDP-Lite if > 0    */
 };
 
 static inline struct udp_sock *udp_sk(const struct sock *sk)
 {
 	return (struct udp_sock *)sk;
 }
+#define IS_UDPLITE(__sk) (udp_sk(__sk)->pcflag)
 
-#endif
+#endif	/* __KERNEL__   */
 
 #endif	/* _LINUX_UDP_H */
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
new file mode 100644
index 0000000..f5597e9
--- /dev/null
+++ b/net/ipv4/udplite.c
@@ -0,0 +1,209 @@
+/*
+ *  UDPLITE     An implementation of the UDP-Lite protocol (RFC 3828).
+ *
+ *  Version:    $Id: udplite.c,v 1.22 2006/08/22 13:01:52 gerrit Exp gerrit $
+ *
+ *  Authors:    Gerrit Renker       <gerrit@erg.abdn.ac.uk>
+ *
+ *  Changes:
+ *  Fixes:
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+struct hlist_head 	udplite_hash[UDP_HTABLE_SIZE];
+int    			udplite_port_rover;
+DEFINE_SNMP_STAT(struct udp_mib, udplite_statistics)	__read_mostly;
+
+/* these functions are called by UDP-Lite with protocol-specific parameters */
+static int	    __udp_get_port(struct sock *, unsigned short,
+				   struct hlist_head *, int *    );
+static struct sock *__udp_lookup(u32 , u16, u32, u16, int, struct hlist_head *);
+static int	    __udp_mcast_deliver(struct sk_buff *, struct udphdr *,
+					u32, u32, struct hlist_head *     );
+static int	    __udp_common_rcv(struct sk_buff *, int is_udplite);
+static void	    __udp_err(struct sk_buff *, u32, struct hlist_head *);
+#ifdef CONFIG_PROC_FS
+static int	    udp4_seq_show(struct seq_file *, void *);
+#endif
+
+/*
+ * 	Designate sk as UDP-Lite socket
+ */
+static	inline int udplite_sk_init(struct sock *sk)
+{
+	udp_sk(sk)->pcflag = UDPLITE_BIT;
+	return 0;
+}
+
+static __inline__ int udplite_v4_get_port(struct sock *sk, unsigned short snum)
+{
+	return	__udp_get_port(sk, snum, udplite_hash, &udplite_port_rover);
+}
+
+static __inline__ struct sock *udplite_v4_lookup(u32 saddr, u16 sport,
+						 u32 daddr, u16 dport, int dif)
+{
+	return __udp_lookup(saddr, sport, daddr, dport, dif, udplite_hash);
+}
+
+static __inline__ int udplite_v4_mcast_deliver(struct sk_buff *skb,
+					struct udphdr *uh, u32 saddr, u32 daddr)
+{
+	return __udp_mcast_deliver(skb, uh, saddr, daddr, udplite_hash);
+}
+
+__inline__ int udplite_rcv(struct sk_buff *skb)
+{
+	return __udp_common_rcv(skb, 1);
+}
+
+__inline__ void udplite_err(struct sk_buff *skb, u32 info)
+{
+	return __udp_err(skb, info, udplite_hash);
+}
+
+static int udplite_checksum_init(struct sk_buff *skb, struct udphdr *uh,
+				 unsigned short len, u32 saddr, u32 daddr)
+{
+	u16 cscov;
+
+        /* In UDPv4 a zero checksum means that the transmitter generated no
+         * checksum. UDP-Lite (like IPv6) mandates checksums, hence packets
+         * with a zero checksum field are illegal.                            */
+	if (uh->check == 0) {
+		LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: zeroed csum field"
+	                "(%d.%d.%d.%d:%d -> %d.%d.%d.%d:%d)\n", NIPQUAD(saddr),
+			ntohs(uh->source), NIPQUAD(daddr), ntohs(uh->dest)    );
+		return 0;
+	}
+
+        UDP_SKB_CB(skb)->partial_cov = 0;
+        cscov = ntohs(uh->len);
+
+	if (cscov == 0)		 /* Indicates that full coverage is required. */
+		cscov = len;
+	else if (cscov < 8  || cscov > len) {
+		/*
+		 * Coverage length violates RFC 3828: log and discard silently.
+		 */
+		LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: bad csum coverage %d/%d "
+			"(%d.%d.%d.%d:%d -> %d.%d.%d.%d:%d)\n", cscov, len,
+			NIPQUAD(saddr), ntohs(uh->source),
+			NIPQUAD(daddr), ntohs(uh->dest)                       );
+		return 0;
+
+	} else if (cscov < len)
+        	UDP_SKB_CB(skb)->partial_cov = 1;
+
+        UDP_SKB_CB(skb)->cscov = cscov;
+
+	/*
+	 * Initialise pseudo-header for checksum computation.
+	 *
+	 * There is no known NIC manufacturer supporting UDP-Lite yet,
+	 * hence ip_summed is always (re-)set to CHECKSUM_NONE.
+	 */
+	skb->csum = csum_tcpudp_nofold(saddr, daddr, len, IPPROTO_UDPLITE, 0);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	return 1;
+}
+
+static void udplite_csum_outgoing(struct sock *sk, struct sk_buff *skb,
+				  int totlen, int cscov, u32 src, u32 dst)
+{
+	unsigned int csum = 0, len;
+	struct udphdr *uh = skb->h.uh;
+
+	uh->check = 0;
+
+	skb->ip_summed = CHECKSUM_NONE;    /* no HW support for checksumming */
+
+	if (skb_queue_len(&sk->sk_write_queue) == 1) {
+		/*
+		 * Only one fragment on the socket.
+		 */
+		csum = skb_checksum(skb, skb->h.raw - skb->data, cscov, 0);
+
+	} else {
+		skb_queue_walk(&sk->sk_write_queue, skb) {
+			len = skb->tail - skb->h.raw;
+
+			skb->csum = skb_checksum(skb, skb->h.raw - skb->data,
+						 (cscov > len)? len : cscov, 0);
+			csum = csum_add(csum, skb->csum);
+
+			if (cscov < len)      /* Enough seen. */
+				break;
+			cscov -= len;
+		}
+	}
+
+	uh->check = csum_tcpudp_magic(src, dst, totlen, IPPROTO_UDPLITE, csum);
+	if (uh->check == 0)
+		uh->check = -1;
+}
+
+
+static	struct net_protocol udplite_protocol = {
+	.handler	= udplite_rcv,
+	.err_handler	= udplite_err,
+	.no_policy	= 1,
+};
+
+static struct inet_protosw udplite4_protosw = {
+	.type		=  SOCK_DGRAM,
+	.protocol	=  IPPROTO_UDPLITE,
+	.prot		=  &udplite_prot,
+	.ops		=  &inet_dgram_ops,
+	.capability	= -1,
+	.no_check	=  0,		/* must checksum (RFC 3828) */
+	.flags		=  INET_PROTOSW_PERMANENT,
+};
+
+void __init udplite4_register(void)
+{
+	if (proto_register(&udplite_prot, 1))
+		goto out_register_err;
+
+	if (inet_add_protocol(&udplite_protocol, IPPROTO_UDPLITE) < 0)
+		goto out_unregister_proto;
+
+	inet_register_protosw(&udplite4_protosw);
+
+	return;
+
+out_unregister_proto:
+	proto_unregister(&udplite_prot);
+out_register_err:
+	printk(KERN_ERR "udplite4_register: Cannot add UDP-Lite protocol\n");
+}
+
+#ifdef CONFIG_PROC_FS
+static struct file_operations udplite4_seq_fops;
+static struct udp_seq_afinfo udplite4_seq_afinfo = {
+	.owner		= THIS_MODULE,
+	.name		= "udplite",
+	.family		= AF_INET,
+	.hashtable	= udplite_hash,
+	.seq_show	= udp4_seq_show,
+	.seq_fops	= &udplite4_seq_fops,
+};
+
+__inline__ int __init udplite4_proc_init(void)
+{
+	return udp_proc_register(&udplite4_seq_afinfo);
+}
+
+__inline__ void udplite4_proc_exit(void)
+{
+	udp_proc_unregister(&udplite4_seq_afinfo);
+}
+#endif /* CONFIG_PROC_FS */
+
+EXPORT_SYMBOL(udplite_hash);
+EXPORT_SYMBOL(udplite_prot);
diff --git a/include/net/udplite.h b/include/net/udplite.h
new file mode 100644
index 0000000..1a32c42
--- /dev/null
+++ b/include/net/udplite.h
@@ -0,0 +1,35 @@
+/*
+ *	Definitions for the UDP-Lite (RFC 3828) code.
+ */
+#ifndef _UDPLITE_H
+#define _UDPLITE_H
+
+/* UDP-Lite socket options */
+#define UDPLITE_SEND_CSCOV   10 /* sender partial coverage (as sent)      */
+#define UDPLITE_RECV_CSCOV   11 /* receiver partial coverage (threshold ) */
+
+extern struct proto 		udplite_prot;
+extern struct hlist_head 	udplite_hash[UDP_HTABLE_SIZE];
+
+/* UDP-Lite does not have a standardized MIB yet, so we inherit from UDP */
+DECLARE_SNMP_STAT(struct udp_mib, udplite_statistics);
+
+/*
+ *	Checksum computation is all in software, hence simpler getfrag.
+ */
+static __inline__ int udplite_getfrag(void *from, char *to, int  offset,
+				      int len, int odd, struct sk_buff *skb)
+{
+	return memcpy_fromiovecend(to, (struct iovec *) from, offset, len);
+}
+
+/*
+ *  	net/ipv4/udplite.c
+ */
+extern void	udplite4_register(void);
+#ifdef CONFIG_PROC_FS
+extern int	udplite4_proc_init(void);
+extern void	udplite4_proc_exit(void);
+#endif
+
+#endif	/* _UDPLITE_H */
