Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUHHU3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUHHU3d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 16:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUHHU3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 16:29:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:1499 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266263AbUHHU33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 16:29:29 -0400
Message-ID: <41168B97.1010704@watson.ibm.com>
Date: Sun, 08 Aug 2004 16:22:47 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erich Focht <efocht@hpce.nec.com>
CC: Paul Jackson <pj@sgi.com>, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <200408071722.36705.efocht@hpce.nec.com>
In-Reply-To: <200408071722.36705.efocht@hpce.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:

> On Saturday 07 August 2004 08:10, Paul Jackson wrote:
> 
> Cpusets are a complex resource which needs to be managed. You already
> provided an interface for management but on the horizon there is this
> CKRM thing... I really don't care too much about the interface as long
> as it is comfortable (advocating for your bitset manipulation routines
> here ;-). CKRM will some day come in and maybe try to unify the
> resource control through a generalized interface. In my understand
> CKRM "classes" are (for the cpusets resource) your "sets". I was
> trying to anticipate that CKRM might want to present the single entry
> point for managing resources, including cpusets.

That is the intended utility of the CKRM core+interface, atleast for any 
resource for which it is useful to impose controls on a group of objects 
at once, as opposed to individually.

> 
> If I understand correctly, CKRM is fine for simple resources like
> amount of memory or cputime and designed to control flexible sharing
> of these resources and ensure some degree of fairness. Cpusets is a
> complex NUMA specific compound resource which actually only allows for
> a rather static distribution across processes (especially with the
> exclusive bits set). Including cpusets control into CKRM will be
> trivial, because you already provide all that's needed.

If we move to the new model where each controller has an independent 
hierarchy, this becomes a real possibility. We'd still need to negotiate 
on the interface. Implementationally its pretty simple....the main 
question is - should there be some uniformity in the interfaces at the 
/rcfs/<?> level for each controller or not. If there isn't, the only 
thing that CKRM brings to the table (for cpusets) is the filesystem.

> 
> What I proposed was to include cpusets ASAP. As we learned from
> Hubertus, CKRM is undergoing some redesign (after the kernel summit),
> so let's now get used to cpusets and forget about the generic resource
> controller until that is mature to enter the kernel. 

> When that happens
> people might love the generic way of controlling resources 

Might ? :-) We think its a home run :-)

> and the
> cpusets user interface will be yet another filesystem for controlling
> some hierarchical structures... The complaints about the huge size of
> the patch should therefore have in mind that we might well get rid of
> the user interface part of it. The core infrastructure of cpusets will
> be needed anyway and the amount of code is the absolutely required
> minimum, IMHO.
> 
> 
> 
>>The other reason that this suggestion worries me is a bit more
>>philosophical.  I'm sure that for all the other, well known,
>>resources that CKRM manages, no one is proposing replacing whatever
>>existing names and mechanisms exist for those resources, such as
>>bandwidth, compute cycles, memory, ...  Rather I presume that CKRM
>>provides an additional resource management layer on top of the
>>existing resources, which retain their classic names and apparatus.
>>[...]
> 
> 
> I hope cpusets will be an "existing resource" when CKRM comes into
> play. It's a compound resource built of cpus and memories (and the
> name cpuset is a bit misleading) but it fully makes sense on a NUMA
> machine to have these two elementary resources glued together. If CKRM
> was to build a resource controller for cpu masks and memories, or two
> separate resource controllers, the really acceptable end result would
> look like the current cpusets infrastructure. So why waste time?
> 
> Later cpusets could borrow the user interface of CKRM or, if the
> cpusets user interface is better suited, maybe we can just have a
> /rcfs/cpusets/ directory tree with the current cpusets look and feel?
> Question to CKRM people: would it make sense to have a class with
> another way of control than the shares/targets/members files?

Need to mull this over in ckrm-tech, as mentioned earlier.
There are two issues:
- should controllers be allowed to create their own virtual files ?
- are all of the existing shares/targets/members files sufficiently 
useful to existing and future controllers to make them available by 
default (and offer the user some consistency) ?

I feel the answer to the second one is a yes though I'm not convinced 
that the attributes within the shares file need to be the same.

But saying yes to the first one will mean controllers have to implement 
some filesystem-related code (as is done by CKRM's Classification Engine 
modules, which also sit under /rcfs but have a completely different 
interface in terms of virtual files). We could work something out where 
controllers could use common code where available and then roll their 
own extras.

If there's interest in this idea from the cpusets team and if we can 
come up with a way in which cpu/mem/io etc. could continue to share 
common rcfs code (as they do today) CKRM could consider this option.

-- Shailabh
