Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUIHMjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUIHMjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUIHMid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:38:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63971 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262837AbUIHMgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:36:54 -0400
Date: Wed, 8 Sep 2004 14:38:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] max-sectors-2.6.9-rc1-bk14-A0
Message-ID: <20040908123821.GA17953@elte.hu>
References: <20040908100448.GA4994@elte.hu> <20040908030944.4cd0e3a0.akpm@osdl.org> <20040908104931.GA5523@elte.hu> <20040908044328.46eec88b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908044328.46eec88b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Still sounds a bit odd.  How many cachelines can that CPU fetch in 8
> usecs? Several tens at least?

the CPU in question is a 600 MHz C3, so it should be dozens. Considering
a conservative 200nsec cacheline-fetch latency and 8 nsecs per byte
bursted - so for a 32-byte cacheline it could take 264 nsecs. So with
... ~8 cachelines touched that could only explain 2-3 usec of overhead.
The bio itself is not layed out optimally: the bio and the vector are on
two different cachelines plus we have the buffer_head too (in the ext3
case) - all on different cachelines.

but the latency does happen and it happens even with tracing turned
completely off.

The main overhead is the completion path for a single page, which goes
like:

__end_that_request_first()
  bio_endio()
    end_bio_bh_io_sync()
      journal_end_buffer_io_sync()
         unlock_buffer()
           wake_up_buffer()
    bio_put()
      bio_destructor()
        mempool_free()
          mempool_free_slab()
            kmem_cache_free()
        mempool_free()
          mempool_free_slab()
            kmem_cache_free()

this is quite fat just from an instruction count POV - 14 functions with
at least 20 instructions in each function, amounting to ~300
instructions per iteration - that alone is quite an icache footprint
assumption.

Plus we could be trashing the cache due to touching at least 3 new
cachelines per iteration - which is 192 new (dirty) cachelines for the
full completion or ~6K of new L1 cache contents. With 128 byte
cachelines it's much worse: at least 24K worth of new cache contents. 
I'd suggest to at least attempt to merge bio and bio->bi_io_vec into a
single cacheline, for the simpler cases.

another detail is the SLAB's FIFO logic memmove-ing the full array:

 0.184ms (+0.000ms): kmem_cache_free (mempool_free)
 0.185ms (+0.000ms): cache_flusharray (kmem_cache_free)
 0.185ms (+0.000ms): free_block (cache_flusharray)
 0.200ms (+0.014ms): memmove (cache_flusharray)
 0.200ms (+0.000ms): memcpy (memmove)

that's 14 usecs a pop and quite likely a fair amount of new dirty cache
contents.

The building of the sg-list of the next DMA request was responsible for
some of the latency as well:

 0.571ms (+0.000ms): ide_build_dmatable (ide_start_dma)
 0.571ms (+0.000ms): ide_build_sglist (ide_build_dmatable)
 0.572ms (+0.000ms): blk_rq_map_sg (ide_build_sglist)
 0.593ms (+0.021ms): do_IRQ (common_interrupt)
 0.594ms (+0.000ms): mask_and_ack_8259A (do_IRQ)

this completion codeath isnt something people really profiled/measured
previously, because it's in an irqs-off hardirq path that triggers
relatively rarely. But for scheduling latencies it can be quite high.

	Ingo
