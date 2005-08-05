Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263103AbVHEUCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbVHEUCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVHEUCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:02:19 -0400
Received: from waste.org ([216.27.176.166]:11483 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262814AbVHEUCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:02:17 -0400
Date: Fri, 5 Aug 2005 13:01:57 -0700
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050805200156.GF7425@waste.org>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain> <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123252591.18332.45.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 10:36:31AM -0400, Steven Rostedt wrote:
> Looking at the netpoll routines, I noticed that the find_skb could
> lockup if the memory is low. This is because the allocations are
> called with GFP_ATOMIC (since this is in interrupt context) and if
> it fails, it will continue to fail. This is just by observing the
> code, I didn't have this actually happen. So if this is not the
> case, please let me know how it can get out. Otherwise, please
> accept this patch.

By netpoll_poll() tickling the driver enough to free the currently
queued outgoing SKBs.

Also note that by the time we're in this loop, we're ready to take
desperate measures. We've already exhausted our private queue of SKBs
so we have no alternative but to keep kicking the driver until
something happens.

The netpoll philosophy is to assume that its traffic is an absolute
priority - it is better to potentially hang trying to deliver a panic
message than to give up and crash silently.

> Also, as Andi told me, the printk here would probably not show up
> anyway if this happens with netconsole.

That's fine. But in fact, it does show up occassionally - I've seen
it.

NAK'ed.

-- 
Mathematics is the supreme nostalgia of our time.
