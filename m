Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTIGPSR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 11:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbTIGPSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 11:18:17 -0400
Received: from pat.uio.no ([129.240.130.16]:63987 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263338AbTIGPSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 11:18:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16219.19506.659542.990013@charged.uio.no>
Date: Sun, 7 Sep 2003 11:18:10 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: NFS client problems in 2.4.18 to 2.4.20
In-Reply-To: <20030907142727.GG19977@mail.jlokier.co.uk>
References: <16218.5318.401323.630346@charged.uio.no>
	<20030906212250.64809.qmail@web40414.mail.yahoo.com>
	<20030906231401.GB12392@mail.jlokier.co.uk>
	<16218.37312.1855.652692@charged.uio.no>
	<20030907142727.GG19977@mail.jlokier.co.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jamie Lokier <jamie@shareable.org> writes:

     > A real problem is the rule of having a fixed number of
     > retransmits before an operation fails with a "soft" moount.
     > This is wrong for NFS, now that rtt is estimated dynamically.

     > The "soft operation fail" imeout should have a minimum absolute
     > time, like 30 seconds or so.  It should also have a maximum
     > (for systems where the estimated rtt is 10 seconds).  This
     > should be independent of the rtt estimate.

     > - server responds to cached requests within 10 microseconds

     >    - uncached requests take 10 seconds to respond (spinning up CD,
     >      seeking on tape HFS, or just ordinary disk/swap
     >      contention).

This is not an issue for tapes, etc. NFS has an alternative mechanisms
for dealing with this in the form of the NFSERR_JUKEBOX error.

However for disks I agree that you do have 'large' variations between
the cached and uncached case. Should latency really be much larger
than 1/10 second for a 32k read though?

     > The fundamental error is assuming that all NFS requests take
     > about the same time to server, and delays are caused by the
     > network.  This isn't true especially on a LAN.  Delays for NFS
     > are typically caused by I/O, and vary by 6 orders of magnitude
     > from request to request.

If it was merely a case of random error, then we wouldn't have a
problem at all. The RTT code does make an estimate of the error on the
the measurement. The problem is that there is a large tail in the
graph of round trip time vs. number of events due to these disk
spinups, etc...

However retransmissions compensate somewhat because they impose a
geometric increase in the timeout value. i.e. The for the first
transmission the timeout == the rto, then the retransmissions follow
2*rto, 4*rto, 8*rto,...

Part of the problem in the Linux case is therefore that we have a too
low default value for 'retrans'. The kernel default is '5' (same as
for Solaris, however the mount program still overrides that default
with a value of '3'. This implies that for soft mounts, we never wait
longer than 15*rto before we time out (well - 7*rto actually since the
code in xdr_adjust_timeout() actually appears to confuse number of
retransmissions with the number of transmissions).

By setting 'retrans=6' (5 + 1 to compensate for the bug), therefore,
people can ensure that we retry for at least 6 seconds before timing
out. The question is: is this an adequate default?

Cheers,
  Trond
