Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVDVV35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVDVV35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVDVV3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:29:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13267 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262140AbVDVV3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:29:03 -0400
Date: Fri, 22 Apr 2005 14:26:18 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] Dynamic sched domains aka Isolated
 cpusets
Message-Id: <20050422142618.08d74ede.pj@sgi.com>
In-Reply-To: <20050421162738.GA4200@in.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<20050419093438.GB3963@in.ibm.com>
	<20050419102348.118005c1.pj@sgi.com>
	<20050420071606.GA3931@in.ibm.com>
	<20050420120946.145a5973.pj@sgi.com>
	<20050421162738.GA4200@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> Ok, Let me begin at the beginning and attempt to define what I am 
> doing here

The statement of requirements and approach help.  Thank-you.

And the comments in the code patch are much easier for me
to understand.  Thanks.

Let me step back and consider where we are here.

I've not been entirely happy with the cpu_exclusive (and mem_exclusive)
properties.  They were easy to code, and they require only looking at
ones siblings and parent, but they don't provide all that people usually
want, which is system wide exclusivity, because they don't exclude tasks
in ones parent (or more remote ancestor) cpusets from stealing resources.

I take your isolated cpusets as a reasonable attempt to provide what's
really wanted.  I had avoided simple, system-wide exclusivity because
I really wanted cpusets to be hierarchical.  One should be able to
subdivide and manage one subtree of the cpuset hierarchy, oblivious
to what someone else is doing with a disjoint subtree.  Your work shows
how to provide a stronger form of isolation (exclusivity) without
abandoning the hierarchical structure.

There are three directions we could go from here.  I am not yet decided
between them:

 1) Remove cpu and mem exclusive flags - they are of limited use.

 2) Leave code as is.

 3) Extend the exclusive capability to include isolation from parents,
    along the lines of your patch.

If I was redoing cpusets from scratch, I might not include the exclusive
feature at all - not sure.  But it's cheap, at least in terms of code,
and of some use to some users.  So I would choose (2) over (1), given
where we are now.  The main cost at present of the exclusive flags is
the cost in understanding - they tend to confuse people at first glance,
due to their somewhat unusual approach.

If we go with (3), then I'd like to consider the overall design of this
a bit more.  Your patch, as is common for patches, attempts to work within
the current framework, minimizing change.  Better to take a step back and
consider what would have been the best design as if the past didn't matter,
then with that clearly in mind, ask how best to get there from here.

I don't think we would have both isolated and exclusive flags, in the
'ideal design.'  The exclusive flags are essentially half (or a third)
of what's needed, and the isolated flags and masks the rest of it.

Essentially, your patch replaces the single set of CPUs in a cpuset
with three, related sets:
 A] the set of all CPUs managed by that cpuset
 B] the set of CPUs allowed to tasks attached to that cpuset
 C] the set of CPUs isolated for the dedicated use of some descendent

Sets [B] and [C] form a partition of [A] -- their intersection is empty,
and their union is [A].

Your current presentation of these sets of CPUs shows set [B] in the
cpus file, followed by set [C] in brackets, if I am recalling correctly.
This format changes the format of the current cpus_allowed file, and it
violates the preference for a single value or vector per file.  I would
like to consider alternatives.

Your code automatically updates [C] if the child cpuset adds or removes
CPUs from those it manages in isolation (though I am not sure that your
code manages this change all the way back up the hierarchy to the top
cpuset, and I wondering if perhaps your code should be doing this, as
noted in my detailed comments on your patch earlier today.)

I'd be tempted, if taking this approach (3) to consider a couple of
alternatives.

As I spelled out a few days ago, one could mark some cpusets that form a
partition of the systems CPUs, for the purposes of establishing isolated
scheduler domains, without requiring the above three related sets per
cpuset instead of one.  I am still unsure how much of your motivation is
the need to make the scheduler more efficient by establishing useful
isolated sched domains, and how much is the need to keep the usage of
CPUs by various jobs isolated, even from tasks attached to parent cpusets.

One can obtain the job isolation just in user code - if you don't want a
task to use a parent cpusets access to your isolated cpuset, then simply
don't attach a task to the parent cpusets.  I do not understand yet how
strong your requirement is to have the _kernel_ enforce that there are
not tasks in a parent cpuset which could intrude on the non-isolated
resources of a child.  I provide (non open source) user level tools to
my users which enable them to conveniently ensure that there are no such
unwanted tasks, so they don't have a problem with a parent cpusets CPUs
overlapping a cpuset that they are using for an isolated job.  Perhaps I
could persuade my employer that it would be appropriate to open source
these tools.

In any case, going (3) would result in _one_ attribute, not two (both
exclusive and isolated, with overlapping semantics, which is confusing.)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
