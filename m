Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVIZWbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVIZWbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVIZWbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:31:47 -0400
Received: from ns1.coraid.com ([65.14.39.133]:35635 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932346AbVIZWbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:31:45 -0400
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/2]: explicitly set minimum packet
 length to ETH_ZLEN
References: <87oe6fhj8y.fsf@coraid.com> <87hdc7ept7.fsf@coraid.com>
	<200509261710.j8QHAkE7008871@turing-police.cc.vt.edu>
From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 26 Sep 2005 18:28:39 -0400
In-Reply-To: <200509261710.j8QHAkE7008871@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Mon, 26 Sep 2005 13:10:46 -0400")
Message-ID: <87vf0npip4.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

...
> I haven't chased through the code in detail - will this change ensure that
> all ETH_ZLEN bytes are initialized?  We had a bunch of drivers a few years
> ago that set the length to the legal min, but then only copied some smaller
> number of bytes in, resulting in leakage of kernel memory contents....

No, it looks like alloc_skb just kmallocs the data, so I'd need to
follow up with something like this:

diff -rN -u old-aoe-2.6-stand/linux/drivers/block/aoe/aoecmd.c new-aoe-2.6-stand/linux/drivers/block/aoe/aoecmd.c
--- old-aoe-2.6-stand/linux/drivers/block/aoe/aoecmd.c	2005-09-26 18:25:19.000000000 -0400
+++ new-aoe-2.6-stand/linux/drivers/block/aoe/aoecmd.c	2005-09-26 17:08:21.000000000 -0400
@@ -26,6 +26,7 @@
 
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (skb) {
+		memset(skb->head, 0, skb->end - skb->head);
 		skb->nh.raw = skb->mac.raw = skb->data;
 		skb->dev = if_dev;
 		skb->protocol = __constant_htons(ETH_P_AOE);



-- 
  Ed L Cashin <ecashin@coraid.com>

