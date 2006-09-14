Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWINUHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWINUHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWINUHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:07:44 -0400
Received: from ns1.coraid.com ([65.14.39.133]:12372 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751113AbWINUHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:07:43 -0400
Date: Thu, 14 Sep 2006 15:50:55 -0400
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.18-rc4] aoe [04/13]: zero copy write 1 of 2
Message-ID: <20060914195054.GL697@coraid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

f5d@coraid.com> <1155982692.4051.9.camel@localhost.localdomain> <20060822212150.
GQ6196@coraid.com> <1156345386.3007.24.camel@localhost.localdomain>
In-Reply-To: <1156345386.3007.24.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126

Hi.  Back in August I sent out some patches for the aoe driver, and
Alan objected to the direct setting of skb->len in one of them.  I
asked whether he was suggesting that we use something like this
instead of setting skb->len:

	skb->data_len = 0;
	skb_trim(skb, 0);
	skb_put(skb, sizeof *h + sizeof *ah + DEFAULTBCNT);

... and Alan said that was acceptible because it takes care of
skb->tail, checks for overflow, and is more future proof.

So I took some time to implement the necessary changes, but then it
became apparent that there was a problem.

The skb_trim and skb_put macros are only for non-linear skbuffs, but
we are only using the area inside the skbuff itself for packet
headers, not data.

When we do something like this:

	if (bio_data_dir(buf->bio) == WRITE) {
		skb_fill_page_desc(skb, 0, bv->bv_page, buf->bv_off, bcnt);
		ah.aflags |= AOEAFL_WRITE;
		skb->len += bcnt;
		skb->data_len = bcnt;
		t->wpkts++;

... skb->tail isn't really relevant, because we are only using the
pre-allocated part of the skbuff for headers, and the headers aren't
expanding here.  Other parts of the kernel that aren't putting data in
the skbuff itself set the skb->len directly.

  e1000_main.c
  ip_output.c
  tcp.c
  ip6_output.c

So is it correct for the callers of skb_fill_page_desc to set skb->len
or is another interface needed besides skb_put/skb_trim?  Such a new
interface would be able to maintain the consistency of the skbuff
fields without assuming that the data is in the skbuff itself.

If a new interface is needed, then it seems like we should set
skb->len in this patch until the new interface is ready.

-- 
  Ed L Cashin <ecashin@coraid.com>
