Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbRHYJaq>; Sat, 25 Aug 2001 05:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268342AbRHYJag>; Sat, 25 Aug 2001 05:30:36 -0400
Received: from maile.telia.com ([194.22.190.16]:33230 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S267852AbRHYJa3>;
	Sat, 25 Aug 2001 05:30:29 -0400
Message-Id: <200108250930.f7P9UZH10871@maile.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: =?iso-8859-1?q?G=E9rard=20Roudier?= <groudier@free.fr>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sat, 25 Aug 2001 11:26:10 +0200
X-Mailer: KMail [version 1.3]
Cc: "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
In-Reply-To: <20010825094000.O756-100000@gerard>
In-Reply-To: <20010825094000.O756-100000@gerard>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday den 25 August 2001 10:02, Gérard Roudier wrote:
> On Fri, 24 Aug 2001, Rik van Riel wrote:
> > On Fri, 24 Aug 2001, Gérard Roudier wrote:
> > > The larger the read-ahead chunks, the more likely trashing will
> > > occur. In my opinion, using more than 128 K IO chunks will not
> > > improve performances with modern hard disks connected to a
> > > reasonnably fast controller, but will increase memory pressure
> > > and probably thrashing.
> >
> > Your opinion seems to differ from actual measurements
> > made by Roger Larsson and other people.
>
> The part of my posting that talked about modern hard disks sustaining more
> than 8000 IOs per second and controllers sustaining 15000 IOs per second
> is a _measurement_.
>
> With such values, given a U160 SCSI BUS, using 64K IO chunks will result
> in about less than 25% of bandwidth used for the SCSI protocol and 75% for
> useful data at full load (about 2000 IO/s - 120 MB/s). This is a
> _calculation_. With 128K IO chunks, less than 15% of the SCSI BUS will be
> used for the SCSI protocol and more than 85% for usefull data. Still a
> _calculation_.
>
> This let me claim - opinion based on fairly simple calculations - that if
> using more 128 K IO chunks gives significantly better throughput, then
> some serious IO scheduling problem should exist in kernel IO subsystems.

Where did the seek time go? And rotational latency?

[I hope my calculations are correct]


This is mine (a IBM Deskstar 75GXP)
Sustained data rate (MB/sec)	37
Seek time  (read typical)
	Average (ms)		 8.5
	Track-to-track (ms)	 1.2
	Full-track (ms)		15.0
Data buffer			2 MB
Latency (calculated 7200 RPM)	4.2 ms

So sustained data rate is 37 MB/s
> hdparm -t gives around 35 MB/s
best I got during testing or real files is 32 MB/s

A small calculation:
Track-to-track time is 1.2 ms + time to rotate 4.2 ms = 5.4 ms
In this time I can read 37 MB/s * 5.4 ms = 200 kB or 
more than 48 pages (instead of moving the head to the closest
track I could read 48 pages...)

Average is 8.5 ms + 4.2 ms => 114 pages 

Reading a maximum of 114 pages at a time gives on the average
half the maximum sustained throughput for this disk.
But the buffer holds 512 pages... => I tried with that. [overkill]

* Data from a Seagate Cheetah X15 ST336732LC (Better than most
disks out there - way better than mine)
Formatted Int Transfer Rate (min)	51 MBytes/sec
Formatted Int Transfer Rate (max)	69 MBytes/sec
Average Seek Time, Read		3.7 msec typical
Track-to-Track Seek, Read	0.5 msec typical
Average Latency			2 msec
Default Buffer (cache) Size	8,192 Kbytes
Spindle Speed			15K RPM

Same calculation:
Track-to-track: (2 + 0.5) ms * 51 MB = 127 kB or 31 pages (42 pages max)
Average: (2 + 3.7 ms) * 51 MB/s = 290 kB or almost 71 pages (96 pages max)

Reading a maximum of 71 pages gives on the average half the
maximum sustained throughput. [smart buffering in the drive might help
when reading from several streams]


/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
