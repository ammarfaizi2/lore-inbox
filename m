Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUDDGdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 01:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUDDGdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 01:33:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4049 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261704AbUDDGdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 01:33:21 -0500
Date: Sun, 4 Apr 2004 01:33:09 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
       <selinux@tycho.nsa.gov>
Subject: [SELINUX] Add IPv6 support
Message-ID: <Xine.LNX.4.44.0404040107120.7220-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below, against 2.6.5, adds explicit IPv6 support to SELinux.

Brief description of changes:

o IPv6 networking is now subject to the same controls as IPv4 (in addition
  to the generic socket permissions which cover all protocols), namely: 
  bind to local node address; bind to local port; send & receive TCP/UDP 
  and raw IP packets based on local network interface and remote node 
  address.

o Packet parsing has been extended to IPv6 packets for logging and 
  control, and simplified for IPv4.

o Support for logging of IPv6 addresses has also been added.

o The kernel policy database code has been modified to support IPv6, and
  reworked to provide generic security policy version handling so that 
  older policy versions will still work, making upgrading simpler.

Corresponding userspace patches are available at
<http://people.redhat.com/jmorris/selinux/ipv6/>, although current
userspace tools will continue to function normally (but without explicit
IPv6 support).

For more details at the security management level, see
<http://marc.theaimsgroup.com/?l=selinux&m=108068187630948&w=2>

This code has been under testing and review for several weeks.  Andrew, 
please consider applying to -mm.

 security/selinux/avc.c              |   54 ++++++-
 security/selinux/hooks.c            |  274 ++++++++++++++++++++++++++++--------
 security/selinux/include/avc.h      |   17 +-
 security/selinux/include/security.h |   11 +
 security/selinux/selinuxfs.c        |    2 
 security/selinux/ss/policydb.c      |  104 ++++++++++---
 security/selinux/ss/policydb.h      |    7 
 security/selinux/ss/services.c      |   57 ++++++-
 8 files changed, 422 insertions(+), 104 deletions(-)


- James
-- 
James Morris
<jmorris@redhat.com>


diff -purN -X dontdiff linux-2.6.5.o/security/selinux/avc.c linux-2.6.5.w/security/selinux/avc.c
--- linux-2.6.5.o/security/selinux/avc.c	2004-02-18 00:17:09.000000000 -0500
+++ linux-2.6.5.w/security/selinux/avc.c	2004-04-04 00:42:36.041574440 -0500
@@ -22,6 +22,8 @@
 #include <linux/un.h>
 #include <net/af_unix.h>
 #include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <net/ipv6.h>
 #include "avc.h"
 #include "avc_ss.h"
 #include "class_to_string.h"
@@ -418,6 +420,16 @@ out:
 	return rc;
 }
 
+static inline void avc_print_ipv6_addr(struct in6_addr *addr, u16 port,
+				       char *name1, char *name2)
+{
+	if (!ipv6_addr_any(addr))
+		printk(" %s=%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
+		       name1, NIP6(*addr));
+	if (port)
+		printk(" %s=%d", name2, ntohs(port));
+}
+
 static inline void avc_print_ipv4_addr(u32 addr, u16 port, char *name1, char *name2)
 {
 	if (addr)
@@ -602,11 +614,11 @@ void avc_audit(u32 ssid, u32 tsid,
 			if (a->u.net.sk) {
 				struct sock *sk = a->u.net.sk;
 				struct unix_sock *u;
-				struct inet_opt *inet;
 
 				switch (sk->sk_family) {
-				case AF_INET:
-					inet = inet_sk(sk);
+				case AF_INET: {
+					struct inet_opt *inet = inet_sk(sk);
+
 					avc_print_ipv4_addr(inet->rcv_saddr,
 					                    inet->sport,
 					                    "laddr", "lport");
@@ -614,6 +626,19 @@ void avc_audit(u32 ssid, u32 tsid,
 					                    inet->dport,
 					                    "faddr", "fport");
 					break;
+				}
+				case AF_INET6: {
+					struct inet_opt *inet = inet_sk(sk);
+					struct ipv6_pinfo *inet6 = inet6_sk(sk);
+					
+					avc_print_ipv6_addr(&inet6->rcv_saddr,
+							    inet->sport,
+							    "laddr", "lport");
+					avc_print_ipv6_addr(&inet6->daddr,
+							    inet->dport,
+							    "faddr", "fport");
+					break;
+				}
 				case AF_UNIX:
 					u = unix_sk(sk);
 					if (u->dentry) {
@@ -639,11 +664,24 @@ void avc_audit(u32 ssid, u32 tsid,
 				}
 			}
 			
-			avc_print_ipv4_addr(a->u.net.saddr, a->u.net.sport,
-			                    "saddr", "src");
-			avc_print_ipv4_addr(a->u.net.daddr, a->u.net.dport,
-			                    "daddr", "dest");
-
+			switch (a->u.net.family) {
+			case AF_INET:
+				avc_print_ipv4_addr(a->u.net.v4info.saddr,
+						    a->u.net.sport,
+						    "saddr", "src");
+				avc_print_ipv4_addr(a->u.net.v4info.daddr,
+						    a->u.net.dport,
+						    "daddr", "dest");
+				break;
+			case AF_INET6:
+				avc_print_ipv6_addr(&a->u.net.v6info.saddr,
+						    a->u.net.sport,
+						    "saddr", "src");
+				avc_print_ipv6_addr(&a->u.net.v6info.daddr,
+						    a->u.net.dport,
+						    "daddr", "dest");
+				break;
+			}
 			if (a->u.net.netif)
 				printk(" netif=%s", a->u.net.netif);
 			break;
diff -purN -X dontdiff linux-2.6.5.o/security/selinux/hooks.c linux-2.6.5.w/security/selinux/hooks.c
--- linux-2.6.5.o/security/selinux/hooks.c	2004-04-04 00:22:53.000000000 -0500
+++ linux-2.6.5.w/security/selinux/hooks.c	2004-04-04 00:33:22.140780160 -0500
@@ -42,6 +42,7 @@
 #include <linux/proc_fs.h>
 #include <linux/kd.h>
 #include <linux/netfilter_ipv4.h>
+#include <linux/netfilter_ipv6.h>
 #include <net/icmp.h>
 #include <net/ip.h>		/* for sysctl_local_port_range[] */
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
@@ -59,6 +60,7 @@
 #include <net/af_unix.h>	/* for Unix socket types */
 #include <linux/parser.h>
 #include <linux/nfs_mount.h>
+#include <net/ipv6.h>
 #include <linux/hugetlb.h>
 
 #include "avc.h"
@@ -2647,35 +2649,32 @@ static void selinux_task_to_inode(struct
 
 #ifdef CONFIG_SECURITY_NETWORK
 
-static void selinux_parse_skb_ipv4(struct sk_buff *skb, struct avc_audit_data *ad)
+/* Returns error only if unable to parse addresses */
+static int selinux_parse_skb_ipv4(struct sk_buff *skb, struct avc_audit_data *ad)
 {
-	int dlen, ihlen;
-	struct iphdr *iph;
+	int offset, ihlen, ret;
+	struct iphdr iph;
 
-	if (skb->len < sizeof(struct iphdr))
+	offset = skb->nh.raw - skb->data;
+	ret = skb_copy_bits(skb, offset, &iph, sizeof(iph));
+	if (ret)
 		goto out;
-	
-	iph = skb->nh.iph;
-	ihlen = iph->ihl * 4;
-	if (ihlen < sizeof(struct iphdr))
+
+	ihlen = iph.ihl * 4;
+	if (ihlen < sizeof(iph))
 		goto out;
 
-	dlen = skb->len - ihlen;
-	ad->u.net.saddr = iph->saddr;
-	ad->u.net.daddr = iph->daddr;
+	ad->u.net.v4info.saddr = iph.saddr;
+	ad->u.net.v4info.daddr = iph.daddr;
 
-	switch (iph->protocol) {
+	switch (iph.protocol) {
         case IPPROTO_TCP: {
-        	int offset;
         	struct tcphdr tcph;
 
-        	if (ntohs(iph->frag_off) & IP_OFFSET)
+        	if (ntohs(iph.frag_off) & IP_OFFSET)
         		break;
-        		
-		if (dlen < sizeof(tcph))
-			break;
 
-		offset = skb->nh.raw - skb->data + ihlen;
+		offset += ihlen;
 		if (skb_copy_bits(skb, offset, &tcph, sizeof(tcph)) < 0)
 			break;
 
@@ -2685,16 +2684,12 @@ static void selinux_parse_skb_ipv4(struc
         }
         
         case IPPROTO_UDP: {
-        	int offset;
         	struct udphdr udph;
         	
-        	if (ntohs(iph->frag_off) & IP_OFFSET)
+        	if (ntohs(iph.frag_off) & IP_OFFSET)
         		break;
         		
-        	if (dlen < sizeof(udph))
-        		break;
-
-		offset = skb->nh.raw - skb->data + ihlen;
+		offset += ihlen;
         	if (skb_copy_bits(skb, offset, &udph, sizeof(udph)) < 0)
         		break;	
 
@@ -2707,7 +2702,96 @@ static void selinux_parse_skb_ipv4(struc
         	break;
         }
 out:
-	return;
+	return ret;
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+
+/* Returns error only if unable to parse addresses */
+static int selinux_parse_skb_ipv6(struct sk_buff *skb, struct avc_audit_data *ad)
+{
+	u8 nexthdr;
+	int ret, offset = skb->nh.raw - skb->data;
+	struct ipv6hdr ipv6h;
+
+	offset = skb->nh.raw - skb->data;
+	ret = skb_copy_bits(skb, offset, &ipv6h, sizeof(ipv6h));
+	if (ret)
+		goto out;
+
+	ipv6_addr_copy(&ad->u.net.v6info.saddr, &ipv6h.saddr);
+	ipv6_addr_copy(&ad->u.net.v6info.daddr, &ipv6h.daddr);
+	
+	nexthdr = ipv6h.nexthdr;
+	offset += sizeof(ipv6h);
+	offset = ipv6_skip_exthdr(skb, offset, &nexthdr,
+				  skb->tail - skb->head - offset);
+	if (offset < 0)
+		goto out;
+
+	switch (nexthdr) {
+	case IPPROTO_TCP: {
+        	struct tcphdr tcph;
+
+		if (skb_copy_bits(skb, offset, &tcph, sizeof(tcph)) < 0)
+			break;
+
+		ad->u.net.sport = tcph.source;
+		ad->u.net.dport = tcph.dest;
+		break;
+	}
+	
+	case IPPROTO_UDP: {
+		struct udphdr udph;
+		
+		if (skb_copy_bits(skb, offset, &udph, sizeof(udph)) < 0)
+			break;
+			
+		ad->u.net.sport = udph.source;
+		ad->u.net.dport = udph.dest;
+		break;
+	}
+	
+	/* includes fragments */
+	default:
+		break;
+	}
+out:
+	return ret;
+}
+
+#endif /* IPV6 */
+
+static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
+			     char **addrp, int *len, int src)
+{
+	int ret = 0;
+
+	switch (ad->u.net.family) {
+	case PF_INET:
+		ret = selinux_parse_skb_ipv4(skb, ad);
+		if (ret || !addrp)
+			break;
+		*len = 4;
+		*addrp = (char *)(src ? &ad->u.net.v4info.saddr :
+					&ad->u.net.v4info.daddr);
+		break;
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)		
+	case PF_INET6:
+		ret = selinux_parse_skb_ipv6(skb, ad);
+		if (ret || !addrp)
+			break;
+		*len = 16;
+		*addrp = (char *)(src ? &ad->u.net.v6info.saddr :
+					&ad->u.net.v6info.daddr);
+		break;
+#endif	/* IPV6 */
+	default:
+		break;
+	}
+	
+	return ret;
 }
 
 /* socket security operations */
@@ -2770,6 +2854,7 @@ static void selinux_socket_post_create(s
 
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
+	u16 family;
 	int err;
 
 	err = socket_has_perm(current, sock, SOCKET__BIND);
@@ -2777,20 +2862,35 @@ static int selinux_socket_bind(struct so
 		goto out;
 
 	/*
-	 * If PF_INET, check name_bind permission for the port.
+	 * If PF_INET or PF_INET6, check name_bind permission for the port.
 	 */
-	if (sock->sk->sk_family == PF_INET) {
+	family = sock->sk->sk_family;
+	if (family == PF_INET || family == PF_INET6) {
+		char *addrp;
 		struct inode_security_struct *isec;
 		struct task_security_struct *tsec;
 		struct avc_audit_data ad;
-		struct sockaddr_in *addr = (struct sockaddr_in *)address;
-		unsigned short snum = ntohs(addr->sin_port);
+		struct sockaddr_in *addr4 = NULL;
+		struct sockaddr_in6 *addr6 = NULL;
+		unsigned short snum;
 		struct sock *sk = sock->sk;
-		u32 sid, node_perm;
+		u32 sid, node_perm, addrlen;
 
 		tsec = current->security;
 		isec = SOCK_INODE(sock)->i_security;
 
+		if (family == PF_INET) {
+			addr4 = (struct sockaddr_in *)address;
+			snum = ntohs(addr4->sin_port);
+			addrlen = sizeof(addr4->sin_addr.s_addr);
+			addrp = (char *)&addr4->sin_addr.s_addr;
+		} else {
+			addr6 = (struct sockaddr_in6 *)address;
+			snum = ntohs(addr6->sin6_port);
+			addrlen = sizeof(addr6->sin6_addr.s6_addr);
+			addrp = (char *)&addr6->sin6_addr.s6_addr;
+		}
+		
 		if (snum&&(snum < max(PROT_SOCK,ip_local_port_range_0) ||
 			   snum > ip_local_port_range_1)) {
 			err = security_port_sid(sk->sk_family, sk->sk_type,
@@ -2820,14 +2920,19 @@ static int selinux_socket_bind(struct so
 			break;
 		}
 		
-		err = security_node_sid(PF_INET, &addr->sin_addr.s_addr,
-		                        sizeof(addr->sin_addr.s_addr), &sid);
+		err = security_node_sid(family, addrp, addrlen, &sid);
 		if (err)
 			goto out;
 		
 		AVC_AUDIT_DATA_INIT(&ad,NET);
 		ad.u.net.sport = htons(snum);
-		ad.u.net.saddr = addr->sin_addr.s_addr;
+		ad.u.net.family = family;
+
+		if (family == PF_INET)
+			ad.u.net.v4info.saddr = addr4->sin_addr.s_addr;
+		else
+			ipv6_addr_copy(&ad.u.net.v6info.saddr, &addr6->sin6_addr);
+
 		err = avc_has_perm(isec->sid, sid,
 		                   isec->sclass, node_perm, NULL, &ad);
 		if (err)
@@ -2967,21 +3072,26 @@ static int selinux_socket_unix_may_send(
 
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	int err = 0;
+	u16 family;
+	char *addrp;
+	int len, err = 0;
 	u32 netif_perm, node_perm, node_sid, recv_perm = 0;
 	struct socket *sock;
 	struct inode *inode;
 	struct net_device *dev;
-	struct iphdr *iph;
 	struct sel_netif *netif;
 	struct netif_security_struct *nsec;
 	struct inode_security_struct *isec;
 	struct avc_audit_data ad;
 
-	/* Only IPv4 is supported here at this stage */
-	if (sk->sk_family != PF_INET)
+	family = sk->sk_family;
+	if (family != PF_INET && family != PF_INET6)
 		goto out;
 
+	/* Handle mapped IPv4 packets arriving via IPv6 sockets */
+	if (family == PF_INET6 && skb->protocol == ntohs(ETH_P_IP))
+		family = PF_INET;
+	
 	sock = sk->sk_socket;
 	
 	/* TCP control messages don't always have a socket. */
@@ -3026,7 +3136,13 @@ static int selinux_socket_sock_rcv_skb(s
 
 	AVC_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.netif = dev->name;
-	selinux_parse_skb_ipv4(skb, &ad);
+	ad.u.net.family = family;
+	
+	err = selinux_parse_skb(skb, &ad, &addrp, &len, 1);
+	if (err) {
+		sel_netif_put(netif);
+		goto out;
+	}
 
 	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
 	                   netif_perm, &nsec->avcr, &ad);
@@ -3035,8 +3151,7 @@ static int selinux_socket_sock_rcv_skb(s
 		goto out;
 	
 	/* Fixme: this lookup is inefficient */
-	iph = skb->nh.iph;
-	err = security_node_sid(PF_INET, &iph->saddr, sizeof(iph->saddr), &node_sid);
+	err = security_node_sid(family, addrp, len, &node_sid);	
 	if (err)
 		goto out;
 	
@@ -3057,7 +3172,6 @@ static int selinux_socket_sock_rcv_skb(s
 		err = avc_has_perm(isec->sid, port_sid, isec->sclass,
 		                   recv_perm, NULL, &ad);
 	}
-
 out:	
 	return err;
 }
@@ -3111,18 +3225,20 @@ static void selinux_sk_free_security(str
 }
 
 #ifdef CONFIG_NETFILTER
+
 static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
                                               struct sk_buff **pskb,
                                               const struct net_device *in,
                                               const struct net_device *out,
-                                              int (*okfn)(struct sk_buff *))
+                                              int (*okfn)(struct sk_buff *),
+                                              u16 family)
 {
-	int err = NF_ACCEPT;
+	char *addrp;
+	int len, err = NF_ACCEPT;
 	u32 netif_perm, node_perm, node_sid, send_perm = 0;
 	struct sock *sk;
 	struct socket *sock;
 	struct inode *inode;
-	struct iphdr *iph;
 	struct sel_netif *netif;
 	struct sk_buff *skb = *pskb;
 	struct netif_security_struct *nsec;
@@ -3170,9 +3286,17 @@ static unsigned int selinux_ip_postroute
 		break;
 	}
 
+	
 	AVC_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.netif = dev->name;
-	selinux_parse_skb_ipv4(skb, &ad);
+	ad.u.net.family = family;
+
+	err = selinux_parse_skb(skb, &ad, &addrp,
+				&len, 0) ? NF_DROP : NF_ACCEPT;
+	if (err != NF_ACCEPT) {
+		sel_netif_put(netif);
+		goto out;
+	}
 
 	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
 	                   netif_perm, &nsec->avcr, &ad) ? NF_DROP : NF_ACCEPT;
@@ -3181,8 +3305,7 @@ static unsigned int selinux_ip_postroute
 		goto out;
 		
 	/* Fixme: this lookup is inefficient */
-	iph = skb->nh.iph;
-	err = security_node_sid(PF_INET, &iph->daddr, sizeof(iph->daddr),
+	err = security_node_sid(family, addrp, len,
 				&node_sid) ? NF_DROP : NF_ACCEPT;
 	if (err != NF_ACCEPT)
 		goto out;
@@ -3212,6 +3335,28 @@ out:
 	return err;
 }
 
+static unsigned int selinux_ipv4_postroute_last(unsigned int hooknum,
+						struct sk_buff **pskb,
+						const struct net_device *in,
+						const struct net_device *out,
+						int (*okfn)(struct sk_buff *))
+{
+	return selinux_ip_postroute_last(hooknum, pskb, in, out, okfn, PF_INET);
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+
+static unsigned int selinux_ipv6_postroute_last(unsigned int hooknum,
+						struct sk_buff **pskb,
+						const struct net_device *in,
+						const struct net_device *out,
+						int (*okfn)(struct sk_buff *))
+{
+	return selinux_ip_postroute_last(hooknum, pskb, in, out, okfn, PF_INET6);
+}
+
+#endif	/* IPV6 */
+
 #endif	/* CONFIG_NETFILTER */
 
 #endif	/* CONFIG_SECURITY_NETWORK */
@@ -4025,14 +4170,26 @@ security_initcall(selinux_init);
 
 #if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_NETFILTER)
 
-static struct nf_hook_ops selinux_ip_ops[] = {
-	{ .hook =	selinux_ip_postroute_last,
-	  .owner =	THIS_MODULE,
-	  .pf =		PF_INET, 
-	  .hooknum =	NF_IP_POST_ROUTING, 
-	  .priority =	NF_IP_PRI_SELINUX_LAST, },
+static struct nf_hook_ops selinux_ipv4_op = {
+	.hook =		selinux_ipv4_postroute_last,
+	.owner =	THIS_MODULE,
+	.pf =		PF_INET, 
+	.hooknum =	NF_IP_POST_ROUTING, 
+	.priority =	NF_IP_PRI_SELINUX_LAST,
+};
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+
+static struct nf_hook_ops selinux_ipv6_op = {
+	.hook =		selinux_ipv6_postroute_last,
+	.owner =	THIS_MODULE,
+	.pf =		PF_INET6,
+	.hooknum =	NF_IP6_POST_ROUTING, 
+	.priority =	NF_IP6_PRI_SELINUX_LAST,
 };
 
+#endif	/* IPV6 */
+
 static int __init selinux_nf_ip_init(void)
 {
 	int err = 0;
@@ -4042,10 +4199,17 @@ static int __init selinux_nf_ip_init(voi
 		
 	printk(KERN_INFO "SELinux:  Registering netfilter hooks\n");
 	
-	err = nf_register_hook(&selinux_ip_ops[0]);
+	err = nf_register_hook(&selinux_ipv4_op);
+	if (err)
+		panic("SELinux: nf_register_hook for IPv4: error %d\n", err);
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+
+	err = nf_register_hook(&selinux_ipv6_op);
 	if (err)
-		panic("SELinux: nf_register_hook 0 error %d\n", err);
+		panic("SELinux: nf_register_hook for IPv6: error %d\n", err);
 
+#endif	/* IPV6 */
 out:
 	return err;
 }
diff -purN -X dontdiff linux-2.6.5.o/security/selinux/include/avc.h linux-2.6.5.w/security/selinux/include/avc.h
--- linux-2.6.5.o/security/selinux/include/avc.h	2004-02-18 00:17:09.000000000 -0500
+++ linux-2.6.5.w/security/selinux/include/avc.h	2004-04-04 00:33:22.156777728 -0500
@@ -12,6 +12,7 @@
 #include <linux/kdev_t.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
+#include <linux/in6.h>
 #include <asm/system.h>
 #include "flask.h"
 #include "av_permissions.h"
@@ -65,16 +66,28 @@ struct avc_audit_data {
 		struct {
 			char *netif;
 			struct sock *sk;
+			u16 family;
 			u16 dport;
 			u16 sport;
-			u32 daddr;
-			u32 saddr;
+			union {
+				struct {
+					u32 daddr;
+					u32 saddr;
+				} v4;
+				struct {
+					struct in6_addr daddr;
+					struct in6_addr saddr;
+				} v6;
+			} fam;
 		} net;
 		int cap;
 		int ipc_id;
 	} u;
 };
 
+#define v4info fam.v4
+#define v6info fam.v6
+
 /* Initialize an AVC audit data structure. */
 #define AVC_AUDIT_DATA_INIT(_d,_t) \
         { memset((_d), 0, sizeof(struct avc_audit_data)); (_d)->type = AVC_AUDIT_DATA_##_t; }
diff -purN -X dontdiff linux-2.6.5.o/security/selinux/include/security.h linux-2.6.5.w/security/selinux/include/security.h
--- linux-2.6.5.o/security/selinux/include/security.h	2004-04-04 00:22:53.000000000 -0500
+++ linux-2.6.5.w/security/selinux/include/security.h	2004-04-04 00:33:22.156777728 -0500
@@ -15,8 +15,15 @@
 #define SECCLASS_NULL			0x0000 /* no class */
 
 #define SELINUX_MAGIC 0xf97cff8c
-#define POLICYDB_VERSION 16
-#define POLICYDB_VERSION_COMPAT 15
+
+/* Identify specific policy version changes */
+#define POLICYDB_VERSION_BASE  15
+#define POLICYDB_VERSION_BOOL  16
+#define POLICYDB_VERSION_IPV6  17
+
+/* Range of policy versions we understand*/
+#define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_IPV6
 
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 extern int selinux_enabled;
diff -purN -X dontdiff linux-2.6.5.o/security/selinux/selinuxfs.c linux-2.6.5.w/security/selinux/selinuxfs.c
--- linux-2.6.5.o/security/selinux/selinuxfs.c	2004-04-04 00:22:53.000000000 -0500
+++ linux-2.6.5.w/security/selinux/selinuxfs.c	2004-04-04 00:33:22.157777576 -0500
@@ -164,7 +164,7 @@ static ssize_t sel_read_policyvers(struc
 		return -ENOMEM;
 	memset(page, 0, PAGE_SIZE);
 
-	length = scnprintf(page, PAGE_SIZE, "%u", POLICYDB_VERSION);
+	length = scnprintf(page, PAGE_SIZE, "%u", POLICYDB_VERSION_MAX);
 	if (length < 0) {
 		free_page((unsigned long)page);
 		return length;
diff -purN -X dontdiff linux-2.6.5.o/security/selinux/ss/policydb.c linux-2.6.5.w/security/selinux/ss/policydb.c
--- linux-2.6.5.o/security/selinux/ss/policydb.c	2004-04-04 00:22:53.000000000 -0500
+++ linux-2.6.5.w/security/selinux/ss/policydb.c	2004-04-04 00:33:22.159777272 -0500
@@ -48,6 +48,45 @@ static unsigned int symtab_sizes[SYM_NUM
 	16
 };
 
+struct policydb_compat_info {
+	int version;
+	int sym_num;
+	int ocon_num;
+};
+
+/* These need to be updated if SYM_NUM or OCON_NUM changes */
+static struct policydb_compat_info policydb_compat[] = {
+	{
+		.version        = POLICYDB_VERSION_BASE,
+		.sym_num        = SYM_NUM - 1,
+		.ocon_num       = OCON_NUM - 1,
+	},
+	{
+		.version        = POLICYDB_VERSION_BOOL,
+		.sym_num        = SYM_NUM,
+		.ocon_num       = OCON_NUM - 1,
+	},
+	{
+		.version        = POLICYDB_VERSION_IPV6,
+		.sym_num        = SYM_NUM,
+		.ocon_num       = OCON_NUM,
+	},
+};
+
+static struct policydb_compat_info *policydb_lookup_compat(int version)
+{
+	int i;
+	struct policydb_compat_info *info = NULL;
+	
+	for (i = 0; i < sizeof(policydb_compat)/sizeof(*info); i++) {
+		if (policydb_compat[i].version == version) {
+			info = &policydb_compat[i];
+			break;
+		}
+	}
+	return info;
+}
+
 /*
  * Initialize the role table.
  */
@@ -1086,9 +1125,10 @@ int policydb_read(struct policydb *p, vo
 	struct role_trans *tr, *ltr;
 	struct ocontext *l, *c, *newc;
 	struct genfs *genfs_p, *genfs, *newgenfs;
-	int i, j, rc, policy_ver, num_syms;
+	int i, j, rc, r_policyvers;
 	u32 *buf, len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
+	struct policydb_compat_info *info;
 
 	config = 0;
 	mls_set_config(config);
@@ -1151,12 +1191,15 @@ int policydb_read(struct policydb *p, vo
 	for (i = 0; i < 4; i++)
 		buf[i] = le32_to_cpu(buf[i]);
 
-	policy_ver = buf[0];
-	if (policy_ver != POLICYDB_VERSION && policy_ver != POLICYDB_VERSION_COMPAT) {
-		printk(KERN_ERR "security:  policydb version %d does not match "
-		       "my version %d\n", buf[0], POLICYDB_VERSION);
-		goto bad;
+	r_policyvers = buf[0];
+	if (r_policyvers < POLICYDB_VERSION_MIN ||
+	    r_policyvers > POLICYDB_VERSION_MAX) {
+	    	printk(KERN_ERR "security:  policydb version %d does not match "
+	    	       "my version range %d-%d\n",
+	    	       buf[0], POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
+	    	goto bad;
 	}
+
 	if (buf[1] != config) {
 		printk(KERN_ERR "security:  policydb configuration (%s) does "
 		       "not match my configuration (%s)\n",
@@ -1164,30 +1207,27 @@ int policydb_read(struct policydb *p, vo
 		       mls_config(config));
 		goto bad;
 	}
+	
 
-	if (policy_ver == POLICYDB_VERSION_COMPAT) {
-		if (buf[2] != (SYM_NUM - 1) || buf[3] != OCON_NUM) {
-			printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
-			       "not match mine (%d,%d)\n",
-			       buf[2], buf[3], SYM_NUM, OCON_NUM);
-			goto bad;
-		}
-		num_syms = SYM_NUM - 1;
-	} else {
-		if (buf[2] != SYM_NUM || buf[3] != OCON_NUM) {
-			printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
-			       "not match mine (%d,%d)\n",
-			       buf[2], buf[3], SYM_NUM, OCON_NUM);
-			goto bad;
-		}
-		num_syms = SYM_NUM;
+	info = policydb_lookup_compat(r_policyvers);
+	if (!info) {
+		printk(KERN_ERR "security:  unable to find policy compat info "
+		       "for version %d\n", r_policyvers);
+		goto bad;
+	}
+	
+	if (buf[2] != info->sym_num || buf[3] != info->ocon_num) {
+		printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
+		       "not match mine (%d,%d)\n", buf[2], buf[3],
+		       info->sym_num, info->ocon_num);
+		goto bad;
 	}
 
 	rc = mls_read_nlevels(p, fp);
 	if (rc)
 		goto bad;
 
-	for (i = 0; i < num_syms; i++) {
+	for (i = 0; i < info->sym_num; i++) {
 		buf = next_entry(fp, sizeof(u32)*2);
 		if (!buf) {
 			rc = -EINVAL;
@@ -1208,7 +1248,7 @@ int policydb_read(struct policydb *p, vo
 	if (rc)
 		goto bad;
 
-	if (policy_ver == POLICYDB_VERSION) {
+	if (r_policyvers >= POLICYDB_VERSION_BOOL) {
 		rc = cond_read_list(p, fp);
 		if (rc)
 			goto bad;
@@ -1281,7 +1321,7 @@ int policydb_read(struct policydb *p, vo
 	if (rc)
 		goto bad;
 
-	for (i = 0; i < OCON_NUM; i++) {
+	for (i = 0; i < info->ocon_num; i++) {
 		buf = next_entry(fp, sizeof(u32));
 		if (!buf) {
 			rc = -EINVAL;
@@ -1379,6 +1419,20 @@ int policydb_read(struct policydb *p, vo
 				if (rc)
 					goto bad;
 				break;
+			case OCON_NODE6: {
+				int k;
+				
+				buf = next_entry(fp, sizeof(u32) * 8);
+				if (!buf)
+					goto bad;
+				for (k = 0; k < 4; k++)
+					c->u.node6.addr[k] = le32_to_cpu(buf[k]);
+				for (k = 0; k < 4; k++)
+					c->u.node6.mask[k] = le32_to_cpu(buf[k+4]);
+				if (context_read_and_validate(&c->context[0], p, fp))
+					goto bad;
+				break;
+			}
 			}
 		}
 	}
diff -purN -X dontdiff linux-2.6.5.o/security/selinux/ss/policydb.h linux-2.6.5.w/security/selinux/ss/policydb.h
--- linux-2.6.5.o/security/selinux/ss/policydb.h	2004-04-04 00:22:53.000000000 -0500
+++ linux-2.6.5.w/security/selinux/ss/policydb.h	2004-04-04 00:33:22.160777120 -0500
@@ -138,6 +138,10 @@ struct ocontext {
 			u32 addr;
 			u32 mask;
 		} node;		/* node information */
+		struct {
+			u32 addr[4];
+			u32 mask[4];
+		} node6;        /* IPv6 node information */
 	} u;
 	union {
 		u32 sclass;  /* security class for genfs */
@@ -177,7 +181,8 @@ struct genfs {
 #define OCON_NETIF 3	/* network interfaces */
 #define OCON_NODE  4	/* nodes */
 #define OCON_FSUSE 5	/* fs_use */
-#define OCON_NUM   6
+#define OCON_NODE6 6	/* IPv6 nodes */
+#define OCON_NUM   7
 
 /* The policy database */
 struct policydb {
diff -purN -X dontdiff linux-2.6.5.o/security/selinux/ss/services.c linux-2.6.5.w/security/selinux/ss/services.c
--- linux-2.6.5.o/security/selinux/ss/services.c	2004-04-04 00:22:53.000000000 -0500
+++ linux-2.6.5.w/security/selinux/ss/services.c	2004-04-04 00:48:37.875567312 -0500
@@ -1187,6 +1187,18 @@ out:
 	return rc;
 }
 
+static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
+{
+	int i, fail = 0;
+	
+	for(i = 0; i < 4; i++)
+		if(addr[i] != (input[i] & mask[i])) {
+			fail = 1;
+			break;
+		}
+
+	return !fail;
+}
 
 /**
  * security_node_sid - Obtain the SID for a node (host).
@@ -1201,22 +1213,47 @@ int security_node_sid(u16 domain,
 		      u32 *out_sid)
 {
 	int rc = 0;
-	u32 addr;
 	struct ocontext *c;
 
 	POLICY_RDLOCK;
 
-	if (domain != AF_INET || addrlen != sizeof(u32)) {
-		*out_sid = SECINITSID_NODE;
-		goto out;
+	switch (domain) {
+	case AF_INET: {
+		u32 addr;
+		
+		if (addrlen != sizeof(u32)) {
+			rc = -EINVAL;
+			goto out;
+		}
+		
+		addr = *((u32 *)addrp);
+		
+		c = policydb.ocontexts[OCON_NODE];
+		while (c) {
+			if (c->u.node.addr == (addr & c->u.node.mask))
+				break;
+			c = c->next;
+		}
+		break;
 	}
-	addr = *((u32 *)addrp);
 
-	c = policydb.ocontexts[OCON_NODE];
-	while (c) {
-		if (c->u.node.addr == (addr & c->u.node.mask))
-			break;
-		c = c->next;
+	case AF_INET6:
+		if (addrlen != sizeof(u64) * 2) {
+			rc = -EINVAL;
+			goto out;
+		}
+		c = policydb.ocontexts[OCON_NODE6];
+		while (c) {
+			if (match_ipv6_addrmask(addrp, c->u.node6.addr,
+						c->u.node6.mask))
+				break;
+			c = c->next;
+		}
+		break;
+		
+	default:
+		*out_sid = SECINITSID_NODE;
+		goto out;
 	}
 
 	if (c) {

