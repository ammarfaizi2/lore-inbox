Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424167AbWKPSJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424167AbWKPSJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 13:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424306AbWKPSJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 13:09:07 -0500
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:5650 "EHLO
	sentry.sandia.gov") by vger.kernel.org with ESMTP id S1424304AbWKPSJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 13:09:06 -0500
X-Server-Uuid: 90CB8AE7-3E4E-4A99-82E1-C9C733D7F589
Subject: splice/vmsplice performance test results
From: "Jim Schutt" <jaschut@sandia.gov>
To: linux-kernel@vger.kernel.org
cc: jens.axboe@oracle.com
Date: Thu, 16 Nov 2006 11:08:59 -0700
Message-ID: <1163700539.2672.14.camel@sale659.sandia.gov>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27)
X-TMWD-Spam-Summary: TS=20061116180901; SEV=2.2.0; DFV=B2006111608;
 IFV=2.0.4,4.0-9; AIF=B2006111608; RPD=5.02.0004; ENG=IBF; RPDID=NA;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2006111608_5.02.0004_4.0-9
X-WSS-ID: 694276B62JC4064092-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've done some testing to see how splice/vmsplice perform
vs. other alternatives on transferring a large file across
a fast network.  One option I tested was to use vmsplice 
to get a 1-copy receive, but it didn't perform as well 
as I had hoped.  I was wondering if my results were at odds
with what other people have observed.

I've two systems, each with:
  Tyan S2895 motherboard
  2 ea. 2.6 GHz Opteron
  1 GiB memory
  Myricom Myri-10G 10 Gb/s NIC (PCIe x8)
  2.6.19-rc5-g134a11f0 on FC4

In addition, one system has a 3ware 9590-8ML (PCIe) and a 3ware
9550SX-8LP (PCI-X), with 16 Seagate Barracuda 7200.10 SATA drives 
(250 GB ea., NCQ enabled).  Write caching is enabled on the 3ware
cards.

The Myricom cards are connected back-to-back using 9000 byte MTU. 
I baseline the network performance with 'iperf -w 1M -l 64K'
and get 6.9 Gb/s.

After a fair amount of testing, I settled on a 4-way software
RAID0 on top of 4-way hardware RAID0 units as giving the best
streaming performance.  The file system is XFS, with the stripe
unit set to the hardware RAID chunk size, and the stripe width 
16 times that.  

Disk tuning parameters in /sys/block/sd*/queue are default
values, except queue/nr_requests = 5 gives me best performance.
(It seems like the 3ware cards slow down a little if I feed them 
too much data on the streaming write test I'm using.)

I baseline file write performance with 
  sync; time { dd if=/dev/zero of=./zero bs=32k count=512k; sync; }
and get 465-520 MB/s (highly variable).

I test baseline file read performance with
  time dd if=./zero of=/dev/null bs=32k count=512k
and get 950 MB/s (fairly repeatable).

My test program can do one of the following:

send data:
 A) read() from file into buffer, write() buffer into socket
 B) mmap() section of file, write() that into socket, munmap()
 C) splice() from file to pipe, splice() from pipe to socket

receive data:
 1) read() from socket into buffer, write() buffer into file
 2) ftruncate() to extend file, mmap() new extent, read() 
      from socket into new extent, munmap()
 3) read() from socket into buffer, vmsplice() buffer to 
     pipe, splice() pipe to file (using the double-buffer trick)

Here's the results, using:
 - 64 KiB buffer, mmap extent, or splice
 - 1 MiB TCP window
 - 16 GiB data sent across network

A) from /dev/zero -> 1) to /dev/null : 857 MB/s (6.86 Gb/s)

A) from file      -> 1) to /dev/null : 472 MB/s (3.77 Gb/s)
B) from file      -> 1) to /dev/null : 366 MB/s (2.93 Gb/s)
C) from file      -> 1) to /dev/null : 854 MB/s (6.83 Gb/s)

A) from /dev/zero -> 1) to file      : 375 MB/s (3.00 Gb/s)
A) from /dev/zero -> 2) to file      : 150 MB/s (1.20 Gb/s)
A) from /dev/zero -> 3) to file      : 286 MB/s (2.29 Gb/s)

I had (naively) hoped the read/vmsplice/splice combination would 
run at the same speed I can write a file, i.e. at about 450 MB/s
on my setup.  Do any of my numbers seem bogus, so I should look 
harder at my test program?

Or is read+write really the fastest way to get data off a
socket and into a file?

-- Jim Schutt

(Please Cc: me, as I'm not subscribed to lkml.)


