Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUIEGEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUIEGEH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 02:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUIEGEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 02:04:07 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:24748
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266218AbUIEGEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 02:04:04 -0400
Date: Sat, 4 Sep 2004 23:02:10 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
Message-Id: <20040904230210.03fe3c11.davem@davemloft.net>
In-Reply-To: <413AA7B2.4000907@yahoo.com.au>
References: <413AA7B2.4000907@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004 15:44:18 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> So my solution? Just teach kswapd and the watermark code about higher
> order allocations in a fairly simple way. If pages_low is (say), 1024KB,
> we now also require 512KB of order-1 and above pages, 256K of order-2
> and up, 128K of order 3, etc. (perhaps we should stop at about order-3?)

Whether to stop at order 3 is indeed an interesting question.

The reality is that the high-order allocations come mostly from folks
using jumbo 9K MTUs on gigabit and faster technologies.  On x86, an
order 2 would cover those packet allocations, but on sparc64 for example
order 1 would be enough, whereas on a 2K PAGE_SIZE system order 3 would
be necessary.

People using e1000 cards are hitting this case, and some of the e1000
developers are going to play around with using page array based SKBs
(via the existing SKB page frags mechanism).  So instead of allocating
a huge linear chunk for RX packets, they'll allocate a header area of
256 bytes then an array of pages to cover the rest.

Right now, my current suggestion would not be to stop at a certain order.
