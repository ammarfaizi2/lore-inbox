Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUJBQYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUJBQYh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUJBQW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:22:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52619 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267314AbUJBQSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:18:37 -0400
Message-ID: <415ED3E3.6050008@watson.ibm.com>
Date: Sat, 02 Oct 2004 12:14:27 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com>
In-Reply-To: <20041002145521.GA8868@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, let me respond to this (again...) from the perspective of cpus.
This should to some extend also cover Andrew's request as well as
Paul's earlier message.

I see cpumem sets to be orthogonal to CKRM cpu share allocations.
AGAIN.
I see cpumem sets to be orthogonal to CKRM cpu share allocations.

In its essense, "cpumem sets" is a hierarchical mechanism of sucessively 
tighter constraints on the affinity mask of tasks.

The O(1) scheduler today does not know about cpumem sets. It operates
on the level of affinity masks to adhere to the constraints specified 
based on cpu masks.

The CKRM cpu scheduler also adheres to affinity mask constraints and 
frankly does not care how they are set.

So I do not see what at the scheduler level the problem will be.
If you want system isolation you deploy cpumem sets. If you want overall 
  share enforcement you choose ckrm classes.
In addition you can use both with the understanding that cpumem sets can 
and will not be violated even if that means that shares are not maintained.

Since you want orthogonality, cpumem sets could be implemented as a
different "classtype". They would not belong to the taskclass and thus 
are independent from what we consider the task class.



The tricky stuff comes in from the fact that CKRM assumes a system wide 
definition of a class and a system wide "calculation" of shares.






Dipankar Sarma wrote:
> On Fri, Oct 01, 2004 at 11:06:44PM -0700, Paul Jackson wrote:
> 
>>Cpuset Requirements
>>===================
>>
>>The three primary requirements that the SGI support engineers
>>on our biggest configurations keep telling me are most important
>>are:
>>  1) isolation,
>>  2) isolation, and
>>  3) isolation.  
>>A big HPC job running on a dedicated set of CPUs and Memory Nodes
>>should not lose any CPU cycles or Memory pages to outsiders.
>>
> 
> ....
> 
> 
>>A job running in a cpuset should be able to use various configuration,
>>resource management (CKRM for example), cpu and memory (numa) affinity
>>tools, performance analysis and thread management facilities within a
>>set, including pthreads and MPI, independently from what is happening
>>on the rest of the system.
>>
>>One should be able to run a stock 3rd party app (Oracle is
>>the canonical example) on a system side-by-side with a special
>>customer app, each in their own set, neither interfering with
>>the other, and the Oracle folks happy that their app is running
>>in a supported environment.
> 
> 
> One of the things we are working on is to provide exactly something
> like this. Not just that, within the isolated partitions, we want
> to be able to provide completely different environment. For example,
> we need to be able to run or more realtime processes of an application
> in one partition while the other partition runs the database portion
> of the application. For this to succeed, they need to be completely
> isolated.
> 
> It would be nice if someone explains a potential CKRM implementation for 
> this kind of complete isolation.

Alternatively to what is described above, if you want to do cpumemsets 
purely through the current implementation, I'd approach it as follows:

- Start with the current cpumemset implementation.
- Write the CKRM controller that simply replaces the API of the
   cpumemset.
- Now you have the object hierarchy through /rcfs/taskclass
- Change the memsets through the generic attributes (discussed in
   earlier emails to extend the static fixed shares notation)
- DO NOT USE CPU shares (always specify DONTCARE).

I am not saying that this is the most elegant solution, but neither
is trying to achieve proportional shares through cpumemsets.


> 
> Thanks
> Dipankar
> 

Hope this helps.

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

