Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUDFNdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbUDFNdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:33:31 -0400
Received: from ns.suse.de ([195.135.220.2]:49048 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263807AbUDFNdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:33:24 -0400
Date: Tue, 6 Apr 2004 15:33:22 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: NUMA API for Linux
Message-Id: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patches add support for configurable NUMA memory policy
for user processes. It is based on the proposal from last kernel summit
with feedback from various people.

This NUMA API doesn't not attempt to implement page migration or anything
else complicated: all it does is to police the allocation when a page 
is first allocation or when a page is reallocated after swapping. Currently
only support for shared memory and anonymous memory is there; policy for 
file based mappings is not implemented yet (although they get implicitely
policied by the default process policy)

It adds three new system calls: mbind to change the policy of a VMA,
set_mempolicy to change the policy of a process, get_mempolicy to retrieve
memory policy. User tools (numactl, libnuma, test programs, manpages) can be 
found in  ftp://ftp.suse.com/pub/people/ak/numa/numactl-0.6.tar.gz

For details on the system calls see the manpages
http://www.firstfloor.org/~andi/mbind.html
http://www.firstfloor.org/~andi/set_mempolicy.html
http://www.firstfloor.org/~andi/get_mempolicy.html
Most user programs should actually not use the system calls directly,
but use the higher level functions in libnuma 
(http://www.firstfloor.org/~andi/numa.html) or the command line tools
(http://www.firstfloor.org/~andi/numactl.html

The system calls allow user programs and administors to set various NUMA memory 
policies for putting memory on specific nodes. Here is a short description
of the policies copied from the kernel patch:

 * NUMA policy allows the user to give hints in which node(s) memory should
 * be allocated.
 *
 * Support four policies per VMA and per process:
 *
 * The VMA policy has priority over the process policy for a page fault.
 *
 * interleave     Allocate memory interleaved over a set of nodes,
 *                with normal fallback if it fails.
 *                For VMA based allocations this interleaves based on the
 *                offset into the backing object or offset into the mapping
 *                for anonymous memory. For process policy an process counter
 *                is used.
 * bind           Only allocate memory on a specific set of nodes,
 *                no fallback.
 * preferred      Try a specific node first before normal fallback.
 *                As a special case node -1 here means do the allocation
 *                on the local CPU. This is normally identical to default,
 *                but useful to set in a VMA when you have a non default
 *                process policy.
 * default        Allocate on the local node first, or when on a VMA
 *                use the process policy. This is what Linux always did
 *                in a NUMA aware kernel and still does by, ahem, default.
 *
 * The process policy is applied for most non interrupt memory allocations
 * in that process' context. Interrupts ignore the policies and always
 * try to allocate on the local CPU. The VMA policy is only applied for memory
 * allocations for a VMA in the VM.
 *
 * Currently there are a few corner cases in swapping where the policy
 * is not applied, but the majority should be handled. When process policy
 * is used it is not remembered over swap outs/swap ins.
 *
 * Only the highest zone in the zone hierarchy gets policied. Allocations
 * requesting a lower zone just use default policy. This implies that
 * on systems with highmem kernel lowmem allocation don't get policied.
 * Same with GFP_DMA allocations.
 *
 * For shmfs/tmpfs/hugetlbfs shared memory the policy is shared between
 * all users and remembered even when nobody has memory mapped.

The following patches implement all this. 

I think these patches are ready for merging in -mm*.

-Andi
