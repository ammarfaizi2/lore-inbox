Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUGXGmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUGXGmA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 02:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268332AbUGXGmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 02:42:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18560 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264717AbUGXGl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 02:41:57 -0400
Date: Sat, 24 Jul 2004 08:43:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040724064304.GA32269@elte.hu>
References: <20040712174639.38c7cf48.akpm@osdl.org> <1089687168.10777.126.camel@mindpipe> <20040712205917.47d1d58b.akpm@osdl.org> <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu> <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu> <20040720121905.GG1651@suse.de> <1090642050.2871.6.camel@mindpipe> <1090647952.1006.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090647952.1006.7.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> jackd was running in the background in both cases.  With 1024KB, there
> were massive XRUNS, and worse, occasionally the soundcard interrupt
> was completely lost for tens of milliseconds.  This is what I would
> expect if huge SG lists are being built in hardirq context.  With
> 16KB, jackd ran perfectly, the highest latency I was was about 100
> usecs.
> 
> Kernel is 2.6.8-rc2 + voluntary-preempt-I4.  CPU is 600Mhz, 512MB RAM.

ok, i'll put in a tunable for the sg size.

Btw., it's not really the building of the SG list that is expensive,
it's the completion activity that is expensive since e.g. in the case of
ext3 IO traffic it goes over _every single_ sg entry with the following
fat codepath:

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

the buffer_head, the bio and bio->bi_io_vec all lie on different
cachelines and are very likely to be not cached after long IO latencies. 
So we eat at least 3 big cachemisses, times 256.

Jens, one solution would be to make BIO completion a softirq - like SCSI
does. That makes the latencies much easier to control.

Another thing would be to create a compound structure for bio and
[typical sizes of] bio->bi_io_vec and free them as one entity, this
would get rid of one of the cachemisses. (there cannot be a 3-way
compound structure that includes the bh too because the bh is freed
later on by ext3.)

	Ingo
