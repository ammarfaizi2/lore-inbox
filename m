Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269099AbUHXW6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269099AbUHXW6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUHXW6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:58:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23524 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269099AbUHXW5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:57:47 -0400
Date: Tue, 24 Aug 2004 15:57:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dominik.karall@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: page allocation failure
Message-Id: <20040824155727.4749e6ad.davem@redhat.com>
In-Reply-To: <20040824130531.3cbb03d1.akpm@osdl.org>
References: <200408242205.20571.dominik.karall@gmx.net>
	<20040824130531.3cbb03d1.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 13:05:31 -0700
Andrew Morton <akpm@osdl.org> wrote:

> It's networking trying to allocate eight physically-contiguous pages with
> GFP_ATOMIC.  Can you say "snowball's chance in hell"?

It's netfilter's ip_nat_fn() calling skb_checksum_help() which does
an skb_copy() if the skb is either shared or cloned.

This patch from Herbert Xu, which I may integrate tonight, should
help with this case.

===== net/core/dev.c 1.155 vs edited =====
--- 1.155/net/core/dev.c	2004-07-31 07:23:04 +10:00
+++ edited/net/core/dev.c	2004-08-24 20:59:57 +10:00
@@ -1144,16 +1144,10 @@
 		goto out;
 	}
 
-	if (skb_shared(*pskb)  || skb_cloned(*pskb)) {
-		struct sk_buff *newskb = skb_copy(*pskb, GFP_ATOMIC);
-		if (!newskb) {
-			ret = -ENOMEM;
+	if (skb_cloned(*pskb)) {
+		ret = pskb_expand_head(*pskb, 0, 0, GFP_ATOMIC);
+		if (ret)
 			goto out;
-		}
-		if ((*pskb)->sk)
-			skb_set_owner_w(newskb, (*pskb)->sk);
-		kfree_skb(*pskb);
-		*pskb = newskb;
 	}
 
 	if (offset > (int)(*pskb)->len)

