Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUHHUIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUHHUIH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 16:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUHHUIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 16:08:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:34027 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266245AbUHHUGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 16:06:32 -0400
Message-ID: <411685D6.5040405@watson.ibm.com>
Date: Sun, 08 Aug 2004 15:58:14 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Erich Focht <efocht@hpce.nec.com>, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>	<20040805190500.3c8fb361.pj@sgi.com>	<247790000.1091762644@[10.10.2.4]>	<200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com>
In-Reply-To: <20040806231013.2b6c44df.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Erich Focht wrote:
> 
>>we (NEC) are also a potential user of this patch
> 
> 
> Good - welcome.
> 
> 
> 
>>I think cpusets and CKRM should be
>>made to come together. One of CKRM's user interfaces is a filesystem
>>with the file-tree representing the class hierarchy. It's the same for
>>cpusets.
> 
> 
> Hmmm ... this suggestion worries me, for a couple of reasons.
> 
> Just because cpusets and CKRM both have a hierarchy represented in a
> file system doesn't mean it is, or can be, the same file system.  Not
> all trees are the same.
> 
> Perhaps someone more expert in CKRM can help here.  The cpuset hierarchy
> has some strict semantics:
>  1) Any cpusets CPUs and Memory must be a subset of its parents.
>  2) A cpuset may be exclusive for CPU or Memory only if its parent is.
>  3) A CPU or Memory exclusive cpuset may not overlap its siblings.
> 
> See the routine kernel/cpuset.c:validate_change() for the exact
> coding of these rules.
> 
> If we followed your suggestion, Erich, would these rules still hold?
> I can't imagine that the CKRM folks have any existing hierarchies with
> these particular rules.  They would need to if we went this way.

As CKRM stands today, we wouldn't be able to impose these constraints 
for exactly the reasons you point out. The other controllers would not 
forbid the move of a task violating the above rules to a CKRM class but 
this controller (CKRM's version of cpusets) would. Currently, on a task 
move, CKRM's core calls per-controller callbacks so the controller can 
make modifications to the controller-specific per-class objects. But 
controllers can't prevent such a move.

However, one of the CKRM changes suggested in the Kernel Summit was to 
split up the controllers and not have them bundled within a "core" class 
as we call it. In this model, each task would directly belong to some 
controller-specific class.

If CKRM were to adopt this change, one *potential* (but not necessary) 
consequence, is to have multiple hierarchies, one per-controller, 
exposed to the user e.g. instead of /rcfs/taskclass/<sameclasstree>, we 
would have /rcfs/cpu/<oneclasstree> and /rcfs/mem/<anotherclasstree> etc.

In such a scenario, it would be more logical for the controller to 
constrain memberships (i.e. task moves, class share setting while it is 
part of a hierarchy etc.) and it would be easy for cpusets to get its 
semantics.


> 
> On the flip side, what additional rules, if any, would CKRM impose
> on this hierarchy?

Currently, we impose rules on the shares that one can set (child cannot 
have more than its parent, sibling shares should add up etc.) and we'd
discussed, but not implemented yet, some limit on how deep the common 
hierarchy would go.

> 
> The other reason that this suggestion worries me is a bit more
> philosophical.  I'm sure that for all the other, well known,
> resources that CKRM manages, no one is proposing replacing whatever
> existing names and mechanisms exist for those resources, such as
> bandwidth, compute cycles, memory, ...  Rather I presume that CKRM
> provides an additional resource management layer on top of the
> existing resources, which retain their classic names and apparatus.
> 
> What you seem to be suggesting here, especially with this nice
> picture from your next post:
> 
>         The files in cpusets are:
>          - cpus: list of CPUs in that cpuset
>          - mems: list of Memory Nodes in that cpuset
>          - cpu_exclusive flag: is cpu placement exclusive?
>          - mem_exclusive flag: is memory placement exclusive?
>          - tasks: list of tasks (by pid) attached to that cpuset
>         The files in a CKRM class directory:
>          - stats   : statistics (not needed for cpusets)
>          - shares  : could contain cpus, mems, cpu_exclusive, mem_exclusive
>          - members : same as reading /dev/cpusets/.../tasks
>          - target  : same as writing /dev/cpusets/.../tasks
> 
>         Changing the "shares" would mean something like
>           echo "cpus +6-10" > .../shares
> 
> would remove the cpuset specific interface forever, leaving it only
> visible via a more generic "shares, members, target" interface suitable
> for abstract resource management.
> 
> I am afraid that this would make it harder for new users of cpusets to
> figure them out.  Just cpusets by themselves add a new and strange layer
> of abstraction, that will require a little bit of head scratching (as
> Martin Bligh can testify to, from recent experience ;) for those
> administering and managing the big iron where cpusets will be useful. 
> 
> To add yet another layer of abstractions on top of that, from the CKRM
> world, might send quite a few users into mental overload, doing the
> usual stupid things we all do when we have given up on understanding and
> are just thrashing about, trying to get something to work.
> 
> I think we are onto something useful here, the hierarchical organizing
> of compute resources of CPU and Memory, which will become increasingly
> relevant in the coming years, with bigger machines and more complex
> compute and memory architectures.
> 
> I'd hate to see cpusets hidden behind resource management terms from day
> one.

Yup, thats a valid concern. In this current round of CKRM redesign, 
we're considering whether controllers should be allowed to export their 
own interface (in a sense) by accepting different kinds of share 
settings. That is already true today in case of the "stats" and "config" 
virtual files which don't have any CKRM-imposed semantics. Only "shares" 
  has a CKRM-defined set of values defined, not all of which are useful 
or will be implemented by a controller. We're debating whether to make 
that one controller-dependent too. If that happens, it'll make it 
somewhat better for cpusets. But I'm not sure if we'd want to go so far 
as to allow controllers to define what virtual files they export......we 
do that today for the classification engine because it is an entirely 
different beast but the controllers are similar.....

> And, looking at it from the CKRM side (not sure I can, I'll try ...)
> would it not seem a bit odd to a CKRM user that just one of the resource
> types managed, these cpusets, had no apparent existence outside of the
> CKRM hierarchy, unlike all the other resources, which existed a priori,
> and, I presume, continue their independent existance?

 From just the viewpoint of cpusets (not adding mem), it seems to be 
quite similar to what CKRM's other controllers are doing - grouping a 
per-task control (in your case, sched_setaffinity) using  hierarchical 
sets.

> 
> Obviously, I could use a little CKRM expertise here.
> 
> But my inclination is to continue to view these two projects as separate,
> with the potential that CKRM will someday add cpusets to the resource types
> that it can manage.

Umm... I'm quite sure you mean , you'll contribute code to do that, 
right ? :-)

It looks like the interface issue is the main one from both projects' 
pov. Hopefully things will become clearer in the next week or so when 
ckrm-tech thrashes out the Kernel Summit suggestion (it has other 
ramifications besides interface).

-- Shailabh
> 
> Thank-you.
> 

