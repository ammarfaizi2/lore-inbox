Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVDSQVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVDSQVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 12:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVDSQVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 12:21:04 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:15269 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261620AbVDSQUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 12:20:54 -0400
Date: Tue, 19 Apr 2005 09:19:39 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, dipankar@in.ibm.com, colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-Id: <20050419091939.55933186.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0504190955250.4587@openx3.frec.bull.fr>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<Pine.LNX.4.61.0504190955250.4587@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon wrote:
> I guess we hit a limit of the filesystem-interface approach here.
> Are the possible failure reasons really that complex ?

Given the amount of head scratching my proposal has provoked
so far, they might be that complex, yes.  Failure reasons
include:
 * The cpuset Foo whose domain_cpu_rebuild file we wrote does
   not align with the current partition of CPUs on the system
   (align: every subset of the partition is either within or
   outside the CPUs of Foo)
 * The cpusets Foo and its descendents which are marked with
   a true domain_cpu_pending do not form a partition of the
   CPUs in Foo.  This could be either because two of these
   cpusets have overlapping CPUs, or because the union of all
   the CPUs in these cpusets doesn't cover.
 * The usual other reasons such as lacking write permission.

> If this is only to get a hint, OK.

Yes - it would be a hint.  The official explanation would be the
errno setting on the failed write.  The hint, written to the
domain_cpu_error file, could actually state which two cpusets
had overlapping CPUs, or which CPUs in Foo were not covered by
the union of the CPUs in the marked descendent cpusets.

Yes - it pushing the limits of available mechanisms.  Though I don't
offhand see where the filesystem-interface approach is to blame here.
Can you describe any other approach that would provide such a similarly
useful error explanation in a less unusual fashion?

> Is such an error reporting scheme already in use in the kernel ?

I don't think so.

> On the other hand, there's also no guarantee that what we are triggering 
> by writing in domain_cpu_rebuild is what we have set up by writing in 
> domain_cpu_pending. User applications will need a bit of self-discipline.

True.

To preserve the invariant that the CPUs in the selected cpusets form a
partition (disjoint cover) of the systems CPUs, we either need to
provide an atomic operation that allows passing in a selection of
cpusets, or we need to provide a sequence of operations that essentially
drive a little finite state machine, building up a description of the
new state while the old state remains in place, until the final trigger
is fired.

This suggests what the primary alternative to my proposed API would be,
and that would be an interface that let one pass in a list of cpusets,
requesting that the partition below the specified cpuset subtree Foo be
completely and atomically rebuilt, to be that defined by the list of
cpusets, with the set of CPUS in each of these cpusets defining one
subset of the partition.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
