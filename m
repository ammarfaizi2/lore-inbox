Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUDHOGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDHOGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:06:48 -0400
Received: from waste.org ([209.173.204.2]:63884 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261610AbUDHOGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:06:47 -0400
Date: Thu, 8 Apr 2004 09:06:33 -0500
From: Matt Mackall <mpm@selenic.com>
To: Stelian Pop <stelian@popies.net>, kgdb-bugreport@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] netpoll: prevent transmission stall
Message-ID: <20040408140633.GA6248@waste.org>
References: <20040408103924.GU2718@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408103924.GU2718@deep-space-9.dsnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 12:39:25PM +0200, Stelian Pop wrote:
> While working on kgdb over netpoll I found out another bug in
> netpoll.
> 
> This one is in netpoll_send_skb(), and it is triggered by
> sending repeatedly more packets than the transmit buffers the
> ethernet card has, while being in the netpoll_trap. (this is 
> rapidly triggered by kgdb when using a card with limited
> transmit buffers, like my pcmcia NE2000).
> 
> One should poll() the ethernet card interrupt function in order
> to get the transmit acks from the card and free the transmit 
> buffers in order to be able to transmit more packets.
>
> This is why in the original code, netpoll_send_skb() calls 
> netpoll_poll() if dev->hard_start_xmit() fails. However, this
> does not work because netpoll_poll() is called only if 
> netif_queue_stopped(). But the net queue functions are overridden 
> if netpoll_trap() is on, causing netif_queue_stopped() to never
> return true.
> 
> The attached patch 'fixes' this, by forcing a netpoll_poll()
> every time dev->hard_start_xmit() fails. Maybe there is a cleaner
> way to do this by making the queue functions work even under
> netpoll_trap, but it shouldn't really be necessary, I cannot
> see how forcing the netpoll_poll() call could break anything.

Ok, makes sense. I'll queue this up.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
