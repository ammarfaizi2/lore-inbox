Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWBHSdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWBHSdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWBHSdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:33:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64459 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030439AbWBHSdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:33:31 -0500
Date: Wed, 8 Feb 2006 10:33:23 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
Message-Id: <20060208103323.7ba3709e.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of comments ...

It took me an extra couple of passes to understand this code.

I wonder if the following, essentially equivalent (if I didn't
break something - never tested this) is easier to understand:

#ifdef CONFIG_NUMA
		/*
		 * In the NUMA case we may have gotten here because the
		 * memory policies or cpusets have restricted the allocation.
		 */
		{
			nodemask_t nodes;	/* compute nodes not allowd */

			nodes = node_online_map;
			for (z = zonelist->zones; *z; z++)
				if (cpuset_zone_allowed(*z, gfp_mask))
					node_clear((*z)->zone_pgdat->node_id,
							nodes);
			/*
			 * If there are any nodes left set in 'nodes', these
			 * are nodes the cpuset or mempolicy settings aren't
			 * letting us use.  In that case, return NULL to the
			 * current task, rather than invoking out_of_memory()
			 * on the system.
			 */
			if (!nodes_empty(nodes))
				return NULL;
		}
#endif

Second point - I thought I had already throttled the oom_killer
to some degree, with the lines, in mm/oom_kill.c select_bad_process():

                /* If p's nodes don't overlap ours, it won't help to kill p. */
                if (!cpuset_excl_nodes_overlap(p))
                        continue;

What your patch is doing affectively disables the oom_killer for
big numa systems, rather than having it operate within the set
of tasks using overlapping resources.

Do we need this more radical constraint on the oom_killer?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
