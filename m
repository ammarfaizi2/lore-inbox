Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUHGGMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUHGGMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 02:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUHGGMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 02:12:37 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4573 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266271AbUHGGMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 02:12:32 -0400
Date: Fri, 6 Aug 2004 23:10:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Erich Focht <efocht@hpce.nec.com>
Cc: mbligh@aracnet.com, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20040806231013.2b6c44df.pj@sgi.com>
In-Reply-To: <200408061730.06175.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:
> we (NEC) are also a potential user of this patch

Good - welcome.


> I think cpusets and CKRM should be
> made to come together. One of CKRM's user interfaces is a filesystem
> with the file-tree representing the class hierarchy. It's the same for
> cpusets.

Hmmm ... this suggestion worries me, for a couple of reasons.

Just because cpusets and CKRM both have a hierarchy represented in a
file system doesn't mean it is, or can be, the same file system.  Not
all trees are the same.

Perhaps someone more expert in CKRM can help here.  The cpuset hierarchy
has some strict semantics:
 1) Any cpusets CPUs and Memory must be a subset of its parents.
 2) A cpuset may be exclusive for CPU or Memory only if its parent is.
 3) A CPU or Memory exclusive cpuset may not overlap its siblings.

See the routine kernel/cpuset.c:validate_change() for the exact
coding of these rules.

If we followed your suggestion, Erich, would these rules still hold?
I can't imagine that the CKRM folks have any existing hierarchies with
these particular rules.  They would need to if we went this way.

On the flip side, what additional rules, if any, would CKRM impose
on this hierarchy?

The other reason that this suggestion worries me is a bit more
philosophical.  I'm sure that for all the other, well known,
resources that CKRM manages, no one is proposing replacing whatever
existing names and mechanisms exist for those resources, such as
bandwidth, compute cycles, memory, ...  Rather I presume that CKRM
provides an additional resource management layer on top of the
existing resources, which retain their classic names and apparatus.

What you seem to be suggesting here, especially with this nice
picture from your next post:

        The files in cpusets are:
         - cpus: list of CPUs in that cpuset
         - mems: list of Memory Nodes in that cpuset
         - cpu_exclusive flag: is cpu placement exclusive?
         - mem_exclusive flag: is memory placement exclusive?
         - tasks: list of tasks (by pid) attached to that cpuset
        The files in a CKRM class directory:
         - stats   : statistics (not needed for cpusets)
         - shares  : could contain cpus, mems, cpu_exclusive, mem_exclusive
         - members : same as reading /dev/cpusets/.../tasks
         - target  : same as writing /dev/cpusets/.../tasks

        Changing the "shares" would mean something like
          echo "cpus +6-10" > .../shares

would remove the cpuset specific interface forever, leaving it only
visible via a more generic "shares, members, target" interface suitable
for abstract resource management.

I am afraid that this would make it harder for new users of cpusets to
figure them out.  Just cpusets by themselves add a new and strange layer
of abstraction, that will require a little bit of head scratching (as
Martin Bligh can testify to, from recent experience ;) for those
administering and managing the big iron where cpusets will be useful. 

To add yet another layer of abstractions on top of that, from the CKRM
world, might send quite a few users into mental overload, doing the
usual stupid things we all do when we have given up on understanding and
are just thrashing about, trying to get something to work.

I think we are onto something useful here, the hierarchical organizing
of compute resources of CPU and Memory, which will become increasingly
relevant in the coming years, with bigger machines and more complex
compute and memory architectures.

I'd hate to see cpusets hidden behind resource management terms from day
one.

And, looking at it from the CKRM side (not sure I can, I'll try ...)
would it not seem a bit odd to a CKRM user that just one of the resource
types managed, these cpusets, had no apparent existence outside of the
CKRM hierarchy, unlike all the other resources, which existed a priori,
and, I presume, continue their independent existance?

Obviously, I could use a little CKRM expertise here.

But my inclination is to continue to view these two projects as separate,
with the potential that CKRM will someday add cpusets to the resource types
that it can manage.

Thank-you.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
