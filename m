Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVIFB6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVIFB6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 21:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVIFB6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 21:58:41 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50854
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750773AbVIFB6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 21:58:40 -0400
Date: Mon, 05 Sep 2005 18:58:43 -0700 (PDT)
Message-Id: <20050905.185843.25774101.davem@davemloft.net>
To: colin.harrison@virgin.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at net/ipv4/tcp.c:775! with 2.6.13-git5
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200509051543.j85FhWDS008418@StraightRunning.com>
References: <200509051543.j85FhWDS008418@StraightRunning.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Colin Harrison" <colin.harrison@virgin.net>
Date: Mon, 5 Sep 2005 16:43:44 +0100

> I'm getting the following BUG report with 2.6.13-git5:-

Should be fixed by this patch.  And please use netdev@vger.kernel.org
for networking kernel stuff, thanks.

diff-tree fb5f5e6e0cebd574be737334671d1aa8f170d5f3 (from 1198ad002ad36291817c7bf0308ab9c50ee2571d)
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Sep 5 18:55:48 2005 -0700

    [TCP]: Fix TCP_OFF() bug check introduced by previous change.
    
    The TCP_OFF assignment at the bottom of that if block can indeed set
    TCP_OFF without setting TCP_PAGE.  Since there is not much to be
    gained from avoiding this situation, we might as well just zap the
    offset.  The following patch should fix it.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -769,10 +769,10 @@ new_segment:
 					if (off == PAGE_SIZE) {
 						put_page(page);
 						TCP_PAGE(sk) = page = NULL;
-						TCP_OFF(sk) = off = 0;
+						off = 0;
 					}
 				} else
-					BUG_ON(off);
+					off = 0;
 
 				if (copy > PAGE_SIZE - off)
 					copy = PAGE_SIZE - off;
