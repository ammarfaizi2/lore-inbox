Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129271AbRBZXuK>; Mon, 26 Feb 2001 18:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129274AbRBZXuB>; Mon, 26 Feb 2001 18:50:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30111 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129271AbRBZXtw>;
	Mon, 26 Feb 2001 18:49:52 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15002.60104.350394.893905@pizda.ninka.net>
Date: Mon, 26 Feb 2001 15:46:16 -0800 (PST)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > 1) Rx Skb recycling.
 ...
 > Advantages:  A de-allocation immediately followed by a reallocation is
 > eliminated, less L1 cache pollution during interrupt handling. 
 > Potentially less DMA traffic between card and host.
 ...
 > Disadvantages?

It simply cannot work, as Alexey stated, in normal circumstances
netif_rx() queues until the user reads the data.  This is the whole
basis of our receive packet processing model within softint/user
context.

Secondly, I can argue that skb recycling can give _worse_ cache
performance.  If the next use and access by the card to the
skb data is deferred, this gives the cpu a chance to displace those
lines in it's cache naturally via displacement instead of being forced
quickly to do so when the device touches that data.

If the device forces the cache displacement, those cache lines become
empty until filled with something later (smaller utilization of total
cache contents) whereas natural displacement puts useful data into
the cache at the time of the displacement (larger utilization of total
cache contents).

It is an NT/windows driver API rubbish idea, and it is full crap.

 > 2) Tx packet grouping.
 ...
 > Disadvantages?

See Torvalds vs. world discussion on this list about API entry points
which pass multiple pages at a time versus simpler ones which pass
only a single page at a time. :-)

 > 3) Slabbier packet allocation.
 ...
 > Disadvantages?  Doing this might increase cache pollution due to
 > increased code and data size, but I think the hot path is much improved
 > (dequeue a properly sized, initialized, skb-reserved'd skb off a list)
 > and would help mitigate the impact of sudden bursts of traffic.

I don't know what I think about this one, but my hunch is that it will
lead to worse data packing via such an allocator.

Later,
David S. Miller
davem@redhat.com
