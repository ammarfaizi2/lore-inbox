Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbTL3VXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 16:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbTL3VXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 16:23:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:17046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265802AbTL3VXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 16:23:33 -0500
Date: Tue, 30 Dec 2003 13:23:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <Pine.LNX.4.58.0312301524220.3152@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0312301318540.2065@home.osdl.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
 <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
 <Pine.LNX.4.58.0312291502210.1586@home.osdl.org>
 <Pine.LNX.4.58.0312300903170.2825@localhost.localdomain>
 <20031230143929.GN27687@holomorphy.com> <Pine.LNX.4.58.0312301524220.3152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Thomas Molina wrote:
> 
> The times for this operation is:
> real	15m20s
> user	0m35s
> sys	0m20s

Ok. This looks much closer to the 2.4.x numbers you reported:

	real    13m50.198s
	user    0m33.780s
	sys     0m15.390s

so I assume that we can consider this problem largely solved? There's 
still some difference, that could be due to just VM tuning.. 

I suspect that what happened is:
 - slab debugging adds a heavy CPU _and_ it also makes all the slab caches 
   much less dense.
 - as a result, you see much higher system times, and you also end up 
   needing much more memory for things like the dentry cache, so your 
   memory-starved machine ended up swapping a lot more too.

> On my main system (1.3GHz Athlon, 512MB memory, fast hard drive; in other 
> words has plenty of resources) I get similar results, scaled down of 
> course.
> 
> On 2.4 the times are
> real	3m47s
> user	14s
> sys	7s
> 
> On 2.6 the times are
> real	3m27s
> user	14s
> sys	7s

So here 2.6.x actually outperforms 2.4.x

> I also get 90+ percent iowait under 2.6 and 0 iowait in 2.4.

This is likely just an issue of reporting. Under 2.6.x your idle time will 
be reported as iowait, while in your 2.4.x kernel you don't even have the 
iowait support, so all idle time is just "idle", and not split up into 
_why_ it is idle.

			Linus
