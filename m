Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUIFVf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUIFVf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUIFVf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:35:26 -0400
Received: from waste.org ([209.173.204.2]:29338 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265928AbUIFVfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:35:16 -0400
Date: Mon, 6 Sep 2004 16:35:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netpoll trapped question
Message-ID: <20040906213502.GU31237@waste.org>
References: <16692.45331.968648.262910@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16692.45331.968648.262910@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 01:10:43PM -0400, Jeff Moyer wrote:
> Hi, Matt,
> 
> This part of the netpoll trapped logic seems suspect to me, from
> include/linux/netdevice.h:
> 
> static inline void netif_wake_queue(struct net_device *dev)
> {
> #ifdef CONFIG_NETPOLL_TRAP
> 	if (netpoll_trap())
> 		return;
> #endif
> 	if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state))
> 		__netif_schedule(dev);
> }
> 
> static inline void netif_stop_queue(struct net_device *dev)
> {
> #ifdef CONFIG_NETPOLL_TRAP
> 	if (netpoll_trap())
> 		return;
> #endif
> 	set_bit(__LINK_STATE_XOFF, &dev->state);
> }
> 
> This looks buggy.  Network drivers are now not able to stop the queue when
> they run out of Tx descriptors.  I think the __netif_schedule is okay to do
> in the context of netpoll, and certainly a set_bit is okay.  Why are these
> hooks in place?  I've tested alt-sysrq-t over netconsole and also netdump
> with these #ifdef's removed, and things work correctly.  Compare this with
> alt-sysrq-t hanging the system with these tests in place.  If I run netdump
> with this logic still in place, I get the following messages from the tg3
> driver:
> 
>   eth0: BUG! Tx Ring full when queue awake!
> 
> Shall I send a patch, or have I missed something?

I don't remember the origin or motivation of this bit, so I'm not sure
at the moment. Shoot me a patch and I'll poke at it.

Btw, did I send you my thoughts on your recursion patch?

-- 
Mathematics is the supreme nostalgia of our time.
