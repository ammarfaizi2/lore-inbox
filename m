Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbVJaF1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbVJaF1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVJaF1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:27:15 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:39175 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751383AbVJaF1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:27:14 -0500
Date: Mon, 31 Oct 2005 14:27:17 +0900 (JST)
Message-Id: <20051031.142717.40152885.yoshfuji@linux-ipv6.org>
To: yanzheng@21cn.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dlstevens@us.ibm.com,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH][MCAST]IPv6: Check packet size when process Multicast
 Address and Source Specific Query
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <4365A995.3050404@21cn.com>
References: <4365A995.3050404@21cn.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4365A995.3050404@21cn.com> (at Mon, 31 Oct 2005 13:20:21 +0800), Yan Zheng <yanzheng@21cn.com> says:

> 
> Signed-off-by: Yan Zheng <yanzheng@21cn.com>
> 
> Index: net/ipv6/mcast.c
> ================================================================================
> --- linux-2.6.14/net/ipv6/mcast.c	2005-10-30 23:09:33.000000000 +0800
> +++ linux/net/ipv6/mcast.c	2005-10-31 13:13:10.000000000 +0800
> @@ -1156,7 +1156,12 @@ int igmp6_event_query(struct sk_buff *sk
>  			return 0;
>  		}
>  		/* mark sources to include, if group & source-specific */
> -		mark = mlh2->nsrcs != 0;
> +		if (mlh2->nsrcs != 0) {
> +			if (!pskb_may_pull(skb, mlh2->nsrcs * sizeof(struct in6_addr) +
> +				(sizeof(struct mld2_query) - sizeof(struct icmp6hdr))))
> +				return -EINVAL;
> +			mark = 1;
> +		}
>  	} else {
>  		in6_dev_put(idev);
>  		return -EINVAL;

You cannot continue using mlh2, local copy of skb->h.raw
after pskb_may_pull(). Please refresh it.

--yoshfuji
