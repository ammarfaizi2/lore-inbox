Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVI0HpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVI0HpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVI0HpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:45:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964851AbVI0HpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:45:14 -0400
Date: Tue, 27 Sep 2005 00:44:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: 2.6.14-rc2-mm1 (Oops, possibly Netfilter related?)
Message-Id: <20050927004410.29ab9c03.akpm@osdl.org>
In-Reply-To: <4338F136.1020404@reub.net>
References: <20050921222839.76c53ba1.akpm@osdl.org>
	<4338F136.1020404@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
>  On 22/09/2005 5:28 p.m., Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm1/
>  > 
>  > - Added git tree `git-sas.patch': Luben Tuikov's SAS driver and its support.
>  > 
>  > - Various random other things - nothing major.
> 
>  Just noticed this oops from about 4am this morning.  This would have been at 
>  about the time when the normal daily cronjobs are run, but shouldn't have been 
>  doing much else.
> 
> 
>  Sep 27 04:04:28 tornado kernel: smbd: page allocation failure. order:1, 
>  mode:0x80000020
>  Sep 27 04:04:28 tornado kernel:  [<c0103ad0>] dump_stack+0x17/0x19
>  Sep 27 04:04:28 tornado kernel:  [<c013f84a>] __alloc_pages+0x2d8/0x3ef
>  Sep 27 04:04:28 tornado kernel:  [<c0142b32>] kmem_getpages+0x2c/0x91
>  Sep 27 04:04:28 tornado kernel:  [<c0144136>] cache_grow+0xa2/0x1aa
>  Sep 27 04:04:28 tornado kernel:  [<c0144810>] cache_alloc_refill+0x279/0x2bb
>  Sep 27 04:04:28 tornado kernel:  [<c0144da9>] __kmalloc+0xc7/0xe7
>  Sep 27 04:04:28 tornado kernel:  [<c02ab386>] pskb_expand_head+0x4b/0x11a
>  Sep 27 04:04:28 tornado kernel:  [<c02afd34>] skb_checksum_help+0xcb/0xe5
>  Sep 27 04:04:28 tornado kernel:  [<c0302b0d>] ip_nat_fn+0x16d/0x1bf
>  Sep 27 04:04:28 tornado kernel:  [<c0302cdc>] ip_nat_local_fn+0x57/0x8d
>  Sep 27 04:04:28 tornado kernel:  [<c03068ef>] nf_iterate+0x59/0x7d
>  Sep 27 04:04:28 tornado kernel:  [<c030695d>] nf_hook_slow+0x4a/0x109
>  Sep 27 04:04:28 tornado kernel:  [<c02ca035>] ip_queue_xmit+0x23c/0x4f5
>  Sep 27 04:04:28 tornado kernel:  [<c02da477>] tcp_transmit_skb+0x3ce/0x713
>  Sep 27 04:04:29 tornado kernel:  [<c02db53b>] tcp_write_xmit+0x124/0x37b
>  Sep 27 04:04:29 tornado kernel:  [<c02db7b3>] __tcp_push_pending_frames+0x21/0x70
>  Sep 27 04:04:29 tornado kernel:  [<c02d0b45>] tcp_sendmsg+0x9cc/0xabc
>  Sep 27 04:04:29 tornado kernel:  [<c02ed3dd>] inet_sendmsg+0x2e/0x4c
>  Sep 27 04:04:29 tornado kernel:  [<c02a6691>] sock_sendmsg+0xbf/0xe3
>  Sep 27 04:04:29 tornado kernel:  [<c02a77be>] sys_sendto+0xa5/0xbe

No, this is simply a warning - the kernel ran out of 1-order pages in the
page allocator.  There have been several reports of this after
mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch was merged,
which was rather expected.

I've dropped that patch.  Joel Schopp is working on Mel Gorman's patches
which address fragmentation at this level.  If that code gets there then we
can take another look at
mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch.
