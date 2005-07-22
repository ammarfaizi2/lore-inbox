Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVGVD5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVGVD5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVGVD5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:57:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45777 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261907AbVGVD4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:56:36 -0400
Message-ID: <42E06F0D.8020503@watson.ibm.com>
Date: Thu, 21 Jul 2005 23:59:09 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
References: <20050717082000.349b391f.pj@sgi.com> <Pine.LNX.4.44.0507171330030.4074-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0507171330030.4074-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
>>I suspect that the main problem is that this patch is not a mainstream
>>kernel feature that will gain multiple uses, but rather provides
>>support for a specific vendor middleware product used by that
>>vendor and a few closely allied vendors.  If it were smaller or
>>less intrusive, such as a driver, this would not be a big problem.
>>That's not the case.
> 
> 
> yes, that's the crux.  CKRM is all about resolving conflicting resource 
> demands in a multi-user, multi-server, multi-purpose machine.  this is a 
> huge undertaking, and I'd argue that it's completely inappropriate for 
> *most* servers.  that is, computers are generally so damn cheap that 
> the clear trend is towards dedicating a machine to a specific purpose, 
> rather than running eg, shell/MUA/MTA/FS/DB/etc all on a single machine.  

The argument about scale-up vs. scale-out is nowhere close to being 
resolved. To argue that any support for performance partitioning (which 
CKRM does) is in support of a lost cause is premature to say the least.

> this is *directly* in conflict with certain prominent products, such as 
> the Altix and various less-prominent Linux-based mainframes.  they're all
> about partitioning/virtualization - the big-iron aesthetic of splitting up 
> a single machine.  note that it's not just about "big", since cluster-based 
> approaches can clearly scale far past big-iron, and are in effect statically
> partitioned.  yes, buying a hideously expensive single box, and then chopping 
> it into little pieces is more than a little bizarre, and is mainly based
> on a couple assumptions:
> 
> 	- that clusters are hard.  really, they aren't.  they are not 
> 	necessarily higher-maintenance, can be far more robust, usually
> 	do cost less.  just about the only bad thing about clusters is 
> 	that they tend to be somewhat larger in size.
> 
> 	- that partitioning actually makes sense.  the appeal is that if 
> 	you have a partition to yourself, you can only hurt yourself.
> 	but it also follows that burstiness in resource demand cannot be 
> 	overlapped without either constantly tuning the partitions or 
> 	infringing on the guarantee.

"constantly tuning the partitions" is effectively whats done by workload 
managers. But our earlier presentations and papers have made the case 
that this is not the only utility for performance isolation - simple 
needs like isolating one user from another on a general purpose server 
is also a need that cannot be met by any existing or proposed Linux 
kernel mechanisms today.

If partitioning made so little sense and the case for clusters was that 
obvious, one would be hard put to explain why server consolidation is 
being actively pursued by so many firms, Solaris is bothering with 
coming up with Containers and Xen/VMWare getting all this attention.
I don't think the concept of partitioning can be dismissed so easily.

Of course, it must be noted that CKRM only provides performance 
isolation not fault isolation. But there is a need for that. Whether 
Linux chooses to let this need influence its design is another matter 
(which I hope we'll also discuss besides the implementation issues).

> CKRM is one of those things that could be done to Linux, and will benefit a
> few, but which will almost certainly hurt *most* of the community.
> 
> let me say that the CKRM design is actually quite good.  the issue is whether 
> the extensive hooks it requires can be done (at all) in a way which does 
> not disporportionately hurt maintainability or efficiency.

If there are suggestions on implementing this better, it'll certainly be 
very welcome.

> 
> CKRM requires hooks into every resource-allocation decision fastpath:
> 	- if CKRM is not CONFIG, the only overhead is software maintenance.
> 	- if CKRM is CONFIG but not loaded, the overhead is a pointer check.
> 	- if CKRM is CONFIG and loaded, the overhead is a pointer check
> 	and a nontrivial callback.
> 
> but really, this is only for CKRM-enforced limits.  CKRM really wants to
> change behavior in a more "weighted" way, not just causing an
> allocation/fork/packet to fail.  a really meaningful CKRM needs to 
> be tightly integrated into each resource manager - effecting each scheduler
> (process, memory, IO, net).  I don't really see how full-on CKRM can be 
> compiled out, unless these schedulers are made fully pluggable.

This is a valid point for the CPU, memory and network controllers (I/O 
can be made pluggable quite easily). For the CPU controller in SuSE, the 
CKRM CPU controller can be turned on and off dynamically at runtime. 
Exploring a similar option for  memory and network (incurring only a 
pointer check) could be explored. Keeping the overhead close to zero for 
kernel users not interested in CKRM is certainly one of our objectives.

> finally, I observe that pluggable, class-based resource _limits_ could 
> probably be done without callbacks and potentially with low overhead.
> but mere limits doesn't meet CKRM's goal of flexible, wide-spread resource 
> partitioning within a large, shared machine.

True but only limits are not as useful for general workload management.

> regards, mark hahn.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


