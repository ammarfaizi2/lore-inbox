Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVGYCPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVGYCPI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 22:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVGYCPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 22:15:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20398
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261592AbVGYCPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 22:15:04 -0400
Date: Sun, 24 Jul 2005 19:15:05 -0700 (PDT)
Message-Id: <20050724.191505.69244686.davem@davemloft.net>
To: laforge@netfilter.org
Cc: yoshfuji@linux-ipv6.org, johnpol@2ka.mipt.ru,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1 Wire drivers illegally overload NETLINK_NFLOG
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050723133353.GB11177@rama>
References: <20050723125427.GA11177@rama>
	<20050722.230559.123762041.yoshfuji@linux-ipv6.org>
	<20050723133353.GB11177@rama>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Welte <laforge@netfilter.org>
Date: Sat, 23 Jul 2005 09:33:53 -0400

> I strongly disrecommend increasing NPROTO.  Maybe we should look into
> reusing NETLINK_FIREWALL (which was an old 2.2.x kernel interface).

ip_queue.c still uses NETLINK_FIREWALL so we really can't use
that.

So instead, as in the patch below, I solved this for now by using
the NETLINK_SKIP value which was reserved years ago yet never
made use of.

diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -88,7 +88,7 @@ static struct w1_master * w1_alloc_dev(u
 
 	dev->groups = 23;
 	dev->seq = 1;
-	dev->nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
+	dev->nls = netlink_kernel_create(NETLINK_W1, NULL);
 	if (!dev->nls) {
 		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
 			NETLINK_NFLOG, dev->dev.bus_id);
diff --git a/include/linux/netlink.h b/include/linux/netlink.h
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 
 #define NETLINK_ROUTE		0	/* Routing/device hook				*/
-#define NETLINK_SKIP		1	/* Reserved for ENskip  			*/
+#define NETLINK_W1		1	/* 1-wire subsystem				*/
 #define NETLINK_USERSOCK	2	/* Reserved for user mode socket protocols 	*/
 #define NETLINK_FIREWALL	3	/* Firewalling hook				*/
 #define NETLINK_TCPDIAG		4	/* TCP socket monitoring			*/
