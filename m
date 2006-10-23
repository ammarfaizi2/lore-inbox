Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWJWFve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWJWFve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 01:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWJWFve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 01:51:34 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59324 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751533AbWJWFvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 01:51:33 -0400
Date: Sun, 22 Oct 2006 22:51:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dino@in.ibm.com, akpm@osdl.org, mbligh@google.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061022225108.21716614.pj@sgi.com>
In-Reply-To: <453C4E22.9000308@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<20061020210422.GA29870@in.ibm.com>
	<20061022201824.267525c9.pj@sgi.com>
	<453C4E22.9000308@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> Did you send resend the patch to remove sched-domain partitioning?
> After clearing up my confusion, IMO that is needed and could probably
> go into 2.6.19.

The patch titled
     cpuset: remove sched domain hooks from cpusets
went into *-mm on Friday, 20 Oct.

Is that the patch you mean?

It's just the first step - unplugging the old.

Now we need the new:
 1) Ability at runtime to isolate cpus for real-time and such.
 2) Big systems perform better if we can avoid load balancing across
    zillions of cpus.

> The sched-domains code is all there and just ready to be used. IMO
> using the cpusets API (or a slight extension thereof) would be the
> best idea if we're going to use any explicit interface at all.

Good.  Thanks.

> A cool option would be to determine the partitions according to the
> disjoint set of unions of cpus_allowed masks of all tasks. I see this
> getting computationally expensive though, probably O(tasks*CPUs)... I
> guess that isn't too bad.

Yeah - if that would work, from the practical perspective of providing
us with a useful partitioning (get those humongous sched domains carved
down to a reasonable size) then that would be cool.

I'm guessing that in practice, it would be annoying to use.  One would
end up with stray tasks that happened to be sitting in one of the bigger
cpusets and that did not have their cpus_allowed narrowed, stopping us
from getting a useful partitioning.  Perhaps anilliary tasks associated
with the batch scheduler, or some paused tasks in an inactive job that
were it active would need load balancing across a big swath of cpus.
These would be tasks that we really didn't need to load balance, but they
would appear as if they needed it because of their fat cpus_allowed.

Users (admins) would have to hunt down these tasks that were getting in
the way of a nice partitioning and whack their cpus_allowed down to
size.

So essentially, one would end up with another userspace API, backdoor
again.  Like those magic doors in the libraries of wealthy protagonists
in mystery novels, where you have to open a particular book and pull
the lamp cord to get the door to appear and open.

Automatic chokes and transmissions are great - if they work.  If not,
give me a knob and a stick.

===

Another idea for a cpuset-based API to this ...

>From our internal perspective, it's all about getting the sched domain
partitions cut down to a reasonable size, for performance reasons.

But from the users perspective, the deal we are asking them to
consider is to trade in fully automatic, all tasks across all cpus,
load balancing, in turn for better performance.

Big system admins would often be quite happy to mark the top cpuset
as "no need to load balance tasks in this cpuset."  They would
take responsibility for moving any non-trivial, unpinned tasks into
lower cpusets (or not be upset if something left behind wasn't load
balancing.)

And the batch scheduler would be quite happy to mark its top cpuset as
"no need to load balance".  It could mark any cpusets holding inactive
jobs the same way.

This "no need to load balance" flag would be advisory.  The kernel
might load balance anyway.  For example if the batch scheduler were
running under a top cpuset that was -not- so marked, we'd still have
to load balance everyone.  The batch scheduler wouldn't care.  It would
have done its duty, to mark which of its cpusets didn't need balancing.

All we need from them is the ok to not load balance certain cpusets,
and the rest is easy enough.  If they give us such ok on enough of the
big cpusets, we give back a nice performance improvement.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
