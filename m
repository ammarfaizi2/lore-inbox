Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291926AbSBNVEP>; Thu, 14 Feb 2002 16:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291913AbSBNVCm>; Thu, 14 Feb 2002 16:02:42 -0500
Received: from synapse.t30.physik.tu-muenchen.de ([129.187.186.221]:64438 "EHLO
	synapse.t30.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S291893AbSBNVCP>; Thu, 14 Feb 2002 16:02:15 -0500
To: linux-kernel@vger.kernel.org
Subject: performance bug in 2.4.18-rc1: writing to MO/DVD-RAM blocks reading from HDD
Content-Type: text/plain; charset=US-ASCII
From: Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Date: 14 Feb 2002 22:02:11 +0100
Message-ID: <rxxsn83rd4c.fsf@synapse.t30.physik.tu-muenchen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I don't know which subsystem of the kernel is broken, so I report this
performance bug of kernels 2.4.x here.

Copying a large file from HDD to MO makes a concurrent read from HDD
very very slow. This is my "benchmark":


#!/bin/bash
mount /mod
time dd if=/dev/hda of=/dev/null bs=1000000 count=100
cp /somewhere/very_large_file /mod & 
CPPID=$!
sleep 20
time dd if=/dev/hda of=/dev/null bs=1000000 count=100
kill $!


It first copies 100 MB from HDD to /dev/null and measures the elapsed
time. Then it copies the same 100 MB from HDD to /dev/null while a
very large (larger than there is space on the MO) file is copied from
HDD to the MO drive. Copying that very large file effectively blocks
reading the 100 MB, as you can see from the output (kernel 2.4.17):


100+0 records in
100+0 records out

real	0m10.117s
user	0m0.000s
sys	0m2.670s

100+0 records in
100+0 records out

real	1m21.802s
user	0m0.020s
sys	0m2.800s


Reading 100 MB during a large file is written to MO takes eight times
longer as reading without concurrently accessing the MO. I'd expect
the second read to take not much longer (at most twice as long) as the
first because the MO is very slow (2 MB/s or so). I consider this to
be a performance bug.

Here is a list of kernel versions I tried and benchmark results:

Kernel     HDD HDD+MO
2.4.6      10  81
2.4.17     10  82
2.4.18-rc1  9  56
2.5.5-pre1  9  11

HDD    = first real time in seconds (HDD read time only)
HDD+MO = second real time in seconds (HDD read time while writing to MO)

As you can see from the numbers, the bug is not present in kernel
2.5.5-pre1. (I had to compile with different compile options to get it
to compile though.)

The bug also does not show up when I do 'dd if=/dev/zero of=/mod/tmp
&' instead of the 'cp /somewhere/very_large_file /mod &'. Also,
reading from MO ('cp /mod/very_large_file &> /dev/null' or 'cp
/mod/very_large_file /somewhere') while reading from HDD does not do
any harm.

The system I used is a Pentium Pro 200 MHz with a Fujitsu SCSI 640 MB
MO drive, a single IDE HDD and 128 MB RAM. But the bug also shows up
when using an Athlon 700 MHz with a Toshiba ATAPI 4.7 GB DVD-RAM
drive, a single IDE HDD and 256 MB RAM (kernel 2.4.13, 2.4.17, I've
not yet tried 2.5.x on this system).


What is the reason for this obvious misbehaviour?

Can the performance of 2.5.5-pre1 be somehow backported to 2.4.x?


Thank you in advance,

Moritz
