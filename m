Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUGZBBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUGZBBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 21:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUGZBBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 21:01:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:19855 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264750AbUGZBBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 21:01:17 -0400
Date: Sun, 25 Jul 2004 17:59:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Harald Welte <laforge@netfilter.org>
Cc: sebest@ovibes.net, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: kernel 2.6.7 -> page allocation failure. order:1, mode:0x20
 (netfilter?)
Message-Id: <20040725175945.15999990.akpm@osdl.org>
In-Reply-To: <20040720024741.GF27487@obroa-skai.de.gnumonks.org>
References: <40FB93FE.90308@ovibes.net>
	<20040720024741.GF27487@obroa-skai.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte <laforge@netfilter.org> wrote:
>
> what's worrying me is the part above... how would skb_checksum_help
>  directly end up in copy_from_user()?

That'll be leftover gunk on the stack.  Enabling frame pointers makes that
go away.

>  > swapper: page allocation failure. order:1, mode:0x20
>  > [<c013d770>] __alloc_pages+0x2da/0x34a
>  > [<c013d805>] __get_free_pages+0x25/0x3f
>  > [<c0140e28>] kmem_getpages+0x2b/0xdc
>  > [<c0141bfc>] kfree_skbmem+0x24/0x2c
>  > [<c0141c5d>] cache_grow+0xe5/0x2a4
>  > [<c0141f8a>] cache_grow+0x146/0x2a4
>  > [<c0295917>] cache_alloc_refill+0x1cf/0x29f
>  > [<c014262a>] __kmalloc+0x85/0x8c
>  > [<c02681f1>] tcp_transmit_skb+0x411/0x68a
>  > [<c0296621>] alloc_skb+0x47/0xe0
>  > [<c026875e>] tcp_write_xmit+0x16d/0x2d6
>  > [<c01da1ac>] skb_copy+0x33/0xde
>  > [<c026ca5b>] copy_from_user+0x42/0x6e
> 
>  Does anybody have a clue what's going on?

Networking tried to do an atomic 1-order allocation and there were no
1-order pages available in the free page pools.  It's pretty much
unavoidable, and the caller simply needs to handle it - presumably by
dropping the packet.

Its frequency can be reduced by increasing /proc/sys/vm/min_free_kbytes.

It can be eliminated by using GFP_KERNEL.  It can be hugely reduced by
sticking to 0-order allocations.

I wouldn't worry about this unless someone is seeing a lot of them (a
significant number of packets are getting dropped)
