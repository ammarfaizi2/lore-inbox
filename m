Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbTEUKQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 06:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTEUKQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 06:16:13 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:17313 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261847AbTEUKQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 06:16:11 -0400
Date: Wed, 21 May 2003 16:01:56 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       David Mosberger-Tang <davidm@hpl.hp.com>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>
Subject: Re: [PATCH 4/3] Replace dynamic percpu implementation
Message-ID: <20030521103156.GB2861@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030520043332.E80372C09D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030520043332.E80372C09D@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 02:32:37PM +1000, Rusty Russell wrote:
> This requires the first three patches.  IA64 untested.  See comment.
> 
> Name: Dynamic per-cpu allocation using static per-cpu mechanism
> Author: Rusty Russell
> Status: Tested on 2.5.69-bk13
> Depends: Misc/kmalloc_percpu-interface.patch.gz
> 
> D: This patch replaces the dynamic per-cpu allocator, alloc_percpu,
> D: to make it use the same mechanism as the static per-cpu variables, ie.
> D: ptr + __per_cpu_offset[smp_processor_id()] gives the variable address.
> D: This allows it to be used in modules (following patch), and hopefully
> D: increases space and time efficiency of reference at the same time.
> D: It gets moved to its own (SMP-only) file: mm/percpu.c.

We will do some measurements with this but based on a large number
of measurements that Kiran had done earlier, we can see a couple of things -

1. Even though a percpu scheme using pointer arithmatic has one less memory
   reference, the globally shared offset table is often in the cache
   and therefore pointer arithmatic offers no added advantage.

2. Increased sharing of cacheline helps by reducing associativity misses.
   We see this by comparing an interlaced allocator where only same
   sized objects share blocks vs. the current static allocator. Sharing of
   blocks by differently sized objects also allow cache lines to be
   kept warm as more subsystems in the kernel access them.

Considering these results, this allocator seems to be a step in the right
direction.

Thanks
Dipankar
