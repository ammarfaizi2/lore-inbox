Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755957AbWKRESO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbWKRESO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 23:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755959AbWKRESO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 23:18:14 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:16865 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1755957AbWKRESN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 23:18:13 -0500
Date: Fri, 17 Nov 2006 20:18:12 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Bela Lubkin <blubkin@vmware.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: RE: touch_cache() only touches two thirds
In-Reply-To: <FE74AC4E0A23124DA52B99F17F44159701DBBFE7@PA-EXCH03.vmware.com>
Message-ID: <Pine.LNX.4.64.0611171953420.12661@twinlark.arctic.org>
References: <FE74AC4E0A23124DA52B99F17F441597DA118C@PA-EXCH03.vmware.com>
 <p734pt7k8s0.fsf@bingen.suse.de> <FE74AC4E0A23124DA52B99F17F44159701DBBFE7@PA-EXCH03.vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006, Bela Lubkin wrote:

> The corrected code in <http://bugzilla.kernel.org/show_bug.cgi?id=7476#c4>
> covers the full cache range.  Granted that modern CPUs may be able to track
> multiple simultaneous cache access streams: how many such streams are they
> likely to be able to follow at once?  It seems like going from 1 to 2 would
> be a big win, 2 to 3 a small win, beyond that it wouldn't likely make much
> incremental difference.  So what do the actual implementations in the field
> support?

p-m family, core, core2 track one stream on each of 12 to 16 pages.  in 
the earlier ones they split the trackers into some forward-only and some 
backward-only, but on core2 i think they're all bidirectional.  if i had 
to guess they round-robin the trackers, so once you hit 17 pages with 
streams they're defeated.

a p4 (0f0403, probably "prescott") i have here is tracking 16 -- seems to 
use LRU or pLRU but i haven't tested really, you need to get out past 32 
streams before it really starts falling off... and even then the next-line 
prefetch in the L2 helps too much (64-byte lines, but 128-byte tags and a 
pair of dirty/state bits -- it prefetches the other half of a pair 
automatically).  oh it can track forward or backward, and is happy with 
strides up to 128.

k8 rev F tracks one stream on each of 20 pages (forward or backward).  it 
also seems to use round-robin, and is defeated as soon as you have 21 
streams.

i swear there was an x86 which did 28 streams, but it was a few years ago 
that i last looked really closely at the prefetchers and i don't have 
access to the data at the moment.

i suggest that streams are the wrong approach.  i was actually considering 
this same problem this week, happy to see your thread.

the approach i was considering was to set up two pointer chases:

one pointer chase covering enough cache lines (and in a prefetchable 
ordering) for "scrubbing" the cache(s).

another pointer chase arranged to fill the L1 (or L2) using many many 
pages.  i.e. suppose i wanted to traverse 32KiB L1 with 64B cache lines 
then i'd allocate 512 pages and put one line on each page (pages ordered 
randomly), but colour them so they fill the L1.  this conveniently happens 
to fit in a 2MiB huge page on x86, so you could even ameliorate the TLB 
pressure from the microbenchmark.

you can actually get away with a pointer every 256 bytes today -- none of 
the prefetchers on today's x86 cores consider a 256 byte stride to be 
prefetchable.  for safety you might want to use 512 byte alignment... this 
lets you get away with fewer pages for colouring larger caches.

the benchmark i was considering would be like so:

	switch to cpu m
	scrub the cache
	switch to cpu n
	scrub the cache
	traverse the coloured list and modify each cache line as we go
	switch to cpu m
	start timing
	traverse the coloured list without modification
	stop timing

-dean
