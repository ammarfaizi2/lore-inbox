Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTIGO1b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 10:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTIGO1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 10:27:31 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:51598 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263258AbTIGO13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 10:27:29 -0400
Date: Sun, 7 Sep 2003 15:27:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client problems in 2.4.18 to 2.4.20
Message-ID: <20030907142727.GG19977@mail.jlokier.co.uk>
References: <16218.5318.401323.630346@charged.uio.no> <20030906212250.64809.qmail@web40414.mail.yahoo.com> <20030906231401.GB12392@mail.jlokier.co.uk> <16218.37312.1855.652692@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16218.37312.1855.652692@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>      > This might be the bug where it adjusts the retransmit timeout
>      > to a ridiculously small sub-millisecond value, because of a
>      > sequence of fast cached responses from the server
> 
> BTW: this should be fixed now in 2.6.x. I've set a minimum value on
> the estimated error on the round-trip time to 1/10sec.

I don't think the round-trip estimate was ever a real problem,
although setting a low bound does make sense.

A real problem is the rule of having a fixed number of retransmits
before an operation fails with a "soft" moount.  This is wrong for
NFS, now that rtt is estimated dynamically.

It is wrong because NFS response times are not due to network
congestion - they are due mainly to I/O on the server, and I/O times
don't have the same properties as networks at all.

The "soft operation fail" imeout should have a minimum absolute time,
like 30 seconds or so.  It should also have a maximum (for systems
where the estimated rtt is 10 seconds).  This should be independent of
the rtt estimate.

Think of a worst case:

   - server responds to cached requests within 10 microseconds

   - uncached requests take 10 seconds to respond (spinning up CD,
     seeking on tape HFS, or just ordinary disk/swap contention).

This should never timeout, as long as the server is responding within
a fixed absolute time, although it's fine to issue lots of retransmits
until that time.

The fundamental error is assuming that all NFS requests take about the
same time to server, and delays are caused by the network.  This isn't
true especially on a LAN.  Delays for NFS are typically caused by I/O,
and vary by 6 orders of magnitude from request to request.

-- Jamie
