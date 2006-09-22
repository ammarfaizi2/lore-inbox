Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWIVHnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWIVHnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWIVHnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:43:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750864AbWIVHnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 03:43:02 -0400
Date: Fri, 22 Sep 2006 00:42:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: 2.6.1[78] page allocation failure. order:3, mode:0x20
Message-Id: <20060922004253.2e2e2612.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609220655550.13396@diagnostix.dwd.de>
References: <Pine.LNX.4.64.0609220655550.13396@diagnostix.dwd.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 07:27:18 +0000 (GMT)
Holger Kiehl <Holger.Kiehl@dwd.de> wrote:

> I get some of the "page allocation failure" errors. My hardware is 4 CPU
> Opteron with one quad + one dual intel e1000 cards. Kernel is plain 2.6.18
> and for two cards MTU is set to 9000.
> 
>     Sep 21 21:03:15 athena kernel: vsftpd: page allocation failure. order:3, mode:0x20
>     Sep 21 21:03:15 athena kernel:
>     Sep 21 21:03:15 athena kernel: Call Trace:
>     Sep 21 21:03:15 athena kernel:  <IRQ> [<ffffffff8024e516>] __alloc_pages+0x282/0x29b
>     Sep 21 21:03:15 athena kernel:  [<ffffffff8807aa93>] :ip_tables:ipt_do_table+0x1eb/0x318
>     Sep 21 21:03:15 athena kernel:  [<ffffffff8026614b>] cache_grow+0x134/0x33d
>     Sep 21 21:03:15 athena kernel:  [<ffffffff8026664c>] cache_alloc_refill+0x189/0x1d7
>     Sep 21 21:03:15 athena kernel:  [<ffffffff80266724>] __kmalloc+0x8a/0x94
>     Sep 21 21:03:15 athena kernel:  [<ffffffff803b5438>] __alloc_skb+0x5c/0x123
>     Sep 21 21:03:15 athena kernel:  [<ffffffff803b5f2e>] __netdev_alloc_skb+0x12/0x2d
>     Sep 21 21:03:15 athena kernel:  [<ffffffff8033cb22>] e1000_alloc_rx_buffers+0x6f/0x2f3
>     Sep 21 21:03:15 athena kernel:  [<ffffffff803d1234>] ip_local_deliver+0x173/0x23b
>     Sep 21 21:03:15 athena kernel:  [<ffffffff8033d29a>] e1000_clean_rx_irq+0x4f4/0x514

Is OK, it's just a warning and it is expected - the kernel will recover.

I'm half-inclined to shut the warning up by sticking a __GFP_NOWARN in there.

But on the other hand, that warning is handy sometimes.  How come kmalloc
decided to request a 32k hunk of memory when the MTU size is only 9k?  Is
the driver doing something dumb?

	else if (max_frame <= E1000_RXBUFFER_8192)
		adapter->rx_buffer_len = E1000_RXBUFFER_8192;
	else if (max_frame <= E1000_RXBUFFER_16384)
		adapter->rx_buffer_len = E1000_RXBUFFER_16384;

It sure is.

This is going to cause an 9000-byte MTU to use a 16384-byte allocation. 
e1000_alloc_rx_buffers() adds two bytes to that, so we do kmalloc(16386),
which causes the slab allocator to request 32768 bytes.  All for a 9kbyte skb.

