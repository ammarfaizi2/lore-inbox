Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUHKRzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUHKRzC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268143AbUHKRzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:55:01 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:61871 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268136AbUHKRwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:52:44 -0400
Date: Wed, 11 Aug 2004 10:50:57 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20040811105057.76f97ead.pj@sgi.com>
In-Reply-To: <10920000.1092235770@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<200408071722.36705.efocht@hpce.nec.com>
	<2447730000.1091976606@[10.10.2.4]>
	<200408111140.14466.efocht@hpce.nec.com>
	<10920000.1092235770@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> but they're still close enough, that especially when programming
> them in combination, it seems silly to have 2 separate interfaces. 

The specific attributes needed of CKRM classes are not the same as those
needed for cpusets.

The semantics of the two are distinct -- each has different rules that
have little relevance to the other.

The typical uses of the two have little overlap.  More often than not,
the applications that customers want to run in isolation in cpusets are
not the same as those which customers want to run while sharing compute
resources with a managed balance.

Any merger of two separate mechanisms has its costs - the result risks
being less focused, larger.  These costs must be balanced with what's
called (in Corporate mergers) "synergy".

Programming these two "in combination" simply means using CKRM to manage
resources for some tasks running in a cpuset.  Neither capability or
interface gains in such a use by attempting to merge it with the other.

I can imagine running multiple cpusets, say SetA, SetB, and SetC, using
Nodes 0..31, 32..63, and 64..127, respectively.  Within each, running
the same suite of applications, say a DBMS, web server and credit card
payment handler.  Serving within each three classes of customers: Gold
(corporate), Silver (logged in individuals) and Bronze (anonymous web
surfers).  This is naturally a 3x3 two-dimensional space, not a flat
space that's nine units wide.  The two dimensions are orthogonal here.

No, it is not silly to have 2 separate interfaces.  What's silly is to
presume that everything that seems similar at the 10,000 foot level
should be combined.

The details matter.  Show me the synergy.

Do we have trains that float and ships that roll?

Is there much of a market for a hammer-saw?

It is fitting and proper for kernels to provide independent mechanisms,
and let user space connect them as it will.  Look at the actual hooks
in the kernel code to implement these two facilities.  One hooks the
scheduler and allocator to prohibit running on CPUs outside the cpuset,
and to prohibit allocating memory on Nodes outside the cpuset.  The other
hooks these places, and others, to bias their decisions in order to obtain
the requested balance of resource usage.

These are two distinct sets of hooks, perhaps on the same page of code,
but distinct in placement, logic, means and intention.

Ideally, the kernel provides a single, separate, orthogonal interface to
each mechanism it supports.

If this were a case of proposing two interfaces to the same mechanism,
or what should be the same mechanism, then you'd be 100% right.  We
should merge them.

Perhaps the proper place to resolve this discussion in is a detailed
examination of the kernel hooks required for CKRM and cpusets, the
hooks in the scheduler, allocator and such.

You have both patches available to you.  Examine them.  Especially
examine the hooks in the scheduler and allocator code.  These are not
the same hooks.  I defy you to make them the same and propose such with
a straight face.  If you do so successfully, I will sit up and take
notice.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
