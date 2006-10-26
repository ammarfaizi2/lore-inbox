Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423483AbWJZNDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423483AbWJZNDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423479AbWJZNDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:03:24 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:48401 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423480AbWJZNDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:03:22 -0400
Date: Thu, 26 Oct 2006 15:03:17 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [patch 3/5] net: fix uaccess handling
Message-ID: <20061026130317.GD7127@osiris.boeblingen.de.ibm.com>
References: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 net/ipv4/raw.c           |   17 +++++++++++------
 net/ipv6/raw.c           |   17 +++++++++++------
 net/netlink/af_netlink.c |    5 +++--
 3 files changed, 25 insertions(+), 14 deletions(-)

Index: linux-2.6/net/ipv4/raw.c
===================================================================
--- linux-2.6.orig/net/ipv4/raw.c	2006-10-26 14:40:56.000000000 +0200
+++ linux-2.6/net/ipv4/raw.c	2006-10-26 14:42:12.000000000 +0200
@@ -329,7 +329,7 @@
 	return err; 
 }
 
-static void raw_probe_proto_opt(struct flowi *fl, struct msghdr *msg)
+static int raw_probe_proto_opt(struct flowi *fl, struct msghdr *msg)
 {
 	struct iovec *iov;
 	u8 __user *type = NULL;
@@ -338,7 +338,7 @@
 	unsigned int i;
 
 	if (!msg->msg_iov)
-		return;
+		return 0;
 
 	for (i = 0; i < msg->msg_iovlen; i++) {
 		iov = &msg->msg_iov[i];
@@ -360,8 +360,9 @@
 				code = iov->iov_base;
 
 			if (type && code) {
-				get_user(fl->fl_icmp_type, type);
-			        get_user(fl->fl_icmp_code, code);
+				if (get_user(fl->fl_icmp_type, type) ||
+				    get_user(fl->fl_icmp_code, code))
+					return -EFAULT;
 				probed = 1;
 			}
 			break;
@@ -372,6 +373,7 @@
 		if (probed)
 			break;
 	}
+	return 0;
 }
 
 static int raw_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
@@ -480,8 +482,11 @@
 				    .proto = inet->hdrincl ? IPPROTO_RAW :
 					    		     sk->sk_protocol,
 				  };
-		if (!inet->hdrincl)
-			raw_probe_proto_opt(&fl, msg);
+		if (!inet->hdrincl) {
+			err = raw_probe_proto_opt(&fl, msg);
+			if (err)
+				goto done;
+		}
 
 		security_sk_classify_flow(sk, &fl);
 		err = ip_route_output_flow(&rt, &fl, sk, !(msg->msg_flags&MSG_DONTWAIT));
Index: linux-2.6/net/ipv6/raw.c
===================================================================
--- linux-2.6.orig/net/ipv6/raw.c	2006-10-26 14:40:56.000000000 +0200
+++ linux-2.6/net/ipv6/raw.c	2006-10-26 14:42:12.000000000 +0200
@@ -604,7 +604,7 @@
 	return err; 
 }
 
-static void rawv6_probe_proto_opt(struct flowi *fl, struct msghdr *msg)
+static int rawv6_probe_proto_opt(struct flowi *fl, struct msghdr *msg)
 {
 	struct iovec *iov;
 	u8 __user *type = NULL;
@@ -616,7 +616,7 @@
 	int i;
 
 	if (!msg->msg_iov)
-		return;
+		return 0;
 
 	for (i = 0; i < msg->msg_iovlen; i++) {
 		iov = &msg->msg_iov[i];
@@ -638,8 +638,9 @@
 				code = iov->iov_base;
 
 			if (type && code) {
-				get_user(fl->fl_icmp_type, type);
-				get_user(fl->fl_icmp_code, code);
+				if (get_user(fl->fl_icmp_type, type) ||
+				    get_user(fl->fl_icmp_code, code))
+					return -EFAULT;
 				probed = 1;
 			}
 			break;
@@ -650,7 +651,8 @@
 			/* check if type field is readable or not. */
 			if (iov->iov_len > 2 - len) {
 				u8 __user *p = iov->iov_base;
-				get_user(fl->fl_mh_type, &p[2 - len]);
+				if (get_user(fl->fl_mh_type, &p[2 - len]))
+					return -EFAULT;
 				probed = 1;
 			} else
 				len += iov->iov_len;
@@ -664,6 +666,7 @@
 		if (probed)
 			break;
 	}
+	return 0;
 }
 
 static int rawv6_sendmsg(struct kiocb *iocb, struct sock *sk,
@@ -787,7 +790,9 @@
 	opt = ipv6_fixup_options(&opt_space, opt);
 
 	fl.proto = proto;
-	rawv6_probe_proto_opt(&fl, msg);
+	err = rawv6_probe_proto_opt(&fl, msg);
+	if (err)
+		goto out;
  
 	ipv6_addr_copy(&fl.fl6_dst, daddr);
 	if (ipv6_addr_any(&fl.fl6_src) && !ipv6_addr_any(&np->saddr))
Index: linux-2.6/net/netlink/af_netlink.c
===================================================================
--- linux-2.6.orig/net/netlink/af_netlink.c	2006-10-26 14:40:56.000000000 +0200
+++ linux-2.6/net/netlink/af_netlink.c	2006-10-26 14:42:12.000000000 +0200
@@ -1075,8 +1075,9 @@
 			return -EINVAL;
 		len = sizeof(int);
 		val = nlk->flags & NETLINK_RECV_PKTINFO ? 1 : 0;
-		put_user(len, optlen);
-		put_user(val, optval);
+		if (put_user(len, optlen) ||
+		    put_user(val, optval))
+			return -EFAULT;
 		err = 0;
 		break;
 	default:
