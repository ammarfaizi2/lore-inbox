Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269970AbRHEPYo>; Sun, 5 Aug 2001 11:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269969AbRHEPYe>; Sun, 5 Aug 2001 11:24:34 -0400
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:46328 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S269970AbRHEPYW>; Sun, 5 Aug 2001 11:24:22 -0400
Message-ID: <01df01c11dc2$b2ee30e0$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Ben LaHaise" <bcrl@redhat.com>,
        "Daniel Phillips" <phillips@bonn-fries.net>,
        "Rik van Riel" <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, "Andrew Morton" <andrewm@uow.edu.au>
In-Reply-To: <Pine.LNX.4.33.0108040952460.1203-100000@penguin.transmeta.com>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
Date: Sun, 5 Aug 2001 11:24:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I bumped up the queue_nr_requests to 512, then 1024 -- 1024 finally made a
performance difference for me and the machine was still usable.
As an ext2 mount there were no interactive delays at all (this is as it
always has been prior to any of these patches):
tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  50.52 59.9% 0.869 2.28% 29.28 25.0% 1.329 0.85%
   .     4000   4096    2  45.52 57.9% 1.104 2.58% 26.66 25.8% 1.346 1.11%
   .     4000   4096    4  33.69 44.2% 1.316 3.08% 17.02 17.2% 1.342 1.26%
   .     4000   4096    8  29.74 39.5% 1.500 3.43% 14.45 15.4% 1.342 1.26%

As an ext3 mount (here's where I've been seeing BIG delays before) there
were:
1 thread - no delays
2 threads - 2 delays for 2 seconds each  << previously even 2 threads caused
minute+ delays.
4 threads - 5 delays - 1 for 3 seconds, 4 for 2 seconds
8 threads - 21 delays  - 9 for 2 sec, 4 for 3 sec,  4 for 4 sec, 2 for 5
sec, 1 for 6 sec, and 1 for 10 sec
NOTE: all these delays were during the write tests -- none during read.
tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  46.32 66.3% 0.859 1.98% 26.09 31.3% 1.280 0.73%
   .     4000   4096    2  18.65 29.8% 0.997 2.10% 16.04 28.2% 1.300 1.12%
   .     4000   4096    4  15.90 26.7% 1.154 2.48% 14.68 31.0% 1.263 1.15%
   .     4000   4096    8  14.93 24.1% 1.307 2.82% 11.68 41.5% 1.251 1.18%

To compute the delays I'm just using a simple little program:
#include <stdio.h>
main()
{
        int last,last2;
        last=time(NULL);
        while(1) {
                sleep(1);
                last2=time(NULL);
                if(last2-last > 2) {
                        printf("Delay %d\n",last2-last-1);
                }
                last = last2;
        }
}



----- Original Message -----
From: "Linus Torvalds" <torvalds@transmeta.com>
To: "Mike Black" <mblack@csihq.com>
Cc: "Ben LaHaise" <bcrl@redhat.com>; "Daniel Phillips"
<phillips@bonn-fries.net>; "Rik van Riel" <riel@conectiva.com.br>;
<linux-kernel@vger.kernel.org>; <linux-mm@kvack.org>; "Andrew Morton"
<andrewm@uow.edu.au>
Sent: Saturday, August 04, 2001 1:08 PM
Subject: Re: [RFC][DATA] re "ongoing vm suckage"


>
> On Sat, 4 Aug 2001, Mike Black wrote:
> >
> > I'm testing 2.4.8-pre4 -- MUCH better interactivity behavior now.
>
> Good.. However..
>
> > I've been testing ext3/raid5 for several weeks now and this is usable
now.
> > My system is Dual 1Ghz/2GRam/4GSwap fibrechannel.
> > But...the single thread i/o performance is down.
>
> Bad. And before we get too happy about the interactive thing, let's
> remember that sometimes interactivity comes at the expense of throughput,
> and maybe if we fix the throughput we'll be back where we started.
>
> Now, you basically have a rather fast disk subsystem, and it's entirely
> possible that with that kind of oomph you really want a longer queue. So
> in blk_dev_init() in drivers/block/ll_rw_blk.c, try changing
>
> /*
>          * Free request slots per queue.
>          * (Half for reads, half for writes)
>          */
>         queue_nr_requests = 64;
>         if (total_ram > MB(32))
>                 queue_nr_requests = 128;
>
> to something more like
>
> /*
>          * Free request slots per queue.
>          * (Half for reads, half for writes)
>          */
>         queue_nr_requests = 64;
>         if (total_ram > MB(32)) {
>                 queue_nr_requests = 128;
> if (total_ram > MB(128))
> queue_nr_requests = 256;
> }
>
> and tell me if interactivity is still fine, and whether performance goes
> up?
>
> And please feel free to play with different values - but remember that
> big values do tend to mean bad latency.
>
> Rule of thumb: even on fast disks, the average seek time (and between
> requests you almost always have to seek) is on the order of a few
> milliseconds. With a large write-queue (256 total requests means 128 write
> requests) you can basically get single-request latencies of up to a
> second. Which is really bad.
>
> One partial solution may be the just make the read queue deeper than the
> write queue. That's a bit more complicated than just changing a single
> value, though - you'd need to make the batching threshold be dependent on
> read-write too etc. But it would probably not be a bad idea to change the
> "split requests evenly" to do even "split requests 2:1 to read:write".
>
> All the logic is in drivers/block/ll_rw_block.c, and it's fairly easy to
> just search for queue_nr_requests/batch_requests to see what it's doing.
>
> > I"m seeing a lot more CPU Usage for the 1st thread than previous
tests --
> > perhaps we've shortened the queue too much and it's throttling the read?
> > Why would CPU usage go up and I/O go down?
>
> I'd guess it's calling the scheduler more. With fast disks and a queue
> that runs out, you'd probably go into a series of extremely short
> stop-start behaviour. Or something similar.
>
> Linus

