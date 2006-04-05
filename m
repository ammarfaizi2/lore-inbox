Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWDEO75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWDEO75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 10:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWDEO75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 10:59:57 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35284 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750842AbWDEO74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 10:59:56 -0400
Subject: [PATCH] [IPSEC] Avoid null pointer dereference in xfrm4_rcv_encap
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 09:59:38 -0500
Message-Id: <1144249178.10340.5.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a panic that I've traced back to this changeset:
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e695633e21ffb6a443a8c2f8b3f095c7f1a48eb0

xfrm4_rcv_encap dereferences x->encap without testing it for null.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
--- linux-2.6.17-rc1-mm1/net/ipv4/xfrm4_input.c.orig	2006-04-04
07:37:23.444068000 -0500
+++ linux-2.6.17-rc1-mm1/net/ipv4/xfrm4_input.c	2006-04-05
09:01:08.798510500 -0500
@@ -90,7 +90,7 @@ int xfrm4_rcv_encap(struct sk_buff *skb,
 		if (unlikely(x->km.state != XFRM_STATE_VALID))
 			goto drop_unlock;
 
-		if (x->encap->encap_type != encap_type)
+		if (x->encap && (x->encap->encap_type != encap_type))
 			goto drop_unlock;
 
 		if (x->props.replay_window && xfrm_replay_check(x, seq))

-- 
David Kleikamp
IBM Linux Technology Center

