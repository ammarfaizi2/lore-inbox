Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTKKFgN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 00:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTKKFgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 00:36:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:45018 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263357AbTKKFgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 00:36:09 -0500
Date: Mon, 10 Nov 2003 21:36:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Paul Venezia <pvenezia@jpj.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
In-Reply-To: <20031110205443.6422259f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0311102101500.2881-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Nov 2003, Andrew Morton wrote:
> >   0 10      0 1146444  18940 286856    0    0     0  2106 21450 25860  4 14 37 45
> 
> OK, the IO rates are obviously very poor, and the context switch rate is
> suspicious as well.  Certainly, testing with the single disk would help.
> 
> But.  If the workload here was a simple dd of /dev/zero onto a regular
> file then why on earth is the pagecache size not rising?

Interesting. That does indeed look really strange. Paul has more than a 
gigabyte of free memory, and it isn't shrinking.

That interrupt and context switch numbers are also _way_ out of line: Paul
has big stretches with 25k+ interrupts per second and 30k+ context
switches. While at the same time only feeding a few megabytes of data
through the system.

That would imply more than one interrupt per _sector_ (there really
shouldn't be anything else going on there, if it's a local "dd").  Which
is patently ridiculous. There's something seriously broken in there.

Any "normal" IO load should get one interrupt per request, and requests
should be in the "closer to hundred-kB" range for reasonably contiguous
IO. For a normal "dd to file" on a good single-disk system, something like
40MB/s with 1500+ interrupts/sec should be the normal baseline (1000
interrupts / sec come from the regular timer interrupt, the extra 500+
would be the IO completion interrupts).

And you should see context switches on maybe a request basis (ie you might
see 500 context switches a second). Again, seeing 30k ctx/sec for a 3MB
throughput implies one context switch per 100 _bytes_. Whee. That's just
_wrong_.

I see 1200 context switches a second when I move my mouse around and try
to upset X and the window manager as much as possible. That's "normal",
with a hundred mouse events a second that just _cascade_ through a system.  
But that's for a device that is literally _designed_ to be "lots of small
events, and throughput isn't even on our radar".

Btw, is the RAID1 setup using hw raid or the sw raid code? I _assume_ 
you're just using the MPT hw support?

		Linus


