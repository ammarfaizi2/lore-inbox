Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTJATSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTJATSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:18:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24216 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262168AbTJATRy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:17:54 -0400
Date: Wed, 01 Oct 2003 12:19:05 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Minutes from 10/1 LSE Call
Message-ID: <37940000.1065035945@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	LSE Call Minutes from 10/1 

I. Sylvain Jeaugey and Simon Derr: CPUSETS, Controlling CPU placement.

http://marc.theaimsgroup.com/?l=lse-tech&m=106441942222186&w=2

Prcesses attach to cpusets. Made changes to system calls.
new file /proc/cpusets which shows which cpus are in the sets. also
/proc/pid/ info. Only cpus in the current cpuset are available to
the processes attached to the set. Hooks into fork and other system calls.
There are man pages on the web site for all these processes. 
www.opensource.org/cpuset
----
Paul Jackson- q about restriction to certain cpus. ie cpu 3 & 5 in the
set. Does the process see the real numbers or are they renumbered? 

A - They are not renumbered in the /proc info but for the schedsetaffinity
call they are renumbered starting at 0. 

Q- So an application could become confused? 

A- No, the application doesnt need to know those details.

Paul - Sometimes applications do want to know what cpu they are on.
----
Hubertus Franke- Do you do any optimization based on cpu usage? because it
is a virtualization they have the power to assign any cpu at will.

A -Right now we just have a basic view of the machine.  There is some 
awareness of NUMA.

Paul J- I would guess we would put the optimization at a higher layer
than the virtualization layer.

Hubertus-  I think a good idea would be to not have a set mapping but
let the kernel pick the best mapping based on load or some intelligent
entity. That could be an interesting extension to this.

---

Mike Raymond - Can threads within the set leave? 

A- No

Q - Can threads outside the cpuset join?

A- no, unless their cpusets overlap. Every thread is in a cpuset.
no thread can leave their cpuset.

Q - Is there some option ie strict that tells whether or not some
other thread can steal resources or not. 

A - Only threads within the cpuset can use the processor.
The parent is always a superset of the child.

Q- I can imagine we would want the cpus for certain daemons
to be spun up very early.

More difficult to move memory than to reschedule a task.
But that is a bigger topic, not for this call.

====================
II. Mark Gross: Real-Time applications needs when system is stressed. 

http://marc.theaimsgroup.com/?l=lse-tech&m=106494685313136&w=2

Looking at the performance robustness under Linux as the workloads
get heavy. Most this work is being motivated from telco software
venders as they try to use Linux. It works OK until the workload
gets large. At least that is what we keep hearing.

The things we are looking at is to try to isolate the bottlenecks
and create some mircobenchmarks that expose these bottlenecks.
We are also looking into developing tools to identify these
bottlenecks. I believe they are coming from semaphore locks
in the kernel. Would like a tool, such as lockmeter, that
could work with semaphore locks.

We got about 100 mb/sec using the bonie benchmark for block io writes, 
for writes we hit a ceiling around 100-120 mb/sec. Stopped scaling 
after about 3 spindles.

Tried to focus on the block io part of it. Have not tried
direct or raw io yet.  With block IO we got about 133 mb/sec 
doing a simple dd to dev/null from multiple spindles. This
was on the 2.6 test 3.

Jesse Barnes recommends trying direct or raw io. They saw some 
higher numbers. Raw and Odirect avoid the cpu more than block io does.

Block it goes through the buffer cache instead of he page cache.
which only comes out of lowmem which really can restrict you.

Badari Pulavarty, said that is by design and there is no work 
going on to change that to page cache. It is buffer IO, it is 
supposed to go through the cache now. There was some talk but 
nobody cared enough to change it. No one is saying to go through 
block io right now anyway.

Q - Is using direct IO an option for posix apps?

A- not right now. There are a lot of apps.

It is great that direct io kicks ass but we should make sure
file io kicks butt too.

Odirect on large block sizes has low cpu utilization ( 3-5% ).
However with buffered IO we can easily get to 100% cpu utilization. 
If you look at the profile most of that is in the copy_to_user function.

Dave howell- so these apps dont run very well on Linux right
now?

A- Yes.

Q- Did you see any spinlock contention with lockmeter?

A- Not really, there arent many spinlocks with this app.

Mark Gross Q- Is there a Kernprof for 2.6? Andrew Morton
has lockmeter in his tree but not kernprof.

John Hawkes A- No. Will require a different approach in 2.6 than 2.4. 
Could use some help on this.

Badari- going back to the 100% utilization issue with block io.
That is probably caused by low mem problem. It would be good
to change the app to not use block io.

A- It is a whole suite of telco apps that use Posix so that is a 
difficult option.

=======================

III. Steve Pratt: IO performance in mm tree vs mainline.

http://marc.theaimsgroup.com/?l=lse-tech&m=106495069918264&w=2

Got some interesting results comparing IO throughput on the mainline
tree vs the mm tree doing random and sequential reads with different
block sizes. 

With large blcok size  and random reads the (aio readahead speedup patch) 
was giving significant thruput improvements. However, with sequential
reads we saw a 10% overhead in cpu utilization no throuput increase. 
So there are some drawbacks to the readahead patch if doing both random and 
sequential reads.

In mainline, once block size is over 32k our throuput actually drops off.
It levels off around 128k but at a greater cpu utilization.
Dont really understand why that is. 

In mm tree, maintains throughput for all block size but the cpu utilzation
keeps going up to do the same throughput.  Readprofile shows the extra time 
is being spent in copy_to_user (in mm tree). Backing out readahead patch 
reduces cpu by 10% for all block sizes but still shows the spike. So that
isnt the main problem.

Badari - Are you using the serveraid or ips driver? 

A - yes. We are planning on moving to the qlogic driver but need to get 
different disks and get it all set up. But I wouldnt expect that to 
kick in until 128k. So the fact it starts at 32k makes me think that
isnt the issue. So 64k is less than the max throughput.  

Q- What tool are you using for these measurements?

A- It is an internal tool called Raw Read that has been open sourced 
and is available on IBM's open source site. Under developerworks
under Linux Perf. Will get the latest version out soon.

Mark Gross- We saw a similiar performance degredation as we scaled
by spindles.

Steve - I can add spindles no problem, we actually have 80 spindles
in a raid array that looks like 20 spindles.

---

minutes compiled by Hanna Linder 10/01/03


