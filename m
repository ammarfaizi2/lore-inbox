Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137164AbREKQPw>; Fri, 11 May 2001 12:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137165AbREKQPm>; Fri, 11 May 2001 12:15:42 -0400
Received: from shine.micron.net ([204.229.122.198]:41148 "EHLO
	shine.micron.net") by vger.kernel.org with ESMTP id <S137164AbREKQPa>;
	Fri, 11 May 2001 12:15:30 -0400
Date: Fri, 11 May 2001 10:15:20 -0600 (MDT)
From: null <null@null.com>
To: linux-kernel@vger.kernel.org
Subject: nasty SCSI performance drop-outs (potential test case)
Message-ID: <Pine.LNX.4.21.0105111006390.32238-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SMTP-HELO: cboi04p38.boi.micron.net
X-SMTP-MAIL-FROM: null@null.com
X-SMTP-PEER-INFO: cboi04p38.boi.micron.net [206.207.109.39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


