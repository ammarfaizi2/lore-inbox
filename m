Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUFNPmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUFNPmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 11:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUFNPmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 11:42:13 -0400
Received: from ozlabs.org ([203.10.76.45]:43456 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263184AbUFNPmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 11:42:05 -0400
Date: Tue, 15 Jun 2004 01:36:38 +1000
From: Anton Blanchard <anton@samba.org>
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org
Subject: NUMA API observations
Message-ID: <20040614153638.GB25389@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andi,

I had a chance to test out the NUMA API on ppc64. I started with 64bit
userspace, I'll send on some 32/64bit compat patches shortly.

This machine is weird in that there are lots of nodes with no memory.
Sure I should probably not set those nodes online, but its a test setup
that is good for finding various issues (like node failover when one is
OOM).

As you can see only node 0 and 1 has memory:

# cat /proc/buddyinfo
Node 1, zone  DMA  0   53  62  22  1  0  1  1  1  1  0  0  0  1  60
Node 0, zone  DMA  136 18   5   1  2  1  0  1  0  1  1  0  0  0  59

# numastat
            node7  node6  node5  node4  node3  node2  node1   node0
numa_hit        0      0      0      0      0      0  30903 2170759
numa_miss       0      0      0      0      0      0      0       0
numa_foreign    0      0      0      0      0      0      0       0
interleave_hit  0      0      0      0      0      0    715     835
local_node      0      0      0      0      0      0  28776 2170737
other_node      0      0      0      0      0      0   2127      22

Now if I try and interleave across all, the task gets OOM killed:

# numactl --interleave=all /bin/sh
Killed

in dmesg: VM: killing process sh

It works if I specify the nodes with memory:

# numactl --interleave=0,1 /bin/sh

Is this expected or do we want it to fallback when there is lots of
memory on other nodes?

A similar scenario happens with:

# numactl --preferred=7 /bin/sh
Killed

in dmesg: VM: killing process numactl

The manpage says we should fallback to other nodes when the preferred
node is OOM.

numactl cpu affinity looks broken on big cpumask systems:

# numactl --cpubind=0 /bin/sh
sched_setaffinity: Invalid argument

sched_setaffinity(19470, 64,  { 0, 0, 0, 0, 0, 0, 2332313320, 534d50204d6f6e20 }) = -1 EINVAL (Invalid argument)

My kernel is compiled with NR_CPUS=128, the setaffinity syscall must be
called with a bitmap at least as big as the kernels cpumask_t. I will
submit a patch for this shortly.

Next I looked at the numactl --show info:

# numactl --show
policy: default
preferred node: 0
interleavemask:
interleavenode: 0
nodebind: 0 1 2 3
membind: 0 1 2 3 4 5 6 7

Whats the difference between nodebind and membind? Why dont i see all 8
nodes on both of them? I notice if I do membind=all then I only see
the nodes with memory:

# numactl --membind=all --show
policy: bind
preferred node: 0
interleavemask:
interleavenode: 0
nodebind: 0 1 2 3
membind: 0 1

That kind of makes sense, but I dont understand why we have 4 nodes in
the nodebind field. My cpu layout is not contiguous, perhaps thats why
nodebind comes out strange:

processor       : 0
processor       : 1
processor       : 2
processor       : 3
processor       : 16
processor       : 17
processor       : 18
processor       : 19

Anton
