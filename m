Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161670AbWAMDVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161670AbWAMDVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161662AbWAMDUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:20:23 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35970 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161660AbWAMDTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:51 -0500
Message-Id: <20060113032247.495432000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:52 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Martin Murray <murrayma@citi.umich.edu>,
       " David S. Miller " <davem@davemloft.net>
Subject: [PATCH 14/17] [AF_NETLINK]: Fix DoS in netlink_rcv_skb() (CVE-2006-0035)
Content-Disposition: inline; filename=fix-DoS-in-netlink_rcv_skb.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Sanity check nlmsg_len during netlink_rcv_skb.  An nlmsg_len == 0 can
cause infinite loop in kernel, effectively DoSing machine.  Noted by
Matin Murray.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/netlink/af_netlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.y.orig/net/netlink/af_netlink.c
+++ linux-2.6.15.y/net/netlink/af_netlink.c
@@ -1422,7 +1422,7 @@ static int netlink_rcv_skb(struct sk_buf
 	while (skb->len >= nlmsg_total_size(0)) {
 		nlh = (struct nlmsghdr *) skb->data;
 
-		if (skb->len < nlh->nlmsg_len)
+		if (nlh->nlmsg_len < NLMSG_HDRLEN || skb->len < nlh->nlmsg_len)
 			return 0;
 
 		total_len = min(NLMSG_ALIGN(nlh->nlmsg_len), skb->len);

--
