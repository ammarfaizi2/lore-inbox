Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUJBXrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUJBXrR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 19:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUJBXrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 19:47:17 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:15781 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267614AbUJBXrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 19:47:12 -0400
Message-ID: <415F3D4C.6060907@watson.ibm.com>
Date: Sat, 02 Oct 2004 19:44:12 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: dipankar@in.ibm.com, Paul Jackson <pj@sgi.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, mbligh@aracnet.com, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>
In-Reply-To: <415F37F9.6060002@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are in sync on this... Hopefully, everybody else as well.
> 
> This is where I see the need for "CPU sets".  I.e. as a 
> replacement/modification to the CPU affinity mechanism basically adding 
> an extra level of abstraction to make it easier to use for implementing 
> the type of isolation that people seem to want.  I say this because, 
> strictly speaking and as you imply, the current affinity mechanism is 
> sufficient to provide that isolation BUT it would be a huge pain to 
> implement.

Exactly, you do the movement from cpuset through higher level operations 
replacing the per task cpu-affinity with a shared object.
This is what CKRM does at the core level through its class objects.
RCFS provides the high level operations. The controller implements them
wrt to the constraints and the details.

> 
> The way I see it you just replace the task's affinity mask with a 
> pointer to its "CPU set" which contains the affinity mask shared by 
> tasks belonging to that set (and this is used by try_to_wake_up() and 
> the load balancing mechanism to do their stuff instead of the per task 
> affinity mask).  Then when you want to do something like take a CPU away 
> from one group of tasks and give it to another group of tasks it's just 
> a matter of changing the affinity masks in the sets instead of visiting 
> every one of the tasks individually and changing their masks.  

Exactly ..

> There 
> should be no need to explicitly move tasks off the "lost" CPU after such 
> a change as it should/could be done next time that they go through 
> try_to_wake_up() and/or finish a time slice.  Moving a task from one CPU 
> set to another would be a similar process to the current change of 
> affinity mask.
> 
> There would, of course, need to be some restriction on the movement of 
> CPUs from one set to another so that you don't end up with an empty set 
> with live tasks, etc.
> 
> A possible problem is that there may be users whose use of the current 
> affinity mechanism would be broken by such a change.  A compile time 
> choice between the current mechanism and a set based mechanism would be 
> a possible solution.  Of course, this proposed modification wouldn't 
> make any sense with less than 3 CPUs.

Why ? It is even useful for 2 cpus.
Currently cpumem sets do not enforce that there is not intersections 
between siblings of a hierarchy.

> 
> PS Once CPU sets were implemented like this, configurable CPU schedulers 
> (such as (blatant plug :-)) ZAPHOD) could have "per CPU set" 
> configurations, CKRM could do its (CPU management stuff) stuff within a 
> CPU set, etc.

That's one of the sticking points.
That would require that TASKCLASSES and cpumemsets must go along the 
same hierarchy. With CPUmemsets being the top part of the hierarchy.
In other words the task classes can not span different cpusets.

There are other posibilities that would restrict the load balancing
along cpuset boundaries. If taskclasses are allowed to span disjoint
cpumemsets, what is then the definition of setting shares ?

Today we simply do the system wide share proportionment adhering to the 
affinity constraints, which is still valid in this discussion.

> 

>>
>> The tricky stuff comes in from the fact that CKRM assumes a system 
>> wide definition of a class and a system wide "calculation" of shares.
> 
Tricky in that it needs to be decided what the class hierarchy 
definitions and whether to CKRM cpu scheduling within each cpuset and 
what the exact definition of share then is ?

> 
> Doesn't sound insurmountable or particularly tricky :-).

I agree its not insurmountable but a matter of deciding what the desired
behavior is ...

Regards.



> 
> Peter

