Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285030AbRLQGIT>; Mon, 17 Dec 2001 01:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285025AbRLQGIJ>; Mon, 17 Dec 2001 01:08:09 -0500
Received: from f141.law7.hotmail.com ([216.33.237.141]:41224 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S285024AbRLQGH6>;
	Mon, 17 Dec 2001 01:07:58 -0500
X-Originating-IP: [216.117.88.41]
From: "Edward Killips" <etkillips@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Netfilter Oops Solved
Date: Mon, 17 Dec 2001 01:07:52 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F141o1ujjSkZSvx5bd600005006@hotmail.com>
X-OriginalArrivalTime: 17 Dec 2001 06:07:53.0081 (UTC) FILETIME=[29C71E90:01C186C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the problem in the netfilter code. In the file ipt_TOS.c the 
following code is wrong;
if(!nskb)
     return NF_DROP;
*pskb = nskb;            <---this should be down 1 line
kfree_skb(*pksb);        <-- pointer is freed here
iph = (*pksb)->nh.iph;   <-- freed pointer is used here.

The following patch fixes the problem.

--- ipt_TOS.c.orig	Mon Dec 17 00:33:50 2001
+++ ipt_TOS.c	Mon Dec 17 00:34:18 2001
@@ -27,8 +27,8 @@
			struct sk_buff *nskb = skb_copy(*pskb, GFP_ATOMIC);
			if (!nskb)
				return NF_DROP;
-			*pskb = nskb;
			kfree_skb(*pskb);
+			*pskb = nskb;
			iph = (*pskb)->nh.iph;
		}



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.

