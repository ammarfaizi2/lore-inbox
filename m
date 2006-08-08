Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWHHGf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWHHGf1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWHHGf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:35:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19170
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751248AbWHHGf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:35:26 -0400
Date: Mon, 07 Aug 2006 23:35:29 -0700 (PDT)
Message-Id: <20060807.233529.58454613.davem@davemloft.net>
To: pavlin@icir.org
Cc: linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: Bug in the RTM_SETLINK kernel API for setting MAC address 
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608080531.k785VxYL077237@possum.icir.org>
References: <davem@davemloft.net>
	<200608080531.k785VxYL077237@possum.icir.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavlin Radoslavov <pavlin@icir.org>
Date: Mon, 07 Aug 2006 22:31:59 -0700

> The real mismatch is that ida[IFLA_ADDRESS - 1] is (as you say)
> suppose to be a MAC address, but the set_mac_address() functions
> for each device assume that the RTA_DATA(ida[IFLA_ADDRESS - 1])
> payload is a sockaddr.

That's because ->set_mac_address() is usually invoked via
dev_set_mac_address() which in turn is invoked from places
SIOCSIFHWADDR ioctl() processing which does want the sockaddr
wrapped around the MAC address.

So the netlink code is definitely doing the wrong thing if
it wants merely the MAC address in the attribute.

Since changing all the drivers is a pain, what we probably
should do is have the netlink code allocate a sockaddr,
place the MAC address attribute in to that allocated sockaddr,
and pass it into ->set_mac_address().

This patch should do the trick, can you test it out?

Thanks.

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 20e5bb7..30cc1ba 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -394,6 +394,9 @@ static int do_setlink(struct sk_buff *sk
 	}
 
 	if (ida[IFLA_ADDRESS - 1]) {
+		struct sockaddr *sa;
+		int len;
+
 		if (!dev->set_mac_address) {
 			err = -EOPNOTSUPP;
 			goto out;
@@ -405,7 +408,17 @@ static int do_setlink(struct sk_buff *sk
 		if (ida[IFLA_ADDRESS - 1]->rta_len != RTA_LENGTH(dev->addr_len))
 			goto out;
 
-		err = dev->set_mac_address(dev, RTA_DATA(ida[IFLA_ADDRESS - 1]));
+		len = sizeof(sa_family_t) + dev->addr_len;
+		sa = kmalloc(len, GFP_KERNEL);
+		if (!sa) {
+			err = -ENOMEM;
+			goto out;
+		}
+		sa->sa_family = dev->type;
+		memcpy(sa->sa_data, RTA_DATA(ida[IFLA_ADDRESS - 1]),
+		       dev->addr_len);
+		err = dev->set_mac_address(dev, sa);
+		kfree(sa);
 		if (err)
 			goto out;
 		send_addr_notify = 1;
