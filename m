Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283013AbRK1Dxa>; Tue, 27 Nov 2001 22:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281865AbRK1DxV>; Tue, 27 Nov 2001 22:53:21 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:38102 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S283011AbRK1DxK>; Tue, 27 Nov 2001 22:53:10 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: Unresponiveness of 2.4.16
Date: Wed, 28 Nov 2001 04:53:03 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
In-Reply-To: <20011128013129Z281843-17408+21534@vger.kernel.org> <3C044855.3CF2DCA3@zip.com.au> <20011127183429.B862@mikef-linux.matchmail.com>
In-Reply-To: <20011127183429.B862@mikef-linux.matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011128035317Z283011-17409+18642@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 28. November 2001 03:34 schrieb Mike Fedyk:
> On Tue, Nov 27, 2001 at 06:13:41PM -0800, Andrew Morton wrote:
> > Dieter N?tzel wrote:
> > > Don't forget to tune max-readahead.
> >
> > Yes.  Readahead is fairly critical and there may be additional fixes
> > needed in this area.
> >
> > Someone recently added the /proc/sys/vm/max_readahead (?) tunable.

-mt (Marcelo Tosatti) our _new_ 2.4.x maintainer did it.

> Isn't this part of the max-readahead patch?
>
> Does /proc/sys/vm/max_readahead affect scsi in any way?

Hello people, can you read?
I've reported U160 (SCSI) IBM DDYS (Ultrastar 36LZX) 18 GB 10k results...;-)

Kernel default:
SunWave1 src/linux# cat /proc/sys/vm/min-readahead
3
SunWave1 src/linux# cat /proc/sys/vm/max-readahead
31
SunWave1 src/linux# hdparm -tT /dev/sda1
/dev/sda1:
 Timing buffer-cache reads:   128 MB in  0.80 seconds =160.00 MB/sec
 Timing buffered disk reads:  64 MB in  2.28 seconds = 28.07 MB/sec


SunWave1 src/linux# cat /proc/sys/vm/max-readahead
127
SunWave1 src/linux# hdparm -tT /dev/sda1
/dev/sda1:
 Timing buffer-cache reads:   128 MB in  0.80 seconds =160.00 MB/sec
 Timing buffered disk reads:  64 MB in  1.87 seconds = 34.22 MB/sec

So it improved hdparm by 0.5 MB at the inner and 6 MB at the outer cylinders.

max-readahead=31		max-readahead=127
26-28 MB/s			26.5-34 MB/s

max-readahead=63	is nearly the same
max-readahead=255	little slower
max-readahead=511	even little slower

Here is a snipped of the IBM specs:

Performance 
Data buffer		4 MB² 
Rotational speed		10,000 RPM 
Latency (average)	2.99 ms 
Media transfer rate	280-452 Mbits/sec 
Interface transfer rate	160 MB/sec
Sustained data rate	21.7- 36.1MB/sec 

Seek time
Average			4.9 ms 
Track to track		0.5 ms 
Full track		10.5 ms 

To Robert Love:
I get the following in dmesg:
lock-break-rml-2.4.16-1.patch

date: busy buffer
lock_break: buffer.c:681: count was 2 not 551
invalidate: busy buffer
lock_break: buffer.c:681: count was 2 not 551
invalidate: busy buffer
[-]

lock-break-rml-2.4.16-2.patch

validate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
[-]

Now my dbench numbers.
First without Noatun playing Ogg-Vorbis:
dbench/dbench> time ./dbench 32
32 clients started
........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+................+..............................................................................+++.+.+.......+.....++++....++.....+++++.++++.++.+++++++********************************
Throughput 43.8254 MB/sec (NB=54.7818 MB/sec  438.254 MBit/sec)
14.490u 53.230s 1:37.40 69.5%   0+0k 0+0io 937pf+0w
system load: 23.52

Second Noatun playing Ogg-Vorbis (with hiccup):
dbench/dbench> time ./dbench 32
32 clients started
...............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+....+........................+.......++++...+.+...........+.+.....+++++.+.++..++..+++.++.++++.++********************************
Throughput 42.1212 MB/sec (NB=52.6515 MB/sec  421.212 MBit/sec)
14.710u 53.940s 1:41.29 67.7%   0+0k 0+0io 937pf+0w
system load: 26.30

Not bad, I think.
Andrew, your patch follows tomorrow.

Regards,
	Dieter
