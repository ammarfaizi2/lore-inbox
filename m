Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUJBQ0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUJBQ0J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUJBQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:25:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:21381 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267314AbUJBQX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:23:57 -0400
Message-ID: <415ED4A4.1090001@watson.ibm.com>
Date: Sat, 02 Oct 2004 12:17:40 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
CC: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       ckrm-tech@lists.sourceforge.net, pj@sgi.com, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, Larry Peterson <llp@CS.Princeton.EDU>
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>
In-Reply-To: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc E. Fiuczynski wrote:

> Paul & Andrew,
> 
> For PlanetLab (www.planet-lab.org) we also care very much about isolation
> between different users.  Maybe not to the same degree as your users.
> Nonetheless, penning in resource hogs is very important to us.  We are
> giving CKRM a shot.  Over the past two weeks I have worked with Hubertus,
> Chandra, and Shailabh to iron various bugs.  The controllers appear to be
> working at first approximation.  From our perspective, it is not so much the
> specific resource controllers but the CKRM framework that is of importance.
> I.e., we certainly plan to test and implement other resource controllers for
> CPU, disk I/o and memory isolation.
> 
> For cpu isolation, would it suffice to use a HTB-based cpu scheduler.  This
> is essentially what the XEN folks are using to ensure strong isolation
> between separate Xen domains.  An implementation of such a scheduler exists
> as part of the linux-vserver project and the port of that to CKRM should be
> straightforward.  In fact, I am thinking of doing such a port for PlanetLab
> just to have an alternative to the existing CKRM cpu controller. Seems like
> an implementation of that scheduler (or a modification to the existing CKRM
> controller) + some support for CPU affinity + hotplug CPU support might
> approach your cpuset solution. Correct me if I completely missed it.

Marc, cpusets lead to physical isolation.

> 
> For memory isolation, I am not sufficiently familiar with NUMA style
> machines to comment on this topic.  The CKRM memory controller is
> interesting, but we have not used it sufficiently to comment.
> 
> Finally, in terms of isolation, we have mixed together CKRM with VSERVERs.
> Using CKRM for performance isolation and Vserver (for the lack of a better
> name) "view" isolation.  Maybe your users care about the vserver style of
> islation.  We have an anon cvs server with our kernel (which is based on
> Fedora Core 2 1.521 + vserver 1.9.2 + the latest ckrm e16 framework and
> resource controllers that are not even available yet at ckrm.sf.net), which
> you are welcome to play with.
> 
> Best regards,
> Marc
> 
> -----------
> Marc E. Fiuczynski
> PlanetLab Consortium --- OS Taskforce PM
> Princeton University --- Research Scholar
> http://www.cs.princeton.edu/~mef
> 
> 
>>-----Original Message-----
>>From: ckrm-tech-admin@lists.sourceforge.net
>>[mailto:ckrm-tech-admin@lists.sourceforge.net]On Behalf Of Andrew Morton
>>Sent: Friday, October 01, 2004 7:41 PM
>>To: Shailabh Nagar; ckrm-tech@lists.sourceforge.net
>>Cc: pj@sgi.com; efocht@hpce.nec.com; mbligh@aracnet.com;
>>lse-tech@lists.sourceforge.net; hch@infradead.org; steiner@sgi.com;
>>jbarnes@sgi.com; sylvain.jeaugey@bull.net; djh@sgi.com;
>>linux-kernel@vger.kernel.org; colpatch@us.ibm.com; Simon.Derr@bull.net;
>>ak@suse.de; sivanich@sgi.com
>>Subject: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
>>memory placement
>>
>>
>>
>>Paul, I'm having second thoughts regarding a cpusets merge.  Having gone
>>back and re-read the cpusets-vs-CKRM thread from mid-August, I am quite
>>unconvinced that we should proceed with two orthogonal resource
>>management/partitioning schemes.
>>
>>And CKRM is much more general than the cpu/memsets code, and hence it
>>should be possible to realize your end-users requirements using an
>>appropriately modified CKRM, and a suitable controller.
>>
>>I'd view the difficulty of implementing this as a test of the wisdom of
>>CKRM's design, actually.
>>
>>The clearest statement of the end-user cpu and memory partitioning
>>requirement is this, from Paul:
>>
>>
>>>Cpusets - Static Isolation:
>>>
>>>    The essential purpose of cpusets is to support isolating large,
>>>    long-running, multinode compute bound HPC (high performance
>>>    computing) applications or relatively independent service jobs,
>>>    on dedicated sets of processor and memory nodes.
>>>
>>>    The (unobtainable) ideal of cpusets is to provide perfect
>>>    isolation, for such jobs as:
>>>
>>>     1) Massive compute jobs that might run hours or days, on dozens
>>>	or hundreds of processors, consuming gigabytes or terabytes
>>>	of main memory.  These jobs are often highly parallel, and
>>>	carefully sized and placed to obtain maximum performance
>>>	on NUMA hardware, where memory placement and bandwidth is
>>>	critical.
>>>
>>>     2) Independent services for which dedicated compute resources
>>>        have been purchased or allocated, in units of one or more
>>>	CPUs and Memory Nodes, such as a web server and a DBMS
>>>	sharing a large system, but staying out of each others way.
>>>
>>>    The essential new construct of cpusets is the set of dedicated
>>>    compute resources - some processors and memory.  These sets have
>>>    names, permissions, an exclusion property, and can be subdivided
>>>    into subsets.
>>>
>>>    The cpuset file system models a hierarchy of 'virtual computers',
>>>    which hierarchy will be deeper on larger systems.
>>>
>>>    The average lifespan of a cpuset used for (1) above is probably
>>>    between hours and days, based on the job lifespan, though a couple
>>>    of system cpusets will remain in place as long as the system is
>>>    running.  The cpusets in (2) above might have a longer lifespan;
>>>    you'd have to ask Simon Derr of Bull about that.
>>>
>>
>>Now, even that is not a very good end-user requirement because it does
>>prejudge the way in which the requirement's solution should be
>>implemented.
>> Users don't require that their NUMA machines "model a hierarchy of
>>'virtual computers'".  Users require that their NUMA machines implement
>>some particular behaviour for their work mix.  What is that behaviour?
>>
>>For example, I am unable to determine from the above whether the users
>>would be 90% satisfied with some close-enough ruleset which was
>>implemented
>>with even the existing CKRM cpu and memory governors.
>>
>>So anyway, I want to reopen this discussion, and throw a huge spanner in
>>your works, sorry.
>>
>>I would ask the CKRM team to tell us whether there has been any
>>progress in
>>this area, whether they feel that they have a good understanding
>>of the end
>>user requirement, and to sketch out a design with which CKRM could satisfy
>>that requirement.
>>
>>Thanks.
>>
>>
>>-------------------------------------------------------
>>This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
>>Use IT products in your business? Tell us what you think of them. Give us
>>Your Opinions, Get Free ThinkGeek Gift Certificates! Click to
>>find out more
>>http://productguide.itmanagersjournal.com/guidepromo.tmpl
>>_______________________________________________
>>ckrm-tech mailing list
>>https://lists.sourceforge.net/lists/listinfo/ckrm-tech
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 

