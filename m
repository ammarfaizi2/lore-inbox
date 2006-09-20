Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWITTsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWITTsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWITTsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:48:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32492 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932307AbWITTsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:48:39 -0400
Date: Wed, 20 Sep 2006 12:48:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: clameter@sgi.com, rohitseth@google.com, nickpiggin@yahoo.com.au,
       ckrm-tech@lists.sourceforge.net, devel@openvz.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920124813.fe160e71.pj@sgi.com>
In-Reply-To: <1158775586.28174.27.camel@lappy>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<4510D3F4.1040009@yahoo.com.au>
	<1158751720.8970.67.camel@twins>
	<4511626B.9000106@yahoo.com.au>
	<1158767787.3278.103.camel@taijtu>
	<451173B5.1000805@yahoo.com.au>
	<1158774657.8574.65.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201051550.31636@schroedinger.engr.sgi.com>
	<1158775586.28174.27.camel@lappy>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter wrote:
> > Which comes naturally with cpusets.
> 
> How are shared mappings dealt with, are pages charged to the set that
> first faults them in?

Cpusets does not attempt to manage how much memory a task can allocate,
but where it can allocate it.  If a task can find an existing page to
share, and avoid the allocation, then it entirely avoids dealing with
cpusets in that case.

Cpusets pays no attention to how often a page is shared.  It controls
which tasks can allocate a given free page, based on the node on which
that page resides.  If that node is allowed in a tasks 'nodemask_t
mems_allowed' (a task struct field), then the task can allocate
that page, so far as cpusets is concerned.

Cpusets does not care who links to a page, once it is allocated.

Every page is assigned to one specific node, and may only be allocated
by tasks allowed to allocate from that node.

These cpusets can overlap - which so far as memory goes, roughly means
that the various mems_allowed nodemask_t's of different tasks can overlap.

Here's an oddball example configuration that might make this easier to
think about.

    Let's say we have a modest sized NUMA system with an extra bank
    of memory added, in addition to the per-node memory.  Let's say
    the extra bank is a huge pile of cheaper (slower) memory, off a
    slower bus.

    Normal sized tasks running on one or more of the NUMA nodes just
    get to fight for the CPUs and memory on those nodes allowed them.

    Let's say an occassional big memory job is to be allowed to use
    some of the extra cheap memory, and we use the idea of Andrew
    and others to split that memory into fake nodes to manage the
    portion of memory available to specified tasks.

    Then one of these big jobs could be in a cpuset that let it use
    one or more of the CPUs and memory on the node it ran on, plus
    some number of the fake nodes on the extra cheap memory.

    Other jobs could be allowed, using cpusets, to use any combination
    of the same or overlapping CPUs or nodes, and/or other disjoint
    CPUs or nodes, fake or real.

Another example, restating some of the above.

    If say some application happened to fault in a libc.so page,
    it would be required to place that page on one of the nodes
    allowed to it.  If an other application comes along later and
    ends up wanting shared references to that same page, it could
    certainly do so, regardless of its cpuset settings.  It would
    not be allocating a new page for this, so would not encounter
    the cpuset constraints on where it could allocate such a page.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
