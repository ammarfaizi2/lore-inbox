Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVBIEZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVBIEZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 23:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVBIEZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 23:25:07 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52635 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261777AbVBIEY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 23:24:59 -0500
Date: Tue, 8 Feb 2005 20:23:56 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: mbligh@aracnet.com, dino@in.ibm.com, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20050208202356.41bda38b.pj@sgi.com>
In-Reply-To: <42094AA7.6050006@yahoo.com.au>
References: <20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<1097014749.4065.48.camel@arrakis>
	<420800F5.9070504@us.ibm.com>
	<20050208095440.GA3976@in.ibm.com>
	<42088B3E.7050701@yahoo.com.au>
	<43450000.1107879186@[10.10.2.4]>
	<42094AA7.6050006@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> The biggest issues may be the userspace
> interface and a decent userspace management tool.

One possibility, perhaps, would be to have a boolean flag "sched_domain"
on each cpuset, indicating whether it was a sched domain or not.  If a
cpuset had its sched_domain flag set, then that cpusets cpus_allowed
mask would define a sched domain.

Later Nick wrote:
> In the (hopefully) common case where there are disjoint partitions
> _somewhere_, sched domains can do the job in a much better
> way than task cpu affinities (better isolation, multiprocessor
> balancing shouldn't break down).
> 
> Those users with overlapping CPU sets can then use task affinities
> on top of sched domains partitions to get the desired result.

Ok - seems it should work with the above cpuset flag marking sched
domains, and a rule that _those_ cpusets so marked can't overlap.  Other
cpusets that are not so marked, and any sched_setaffinity calls, can do
whatever they want.  Trying to turn on the sched_domain flag on a cpuset
that overlapped with existing such cpuset sched_domains, or trying to
mess with the CPUs (cpus_allowed) in an existing cpuset sched_domain so
as to force it to overlap, would return an error to user space on that
write(2).

If the sysadmin didn't mark any cpusets as sched_domains, then fall back
to something automatic and useful.

Inside the kernel, we'll need someway for the cpuset code to tell the
sched code about sched_domain changes.  This might mean something like
the following.  Have the sched code provide the cpuset code a couple of
routines, one to setup and and the other to tear down sched_domains.

Both calls would take a cpumask_t argument, and return void.  The setup
call must pass a cpumask that does not overlap any existing sched
domains defined via cpusets.  The tear down call must pass a cpumask
value exactly matching a previous, still active, setup call.

So if someone made a single CPU change to an existing sched_domain
defining cpuset, the kernel cpuset code would have to call the kernel
sched code twice, first to tear down the old sched_domain, and then to
setup the new, slightly different, one.  The cpuset code would likely be
holding the single global cpuset_sem semaphore across this pair of
calls.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
