Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbTEGFGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTEGFGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:06:51 -0400
Received: from holomorphy.com ([66.224.33.161]:9357 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262860AbTEGFGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:06:44 -0400
Date: Tue, 6 May 2003 22:19:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030507051901.GY8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Mackerras <paulus@samba.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com,
	linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20030506014745.02508f0d.akpm@digeo.com> <20030507023126.12F702C019@lists.samba.org> <20030507024135.GW8978@holomorphy.com> <16056.34210.319959.255815@argo.ozlabs.ibm.com> <20030507042250.GX8978@holomorphy.com> <16056.37397.694764.303333@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16056.37397.694764.303333@argo.ozlabs.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> Same address mapped differently on different cpus is what I thought
>> you meant. It does make sense, and besides, it only really matters
>> when the thing is being switched in, so I think it's not such a big
>> deal. e.g. mark per-thread mm context with the cpu it was prepped for,
>> if they don't match at load-time then reset the kernel pmd's pgd entry
>> in the per-thread pgd at the top level. x86 blows away the TLB at the

On Wed, May 07, 2003 at 02:56:53PM +1000, Paul Mackerras wrote:
> Having to have a pgdir per thread would be a bit sucky, wouldn't it?

Not as bad as it initially sounds; on non-PAE i386, it's 4KB and would
hurt. On PAE i386, it's 32B and can be shoehorned, say, in thread_info.
Then the rest is just a per-cpu kernel pmd and properly handling vmalloc
faults (which are already handled properly for non-PAE vmallocspace).
There might be other reasons to do it, like reducing the virtualspace
overhead of the atomic kmap area, but it's not really time yet.


On Wed, May 07, 2003 at 02:56:53PM +1000, Paul Mackerras wrote:
> On PPCs with the hash-table based MMU, if we wanted to do different
> mappings of the same address on different CPUs, we would have to have
> a separate hash table for each CPU, which would chew up a lot of
> memory.  On PPC64 machines with logical partitioning, I don't think
> the hypervisor would let you have a separate hash table for each CPU.
> On the flip side, PPC can afford a register to point to a per-cpu data
> area more easily than x86 can.

Well, presumably it'd have to be abstracted so the mechanism isn't
exposed to core code if ever done. The arch code insulation appears to
be there to keep one going, though not necessarily accessors. Probably
the only reason to seriously think about it is that the arithmetic
shows up as a disincentive on the register-starved FPOS's I'm stuck on.


William Lee Irwin III writes:
>> The vmallocspace bit is easier, though the virtualspace reservation
>> could get uncomfortably large depending on how much is crammed in there.
>> That can go node-local also. I guess it has some runtime arithmetic
>> overhead vs. the per-cpu TLB entries in exchange for less complex code.

On Wed, May 07, 2003 at 02:56:53PM +1000, Paul Mackerras wrote:
> I was thinking of something like 64kB per cpu times 32 cpus = 2MB.
> Anyway, 32-bit machines with > 8 cpus are a pretty rare corner case.
> On 64-bit machines we have enough virtual space to give each cpu
> gigabytes of per-cpu data if we want to.

2MB vmallocspace is doable; it'd need to be bigger or per-something
besides cpus to hurt.


-- wli
