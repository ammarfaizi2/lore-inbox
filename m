Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUJFCMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUJFCMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 22:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUJFCMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 22:12:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19625 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266885AbUJFCLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 22:11:45 -0400
Date: Tue, 5 Oct 2004 19:08:52 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Simon.Derr@bull.net, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041005190852.7b1fd5b5.pj@sgi.com>
In-Reply-To: <1193270000.1097025361@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	<58780000.1097004886@flay>
	<20041005172808.64d3cc2b.pj@sgi.com>
	<1193270000.1097025361@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin writes:
> I agree with the basic partitioning stuff - and see a need for that. The
> non-exclusive stuff I think is fairly obscure, and unnecessary complexity
> at this point, as 90% of it is covered by CKRM. It's Andrew and Linus's 
> decision, but that's my input.

Now you're trying to marginalize non-exclusive cpusets as a fringe
requirement.  Thanks a bunch ;).

Instead of requiring complete exclusion for all cpusets, and pointing to
the current 'exclusive' flag as the wrong flag at the wrong place at the
wrong time (sorry - my radio is turned to the V.P. debate in the
background) how about let's being clear what sort of exclusion the
schedulers, the allocators and here the resource manager (CKRM) require.

I can envision dividing a machine into a few large, quite separate,
'soft' partitions, where each such partition is represented by a subtree
of the cpuset hierarchy, and where there is no overlap of CPUs, Memory
Nodes or tasks between the 'soft' partitions, even though there is a
possibly richly nested cpuset (cpu and memory affinity) structure within
any given 'soft' partition.

Nothing would cross 'soft' partition boundaries.  So far as CPUs, Memory
Nodes, Tasks and their Affinity, the 'soft' partitions would be
separate, isolated, and non-overlapping.

Each such 'soft' partition could host a separate instance (domain) of
the scheduler, allocator, and resource manager.  Any such domain would
know what set of CPUs, Memory Nodes and Tasks it was managing, and would
have complete and sole control of the scheduling, allocation or resource
sharing of those entities.

But also within a 'soft' partition, there would be finer grain placement,
finer grain CPU and Memory affinity, whether by the current tasks
cpus_allowed and mems_allowed, or by some improved mechanism that the
schedulers, allocators and resource managers could better deal with.

There _has_ to be.  Even if cpusets, sched_setaffinity, mbind, and
set_mempolicy all disappeared tomorrow, you still have the per-cpu
kernel threads that have to be placed to a tighter specification than
the whole of such a 'soft' partition.

Could you or some appropriate CKRM guru please try to tell me what
isolation you actually need for CKRM.  Matthew or Peter please do the
same for the schedulers.

In particular, do you need to prohibit any finer grained placement
within a particular domain, or not.  I believe not.  Is it not the case
that what you really need is that the cpusets that correspond to one of
your domains (my 'soft' partitions, above) be isolated from any other
such 'soft' partition?  Is it not the case that further, finer grained
placement within such an isolated 'soft' partition is acceptable?  Sure
better be.  Indeed, that's pretty much what we have now, with what
amounts to a single domain covering the entire system.

Instead of throwing out half of cpusets on claims that it conflicts
with the requirements of the schedulers, resource managers or (not yet
raised) the allocators, please be more clear as to what the actual
requirements are.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
