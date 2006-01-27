Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWA0W7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWA0W7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWA0W7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:59:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18817 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422664AbWA0W7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:59:20 -0500
Date: Fri, 27 Jan 2006 15:01:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: dada1@cosmosbay.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables --
 proto.sockets_allocated
Message-Id: <20060127150106.38b9e041.akpm@osdl.org>
In-Reply-To: <20060127224433.GB3565@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain>
	<20060126190357.GE3651@localhost.localdomain>
	<43D9DFA1.9070802@cosmosbay.com>
	<20060127195227.GA3565@localhost.localdomain>
	<20060127121602.18bc3f25.akpm@osdl.org>
	<20060127224433.GB3565@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Fri, Jan 27, 2006 at 12:16:02PM -0800, Andrew Morton wrote:
> > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > >
> > > which can be assumed as not frequent.  
> > > At sk_stream_mem_schedule(), read_sockets_allocated() is invoked only 
> > > certain conditions, under memory pressure -- on a large CPU count machine, 
> > > you'd have large memory, and I don't think read_sockets_allocated would get 
> > > called often.  It did not atleast on our 8cpu/16G box.  So this should be OK 
> > > I think.
> > 
> > That being said, the percpu_counters aren't a terribly successful concept
> > and probably do need a revisit due to the high inaccuracy at high CPU
> > counts.  It might be better to do some generic version of vm_acct_memory()
> > instead.
> 
> AFAICS vm_acct_memory is no better.  The deviation on large cpu counts is the 
> same as percpu_counters -- (NR_CPUS * NR_CPUS * 2) ...

I suppose so.  Except vm_acct_memory() has

	#define ACCT_THRESHOLD  max(16, NR_CPUS * 2)

But if we were to perform similar tuning to percpu_counter, yes, they're
pretty similar.

Oh, and because vm_acct_memory() is counting a singleton object, it can use
DEFINE_PER_CPU rather than alloc_percpu(), so it saves on a bit of kmalloc
overhead.


> > 
> > If the benchmarks say that we need to.  If we cannot observe any problems
> > in testing of existing code and if we can't demonstrate any benefit from
> > the patched code then one option is to go off and do something else ;)
> 
> We first tried plain per-CPU counters for memory_allocated, found that reads
> on memory_allocated was causing cacheline transfers, and then
> switched over to batching.  So batching reads is useful.  To avoid
> inaccuracy, we can maybe change percpu_counter_init to:
> 
> void percpu_counter_init(struct percpu_counter *fbc, int maxdev)
> 
> the percpu batching limit would then be maxdev/num_possible_cpus.  One would
> use batching counters only when both reads and writes are frequent.  With
> the above scheme, we would go fetch cachelines from other cpus for read
> often only on large cpu counts, which is not any worse than the global
> counter alternative, but it would still be beneficial on smaller machines,
> without sacrificing a pre-set deviation.  
> 
> Comments?

Sounds sane.
