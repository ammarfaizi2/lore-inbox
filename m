Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUJGTMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUJGTMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUJGTMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:12:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:17395 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267808AbUJGTJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:09:20 -0400
Message-Id: <200410071905.i97J57TS014336@owlet.beaverton.ibm.com>
To: Paul Jackson <pj@sgi.com>
cc: colpatch@us.ibm.com, mbligh@aracnet.com, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement 
In-reply-to: Your message of "Thu, 07 Oct 2004 07:28:42 PDT."
             <20041007072842.2bafc320.pj@sgi.com> 
Date: Thu, 07 Oct 2004 12:05:07 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > Once you have the exclusive set in your example, wouldn't the existing
    > functionality of CKRM provide you all the functionality the other
    > non-exclusive sets require?
    > 
    > Seems to me, we need a way to *restrict use* of certain resources
    > (exclusive) and a way to *share use* of certain resources (non-exclusive.)
    > CKRM does the latter right now, I believe, but not the former.
    
    
    I'm losing you right at the top here, Rick.  Sorry.

    I'm no CKRM wizard, so tell me if I'm wrong.

    But doesn't CKRM provide a way to control what percentage of the
    compute cycles are available from a pool of cycles?

    And don't cpusets provide a way to control which physical CPUs a
    task can or cannot use?

Right.

And what I'm hearing is that if you're a job running in a set of shared
resources (i.e., non-exclusive) then by definition you are *not* a job
who cares about which processor you run on.  I can't think of a situation
where I'd care about the physical locality, and the proximity of memory
and other nodes, but NOT care that other tasks might steal my cycles.

    For parallel threaded apps with rapid synchronization between the
    threads, as one gets with say OpenMP or MPI, there's a world of
    difference. Giving both threads in a 2-way application of this kind
    50% of the cycles on each of 2 processors can be an order of magnitude
    slower than giving each thread 100% of one processor.  Similarly, the
    variability of runtimes for such threads pinned on distinct processors
    can be an order of magnitude less than for floating threads.

Ah, so you want processor affinity for the tasks, then, not cpusets.

    For shared resource environments where one is purchasing time
    on your own computer, there's also world of difference. In many
    cases one has paid (whether in real money to another company, or in
    inter-departmental funny money - doesn't matter a whole lot here)
    money for certain processor power, and darn well expects those
    processors to sit idle if you don't use them.

One does?  No, in my world, there's constant auditing going on and if
you can get away with having a machine idle, power to ya, but chances
are somebody's going to come and take away at least the cycles and maybe
the whole machine for somebody yammering louder than you about their
budget cuts.  You get first cut, but if you're not using it, you don't
get to sit fat and happy.

    And the vendor (whether your ISP or your MIS department) of these
    resources can't hide the difference. Your work runs faster and with
    dramatically more consistent runtimes if the entire processor/memory
    units are yours, all yours, whether you use them or not.

When I'm not using them, my work doesn't run faster.  It just doesn't run.

    There is a fundamental difference between controlling which physical
    processors on an SMP or NUMA system one may use, and adding delays
    to the tasks of select users to ensure they don't use too much.

    In the experience of SGI, and I hear tell of other companies,
    workload management by fair share techniques (add delays to tasks
    exceeding their allotment) has been found to be dramatically less
    useful to customers,

Less useful than ... what?  As a substitute for exclusive access to
one or more cpus, which currently is not possible?  I can believe that.
But you're saying these companies didn't size their tasks properly to
the cpus they had allocated and yet didn't require exclusivity? How
would non-exclusive sets address this human failing?  You have 30 cpus'
worth of tasks to run on 24 cpus.  Somebody will take a hit, right,
whether CKRM or cpusets are managing those 24 cpus?

    >     * There is no clear policy on how to amiably create an exclusive set.
    >       The main problem is what to do with the tasks already there.

    There is a policy, that works well, and those of us in this
    business have been using for years.  When the system boots,
    you put everything that doesn't need to be pinned elsewhere in
    a bootcpuset, and leave the rest of the system dark.  You then,
    whether by manual administrative techniques or a batch scheduler,
    hand out dedicated sets of CPU and Memory to jobs, which get exclusive
    use of those compute resources (or controlled sharing with only what
    you intentionally let share).

This presumes you know, at boot time, how you want things divided.
All of your examples so far have seemed to indicate that policy changes
may well be made *after* boot time.  So I'll rephrase: any time you
create an exclusive set after boot time, you may find tasks already
running there.  I suggested one policy for dealing with them.

    The difference between cpusets and CKRM is not about restricting
    versus sharing.  Rather cpusets is about controlled allocation of big,
    named chunks of a computer - certain numbered CPUs and Memory Nodes
    allocated by number.  CKRM is about enforcing the rate of usage of
    anonymous, fungible resources such as cpu cycles and memory pages.

    Unfortunately for CKRM, on modern system architectures of two or more
    CPUs, cycles are not interchangeable and fungible, due to the caching.
    On NUMA systems, which is the norm for all vendors above 10 or 20 CPUs
    (due to our inability to make a backplane fast enough to handle more)
    memory pages are not interchangeable and fungible either.

CKRM is not going to merrily move tasks around just because it can,
either, and it will still adhere to common scheduling principles regarding
cache warmth and processor affinity.

You use the example of a two car family, and preferring one over the other.
I'd turn that around and say it's really two exclusive sets of one
car each, rather than a shared set of two cars.  In that example, do you
ask your wife before you take "her" car, or do just take it because it's
a shared resource?  I know how it works in *my* family :)

You've given a convincing argument for the exclusive side of things.
But my point is that on the non-exclusive side the features you claim
to need seem in confict: if the cpu/memory linkage is important to job
predictability, how can you then claim it's ok to share it with anybody,
even a "friendly" task?  If it's ok to share, then you've just thrown
predictability out the window.  The cpu/memory linkage is interesting,
but it won't drive the job performance anymore.

I'm trying to nail down requirements.  I think we've nailed down the
exclusive one.  It's real, and it's currently unmet.  The code you've
written looks to provide a good base upon which to meet that requirement.
On the non-exclusive side, I keep hearing conflicting information
about how layout is important for performance but it's ok to share with
arbitrary jobs -- like sharing won't affect performance?

Rick
