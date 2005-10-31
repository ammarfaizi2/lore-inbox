Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVJaFTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVJaFTM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVJaFTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:19:12 -0500
Received: from send.forptr.21cn.com ([202.105.45.51]:38646 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1750999AbVJaFTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:19:11 -0500
Message-ID: <4365A995.3050404@21cn.com>
Date: Mon, 31 Oct 2005 13:20:21 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
Subject: [PATCH][MCAST]IPv6: Check packet size when process Multicast Address
 and Source Specific Query
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: UcYG26OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Yan Zheng <yanzheng@21cn.com>

Index: net/ipv6/mcast.c
================================================================================
--- linux-2.6.14/net/ipv6/mcast.c	2005-10-30 23:09:33.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-10-31 13:13:10.000000000 +0800
@@ -1156,7 +1156,12 @@ int igmp6_event_query(struct sk_buff *sk
 			return 0;
 		}
 		/* mark sources to include, if group & source-specific */
-		mark = mlh2->nsrcs != 0;
+		if (mlh2->nsrcs != 0) {
+			if (!pskb_may_pull(skb, mlh2->nsrcs * sizeof(struct in6_addr) +
+				(sizeof(struct mld2_query) - sizeof(struct icmp6hdr))))
+				return -EINVAL;
+			mark = 1;
+		}
 	} else {
 		in6_dev_put(idev);
 		return -EINVAL;
