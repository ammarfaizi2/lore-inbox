Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTICVUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTICVUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:20:39 -0400
Received: from holomorphy.com ([66.224.33.161]:58506 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264324AbTICVUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:20:36 -0400
Date: Wed, 3 Sep 2003 14:21:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030903212119.GX4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105370000.1062622139@flay>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>>  The sharing matters; e.g. libc and other massively shared bits are
>>  replicated in memory once per instance, which increases memory and
>>  cache footprint(s). A number of other consequences of the sharing loss:

On Wed, Sep 03, 2003 at 01:48:59PM -0700, Martin J. Bligh wrote:
> Explain the cache footprint argument - if you're only using a single
> copy from any given cpu, it shouldn't affect the cpu cache. More 
> importantly, it'll massively reduce the footprint on the NUMA 
> interconnect cache, which is the whole point of doing text replication.

The single copy from any given cpu assumption was not explicitly made.
Some of this depends on how the administrator/whoever wants to arrange
OS instances so that when one becomes blocked on io or otherwise idled
others can make progress or other forms of overcommitment.


At some point in the past, I wrote:
>>  The number of systems to manage proliferates.

On Wed, Sep 03, 2003 at 01:48:59PM -0700, Martin J. Bligh wrote:
> Not if you have an SSI cluster, that's the point.

The scenario described above wasn't SSI but independent instances with
a shared distributed fs. SSI clusters have most of the same problems,
really. Managing the systems just becomes "managing the nodes" because
they're not called systems, and you have to go through some (possibly
automated, though not likely) hassle to figure out the right way to
spread things across nodes, which virtualizes pieces to hand to which
nodes running which loads, etc.


At some point in the past, I wrote:
>>  Pagecache access suddenly involves cross-instance communication instead
>>  of swift memory access and function calls, with potentially enormous
>>  invalidation latencies.

On Wed, Sep 03, 2003 at 01:48:59PM -0700, Martin J. Bligh wrote:
> No, each node in an SSI cluster has its own pagecache, that's mostly
> independant.

But not totally. truncate() etc. need handling, i.e. cross-instance
pagecache invalidations. And write() too. =)


At some point in the past, I wrote:
>>  The limited size of a single instance bounds the size of individual
>>  applications, which at various times would like to have larger memory
>>  footprints or consume more cpu time than fits in a single instance.
>>  i.e. something resembling external fragmentation of system resources.

On Wed, Sep 03, 2003 at 01:48:59PM -0700, Martin J. Bligh wrote:
> True. depends on how the processes / threads in that app communicate
> as to how big the impact would be. There's nothing saying that two
> processes of the same app in an SSI cluster can't run on different
> nodes ... we present a single system image to userspace, across nodes.
> Some of the glue layer (eg for ps, to give a simple example), like
> for_each_task, is where the hard work in doing this is.

Well, let's try the word "process" then. e.g. 4GB nodes and a process
that suddenly wants to inflate to 8GB due to some ephemeral load
imbalance.


-- wli
