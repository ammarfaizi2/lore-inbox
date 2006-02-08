Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWBHUWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWBHUWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWBHUWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:22:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60033 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751140AbWBHUWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:22:36 -0500
Date: Wed, 8 Feb 2006 12:22:27 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: clameter@engr.sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
Message-Id: <20060208122227.3379643e.pj@sgi.com>
In-Reply-To: <200602082005.12657.ak@suse.de>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
	<Pine.LNX.4.62.0602081037240.3590@schroedinger.engr.sgi.com>
	<20060208105714.15bb4bb2.pj@sgi.com>
	<200602082005.12657.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the oom killer is of any use on a numa system using set_mempolicy,
mbind and/or cpusets, then it would be of use in the bootcpuset -- that
cpuset which is often setup to hold the classic Unix daemons.  I'm not
sure we want to do that.

If we changed the mm/oom_kill.c select_bad_process() constraint from

                /* If p's nodes don't overlap ours, it won't help to kill p. */
                if (!cpuset_excl_nodes_overlap(p))
                        continue;

which kills any task that has any overlap with nodes with the current task:

 1) to the much tighter limit of only killing tasks that are on the same or
    a subset of the same nodes, and

 2) changed it to look at -both- the cpuset and MPOL_BIND constraints,

then oom killer would work in a bootcpuset rather as it does now on
simple UMA systems.

The new logic would be -- only kill tasks that are constrained to
the same or a subset of the same nodes as the current task.

With this, the problem you describe with the oom killer and a task that
has used mbind or cpuset to just allow a single node would be fixed --
only tasks constrained to just that node, no more, would be considered
for killing.

At the same time, a typical bootcpuset would have oom killer behaviour
resembling what people have become accustomed to.

If we are going to neuter or eliminate the oom killer, it seems like
we should do it across the board, not just on numa boxes using
some form of memory constraint (mempolicy or cpuset).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
