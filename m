Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWHUSrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWHUSrz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWHUSrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:47:55 -0400
Received: from ns1.suse.de ([195.135.220.2]:35206 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750724AbWHUSrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:47:52 -0400
Date: Mon, 21 Aug 2006 11:46:18 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 05/20] Fix IFLA_ADDRESS handling
Message-ID: <20060821184618.GF21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-ifla_address-handling.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Miller <davem@davemloft.net>

[RTNETLINK]: Fix IFLA_ADDRESS handling.

The ->set_mac_address handlers expect a pointer to a
sockaddr which contains the MAC address, whereas
IFLA_ADDRESS provides just the MAC address itself.

So whip up a sockaddr to wrap around the netlink
attribute for the ->set_mac_address call.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/core/rtnetlink.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- linux-2.6.17.8.orig/net/core/rtnetlink.c
+++ linux-2.6.17.8/net/core/rtnetlink.c
@@ -395,6 +395,9 @@ static int do_setlink(struct sk_buff *sk
 	}
 
 	if (ida[IFLA_ADDRESS - 1]) {
+		struct sockaddr *sa;
+		int len;
+
 		if (!dev->set_mac_address) {
 			err = -EOPNOTSUPP;
 			goto out;
@@ -406,7 +409,17 @@ static int do_setlink(struct sk_buff *sk
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

--
