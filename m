Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131351AbRCPVQf>; Fri, 16 Mar 2001 16:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRCPVQP>; Fri, 16 Mar 2001 16:16:15 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:19216 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131293AbRCPVQF>; Fri, 16 Mar 2001 16:16:05 -0500
Message-ID: <3ADB504B.691393B0@baldauf.org>
Date: Mon, 16 Apr 2001 22:04:27 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: linux-net@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [patch] ip_dynaddr re-enable
Content-Type: multipart/mixed;
 boundary="------------6F4B67A8FAAB7F931C583D88"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6F4B67A8FAAB7F931C583D88
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

about one or two months ago, I had the problem that
/proc/sys/net/ipv4/ip_dynaddr did not work. I analyzed the
problem and somehow came to a solution which I have
forgotten. But a patch which solved the problem against
2.4.1 which also works for 2.4.2-pre4 remained. Here it is.

Xu=E2n.



--------------6F4B67A8FAAB7F931C583D88
Content-Type: text/plain; charset=us-ascii;
 name="linux-2.4.ip_dynaddr.reenable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.ip_dynaddr.reenable.patch"

--- linux/net/ipv4/tcp_ipv4.c.orig	Tue Jan 30 11:37:56 2001
+++ linux/net/ipv4/tcp_ipv4.c	Tue Jan 30 13:31:14 2001
@@ -1774,6 +1774,11 @@
 	u32 daddr;
 	int err;
 
+	if (sysctl_ip_dynaddr > 2) {
+		printk(KERN_INFO "tcp_v4_rebuild_header(): sysctl_ip_dynaddr=%d, sk->userlocks=0x%x, rt==0x%x, src=%d.%d.%d.%d, sk->state=%d,sk->userlocks=0x%x.\n",
+		       sysctl_ip_dynaddr, sk->userlocks,rt,NIPQUAD(sk->saddr),sk->state,sk->userlocks);
+	}
+
 	/* Route is OK, nothing to do. */
 	if (rt != NULL)
 		return 0;
@@ -1783,9 +1788,26 @@
 	if(sk->protinfo.af_inet.opt && sk->protinfo.af_inet.opt->srr)
 		daddr = sk->protinfo.af_inet.opt->faddr;
 
+	if ((sysctl_ip_dynaddr) && (sk->state == TCP_SYN_SENT) && (!(sk->userlocks & SOCK_BINDADDR_LOCK)) ) {
+	    err = tcp_v4_reselect_saddr(sk);
+
+		if (sysctl_ip_dynaddr > 2) {
+			printk(KERN_INFO "tcp_v4_rebuild_header(): tcp_v4_reselect_saddr(sk)=%d.\n",err);
+		}
+	    
+	    if (err!=0) {
+		sk->err_soft=-err;
+		/* sk->error_report(sk); */
+	    }
+	}
+
 	err = ip_route_output(&rt, daddr, sk->saddr,
 			      RT_TOS(sk->protinfo.af_inet.tos) | RTO_CONN | sk->localroute,
 			      sk->bound_dev_if);
+	if (sysctl_ip_dynaddr > 2) {
+		printk(KERN_INFO "tcp_v4_rebuild_header(): err=%d.\n",
+		       err);
+	}
 	if (!err) {
 		__sk_dst_set(sk, &rt->u.dst);
 		/* sk->route_caps = rt->u.dst.dev->features; */

--------------6F4B67A8FAAB7F931C583D88--

