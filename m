Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268328AbUGXGdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268328AbUGXGdc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 02:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268329AbUGXGdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 02:33:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52125 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268328AbUGXGd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 02:33:29 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1090647952.1006.7.camel@mindpipe>
References: <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>
	 <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu>
	 <20040720121905.GG1651@suse.de>  <1090642050.2871.6.camel@mindpipe>
	 <1090647952.1006.7.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1090650808.845.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 02:33:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 01:46, Lee Revell wrote:
> On Sat, 2004-07-24 at 00:07, Lee Revell wrote:
> > On Tue, 2004-07-20 at 08:19, Jens Axboe wrote:
> > > On Tue, Jul 20 2004, Ingo Molnar wrote:
> > > > > How much I/O do you allow to be in flight at once?  It seems like by
> > > > > decreasing the maximum size of I/O that you handle in one interrupt
> > > > > you could improve this quite a bit.  Disk throughput is good enough,
> > > > > anyone in the real world who would feel a 10% hit would just throw
> > > > > hardware at the problem.
> > > > 
> > > it's not tweakable right now, but if you wish to experiment you just
> > > need to add a line to ide-disk.c:idedisk_setup() - pseudo patch:
> > > 
> > > +	blk_queue_max_sectors(drive->queue, 32);
> > > +
> > I am currently testing the effect on throughput and will have some
> > better numbers soon.
> 
> OK, here are my bonnie test results.  They are not what I expected -
> read and write performance is significantly better with 16KB max request
> size, while seeking is much better with 1024KB.
> 

I repeated the test with 'bonnie -f' and without jackd running, and with
32KB vs. 1024KB.  The results are not as drastic, which suggests that
all the overhead from the XRUN tracing was a factor.

These results show that 32KB is better than 1024KB in some areas, and
not singificantly worse in any of these metrics.

32KB:

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mindpipe         1G           38499  68 16383  28           35913  34 154.5   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   257  99 +++++ +++ 24008  98   256  99 +++++ +++  1179  98
mindpipe,1G,,,38499,68,16383,28,,,35913,34,154.5,1,16,257,99,+++++,+++,24008,98,256,99,+++++,+++,1179,98

1024KB:

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mindpipe         1G           38285  60 13961  20           33694  28 155.2   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   259  99 +++++ +++ 24250  98   256  99 +++++ +++  1184  98
mindpipe,1G,,,38285,60,13961,20,,,33694,28,155.2,1,16,259,99,+++++,+++,24250,98,256,99,+++++,+++,1184,98

Lee




