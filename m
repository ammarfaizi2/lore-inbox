Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268290AbUHFUjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268290AbUHFUjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUHFUjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:39:19 -0400
Received: from waste.org ([209.173.204.2]:35305 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268290AbUHFU1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:27:13 -0400
Date: Fri, 6 Aug 2004 15:26:49 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>
Subject: Re: [patch] fix netconsole hang with alt-sysrq-t
Message-ID: <20040806202649.GE16310@waste.org>
References: <16659.56343.686372.724218@segfault.boston.redhat.com> <20040806195237.GC16310@waste.org> <16659.58271.979999.616045@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16659.58271.979999.616045@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 04:01:35PM -0400, Jeff Moyer wrote:
> ==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:
> 
> mpm> On Fri, Aug 06, 2004 at 03:29:27PM -0400, Jeff Moyer wrote:
> >> Hi, Matt,
> >> 
> >> Here's the patch.  Sorry it took me so long, been busy with other work.
> >> Two things which need perhaps more thinking, can netpoll_poll be called
> >> recursively (it didn't look like it to me)
> 
> mpm> It can if the poll function does a printk or the like and wants to
> mpm> recurse via netconsole. We could short-circuit that with an in_netpoll
> mpm> flag, but let's worry about that separately.
> 
> Hmm, ok.
> 
> >> and do we care about the racy
> >> nature of the netpoll_set_trap interface?
> 
> mpm> That should probably become an atomic now.
>  
> Ouch.  I wanted to avoid that, but if we can't, we can't.  Will
> netpoll_set_trap then to an atomic_inc or an atomic_add?  I've only seen it
> called with 1 and 0, is that all that was intended?

It's a boolean interface. We might switch from set(bool) to
enable()/disable(). More thought required.
 
> >> You'll notice that I reverted part of an earlier changeset which caused us
> >> to call the hard_start_xmit function even if netif_queue_stopped returned
> >> true.  This is a bug.  I preserved the second part of that patch, which was
> >> correct.
> 
> mpm> Ok, jgarzik pointed that out to me just a bit ago. I'm not sure if
> mpm> we're dealing with the behavior that was intended to address yet
> mpm> though. Stelian, can you try giving this a spin?
> 
> Well, we kept the second part of the patch, which deals with the
> hard_start_xmit routine returning 1.  That was a valid bug, I believe.

Probably, but it's hairy enough that I'm not entirely convinced we've
solved the particular problem.

> Yah, and I just noticed we don't want the poll_lock to be per struct
> netpoll.  It should be a static lock in the netpoll.c file.  The problem is
> that more than one netpoll object can reference the same ethernet device.

Good catch. My original design stuck pointers to the netpoll objects
in the net device and then I switched to allowing multiples and didn't
fix that bit.

-- 
Mathematics is the supreme nostalgia of our time.
