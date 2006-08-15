Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWHOJAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWHOJAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWHOJAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:00:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2732
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932431AbWHOJAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:00:02 -0400
Date: Tue, 15 Aug 2006 02:00:04 -0700 (PDT)
Message-Id: <20060815.020004.76775981.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: [PATCH] ISDN: fix double free bug in isdn_net
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608122248.22639.jesper.juhl@gmail.com>
References: <200608122248.22639.jesper.juhl@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Sat, 12 Aug 2006 22:48:22 +0200

> There's double-free bug in 
> drivers/isdn/i4l/isdn_net.c::isdn_net_writebuf_skb().
> 
> If isdn_writebuf_skb_stub() doesn't handle the entire skb, then it will 
> have freed the skb that was passed to it and when the code then jumps 
> to the error label it'll result in a double free of the skb.
> 
> The easy way to fix this is to insert an assignment of skb = NULL in the
> 'if' following the call to isdn_writebuf_skb_stub() so that when the code
> at the error label calls dev_kfree_skb(skb); the skb will be NULL and 
> nothing will happen since dev_kfree_skb() just does a return if passed a
> NULL.
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

I can't ascertain that this is exactly true.

For example, in isdn_writebuf_skb_stub() we have this:

	if (ret > 0) {
 ...
		if (dev->v110[idx]) {
 ...
			if (ret == skb->len)
				dev_kfree_skb(skb);

So if ret > 0 and we're doing V.110, we only free the skb
if isdn_v110_encode put a value at *((int *)nskb->data)
equal to skb->len.

So in the V.110 case it's not purely the ->writebuf_skb() return
value that gets returned, rather we return that integer that
isdn_v110_encode() put there.

Therefore I don't think this SKB leak is %100 correct.  What did
I miss?

BTW, this ISDN code is rotting a bit and could use some cleanups if
not a rewrite. :-/
