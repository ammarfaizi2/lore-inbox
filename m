Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVDWDP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVDWDP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 23:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVDWDP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 23:15:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32161 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261405AbVDWDPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 23:15:17 -0400
Date: Fri, 22 Apr 2005 20:11:45 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets (v0.2)
Message-Id: <20050422201145.2516a326.pj@sgi.com>
In-Reply-To: <20050421173135.GB4200@in.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050421173135.GB4200@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar's patch contains:
+	/* Make the change */
+	par->cpus_allowed = t.cpus_allowed;
+	par->isolated_map = t.isolated_map;

Doesn't the above make changes to the parent cpus_allowed without
calling validate_change()?  Couldn't we do nasty things like
empty that cpus_allowed, leaving tasks in that cpuset starved
(or testing the last chance code that scans up the cpuset
hierarchy looking for a non-empty cpus_allowed)?

What prevents all the immediate children of the top cpuset from
using up all the cpus as isolated cpus, leaving the top cpuset
cpus_allowed empty, which fails even that last chance check,
going to the really really last chance code, allowing any online
cpu to tasks in that cpuset?

These questions are in addition to my earlier question:

    Why don't you need to propogate upward this change to
    the parents cpus_allowed and isolated_map?  If a parents
    isolated_map grows (or shrinks), doesn't that affect every
    ancestor, all the way to the top cpuset?

I am unable to tell, just from code reading, whether this code
has adequately worked through the details involved in properly
handling nested changes.

I am unable to build or test this on ia64, because you have code
such as the rebuild_sched_domains() routine, that is in the
'#else' half of a very large "#ifdef ARCH_HAS_SCHED_DOMAIN -
#else - #endif" section of kernel/sched.c, and ia64 arch (and
only that arch, so far as I know) defines ARCH_HAS_SCHED_DOMAIN,
so doesn't see this '#else' half.

+	/* 
+         * If current isolated cpuset has isolated children 
+         * disallow changes to cpu mask
+	 */
+	if (!cpus_empty(cs->isolated_map))
+		return -EBUSY;

1) spacing - there's 8 spaces, not a tab, on two of the lines above.
2) I can't tell yet - but I am curious as to whether the above restriction
   prohibiting cpu mask changes to a cpuset with isolated children
   might be a bit draconian.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
