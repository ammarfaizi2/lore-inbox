Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWG0Htb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWG0Htb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWG0Htb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:49:31 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:5262 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751299AbWG0Hta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:49:30 -0400
Date: Thu, 27 Jul 2006 11:49:02 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
Message-ID: <20060727074902.GC5490@2ka.mipt.ru>
References: <44C66FC9.3050402@redhat.com> <20060725.150122.49854414.davem@davemloft.net> <20060726062817.GA20636@2ka.mipt.ru> <20060726.231055.121220029.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060726.231055.121220029.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 27 Jul 2006 11:49:06 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 11:10:55PM -0700, David Miller (davem@davemloft.net) wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Wed, 26 Jul 2006 10:28:17 +0400
> 
> > I have not created additional DMA memory allocation methods, like
> > Ulrich described in his article, so I handle it inside NAIO which
> > has some overhead (I posted get_user_pages() sclability graph some
> > time ago).
> 
> I've been thinking about this aspect, and I think it's very
> interesting.  Let's be clear what the ramifications of this
> are first.
> 
> Using the terminology of Network Algorithmics, this is an
> instance of Principle 2, "Shift computation in time".
> 
> Instead of using get_user_pages() at AIO setup, we instead map the
> thing to userspace later when the user wants it.  Pinning pages is a
> pain because both user and kernel refer to the buffer at the same
> time.  We get more flexibility when the user has to map the thing
> explicitly.

I.e. map skb's data to userspace? Not a good idea especially with it's
tricky lifetime and unability for userspace to inform kernel when it
finished and skb can be freed (without additional syscall).
I did it with af_tlb zero-copy sniffer (but I substitute mapped pages
with physical skb->data pages), and it was not very good.

> I want us to think about how a user might want to use this.  What
> I anticipate is that users will want to organize a pool of AIO
> buffers for themselves using this DMA interface.  So the events
> they are truly interested in are of a finer granularity than you
> might expect.  They want to know when pieces of a buffer are
> available for reuse.

Ah, I see.
Well, I think preallocate some buffers and use that in AIO setup is a
plus, since in that case user does not care about when it is possible to
reuse the same buffer - when appropriate kevent is completed, that means
that provided buffer is no longer in use by kernel, and user can reuse
it.

-- 
	Evgeniy Polyakov
