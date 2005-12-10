Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVLJAHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVLJAHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVLJAHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:07:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:746 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932521AbVLJAHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:07:01 -0500
Date: Fri, 9 Dec 2005 16:06:47 -0800
From: Paul Jackson <pj@sgi.com>
To: hawkes@sgi.com
Cc: nickpiggin@yahoo.com.au, dino@in.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, mingo@elte.hu, steiner@sgi.com,
       hawkes@sgi.com
Subject: Re: [PATCH] -mm tree: broken "dynamic sched domains" and "migration
 cost"
Message-Id: <20051209160647.275febe4.pj@sgi.com>
In-Reply-To: <20051209205454.18325.46768.sendpatchset@tomahawk.engr.sgi.com>
References: <20051209205454.18325.46768.sendpatchset@tomahawk.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (5) Besides, the migration cost between any two CPUs is something
>     that can be calculated once at boot time and remembered
>     thereafter.  I suspect the reason why the algorithm doesn't do
>     this is that an exhaustive NxN calculation will be very slow for
>     large NR_CPUS counts, which explains why the calculations are
>     now done in the context of sched domains.

Agreed - I too suspect that this a form of compression, both of
computation costs and data size.  We save space and time by not
calculating the full N * N matrix, where N is num_onlinecpus(), but
just the sched domain sub-matrices.

In theory, I would think that we should -not- compress based on sched
domains, because:
 1) these are (now becoming) dynamic, and
 2) they don't reflect the "natural" basis for such compression,
    which would be hardware topology based, not sched domain based.

Rather we should compress based on the topological symmetries of the
hardware system.  Of course, this is an ARCH specific characteristic,
or even platform specific.

Perhaps we could provide an ARCH specific routine that would map any
ordered pair <cpu0, cpu1> of cpu numbers to a canonical pair, such that
the canonical pairs were "about as far apart, for that system
topology", but potentially much fewer in number than the entire N * N
space, and a smaller maximum value of the largest cpu number returned.
The default routine would be the identify function, which would work
fine for ordinary sized systems.

A second ARCH specific routine would return the largest value M
canonical cpu number that would be returned by the above routine.
The distance array could be dynamically allocated to M**2 size.
The default routine would just return the highest online CPU number.

These 'canonical cpu pairs' would replace the sched domains as the
basis for compression.

Then one time at boot, for each possible pair of online cpus, map that
pair to its canonical pair, and if not already done, compute its
migration cost.  For example, if on the current systems topology, cpu
pairs <3,5> and <67,69> are pretty much the same distances apart, the
"canonical" pair for both these might be <3,5>, and only that pair
would have to be actually computed and stored.  Everytime the software
using this wanted results for <67,69>, it would get mapped to <3,5> for
resolution.

In the extreme case of a big NUMA system with an essentially homogeneous
topology (all cpu-cpu distances the same), all <cpu0, cpu1> pairs where
cpu- != cpu1, could be mapped to same canonical pair <0, 1>.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
