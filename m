Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbRGYVSu>; Wed, 25 Jul 2001 17:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbRGYVSl>; Wed, 25 Jul 2001 17:18:41 -0400
Received: from rj.sgi.com ([204.94.215.100]:20177 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S267338AbRGYVSh>;
	Wed, 25 Jul 2001 17:18:37 -0400
Message-Id: <200107252118.f6PLIV305181@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, Rik van Riel <riel@conectiva.com.br>,
        jlnance@intrex.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Optimization for use-once pages 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Wed, 25 Jul 2001 03:30:34 +0200." <0107250330340D.00520@starship> 
Date: Wed, 25 Jul 2001 16:18:31 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> On Wednesday 25 July 2001 02:43, Anton Altaparmakov wrote:
> > At 01:04 25/07/2001, Daniel Phillips wrote:
> > >At that size you'd run a real risk of missing the tell-tale multiple
> > >references that mark a page as frequently used.  Think about
> > > metadata here (right now, that usually just means directory pages,
> > > but later... who knows).
> >
> > This is not actually implemented yet, but NTFS TNG will use the page
> > cache to hold both the LCN (physical clusters) and MFT (on disk
> > inodes) allocation bitmaps in addition to file and directory pages.
> > (Admittedly the LCN case folds into the file pages in page cache one
> > as the LCN bitmap is just stored inside the usual data of a file
> > called $Bitmap, but the MFT case is more complex as it is in an
> > additional attribute inside the file $MFT so the normal file
> > read/write functions definitely cannot be used. The usual data here
> > is the actual on disk inodes...)
> >
> > Just FYI.
> 
> Yes, not a surprise.  Plus, I was working on an experimental patch to 
> put Ext2 index blocks into the page cache just before I got off on this 
> use-once tangent.  Time to go back to that...
> 
> --
> Daniel
> -

So here is a datapoint from a filesystem which uses pages for all of its
data and metadata, XFS. These are for 2.4.7 with and without the patch.
XFS metadata is held in a special address space, when not in use by XFS
the vm is free to reclaim it via the usual page reclaim methods, so XFS
is probably fairly heavily influenced by a change like this.

All runs on a 2 cpu 450MHz PIII with 128M of memory, single scsi partition.

1. dbench runs at various loads back to back, starting with
   the highest load, 3 runs of each load):

Vanilla 2.4.7 xfs

64
=====
Throughput 6.77363 MB/sec (NB=8.46704 MB/sec  67.7363 MBit/sec)
Throughput 7.03715 MB/sec (NB=8.79644 MB/sec  70.3715 MBit/sec)
Throughput 7.11706 MB/sec (NB=8.89632 MB/sec  71.1706 MBit/sec)
48
=====
Throughput 8.50251 MB/sec (NB=10.6281 MB/sec  85.0251 MBit/sec)
Throughput 8.38426 MB/sec (NB=10.4803 MB/sec  83.8426 MBit/sec)
Throughput 8.58152 MB/sec (NB=10.7269 MB/sec  85.8152 MBit/sec)
32
=====
Throughput 11.6378 MB/sec (NB=14.5473 MB/sec  116.378 MBit/sec)
Throughput 11.7586 MB/sec (NB=14.6983 MB/sec  117.586 MBit/sec)
Throughput 12.0686 MB/sec (NB=15.0858 MB/sec  120.686 MBit/sec)
16
=====
Throughput 16.9877 MB/sec (NB=21.2346 MB/sec  169.877 MBit/sec)
Throughput 16.9502 MB/sec (NB=21.1877 MB/sec  169.502 MBit/sec)
Throughput 16.8703 MB/sec (NB=21.0878 MB/sec  168.703 MBit/sec)
8
=====
Throughput 36.085 MB/sec (NB=45.1062 MB/sec  360.85 MBit/sec)
Throughput 31.8114 MB/sec (NB=39.7642 MB/sec  318.114 MBit/sec)
Throughput 36.0801 MB/sec (NB=45.1001 MB/sec  360.801 MBit/sec)
4
=====
Throughput 42.7741 MB/sec (NB=53.4677 MB/sec  427.741 MBit/sec)
Throughput 46.2591 MB/sec (NB=57.8239 MB/sec  462.591 MBit/sec)
Throughput 42.8487 MB/sec (NB=53.5608 MB/sec  428.487 MBit/sec)
2
=====
Throughput 48.776 MB/sec (NB=60.97 MB/sec  487.76 MBit/sec)
Throughput 48.4417 MB/sec (NB=60.5522 MB/sec  484.417 MBit/sec)
Throughput 47.0938 MB/sec (NB=58.8673 MB/sec  470.938 MBit/sec)
1
=====
Throughput 32.0957 MB/sec (NB=40.1196 MB/sec  320.957 MBit/sec)
Throughput 32.1901 MB/sec (NB=40.2376 MB/sec  321.901 MBit/sec)
Throughput 31.3972 MB/sec (NB=39.2465 MB/sec  313.972 MBit/sec)

2.4.7 xfs + patch

64
=====
Throughput 8.99448 MB/sec (NB=11.2431 MB/sec  89.9448 MBit/sec)
Throughput 9.07137 MB/sec (NB=11.3392 MB/sec  90.7137 MBit/sec)
Throughput 9.09924 MB/sec (NB=11.3741 MB/sec  90.9924 MBit/sec)
48
=====
Throughput 10.7328 MB/sec (NB=13.416 MB/sec  107.328 MBit/sec)
Throughput 10.791 MB/sec (NB=13.4887 MB/sec  107.91 MBit/sec)
Throughput 10.9185 MB/sec (NB=13.6482 MB/sec  109.185 MBit/sec)
32
=====
Throughput 12.6625 MB/sec (NB=15.8282 MB/sec  126.625 MBit/sec)
Throughput 12.7601 MB/sec (NB=15.9501 MB/sec  127.601 MBit/sec)
Throughput 12.6732 MB/sec (NB=15.8415 MB/sec  126.732 MBit/sec)
16
=====
Throughput 19.5692 MB/sec (NB=24.4614 MB/sec  195.692 MBit/sec)
Throughput 19.6163 MB/sec (NB=24.5204 MB/sec  196.163 MBit/sec)
Throughput 19.6773 MB/sec (NB=24.5966 MB/sec  196.773 MBit/sec)
8
=====
Throughput 36.8323 MB/sec (NB=46.0404 MB/sec  368.323 MBit/sec)
Throughput 36.9346 MB/sec (NB=46.1683 MB/sec  369.346 MBit/sec)
Throughput 36.4622 MB/sec (NB=45.5778 MB/sec  364.622 MBit/sec)
4
=====
Throughput 42.883 MB/sec (NB=53.6037 MB/sec  428.83 MBit/sec)
Throughput 42.1596 MB/sec (NB=52.6995 MB/sec  421.596 MBit/sec)
Throughput 42.9602 MB/sec (NB=53.7002 MB/sec  429.602 MBit/sec)
2
=====
Throughput 44.2798 MB/sec (NB=55.3498 MB/sec  442.798 MBit/sec)
Throughput 39.5441 MB/sec (NB=49.4301 MB/sec  395.441 MBit/sec)
Throughput 46.8569 MB/sec (NB=58.5711 MB/sec  468.569 MBit/sec)
1
=====
Throughput 32.0682 MB/sec (NB=40.0852 MB/sec  320.682 MBit/sec)
Throughput 32.1923 MB/sec (NB=40.2403 MB/sec  321.923 MBit/sec)
Throughput 32.1677 MB/sec (NB=40.2097 MB/sec  321.677 MBit/sec)

A definite improvement under high loads, and the lower loads appear
about the same. I reran the dbench 2 numbers and got results in line
with the non patched kernel.

2. Kernel builds

Unmodified kernel:

time make -j3 bzImage
948.880u 70.660s 8:45.88 193.8% 0+0k 0+0io 721072pf+0w
948.360u 69.950s 8:43.68 194.4% 0+0k 0+0io 721072pf+0w

Patched kernel:
942.660u 54.320s 8:29.49 195.6% 0+0k 0+0io 721044pf+0w
942.150u 54.900s 8:29.35 195.7% 0+0k 0+0io 721041pf+0w

Looks good to me, 22% less system time for the kernel build
is pretty good, also looks like my cpus are slower than most
people's nowadays :-(

Steve


