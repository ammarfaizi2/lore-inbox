Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946536AbWKAFnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946536AbWKAFnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946543AbWKAFnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:43:45 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16092 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946541AbWKAFnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:43:35 -0500
Message-Id: <20061101054219.519653000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:19 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Herbert Xu <herbert@gondor.apana.org.au>,
       David S Miller <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 39/61] NET: Fix skb_segment() handling of fully linear SKBs
Content-Disposition: inline; filename=net-fix-skb_segment-handling-of-fully-linear-skbs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[NET]: Fix segmentation of linear packets

skb_segment fails to segment linear packets correctly because it
tries to write all linear parts of the original skb into each
segment.  This will always panic as each segment only contains
enough space for one MSS.

This was not detected earlier because linear packets should be
rare for GSO.  In fact it still remains to be seen what exactly
created the linear packets that triggered this bug.  Basically
the only time this should happen is if someone enables GSO
emulation on an interface that does not support SG.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 net/core/skbuff.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- linux-2.6.18.1.orig/net/core/skbuff.c
+++ linux-2.6.18.1/net/core/skbuff.c
@@ -1945,7 +1945,7 @@ struct sk_buff *skb_segment(struct sk_bu
 	do {
 		struct sk_buff *nskb;
 		skb_frag_t *frag;
-		int hsize, nsize;
+		int hsize;
 		int k;
 		int size;
 
@@ -1956,11 +1956,10 @@ struct sk_buff *skb_segment(struct sk_bu
 		hsize = skb_headlen(skb) - offset;
 		if (hsize < 0)
 			hsize = 0;
-		nsize = hsize + doffset;
-		if (nsize > len + doffset || !sg)
-			nsize = len + doffset;
+		if (hsize > len || !sg)
+			hsize = len;
 
-		nskb = alloc_skb(nsize + headroom, GFP_ATOMIC);
+		nskb = alloc_skb(hsize + doffset + headroom, GFP_ATOMIC);
 		if (unlikely(!nskb))
 			goto err;
 

--
