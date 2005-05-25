Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVEYO0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVEYO0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 10:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVEYO0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 10:26:23 -0400
Received: from soufre.accelance.net ([213.162.48.15]:496 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261444AbVEYO0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 10:26:09 -0400
Message-ID: <42948AFC.5040300@xenomai.org>
Date: Wed, 25 May 2005 16:26:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
Cc: linux-kernel@vger.kernel.org, rpm@xenomai.org
Subject: Re: RT patch acceptance
References: <001701c560a6$cafbe2b0$c800a8c0@mvista.com> <4293AB4D.4030506@opersys.com> <20050524234911.GC17781@nietzsche.lynx.com>
In-Reply-To: <20050524234911.GC17781@nietzsche.lynx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Tue, May 24, 2005 at 06:31:41PM -0400, Karim Yaghmour wrote:
> 
>><repeating-myself>
>>From my POV, it just seems that it's worth asking a basic
>>question: what is the least intrusive modification to the Linux
>>kernel that will allow obtaining hard-rt and what mechanisms
>>can we or can we not build on that modification? Again, my
>>answer to this question doesn't matter, it's the development
>>crowd's collective answer that matters. And in championing
>>the hypervisor/nanokernel path, I could turn out to be horribly
>>wrong. At this stage, though, I'm yet unconvinced of the
>>necessity of anything but the most basic kernel changes (as
>>in using function pointers for the interrupt control path,
>>which could be a CONFIG_ also).
> 
> 
> I know what you're saying and it's kind unaddressed by various
> in this discussion.
> 
> When I think of the advantages of a single over dual image kernel
> system I think of it in terms of how I'm going to implement QoS.
> If I need to get access to a special TCP/IP socket in real time
> with strong determinancy you run into the problem of crossing to
> kernel concurrency domains, one preemptible one not, with a dual
> kernel system and have to use queues or other things to
> communicate with it. Even with lockless structures, you're still
> expressing latency in the Linux kernel personality if you have
> some kind of preexisting app that's already running in an atomic
> critical section holding non-preemptive spinlocks.
> 
> However this is not RTAI as I understand it since it can run N
> number of image for each RT task (correct?)
>

Basically, yes. The RTAI/fusion machinery makes sure that either Linux 
or the RTAI co-scheduler are alternately in control of the RT tasks they 
share, depending on the code they happen to tread on, and use the same 
priority scheme so that you don't end up losing your effective RTAI 
priority just because you happen to issue a regular system call that 
migrates you under the control of the Linux kernel to process it.

It turns out that your worst-case sched latency when using Linux 
services in RT context is mainly defined by the granularity of the Linux 
kernel, since the co-scheduler has very simple synchronization 
constraints, and can be activated at any time by interrupts regardless 
of the current masking state set by the Linux kernel. For the same 
reason, if the task keeps using only RTAI-specific services, then your 
worst-case is always close to the hardware limit.

> Having multipule images helps out, but fails in scenarios where
> you have to have tight data coupling. I have to think about things
> like dcache_lock, route tables, access to various IO system like
> SCSI and TCP/IP, etc...
> 
> A single system image makes access to this direct unlike dual kernel
> system where you need some kind of communication coupling. Resource
> access is direct. Modifying large grained subsystems in the kernel
> is also direct. As preexisting multimedia apps use more RT facilities,
> apps are going to need something more of a general purpose OS to make
> development easiler. These aren't traditional RT apps at all, but
> still require hard RT response times. Keep in mind media apps use
> the screen, X11, audio device(s), IDE/SCSI for streaming, networking,
> etc... It's a comprehensive use of many of the facilities of kernel
> unlike traditional RT apps.

Agreed, not all apps requiring bounded latencies are sampling i/o ports 
on the bare metal at 20Khz, just because there are different levels of 
RT requirements. For this reason, RTAI's fusion track has always been 
meant to leverage and complement the undergoing efforts to improve the 
vanilla kernel wrt overall latency and proper priority enforcement, in 
the current case PREEMPT_RT and its PI implementation. RTAI (all tracks 
included) addresses a small niche of applications which really can't 
take any chance with unexpected latencies when time constraints are 
extreme, underlying hardware has limited capacities, and/or detection of 
3rd party code randomly inducing jittery in a large kernel codebase is 
out of reach. A niche which is being shared with other RTOS and as you 
already pointed out, may even get smaller once Linux latencies 
eventually becomes predictable and bounded within a reasonably low 
micro-sec range, as some people who don't actually need extremely low 
worst-case latencies close to the hardware limits eventually figure out 
that vanilla Linux on full preemption steroids is up to the job.

As said earlier, one of the main goals of the fusion track within the 
RTAI project is about providing a convenient way for the remaining niche 
users to access both worlds seamlessly, so that the covered spectrum of 
applications with varying RT requirements could be broader. In that 
sense, you can bet that we are among the supporters of the PREEMPT_RT 
effort, because it magically solves half of the long-term issues 
involved with having a practical and sound integration between fusion 
and Linux.

> 
> Now, this doesn't necessarily replace RTAI, but a preemptive Linux
> kernel can live as a first-class citizen to RTAI. I've been thinking
> about merging some of the RTAI scheduler stuff into the RT patch.

I did it recently, crafting a combo patch between Adeos (needed by 
fusion) and PREEMPT_RT (0.7.44-03). The results running fusion over this 
combo are encouraging, even if things remain to be ironed.

> uber-preemption Linux doesn't have a sophisticate userspace yet
> and here RTAI clearly wins, no decent RT signal handling, etc...
> There are other problems with it and the current implementation.
> This is going to take time to sort out so RTAI still wins at this
> point.
> 

IMHO, RTAI will eventually achieve one of its major goals when it 
succeeds to smartly and transparently integrate with Linux, while still 
keeping the standard semantics for the RT tasks it manages. At this 
point, using RTAI or not will not be a matter of religion between mere 
Linux or co-kernel zealots, but a decision based on the required level 
of predictability that one may obtain in a particular hw/sw context. 
Hopefully.

> I hope I addressed this properly, but that's the point of view
> I'm coming from.
> 
> bill
> 

-- 

Philippe.
