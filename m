Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbUBYBXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUBYBXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:23:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:10167 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262559AbUBYBXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:23:12 -0500
Date: Tue, 24 Feb 2004 17:25:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Marco d'Itri" <md@Linux.IT>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure. order:3, mode:0x20
Message-Id: <20040224172505.775e609f.akpm@osdl.org>
In-Reply-To: <20040224210144.GA9129@wonderland.linux.it>
References: <20040224210144.GA9129@wonderland.linux.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marco d'Itri" <md@Linux.IT> wrote:
>
> Linux attila 2.6.3 #1 Fri Feb 20 02:12:34 CET 2004 ppc GNU/Linux
> 
> (Linus tree.)
> 
> kernel: tinyproxy: page allocation failure. order:3, mode:0x20
> kernel: Call trace:
> kernel:  [c00097e8] dump_stack+0x18/0x28
> kernel:  [c0037fd8] __alloc_pages+0x31c/0x364
> kernel:  [c003804c] __get_free_pages+0x2c/0x74
> kernel:  [c003b14c] cache_grow+0x94/0x328
> kernel:  [c003b5a0] cache_alloc_refill+0x1c0/0x25c
> kernel:  [c003b9ac] __kmalloc+0xa8/0xb4
> kernel:  [c0167dc8] alloc_skb+0x4c/0xe0
> kernel:  [c0127004] loopback_xmit+0x100/0x110
> kernel:  [c016d0c0] dev_queue_xmit+0xcc/0x248
> kernel:  [c0184464] ip_finish_output+0x124/0x26c
> kernel:  [c018698c] dst_output+0x28/0x5c
> kernel:  [c01784c8] nf_hook_slow+0xf0/0x14c
> kernel:  [c0184c50] ip_queue_xmit+0x408/0x520
> kernel:  [c01960b4] tcp_transmit_skb+0x3e4/0x5e4
> kernel: tinyproxy: page allocation failure. order:4, mode:0x20

When the slab code creates a new slab it decides up-front on a nice
underlying allocation size which will pack a good number of the requested
objects.  So for the size-2048 slab it is currently using a 2-order (16k)
allocation.

Here, you're getting 3- and even 4-order allocation attempts.  Presumably
because loopback uses a 16k MTU and slab has sized that up to use 64k
allocations.

It's all crazy - these allocations are sure to fail all over the place. 
Manfred is working on fixing it up.

