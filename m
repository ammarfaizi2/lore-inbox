Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVJaMIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVJaMIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 07:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVJaMIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 07:08:49 -0500
Received: from send.forptr.21cn.com ([202.105.45.48]:47539 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S932071AbVJaMIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 07:08:48 -0500
Message-ID: <43660989.2000100@21cn.com>
Date: Mon, 31 Oct 2005 20:09:45 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH][MCAST]IPv6: Check packet size when process Multicast
 Address and Source Specific Query
References: <4365A995.3050404@21cn.com> <20051031.142717.40152885.yoshfuji@linux-ipv6.org>
In-Reply-To: <20051031.142717.40152885.yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: Pa1486OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> You cannot continue using mlh2, local copy of skb->h.raw
> after pskb_may_pull(). Please refresh it.
> 
> --yoshfuji
> 

My mistake. sorry.
I hope the new one is correct.

Regards
================================================================================
--- linux-2.6.14/net/ipv6/mcast.c	2005-10-30 23:09:33.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-10-31 14:16:19.000000000 +0800
@@ -1087,7 +1087,7 @@ static void mld_marksources(struct ifmca
 
 int igmp6_event_query(struct sk_buff *skb)
 {
-	struct mld2_query *mlh2 = (struct mld2_query *) skb->h.raw;
+	struct mld2_query *mlh2 = NULL;
 	struct ifmcaddr6 *ma;
 	struct in6_addr *group;
 	unsigned long max_delay;
@@ -1140,6 +1140,13 @@ int igmp6_event_query(struct sk_buff *sk
 		/* clear deleted report items */
 		mld_clear_delrec(idev);
 	} else if (len >= 28) {
+		int srcs_offset = sizeof(struct mld2_query) - 
+				  sizeof(struct icmp6hdr);
+		if (!pskb_may_pull(skb, srcs_offset)) {
+			in6_dev_put(idev);
+			return -EINVAL;
+		}
+		mlh2 = (struct mld2_query *) skb->h.raw;
 		max_delay = (MLDV2_MRC(ntohs(mlh2->mrc))*HZ)/1000;
 		if (!max_delay)
 			max_delay = 1;
@@ -1156,7 +1163,15 @@ int igmp6_event_query(struct sk_buff *sk
 			return 0;
 		}
 		/* mark sources to include, if group & source-specific */
-		mark = mlh2->nsrcs != 0;
+		if (mlh2->nsrcs != 0) {
+			if (!pskb_may_pull(skb, srcs_offset + 
+				mlh2->nsrcs * sizeof(struct in6_addr))) {
+				in6_dev_put(idev);
+				return -EINVAL;
+			}
+			mlh2 = (struct mld2_query *) skb->h.raw;
+			mark = 1;
+		}
 	} else {
 		in6_dev_put(idev);
 		return -EINVAL;
