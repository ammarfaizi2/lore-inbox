Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVDTTNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVDTTNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 15:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDTTNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 15:13:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58846 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261687AbVDTTM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 15:12:57 -0400
Date: Wed, 20 Apr 2005 12:09:46 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] Dynamic sched domains aka Isolated
 cpusets
Message-Id: <20050420120946.145a5973.pj@sgi.com>
In-Reply-To: <20050420071606.GA3931@in.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<20050419093438.GB3963@in.ibm.com>
	<20050419102348.118005c1.pj@sgi.com>
	<20050420071606.GA3931@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier, I wrote to Dinakar:
> What are your invariants, and how can you assure yourself and us
> that your code preserves these invariants?

I repeat that question.

===

On my first reading of your example, I see the following.

It is sinking into my dense skull more than it had before that your
patch changes the meaning of the cpuset field 'cpus_allowed', to only
include the cpus not in isolated children.  However there are other uses
of the 'cpus_allowed' field in the cpuset code that are not changed, and
comments and documentation describing this field that are not changed. 
I suspect this is an incomplete change.

You don't actually state it that I noticed, but the main point of your
example seems to be that you support incrementally moving individual
cpus between cpusets, without the constraint that both cpusets be in the
same subset of the partition (the same isolation group).  So you can
move a cpu in and out of an isolated group without tearing down the
group down first, only to rebuild it after.

To do this, you've added new semantics to some of the operations to
write the 'cpus' special file of a cpuset, if and only if that cpuset is
marked isolated, which involves changing some other masks.  These new
semantics are something along the lines of "adding a cpu here implies
removing it from there.  This presumably allows you to move cpus in or
out of or between an isolated cpuset, while preserving the essential
properties of a partition - that it is a disjoint covering.

> He removes cpus 4-5 from batch and adds them to cint

Could you spell out the exact steps the user would take, for this part
of your example?  What does the user do, what does the kernel do in
response, and what state the cpusets end up in, after each action of the
user?

===

So far, to be honest, I am finding your patch to be rather frustrating.

Perhaps the essential reason is this.  The interface that cpusets
presents in the cpuset file system, mounted at /dev/cpuset, is not in my
intentions primarily a human interface.  It is primarily a programmatic
interface.

As such, there is a high premium on clarity of design, consistency of
behaviour and absence of side affects.   Each operation should do one
thing, clearly defined, changing only what is operated on, preserving
clearly spelled out invariants.

If it takes three steps instead of one to accomplish a typical task,
that's fine.  The programs that layer on top of /dev/cpuset don't mind
doing three things to get one thing done.  But such programs are a pain
in the backside to program correctly if the affects of each operation
are not clearly defined, not focused on the obvious object being
operated on, or not precisely consistent with an overriding model.

This patch seems to add side affects and the change the meanings of
things, doing so with the most minimum of mention in the description,
without clearly and consistently spelling out the new mental model, and
without uniformly changing all uses, comments and documentation to fit
the new model.

This cpuset facility is also a less commonly used kernel facility, and
changes to cpusets, outside of a few key hooks in the scheduler and
allocator, are not performance critical.  This means that there is a
premium in keeping the kernel code minimal, leaving as many details as
practical to userland.  This patch seems to increase the kernel text
size, for an ia64 SN2 build using gcc 3.2.3 of a 2.6.12-rc1-mm4 tree I
had at hand, _just_ for the cpuset.c changes, from 23071 bytes to 28999.

  That's over a 25% per-cent increase in the kernel text size of the file
  kernel/cpuset.o, just for this feature.  That's too much, in my view.

I don't know yet if the ability to move cpus between isolated sched
domains without tearing them down and rebuilding them, is a critical
feature for you or not.  You have not been clear on what are the
essential requirements of this feature.  I don't even know for sure yet
that this is the one key feature in your view that separates your
proposal from the variations I explored.

But if this is for you the critical feature that your proposal has, and
mine lack, then I'd like to see if there is a way to do it without
implicit side affects, without messing with the semantics of what's
there now, and with significantly fewer bytes of kernel text space.  And
I'd like to see if we can have uniform and precisely spelled out
semantics, in the code, comments and documentation, with any changes to
the current semantics made everywhere, uniformly.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
