Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992716AbWJTTTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992716AbWJTTTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992718AbWJTTTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:19:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2476 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S2992716AbWJTTTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:19:30 -0400
Date: Fri, 20 Oct 2006 12:19:12 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, mbligh@google.com, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061020121912.9a391f87.pj@sgi.com>
In-Reply-To: <20061020102946.A8481@unix-os.sc.intel.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<4538F34A.7070703@yahoo.com.au>
	<20061020102946.A8481@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> I like the direction of Nick's patch which do domain partitioning
> at the top-most exclusive cpuset.

See the reply I just posted to Nick on this.

His patch didn't partition at the top cpuset, but at its children.
It could not have done any better than that.

The top cpuset covers all online cpus on the system, which is the
same as the default sched domain partition.  Partitioning there
would be a no-op, producing the same one big partition we have now.

Partitioning at any lower level, even just the immediate children
of the root cpuset as Nick's patch does, breaks load balancing for
any tasks in the top cpuset.

And even if for some strange reason that weren't a problem, still
partitioning at the level of the immediate children of the root cpuset
doesn't help much on a decent proportion of big systems.  Many of my
big systems run with just two cpusets right under the top cpuset, a
tiny cpuset (say 4 cpus) for classic Unix daemons, cron jobs and init,
and a huge (say 1020 out of 1024 cpus) cpuset for the batch scheduler
to slice and dice, to sub-divide into smaller cpusets for the various
jobs and other needs it has.

These systems would still suffer from any performance problems we had
balancing a huge sched domain.  Presumably the pain of balancing a
1020 cpu partition is not much less than it is for a 1024 cpu partition.

So, regrettably, Nick's patch is both broken and useless ;).

Only a finer grain sched domain partitioning, that accurately reflects
the placement of active jobs and tasks needing load balancing, is of
much use here.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
