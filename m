Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVGAXjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVGAXjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVGAXjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:39:12 -0400
Received: from waste.org ([216.27.176.166]:53456 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261636AbVGAXiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:38:24 -0400
Date: Fri, 1 Jul 2005 16:38:11 -0700
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [rfc | patch 0/6] netpoll: add support for the bonding driver
Message-ID: <20050701233811.GQ12006@waste.org>
References: <17093.52306.136742.190912@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17093.52306.136742.190912@segfault.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 07:05:54PM -0400, Jeff Moyer wrote:
> New netpoll function implemented by the network drivers:
> 
> net_device->netpoll_setup
>   This is required, since the bonding device has to walk through each slave
>   and point its slave_dev->npinfo at the npinfo for the master device.  The
>   reason for this is so that when we're doing the napi polling, we can set
>   the rx_flags appropriately.
> 
> net_device->netpoll_start_xmit
>   This routine is required since, otherwise, there is no way to intercept
>   packets bound for interfaces that are not ready for them.  Of course, it
>   requires further logic in the bonding driver to then call into the
>   netpoll_send_skb routine (which is a new export).
> 
> Note that neither of these pointers has to be filled in by the driver.
> These functions should only be implemented where needed, and to date, that
> is only in the bonding driver.
> 
> Newly exported are:
> 
> netpoll_send_skb
>   This is exported so that the bonding driver can queue a packet to be sent
>   via the real ethernet device it has chosen.
> 
> netpoll_poll_dev
>   This is a new routine that was created and exported so that the
>   poll_controller implementation in the bonding driver could poll each of
>   the underlying real devices without duplicating all of the logic that
>   exists internally to netpoll already.
> 
> 
> To test this, as I mentioned above, I wrote a simple module which, upon
> receipt of any packet, sends out a packet with the message "PONG".  I fired
> up netcat to send test packets, and receive the responses.  I also loaded
> the netconsole module for the very same interface, bond0, and issue a
> series of sysrq-X's, both via sysrq-trigger and via the keyboard.  I did
> this while simultaneously testing the PING server on an SMP machine.  As
> things stand, it is very stable in my environment.
> 
> And so, the patch set follows.  Any and all comments are appreciated.

Patches 1, 3, and 6 are unrelated bugfixes and should just go in.

I don't like that we rely on queueing to process round trips for PONG.
Is this really unavoidable?

And I think the most controversial thing here is moving locks from npinfo
into the device.

Not really happy about how incestuous this makes the bonding driver
with netpoll. I'll try to think more about it over the weekend.

-- 
Mathematics is the supreme nostalgia of our time.
