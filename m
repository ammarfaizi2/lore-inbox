Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVBHAAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVBHAAD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVBHAAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:00:03 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:62408 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261344AbVBGX75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 18:59:57 -0500
Message-ID: <420800F5.9070504@us.ibm.com>
Date: Mon, 07 Feb 2005 15:59:49 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Simon.Derr@bull.net,
       Andi Kleen <ak@suse.de>, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>	 <20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]>	 <200408061730.06175.efocht@hpce.nec.com>	<20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>	<20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com>	<20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com>	<415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]>	 <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis>
In-Reply-To: <1097014749.4065.48.camel@arrakis>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> On Sun, 2004-10-03 at 16:53, Martin J. Bligh wrote:
> 
>>>Martin wrote:
>>>
>>>>Matt had proposed having a separate sched_domain tree for each cpuset, which
>>>>made a lot of sense, but seemed harder to do in practice because "exclusive"
>>>>in cpusets doesn't really mean exclusive at all.
>>>
>>>See my comments on this from yesterday on this thread.
>>>
>>>I suspect we don't want a distinct sched_domain for each cpuset, but
>>>rather a sched_domain for each of several entire subtrees of the cpuset
>>>hierarchy, such that every CPU is in exactly one such sched domain, even
>>>though it be in several cpusets in that sched_domain.
>>
>>Mmmm. The fundamental problem I think we ran across (just whilst pondering,
>>not in code) was that some things (eg ... init) are bound to ALL cpus (or
>>no cpus, depending how you word it); i.e. they're created before the cpusets
>>are, and are a member of the grand-top-level-uber-master-thingummy.
>>
>>How do you service such processes? That's what I meant by the exclusive
>>domains aren't really exclusive. 
>>
>>Perhaps Matt can recall the problems better. I really liked his idea, aside
>>from the small problem that it didn't seem to work ;-)
> 
> 
> Well that doesn't seem like a fair statement.  It's potentially true,
> but it's really hard to say without an implementation! ;)
> 
> I think that the idea behind cpusets is really good, essentially
> creating isolated areas of CPUs and memory for tasks to run
> undisturbed.  I feel that the actual implementation, however, is taking
> a wrong approach, because it attempts to use the cpus_allowed mask to
> override the scheduler in the general case.  cpus_allowed, in my
> estimation, is meant to be used as the exception, not the rule.  If we
> wish to change that, we need to make the scheduler more aware of it, so
> it can do the right thing(tm) in the presence of numerous tasks with
> varying cpus_allowed masks.  The other option is to implement cpusets in
> a way that doesn't use cpus_allowed.  That is the option that I am
> pursuing.  
> 
> My idea is to make sched_domains much more flexible and dynamic.  By
> adding locking and reference counting, and simplifying the way in which
> sched_domains are created, linked, unlinked and eventually destroyed we
> can use sched_domains as the implementation of cpusets.  IA64 already
> allows multiple sched_domains trees without a shared top-level domain. 
> My proposal is to make this functionality more generally available. 
> Extending the "isolated domains" concept a little further will buy us
> most (all?) the functionality of "exclusive" cpusets without the need to
> use cpus_allowed at all.
> 
> I've got some code.  I'm in the midst of pushing it forward to rc3-mm2. 
> I'll post an RFC later today or tomorrow when it's cleaned up.
> 
> -Matt

Sorry to reply a long quiet thread, but I've been trading emails with Paul 
Jackson on this subject recently, and I've been unable to convince either him 
or myself that merging CPUSETs and CKRM is as easy as I once believed.  I'm 
still convinced the CPU side is doable, but I haven't managed as much success 
with the memory binding side of CPUSETs.  In light of this, I'd like to remove 
my previous objections to CPUSETs moving forward.  If others still have things 
they want discussed before CPUSETs moves into mainline, that's fine, but it 
seems to me that CPUSETs offer legitimate functionality and that the code has 
certainly "done its time" in -mm to convince me it's stable and usable.

-Matt
