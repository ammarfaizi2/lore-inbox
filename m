Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUDENvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUDENvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:51:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30900 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262459AbUDENvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:51:12 -0400
Date: Mon, 5 Apr 2004 09:51:07 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [SELINUX] 1/2 Make IPv6 code work with audit framework
Message-ID: <Xine.LNX.4.44.0404050949220.14610-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.5-mm1 makes the IPv6 code work with the audit 
framework, following the merge of both into -mm.

Please apply.


diff -urN -X dontdiff linux-2.6.5-mm1.p/security/selinux/avc.c linux-2.6.5-mm1.w/security/selinux/avc.c
--- linux-2.6.5-mm1.p/security/selinux/avc.c	2004-04-05 09:20:26.000000000 -0400
+++ linux-2.6.5-mm1.w/security/selinux/avc.c	2004-04-05 09:36:25.008751944 -0400
@@ -416,14 +416,15 @@
 	return rc;
 }
 
-static inline void avc_print_ipv6_addr(struct in6_addr *addr, u16 port,
+static inline void avc_print_ipv6_addr(struct audit_buffer *ab,
+				       struct in6_addr *addr, u16 port,
 				       char *name1, char *name2)
 {
 	if (!ipv6_addr_any(addr))
-		printk(" %s=%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
-		       name1, NIP6(*addr));
+		audit_log_format(ab, " %s=%04x:%04x:%04x:%04x:%04x:"
+				 "%04x:%04x:%04x", name1, NIP6(*addr));
 	if (port)
-		printk(" %s=%d", name2, ntohs(port));
+		audit_log_format(ab, " %s=%d", name2, ntohs(port));
 }
 
 static inline void avc_print_ipv4_addr(struct audit_buffer *ab, u32 addr,
@@ -570,10 +571,10 @@
 					struct inet_opt *inet = inet_sk(sk);
 					struct ipv6_pinfo *inet6 = inet6_sk(sk);
 
-					avc_print_ipv6_addr(&inet6->rcv_saddr,
+					avc_print_ipv6_addr(ab, &inet6->rcv_saddr,
 							    inet->sport,
 							    "laddr", "lport");
-					avc_print_ipv6_addr(&inet6->daddr,
+					avc_print_ipv6_addr(ab, &inet6->daddr,
 							    inet->dport,
 							    "faddr", "fport");
 					break;
@@ -611,10 +612,10 @@
 						    "daddr", "dest");
 				break;
 			case AF_INET6:
-				avc_print_ipv6_addr(&a->u.net.v6info.saddr,
+				avc_print_ipv6_addr(ab, &a->u.net.v6info.saddr,
 						    a->u.net.sport,
 						    "saddr", "src");
-				avc_print_ipv6_addr(&a->u.net.v6info.daddr,
+				avc_print_ipv6_addr(ab, &a->u.net.v6info.daddr,
 						    a->u.net.dport,
 						    "daddr", "dest");
 				break;

