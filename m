Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268066AbUHKPFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268066AbUHKPFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 11:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268077AbUHKPFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 11:05:41 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:47281 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S268066AbUHKPFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 11:05:21 -0400
Message-ID: <411A33BB.8080007@watson.ibm.com>
Date: Wed, 11 Aug 2004 10:56:59 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040810043120.23aaf071.pj@sgi.com> <41194E49.2000300@watson.ibm.com> <200408111242.04142.efocht@hpce.nec.com>
In-Reply-To: <200408111242.04142.efocht@hpce.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:
> On Wednesday 11 August 2004 00:38, Shailabh Nagar wrote:
> 
>>> Metrics, transactions, tasks, and resource
>>>    decisions all have to be tracked or managed by Class.
>>>
>>>    These Classes form a fairly shallow hierarchy of usage levels or
>>>    service qualities, as perceived by the end users of the system.
>>>
>>>    I'd guess that the average lifetime of a Class is months or years,
>>>    as they can reflect the relative priority of relations with long
>>>    standing, external customers.
>>>
>>>Cpusets and CKRM have profoundly different purposes, economics and
>>>motivations.
>>
>>I would say the methods differ, not the purpose. Both are trying to 
>>performance-isolate groups of tasks - one uses the spatial dimension of 
>>cpu bindings, the other uses  the temporal dimension of cpu time.
> 
> 
> So the purpose is different, too. With your words: spatial versus
> temporal separation. They are orthogonal. 

By purpose, I meant "performance isolation". Method used is spatial 
vs. temporal. But I guess thats just quibbling over words. The 
approaches are certainly orthogonal.

Also, cpusets have a purpose beyond isolation and that is 
optimization. One might want to restrict tasks/apps to a NUMA node for 
reducing avg mem latency - this is completely beyond CKRM's scope.



In physics terms: you need
> both to describe the universe and you cannot transform the one into
> the other. Both make sense, they can be combined to give more benefit
> (aehm, control).

On machines with a fairly large number of cpus, this is true. cpusets 
would partition a machine and CKRM would operate within each partition.

But its less clear whether both CKRM and cpuset approaches can be 
simultaneously used, profitably, on a smaller SMP if one is primarily 
interested in  isolation.

Partitioning the cpus with cpusets does offer harder guarantees, 
replicable isolation etc. but also runs the risk of underutilization.
If the user primarily wants to give 20% to one App, 40% to another, he 
does have to make that call: go with cpusets which offers better 
guarantees but could waste cpus or create ckrm classes which also 
offer this functionality but run the risk of weaker control depending 
on other applications load ?

To further complicate that choice, CKRM's design does provide for 
implementation of hard vs. soft limits where hard limits would provide 
the stronger guarantees that a user might want.

The CKRM CPU controller, in particular, is close (~ two weeks to 
availablity) to providing an implementation of hard limits which would 
offer stronger guarantees along the temporal dimension.



> 
> 
> 
>>The other point of difference is the one you'd brought up earlier - ther 
>>restrictions on the hierarchy creation. CKRM has none (effectively), 
>>cpusets has many.
> 
> 
> Don't know how it's exactly implemented, but the restrictions should
> not be at hierarchy creation time (i.e. when creating the class
> (cpusets) subdirectory). They should be imposed when setting/changing
> the attributes. 

True - I was lumping the "create cpuset + set its cpu ownership 
values" into the hierarchy creation. But the point made still holds 
good, CKRM has no controller-defined restrictions on changing 
attributes, cpusets does.

> Writing illegal values to the virtual attribute files
> must simply fail. And each resource controller knows best what it
> allows for and what not, this shouldn't be a task of the
> infrastructure (CKRM).

Yes, this makes sense.



>>As CKRM's interface stands today, there are sufficient differences 
>>between the interfaces to keep them separate.
>>
>>However, if CKRM moves to a model where
>>- each controller is allowed to define its own virtual files and attributes
>>- each controllers has its own hierarchy (and hence more control over 
>>how it can be formed),
>>then the similarities will be too many to ignore merger possibilities
>>altogether.
>>
>>The kicker is, we've not decided. The splitting of controllers into 
>>their own hierarchy is something we're considering independently (as a 
>>consequence of Linus' suggestion at KS04). But making the interface 
>>completely per-controller is something we can do, without too much 
>>effort, IF there is sufficient reason (we have other reasons for doing 
>>that as well - see recent postings on ckrm-tech).
> 
> 
> Having controller specifics less hidden is good because usage becomes
> more intuitive and you don't have to RTFM (controller specific manuals
> would have to be written, too). One file per attribute is also nicer
> than several attributes hidden in a shares files. Adding an attribute
> means adding a file, it doesn't break the old interface, so this is
> easier to maintain. And, as you mentioned, some files in the current
> CKRM interface just don't make sense for some resources. But a sane
> ruleset provided by CKRM for external controllers should be
> there. For example something like:
>    - Class members are added by writing to the vitual file "target".
>    - Class members are listed by reading the virtual file "target" and
>      the format is ...
>    - Each class attribute should be controlled by one file named
>      appropriately. Etc...
>    - Members of a class can register a callback which will be invoked
>      when following events occur:
>         - the class is destroyed
> 	- ... ?
>    - etc ...

One file per attribute is an excellent idea and the slight additional 
overhead won't matter since attribute changes are rarely in the 
critical path. Will follow up on this on ckrm-tech (which is cc'ed).

We'll still need to keep statistics grouped as far as possible because 
  the overhead of reading several files vs. one will matter.


> 
> 
>>Interest/recommendations from the community that cpusets  be part of 
>>CKRM's hierarchy would certainly be a factor in that decision.
> 
> 
> I'd prefer a single entry point for resource management with
> consistent (not necessarilly same) and easy to use user interfaces for
> all resources.
> 
> Regards,
> Erich
> 


P.S. I've pruned some of the names on the cc: list who are obviously 
subscribed to one or the other lists (mailman on sf keeps complaining 
if the cc list is too long). I can be dropped from the cc: too if this 
thread continues...
