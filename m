Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268776AbUIGX5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268776AbUIGX5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268779AbUIGX5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:57:10 -0400
Received: from waste.org ([209.173.204.2]:29904 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268776AbUIGX5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:57:04 -0400
Date: Tue, 7 Sep 2004 18:57:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: Duncan Sands <baldrick@free.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netpoll endian fixes
Message-ID: <20040907235702.GC31237@waste.org>
References: <200409080124.43530.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409080124.43530.baldrick@free.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 01:24:43AM +0200, Duncan Sands wrote:
> The big-endians took their revenge in netpoll.c: on i386,
> the ip header length / version nibbles need to be the other
> way round; and the htonl leaves only zeros in tot_len...
> 
> All the best, 
> 
> Duncan.
> 
> 
> --- linux-2.5/net/core/netpoll.c.orig	2004-09-08 01:15:22.000000000 +0200
> +++ linux-2.5/net/core/netpoll.c	2004-09-08 01:05:33.000000000 +0200
> @@ -22,6 +22,7 @@
>  #include <net/tcp.h>
>  #include <net/udp.h>
>  #include <asm/unaligned.h>
> +#include <asm/byteorder.h>
>  
>  /*
>   * We maintain a small pool of fully-sized skbs, to make sure the
> @@ -242,9 +243,13 @@
>  	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
>  
>  	/* iph->version = 4; iph->ihl = 5; */
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
> +	put_unaligned(0x45, (unsigned char *)iph);
> +#else
>  	put_unaligned(0x54, (unsigned char *)iph);
> +#endif

Probably what's happened is this:

The original person who sent me the alignment fixes sent a similar
bizarre endian #ifdef thing. He didn't send it as a proper patch
though, so I redid it and copied the not-so-obviously incorrect
clause.

It looks like it ought to be 0x45 everywhere, meaning it's currently
broken everywhere. But no one's complained. Unfortunately at the
present moment I've got one machine short of a test rig unpacked, so
I'm loathe to push another fix until I get some other test reports.
Anyone else run into trouble with netpoll/netconsole in recent -mm or
-bk?

-- 
Mathematics is the supreme nostalgia of our time.
