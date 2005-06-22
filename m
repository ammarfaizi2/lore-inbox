Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVFVVdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVFVVdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVFVV2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:28:45 -0400
Received: from waste.org ([216.27.176.166]:26019 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262547AbVFVV1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:27:25 -0400
Date: Wed, 22 Jun 2005 14:27:07 -0700
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: netdev@oss.sgi.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch,rfc] allow registration of multiple netpolls per interface
Message-ID: <20050622212707.GD27572@waste.org>
References: <17080.35214.507402.998984@segfault.boston.redhat.com> <20050621225252.GY27572@waste.org> <17081.20441.714191.528270@segfault.boston.redhat.com> <20050622170128.GV27572@waste.org> <17081.53899.201190.106025@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17081.53899.201190.106025@segfault.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 05:05:15PM -0400, Jeff Moyer wrote:
> mpm> It might be simpler to have a single lock here..?
> >> 
> >> Maybe.  You can't really have netpoll code running on multiple cpus at the
> >> same time, right?  This is the rx path, remember, so the other cpu should
> >> be spinning on the poll_lock.
> >> 
> >> Keeping separate locks would allow you to unregister a struct netpoll
> >> associated with another net device without causing lock contention.  This
> >> is a very minor win, obviously.
> >> 
> >> I still feel like this npinfo struct is the right place for this, though.
> >> If you're strongly opposed to that, I'll change it.
> 
> mpm> No, certainly having it in npinfo makes sense. I just was wondering if
> mpm> we really need two locks in there.
> 
> Oh, I misunderstood.  Well, one protects recursing into the driver's poll
> routine, the other protects access to the np_rx pointer, which may later
> become a list.  I don't think we can lump these two together, do you?

I don't see why we couldn't, but let's worry about it later.
 
> >> >> +	spin_lock_irqsave(&npinfo->rx_lock, flags);
> >> >> +	if (npinfo->rx_np->dev == skb->dev)
> >> >> +		np = npinfo->rx_np;
> >> >> +	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
> >> 
> mpm> And I think that means we don't need the lock here either.  
> >> 
> >> Sure we do.  We need to protect against rmmod's.
> 
> mpm> How can we have an rmmmod when we're trapped?
> 
> Looking over the code, I don't see what would prevent this.  Could you
> point me the code which prevents this?

I forgot we overloaded trapped for dealing with NAPI. Formerly
trapping meant "I'm stopping the box, drop every packet that's not
addressed to me" which also implied no one should be pulling the rug
out from under us.

> (Interdiff first)

Looks fine.

-- 
Mathematics is the supreme nostalgia of our time.
