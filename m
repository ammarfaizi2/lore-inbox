Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbUDTAJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUDTAJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUDTAJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:09:46 -0400
Received: from mail.shareable.org ([81.29.64.88]:30116 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261804AbUDTAJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:09:35 -0400
Date: Tue, 20 Apr 2004 01:09:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040420000932.GA15220@mail.shareable.org>
References: <20040416090331.GC22226@mail.shareable.org> <1082130906.2581.10.camel@lade.trondhjem.org> <20040416184821.GA25402@mail.shareable.org> <1082142401.2581.131.camel@lade.trondhjem.org> <20040416193914.GA25792@mail.shareable.org> <1082241169.3930.14.camel@lade.trondhjem.org> <20040418032638.GA1786@mail.shareable.org> <1082271815.3619.104.camel@lade.trondhjem.org> <20040418232230.GA11064@mail.shareable.org> <1082389088.2559.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082389088.2559.34.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> > I agree, but would still prefer more consistent behaviour if it is
> > easy -- and I explained how to do it, it's an easy algorithm.
> 
> The reason I don't like it is that it continues to tie the major timeout
> to the resend timeouts. You've convinced me that they should not be the
> same thing.

Sorry, I don't understand that paragraph.

The algorithm I suggested _decouples_ the major timeout from the rtt
estimate.  Your algorithm strongly couples them.  I'm not sure what
you mean by saying the major timeout is "tied to the resend timeouts".

Your current (patched) algorithm sets the major timeout to be in the
range:

     [timeo << retrans, (timeo << retrans) * 2]

The suggested algorithm sets the major timeout to be in the range:

     [timeo << (retrans+1), (timeo << (retrans+1)) + 2 * timeo)

I.e. with retrans set to a new default of 5 (I think that's useful),
the major timeout is approx [44.8, 46] instead of [22.4, 44.8].

I agree it's not the most important thing in the world, but it is nice
to be able to fix the parameters and say that with the defaults, major
timeout happens after about 45 seconds.

You say you don't like it because major timeout is still tied to
something.  Could you explain what the ideal behaviour you have in
mind is?  Right now, with the patch, I think your intention is to have
a fixed major timeout time, but it doesn't work like that.

> The other reason is that it only improves matters for the first request.
> Once we reset the RTO, all those other outstanding requests are anyway
> going to see an immediate discontinuity as their basic timeout jumps
> from 1ms to 700ms.

Yes, that's the point: after a retransmits passes a threshold, we
should no longer depend on the RTO estimate because it doesn't seem to
be reliable.

> So why go to all that trouble just for 1 request?

Because it's visible behaviour with "soft" mounts.  Someone unplugs
the cable or the network is down, and you see the I/O errors after
about 40 seconds.  This is nicer than seeing them after an unknown
period between 40 and 80 (or 20 and 40 depending on your settings).

> It was partly another "consistency" issue that initially worried me,
> partly in order to avoid problems with overflow:
> If you have more than one outstanding request, then those that get
> scheduled after the first major timeout (when we reset the RTO
> estimator) will see a "jump". If the "retries" variable is too large,
> they will either jump straight over 60 seconds, and thus trigger the cap
> or they will end up at zero due to 32-bit overflow.

Ah.  So you keep track of the number of retries per request, and each
time you send a request you set its timeout to (RTO << retries)?

If you do, maybe that's why my algorithm seems over complicated, and
you're concerned about overflows etc.

Instead of counting retries, don't.  You don't need a per-request
retries counter.  Instead: keep track of the request_timeout when the
request was last issued.  When retransmitting, compare that value
against the global value (timeo << retrans).  When a request times out
and request_timeout >= (timeo << retrans), that's a major timeout.
Otherwise you just check if request_timeout < timeo.  If yes, double
it.  If no, set request_timeout = timeo << N for the smallest integer
N such that it's an increase.  And try again.

Notice how that logic is based on constants: it's independent of RTO,
and so outstanding requests aren't affected by changes in RTO.
There's no jump, no overflow, and you can compute the key constant
(timeo << retrans) when initialising: retrans isn't used by itself.

-- Jamie

