Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269318AbTGJPVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269319AbTGJPVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:21:25 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:147 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S269318AbTGJPVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:21:18 -0400
Date: Thu, 10 Jul 2003 16:35:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client errors with 2.5.74?
Message-ID: <20030710153557.GD29113@mail.jlokier.co.uk>
References: <20030710053944.GA27038@mail.jlokier.co.uk> <16141.15245.367725.364913@charged.uio.no> <20030710150012.GA29113@mail.jlokier.co.uk> <16141.32852.39625.891724@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16141.32852.39625.891724@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> >>>>> " " == Jamie Lokier <jamie@shareable.org> writes:
> 
> 
>      > There is no 0.7 second delay either (the default value of
>      > "timeo" according to nfs(5)).  So the retransmission logic is
>      > buggered.
> 
> No. manpage is buggered. We use round trip time estimation now...
> 
> 
>      > However, the protocol problem remains: multiple READDIRPLUS
>      > calls with the same xid in a fraction of a second.  Note: there
>      > is no 0.7 second delay between these packets.  According to
>      > Ethereal, it is between
>      > 0.01 and 0.1 seconds between duplicate requests.
> 
> Yup. That's what the RTO does...

So the problem state arises when the round trip time converges on some
value which is too small?  And in this state, "soft" returns EIO
within some ridiculously small timeout?

It is definitely too small because I see that the bulk of readdir
requests are fine for the first few thousand, but nearly all of them
have one or more duplicates after that.  There is no justification for
those duplicates - all the original requests are getting replies.

It's possible that the server is taking longer to respond to
READDIRPLUS than to GETATTR.  That makes sense, because the
READDIRPLUS reads inodes from disk, then GETATTR just reads them from
memory.  Let's take a look...

Yup!  In the traces, GETATTR responds consistently in 0.0002 seconds
(close to ping time, clearly no disk access), whereas READDIRPLUS
takes some 0.2 seconds to respond.

I see that the RTT estimation _is_ adapting quickly to this: the first
READDIRPLUS in a sequence has several duplicates; subsequent ones don't.

Suggestion:

  - With RTT estimation, "not responding" should require a certain
    amount of absolute time to pass, e.g. 5 seconds, not just a fixed
    number of packets.  Without this, "soft" is broken because the
    time difference between a response for cached data and a response
    from the disk is a factor of several hundred.

Note that I'm looking as "ls -R" now because it's easy to repeat, but
the EIO problem occurs with file reading and writing too.

-- Jamie


p.s Another quirk is I see the server sending more than one duplicate
    reply to each duplicate READDIRPLUS request...  Well, that's a
    separate problem I think :)
