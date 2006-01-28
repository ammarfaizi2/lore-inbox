Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWA1Gl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWA1Gl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 01:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWA1Gl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 01:41:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8924 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932527AbWA1Gl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 01:41:28 -0500
Date: Fri, 27 Jan 2006 22:40:58 -0800
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: steiner@sgi.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       rml@novell.com
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-Id: <20060127224058.a12994f7.pj@sgi.com>
In-Reply-To: <20060128052355.GC18730@localhost.localdomain>
References: <20060127230659.GA4752@sgi.com>
	<20060127191400.aacb8539.pj@sgi.com>
	<20060128034241.GB18730@localhost.localdomain>
	<20060127205834.b5821a02.pj@sgi.com>
	<20060128052355.GC18730@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan, responding to pj, responding to Nathan:
> > Nathan wrote:
> > > Which is problematic, because cpuset_cpus_allowed ->
> > > guarantee_online_cpus restricts the task->cpus_allowed mask to cpus
> > > which happen to be online at the time of the call to
> > > sched_setaffinity.  If more cpus come online later, that task can't be
> > > migrated to them.
> > 
> > Well, sort of.
> > 
> > A task could always migrate - just because a sched_getaffinity
> > the task did in the past doesn't show a CPU as valid, doesn't stop
> > the task from asking to pin to that CPU now.
> 
> I was speaking of the setaffinity (not getaffinity) case -- I assumed
> this was what you were referring to since I couldn't find any calls to
> the cpuset code in the getaffinity path.


Oh dear ... and you said 'setaffinity' quite clearly.  Though
Jack's original post only dealt with getaffinity.

I think this discussion is getting quite confused, for which
I can take at least some of the credit.

You observe, correctly, that the call chain:
	sched_setaffinity
	cpuset_cpus_allowed
	guarantee_online_cpus
restricts a sched_setaffinity to CPUs online at the time of that
sched_setaffinity call.

However, I have no clue how you conclude from this that "If more cpus
come online later, that task can't be migrated to them."

At anytime that some system service or batch scheduler wants to
migrate a task to some different CPUs (whether or not those CPUs were
once offline), it can either attach that task to a different cpuset,
or change the 'cpus' of its current cpuset.

Then if it wants to properly keep that tasks placement relative to its
new cpuset, it can reissue a sched_setaffinity on that tasks behalf,
to again set that tasks cpus_allowed to the same, relative to the
containing cpuset, CPUs as before.

Nothing in the behaviour of sched_getaffinity, that Jack was
considering, nor in the behaviour of sched_setaffinity, that
you thought I must be considering, has any impact on which CPUs
a task can be migrated to.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
