Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVCWLcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVCWLcf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 06:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCWLcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 06:32:35 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:60427 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261539AbVCWLcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 06:32:33 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: yxie@cs.stanford.edu (Yichen Xie)
Subject: Re: memory leak in net/sched/ipt.c?
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, davem@davemloft.net,
       kaber@trash.net, hadi@cyberus.ca
Organization: Core
In-Reply-To: <Pine.LNX.4.61.0503230011090.4207@kaki.stanford.edu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DE44X-0001QM-00@gondolin.me.apana.org.au>
Date: Wed, 23 Mar 2005 22:30:49 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yichen Xie <yxie@cs.stanford.edu> wrote:
> Is the memory block allocated on line 315 leaked every time tcp_ipt_dump 
> is called?

It seems to be.  This patch should free it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

BTW, please report networking bugs to netdev@oss.sgi.com.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
===== net/sched/ipt.c 1.14 vs edited =====
--- 1.14/net/sched/ipt.c	2005-02-07 16:39:40 +11:00
+++ edited/net/sched/ipt.c	2005-03-23 22:28:13 +11:00
@@ -284,10 +284,12 @@
 	tm.lastuse = jiffies_to_clock_t(jiffies - p->tm.lastuse);
 	tm.expires = jiffies_to_clock_t(p->tm.expires);
 	RTA_PUT(skb, TCA_IPT_TM, sizeof (tm), &tm);
+	kfree(t);
 	return skb->len;
 
       rtattr_failure:
 	skb_trim(skb, b - skb->data);
+	kfree(t);
 	return -1;
 }
 
