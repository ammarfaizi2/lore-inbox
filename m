Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUJDOEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUJDOEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUJDOEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:04:35 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:52719 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267928AbUJDOE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:04:29 -0400
Message-ID: <416156E8.7060708@watson.ibm.com>
Date: Mon, 04 Oct 2004 09:58:00 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erich Focht <efocht@hpce.nec.com>
CC: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, ckrm-tech@lists.sourceforge.net,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <200410032221.26683.efocht@hpce.nec.com>
In-Reply-To: <200410032221.26683.efocht@hpce.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Erich Focht wrote:


> Can cpusets help me/us/Linux to get closer to these requirements?
> 
> A clear yes. Regard cpusets as a new kind of composite resource built
> from memory and CPUs. They can play the role of the resource groups we
> need. Disjunct cpusets can run jobs which will almost never interfere
> cpu-cycle or memory-wise. This can be easilly integrated into PBS/LSF
> or whatever batch resource manager comes to your mind. Cpusets
> selected with some knowledge of the NUMA characteristics of a machine
> guarantee always reproducible and best compute performance. If a job
> runs alone in a cpuset it will run as if the machine has been reduced
> to that piece and is owned exclusively by the job. Also if the set
> contains as many CPUs as MPI processes, the cpuset helps getting some
> sort of gang scheduling (i.e. all members of a parallel process get
> cycles at the same time, this reduces barrier synchronisation times,
> improves performance and makes it more predictible). This is something
> one absolutely needs on big machines when dealing with time critical
> highest performance applications. Permanently losing 10% because the
> CPU placement is poor or because one has to get some other process out
> of the way is just inacceptable. When you sell machines for several
> millions 10% performance loss translates to quite some amount of
> money.
> 
> Can CKRM (as it is now) fulfil the requirements?
> 
> I don't think so. CKRM gives me to some extent the confidence that I
> will really use the part of the machine for which I paid, say 50%. But
> it doesn't care about the structure of the machine. CKRM tries giving
> a user as much of the machine as possible, at least the amount he paid
> for. For example: When I come in with my job the machine might be
> already running another job who's user also paid for 50% but was the
> only user and got 100% of the machine (say some Java application with
> enough threads...). This job maybe has filled up most of the memory
> and uses all CPUs. CKRM will take care of getting me cycles (maybe
> exclusively on 50% of the CPUs and will treat my job preferrentially
> when allocating memory, but will not care about the placement of the
> CPUs and the memory. Neither will it care whether the previously
> running job is still using my memory blocks and reducing my bandwith
> to them. So I get 50% of the cycles and the memory but these will be
> BAD CYCLES and BAD MEMORY. My job will run slower than possible and a
> second run will be again different. Don't misunderstand me: CKRM in
> its current state is great for different things and running it inside
> a cpuset sounds like a good thing to do.

You forget that CKRM does NOT violate the constraints set forward by 
cpu_allowed masks. So most of your drawbacks described above are simply 
not true.
As such it comes back to the question whether the RCFS
and controller interfaces can be used to set the cpu_allowed masks
in accordance to the current cpuset semantics.
Absolutely we can...

I am certainly not stipulating that cpusets can replace share based 
scheduling or vice versa.

What remains to be discussed is whether
In order to allow CKRM scheduling within a cpuset here are a few 
questions to be answered:
(a) is it a guarantee/property that cpusets at with the same
     parent cpuset do not overlap ?
(b) can we enforce that a certain task class is limited to a cpuset
     and its subsets.

If we agree or disagree then we can work on a proposal for this.

> 
> What about integration with PBS/LSF and alike?
> 
> It makes sense to let an external resource manager (batch or
> non-batch) keep track of and manage cpusets resources. It can allocate
> them and give them to jobs (exclusively) and delete them. That's
> perfect and exactly what we want. CKRM is a resource manager itself
> and has an own idea about resources. Certainly PBS/LSF/etc. could
> create a CKRM class for each job and run it in this class. The
> difficulty is to avoid the resource managers to interfere and work
> against each other. In such a setup I'd rather expect a batch manager
> to be started inside one CKRM class and let it ensure that e.g. the
> interactive class isn't starved by the batch class.
> 
> Can CKRM be extended to do what cpusets do? 

See above, I think it can be. We need to answer (a) and (b) and then 
define what a share means.

> 
> Certainly. Probably easilly. But cpusets will have to be reinvented, I
> guess. Same hooks, same checks, different user interface...
> 

-- Hubertus

