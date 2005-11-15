Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVKOGpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVKOGpn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 01:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVKOGpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 01:45:43 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59844
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932231AbVKOGpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 01:45:42 -0500
Date: Mon, 14 Nov 2005 22:45:45 -0800 (PST)
Message-Id: <20051114.224545.101398810.davem@davemloft.net>
To: mpm@selenic.com
Cc: jeffrey.t.kirsher@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [BUG] netpoll is unable to handle skb's using packet split
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051115062947.GI31287@waste.org>
References: <20051114.213922.16377460.davem@davemloft.net>
	<20051114.214130.57199557.davem@davemloft.net>
	<20051115062947.GI31287@waste.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Mon, 14 Nov 2005 22:29:47 -0800

> Can we make any assumptions about the size and position of fragments.
> For instance, will the first N data bytes of a UDP packet all be in
> the same fragment?

Nope, they can be fragmented any way possible.

For packet parsing, you don't need any of this anyways.
Just use the things that the normal network input stack
uses, for example you could use something like
skb_header_pointer(), or pskb_may_pull().

For example, a clean way to parse a UDP header at the
front of an SKB is:

	struct udphdr *uh, _tmp;

	uh = skb_header_pointer(skb, 0, sizeof(_tmp), &_tmp);
	if (uh->sport = foo && uh->dport == bar)
		...

The UDP input path uses:

	struct udphdr *uh;

	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
		goto header_error;

	uh = skb->h.uh;

Unfortunately, pskb_may_pull() may need to call __pskb_pull_tail()
which in turn might do a pskb_expand_head() and thus a GFP_ATOMIC
memory allocation.
