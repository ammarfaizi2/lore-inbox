Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTAXSJt>; Fri, 24 Jan 2003 13:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTAXSJs>; Fri, 24 Jan 2003 13:09:48 -0500
Received: from ns0.cobite.com ([208.222.80.10]:31244 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S261375AbTAXSJr>;
	Fri, 24 Jan 2003 13:09:47 -0500
Date: Fri, 24 Jan 2003 13:18:54 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Nick Piggin <piggin@cyberone.com.au>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59mm5, raid1 resync speed regression.
In-Reply-To: <3E31701E.4020101@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0301241311350.32240-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Mansfield wrote:
> 
> >Hi Andrew, list,
> >
> >I'm booting 2.5.59mm5 to run a database workload benchmark that I've been
> >running against various kernels.  I'll post those results if they are
> >interesting later, but I did notice that the raid1 resync is proceeding at
> >half the speed (at best) that it usually does (vs. 2.5.59 that is).
> >
> >It currently at about 4-8 mb/sec (and falling as resync progresses),
> >usually at 12-15 mb/sec.
> >
> >System is SMP 2xPIII 866mhz, 2GB ram, raid1 is two 15k U160 (running only
> >an Ultra speed :-( because the onboard controller sucks) SCSI disks, same
> >channel on aic7xxx.
> >
> >Kernel is 2.5.59-mm5 compiled with gcc version 2.96 20000731 (Red Hat 
> >Linux 7.3 2.96-112)
> >
> >David
> >
> Thanks for the report. Please do post any results you get.
> 
> What disk workload exactly does a RAID1 resync consist of?
> 

Well, I don't know the internals of it, but it goes something like: 

decide which half of the mirror is more current.  Read blocks from this 
partition, write to other.  Periodically update raid-superblock or 
something.  The partitions in my case are on separate SCSI disks.

The thing about it is, it attempts to throttle the sync speed to not
interfere too much with operation of the system (background resync could
suck up all i/o 'cycles' and make a system unusable) by monitoring the
amount of requests through the raid device itself.  The sysadmin can set a
'speed limit' in /proc to control this, but I have it really high, so it
*should* be syncing at max speed regardless of any i/o happening to the
raid device itself.

So it's a bit complicated.  You'd have to look at the code or ask someone 
(Neil Brown) who knows more about it.

.... I'm rebooting and looking at it again.  Here's something strange, if 
I let the system sit completely idle, the resync speed increases almost to 
the 'normal' rate, but causing any (minor) disk activity in another window 
causes the rate to plummet for minutes.

I think there's some strange interaction with the speed-limit code in the 
raid1 resync.

David

P.S. I'll post my benchmark date if/when available.


-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

