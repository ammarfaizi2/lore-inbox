Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVKIMeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKIMeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 07:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVKIMeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 07:34:17 -0500
Received: from send.forptr.21cn.com ([202.105.45.50]:62939 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1750708AbVKIMeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 07:34:16 -0500
Message-ID: <4371ED0E.3030501@21cn.com>
Date: Wed, 09 Nov 2005 20:35:26 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
CC: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: [PATCH][MCAST]Check packet size when process Multicast Address and
 Source Specific Query
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: uPJLp9OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The patch changes the old one to equivalent code in IGMPv3 as David Stevens's suggestion
http://lkml.org/lkml/2005/10/31/221


Regards

Signed-off-by: Yan Zheng<yanzheng@21cn.com>

Index:net/ipv6/mcast.c
============================================================== 

--- linux-2.6.14/net/ipv6/mcast.c	2005-11-09 16:00:48.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-11-09 16:20:03.000000000 +0800
@@ -1149,6 +1149,14 @@ int igmp6_event_query(struct sk_buff *sk
 			return -EINVAL;
 		}
 		mlh2 = (struct mld2_query *) skb->h.raw;
+		if (mlh2->nsrcs != 0) {
+			if (!pskb_may_pull(skb, srcs_offset +
+				mlh2->nsrcs * sizeof(struct in6_addr))) {
+				in6_dev_put(idev);
+				return -EINVAL;
+			}
+			mlh2 = (struct mld2_query *) skb->h.raw;
+		}
 		max_delay = (MLDV2_MRC(ntohs(mlh2->mrc))*HZ)/1000;
 		if (!max_delay)
 			max_delay = 1;
@@ -1165,15 +1173,7 @@ int igmp6_event_query(struct sk_buff *sk
 			return 0;
 		}
 		/* mark sources to include, if group & source-specific */
-		if (mlh2->nsrcs != 0) {
-			if (!pskb_may_pull(skb, srcs_offset + 
-				mlh2->nsrcs * sizeof(struct in6_addr))) {
-				in6_dev_put(idev);
-				return -EINVAL;
-			}
-			mlh2 = (struct mld2_query *) skb->h.raw;
-			mark = 1;
-		}
+		mark = mlh2->nsrcs != 0;
 	} else {
 		in6_dev_put(idev);
 		return -EINVAL;

