Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSGSWFf>; Fri, 19 Jul 2002 18:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSGSWFf>; Fri, 19 Jul 2002 18:05:35 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:23195 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S317091AbSGSWFe>;
	Fri, 19 Jul 2002 18:05:34 -0400
Date: Fri, 19 Jul 2002 15:08:36 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Unusable 2.4 and 2.5 read-ahead latencies
Message-ID: <20020719220836.GA20521@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'lo,

I'm having issues with the latency created by read-ahead in 2.4 (.19rc1)
and in 2.5 (.26), wrt to NFS mounted MP3 files coming across a cablemodem
with capped upstream (probably fairly common).  In 2.4.19rc1, the problem
only shows up sometimes.  In 2.5.26, the problem is happening always.

What seems to be the case is that the kernel detects the sequentual read
(or not, I don't know), and decides to be nice and read a bunch ahead. 
Unfortunately, it seems to be blocking all reading until the big request
is filled, which ends up taking about 4 - 5 seconds over this link.  xmms
isn't very happy with this, and underruns until the burst comes through. 
xmms then starts playing, reaches near the end of the data, the kernel
starts to read-ahead again, and xmms underruns again while waiting for
the big burst.  Repeat until song is finished.

2.4 appears to scale the read-ahead somehow, and the latency stays
fairly low.  However, after some playing, the read-ahead block size
tends to creep up and cause the underruns again.  I found I could tweak
the maximum read-ahead size in /proc, and that seemed to work around
the problem, but this doesn't appear to exist in 2.5 /proc.

So, why doesn't the kernel allow the application to see the blocks when
they arrive?  tcpdump shows successful transfers coming through while
xmms is sitting waiting on even just one page.  I can see how getting to
at least a page size can help, and perhaps batching slightly will help
context switching or perhaps read-ahead thrashing between two
simultaneous readers, but in this case it is completely unusably long. 
Even catting the files shows the large 4 second delays between data
streams.

I can also see how having such long waits would also hurt cases where
the load is fairly equally CPU and disk I/O bound (I/O burst, CPU burst,
repeat, rather than streaming in the I/O and keeping the CPU saturated).
Perhaps the read-ahead blocking should only occur when there is another
read-ahead active (to avoid seek thrashing)?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
