Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUJFAdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUJFAdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUJFAdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:33:03 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32689 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266511AbUJFAbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 20:31:06 -0400
Date: Tue, 5 Oct 2004 17:28:08 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Simon.Derr@bull.net, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041005172808.64d3cc2b.pj@sgi.com>
In-Reply-To: <58780000.1097004886@flay>
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
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> Nope - personally I see us more headed for the exclusive cpusets, and
> handle the non-exclusive stuff via a more CKRM-style mechanism.

As Simon said, no go.

Martin:

 1) Are you going to prevent sched_setaffinity calls as well?
    What about the per-cpu kernel threads?

    See my reply to Hubertus on this thread:

	Date: Tue, 5 Oct 2004 07:20:48 -0700
	Message-Id: <20041005072048.16632106.pj@sgi.com>

 2) Do you have agreement from the LSF and PBS folks that they
    can port to systems that support "shares" (the old Cray
    term roughly equivalent to CKRM), but lacking placement
    for jobs using shared resources?  I doubt it.

 3) Do you understand that OpenMP and MPI applications can really
    need placement, in order to get separate threads on separate
    CPUs, to allow concurrent execution, even when they aren't using
    (or worth providing) 100% of each CPU they are on.

 4) Continuing on item (1), I think that CKRM is going to have to
    deal with varying, detailed placement constraints, such as is
    presently implemented using a variety of settings of cpus_allowed
    and mems_allowed.  So too will schedulers and allocators.  We can
    setup a few, high level domains, that correspond to entire cpuset
    subtrees, that have closer to the exclusive properties that
    you want (stronger than the current cpuset exclusive flag ensures).
    But within any of those domains, we need a mix of exclusive
    and non-exclusive placement.

The CKRM controlled shares style of mechanism is appropriate when
one CPU cycle is as good as another, and one just needs to manage
what share of the total capacity a given class of users receive.

There are other applications, such as OpenMP and MPI applications with
closely coupled parallel threads, that require placement, including in
setups where that application doesn't get a totally isolated exclusive
'soft' partition of its own.  If an OpenMP or MPI job doesn't have each
separate thread placed on a distinct CPU, it runs like crud.  This is
so whether the job has its own dedicated cpuset, or it is sharing CPUs.

And there are important system management products, such as OpenPBS and
LSF, which rely on placement of jobs in named sets of CPUs and Memory
Nodes, both for jobs that are closely coupled parallel and jobs that are
not, both for jobs that have exclusive use of the CPUs and Memory Nodes
assigned to them and not.

CKRM cannot make these other usage patterns and requirements go away,
and even if it could force cpusets to only come in the totally isolated
flavor, CKRM would still have to deal with the placement that occurs
on a thread-by-thread basis that is essential to the performance of
tightly coupled thread applications and essential to the basic function
of certain per-cpu kernel threads.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
