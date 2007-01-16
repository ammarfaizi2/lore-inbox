Return-Path: <linux-kernel-owner+w=401wt.eu-S1751363AbXAPJZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXAPJZi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 04:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXAPJZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 04:25:38 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:44428 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751363AbXAPJZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 04:25:37 -0500
Date: Tue, 16 Jan 2007 01:25:09 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, menage@google.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, ak@suse.de, dgc@sgi.com,
       clameter@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
Message-Id: <20070116012509.145ead36.pj@sgi.com>
In-Reply-To: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> Currently cpusets are not able to do proper writeback since
> dirty ratio calculations and writeback are all done for the system
> as a whole.

Thanks for tackling this - it is sorely needed.

I'm afraid my review will be mostly cosmetic; I'm not competent
to comment on the really interesting stuff.

> If we are in a cpuset then we select only inodes for writeback
> that have pages on the nodes of the cpuset.

Sorry - you tripped over a subtle distinction that happens to be on my
list of things to notice.

When cpusets are configured, -all- tasks are in a cpuset.  And
(correctly so, I trust) this patch doesn't look into the tasks cpuset
to see what nodes it allows.  Rather it looks to the mems_allowed field
in the task struct, which is equal to or (when set_mempolicy is used) a
subset of that tasks cpusets allowed nodes.

Perhaps the following phrasing would be more accurate:

  If CPUSETs are configured, then we select only the inodes for
  writeback that have dirty pages on that tasks mems_allowed nodes.

> Secondly we modify the dirty limit calculation to be based
> on the acctive cpuset.

As above, perhaps the following would be more accurate:

  Secondly we modify the dirty limit calculation to be based
  on the current tasks mems_allowed nodes.

> 1. The nodemask expands the inode structure significantly if the
> architecture allows a high number of nodes. This is only an issue
> for IA64. 

Should that logic be disabled if HOTPLUG is configured on?  Or is
nr_node_ids a valid upper limit on what could be plugged in, even on a
mythical HOTPLUG system?

> 2. The calculation of the per cpuset limits can require looping
> over a number of nodes which may bring the performance of get_dirty_limits
> near pre 2.6.18 performance

Could we cache these limits?  Perhaps they only need to be recalculated if
a tasks mems_allowed changes?

Separate question - what happens if a tasks mems_allowed changes while it is
dirtying pages?  We could easily end up with dirty pages on nodes that are
no longer allowed to the task.  Is there anyway that such a miscalculation
could cause us to do harmful things?

In patch 2/8:
> The dirty map is cleared when the inode is cleared. There is no
> synchronization (except for atomic nature of node_set) for the dirty_map. The
> only problem that could be done is that we do not write out an inode if a
> node bit is not set.

Does this mean that a dirty page could be left 'forever' in memory, unwritten,
exposing us to risk of data corruption on disk, from some write done weeks ago,
but unwritten, in the event of say a power loss?

Also in patch 2/8:
> +static inline void cpuset_update_dirty_nodes(struct inode *i,
> +		struct page *page) {}

Is an incomplete 'struct inode;' declaration needed here in cpuset.h,
to avoid a warning if compiling with CPUSETS not configured?

In patch 4/8:
> We now add per node information which I think is equal or less effort
> since there are less nodes than processors.

Not so on Paul Menage's fake NUMA nodes - he can have say 64 fake nodes on
a system with 2 or 4 CPUs and one real node.  But I guess that's ok ...

In patch 4/8:
> +#ifdef CONFIG_CPUSETS
> +	/*
> +	 * Calculate the limits relative to the current cpuset if necessary.
> +	 */
> +	if (unlikely(nodes &&
> +			!nodes_subset(node_online_map, *nodes))) {
> +		int node;
> +
> +		is_subset = 1;
> +		...
> +#ifdef CONFIG_HIGHMEM
> +			high_memory += NODE_DATA(node)
> +				->node_zones[ZONE_HIGHMEM]->present_pages;
> +#endif
> +			nr_mapped += node_page_state(node, NR_FILE_MAPPED) +
> +					node_page_state(node, NR_ANON_PAGES);
> +		}
> +	} else
> +#endif
> +	{

I'm wishing there was a clearer way to write the above code.  Nested
ifdef's and an ifdef block ending in an open 'else' and perhaps the first
#ifdef CONFIG_CPUSETS ever, outside of fs/proc/base.c ...

However I have no clue if such a clearer way exists.  Sorry.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
