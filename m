Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263763AbUEGUvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUEGUvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUEGUvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:51:23 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:50007 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263763AbUEGUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:50:19 -0400
Date: Fri, 7 May 2004 15:49:38 -0500
From: Jack Steiner <steiner@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040507204938.GA27428@sgi.com>
References: <20040501120805.GA7767@sgi.com> <20040501211704.GY1445@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501211704.GY1445@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, May 01, 2004 at 02:17:04PM -0700, William Lee Irwin III wrote:
> On Sat, May 01, 2004 at 07:08:05AM -0500, Jack Steiner wrote:
> > On a 512p idle 2.6.5 system, each cpu spends ~6% of the time in the kernel
> > RCU code. The time is spent contending for shared cache lines.
> 
> Would something like this help cacheline contention? This uses the
> per_cpu data areas to hold per-cpu booleans for needing switches.
> Untested/uncompiled.
> 
> The global lock is unfortunately still there.
> 
> 
> -- wli
> 
...
>  
> +#if RCU_CPU_SCATTER
> +#define rcu_need_switch(cpu)		(!!atomic_read(&per_cpu(rcu_data, cpu).need_switch))
> +#define rcu_clear_need_switch(cpu)	atomic_set(&per_cpu(rcu_data, cpu).need_switch, 0)
> +static inline int rcu_any_cpu_need_switch(void)
> +{
> +	int cpu;
> +	for_each_online_cpu(cpu) {
> +		if (rcu_need_switch(cpu))
> +			return 1;
> +	}
> +	return 0;
> +}
..

This fixes only part of the problem.

Referencing percpu data for every cpu is not particularily efficient - at
least on our platform.  Percpu data is allocated so that it is on the 
local node of each cpu.

We use 64MB granules. The percpu data structures on the individual nodes 
are separated by addresses that differ by many GB. A scan of all percpu 
data structures requires a TLB entry for each node.  This is costly & 
trashes the TLB.  (Our max system size is currently 256 nodes).


For example, a 4 node, 2 cpus/node system shows:

	mdb> m d __per_cpu_offset
        <0xa000000100b357c8> 0xe000003001010000
        <0xa000000100b357d0> 0xe000003001020000
        <0xa000000100b357d8> 0xe00000b001020000
        <0xa000000100b357e0> 0xe00000b001030000
        <0xa000000100b357e8> 0xe000013001030000
        <0xa000000100b357f0> 0xe000013001040000
        <0xa000000100b357f8> 0xe00001b001040000
        <0xa000000100b35800> 0xe00001b001050000

The node number is encoded in bits [48:39] of the virtual/physical
address.

Unfortunately, our hardware does not provide a way to allocate node
local memory for every node and have all the memory covered by a single
TLB entry.


Moving "need_switch" to a single array with cacheline aligned
entries would work. I can give that a try.....



	
-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


