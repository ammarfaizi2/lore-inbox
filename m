Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTIGPmm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 11:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbTIGPmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 11:42:42 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:57486 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263337AbTIGPmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 11:42:39 -0400
Date: Sun, 7 Sep 2003 16:42:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client problems in 2.4.18 to 2.4.20
Message-ID: <20030907154238.GK19977@mail.jlokier.co.uk>
References: <16218.5318.401323.630346@charged.uio.no> <20030906212250.64809.qmail@web40414.mail.yahoo.com> <20030906231401.GB12392@mail.jlokier.co.uk> <16218.37312.1855.652692@charged.uio.no> <20030907142727.GG19977@mail.jlokier.co.uk> <16219.19506.659542.990013@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16219.19506.659542.990013@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> This is not an issue for tapes, etc. NFS has an alternative mechanisms
> for dealing with this in the form of the NFSERR_JUKEBOX error.

Oh, cool.  Perhaps the server should send these automatically, when
I/O operations are taking a little bit too long?

> However for disks I agree that you do have 'large' variations between
> the cached and uncached case. Should latency really be much larger
> than 1/10 second for a 32k read though?

Yes, it often is.  I seek 32k reads taking several seconds, when the
disk is busy with other tasks.

>      > The fundamental error is assuming that all NFS requests take
>      > about the same time to server, and delays are caused by the
>      > network.  This isn't true especially on a LAN.  Delays for NFS
>      > are typically caused by I/O, and vary by 6 orders of magnitude
>      > from request to request.
> 
> If it was merely a case of random error, then we wouldn't have a
> problem at all. The RTT code does make an estimate of the error on the
> the measurement. The problem is that there is a large tail in the
> graph of round trip time vs. number of events due to these disk
> spinups, etc...

Yes, exactly.  Though I saw the tail due to normal disk seek + access
time is quite significant, compared with cached access time.

> However retransmissions compensate somewhat because they impose a
> geometric increase in the timeout value. i.e. The for the first
> transmission the timeout == the rto, then the retransmissions follow
> 2*rto, 4*rto, 8*rto,...
> 
> Part of the problem in the Linux case is therefore that we have a too
> low default value for 'retrans'. The kernel default is '5' (same as
> for Solaris, however the mount program still overrides that default
> with a value of '3'. This implies that for soft mounts, we never wait
> longer than 15*rto before we time out (well - 7*rto actually since the
> code in xdr_adjust_timeout() actually appears to confuse number of
> retransmissions with the number of transmissions).
> 
> By setting 'retrans=6' (5 + 1 to compensate for the bug), therefore,
> people can ensure that we retry for at least 6 seconds before timing
> out. The question is: is this an adequate default?

That would be a big improvement.  I take it you have effectively
clamped the retransmit time at a minimum of 1/10 second, then?  (I
didn't understand what you meant earlier).

Last time I used a soft mount, I was seeing the first retransmit after
some time smaller than a millisecond.  (I don't remember, but 0.1ms
sounds about right).  If that is the retransmit time, then retrans=6
won't be enough - retrans=16 would be needed.  I don't think a good
correct retrans=xxx setting should depend on the network like that.
Setting a minimum retransmit time is one way to fix that.

-- Jamie
