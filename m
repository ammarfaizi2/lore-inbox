Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWJQTSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWJQTSz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWJQTSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:18:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5852 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751178AbWJQTSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:18:54 -0400
Date: Tue, 17 Oct 2006 12:18:23 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: dino@in.ibm.com, suresh.b.siddha@intel.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-Id: <20061017121823.e6f695aa.pj@sgi.com>
In-Reply-To: <20061017114306.A19690@unix-os.sc.intel.com>
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
	<20061017114306.A19690@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What happens when the job in the cpuset with no sched domain
> becomes active? In this case, scheduler can't make use of all cpus
> that this cpuset is allowed to use.

What happens then is that the job manager marks the cpuset of this
newly activated job as being a sched_domain.

And if the job manager doesn't do that, and sets up a situation in
which the scheduler domains don't line up with the active jobs, then
they can't get scheduler load balancing across all the CPUs in those
jobs cpusets.  That's exactly what they asked for -- that's exactly
what they got.

(Actually, is that right?  I thought load balancing would still occur
at higher levels in the sched domain/group hierarchy, just not as
often.)

It is not the kernels job to make it impossible for user code to do
stupid things.  It's the kernels job to offer up various mechanisms,
and let user space code decide what to do when.

And, anyhow, how does this differ from overloading the cpu_exclusive
flag to define sched domains.  One can setup the same thing there,
where a job can't balance across all its CPUs:

	/dev/cpuset/cs1		cpu_exclusive = 1; cpus = 0-7
	/dev/cpuset/cs1/suba	cpu_exclusive = 1; cpus = 0-3
	/dev/cpuset/cs1/subb	cpu_exclusive = 1; cpus = 4-7

(sched_domain_enabled = 0 in all cpusets)

If you put a task in cpuset "cs1" (not in one of the sub cpusets)
then it can't load balance between CPUs 0-3 and CPUs 4-7 (or can't
load balance as often - depending on how this works.)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
