Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTEGEpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTEGEpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:45:19 -0400
Received: from dp.samba.org ([66.70.73.150]:5528 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262850AbTEGEpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:45:17 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16056.37397.694764.303333@argo.ozlabs.ibm.com>
Date: Wed, 7 May 2003 14:56:53 +1000
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] kmalloc_percpu
In-Reply-To: <20030507042250.GX8978@holomorphy.com>
References: <20030506014745.02508f0d.akpm@digeo.com>
	<20030507023126.12F702C019@lists.samba.org>
	<20030507024135.GW8978@holomorphy.com>
	<16056.34210.319959.255815@argo.ozlabs.ibm.com>
	<20030507042250.GX8978@holomorphy.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:

> Same address mapped differently on different cpus is what I thought
> you meant. It does make sense, and besides, it only really matters
> when the thing is being switched in, so I think it's not such a big
> deal. e.g. mark per-thread mm context with the cpu it was prepped for,
> if they don't match at load-time then reset the kernel pmd's pgd entry
> in the per-thread pgd at the top level. x86 blows away the TLB at the

Having to have a pgdir per thread would be a bit sucky, wouldn't it?

On PPCs with the hash-table based MMU, if we wanted to do different
mappings of the same address on different CPUs, we would have to have
a separate hash table for each CPU, which would chew up a lot of
memory.  On PPC64 machines with logical partitioning, I don't think
the hypervisor would let you have a separate hash table for each CPU.
On the flip side, PPC can afford a register to point to a per-cpu data
area more easily than x86 can.

> The vmallocspace bit is easier, though the virtualspace reservation
> could get uncomfortably large depending on how much is crammed in there.
> That can go node-local also. I guess it has some runtime arithmetic
> overhead vs. the per-cpu TLB entries in exchange for less complex code.

I was thinking of something like 64kB per cpu times 32 cpus = 2MB.
Anyway, 32-bit machines with > 8 cpus are a pretty rare corner case.
On 64-bit machines we have enough virtual space to give each cpu
gigabytes of per-cpu data if we want to.

Paul.
