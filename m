Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282999AbRK1CPE>; Tue, 27 Nov 2001 21:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283006AbRK1COq>; Tue, 27 Nov 2001 21:14:46 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51463 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282999AbRK1CO3>; Tue, 27 Nov 2001 21:14:29 -0500
Message-ID: <3C044855.3CF2DCA3@zip.com.au>
Date: Tue, 27 Nov 2001 18:13:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <20011128013129Z281843-17408+21534@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> Andrew Morton wrote:
> > Jens Axboe wrote:
> > >
> > > I agree that the current i/o scheduler has really bad interactive
> > > performance -- at first sight your changes looks mostly like add-on
> > > hacks though.
> >
> > Good hacks, or bad ones?
> 
> As I can "see" not so good.
> I've tried "dbench 32" and playing an MP3 with Noatun (KDE-2.2.2) and  "saw"
> my reported hiccup since 2.4.7-ac4, as always.

Ah.  dbench.   The change to balance_dirty_state() absolutely
cripples dbench throughput.  And that really doesn't matter,
unless you want to run dbench for a living.

You can get the dbench throughput back by increasing the
async and sync dirty buffer writeback thresholds:

	echo 70 64 64 256 30000 3000 80 0 0 > /proc/sys/vm/bdflush

> Noatun stops after 9-10 seconds of the "dbench 32" run and then every few
> seconds, again and again. The hiccup take place more often but for shorter
> times then without your patch.

Probably Noatun needs larger buffers if it is to survive concurrent
dbench.   You may see improvement with

	elvtune -b N /dev/hdaX

where 8 >= N >= 1.

> System was:
> 
> 2.4.16 +
> preempt +
> lock-break-rml-2.4.16-1.patch +
> all ReiserFS patches for 2.4.16
> 
> 1 GHz Athlon II
> MSI MS-6167 Rev 1.0B (AMD Irongate C4, without bypass)
> 640 MB PC100-2-2-2 SDRAM
> U160 IBM 18 GB disk
> AHA-2940 UW
> 
> > It keeps things localised.  It works.  It's tunable.  It's the best
> > IO scheduler presently available.
> 
> Throughput was a little lower ;-)

dbench?  Throughput seems to scale with the fourth power of the
amount of RAM you chuck at it :)

> Don't forget to tune max-readahead.

Yes.  Readahead is fairly critical and there may be additional fixes
needed in this area.

Someone recently added the /proc/sys/vm/max_readahead (?) tunable.
Beware of this.  It only works for device drivers which do not
populate their own readhead table.  For IDE, it *looks* like
it works, but it doesn't.   For IDE, the only way to alter VM
readahead is via

	echo file_readahead:N > /proc/ide/ide0/hda/settings

where N is in kilobytes in 2.4.16 kernels.  In earlier kernels
it's kilopages (!).

-
