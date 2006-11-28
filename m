Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935059AbWK1DjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935059AbWK1DjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 22:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935069AbWK1DjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 22:39:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:14266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935059AbWK1DjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 22:39:10 -0500
Date: Mon, 27 Nov 2006 19:38:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Alexander V. Lukyanov" <lav@netis.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6.18: memory leak(?)
Message-Id: <20061127193834.b5ca80db.akpm@osdl.org>
In-Reply-To: <20061127124443.GA11569@night.netis.ru>
References: <20061127124443.GA11569@night.netis.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 15:44:44 +0300
"Alexander V. Lukyanov" <lav@netis.ru> wrote:

> After a while, a loaded http proxy gets many errors like below. It is
> reproducible and happens again after reboot (in some time). It did not
> happen with 2.6.17. I have also tested 2.6.18.3, the leak is there too.
> 
> swapper: page allocation failure. order:1, mode:0x20
>  [<c012bc40>] __alloc_pages+0x253/0x267
>  [<c013b12e>] cache_alloc_refill+0x243/0x3e7
>  [<c013b317>] __kmalloc+0x45/0x51
>  [<c01c11b8>] __alloc_skb+0x49/0xf4
>  [<c01e2feb>] tcp_collapse+0x10f/0x2ca
>  [<c01e32f5>] tcp_prune_queue+0x14f/0x20b
>  [<c01e3550>] tcp_data_queue+0x19f/0x9e9
>  [<c01ff7ea>] ipt_do_table+0x296/0x2c0
>  [<c01e52ef>] tcp_rcv_established+0x533/0x5c4
>  [<c01e9e2c>] tcp_v4_do_rcv+0x22/0x267
>  [<c01ff88a>] ipt_hook+0x17/0x1d
>  [<c01d04ad>] nf_iterate+0x30/0x61
>  [<c01ebe08>] tcp_v4_rcv+0x751/0x7a5
>  [<c01dd215>] tcp_prequeue_process+0x30/0x56
>  [<c01d59a8>] ip_local_deliver+0x12f/0x1ab
>  [<c01d5850>] ip_rcv+0x33f/0x368
>  [<c01c4991>] netif_receive_skb+0x135/0x176
>  [<c01c5da5>] process_backlog+0x6d/0xd2
>  [<c01c5e5c>] net_rx_action+0x52/0xcb
>  [<c0110463>] __do_softirq+0x35/0x75
>  [<c01104c5>] do_softirq+0x22/0x26
>  [<c0103b7f>] do_IRQ+0x45/0x4d
>  [<c010266a>] common_interrupt+0x1a/0x20
>  [<c0101506>] mwait_idle+0x20/0x33
>  [<c01014d1>] cpu_idle+0x39/0x4e
>  [<c02765f9>] start_kernel+0x275/0x277

It's not necessarily a leak.  Networking tried to allocate two
physically-contiguous pages from atomic context, but no such two pages were
available.  The packet will be dropped and things should recover.

Increasing /proc/sys/vm/min_free_kbytes will reduce the frequency somewhat.
If it's actually a problem, which I doubt?
