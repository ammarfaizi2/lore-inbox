Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUHFCIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUHFCIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268063AbUHFCIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:08:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58552 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266138AbUHFCGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:06:50 -0400
Date: Thu, 5 Aug 2004 19:05:00 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: akpm@osdl.org, hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de,
       lse-tech@lists.sourceforge.net, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20040805190500.3c8fb361.pj@sgi.com>
In-Reply-To: <256150000.1091739330@flay>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805101038.3740.52850.89920@sam.engr.sgi.com>
	<256150000.1091739330@flay>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> I'm not sure I understand the rationale behind this ...

Thank-you for your question, Martin.

Unlike the first patch in this set (the fancier bitmap format),
this cpuset patch is important to us, as you likely suspected.

I hope I can do it justice.

> is the point to add back virtualized memory and 
> CPU numbering sets specific to each process or group of them,
> a la cpumemsets thing you were posting a year or two ago?

To answer the easy question first, no.  No virtual numbering anymore. We
might do some virtualizing in user library code, but so far as this
patch and the kernel are aware, cpu number 17 is cpu number 17, all the
time, using the same cpu and node numberings as used in the other kernel
API's (setaffinity, mbind and set_mempolicy) and in the kernel cpumasks
and nodemasks.

The bulk of this patch comes from providing named, nested placement (cpu
and memory) regions -- cpusets, with a file system style namespace and
permission model.

The need for supporting such a model comes in managing large systems,
when they are divided and subdivided into subsets of cpu and memory
resources, dedicated to departments, groups, jobs, threads.  Especially
on NUMA systems, maintaining processor-memory locality is important.
This locality must be maintained in a hierarchical fashion.

The VP of Information Systems is not going to be personally placing the
8 parallel threads of the weather simulator run by someone in one of his
departments.  He can agree that that department gets exclusive use of
half of the machine over the weekends, because that's what they budgeted
for.  Then it gets pushed down.

Imagine, say, a large system that is shared by several departments, with
shifting resources between them.  At any point in time, each department
has certain dedicated resources (cpu and memory) allocated to them. 
Within a department, they may be runing multiple large applications - a
database server, a web server, a big simulation, other large HPC apps. 
Some of these may be very performance critical, and require their own
dedicated resources.  In many cases, the customer will be running some
form of batch manager software to help administer the work load.

The result is a hierarchy of these regions, which require, I claim, a
kernel supported hierarchical name space, with permissions, to which
tasks are attached, and which own subsets of the systems cpu and memory.

On most _any_ numa systems running a mixed and shifting load, this
ability to manage the systems use, to control placement and minimize
interaction, is essential to stable, repeatable performance.  On smaller
or dedicated use systems, the existing calls are entirely sufficient. 
On larger, nested use systems, the critical numa resources of processor
and memory need to be managed in a nested fashion.

The existing cpu and memory placement facilities, added in 2.6,
set_schedaffinity (for cpus) and mbind/set_mempolicy (for memory) are
just the right thing for an individual task to manage in detail its
placement across the resources available to it (the online cpus and
nodes if CONFIG_CPUSET is disabled, or within the cpuset if cpusets
are enabled).

But they do not provide the named hierarchy with kernel enforced
permissions and resource support required to sanely manage the
largest multi-use systems.

Three additional ways to approach this patch:

 1) The first file in the patch, Documentation/cpusets.txt,
    describes this facility, and its purpose.

 2) Look at the hooks in the rest of the kernel.  I have spent much
    time minimizing these hooks, so that they are few in number,
    placed as best I could in low maintenace code in the kernel,
    and vanish if CONFIG_CPUSETS is disabled.  But in addition
    to evaluating the risk and impact of the hooks, you can get
    a further sense of how cpusets works from these hooks.
    These hooks are listed in Documentation/cpusets.txt.

 3) Look at the include/linux/cpusets.h header file.  It shows
    the tiny interface with the rest of the kernel, which
    pretty much evaporates if CONFIG_CPUSET is disabled.

By way of analogy, when I had an 8 inch floppy disk drive, I didn't need
much of a file system.  Initially, didn't even need subdirectories, just
a list of files.  But as storage grew, and became a shared resource on
corporate systems, a hierarchical file system, with names, permissions
and sufficient hooks for managing the storage resource, became
essential.

Now, as big iron is growing from tens, to hundreds, soon to thousands,
of processors and memory nodes, their users require a manageable
resource hierarchy of the essential compute resources.

I understand that it is the proper job of a kernel to present the
essential resources of a system to user code, in a sensibly named and
controlled fashion, without imposing policy.  For nested resources, a
file system is a good fit, both for the names, and the associated
permission model.  It took more code (ifdef'd CONFIG_CPUSET, almost
entirely in the kernel/cpuset.c file), doing it this way.  But it is
the natural model to use, when it fits, as in this case.

Certainly, for the class of customer that SGI has on its big Irix
systems, we have already seen that this sort of facility is essential
for certain customer sites.  I hesitate to say "Irix" here, because
the Irix kernel code is another world, not directly useful in Linux.

Fortunately, Simon and Sylvain of Bull (France) detemined, sometime last
year, that they had the same large system cpu/memory management needs,
and Simon wrote this initial kernel code, entirely untainted with Irix
experience so far as I know.  Their focus is apparently more commercial
systems, whereas SGI's focus is more HPC apps.  But the facilities
needed are the same.

My primary contribution has been in removing code, and doing what I
could to learn how to best adapt it to Linux, in a way that meets our
needs, with the most minimal of impact on others (~zero runtime if not
configured, very low maintenance load on the kernel source).  As Simon
and Sylvain can atest, I have thrown away alot of the code and features
they wanted, in order to reduce the kernel footprint.  The cpu and node
renumbering you remembered was one of the things I threw out.  And I
have rewritten much more code, as I have learned the coding style that
is most comfortable within the Linux kernel.  The long term health and
maintainability of the Linux kernel is important to myself and my
employer.

If there is further explanation I can provide, or if there is design or
code change you see that is important to including cpusets in the
kernel, I welcome your input.  Or nits and details, whatever.  For me,
SGI, and Bull, this one is a biggie.  I anticipate for others as well,
as more companies venture into big iron Linux.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
