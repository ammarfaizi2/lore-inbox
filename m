Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262690AbREVRwr>; Tue, 22 May 2001 13:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbREVRwh>; Tue, 22 May 2001 13:52:37 -0400
Received: from shine.micron.net ([204.229.122.198]:35736 "EHLO
	shine.micron.net") by vger.kernel.org with ESMTP id <S262690AbREVRw1>;
	Tue, 22 May 2001 13:52:27 -0400
Date: Tue, 22 May 2001 11:52:15 -0600 (MDT)
From: null <null@null.com>
To: linux-kernel@vger.kernel.org
Subject: bdflush/mm performance drop-out defect (more info)
Message-ID: <Pine.LNX.4.21.0105221114120.32238-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SMTP-HELO: cboi05130.boi.micron.net
X-SMTP-MAIL-FROM: null@null.com
X-SMTP-PEER-INFO: cboi05130.boi.micron.net [209.19.171.131]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is some additional info about the 2.4 performance defect.

Only one person offered a suggestion about the use of HIGHMEM.  I tried
with and without HIGHMEM enabled with the same results.  However, it does
appear to take a bit longer to reach performance drop-out condition when
HIGHMEM is disabled.

The same system degradation also appears when using partitions on a single
internal SCSI drive, but seems to happen only when performing the I/O in
parallel processes.  It appears that the load must be sustained long
enough to affect some buffer cache behavior.  Parallel dd commands
(if=/dev/zero) also reveal the problem.  I still need to do some
benchmarks, but it looks like 2.4 kernels achieve roughly 25% (or less?)
of the throughput of the 2.2 kernels under heavy parallel loads (on
identical hardware).  I've also confirmed the defect on a dual-processor
Xeon system with 2.4.  The defect exists whether drivers are built-in or
compiled as modules, altho the parallel mkfs test duration improves by as
much as 50% in some cases when using a kernel with built-in SCSI drivers.

During the periods when the console is frozen, the activity lights on the
device are also idle.  These idle periods last between 30 seconds up to
several minutes, then there is a burst of about 10 to 15 seconds of I/O
activity to the device.

The 2.2 kernels appear to have none of these issues.

Maybe someone can confirm this behavior on more systems using the test
case below.  It's extremely repeatable in all of the environments I've
tried.  A Windows colleague is beginning to wonder why I don't just
downgrade to 2.2 to avoid this problem, but then he reminds me that
Windows has better SMP performance than the 2.2 kernels.  8)

I've about reached the point where I'm going to have to take his advice.


---------- Forwarded message ----------
Date: Fri, 11 May 2001 10:15:20 -0600 (MDT)
From: null <null@null.com>
To: linux-kernel@vger.kernel.org
Subject: nasty SCSI performance drop-outs (potential test case)

On Tue, 10 Apr 2001, Rik van Riel wrote:
> On Tue, 10 Apr 2001, Alan Cox wrote:
> 
> > > Any time I start injecting lots of mail into the qmail queue,
> > > *one* of the two processors gets pegged at 99%, and it takes forever
> > > for anything typed at the console to actually appear (just as you
> > > describe).
> > 
> > Yes I've seen this case. Its partially still a mystery
>
> I've seen it too.  It could be some interaction between kswapd
> and bdflush ... but I'm not sure what the exact cause would be.
>
> regards,
>
> Rik

Hopefully a repeatable test case will help "flush" this bug out of the
kernel.  Has anyone tried doing mkfs in parallel?  Here are some data
points (which are repeatable even up to 2.4.5-pre1):

Unless noted, results are based on:
stock RedHat7.1 configuration with 2.4.2 kernel (or any recent 2.4 kernel)
default RedHat7.1 (standard?) kupdated parameter settings
6-way 700Mhz Xeon server, with 1.2 GB of system RAM
SCSI I/O with qlogicfc or qla2x00 low-level driver
ext2 filesystem

Case 1:  ------------
Elapsed time to make a single 5GB ext2 filesystem in this configuration is
about 2.6 seconds (time mkfs -F /dev/sdx &).

Time to mkfs two 5GB LUNs sequencially is then 5.2 seconds.

Time to mkfs the same two 5GB LUNs in parallel is 54 seconds.  Hmmm.
Bandwidth on two CPUs is totally consumed (99.9%) and a third CPU is
usually consumed by the kupdated process.  Activity lights on the storage
device are mostly idle during this time.


Case 2:  -------------
Elapsed time to make a single 14GB ext2 filesystem is 8.1 seconds.

Time to mkfs eight 14GB LUNs sequencially is 1 minute 15 seconds.

Time to mkfs the same eight 14GB LUNs in parallel is 57 minutes and 23
seconds.  Yikes.  Bandwidth of all 6 CPUs is completely consumed and
the system becomes completely unresponsive.  Can't even log in from the
console during this period.  Activity lights on the device blink rarely.

For comparison, the same parallel mkfs test on the exact same device and
the exact same eight 14GB LUNs can be completed in 1 minute and 40 seconds
on a 4-way 550Mhz Xeon server running 2.2.16 kernel (RH6.2) and the system
is quite responsive the entire time.

-------------

I have not seen data corruptions in any of these test cases or with live
data.  In another test I tried one mkfs to the external device in parallel
with a mkfs to an internal SCSI drive (Megaraid ctrlr) with the same
drop-out in performance.

Hopefully others can easily repeat this behavior.  I suppose that parallel
mkfs could represent a rare corner case of sequencial writes, but I've
seen the same issue with almost any parallel SCSI I/O workload.  No idea
why sequencial mkfs isn't affected tho.  As it stands, for high traffic
server environments, the 2.2 kernels have well beyond an order of
magnitude better performance on the same equipment.  If others can repeat
this result the 2.4 kernels are not quite buzzword compliant.  8)




