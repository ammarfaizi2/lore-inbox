Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbVI3OWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbVI3OWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVI3OWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:22:18 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:39104 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030318AbVI3OWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:22:17 -0400
Date: Fri, 30 Sep 2005 07:21:44 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <simon.derr@bull.net>
Cc: kurosawa@valinux.co.jp, taka@valinux.co.jp, magnus.damm@gmail.com,
       dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 1/3] CPUMETER: add cpumeter framework to
 the CPUSETS
Message-Id: <20050930072144.7298ec3c.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0509301117500.28042@localhost.localdomain>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050927084905.7d77bdde.pj@sgi.com>
	<20050928062146.6038E70041@sv1.valinux.co.jp>
	<20050928000839.1d659bfb.pj@sgi.com>
	<20050928075331.0408A70041@sv1.valinux.co.jp>
	<20050928094932.43a1f650.pj@sgi.com>
	<20050929025328.E4BFC70046@sv1.valinux.co.jp>
	<Pine.LNX.4.58.0509301117500.28042@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good reply, Simon.  Thank-you.

My apologies for the delay in responding, Takahiro-san.

As I think Simon was saying, we can only guarantee to make available
to an application a certain amount of CPU cycles.  We cannot guarantee
that the application will use them.  Essentially, we can only guarantee
that some no -other- application will use them.

If a job of several tasks is running on a cpuset containing multiple
CPUs, and is guaranteed a certain percentage of those CPUs and
limited to some other percentage, then you've got a set of tasks
that altogether cannot use more than so much of those CPUs (the
meter_cpu_limit) and that will always have at least a certain amount
of those CPUs free and available for its use (the meter_cpu_guarantee).

If that job uses child cpusets to force some of its tasks on one of
those CPUs, and some other of its tasks on another of those CPUs,
that makes no difference whatsoever to the guarantees and limits in
the previous paragraph.  Those child cpusets should not have any
settings for m->guar or m->lim.  Your code must not just look in the
current tasks cpuset for guarantees and limits, because there might
not be any meter settings there.  Rather it must look up the cpuset
hierarchy, to find the nearest ancestor cpuset that has meter data.

Indeed, this might be the best reason to NOT do what I am suggesting.

With the current simple locking of cpusets (one global cpuset_sem),
and even with the improvements suggested by Roman that I hope soon
to writeup (two global locks - a semaphore and a spinlock), it might
be too expensive to do this now.  I am no scheduler guru, but I am
pretty sure that we do not want to take multiple global semaphores
for each task we examine on the hot path of the scheduler.

We probably need someone with more locking expertise than I have
(so far at least) to refine the cpuset locking enough to make this
practical.

So I think I have just talked myself out of asking you to allow
a metered cpuset, such as 1a in our example, to be split into
child cpusets.  Even if we could reach a shared understanding of
what that meant, it would be too slow.

So - metered cpusets may not have child cpusets, until someone
wants it enough to figure out how to make the locking efficient.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
