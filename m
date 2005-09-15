Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbVIOBHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVIOBHX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbVIOBEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:04:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27585 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030309AbVIOBEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:04:42 -0400
Message-Id: <20050915010407.117847000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:50 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       "David S. Miller" <davem@davemloft.net>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Patrick McHardy <kaber@trash.net>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 07/11] [NETFILTER]: Fix DHCP + MASQUERADE problem
Content-Disposition: inline; filename=netfilter-fix-dhcp-masquerade-problem.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

In 2.6.13-rcX the MASQUERADE target was changed not to exclude local
packets for better source address consistency. This breaks DHCP clients
using UDP sockets when the DHCP requests are caught by a MASQUERADE rule
because the MASQUERADE target drops packets when no address is configured
on the outgoing interface. This patch makes it ignore packets with a
source address of 0.

Thanks to Rusty for this suggestion.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 net/ipv4/netfilter/ipt_MASQUERADE.c |    6 ++++++
 1 files changed, 6 insertions(+)

Index: linux-2.6.13.y/net/ipv4/netfilter/ipt_MASQUERADE.c
===================================================================
--- linux-2.6.13.y.orig/net/ipv4/netfilter/ipt_MASQUERADE.c
+++ linux-2.6.13.y/net/ipv4/netfilter/ipt_MASQUERADE.c
@@ -95,6 +95,12 @@ masquerade_target(struct sk_buff **pskb,
 	IP_NF_ASSERT(ct && (ctinfo == IP_CT_NEW || ctinfo == IP_CT_RELATED
 	                    || ctinfo == IP_CT_RELATED + IP_CT_IS_REPLY));
 
+	/* Source address is 0.0.0.0 - locally generated packet that is
+	 * probably not supposed to be masqueraded.
+	 */
+	if (ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip == 0)
+		return NF_ACCEPT;
+
 	mr = targinfo;
 	rt = (struct rtable *)(*pskb)->dst;
 	newsrc = inet_select_addr(out, rt->rt_gateway, RT_SCOPE_UNIVERSE);

--
