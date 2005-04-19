Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVDSUfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVDSUfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVDSUfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:35:42 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19436 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261658AbVDSUf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:35:27 -0400
Date: Tue, 19 Apr 2005 13:34:31 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-Id: <20050419133431.2e389d57.pj@sgi.com>
In-Reply-To: <1113897440.5074.62.camel@npiggin-nld.site>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<1113891575.5074.46.camel@npiggin-nld.site>
	<20050419001926.605a6b59.pj@sgi.com>
	<1113897440.5074.62.camel@npiggin-nld.site>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> Well the scheduler simply can't handle it, so it is not so much a
> matter of pushing - you simply can't use partitioned domains and
> meaningfully have a cpuset above them.

Translating that into cpuset-speak, I think what you mean is that I
can't have partitioned sched domains and have a task attached to a
cpuset above them, if it matters to me that the task can actually use
all the CPUs in its larger cpuset.

But what you actually said was that I cannot have a cpuset above them.

I can certainly _can_ have a cpuset above the cpusets that define the
partitioned domains.  I _have_ to have that, or toss the entire
hierarchical design cpuset.  The top cpuset encompasses all the CPUs on
the system, and is above all others.

Let's see if the following example helps clear up these confusions.

Let's say we started out as one big happy family, with a single top
cpuset, and a single sched domain, each encompassing the entire machine.
All tasks are attached to that cpuset and load balanced and scheduled in
that sched domain.  Any task can be run anywhere.

Then some yahoo comes along and decides to complicate things.  They
create my two cpusets Alpha and Beta, each covering half the system.
They create two partitioned sched domains corresponding to Alpha and
Beta, respectively.  They move almost every task into one of Alpha or
Beta, expecting hence forth that each such moved task will only run on
whichever half of the system it was placed in.  For instance, if they
moved init into Alpha, that means they _want_ the init task to be
constrained to the Alpha half of the system, even if every CPU in Beta
has been idle for the last 5 hours.

So far, all fine and dandy.

But they leave behind a few tasks still attached to the top cpuset, with
those tasks cpus_allowed still allowing any CPU in the system. They
actually don't give a rat's patootie about these few tasks, because they
consume less than 10 seconds each per day, and so long as they are
allowed their few CPU cycles when they want them, all is well.  They
could have moved these tasks as well into Alpha or Beta, but they wanted
to be annoying and see if they could concoct a test case that would
break something here.  Or maybe they were just forgetful.

What breaks?  You seem to be telling me that this is ver botten, but I
don't see yet where the problem is.

My timid guess is that about all that breaks is that each of these stray
tasks will be forever after stuck in which ever one of Alpha or Beta it
happened to be in at the point of the Great Divide.  If say one of these
tasks happened to be on the Beta side at that point, the Beta domain
scheduler will never let an Alpha CPU see that task, leaving the task to
only ever be picked up by a Beta CPU (even though the tasks cpuset and
cpus_allowed would have allowed an Alpha CPU, in theory).

Translating this back into a language my users might speak, I guess is
this means I tell them:
 * No scheduling or load balancing is done across partitioned scheduler domains.
 * Even if one such domain is hugely oversubscribed, and another totally
   idle, no task in one will run in the other.  If that's what you want,
   then go for it.
 * Tasks left attached to cpusets higher up in the hierarchy don't get
   moved or load balanced between partitioned sched domains below their cpuset.
   They will get stuck in one of the domains, willy-nilly.  So if it matters
   to you in the slightest which of the partitions a task runs in, attach
   it appropriately, to one of the cpusets that define the partitioned
   scheduler domains, or below.

In short, perhaps you were trying to make my life, or at least my efforts
to understand this, simple, by telling me that I simply can't have any
cpusets above partitioned sched domains.  The literal translation of that
into cpuset-speak throws out the entire cpuset architecture.  So I have to
push back and figure out in more detail what really matters here.

Am I anywhere close?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
