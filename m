Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbTD3FtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 01:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTD3FtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 01:49:19 -0400
Received: from newman.cs.purdue.edu ([128.10.2.6]:18895 "EHLO
	newman.cs.purdue.edu") by vger.kernel.org with ESMTP
	id S262054AbTD3FtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 01:49:18 -0400
Date: Wed, 30 Apr 2003 01:01:35 -0500
From: Jae-Young Kim <jaykim@cs.purdue.edu>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel timer accuracy
Message-ID: <20030430060135.GA13292@punch.cs.purdue.edu>
References: <20030429165427.GA5923@punch.cs.purdue.edu> <33201371.1051641831@blackhawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33201371.1051641831@blackhawk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 06:43:51PM +0100, Andy Whitcroft wrote:
> My expectation of the error would be 'random' but it would depend on two 
> things.  Firstly, the accuracy of the clock used to measure the time and 
> secondly, the actual source of the packets, ie. the absolute accuracy of 
> the packet injection.  We may be seeing the difference between the two 
> clocks on the two machines in this combination.

First of all, thank you for everybody providing me valuable information. 
The above was right speculation on my timer problem. I got to know
what was wrong by checking the accuracy of the packet injection.

In my experiment, I sent a packet per second from a remote machine.
However, since the clock pacing of two different machines (the remote
packet-sending machine and the local machine) is different,
the packet injection at the local machine was not accurately
one-packet-per-second rate. Instead, in my previous experiment,
the remote machine's clock was slightly slower than the local machine's clock.
(The pacing difference is 10msec/600seconds.)

When my delay module set up a 5-ticks timer, the actual sleep time was
4 full tick time + 1 partial tick at the time of timer-setup. If a packet
arrives at the very beginning of the first tick, this packet will be
delayed for 5 full ticks (= nearly 50msec). However if a packet arrives
at the very end of the first tick, this packet will only be delayed
for about 4 full ticks. (= nearly 40msec). When time drift crosses the 
boundary of 1 tick (in my experiment, after 600 seconds), it will become 
the same as the former case and the same procedure is repeated.

During 600 seconds, the clock pacing difference has gradully created the time 
drift of packet injection and thus induced the odd delay trend. 

This was confirmed when I changed the sending machines. If the remote machine's
clock is faster than the local machine. The drift direction is backward.
If two machines' clocks are nearly synchronized, I couldn't see the
delay drift at all.

- Jay
