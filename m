Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUAMSbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUAMSbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:31:33 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:26684 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265125AbUAMSbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:31:04 -0500
Date: Tue, 13 Jan 2004 13:30:55 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <selinux@tycho.nsa.gov>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [PATCH][SELINUX] 1/1 Improve skb audit logging
Message-ID: <Xine.LNX.4.44.0401131318410.6829-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.1-mm2 is a rework of the skb audit logging code in
SELinux.  Rather than relying on skb header pointers, it parses the skb
for specific protocols (TCP and UDP for IPv4 at this stage).  This is
safer for the case of locally generated raw packets, which can be
malformed.  It also now takes fragmented skbs into account.  The new code
allows the caller to parse the skb so that parsed information can be more
readily re-used.

Please apply.

 security/selinux/avc.c         |   46 ++------------------------
 security/selinux/hooks.c       |   72 ++++++++++++++++++++++++++++++++++++++---
 security/selinux/include/avc.h |    4 +-
 3 files changed, 75 insertions(+), 47 deletions(-)

diff -urN -X dontdiff linux-2.6.1-rc3.pending/security/selinux/avc.c linux-2.6.1-rc3.w1/security/selinux/avc.c
--- linux-2.6.1-rc3.pending/security/selinux/avc.c	2004-01-08 10:38:49.000000000 -0500
+++ linux-2.6.1-rc3.w1/security/selinux/avc.c	2004-01-08 13:53:28.238451616 -0500
@@ -22,8 +22,6 @@
 #include <linux/un.h>
 #include <net/af_unix.h>
 #include <linux/ip.h>
-#include <linux/udp.h>
-#include <linux/tcp.h>
 #include "avc.h"
 #include "avc_ss.h"
 #include "class_to_string.h"
@@ -640,46 +638,12 @@
 					break;
 				}
 			}
-			if (a->u.net.daddr) {
-				printk(" daddr=%d.%d.%d.%d",
-				       NIPQUAD(a->u.net.daddr));
-				if (a->u.net.port)
-					printk(" dest=%d", a->u.net.port);
-			} else if (a->u.net.saddr) {
-				printk(" saddr=%d.%d.%d.%d",
-				       NIPQUAD(a->u.net.saddr));
-				if (a->u.net.port)
-					printk(" src=%d", a->u.net.port);
-			} else if (a->u.net.port)
-				printk(" port=%d", a->u.net.port);
-			if (a->u.net.skb) {
-				struct sk_buff *skb = a->u.net.skb;
-
-				if ((skb->protocol == htons(ETH_P_IP)) &&
-				     skb->nh.iph) {
-					u16 source = 0, dest = 0;
-					u8  protocol = skb->nh.iph->protocol;
-
-
-					if (protocol == IPPROTO_TCP &&
-					    skb->h.th) {
-						source = skb->h.th->source;
-						dest = skb->h.th->dest;
-					}
-					if (protocol == IPPROTO_UDP &&
-					    skb->h.uh) {
-						source = skb->h.uh->source;
-						dest = skb->h.uh->dest;
-					}
+			
+			avc_print_ipv4_addr(a->u.net.saddr, a->u.net.sport,
+			                    "saddr", "src");
+			avc_print_ipv4_addr(a->u.net.daddr, a->u.net.dport,
+			                    "daddr", "dest");
 
-					avc_print_ipv4_addr(skb->nh.iph->saddr,
-					                    source,
-					                    "saddr", "source");
-					avc_print_ipv4_addr(skb->nh.iph->daddr,
-					                    dest,
-					                    "daddr", "dest");
-				}
-			}
 			if (a->u.net.netif)
 				printk(" netif=%s", a->u.net.netif);
 			break;
diff -urN -X dontdiff linux-2.6.1-rc3.pending/security/selinux/hooks.c linux-2.6.1-rc3.w1/security/selinux/hooks.c
--- linux-2.6.1-rc3.pending/security/selinux/hooks.c	2004-01-08 10:38:46.000000000 -0500
+++ linux-2.6.1-rc3.w1/security/selinux/hooks.c	2004-01-08 12:31:57.000000000 -0500
@@ -56,6 +56,7 @@
 #include <linux/netdevice.h>	/* for network interface checks */
 #include <linux/netlink.h>
 #include <linux/tcp.h>
+#include <linux/udp.h>
 #include <linux/quota.h>
 #include <linux/un.h>		/* for Unix socket types */
 #include <net/af_unix.h>	/* for Unix socket types */
@@ -2372,6 +2373,69 @@
 
 #ifdef CONFIG_SECURITY_NETWORK
 
+static void selinux_parse_skb_ipv4(struct sk_buff *skb, struct avc_audit_data *ad)
+{
+	int dlen, ihlen;
+	struct iphdr *iph;
+
+	if (skb->len < sizeof(struct iphdr))
+		goto out;
+	
+	iph = skb->nh.iph;
+	ihlen = iph->ihl * 4;
+	if (ihlen < sizeof(struct iphdr))
+		goto out;
+
+	dlen = skb->len - ihlen;
+	ad->u.net.saddr = iph->saddr;
+	ad->u.net.daddr = iph->daddr;
+
+	switch (iph->protocol) {
+        case IPPROTO_TCP: {
+        	int offset;
+        	struct tcphdr tcph;
+
+        	if (ntohs(iph->frag_off) & IP_OFFSET)
+        		break;
+        		
+		if (dlen < sizeof(tcph))
+			break;
+
+		offset = skb->nh.raw - skb->data + ihlen;
+		if (skb_copy_bits(skb, offset, &tcph, sizeof(tcph)) < 0)
+			break;
+
+		ad->u.net.sport = tcph.source;
+		ad->u.net.dport = tcph.dest;
+		break;
+        }
+        
+        case IPPROTO_UDP: {
+        	int offset;
+        	struct udphdr udph;
+        	
+        	if (ntohs(iph->frag_off) & IP_OFFSET)
+        		break;
+        		
+        	if (dlen < sizeof(udph))
+        		break;
+
+		offset = skb->nh.raw - skb->data + ihlen;
+        	if (skb_copy_bits(skb, offset, &udph, sizeof(udph)) < 0)
+        		break;	
+
+        	ad->u.net.sport = udph.source;
+        	ad->u.net.dport = udph.dest;
+        	break;
+        }
+
+        default:
+        	break;
+        }
+out:
+	return;
+}
+
 /* socket security operations */
 static int socket_has_perm(struct task_struct *task, struct socket *sock,
 			   u32 perms)
@@ -2460,7 +2524,7 @@
 			if (err)
 				goto out;
 			AVC_AUDIT_DATA_INIT(&ad,NET);
-			ad.u.net.port = snum;
+			ad.u.net.sport = htons(snum);
 			err = avc_has_perm(isec->sid, sid,
 					   isec->sclass,
 					   SOCKET__NAME_BIND, NULL, &ad);
@@ -2488,7 +2552,7 @@
 			goto out;
 		
 		AVC_AUDIT_DATA_INIT(&ad,NET);
-		ad.u.net.port = snum;
+		ad.u.net.sport = htons(snum);
 		ad.u.net.saddr = addr->sin_addr.s_addr;
 		err = avc_has_perm(isec->sid, sid,
 		                   isec->sclass, node_perm, NULL, &ad);
@@ -2686,7 +2750,7 @@
 
 	AVC_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.netif = dev->name;
-	ad.u.net.skb = skb;
+	selinux_parse_skb_ipv4(skb, &ad);
 
 	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
 	                   netif_perm, &nsec->avcr, &ad);
@@ -2812,7 +2876,7 @@
 
 	AVC_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.netif = dev->name;
-	ad.u.net.skb = skb;
+	selinux_parse_skb_ipv4(skb, &ad);
 
 	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
 	                   netif_perm, &nsec->avcr, &ad) ? NF_DROP : NF_ACCEPT;
diff -urN -X dontdiff linux-2.6.1-rc3.pending/security/selinux/include/avc.h linux-2.6.1-rc3.w1/security/selinux/include/avc.h
--- linux-2.6.1-rc3.pending/security/selinux/include/avc.h	2004-01-08 10:38:40.000000000 -0500
+++ linux-2.6.1-rc3.w1/security/selinux/include/avc.h	2004-01-08 11:55:20.000000000 -0500
@@ -63,9 +63,9 @@
 		} fs;
 		struct {
 			char *netif;
-			struct sk_buff *skb;
 			struct sock *sk;
-			u16 port;
+			u16 dport;
+			u16 sport;
 			u32 daddr;
 			u32 saddr;
 		} net;









