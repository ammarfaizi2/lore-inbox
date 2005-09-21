Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVIUVZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVIUVZF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVIUVZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:25:05 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:31698 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964920AbVIUVZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:25:04 -0400
Message-ID: <4331CFA7.50104@cosmosbay.com>
Date: Wed, 21 Sep 2005 23:24:55 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>
Subject: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de> <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de> <433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com>
In-Reply-To: <43308324.70403@cosmosbay.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have reworked net/ipv4/ip_tables.c to boost its performance, and post three 
patches.

In oprofile results, ipt_do_table() was at the first position.
It is now at 6th position, using 1/3 of the CPU it was using before.
(Tests done on a dual Xeon i386 and a dual Opteron x86_64)

Short description :

1) No more central rwlock protecting each table (filter, nat, mangle, raw),
    but one lock per CPU. It avoids cache line ping pongs for each packet.

2) Loop unrollings and various code optimizations to reduce branches
    mispredictions.

3) NUMA aware allocation of memory (this part was posted earlier, but got some 
polishing problems)


Long description:

1) No more one rwlock_t protecting the 'curtain'

One major bottleneck on SMP machines is the fact that one rwlock
is taken in ipt_do_table() entry and exit. That 2 atomic operations are
the killer, and even if multiple readers can work together on the same table
(using read_lock_bh()), the cache line containing rwlock still must be
taken exclusively by each CPU at entry/exit of ipt_do_table().

As existing code already use separate copies of the data for each cpu, it is
very easy to convert the central rwlock to separate rwlocks, allocated
percpu (and NUMA aware).

When a cpu enters ipt_do_table(), it can locks its local copy, touching a
cache line that is not used by other cpus. Further operations are done on
'local' copy of the data.

When a sum of all counters must be done, we can write_lock each part at a
time, instead of locking all the parts, reducing the lock contention.

2) Loop unrolling

It seems that with current compilers and CFLAGS, the code from
ip_packet_match() is very bad, using lot of mispredicted conditional branches 
I made some patches and generated code on i386 and x86_64
is much better.

3) NUMA allocation.

Part of the performance problem we have with netfilter is memory allocation
is not NUMA aware, but 'only' SMP aware (ie each CPU normally touch
separate cache lines)

Even with small iptables rules, the cost of this misplacement can be high
  on common workloads.

Instead of using one vmalloc() area (located in the node of the iptables
process), we now allocate an area for each possible CPU, using NUMA policy
(MPOL_PREFERRED) so that memory should be allocated in the CPU's node
if possible.

If the size of ipt_table is small enough (less than one page), we use
kmalloc_node() instead of vmalloc(), to use less memory and less TLB entries)
in small setups.

Note1 : I also optimized get_counters(), using a SET_COUNTER() for the first 
cpu, avoiding a memset() and ADD_COUNTER() if SMP on other cpus.

Note2 : This patch depends on another patch that declares sys_set_mempolicy()
in include/linux/syscalls.h
( http://marc.theaimsgroup.com/?l=linux-kernel&m=112725288622984&w=2 )


Thank you
Eric Dumazet
