Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbVKQXmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbVKQXmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbVKQXmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:42:23 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57008
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965120AbVKQXmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:42:22 -0500
Date: Thu, 17 Nov 2005 15:41:39 -0800 (PST)
Message-Id: <20051117.154139.97107477.davem@davemloft.net>
To: hugh@veritas.com
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, annabellesgarden@yahoo.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] unpaged: sound nopage get_page
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0511171930090.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511171930090.4563@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Thu, 17 Nov 2005 19:31:36 +0000 (GMT)

> Something noticed when studying use of VM_RESERVED in different drivers:
> snd_usX2Y_hwdep_pcm_vm_nopage omitted to get_page: fixed.
> 
> And how did this work before?  Aargh!  That nopage is returning a page
> from within a buffer allocated by snd_malloc_pages, which allocates a
> high-order page, then does SetPageReserved on each 0-order page within.
> 
> That would have worked in 2.6.14, because when the area was unmapped,
> PageReserved inhibited put_page.  2.6.15-rc1 removed that inhibition
> (while leaving ineffective PageReserveds around for now), but it hasn't
> caused trouble because.. we've not been freeing from VM_RESERVED at all.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

There is probably a lot of other grot like this in various drivers.

The amazing thing about this is that all of these drivers getting
snuffed up by VM_RESERVED issues are trying to do essentially the
same thing.  They want to allocate some buffers, which the device
can DMA into and out of, and mmap() those buffers into user space
in some sane way.

The video capture driver layer drivers/media/video/video-buf.c is
probably the best known example, and all the other copies in the
tree of this logic is some derivative.

Note also that the AF_PACKET mmap() facility (in
net/packet/af_packet.c) does this VM_RESERVED stuff, but I think since
it never does the get_user_pages() bit like the video capture drivers
do, it didn't trigger any of the new messages or BUG() traps.

I say "I think" because I haven't tested this stuff out specifically.
