Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUJBXVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUJBXVj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 19:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUJBXVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 19:21:39 -0400
Received: from gizmo06bw.bigpond.com ([144.140.70.41]:47326 "HELO
	gizmo06bw.bigpond.com") by vger.kernel.org with SMTP
	id S267607AbUJBXVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 19:21:35 -0400
Message-ID: <415F37F9.6060002@bigpond.net.au>
Date: Sun, 03 Oct 2004 09:21:29 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: dipankar@in.ibm.com, Paul Jackson <pj@sgi.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, mbligh@aracnet.com, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com>
In-Reply-To: <415ED3E3.6050008@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> OK, let me respond to this (again...) from the perspective of cpus.
> This should to some extend also cover Andrew's request as well as
> Paul's earlier message.
> 
> I see cpumem sets to be orthogonal to CKRM cpu share allocations.
> AGAIN.
> I see cpumem sets to be orthogonal to CKRM cpu share allocations.
> 
> In its essense, "cpumem sets" is a hierarchical mechanism of sucessively 
> tighter constraints on the affinity mask of tasks.
> 
> The O(1) scheduler today does not know about cpumem sets. It operates
> on the level of affinity masks to adhere to the constraints specified 
> based on cpu masks.

This is where I see the need for "CPU sets".  I.e. as a 
replacement/modification to the CPU affinity mechanism basically adding 
an extra level of abstraction to make it easier to use for implementing 
the type of isolation that people seem to want.  I say this because, 
strictly speaking and as you imply, the current affinity mechanism is 
sufficient to provide that isolation BUT it would be a huge pain to 
implement.

The way I see it you just replace the task's affinity mask with a 
pointer to its "CPU set" which contains the affinity mask shared by 
tasks belonging to that set (and this is used by try_to_wake_up() and 
the load balancing mechanism to do their stuff instead of the per task 
affinity mask).  Then when you want to do something like take a CPU away 
from one group of tasks and give it to another group of tasks it's just 
a matter of changing the affinity masks in the sets instead of visiting 
every one of the tasks individually and changing their masks.  There 
should be no need to explicitly move tasks off the "lost" CPU after such 
a change as it should/could be done next time that they go through 
try_to_wake_up() and/or finish a time slice.  Moving a task from one CPU 
set to another would be a similar process to the current change of 
affinity mask.

There would, of course, need to be some restriction on the movement of 
CPUs from one set to another so that you don't end up with an empty set 
with live tasks, etc.

A possible problem is that there may be users whose use of the current 
affinity mechanism would be broken by such a change.  A compile time 
choice between the current mechanism and a set based mechanism would be 
a possible solution.  Of course, this proposed modification wouldn't 
make any sense with less than 3 CPUs.

PS Once CPU sets were implemented like this, configurable CPU schedulers 
(such as (blatant plug :-)) ZAPHOD) could have "per CPU set" 
configurations, CKRM could do its (CPU management stuff) stuff within a 
CPU set, etc.

> 
> The CKRM cpu scheduler also adheres to affinity mask constraints and 
> frankly does not care how they are set.
> 
> So I do not see what at the scheduler level the problem will be.
> If you want system isolation you deploy cpumem sets. If you want overall 
>  share enforcement you choose ckrm classes.
> In addition you can use both with the understanding that cpumem sets can 
> and will not be violated even if that means that shares are not maintained.
> 
> Since you want orthogonality, cpumem sets could be implemented as a
> different "classtype". They would not belong to the taskclass and thus 
> are independent from what we consider the task class.
> 
> 
> 
> The tricky stuff comes in from the fact that CKRM assumes a system wide 
> definition of a class and a system wide "calculation" of shares.

Doesn't sound insurmountable or particularly tricky :-).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
