Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268897AbRHYLxA>; Sat, 25 Aug 2001 07:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268901AbRHYLwu>; Sat, 25 Aug 2001 07:52:50 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:46601 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S268897AbRHYLwa> convert rfc822-to-8bit; Sat, 25 Aug 2001 07:52:30 -0400
Date: Sat, 25 Aug 2001 13:49:59 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: Rik van Riel <riel@conectiva.com.br>, "Marc A. Lehmann" <pcg@goof.com>,
        <linux-kernel@vger.kernel.org>, <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <200108250930.f7P9UZH10871@maile.telia.com>
Message-ID: <20010825130606.Q1086-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Aug 2001, Roger Larsson wrote:

> On Saturday den 25 August 2001 10:02, Gérard Roudier wrote:
> > On Fri, 24 Aug 2001, Rik van Riel wrote:
> > > On Fri, 24 Aug 2001, Gérard Roudier wrote:
> > > > The larger the read-ahead chunks, the more likely trashing will
> > > > occur. In my opinion, using more than 128 K IO chunks will not
> > > > improve performances with modern hard disks connected to a
> > > > reasonnably fast controller, but will increase memory pressure
> > > > and probably thrashing.
> > >
> > > Your opinion seems to differ from actual measurements
> > > made by Roger Larsson and other people.
> >
> > The part of my posting that talked about modern hard disks sustaining more
> > than 8000 IOs per second and controllers sustaining 15000 IOs per second
> > is a _measurement_.
> >
> > With such values, given a U160 SCSI BUS, using 64K IO chunks will result
> > in about less than 25% of bandwidth used for the SCSI protocol and 75% for
> > useful data at full load (about 2000 IO/s - 120 MB/s). This is a
> > _calculation_. With 128K IO chunks, less than 15% of the SCSI BUS will be
> > used for the SCSI protocol and more than 85% for usefull data. Still a
> > _calculation_.
> >
> > This let me claim - opinion based on fairly simple calculations - that if
> > using more 128 K IO chunks gives significantly better throughput, then
> > some serious IO scheduling problem should exist in kernel IO subsystems.
>
> Where did the seek time go? And rotational latency?

They just go away, for the following reasons:

- For random IOs, IOs are rather seek time bounded.
  Tagged commands may help here.
- For sequential IOs, the drive is supposed to prefetch data.

Everything is compromise. If for N K bufferring, you get 90% of the
throughtput, then the compromise looks good to me. 2*N K bufferring is
likely to give no more than 5% gain for *twice* the cost in bufferring.

> [I hope my calculations are correct]
>
>
> This is mine (a IBM Deskstar 75GXP)
> Sustained data rate (MB/sec)	37
> Seek time  (read typical)
> 	Average (ms)		 8.5
> 	Track-to-track (ms)	 1.2
> 	Full-track (ms)		15.0
> Data buffer			2 MB
> Latency (calculated 7200 RPM)	4.2 ms
>
> So sustained data rate is 37 MB/s
> > hdparm -t gives around 35 MB/s
> best I got during testing or real files is 32 MB/s

Looks a less than 10% slow-down.
Did you take into account the bmap() thing?
Are you sure all the read data are on the outer tracks which are
the fastest ones?

> A small calculation:
> Track-to-track time is 1.2 ms + time to rotate 4.2 ms = 5.4 ms
> In this time I can read 37 MB/s * 5.4 ms = 200 kB or
> more than 48 pages (instead of moving the head to the closest
> track I could read 48 pages...)
>
> Average is 8.5 ms + 4.2 ms => 114 pages
>
> Reading a maximum of 114 pages at a time gives on the average
> half the maximum sustained throughput for this disk.

And reading 1140 pages at a time will give 90% of the maximum disk
throughput, for random IOs. :-)
Btw, I thought that IDE was very limited in actual IO size.

> But the buffer holds 512 pages... => I tried with that. [overkill]

The drive buffer is supposed to help overlap actual IOs with the medium.
-> Read prefetching, write behind caching.

> * Data from a Seagate Cheetah X15 ST336732LC (Better than most
> disks out there - way better than mine)
> Formatted Int Transfer Rate (min)	51 MBytes/sec
> Formatted Int Transfer Rate (max)	69 MBytes/sec
> Average Seek Time, Read		3.7 msec typical
> Track-to-Track Seek, Read	0.5 msec typical
> Average Latency			2 msec
> Default Buffer (cache) Size	8,192 Kbytes
> Spindle Speed			15K RPM
>
> Same calculation:
> Track-to-track: (2 + 0.5) ms * 51 MB = 127 kB or 31 pages (42 pages max)
> Average: (2 + 3.7 ms) * 51 MB/s = 290 kB or almost 71 pages (96 pages max)
>
> Reading a maximum of 71 pages gives on the average half the
> maximum sustained throughput. [smart buffering in the drive might help
> when reading from several streams]

It helps even for single-stream by prefetching data. If you are using
files mostly contiguous, you will not see the various disk latencies.

On the other hand, the kernel asynchronous read-ahead code will queue 1 IO
in advance that will be overlapped with the processing of previous data by
the application.

Btw, if the application just discards the data, this is for sure not
useful. :)

  Gérard.

