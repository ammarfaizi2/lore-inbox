Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUDPSsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbUDPSsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:48:32 -0400
Received: from mail.shareable.org ([81.29.64.88]:48546 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263589AbUDPSs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:48:28 -0400
Date: Fri, 16 Apr 2004 19:48:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, shannon@widomaker.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040416184821.GA25402@mail.shareable.org>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <20040416090331.GC22226@mail.shareable.org> <1082130906.2581.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082130906.2581.10.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> > Perhaps because 2.6 changes the UDP retransmit model for NFS, to
> > estimate the round-trip time and thus retransmit faster than 2.4
> > would.  Sometimes _much_ faster: I observed retransmits within a few
> > hundred microseconds.
> 
> Retransmits within a few 100 microsecond should no longer be occurring.
> Have you redone those measurements with a more recent kernel?

No, not since I sent you the packet trace from a 2.5 kernel that
wasn't working with "soft".  I took your advice and stopped using
"soft".  It causes the obvious problem when I (rarely) turn off the
server, otherwise it's been fine and I'm using 2.6.5 now, still fine
(with "soft" not being used).

> 2.6.x and 2.4.x should have pretty much the same code for RTO
> estimation.
> 
> In fact pretty much all the 2.4.x and 2.6.x RPC code is shared. The one
> difference is that 2.6.x uses zero copy writes.
> 
> > There was also a problem with late 2.5 clients and "soft" NFS mounts.
> > Requests would timeout after a fixed number of retransmits, which on a
> > LAN could be after a few milliseconds due to round-trip estimation and
> > fast server response.  Then when an I/O on the server took longer,
> > e.g. due to a disk seek or contention, the client would timeout and
> > abort requests.  2.4 doesn't have this problem with "soft" due to the
> > longer, fixed retransmit timeout.  I don't know if it is fixed in
> > current 2.6 kernels - but you can avoid it by not using "soft" anyway.
> 
> Or changing the default value of "retrans" to something more sane. As
> usual, Linux has a default that is lower than on any other platform.

If few-100-microsecond retransmits no longer occur, perhaps it's no
longer relevant.

The problem I saw with "soft" was that the retransmit time was quite a
good estimate of the server response time.  That part was fine, nice
even.  But then the server response latency would increase by a factor
of 10000 (ten thousand) due to normal disk I/O activity (compare cache
response with disk response on a busy disk), and of course 3
retransmits doubling each time is not adequate to cover that.  2.4 was
fine because the default rtt and retrans together could never get
shorter than a few seconds.

That's why I felt that iff rtt was adapting to the server response
time, then a fixed number of retransmits was no longer appropriate: a
lower bound on the time before timing out is appropriate, e.g. 3
seconds or 10 seconds or whatever.

In other words, with adaptive rtt the concept of "retrans" being a
fixed number is fundamentally flawed -- unless it's also accompanied
by a minimum timeout time.  You'd need a retrans value of 20 or so for
the above perfectly normal LAN situation, but then that's far too
large on other occasions with other networks or servers.

-- Jamie
