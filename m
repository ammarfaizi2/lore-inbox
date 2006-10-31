Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946051AbWJaWGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946051AbWJaWGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946048AbWJaWGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:06:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60089 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946047AbWJaWGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:06:01 -0500
Date: Tue, 31 Oct 2006 17:06:00 -0500
From: Andy Gospodarek <andy@greyhouse.net>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] 2.6.19-rc4 - netlink messages created with bad flags in soft_irq context
Message-ID: <20061031220559.GA10119@gospo.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a kernel built where 

CONFIG_DEBUG_SPINLOCK_SLEEP=y

is in the config and I've noticed some interesting behavior when
bringing up bonds in balance-alb mode.  When I start to enslave devices
to a bond I get the following in the ring buffer:

BUG: sleeping function called from invalid context at mm/slab.c:3007
in_atomic():1, irqs_disabled():0

along with a nice backtrace of the error that pointed to the cause of
this message.  The bonding code was calling for the device to set its
MAC address and the netlink message that would be send as a result of
this notification was being created with the flag GFP_KERNEL instead of
GFP_ATOMIC.  

After I did this, I noticed I didn't completely clear the error (since
this call eventually tries to talk the rtnl_lock), but it gets us
closer.  I'm still trying to decide how best to approach the remaining
problem and will hopefully post a solution soon, but I wanted to get
this in and/or get some feedback on this patch/direction first.


Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
---

 rtnetlink.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 221e403..93d6fb3 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -159,7 +159,7 @@ int rtnetlink_send(struct sk_buff *skb, 
 	NETLINK_CB(skb).dst_group = group;
 	if (echo)
 		atomic_inc(&skb->users);
-	netlink_broadcast(rtnl, skb, pid, group, GFP_KERNEL);
+	netlink_broadcast(rtnl, skb, pid, group, GFP_ATOMIC);
 	if (echo)
 		err = netlink_unicast(rtnl, skb, pid, MSG_DONTWAIT);
 	return err;
@@ -589,7 +589,7 @@ #endif	/* CONFIG_NET_WIRELESS_RTNETLINK 
 
 	payload = NLMSG_ALIGN(sizeof(struct ifinfomsg) +
 			      nla_total_size(iw_buf_len));
-	nskb = nlmsg_new(nlmsg_total_size(payload), GFP_KERNEL);
+	nskb = nlmsg_new(nlmsg_total_size(payload), GFP_ATOMIC);
 	if (nskb == NULL) {
 		err = -ENOBUFS;
 		goto errout;
@@ -639,7 +639,7 @@ void rtmsg_ifinfo(int type, struct net_d
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb = nlmsg_new(NLMSG_GOODSIZE, GFP_ATOMIC);
 	if (skb == NULL)
 		goto errout;
 
@@ -649,7 +649,7 @@ void rtmsg_ifinfo(int type, struct net_d
 		goto errout;
 	}
 
-	err = rtnl_notify(skb, 0, RTNLGRP_LINK, NULL, GFP_KERNEL);
+	err = rtnl_notify(skb, 0, RTNLGRP_LINK, NULL, GFP_ATOMIC);
 errout:
 	if (err < 0)
 		rtnl_set_sk_err(RTNLGRP_LINK, err);
