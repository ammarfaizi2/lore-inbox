Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUJGI5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUJGI5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 04:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUJGI5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 04:57:21 -0400
Received: from zeus.kernel.org ([204.152.189.113]:5251 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267344AbUJGI4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 04:56:02 -0400
Date: Thu, 7 Oct 2004 01:51:07 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: mbligh@aracnet.com, Simon.Derr@bull.net, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041007015107.53d191d4.pj@sgi.com>
In-Reply-To: <1097103580.4907.84.camel@arrakis>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	<58780000.1097004886@flay>
	<20041005172808.64d3cc2b.pj@sgi.com>
	<1193270000.1097025361@[10.10.2.4]>
	<20041005190852.7b1fd5b5.pj@sgi.com>
	<1097103580.4907.84.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see what non-exclusive cpusets buys us.

One can nest them, overlap them, and duplicate them ;)

For example, we could do the following:

 * Carve off CPUs 128-255 of a 256 CPU system in which
   to run various HPC jobs, requiring numbers of CPUs.
   This is named /dev/cpuset/hpcarena, and it is the really
   really exclusive and isolated sort of cpuset which can and
   does have its own scheduler domain, for a scheduler configuration
   that is tuned for running a mix of HPC jobs.  In this hpcarena
   also runs the per-cpu kernel threads that are pinned on CPUs
   128-255 (for _all_ tasks running on an exclusive cpuset
   must be in that cpuset or below).

 * The testing group gets half of this cpuset each weekend, in
   order to run a battery of tests: /dev/cpuset/hpcarena/testing.
   In this testing cpuset runs the following batch manager.

 * They run a home brew batch manager, which takes an input
   stream of test cases, carves off a small cpuset of the
   requested size, and runs that test case in that cpuset.
   This results in cpusets with names like:
   /dev/cpuset/hpcarena/testing/test123.  Our test123 is
   running in this cpuset.

 * Test123 here happens to be a test of the integrity of cpusets,
   so sets up a couple of cpusets to run two independent jobs,
   each a 2 CPU MPI job.  This results in the cpusets:
   /dev/cpuset/hpcarena/testing/test123/a and
   /dev/cpuset/hpcarena/testing/test123/b.  Our little
   MPI jobs 'a' and 'b' are running in these two cpusets.

We now have several nested cpusets, each overlapping its ancestors,
with tasks in each cpuset.

But only the top hpcarena cpuset has the exclusive ownership
with no form of overlap of everything in its subtree that
something like a distinct scheduler domain wants.

Hopefully the above is not what you meant by "little more than a
convenient way to group tasks."


> 2) rewrite the scheduler/allocator to deal with these bindings up front,
> and take them into consideration early in the scheduling/allocating
> process.

The allocator is less stressed here by varied mems_allowed settings
than is the scheduler.  For in 99+% of the cases, the allocator is
dealing with a zonelist that has the local (currently executing)
first on the zonelist, and is dealing with a mems_allowed that allows
allocation on the local node.  So the allocator almost always succeeds
the first time it goes to see if the candidate page it has in hand
comes from a node allowed in current->mems_allowed.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
