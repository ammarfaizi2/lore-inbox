Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWHVWvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWHVWvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 18:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWHVWvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 18:51:24 -0400
Received: from ns1.coraid.com ([65.14.39.133]:6371 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1750853AbWHVWvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 18:51:23 -0400
Date: Tue, 22 Aug 2006 17:21:50 -0400
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.18-rc4] aoe [04/13]: zero copy write 1 of 2
Message-ID: <20060822212150.GQ6196@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com> <f262a8dec6bec42dce9e5723ff332f5d@coraid.com> <1155982692.4051.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155982692.4051.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 11:18:12AM +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-18 am 13:39 -0400, ysgrifennodd Ed L. Cashin:
> > Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
> 
> > +	skb->len = sizeof *h + sizeof *ah;
> > +	memset(h, 0, skb->len);
> 
> Never play with skb->len directly. Use skb_put/skb_trim

These are skbs pre-allocated by the aoe driver that will always have
enough room to accomodate this much data, and we are really setting
the packet header length.

To use skb_put here seems awkward.  We'd have to do things like shown
below throughout the driver instead of just setting the length.  Is
that what you'd like to see?

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-08-22 12:48:18.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-08-22 17:03:23.000000000 -0400
@@ -314,7 +315,9 @@ rexmit(struct aoedev *d, struct frame *f
 		if (ah->aflags & AOEAFL_WRITE) {
 			skb_fill_page_desc(skb, 0, virt_to_page(f->bufaddr),
 				offset_in_page(f->bufaddr), DEFAULTBCNT);
-			skb->len = sizeof *h + sizeof *ah + DEFAULTBCNT;
+			skb->data_len = 0;
+			skb_trim(skb, 0);
+			skb_put(skb, sizeof *h + sizeof *ah + DEFAULTBCNT);
 			skb->data_len = DEFAULTBCNT;
 		}
 		if (++d->lostjumbo > (d->nframes << 1))


-- 
  Ed L Cashin <ecashin@coraid.com>
