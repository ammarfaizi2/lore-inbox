Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUHJWuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUHJWuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUHJWuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:50:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:19612 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267798AbUHJWrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:47:10 -0400
Message-ID: <41194E49.2000300@watson.ibm.com>
Date: Tue, 10 Aug 2004 18:38:01 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Hubertus Franke <frankeh@watson.ibm.com>, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>	<200408061730.06175.efocht@hpce.nec.com>	<20040806231013.2b6c44df.pj@sgi.com>	<200408071722.36705.efocht@hpce.nec.com>	<41168B97.1010704@watson.ibm.com>	<41179ED1.2000909@watson.ibm.com> <20040810043120.23aaf071.pj@sgi.com>
In-Reply-To: <20040810043120.23aaf071.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

> 
> The more I look, the more convinced I become that these two projects
> are separate, in means and goals, with little interaction and less
> opportunty for either to leverage the other.  Neither project should
> be contingent on the other.

> 
> Warning:
> 	No one should take anything that follows as actually
> 	describing CKRM.  I can find statements on the CKRM web
> 	pages directly contradicting what I state, and I am certain
> 	that I'm somewhat to substantially confused.  I'll just go
> 	ahead and boldly describe CKRM as I currently understand it,
> 	in the hopes that someone knowledgeable in the project will
> 	thus more easily see my errors and offer corrections.

> 
> Here is my current understanding of cpusets and CKRM, and how they
> differ.
> 
> Cpusets - Static Isolation:
> 
>     The essential purpose of cpusets is to support isolating large,
>     long-running, multinode compute bound HPC (high performance
>     computing) applications or relatively independent service jobs,
>     on dedicated sets of processor and memory nodes.

CKRM's overall objective is to isolate the performance of a group of 
kernel objects from other groups. The grouping can be static 
(applications, users, etc.) or dynamic (processes of the same app can 
change membership from one group to another).

The group of objects is what we call a class.

The apparent dichotomy between what you describe and what we manage is 
resolved when you consider that all applications/users etc. finally boil 
down to some set of tasks making resource demands of cpu, mem, io etc.

Basically we have a flexible way of defining a group of tasks - what 
that group maps to in user space doesn't matter inside the kernel when
resource allocations are being done.

>     
>     The (unobtainable) ideal of cpusets is to provide perfect
>     isolation, for such jobs as:
> 
>      1) Massive compute jobs that might run hours or days, on dozens
> 	or hundreds of processors, consuming gigabytes or terabytes
> 	of main memory.  These jobs are often highly parallel, and
> 	carefully sized and placed to obtain maximum performance
> 	on NUMA hardware, where memory placement and bandwidth is
> 	critical.
> 
>      2) Independent services for which dedicated compute resources
>         have been purchased or allocated, in units of one or more
> 	CPUs and Memory Nodes, such as a web server and a DBMS
> 	sharing a large system, but staying out of each others way.
> 
>     The essential new construct of cpusets is the set of dedicated
>     compute resources - some processors and memory.  These sets have
>     names, permissions, an exclusion property, and can be subdivided
>     into subsets.

The only difference between CKRM and cpusets in the paragraphs above is 
that cpusets tries to achieve the isolation by a static partitioning of 
physical cpus and mem nodes. CKRM does so in terms of cpu time and 
memory pages.

> 
>     The cpuset file system models a hierarchy of 'virtual computers',
>     which hierarchy will be deeper on larger systems.
> 
>     The average lifespan of a cpuset used for (1) above is probably
>     between hours and days, based on the job lifespan, though a couple
>     of system cpusets will remain in place as long as the system is
>     running.  The cpusets in (2) above might have a longer lifespan;
>     you'd have to ask Simon Derr of Bull about that.

CKRM class lifespans depend on how the classes are defined by the 
sysadmin or delegated users. Classes representing users will last as 
long as the system is up, those representing a particular application 
will last as long as the app (typically - CKRM doesn't autodelete 
classes - the user who created it needs to do it himself).

> 
> CKRM - Dynamic Sharing:
> 
>     My current, probably confused, understanding is that the purpose
>     of CKRM is to enable managing different Qualities of Service, or
>     "Classes" (*) on streams of transactions, queries, jobs, tasks that
>     are sharing the same compute resources. 

It would be easier to think of classes as a grouping of tasks and 
sockets which, as an aggregate, have some share of each resource managed 
by CKRM. A class is not characterized by the QoS level, but the objects 
it groups. In particular, two classes can have the same QoS level (e.g. 
20% of total cpu time) and the same class can have its QoS level changed 
(from 20% to say 40%).

> Even if there is some
>     big honking service process such as an enterprise DBMS running,
>     the point of CKRM is not focused on optimizing the overall
>     performance of that job, but rather on distinguishing between
>     various transactions flowing through the system, determining the
>     quality of service (Class) allowed for each, measuring critical
>     resource usage for each Class, and biasing resource allocation
>     decisions, such as in the scheduler and allocator, to obtain the
>     desired balance of resource usage between Classes, or the desired
>     response time to particular favored Classes.

Managing the QoS of transactions (which tend to cross task/application 
boundaries) is a complicated use of CKRM which tries to exploit its 
support for flexible and dynamic grouping. Doing this requires some 
degree of application cooperation (it is only the app which can tell 
what transaction it is processing).

However transaction QoS management is not what CKRM, the kernel project, 
is doing. Its most commonly expected usage is to isolate the performance 
of one application from another or one user from another. Doing this is 
far easier than transactions since apps and users map to tasks/sockets
in easily understood ways that do not require any cooperation from the 
app/user (indeed we don't want any "cooperation" or "interference" from 
them !)

> 
>     This is certainly a more challenging objective than cpusets,
>     in that it requires (1) tracking resource usage (cpu cycles,
>     memory pages, i/o bandwidth) by Class, (2) assigning a Class to
>     transactions moving through the system, and imputing that Class to
>     the tasks handling each transaction, and (3) dynamically biasing
>     scheduling and allocation decisions so as to affect the desired
>     Quality of Service policies.

Correct, CKRM does have more work to do than cpusets does, since it 
controls more fine-grained resources than cpusets (cpu time vs cpus, mem 
pages vs. nodes).

However, it does get a lot of help from the system and does not have to 
carry the burden of 1) and 3) all by itself. 1) only requires existing 
resource usage data (cpu time consumed by a process) to be aggregated, 
additionally, into class statistics. 3) too can be done as an increment 
over existing schedulers, not a replacement. In case of the CPU, it 
means picking the next class to run and then choosing the next task to 
run. In mem, it means preferentially picking pages from an "over share" 
class to swap out etc.

>     
>     The essential new construct of CKRM is the Class - a Quality
>     of Service level.

As said above, this is not the right way to think of a class. Think 
groupings ! The Quality of Service level is an attribute of a class,
not its defining characteristic.

>  Metrics, transactions, tasks, and resource
>     decisions all have to be tracked or managed by Class.
> 
>     These Classes form a fairly shallow hierarchy of usage levels or
>     service qualities, as perceived by the end users of the system.
> 
>     I'd guess that the average lifetime of a Class is months or years,
>     as they can reflect the relative priority of relations with long
>     standing, external customers.
> 
> Cpusets and CKRM have profoundly different purposes, economics and
> motivations.

I would say the methods differ, not the purpose. Both are trying to 
performance-isolate groups of tasks - one uses the spatial dimension of 
cpu bindings, the other uses  the temporal dimension of cpu time.

> 
> For one thing, the cpuset hierarchy and the class hierarchy are two
> different things.  One provides semi-static collections of compute
> resources, which I sometimes call virtual computers or soft partitions.
> The other reflects the differing qualities of service which you find
> it worth providing the originators of transactions into your system.
> These have about as much to do with each other as the "Program Files"
> on my sons game machine has to do with Linus' home directory.  Yup -
> they're both representable in file system trees ;).

Again, I would disagree. The filesytem hierarchies of cpusets and CKRM 
have quite a few things in common.
- directories representing the grouping of tasks
- hierarchical subdivision aka a child can only subdivide what its 
parent has. In CKRM, only the % share that a parent gets from the system 
is further divisible amongst child classes. In cpusets, that resource 
happens to be the set of cpus_allowed.
- delegation of control through file permissions : both allow non-root 
users to control their resource allocations.
- binding of tasks to a group by writing pids to a special virtual file


> 
> I see no value other than obfuscation to attempting to represent
> either hierarchy in terms of the other.

Notwithstanding the similarities between the hierarchies listed above, 
this danger of obfuscation is a possibility. The reason for that is that 
our interface within the filesystem, as defined by the virtual files and 
the attributes within them that one can read and write, do not map 
cleanly onto the ones exported by cpusets.

e.g. the notions of stats, lower and upper bounds for shares that CKRM 
needs, are not relevant to cpusets. On the other hand, we do allow 
attributes that are controller-specific to be represented within some 
virtual files and cpusets could use that.

The other point of difference is the one you'd brought up earlier - ther 
restrictions on the hierarchy creation. CKRM has none (effectively), 
cpusets has many.

As CKRM's interface stands today, there are sufficient differences 
between the interfaces to keep them separate.

However, if CKRM moves to a model where
- each controller is allowed to define its own virtual files and attributes
- each controllers has its own hierarchy (and hence more control over 
how it can be formed),
then the similarities will be too many to ignore merger possibilities
altogether.

The kicker is, we've not decided. The splitting of controllers into 
their own hierarchy is something we're considering independently (as a 
consequence of Linus' suggestion at KS04). But making the interface 
completely per-controller is something we can do, without too much 
effort, IF there is sufficient reason (we have other reasons for doing 
that as well - see recent postings on ckrm-tech).

Interest/recommendations from the community that cpusets  be part of 
CKRM's hierarchy would certainly be a factor in that decision.



> 
> For another way to put the difference, CKRM is managing "commodity"
> resources, such as cycles and bits.  One cycle is as good as the
> next; it's just a question of who gets how many.  On the other hand,
> cpusets manage precious named resources - such as an entire block
> of 64 CPUs and associated memory on a 256 CPU system.  

> Each such
> cpuset is a unique, named, first class, relatively long lasting
> entity represented by its own directory in the cpuset file system,
> and assigned a specific well known job to execute.

s/cpuset/class and s/cpuset file system/rcfs and this pretty much
describes CKRM.

> 
> So what interaction or relationship if any do I see between cpusets
> and CKRM?  Only one at the moment.  A major job running within a
> long lasting cpuset might well want to make use of CKRM in order to
> provide refined Qualities of Service to its clients.  This means that
> the CKRM instance would need to understand that it's not managing
> the entire physical system, but just some cpuset-defined subset.

This brings up a very important point. If CKRM's cpu controller is 
managing cpu time and cpusets are also operational, it might be hard for 
one or the other to achieve their objectives since they're both trying 
to constrain CPU usage along different dimensions.

But in a sense, CKRM already faces this problem since cpu, mem and io 
are not completely independent resources. We're pretty much relying on 
the sysadmin/user not to set wildly conflicting sets of shares for these 
resources and can have the same expectation from someone trying to use 
both CKRM cpu controller and cpusets at the same time.

> 
> A few days ago, one of the CKRM gurus encouraged me to look forward
> to providing a CKRM controller for cpusets.  At the time, I nodded
> knowingly at my screen, as if that all made sense.
> 
> Now, I've no clue what such a controller would be or do, or why anyone
> would want one.

Such a controller would be a different packaging of the cpusets patch 
with most of its internals remaining the same but using the CKRM 
interfaces, as Erich had pointed out.


> I look forward to having my likely serious confusions over CKRM
> corrected.  Meanwhile, I remain convinced that cpusets and CKRM are
> separate and distinct projects, and that neither should wait for
> the other.

On the non-technical front, this is desirable. Tying two projects 
together always runs the risk that one drags the other down. CKRM also 
faces this dilemma while considering a switch from using relayfs to 
netlink as the kernel-user communication channel. We think relayfs suits 
our needs better but given the problems the project has, can't afford to 
tie ourselves down to it.

Broadly, CKRM is not just a collection of controllers which operate on 
arbitrary groups of kernel objects, but also a framework for such 
controllers. In its latter role, it has a place for cpusets.

However, cpusets has little need for CKRM except for the commonalities 
in the interfaces and that too, if and when CKRM adopts the changes 
needed by cpusets.

So the bottomline, IMHO, is the interface - should there be one or two ? 
One can argue either way. There are already so many filesystems, whats 
one more ? CKRM doesn't encompass other "grouping" resource controllers 
such as outbound network (yet!) so why try to shoehorn cpusets into it ?

On the other hand, the user may appreciate one-stop-shops for similar 
kinds of resource management and would probably benefit from an 
integration of interfaces. And there is a merit to the argument that 
interfaces, once adopted in the mainline, will be hard to change.

Rusty's keynote at OLS2003 advised "work on the interfaces last". 
Evidently that advice isn't operative here ! Future incompatibility of 
interfaces is becoming a blocking factor for acceptance/testing/usage of 
the core functionality.

One suggestion is to go ahead with the  -mm acceptance of cpusets so its 
functionality has a chance to get feedback and address the CKRM 
interface integration a couple of months from now once CKRM's interface 
issues get resolved ? But do let us know if there is interest in merging 
(after this round of clarificatory emails is over) as it will affect 
which way we go.


-- Shailabh










> 
> I continue to recommend that cpusets be accepted into the 2.6.9 mm
> patches, and if that goes well, into Linus' tree.
> 
> Thank-you for reading.
> 
>     (*) The above description of a Class as a Quality of Service
>         does _not_ match the phrase on http://ckrm.sourcefourge.net:
> 	    "A class is a group of Linux tasks (processes), ..."
> 	I'm speculating that this phrase is misleading.  More
> 	likely, it's just that I'm confused ;).
> 
> 

