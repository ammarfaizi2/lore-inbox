Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267930AbTBEMKn>; Wed, 5 Feb 2003 07:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267931AbTBEMKn>; Wed, 5 Feb 2003 07:10:43 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:12819 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267930AbTBEMKl>; Wed, 5 Feb 2003 07:10:41 -0500
Date: Wed, 5 Feb 2003 23:20:08 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Andy Chou <acc@CS.Stanford.EDU>
cc: linux-kernel@vger.kernel.org, <mc@CS.Stanford.EDU>,
       "David S. Miller" <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>
Subject: Re: [CHECKER] 112 potential memory leaks in 2.5.48
In-Reply-To: <20030205011353.GA17941@Xenon.Stanford.EDU>
Message-ID: <Pine.LNX.4.44.0302052302160.28037-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Andy Chou wrote:

> [BUG] /u1/acc/linux/2.5.48/net/ipv6/route.c:1583:inet6_rtm_getroute: 
> ERROR:LEAK:1556:1583:Memory leak

Here's the ipv6 fix.


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.59.orig/net/ipv6/route.c linux-2.5.59.w1/net/ipv6/route.c
--- linux-2.5.59.orig/net/ipv6/route.c	Tue Nov 12 00:12:07 2002
+++ linux-2.5.59.w1/net/ipv6/route.c	Wed Feb  5 23:00:17 2003
@@ -1548,14 +1548,14 @@
 {
 	struct rtattr **rta = arg;
 	int iif = 0;
-	int err;
+	int err = -ENOBUFS;
 	struct sk_buff *skb;
 	struct flowi fl;
 	struct rt6_info *rt;
 
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (skb == NULL)
-		return -ENOBUFS;
+		goto out;
 
 	/* Reserve room for dummy headers, this skb can pass
 	   through good chunk of routing engine.
@@ -1579,8 +1579,10 @@
 	if (iif) {
 		struct net_device *dev;
 		dev = __dev_get_by_index(iif);
-		if (!dev)
-			return -ENODEV;
+		if (!dev) {
+			err = -ENODEV;
+			goto out_free;
+		}
 	}
 
 	fl.oif = 0;
@@ -1597,13 +1599,19 @@
 			    fl.nl_u.ip6_u.saddr,
 			    iif,
 			    RTM_NEWROUTE, NETLINK_CB(in_skb).pid, nlh->nlmsg_seq);
-	if (err < 0)
-		return -EMSGSIZE;
+	if (err < 0) {
+		err = -EMSGSIZE;
+		goto out_free;
+	}
 
 	err = netlink_unicast(rtnl, skb, NETLINK_CB(in_skb).pid, MSG_DONTWAIT);
-	if (err < 0)
-		return err;
-	return 0;
+	if (err > 0)
+		err = 0;
+out:
+	return err;
+out_free:
+	kfree_skb(skb);
+	goto out;	
 }
 
 void inet6_rt_notify(int event, struct rt6_info *rt)


