Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSERERS>; Sat, 18 May 2002 00:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSERERR>; Sat, 18 May 2002 00:17:17 -0400
Received: from gear.torque.net ([204.138.244.1]:16656 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S315529AbSERERO>;
	Sat, 18 May 2002 00:17:14 -0400
Message-ID: <3CE5D4FC.DB2CC47E@torque.net>
Date: Sat, 18 May 2002 00:13:48 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Linux 2.4/2.5 SCSI considerably slower than FreeBSD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
>
> Marco Flohrer has posted an inquiry to de.comp.os.unix.linux.hardware
> [German] <slrnae8q66.go4.marco.flohrer@diamond.csn.tu-chemnitz.de> that his
> Seagate 36ES2 was slow with a DawiControl 2976UW (SYM53C875), only
> around 25 MB/s. I have the same observation with a Fujitsu MAH3182MP
> with an Adaptec 2940UW Pro which is not much faster. Either bus has an
> active LVD/SE terminator.
> 
> Single-user mode,
> time dd if=/dev/XXX of=/dev/null bs=65536 count=10240
> (671,1 MB) linear read.
> 
> Table shows throughput in decimal MB/s (M = 1,000,000)
> 
>                                2.5  2.4  FBSD        max.
> UWSCSI Fuj MAH3182MP  7200/min 32,1 29,4 35,1 TQ     40
> UDMA66 Max 4W060H4    5400/min 27,1 26,7 25,7        66
> UDMA66 IBM DTLA307045 7200/min 37,2 37,5 37,2 TQ 2.5 66
> UDMA66 WDC AC420400D  5400/min 15,5 15,5 15,5 TQ 2.5 66
>                                --------------
> table is in decimal MB/s.
> 
> 2.4:  Linux 2.4.19-pre2-ac3
> 2.5:  Linux 2.5.15
> FBSD: FreeBSD 4.6-RC (Tagged Queueing Broken)
> 
> The IDE drives are attached to a VIA 82C686 (KT133), the Fujitsu
> (actually an U-160 drive) to the mentioned Adaptec.
> 
> FBSD gets about 20% better throughput. It's far from perfect, but 90% of
> the maximum is probably almost as good as we can get.
> 
> Why is Linux SCSI so slow?

With a Fujitsu MAM3184 (U160, 15Krpm 18GB) disk and a Tekram
DC-390U3W controller (sym53c8xx_2 driver) on lk 2.5.15 I get:

$ time dd if=/dev/sdb of=/dev/null bs=64k count=16k
16384+0 records in
16384+0 records out
real 0m18.948s  user 0m0.010s  sys 0m4.090s  

That is 56.67 MB/sec (MB == 10^6).

$ time sg_dd if=/dev/sg1 of=/dev/null bs=512 count=2m time=1
time to transfer data was 18.786448 secs, 57.16 MB/sec
2097152+0 records in
2097152+0 records out
real 0m18.799s  user 0m0.030s  sys 0m3.010s

$ time sgm_dd if=/dev/sg1 of=/dev/null bs=512 count=2m time=1
time to transfer data was 18.777035 secs, 57.18 MB/sec
2097152+0 records in
2097152+0 records out
real 0m18.781s  user 0m0.020s  sys 0m0.100s

The MAM3184 disk was recently reviewed 
( see http://www4.tomshardware.com/storage/02q2/020415/index.html )
and those speeds are very close to the maximum in their benchmarks
(and Fujitsu's published specifications) for outer track reads.

I am impressed by dd's performance in the lk 2.5 series.
When sg_dd and sgm_dd are used they bypass the block subsystem
and issue 64KB SCSI read commands (in this case). As can be seen
above, this improves the throughput by about 1 % compared to dd. 
CPU utilization (on a Athlon 1.2 GHz box with 512 MB of DDR ram) 
is a little more expensive with dd (4 seconds compared with 3 
seconds). The "sgm_dd" command uses mmap() to do "zero copy" reads 
which is why its CPU utilization is so low.

>From memory, dd's performance in the lk 2.4 series was considerably
lower than sg_dd. No doubt FreeBSD would also perform well but I
doubt it could beat linux (2.5) by the type of margin your measurements
indicate. [For sequential reads, tagged queueing will not have a
significant impact.] It is also worth noting that the new aic7xxx
and sym53c8xx_2 drivers are essentially the same on Linux and
FreeBSD (i.e. same code base, same maintainers).


Using scsi_debug (a ram disk) as a dummy scsi load yields:
# time dd if=/dev/sdc of=/dev/null bs=64k count=2k
2048+0 records in
2048+0 records out
real 0m1.082s  user 0m0.000s  sys 0m0.990s
That's 124 MB/sec and the CPU utilization is dominating. The
"sgm_dd" command yields 850 MB/sec for the same transfer.

Doug Gilbert
