Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268356AbUJFNcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268356AbUJFNcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269091AbUJFNcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:32:09 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:58023 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268356AbUJFNb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:31:26 -0400
Date: Wed, 6 Oct 2004 06:27:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: colpatch@us.ibm.com, mbligh@aracnet.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041006062730.721c1767.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0410061114470.19964@openx3.frec.bull.fr>
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
	<1097014749.4065.48.camel@arrakis>
	<20041005194702.0644070b.pj@sgi.com>
	<Pine.LNX.4.61.0410061114470.19964@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon wrote:
> Just to make sure we speak the same language:

Approximately.  We already have two cpuset properties of cpus_exclusive
and mems_exclusive, which if set, assure that cpus and mems respectively
don't overlap with siblings or cousins.

I am imagining adding one more cpuset property: isolated.

Just what it would guarantee if set isn't clear yet: it would have to
provide whatever we agreed the scheduler, allocator and resource manager
folks needed in order to sanely support a separate domain in that
isolated cpuset.  I'm currently expecting this to be something along the
lines of the following:
  a. mems_exclusive == 1
  b. cpus_exclusive == 1
  c. no isolated ancestor or descendent
  d. no task attached to any ancestor that is not either entirely within,
       or entirely without, both the cpus and mems of the isolated cpuset.

Attempts later on to change the cpus or mems allowed of any task so as
to create a violation of [d.] would fail.  As would any other action
that would violate the above.

I'm still unsure of just what is needed.  I'm beginning to suspect that
there is a reasonable meeting point with the scheduler folks, but that
the CKRM folks may want something constructed from unobtainium.  The
allocator folks are easy so far, as they haven't formed an organized
resistance ;).

There would be five flavors of cpusets.  The four flavors obtained by
each combination of cpus_exclusive 0 or 1, and mems_exclusive 0 or 1,
but with isolated == 0.  And the fifth flavor, with each of the
exclusive flags set 1, plus the isolated flag set 1.

The root node would start out isolated, but the first time you went to
mark a direct child of it isolated, if that effort succeeded, then the
root would lose its isolation (isolated goes to '0'), in accordance with
property [c.]  You would have to be using a bootcpuset for this to have
any chance of working, with all the tasks having cpus_allowed ==
CPU_MASK_ALL, or mems_allowed == NODE_MASK_ALL, already confined to the
bootcpuset.  The top level default scheduler, allocator and resource
manager would have to be able to work in a domain that was not isolated
and with some of its tasks, cpus and memory perhaps being managed by a
scheduler, allocator and/or resource manager in an isolated subordinate
domain.


> 'isolated' cpusets should probably be at the same level as the top cpuset 
> (who should lose this name, then).

I don't think so.  The top remains the one and only, all encompassing, top.


> Or should 'isolated' cpusets stay inside the top cpuset, that whould have 
> to schedule its processes outside the 'isolated' cpusets 

Yes - isolated cpusets stay beneath the top cpuset.  Any given task in
the top cpuset would lie either entirely within, or without, of any
isolated descendent.  If within and if that isolated descendent has a
scheduler, it owns the scheduling of that task.  Similarly for the
allocator and resource manager.


> Should it then 
> be forbidden to cover the whole system with 'isolated' cpusets ?

No need for this that I am aware of, yet anyway.


> That's a lot of question marks...

Yes - lots of question marks.

But the basic objectives are not too much up to question at this point:
 1) An isolated cpuset must not overlap any other isolated cpuset, not in
    mems, not in cpus, and (the tricky part) not in the affinity masks (or
    whatever becomes of cpus_allowed and mems_allowed) of any task in the
    system.
 2) For any cpus_allowed or mems_allowed of any task or cpuset in the
    entire system, it is either entirely contained within some isolated
    cpuset, or entirely outside all of them.
 3) Necessarily from the above, the isolated cpusets form a partial,
    non-overlapping covering of the entire systems cpus, memory nodes,
    and (via the per-task affinity bitmaps) tasks.

The final result being that for any scheduler, allocator or resource
manager:
 * it knows exactly what is its domain of cpus, memory nodes or tasks
 * it is the sole and exclusive owner of all in its domain, and 
 * it has no bearing on anything outside its domain.

It may well be that task->cpus_allowed and task->mems_allowed remain as
they are now, but that for major top level 'soft' partitionings of the system,
we use these isolated cpusets, and attach additional properties friendly to
the needs of schedulers, allocators and resource managers to such isolated
cpusets.  This would put the *_allowed bitmaps back closer to being what they
should be - small scale exceptions rather than large scale abuses.

An isolated cpuset might well not have its own dedicated domains for
all three of schedulers, allocators and resource managers.  It might
have say just its own scheduler, but continue to rely on the global
allocator and resource manager.

===

First however - I am still eager to hear what the CKRM folks think of
set_affinity, mbind and set_mempolicy, as well as what they think of the
current existing per-cpu kernel threads.  It would seem that, regardless
of their take on cpusets, the CKRM folks might not be too happy with any
of these other means of setting the *_allowed bitmaps to anything other
than CPU_MASK_ALL.  My best guess from what I've seen so far is that
they are trying to ignore these other issues with varied *_allowed
bitmap settings as being 'beneath the radar', but trying to use the same
issues to transform cpusets into being pretty much _only_ the flat space
of isolated cpusets from above, minus its hierarchical nesting and
non-exclusive options.

And in any case, I've yet to see that OpenMP and MPI jobs, with their
tight threading, fit well in the CKRM-world.  Such jobs require to have
each thread on a separate CPU, or their performance sucks big time. They
can share CPUs and Nodes with other work and not suffer _too_ bad
(especially if something like gang scheduling is available), but they
must be placed one thread per distinct CPU.  This is absolutely a
placement matter, not a fair share percentage of overall resources
matter.  From all I can see, the CKRM folks just wish such jobs would go
away, or at least they wish that the main Linux kernel would accept a
CKRM patch that is inhospitable to such jobs.

My hope is that CKRM, like the schedulers, is tolerant of smaller scale
exceptions to the allowed placement.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
