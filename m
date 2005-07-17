Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVGQPUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVGQPUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 11:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVGQPUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 11:20:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13970 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261302AbVGQPUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 11:20:37 -0400
Date: Sun, 17 Jul 2005 08:20:00 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
Message-Id: <20050717082000.349b391f.pj@sgi.com>
In-Reply-To: <20050715131610.25c25c15.akpm@osdl.org>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050715150034.GA6192@infradead.org>
	<20050715131610.25c25c15.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, replying to Christoph, about CKRM:
> What, in your opinion, makes it "obviously unmergeable"?

Thanks to some earlier discussions on the relation of CKRM with
cpusets, I've spent some time looking at CKRM.  I'm not Christoph,
but perhaps my notes will be of some use in this matter.

CKRM is big, it's difficult for us mere mortals to understand, and it
has attracted only limited review - inadequate review in proportion
to its size and impact.  I tried, and failed, sometime last year to
explain some of what I found difficult to grasp of CKRM to the folks
doing it.  See further an email thread entitled:

    Classes: 1) what are they, 2) what is their name?
    http://sourceforge.net/mailarchive/forum.php?thread_id=5328162&forum_id=35191

on the ckrm-tech@lists.sourceforge.net email list between Aug 14 and
Aug 27, 2004

As to its size, CKRM is in a 2.6.5 variant of SuSE that I happen to be
building just now for other reasons.  The source files that have 'ckrm'
in the pathname, _not_ counting Doc files, total 13044 lines of text.
The CONFIG_CKRM* config options add 144 Kbytes to the kernel text.

The CKRM patches in 2.6.13-rc3-mm1 are similar in size.  These patch
files total 14367 lines of text.

It is somewhat intrusive in the areas it controls, such as some large
ifdef's in kernel/sched.c.

The sched hooks may well impact the cost of maintaining the sched code,
which is always a hotbed of Linux kernel development.  However others
who work in that area will have to speak to that concern.

I tried just now to read through the ckrm hooks in fork, to see
what sort of impact they might have on scalability on large systems.
But I gave up after a couple layers of indirection.  I saw several
atomic counters and a couple of spinlocks that I suspect (not at all
sure) lay on the fork main code path.  I'd be surprised if this didn't
impact scalability.  Earlier, according to my notes, I saw mention of
lmbench results in the OLS 2004 slides, indicating a several percent
cost of available cpu cycles.

A feature of this size and impact needs to attract a fair bit of
discussion, because it is essential to a variety of people, or because
it is intriguing in some other way.

I suspect that the main problem is that this patch is not a mainstream
kernel feature that will gain multiple uses, but rather provides
support for a specific vendor middleware product used by that
vendor and a few closely allied vendors.  If it were smaller or
less intrusive, such as a driver, this would not be a big problem.
That's not the case.

The threshold of what is sufficient review needs to be set rather high
for such a patch, quite a bit higher than I believe it has obtained
so far.  It will not be easy for them to obtain that level of review,
until they get better at arousing the substained interest of other
kernel developers.

There may well be multiple end users and applications depending on
CKRM, but I have not been able to identify how many separate vendors
provide middleware that depends on CKRM.  I am guessing that only one
vendor has a serious middleware software product that provides full
CKRM support.  Acceptance of CKRM would be easier if multiple competing
middleware vendors were using it.  It is also a concern that CKRM
is not really usable for its primary intended purpose except if it
is accompanied by this corresponding middleware, which I presume is
proprietary code.  I'd like to see a persuasive case that CKRM is
useful and used on production systems not running substantial sole
sourced proprietary middleware.

The development and maintenance costs so far of CKRM appear (to
this outsider) to have been substantial, which suggests that the
maintenance costs of CKRM once in the kernel would be non-trivial.
Given the size of the project, its impact on kernel code, and the
rather limited degree to which developers outside of the CKRM project
have participated in CKRM's development or review, this could either
leave the Linux kernel overly dependent on one vendor for maintaining
CKRM, or place an undo maintenance burden on other kernel developers.

CKRM is in part a generalization and descendent of what I call fair
share schedulers.  For example, the fork hooks for CKRM include a
forkrates controller, to slow down the rate of forking of tasks using
too much resources.

No doubt the CKRM experts are already familiar with these, but for
the possible benefit of other readers:

  UNICOS Resource Administration - Chapter 4. Fair-share Scheduler
  http://oscinfo.osc.edu:8080/dynaweb/all/004-2302-001/@Generic__BookTextView/22883

  SHARE II -- A User Administration and Resource Control System for UNIX
  http://www.c-side.com/c/papers/lisa-91.html

  Solaris Resource Manager White Paper
  http://wwws.sun.com/software/resourcemgr/wp-mixed/

  ON THE PERFORMANCE IMPACT OF FAIR SHARE SCHEDULING
  http://www.cs.umb.edu/~eb/goalmode/cmg2000final.htm

  A Fair Share Scheduler, J. Kay and P. Lauder
  Communications of the ACM, January 1988, Volume 31, Number 1, pp 44-55.

The documentation that I've noticed (likely I've missed something)
doesn't do an adequate job of making the case - providing the
motivation and context essential to understanding this patch set.

Because CKRM provides an infrastructure for multiple controllers
(limiting forks, memory allocation and network rates) and multiple
classifiers and policies, its critical interfaces have rather
generic and abstract names.  This makes it difficult for others to
approach CKRM, reducing the rate of peer review by other Linux kernel
developers, which is perhaps the key impediment to acceptance of CKRM.
If anything, CKRM tends to be a little too abstract.

Inclusion of diffstat output would help convey to others the scope
of the patchset.

My notes from many months ago indicate something about a 128 CPU
limit in CKRM.  I don't know why, nor if it still applies.  It is
certainly a smaller limit than the systems I care about.

A major restructuring of this patch set could be considered,  This
might involve making the metric tools (that monitor memory, fork
and network usage rates per task) separate patches useful for other
purposes.  It might also make the rate limiters in fork, alloc and
network i/o separately useful patches.  I mean here genuinely useful
and understandable in their own right, independent of some abstract
CKRM framework.

Though hints have been dropped, I have not seen any public effort to
integrate CKRM with either cpusets or scheduler domains or process
accounting.  By this I don't mean recoding cpusets using the CKRM
infrastructure; that proposal received _extensive_ consideration
earlier, and I am as certain as ever that it made no sense.  Rather I
could imagine the CKRM folks extending cpusets to manage resources
on a per-cpuset basis, not just on a per-task or task class basis.
Similarly, it might make sense to use CKRM to manage resources on
a per-sched domain basis, and to integrate the resource tracking
of CKRM with the resource tracking needs of system accounting.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
