Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbUDRD0q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 23:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbUDRD0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 23:26:46 -0400
Received: from mail.shareable.org ([81.29.64.88]:25763 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264108AbUDRD0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 23:26:41 -0400
Date: Sun, 18 Apr 2004 04:26:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040418032638.GA1786@mail.shareable.org>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <20040416090331.GC22226@mail.shareable.org> <1082130906.2581.10.camel@lade.trondhjem.org> <20040416184821.GA25402@mail.shareable.org> <1082142401.2581.131.camel@lade.trondhjem.org> <20040416193914.GA25792@mail.shareable.org> <1082241169.3930.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082241169.3930.14.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> With this patch
>         - the major timeout is of fixed length "timeo<<retrans", and the
>         clock starts at the first attempt to send the packet.
>         - If a major timeout occurs, we now reset the RTT estimator so
>         as to "slow start" when the server becomes available again.
> 
> For the moment it does use the timeo + retrans values, because the
> former is in fact wanted in order to initialize the RTT estimator.
> However, it no longer uses the count of the number of actual
> retransmissions in order to determine whether or not a major timeout
> occurred.

Ok, observations:

    - The RTT converges to 0.1s on my LAN, just as it did before the patch.
      Very sensible, and as you said the 100 microsecond problem is not
      with us these days.

    - The RTT is reset after a timeout (from 0.1-0.15s to 0.7s in my tests).
      As expected.

    - With the defaults (retrans=3, timeo=0.7s), I see:

      After disconnecting the server, the client first times out after
      about 5.5-6 seconds.  First minor timeout is 0.1.  This makes sense
      as 0.7 << 3 == 5.6.

      Subsequent timeouts take about 10.5 seconds.  This also makes sense,
      as you have set the timeout threshold at 0.7*8 == 5.6 seconds,
      and three timeouts is 0.7*(1+2+4) == 4.9 seconds, too short.
      Four timeouts is 0.7*(1+2+4+8) == 10.5 seconds.

      The old behaviour before RTT estimation would have timed out
      after 10.5 seconds, I think.

    - With retrans=5, and timeo still has the default value of 0.7s:

      After disconnecting the server, the minor timeout intervals are
      approximately:

          0.1, 0.2, 0.4, 0.8, 1.6, 3.2, 3.2, 3.2, 3.2, 3.2, 3.2 seconds.

      Are they intended to stop doubling at 3.2?  The major timeout
      thus happens after 22.3 seconds.

      Unsurprisingly, subsequent major timeouts take 44.1 seconds.

So this patch is a big improvment, and I'm going to keep using it for my home
directory with retrans=5,soft so it gets some more background testing.
(retrans=3 is too short even with the patch).

However, there are potential improvements.  One is that the 3.2 above
should continue doubling.  The other is that behaviour would be nicer
if the major timeout time was more predictable: 22.3 to 44.1 seconds
is a big range.  This is easy with the algorithm described below.

It isn't possible to have remove the variation completely.  However,
it can easily by reduced by changing the doubling strategy: keep
doubling the retransmit time, until it exceeds timeo.  When that
happens, set the retransmit time to the next greater or equal value of
timeo << N for some integer N.

For example, with RTT at 0.1s, retrans=5, timeo=0.7, these would be
the minor timeout intervals:

    0.1, 0.2, 0.4, 0.7, 1.4, 2.8, 5.6, 11.2, 22.4

leading to a total major timeout time of 44.8 seconds.

Subsequent major timeouts, with the RTT reset to 0.7s, would take 44.1
seconds: 0.7, 1.4, 2.8, 5.6, 11.2, 22.4.

If the RTT estimator is larger than timeo to start with, the first
retransmit will timeout after RTT, but subsequent ones will be a value
of timeo << N.  E.g. if RTT was 2s, this would be the minor timeout
sequence: 2.0, 2.8, 5.6, 11.2, 22.4.

The algorithm for deciding when a major timeout occurs is different
too.  Instead of keeping track of the total time since the very first
transmission, you simply deem the major timeout to occur after the
minor timeout of timeo << retrans occurs.  I.e. in these examples, the
22.4s minor timeout is always the final one.

This reduces the possible variation, with these parameters, to the
range 44.1 to 45.325 seconds: much more consistent than 22.05 to 44.1
seconds.

As well as giving more consistent results, this might even be simpler
than the algorithm in your patch, because there is no need to remember
the total time since the first transmission.

-- Jamie
