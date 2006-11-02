Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752610AbWKBAUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbWKBAUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbWKBAUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:20:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:39833 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752610AbWKBAUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:20:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=V0K99OdH2HxTjA9KKO6e+XkOKmRUwirBfTDagZD1iF39cW4dxlTRxG9dnVxL7WqJ55LfZwJvCfZ2x5oNBFYk7XItivgLLBs+9dO3Vv0nh8EAf8Q5yUo69kJgztTHq9lO3EHqAssu5uxDzwDtu7inD35WWtbJz6I/XqjXIBIWxXg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] LLC: Avoid potential NULL dereference in net/llc/af_llc.c::llc_ui_accept() .
Date: Thu, 2 Nov 2006 01:21:53 +0100
User-Agent: KMail/1.9.4
Cc: Jay Schulist <jschlst@samba.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>, davem@davemloft.net,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611020121.53368.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since skb_dequeue() may return NULL we risk dereferencing a NULL pointer at
  if (!skb->sk)
This patch avoids that by also testing for a NULL skb.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 2652ead..a3c885f 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -620,7 +620,7 @@ static int llc_ui_accept(struct socket *
 	        llc_sk(sk)->laddr.lsap);
 	skb = skb_dequeue(&sk->sk_receive_queue);
 	rc = -EINVAL;
-	if (!skb->sk)
+	if (!skb || !skb->sk)
 		goto frees;
 	rc = 0;
 	newsk = skb->sk;


