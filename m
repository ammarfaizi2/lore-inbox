Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274265AbRISXZj>; Wed, 19 Sep 2001 19:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274264AbRISXZc>; Wed, 19 Sep 2001 19:25:32 -0400
Received: from t2.redhat.com ([199.183.24.243]:15357 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S274266AbRISXZQ>; Wed, 19 Sep 2001 19:25:16 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Wed, 19 Sep 2001 20:47:20 +0200." <20010919204720.L720@athlon.random> 
Date: Thu, 20 Sep 2001 00:25:40 +0100
Message-ID: <7486.1000941940@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli <andrea@suse.de> wrote:
> On Wed, Sep 19, 2001 at 07:26:33PM +0100, David Howells wrote:
> > > if we go generic then I strongly recommend my version of the generic
> > > semaphores is _much_ faster (and cleaner) than this one
> >
> > Not so:-) Your patch, Andrea, grabs the spinlock far more than is necessary.
> 
> then why your microbenchmarks says my version is much faster?

They don't:

[my rwsem-unfair-2.diff patch]
#rds #wrs time :  rd granted [spread]  wr granted [spread]
==== ==== =====   ===================  ===================
   1    0   10s:    25384639 [0.008%]           0 [0.000%]
   2    0   10s:     8007388 [0.013%]           0 [0.000%]
   4    0   10s:     8004833 [0.007%]           0 [0.000%]
   0    1   10s:           0 [0.000%]    25717288 [0.009%]
   0    4   10s:           0 [0.000%]     2817293 [2.323%]
   4    2   10s:    12742523 [0.008%]         114 [5.394%]
  30    1   10s:    12739163 [0.002%]          92 [1.739%]
  30   15   50s:    63733591 [0.003%]         286 [2.711%]

[Andrea's 00_rwsem-19 patch]
#rds #wrs time :  rd granted [spread]  wr granted [spread]
==== ==== =====   ===================  ===================
   1    0   10s:    24577938 [0.003%]           0 [0.000%]
   2    0   10s:     5631224 [0.016%]           0 [0.000%]
   4    0   10s:     5633280 [0.009%]           0 [0.000%]
   0    1   10s:           0 [0.000%]    24572785 [0.007%]
   0    4   10s:           0 [0.000%]     3444786 [0.091%]
   4    2   10s:     8036291 [0.008%]         122 [4.918%]
  30    1   10s:     8036490 [0.006%]          89 [1.253%]
  30   15   50s:    40200472 [0.001%]         265 [2.717%]

[Unpatched kernel]
#rds #wrs time :  rd granted [spread]  wr granted [spread]
==== ==== =====   ===================  ===================
   1    0   10s:    30118903 [0.008%]           0 [0.000%]
   2    0   10s:    12543737 [0.007%]           0 [0.000%]
   4    0   10s:    12543731 [0.006%]           0 [0.000%]
   0    1   10s:           0 [0.000%]    28408147 [0.008%]
   0    4   10s:           0 [0.000%]     1554495 [0.172%]
   4    2   10s:     1119656 [0.076%]      560020 [0.077%]
  30    1   10s:     5361923 [0.024%]       55787 [0.012%]
  30   15   50s:     5322473 [0.049%]     2661621 [0.050%]

David
