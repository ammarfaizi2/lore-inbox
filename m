Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVLXTwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVLXTwz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 14:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVLXTwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 14:52:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750701AbVLXTww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 14:52:52 -0500
Date: Sat, 24 Dec 2005 11:52:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Ayaz Abdulla <AAbdulla@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] forcedeth: fix random memory scribbling bug
In-Reply-To: <43AD4ADC.8050004@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0512241145520.14098@g5.osdl.org>
References: <43AD4ADC.8050004@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Dec 2005, Manfred Spraul wrote:
>
> Two critical bugs were found in forcedeth 0.47:
> - TSO doesn't work.
> - pci_map_single() for the rx buffers is called with size==0. This bug is
> critical, it causes random memory corruptions on systems with an iommu.

Good catch. Btw, should we perhaps disallow (or at least WARN_ON()) 
pci_map_single() with a length of zero? I think it's always likely a bug..

However, that

	"skb->end - skb->data"

calculation is a bit strange. It correctly maps the whole skb, but 
wouldn't it make more sense to use the length we actually tell the card to 
use? 

In other words, wouldn't it be a whole lot more sensible and logical to 
use

	np->rx_buf_sz

instead? That's the value we use for allocation and that's the size we 
tell the card we have.

Of course, on the alloc path, it seems to add an additional 
"NV_RX_ALLOC_PAD" thing, so maybe the "end-data" thing makes sense.

		Linus
