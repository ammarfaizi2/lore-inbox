Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267929AbTBEMJw>; Wed, 5 Feb 2003 07:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267930AbTBEMJw>; Wed, 5 Feb 2003 07:09:52 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:11283 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267929AbTBEMJu>; Wed, 5 Feb 2003 07:09:50 -0500
Date: Wed, 5 Feb 2003 23:19:14 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Andy Chou <acc@CS.Stanford.EDU>
cc: linux-kernel@vger.kernel.org, <mc@CS.Stanford.EDU>,
       "David S. Miller" <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>
Subject: [PATCH] Re: [CHECKER] 112 potential memory leaks in 2.5.48
In-Reply-To: <20030205011353.GA17941@Xenon.Stanford.EDU>
Message-ID: <Pine.LNX.4.44.0302052259590.28037-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Andy Chou wrote:

> [BUG] [GEM] The case where __dev_get_by_index() returns 0, followed by goto out.
> /u1/acc/linux/2.5.48/net/ipv4/route.c:2229:inet_rtm_getroute: 
> ERROR:LEAK:2166:2229:Memory leak

Here's a fix for 2.5.59.

- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.59.orig/net/ipv4/route.c linux-2.5.59.w1/net/ipv4/route.c
--- linux-2.5.59.orig/net/ipv4/route.c	Thu Jan 16 22:51:35 2003
+++ linux-2.5.59.w1/net/ipv4/route.c	Wed Feb  5 22:51:48 2003
@@ -2288,7 +2288,7 @@
 		struct net_device *dev = __dev_get_by_index(iif);
 		err = -ENODEV;
 		if (!dev)
-			goto out;
+			goto out_free;
 		skb->protocol	= htons(ETH_P_IP);
 		skb->dev	= dev;
 		local_bh_disable();
@@ -2307,10 +2307,8 @@
 		fl.oif = oif;
 		err = ip_route_output_key(&rt, &fl);
 	}
-	if (err) {
-		kfree_skb(skb);
-		goto out;
-	}
+	if (err)
+		goto out_free;
 
 	skb->dst = &rt->u.dst;
 	if (rtm->rtm_flags & RTM_F_NOTIFY)
@@ -2321,16 +2319,20 @@
 	err = rt_fill_info(skb, NETLINK_CB(in_skb).pid, nlh->nlmsg_seq,
 				RTM_NEWROUTE, 0);
 	if (!err)
-		goto out;
+		goto out_free;
 	if (err < 0) {
 		err = -EMSGSIZE;
-		goto out;
+		goto out_free;
 	}
 
 	err = netlink_unicast(rtnl, skb, NETLINK_CB(in_skb).pid, MSG_DONTWAIT);
 	if (err > 0)
 		err = 0;
 out:	return err;
+
+out_free:
+	kfree_skb(skb);
+	goto out;
 }
 
 int ip_rt_dump(struct sk_buff *skb,  struct netlink_callback *cb)


