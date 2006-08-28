Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWH1Bue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWH1Bue (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 21:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWH1Bue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 21:50:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15521 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932326AbWH1Bue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 21:50:34 -0400
Date: Sun, 27 Aug 2006 18:50:04 -0700
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, akpm@osdl.org,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-Id: <20060827185004.dd3c569e.pj@sgi.com>
In-Reply-To: <20060821174906.GB21130@in.ibm.com>
References: <20060820174015.GA13917@in.ibm.com>
	<20060820174839.GH13917@in.ibm.com>
	<20060820134849.ac449471.pj@sgi.com>
	<20060821174906.GB21130@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vatsa, responding to pj:
> > I can certainly imagine that such constraints make it easier to write
> > correct scheduler group management code.  And I can certainly allow
> > that the cpuset style API, allowing one bit at a time to be changed
> > with each separate open/write/close sequence of system calls, makes it
> > difficult to impose such constraints over the state of several settings
> > at once.
> 
> Could you elaborate this a bit? What do you mean by "difficult to impose
> such constraints"? Are you referring to things like after metered child
> cpusets have been created, any changes to cpus field of parent has to be
> reflected in all its child-cpusets 'atomically'?
> 
> > It sure would be nice to avoid the implicit side affects of copying
> > parent state on the mkdir, and it sure would be nice to reduce the
> > enforced sequencing of operations. 
> 
> How would this help?

Sorry for the delay in responding - I got distracted by other stuff.

I wasn't very clear ... Let me try again.  You have some reasonable
enough constraints that apply to several per-cpuset attributes in
several cpusets, including a parent and its children.  However, it
took me a bit of reading to figure this out, as these constraints are
magically imposed on the child cpusets when created beneath a parent
marked cpu_meter_enabled.

Normal cpuset operations are done by an open/write/close on a single
per-cpuset attribute at a time.  I prefer to avoid magic in the cpuset
API, such as the special copying of the 'cpus', 'mems' and
'cpu_meter_enabled' attributes from the parent to the new child as a
consequence of doing the mkdir. Rather, if some setup requires these
particular settings, I prefer that we require the user code to have to
set each of these attributes, explicitly, one at a time.

However, your code, reasonably enough, does not want to deal with half
baked cpu_meter enabled setups.  If the child is there at all, it must
instantly conform to all the necessary constraints.  So you need to have
the kernel code modify several per-cpuset attributes instantly (from the
user perspective) and automagically, as a side affect of the mkdir call.

I don't like that kind of magic, because I think it makes it a bit
harder to understand the interface.  But I don't have any idea how to
avoid it in this case.  So, as I noted before, this seems worth some
more head scratching, if this  CPU controller ends up adapting this
sort of cpuset API mechanism.

Granted, even the current cpuset code sometimes does that magic, as
for instance the creation of the several per-cpuset special files as
a side affect of the mkdir creating the cpuset.  So I can understand
that you might not have realized I had any dislike of that style of
API ;).

On a related note, I am inclined, whenever I think about this, toward
suggesting that the 'cpu_meter_enabled' flag, which is set in both the
parent and child, should be two flags.  Just as I like my operations
to be simple, with minimum side affects and special cases, so do I
like my flags to be simple, with minimum logical complications.  In this
case, that flag means one of two different things, depending on whether
it is the parent or child.  Perhaps splitting that flag into two flags,
cpuset_meter_parent and cpuset_meter_child, would help clarify this.

Sorry ... too many words ... hopefully it is clearer this time.

 
> There is atleast another serious issue in using cpusets for this API -
> how do we easily find all tasks belonging to a cpuset? There seems to be
> no easy way of doing this, w/o walking thr' the complete task-list.
> 
> We need this task-list for various reasons - like change
> taks->load_weight of all tasks in a child-cpuset when its cpu quota is
> changed etc.

Yes, the only way that exists with the current cpuset code to get a list
of the tasks in a cpuset requires locking and scanning the tasklist.

For current cpuset needs, that seems reasonable enough - a fairly
minimal kernel solution sufficient for our uses.

But I can well imagine that you would need a more efficient, scalable
way to list the tasks in a cpuset.

I suppose this would lead to a linked list of the tasks in a cpuset.
Given the already somewhat fancy [grep rcu kernel/cpuset.c] mechanism
we use to allow one task to modify another tasks cpuset pointer, even
as that affected task is accessing that cpuset lock free, this could be
interesting coding.


> > One other question ... how does all this interact with Suresh's
> > dynamic sched domains?
> 
> By "all this" I presume you are referring to the changes to cpuset in
> this patch. I see little interaction. AFAICS all metered child-cpusets should 
> be in the same dynamic sched-domain afaics.

That's the possible issue -- ensuring that all metered child-cpusets are
in the same dynamic sched domain.  If you know that works out that way,
then good.  I have had to impose a voluntary retirement on myself from
commenting on sched domain code -- it's just too hard for my modest
brain.

My basic concern was not that there would be specific detailed code
level conflicts between your cpu controllers and Suresh's dynamic sched
domains, but rather that I sensed two mechanisms here both intending to
group tasks for the purposes of affecting their scheduling, and I hoped
that it was clear how these two mechanisms played together.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
