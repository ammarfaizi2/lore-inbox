Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTICVA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTICVA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:00:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:53732 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264286AbTICVAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:00:55 -0400
Date: Wed, 03 Sep 2003 13:48:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <105370000.1062622139@flay>
In-Reply-To: <20030903194658.GC1715@holomorphy.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 03, 2003 at 07:32:12PM +0100, Alan Cox wrote:
>> Now add a clusterfs and tell me the difference, other than there being a
>> lot less sharing going on...
> 
> The sharing matters; e.g. libc and other massively shared bits are
> replicated in memory once per instance, which increases memory and
> cache footprint(s). A number of other consequences of the sharing loss:

Explain the cache footprint argument - if you're only using a single
copy from any given cpu, it shouldn't affect the cpu cache. More 
importantly, it'll massively reduce the footprint on the NUMA 
interconnect cache, which is the whole point of doing text replication.

> The number of systems to manage proliferates.

Not if you have an SSI cluster, that's the point.

> Pagecache access suddenly involves cross-instance communication instead
> of swift memory access and function calls, with potentially enormous
> invalidation latencies.

No, each node in an SSI cluster has its own pagecache, that's mostly
independant.
 
> Userspace IPC goes from shared memory and pipes and sockets inside
> a single instance (which are just memory copies) to cross-instance
> data traffic, which involves slinging memory around through the
> hypervisor's interface, which is slower.

Indeed, unless the hypervisor-type-layer sets up an efficient cross
communication mechanism, that doesn't involve it for every transaction.
Yes, there's some cost here. If the workload is fairly "independant"
(between processes), it's easy, if it does a lot of cross-process
traffic with pipes and shit, it's going to hurt to some extent, but 
it *may* be fairly small, depending on the implementation.
 
> The limited size of a single instance bounds the size of individual
> applications, which at various times would like to have larger memory
> footprints or consume more cpu time than fits in a single instance.
> i.e. something resembling external fragmentation of system resources.

True. depends on how the processes / threads in that app communicate
as to how big the impact would be. There's nothing saying that two
processes of the same app in an SSI cluster can't run on different
nodes ... we present a single system image to userspace, across nodes.
Some of the glue layer (eg for ps, to give a simple example), like
for_each_task, is where the hard work in doing this is.

> Process migration is confined to within a single instance without
> some very ugly bits; things such as forking servers and dynamic task
> creation algorithms like thread pools fall apart here.

You *need* to be able to migrate processes across nodes. Yes, it's hard.
Doing it at exec time is easier, but still far from trivial, and not
sufficient anyway.
 
> There's suddenly competition for and a need for dynamic shifting around
> of resources not shared across instances, like private disk space and
> devices, shares of cpu, IP numbers and other system identifiers, and
> even such things as RAM and virtual cpus.
> 
> AFAICT this raises more issues than it addresses. Not that the issues
> aren't worth addressing, but there's a lot more to do than Larry
> saying "I think this is a good idea" before expecting anyone to even
> think it's worth thinking about.

It raises a lot of hard issues. It addresses a lot of hard issues. 
IMHO, it's a fascinating concept, that deserves some attention, and
I'd love to work on it. However, I'm far from sure it'd work out, and
until it's proven to do so, it's unreasonable to expect people to give
up working on the existing methods in favour of an unproven (but rather
cool) pipe-dream. 

What we're doing now is mostly just small incremental changes, and unlike Larry, I don't believe it's harmful (I'm not delving back into that 
debate again - see the mail archives of this list). I'd love to see how
the radical SSI cluster approach compares, when it's done. If I can 
get funding for it, I'll help it get done.

M.

