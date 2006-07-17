Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWGQQbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWGQQbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWGQQbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:31:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:20922 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750928AbWGQQbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:31:42 -0400
Date: Mon, 17 Jul 2006 09:28:26 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 31/45] : Add missing UFO initialisations
Message-ID: <20060717162826.GF4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-missing-ufo-initialisations.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Herbert Xu <herbert@gondor.apana.org.au>

This bug was unknowingly fixed the GSO patches (or rather, its effect was
unknown at the time).

Thanks to Marco Berizzi's persistence which is documented in the thread
"ipsec tunnel asymmetrical mtu", we now know that it can have highly
non-obvious symptoms.

What happens is that uninitialised uso_size fields can cause packets to
be incorrectly identified as UFO, which means that it does not get
fragmented even if it's over the MTU.

The fix is simple enough.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/core/dev.c    |    1 +
 net/core/skbuff.c |    2 ++
 2 files changed, 3 insertions(+)

--- linux-2.6.17.6.orig/net/core/dev.c
+++ linux-2.6.17.6/net/core/dev.c
@@ -1246,6 +1246,7 @@ int __skb_linearize(struct sk_buff *skb,
 	atomic_set(&ninfo->dataref, 1);
 	ninfo->tso_size = skb_shinfo(skb)->tso_size;
 	ninfo->tso_segs = skb_shinfo(skb)->tso_segs;
+	ninfo->ufo_size = skb_shinfo(skb)->ufo_size;
 	ninfo->nr_frags = 0;
 	ninfo->frag_list = NULL;
 
--- linux-2.6.17.6.orig/net/core/skbuff.c
+++ linux-2.6.17.6/net/core/skbuff.c
@@ -240,6 +240,7 @@ struct sk_buff *alloc_skb_from_cache(kme
 	skb_shinfo(skb)->nr_frags  = 0;
 	skb_shinfo(skb)->tso_size = 0;
 	skb_shinfo(skb)->tso_segs = 0;
+	skb_shinfo(skb)->ufo_size = 0;
 	skb_shinfo(skb)->frag_list = NULL;
 out:
 	return skb;
@@ -529,6 +530,7 @@ static void copy_skb_header(struct sk_bu
 	atomic_set(&new->users, 1);
 	skb_shinfo(new)->tso_size = skb_shinfo(old)->tso_size;
 	skb_shinfo(new)->tso_segs = skb_shinfo(old)->tso_segs;
+	skb_shinfo(new)->ufo_size = skb_shinfo(old)->ufo_size;
 }
 
 /**

--
