Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUBOAHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 19:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUBOAHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 19:07:41 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:15239 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S263646AbUBOAGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 19:06:36 -0500
Date: Sat, 14 Feb 2004 16:06:35 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Simonas Leleiva <Simonas.Leleiva@e-net.lt>
cc: linux-kernel@vger.kernel.org
Subject: Re: benchmarking bandwidth Northbridge<->RAM
In-Reply-To: <4022C869.10805@e-net.lt>
Message-ID: <Pine.LNX.4.58.0402141554380.5174@twinlark.arctic.org>
References: <4022C869.10805@e-net.lt>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, Simonas Leleiva wrote:

> 2. But what about L1/L2 caching ruining the benchmark, about which I judge
> from very big results (~5GB/s is truly not the correct benchmark with my
> 2x166MHz RAM and 64bit bus - in the best case it should not overflow
> 2.5GB/s)? I've searched the web for cache disablings, but what I've only
> found was the memtest's source-code, which works only under plain non-Linux
> (non PM) environment (memtest makes a bootable floppy and then launches 'bare
> naked'). So I find memtest's inline assembly useless under linux..

mem read/write latency for memory mapped uncachable doesn't always have a
direct relationship to the cold-cache case of the normal cachable path.
it's still an interesting thing to measure the uncachable path -- but
if you're really interested in the cachable path you need to do it a
different way.

the absolute best way to look at cold cache mem read latency is to set up
a random pointer chase.  it has to be random because you want to eliminate
the effect of automatic hw prefetchers present in most modern hardware.

lmbench 3.0 has some code which is almost right (iirc it's the lat_mem
component) -- but it does these random walks within a page before moving
to another page.  this doesn't defeat prefetchers well enough.  i.e. a
prefetcher need only see a couple accesses on a page before it can just
decide to stream the entire page in and get a better cache hit rate.
in my experience there are prefetchers which defeat this.

in case you haven't heard of a pointer chase, it's basically a loop which
looks like this:

	void *p = foo;

	for (;;) {
		p = *(void **)p;
		p = *(void **)p;
		p = *(void **)p;
		... repeated 100 times
	}

it's a linked list walk basically.

the genius of pointer chases is that you can measure a bazillion memory
system details just by varying the layout of the linked list.

to defeat L1/L2/prefetchers choose a large arena, say 32MiB, break it up
into 64B (or whatever the linesize is) objects, then place those objects
into a linked list in a random order.

-dean

p.s. bunzip2 is a real-world workload which is essentially a random
memory walk over 4-byte objects in a 3600000 byte array.
