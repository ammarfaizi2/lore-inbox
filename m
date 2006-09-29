Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161239AbWI2AoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbWI2AoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWI2AoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:44:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:59371 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161239AbWI2AoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:44:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XGI5hLYLmknykzh1q2YKgRaPH0pPeIZo84SvsxVU9v/vQzqppiahNProt9tRf8ePnBrs30MyvdfHM+QYCiRAW4bxWkkcqhXwpG2jiOAAGJicBn3eCtQCUQ1Mq/jS5T6OUTl0a9mHQfKdwNVCzVNQa171HEu5vW+43KCuxI1wVJA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IPv6/DCCP: Fix memory leak in dccp_v6_do_rcv()
Date: Fri, 29 Sep 2006 02:45:33 +0200
User-Agent: KMail/1.9.4
Cc: netdev@vger.kernel.org, dccp@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       "David S. Miller" <davem@davemloft.net>,
       Pekka Savola <pekkas@netcore.fi>, James Morris <jmorris@namei.org>,
       Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
       Patrick McHardy <kaber@coreworks.de>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609290245.33618.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity found what looks like a real leak in net/dccp/ipv6.c::dccp_v6_do_rcv()

We may leave via the return inside "if (sk->sk_state == DCCP_OPEN) {"
but at that point we may have allocated opt_skb, but we never free it
in that path before the return.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 net/dccp/ipv6.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.18-git10-orig/net/dccp/ipv6.c	2006-09-28 22:40:07.000000000 +0200
+++ linux-2.6.18-git10/net/dccp/ipv6.c	2006-09-29 02:35:15.000000000 +0200
@@ -997,6 +997,8 @@ static int dccp_v6_do_rcv(struct sock *s
 	if (sk->sk_state == DCCP_OPEN) { /* Fast path */
 		if (dccp_rcv_established(sk, skb, dccp_hdr(skb), skb->len))
 			goto reset;
+		if (opt_skb)
+			__kfree_skb(opt_skb);
 		return 0;
 	}
 





PS. Please keep me on Cc:

-- 
Jesper Juhl <jesper.juhl@gmail.com>





