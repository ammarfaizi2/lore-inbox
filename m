Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWJIR4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWJIR4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWJIR4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:56:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750875AbWJIR4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:56:30 -0400
Date: Mon, 9 Oct 2006 09:50:51 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061009095051.38ed9f22@freekitty>
In-Reply-To: <20061009174705.GG26849@mellanox.co.il>
References: <20061009174705.GG26849@mellanox.co.il>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 19:47:05 +0200
"Michael S. Tsirkin" <mst@mellanox.co.il> wrote:

> Hi!
> I'm trying to build a network device driver supporting a very large MTU (around 64K)
> on top of an infiniband connection, and I've hit a couple of issues I'd
> appreciate some feedback on:
> 
> 1. On the send side,
>    I've set NETIF_F_SG, but hardware does not support checksum offloading,
>    and I see "dropping NETIF_F_SG since no checksum feature" warning,
>    and I seem to be getting large packets all in one chunk.
>    The reason I've set NETIF_F_SG, is because I'm concerned that under real life
>    stress Linux won't be able to allocate 64K of continuous memory.
> 
>    Is this concern of mine valid? I saw in-tree drivers allocating at least 8K.
>    What's the best way to enable S/G on send side?
>    Is checksum offloading really required for S/G?

Yes, in the current implementation, Linux needs checksum offload. But there
is no reason, your driver can't compute the checksum in software.

> 2. On the receive side, what's the best/right way to create an skb that
>    is larger than PAGE_SIZE?
>    Do I allocate with alloc_page and fill in nr_frags with skb_fill_page_desc?
>    Some drivers seem to fill in frag_list - which is better?
>    I see than even skb_put only works properly on linear skb.


Allocating large buffers is problematic on busy systems.
See lastest e1000 or sky2 that use frag_list.

>    What are the helpers legal for fragmented skb?
Read the source. Setting up fragmented buffers has less helper
functions, but isn't that hard.

-- 
Stephen Hemminger <shemminger@osdl.org>
