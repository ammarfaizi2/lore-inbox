Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266255AbUARHgA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 02:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbUARHgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 02:36:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:21404 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266255AbUARHf6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 02:35:58 -0500
Date: Sat, 17 Jan 2004 23:36:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: dwmw2@infradead.org, viro@parcelfarce.linux.theplanet.co.uk,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] kill sleep_on
Message-Id: <20040117233618.094c9d22.akpm@osdl.org>
In-Reply-To: <1074409074.1569.12.camel@nidelv.trondhjem.org>
References: <40098251.2040009@colorfullife.com>
	<1074367701.9965.2.camel@imladris.demon.co.uk>
	<20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
	<1074383111.9965.4.camel@imladris.demon.co.uk>
	<20040117224139.5585fb9c.akpm@osdl.org>
	<1074409074.1569.12.camel@nidelv.trondhjem.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> På su , 18/01/2004 klokka 01:41, skreiv Andrew Morton:
> > It would be nice to fix up the lock_kernel()s in the NFS client: SMP lock
> > contention is quite high in there.
> 
> Chuck did a study of that particular issue some 2-3 years ago, but we've
> addressed all the top problems on his list since then. Do you have any
> new numbers to show us? I ask because I'm not at all convinced that the
> BKL adds significantly to our latencies for the moment (I've been
> looking at those number in the last few days due to the readahead
> problems that have already been reported).
> 
> I am, however, quite convinced that we need new statistics on this sort
> of issue. Chuck is therefore working on a set of patches to add an
> "iostat"-like tool to the NFS client. Hopefully that will help settle
> these questions.
> 

Well a quick profile of `dbench 4' on a localhost mount on a P4-HT:

c01445fc kmem_cache_alloc                            495   6.1875
c0140d28 buffered_rmqueue                            514   1.7133
c012a8b4 del_timer_sync                             1043   3.7250
c013ea58 generic_file_aio_write_nolock              1316   0.4398
c011fa60 __wake_up                                  1472  33.4545
c0158a35 .text.lock.read_write                      1541  26.1186
c012113f .text.lock.sched                           2443   4.1197
c011f3f4 schedule                                   2782   1.8065
c0109034 default_idle                              65504 1259.6923
00000000 total                                     91786   0.2234

Turning on spinlock inlining:

c0143ec0 kmem_cache_alloc                            464   6.1053
c01405c8 buffered_rmqueue                            510   1.6346
c012a260 __mod_timer                                 540   1.7308
c012a4d4 del_timer_sync                              949   3.3893
c013e378 generic_file_aio_write_nolock              1340   0.4479
c011fa1c __wake_up                                  1556  29.9231
c0157054 remote_llseek                              1886   6.6408
c011f3a4 schedule                                   5158   3.3407
c0109034 default_idle                              33731 648.6731
00000000 total                                     59918   0.1457

That's quite a lot of contention on the lock_kernel() in remote_llseek().

The context switch rate is 45000/sec, so schedule() gets a workout.

I do recall seeing quite a lot of BKL contention within NFS itself running
across 100bT on 4-way.  That was several months ago - maybe things
improved?

