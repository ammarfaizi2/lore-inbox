Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262714AbREVSlK>; Tue, 22 May 2001 14:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbREVSlB>; Tue, 22 May 2001 14:41:01 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:39847 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S262714AbREVSkv>; Tue, 22 May 2001 14:40:51 -0400
Date: Tue, 22 May 2001 11:39:06 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: null <null@null.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bdflush/mm performance drop-out defect (more info)
In-Reply-To: <Pine.LNX.4.21.0105221114120.32238-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0105221123450.214-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 May 2001, null wrote:

> Here is some additional info about the 2.4 performance defect.
>
> Only one person offered a suggestion about the use of HIGHMEM.  I tried
> with and without HIGHMEM enabled with the same results.  However, it does
> appear to take a bit longer to reach performance drop-out condition when
> HIGHMEM is disabled.
>
> The same system degradation also appears when using partitions on a single
> internal SCSI drive, but seems to happen only when performing the I/O in
> parallel processes.  It appears that the load must be sustained long
> enough to affect some buffer cache behavior.  Parallel dd commands
> (if=/dev/zero) also reveal the problem.  I still need to do some
> benchmarks, but it looks like 2.4 kernels achieve roughly 25% (or less?)
> of the throughput of the 2.2 kernels under heavy parallel loads (on
> identical hardware).  I've also confirmed the defect on a dual-processor
> Xeon system with 2.4.  The defect exists whether drivers are built-in or
> compiled as modules, altho the parallel mkfs test duration improves by as
> much as 50% in some cases when using a kernel with built-in SCSI drivers.

That's a very interesting observation.  May I suggest that the problem may
be the driver for your SCSI device?  I just ran some tests of parallel I/O
on a 2 CPU Intel Pentium III 800 MHz with 2GB main memory, on a single
Seagate Barracuda ST336704LWV attached to a AIC7896.  The system
controller is Intel 440GX.  The kernel is 2.4.3-ac7:

jwb@windmill:~$ for i in 1 2 3 4 5 6 7 8 9 10; do time dd if=/dev/zero
of=/tmp/$i bs=4096 count=25600 & done;

This spawns 10 writers of 100MB files on the same filesystem.  While all
this went on, the system was responsive, and vmstat showed a steady block
write of at least 20000 blocks/second.  Meanwhile this machine also has
constantly used mysql and postgresql database systems and a few
interactive users.

The test completed in 19 seconds and 24 seconds on separate runs.

I also performed this test on a machine with 2 Intel Pentium III 933 MHz
CPUs, 512MB main memory, an Intel 840 system controller, and a Quantum 10K
II 9GB drive attached to an Adaptec 7899P controller, using kernel
2.4.4-ac8.  I had no problems there either, and the test completed in 30
seconds (with a nearly full disk).

I also didn't see this problem on an Apple Powerbook G4 nor on another
Intel machine with a DAC960 RAID.

In short, I'm not seeing this problem.

Regards,
Jeffrey Baker

