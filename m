Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUGXFqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUGXFqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUGXFqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:46:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:44186 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268299AbUGXFqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:46:02 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1090642050.2871.6.camel@mindpipe>
References: <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>
	 <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu>
	 <20040720121905.GG1651@suse.de>  <1090642050.2871.6.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1090647952.1006.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 01:46:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 00:07, Lee Revell wrote:
> On Tue, 2004-07-20 at 08:19, Jens Axboe wrote:
> > On Tue, Jul 20 2004, Ingo Molnar wrote:
> > > > How much I/O do you allow to be in flight at once?  It seems like by
> > > > decreasing the maximum size of I/O that you handle in one interrupt
> > > > you could improve this quite a bit.  Disk throughput is good enough,
> > > > anyone in the real world who would feel a 10% hit would just throw
> > > > hardware at the problem.
> > > 
> > it's not tweakable right now, but if you wish to experiment you just
> > need to add a line to ide-disk.c:idedisk_setup() - pseudo patch:
> > 
> > +	blk_queue_max_sectors(drive->queue, 32);
> > +
> I am currently testing the effect on throughput and will have some
> better numbers soon.

OK, here are my bonnie test results.  They are not what I expected -
read and write performance is significantly better with 16KB max request
size, while seeking is much better with 1024KB.

jackd was running in the background in both cases.  With 1024KB, there
were massive XRUNS, and worse, occasionally the soundcard interrupt was
completely lost for tens of milliseconds.  This is what I would expect 
if huge SG lists are being built in hardirq context.  With 16KB, jackd
ran perfectly, the highest latency I was was about 100 usecs.

Kernel is 2.6.8-rc2 + voluntary-preempt-I4.  CPU is 600Mhz, 512MB RAM.

16KB:

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mindpipe         1G  3002  88 31164  60 13485  29  3035  84 32838  36  56.7   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16    94  40 +++++ +++ 15510  66   204  86 +++++ +++   906  83 
mindpipe,1G,3002,88,31164,60,13485,29,3035,84,32838,36,56.7,0,16,94,40,+++++,+++,15510,66,204,86,+++++,+++,906,83

1024KB:

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mindpipe         1G  2988  86 17647  29 10979  17  3114  90 28556  25 156.7   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   210  88 +++++ +++ 13295  62   215  89 +++++ +++   920  84 
mindpipe,1G,2988,86,17647,29,10979,17,3114,90,28556,25,156.7,1,16,210,88,+++++,+++,13295,62,215,89,+++++,+++,920,84

HD info:
/dev/hdc:

 Model=Maxtor 6Y160P0, FwRev=YAR41BW0, SerialNo=Y44K8TZE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null): 

 * signifies the current active mode

Lee

