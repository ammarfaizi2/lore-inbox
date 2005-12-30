Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVL3CQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVL3CQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 21:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVL3CQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 21:16:22 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:1734 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750780AbVL3CQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 21:16:21 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051229202848.GC29546@elte.hu>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
	 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu>
	 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe>
	 <20051229202848.GC29546@elte.hu>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 21:16:19 -0500
Message-Id: <1135908980.4568.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 21:28 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > Still does not quite work for me on i386.  I applied all the patches as
> > > I'm using 4K stacks.
> 
> oops!
> 
> > > LD      .tmp_vmlinux1
> > > init/built-in.o: In function `start_kernel':
> > > : undefined reference to `preempt_max_latency'
> > > make: *** [.tmp_vmlinux1] Error 1
> > > 
> > 
> > This patch fixes the problem.
> 
> thanks, applied - new version uploaded.

It seems that debug_smp_processor_id is being called a lot, even though
I have a UP config, which I didn't see with the -rt kernel:

$ grep debug_smp_processor_id /proc/latency_trace | head -20
evolutio-4568  0d.H1    3us : debug_smp_processor_id (do_IRQ)
evolutio-4568  0d.h.   25us : debug_smp_processor_id (netif_rx)
evolutio-4568  0d.h.   28us : debug_smp_processor_id (kmem_cache_alloc)
evolutio-4568  0d.h.   31us+: debug_smp_processor_id (__kmalloc)
evolutio-4568  0d.s.   46us : debug_smp_processor_id (__do_softirq)
evolutio-4568  0d.s.   47us : debug_smp_processor_id (__do_softirq)
evolutio-4568  0d.s1   54us+: debug_smp_processor_id (kmem_cache_alloc)
evolutio-4568  0d.s1   65us : debug_smp_processor_id (kmem_cache_free)
evolutio-4568  0d.s3  109us : debug_smp_processor_id (kmem_cache_alloc)
evolutio-4568  0d.s3  111us+: debug_smp_processor_id (__kmalloc)
evolutio-4568  0d.s3  140us : debug_smp_processor_id (kfree)
evolutio-4568  0d.s3  141us : debug_smp_processor_id (kmem_cache_free)
evolutio-4568  0d.s3  158us : debug_smp_processor_id (kfree)
evolutio-4568  0d.s3  160us : debug_smp_processor_id (kmem_cache_free)
evolutio-4568  0d.s3  192us : debug_smp_processor_id (kfree)
evolutio-4568  0d.s3  193us : debug_smp_processor_id (kmem_cache_free)
evolutio-4568  0d.s3  210us : debug_smp_processor_id (kfree)
evolutio-4568  0d.s3  211us : debug_smp_processor_id (kmem_cache_free)
evolutio-4568  0d.s3  216us : debug_smp_processor_id (kmem_cache_alloc)
evolutio-4568  0d.s3  217us+: debug_smp_processor_id (__kmalloc)

etc.

Was this optimized out on UP before?

Lee

