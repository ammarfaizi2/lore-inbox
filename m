Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUHJLeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUHJLeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUHJLeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:34:22 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19630 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264371AbUHJLeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:34:14 -0400
Date: Tue, 10 Aug 2004 04:31:20 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: nagar@watson.ibm.com, efocht@hpce.nec.com, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20040810043120.23aaf071.pj@sgi.com>
In-Reply-To: <41179ED1.2000909@watson.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<200408071722.36705.efocht@hpce.nec.com>
	<41168B97.1010704@watson.ibm.com>
	<41179ED1.2000909@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been puzzling over the relationship of cpusets and CKRM the last
few days, unable to understand how they relate, or how either could
make much use of the other.

Others have noticed they both have a hierarchy, and are both concerned
with managing resources in some sense.  Hence more than one person has
suspected opportunities for closer integration of the two projects,
indeed, hoped for such opportunities, given that neither code base
has a reputation for being small.  Though, to be fair to CKRM, they
have substantial more code invested.  Outside of the cpusets.txt file
in Documentation, the cpuset patch is under 2000 lines involving 13
files, whereas a quick count of the June 2004 e13 ckrm and related
cpu patches shows over 15,000 lines involving 62 files.

Someone has suggested that we shouldn't accept the particular names
and directory structure of cpusets into the kernel until we understand
how this interacts with CKRM, because things like this are hard to
change once put in use, and CKRM might impose or at least recommend
different names or such.

The more I look, the more convinced I become that these two projects
are separate, in means and goals, with little interaction and less
opportunty for either to leverage the other.  Neither project should
be contingent on the other.

Warning:
	No one should take anything that follows as actually
	describing CKRM.  I can find statements on the CKRM web
	pages directly contradicting what I state, and I am certain
	that I'm somewhat to substantially confused.  I'll just go
	ahead and boldly describe CKRM as I currently understand it,
	in the hopes that someone knowledgeable in the project will
	thus more easily see my errors and offer corrections.

Here is my current understanding of cpusets and CKRM, and how they
differ.

Cpusets - Static Isolation:

    The essential purpose of cpusets is to support isolating large,
    long-running, multinode compute bound HPC (high performance
    computing) applications or relatively independent service jobs,
    on dedicated sets of processor and memory nodes.
    
    The (unobtainable) ideal of cpusets is to provide perfect
    isolation, for such jobs as:

     1) Massive compute jobs that might run hours or days, on dozens
	or hundreds of processors, consuming gigabytes or terabytes
	of main memory.  These jobs are often highly parallel, and
	carefully sized and placed to obtain maximum performance
	on NUMA hardware, where memory placement and bandwidth is
	critical.

     2) Independent services for which dedicated compute resources
        have been purchased or allocated, in units of one or more
	CPUs and Memory Nodes, such as a web server and a DBMS
	sharing a large system, but staying out of each others way.

    The essential new construct of cpusets is the set of dedicated
    compute resources - some processors and memory.  These sets have
    names, permissions, an exclusion property, and can be subdivided
    into subsets.

    The cpuset file system models a hierarchy of 'virtual computers',
    which hierarchy will be deeper on larger systems.

    The average lifespan of a cpuset used for (1) above is probably
    between hours and days, based on the job lifespan, though a couple
    of system cpusets will remain in place as long as the system is
    running.  The cpusets in (2) above might have a longer lifespan;
    you'd have to ask Simon Derr of Bull about that.

CKRM - Dynamic Sharing:

    My current, probably confused, understanding is that the purpose
    of CKRM is to enable managing different Qualities of Service, or
    "Classes" (*) on streams of transactions, queries, jobs, tasks that
    are sharing the same compute resources.  Even if there is some
    big honking service process such as an enterprise DBMS running,
    the point of CKRM is not focused on optimizing the overall
    performance of that job, but rather on distinguishing between
    various transactions flowing through the system, determining the
    quality of service (Class) allowed for each, measuring critical
    resource usage for each Class, and biasing resource allocation
    decisions, such as in the scheduler and allocator, to obtain the
    desired balance of resource usage between Classes, or the desired
    response time to particular favored Classes.

    This is certainly a more challenging objective than cpusets,
    in that it requires (1) tracking resource usage (cpu cycles,
    memory pages, i/o bandwidth) by Class, (2) assigning a Class to
    transactions moving through the system, and imputing that Class to
    the tasks handling each transaction, and (3) dynamically biasing
    scheduling and allocation decisions so as to affect the desired
    Quality of Service policies.
    
    The essential new construct of CKRM is the Class - a Quality
    of Service level.  Metrics, transactions, tasks, and resource
    decisions all have to be tracked or managed by Class.

    These Classes form a fairly shallow hierarchy of usage levels or
    service qualities, as perceived by the end users of the system.

    I'd guess that the average lifetime of a Class is months or years,
    as they can reflect the relative priority of relations with long
    standing, external customers.

Cpusets and CKRM have profoundly different purposes, economics and
motivations.

For one thing, the cpuset hierarchy and the class hierarchy are two
different things.  One provides semi-static collections of compute
resources, which I sometimes call virtual computers or soft partitions.
The other reflects the differing qualities of service which you find
it worth providing the originators of transactions into your system.
These have about as much to do with each other as the "Program Files"
on my sons game machine has to do with Linus' home directory.  Yup -
they're both representable in file system trees ;).

I see no value other than obfuscation to attempting to represent
either hierarchy in terms of the other.

One of the valuable parts of my cpuset proposal is that the cpuset
file system reflects the allocation of cpu and memory nodes to
cpusets in a visible and obvious fashion, and thanks to the Linux
vfs infrastructure, provides the customary file system hierarchy and
permission model with little additional cpuset code.  Cpusets have
user (administrator) provided pathnames, in a file system hierarchy,
with the usual and expected vfs support.  And the filenames (mems,
cpus, tasks, ...)  within each cpuset directory have a relevance that
should be preserved.  I don't see any value that the CKRM hierarchy
mechanisms, naming or semantics bring to that.

For another way to put the difference, CKRM is managing "commodity"
resources, such as cycles and bits.  One cycle is as good as the
next; it's just a question of who gets how many.  On the other hand,
cpusets manage precious named resources - such as an entire block
of 64 CPUs and associated memory on a 256 CPU system.  Each such
cpuset is a unique, named, first class, relatively long lasting
entity represented by its own directory in the cpuset file system,
and assigned a specific well known job to execute.

So what interaction or relationship if any do I see between cpusets
and CKRM?  Only one at the moment.  A major job running within a
long lasting cpuset might well want to make use of CKRM in order to
provide refined Qualities of Service to its clients.  This means that
the CKRM instance would need to understand that it's not managing
the entire physical system, but just some cpuset-defined subset.

A few days ago, one of the CKRM gurus encouraged me to look forward
to providing a CKRM controller for cpusets.  At the time, I nodded
knowingly at my screen, as if that all made sense.

Now, I've no clue what such a controller would be or do, or why anyone
would want one.

I look forward to having my likely serious confusions over CKRM
corrected.  Meanwhile, I remain convinced that cpusets and CKRM are
separate and distinct projects, and that neither should wait for
the other.

I continue to recommend that cpusets be accepted into the 2.6.9 mm
patches, and if that goes well, into Linus' tree.

Thank-you for reading.

    (*) The above description of a Class as a Quality of Service
        does _not_ match the phrase on http://ckrm.sourcefourge.net:
	    "A class is a group of Linux tasks (processes), ..."
	I'm speculating that this phrase is misleading.  More
	likely, it's just that I'm confused ;).


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
