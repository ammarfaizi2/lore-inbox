Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422735AbWA1AY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbWA1AY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422734AbWA1AY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:24:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422730AbWA1AY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:24:26 -0500
Date: Fri, 27 Jan 2006 16:26:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: dada1@cosmosbay.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables --
 proto.sockets_allocated
Message-Id: <20060127162611.5d160638.akpm@osdl.org>
In-Reply-To: <20060128000100.GD3565@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain>
	<20060126190357.GE3651@localhost.localdomain>
	<43D9DFA1.9070802@cosmosbay.com>
	<20060127195227.GA3565@localhost.localdomain>
	<20060127121602.18bc3f25.akpm@osdl.org>
	<20060127224433.GB3565@localhost.localdomain>
	<20060127150106.38b9e041.akpm@osdl.org>
	<20060127150847.48c312c0.akpm@osdl.org>
	<20060128000100.GD3565@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Fri, Jan 27, 2006 at 03:08:47PM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > Oh, and because vm_acct_memory() is counting a singleton object, it can use
> > > DEFINE_PER_CPU rather than alloc_percpu(), so it saves on a bit of kmalloc
> > > overhead.
> > 
> > Actually, I don't think that's true.  we're allocating a sizeof(long) with
> > kmalloc_node() so there shouldn't be memory wastage.
> 
> Oh yeah there is. Each dynamic per-cpu object would have been  atleast
> (NR_CPUS * sizeof (void *) + num_cpus_possible * cacheline_size ).  
> Now kmalloc_node will fall back on size-32 for allocation of long, so
> replace the cacheline_size above with 32 -- which then means dynamic per-cpu
> data are not on a cacheline boundary anymore (most modern cpus have 64byte/128 
> byte cache lines) which means per-cpu data could end up false shared....
> 

OK.  But isn't the core of the problem the fact that __alloc_percpu() is
using kmalloc_node() rather than a (new, as-yet-unimplemented)
kmalloc_cpu()?  kmalloc_cpu() wouldn't need the L1 cache alignment.

It might be worth creating just a small number of per-cpu slabs (4-byte,
8-byte).  A kmalloc_cpu() would just need a per-cpu array of
kmem_cache_t*'s and it'd internally use kmalloc_node(cpu_to_node), no?

Or we could just give __alloc_percpu() a custom, hand-rolled,
not-cacheline-padded sizeof(long) slab per CPU and use that if (size ==
sizeof(long)).  Or something.
