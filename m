Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264474AbTICVki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTICVki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:40:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:50400 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264474AbTICVke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:40:34 -0400
Date: Wed, 03 Sep 2003 14:29:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <115070000.1062624541@flay>
In-Reply-To: <20030903212119.GX4306@holomorphy.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 03, 2003 at 01:48:59PM -0700, Martin J. Bligh wrote:
>> Not if you have an SSI cluster, that's the point.
> 
> The scenario described above wasn't SSI but independent instances with
> a shared distributed fs. 

OK, sorry - crosstalk confusion between subthreads.

> SSI clusters have most of the same problems,
> really. Managing the systems just becomes "managing the nodes" because
> they're not called systems, and you have to go through some (possibly
> automated, though not likely) hassle to figure out the right way to
> spread things across nodes, which virtualizes pieces to hand to which
> nodes running which loads, etc.

That's where I disagree - it's much easier for the USER because an SSI
cluster works out all the load balancing shit for itself, instead of
pushing the problem out to userspace. It's much harder for the KERNEL
programmer, sure ... but we're smart ;-) And I'd rather solve it once,
properly, in the right place where all the right data is about all
the apps running on the system, and the data about the machine hardware.
 
> On Wed, Sep 03, 2003 at 01:48:59PM -0700, Martin J. Bligh wrote:
>> No, each node in an SSI cluster has its own pagecache, that's mostly
>> independant.
> 
> But not totally. truncate() etc. need handling, i.e. cross-instance
> pagecache invalidations. And write() too. =)

Same problem as any clustered fs, but yes, truncate will suck harder
than it does now. Not sure I care though ;-) Invalidations on write,
etc will be more expensive when we're sharing files across nodes, but
independant operations will be cheaper due to the locality. It's a 
tradeoff - whether it pays off or not depends on the workload.

>> True. depends on how the processes / threads in that app communicate
>> as to how big the impact would be. There's nothing saying that two
>> processes of the same app in an SSI cluster can't run on different
>> nodes ... we present a single system image to userspace, across nodes.
>> Some of the glue layer (eg for ps, to give a simple example), like
>> for_each_task, is where the hard work in doing this is.
> 
> Well, let's try the word "process" then. e.g. 4GB nodes and a process
> that suddenly wants to inflate to 8GB due to some ephemeral load
> imbalance.

Well, if you mean "task" in the linux sense (ie not a multi-threaded
process), that reduces us from worrying about tasks to memory. On an
SSI cluster that's on a NUMA machine, we could loan memory across nodes
or something, but yes, that's definitely a problem area. It ain't no
panacea ;-)

M.

