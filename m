Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269208AbUJEO0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269208AbUJEO0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269040AbUJEOXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:23:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59883 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269028AbUJEOXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 10:23:30 -0400
Date: Tue, 5 Oct 2004 07:20:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: matthltc@us.ibm.com, pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041005072048.16632106.pj@sgi.com>
In-Reply-To: <41625B9B.5010901@watson.ibm.com>
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
	<415F3D4C.6060907@watson.ibm.com>
	<1096946035.2673.769.camel@stark>
	<41625B9B.5010901@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus writes:
> Since classes can span different cpu sets with different shares
> how do we address the cpushare of a class in the particular context
> of a cpu-set.
> Alternatively, one could require that classes can not span different
> cpu-sets, which would significantly reduce the complexity of this.

It's not just cpusets that sets a tasks cpus_allowed ...

Lets say we have a 16 thread OpenMP application, running on a cpuset of
16 CPUs on a large system, one thread pinned to each CPU of the 16 using
sched_setaffinity, running exclusively there.  Which means that there
are perhaps eight tasks pinned on each of those 16 CPUs, the one OpenMP
thread, and perhaps seven indigenous per-cpu kernel threads:
    migration, ksoftirq, events, kblockd, aio, xfslogd and xfsdatad
(using what happens to be on a random 2.6 Altix in front of me).

Then the classe(s) containing the eight tasks on any given one of these
CPUs would be required to not contain any other tasks outside of those
eight, by your reduced complexity alternative, right?

On whom/what would this requirement be imposed?  Hopefully some CKRM
classification would figure this out and handle the classification
automatically.

What of the couple of "mother" tasks in this OpenMP application, which
are in this same 16 CPU cpuset, probably pinned to all 16 of the CPUs,
instead of to any individual one of them?  What are the requirements on
the classes to which these tasks belong, in relation to the above
classes for the per-cpu kthreads and per-cpu OpenMP threads?  And on
what person/software is the job of adapting to these requirements
imposed?

Observe by the way that so long as:
 1) the per-cpu OpenMP threads each get to use 99+% of their
    respective CPUs,
 2) CKRM didn't impose any constraints or work on anything else

then what CKRM does here doesn't matter.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
