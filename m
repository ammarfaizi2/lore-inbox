Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVBISBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVBISBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVBISBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:01:41 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:45048 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261867AbVBISBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:01:35 -0500
Date: Wed, 9 Feb 2005 09:59:28 -0800
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Matthew Dobson <colpatch@us.ibm.com>, dino@in.ibm.com, mbligh@aracnet.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <20050209175928.GA5710@chandralinux.beaverton.ibm.com>
References: <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis> <420800F5.9070504@us.ibm.com> <20050208095440.GA3976@in.ibm.com> <42090C42.7020700@us.ibm.com> <20050208124234.6aed9e28.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208124234.6aed9e28.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 12:42:34PM -0800, Paul Jackson wrote:
> Matthew wrote:
> 
> I found no useful and significant basis for integration of cpusets and
> CKRM either involving CPU or Memory Node management.
> 
> As best as I can figure out, CKRM is a fair share scheduler with a
> gussied up more modular architecture, so that the components to track
> usage, control (throttle) tasks, and classify tasks are separate
> plugins.  I can find no significant and useful overlap on any of these
> fronts, either the existing plugins or their infrastructure, with what
> cpusets has and needs.
> 
> There are claims that CKRM has some generalized resource management
> architecture that should be able to handle cpusets needs, but despite my
> repeated (albeit not entirely successful) efforts to find documentation
> and read source and my pleadings with Matthew and earlier on this
> thread, I was never able to figure out what this meant, or find anything
> that could profitably integrate with cpusets.

I thought Hubertus did talk about this when the last time the thread
was active. Anyways, Here is how one could do cpuset/memset under the
ckrm framework(Note that I am not pitching for a marriage :) as there are 
some small problems, like supporting 128 cpus, changing the parameter names
that ckrm currently uses):

First off cpuset and memset has to be implemented as two different
controllers.

cpuset controller:
- 'guarantee' parameter to be used for representing cpuset(bitwise)
- 'limit' parameter to be used for exclusivity and other flags.
- Highest level class(/rcfs/taskclass) will have all cpus in its list
- Every class will maintain two sets of cpusets, one that can be inherited,
  inherit_cpuset(needed when exclusive is set in a child) and the other
  for use by the class itself, my_cpuset.
- when a new class is created (under /rcfs/taskclass), it inherits all the 
  CPUS (from inherit_cpuset).
- admin can change the cpuset of this class by echoing the new 
  cpuset(guarantee) into the 'shares' file.
- admin can set/change the exclusivity(like) flags by echoing the value(limit)
  to the 'shares' file.
- When the exclusivity flag is set in a class, the cpuset bits in this class
  will be cleared in the inherit_cpuset of the parent, and all its other
  children.
- At the time of scheduling, my_cpuset in the class of the task will be
  consulted.

memset_controller would be similar to this, before pitching it I will talk
with Matt about why he thought that there is a problem.

If I missed some feature of cpuset that shows a bigger problem, please
let me know.
> 
> In sum -- I see a potential for useful integration of cpusets and
> scheduler domains, I'll have to leave it up to those with expertise in
> the scheduler to evaluate and perhaps accomplish this.  I do not see any
> useful integration of cpusets and CKRM.
> 
> I continue to be befuddled as to why, Matthew, you confound potential
> cpuset-scheddomain integration with potential cpuset-CKRM integration.
> Scheduler domains and CKRM are distinct beasts, in my book, and the
> contemplations of cpuset integration with these two beasts are also
> distinct efforts.
> 
> And cpusets and CKRM are distinct beasts.
> 
> But I repeat myself ...
> 
> -- 
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
