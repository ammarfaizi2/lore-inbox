Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289794AbSBONxS>; Fri, 15 Feb 2002 08:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289779AbSBONxF>; Fri, 15 Feb 2002 08:53:05 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59783 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289735AbSBONwr>; Fri, 15 Feb 2002 08:52:47 -0500
Date: Fri, 15 Feb 2002 08:54:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange disk-write speeds
In-Reply-To: <3C6CC4D9.C624F4A9@aitel.hist.no>
Message-ID: <Pine.LNX.3.95.1020215084359.9495B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Helge Hafting wrote:

> "Richard B. Johnson" wrote:
> > 
> > Weird. I have two identical SCSI drives. They both synchronize
> > at 40 Mb/s on my Buslogic controller. They are the two ...
> >     Vendor: SEAGATE  Model: ST318233LWV      Rev: 0002
> > ... drives shown below.
> > 
> > They both have ext2 file-systems occupying a single partition.
> > The time to write a file that fills up the file-system on the
> > "Id: 01" drive is about 1/2 an hour and the time to write a
> > file that fills up the file-system on "Id: 02" is about 1/2 day!
> > 
> > This is with the file created with "O_SYNC". If the file is
> > not created with "O_SYNC", there is no apparent difference in
> > write speed.
> > 
> > If I swap the jumpers on the two drives to isolate the drives
> > from the problem, the slooooo drive is the logical "ID: 02",
> > always... not the physical one!
> > 
> 
> O_SYNC writes takes different time depending on the scsi ID?
> 
> _Very_ strange, unless your /etc/fstab looks different for
> /dev/sdbX and /dev/sdcX  
> I.e. different mount options that indeed depend on scsi id.
> Also check to make sure nothing else is running and accessing
> any partition on sdc, that might force those sync writes
> to seek more.  (I guess the slow disk is noisy?)
> 
> Helge Hafting
> 

Well here are the buslogic statistics.

The faster drive completed more transactions for the same amount of
data written. This means that the faster drive used smaller buffers.
But, its not the drive that's faster, it's the logical order of
the drive. Maybe the SCSI command queue starts at the first drive
every time, rather than the next drive?? "Next" being one after the
previous access. So, the third drive doesn't have the resources that
the second one had, and the first one has all the resources of the
previously-completed commands.


***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
  Firmware Version: 5.06J, I/O Address: 0xB400, IRQ Channel: 11/Level
  PCI Bus: 0, Device: 12, Address: 0xDF000000, Host Adapter SCSI ID: 7
  Parity Checking: Enabled, Extended Translation: Enabled
  Synchronous Negotiation: UUUUUUF#UUUUUUUU, Wide Negotiation: Enabled
  Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
  Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
  Driver Queue Depth: 211, Host Adapter Queue Depth: 192
  Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
  Error Recovery Strategy: Default, SCSI Bus Reset: Enabled
  SCSI Bus Termination: High Enabled, SCAM: Disabled
*** BusLogic BT-958 Initialized Successfully ***

Target 0: Queue Depth 28, Wide Synchronous at 40.0 MB/sec, offset 15
Target 1: Queue Depth 28, Wide Synchronous at 40.0 MB/sec, offset 15
Target 2: Queue Depth 28, Wide Synchronous at 40.0 MB/sec, offset 15
Target 4: Queue Depth 3, Synchronous at 10.0 MB/sec, offset 15

Current Driver Queue Depth:	211
Currently Allocated CCBs:	91


			   DATA TRANSFER STATISTICS

Target	Tagged Queuing	Queue Depth  Active  Attempted	Completed
======	==============	===========  ======  =========	=========
   0	    Active	     28         0       190452	   190452
   1	    Active	     28         0      2299708	  2299708
   2	    Active	     28         0       517521	   517521
   4	Not Supported	      3         0        22140	    22140

Target  Read Commands  Write Commands   Total Bytes Read    Total Bytes Written
======  =============  ==============  ===================  ===================
   0	      91569	     98874             1526159872           5036346880
   1	      76628	   2223071                8503424          75675684864
   2	      13033	   2104479		   794752          74215583232
   4	         10	     21789		    20480	     713973760

Target  Command    0-1KB      1-2KB      2-4KB      4-8KB     8-16KB
======  =======  =========  =========  =========  =========  =========
   0	 Read	     27517       5195       5072       6402       3980
   0	 Write	      1765        820        315      25194       2302
   1	 Read	         0          2          0      48658       5550
   1	 Write	         0          0          0    1430296      88987
   2	 Read	         0          5          0       3837        531
   2	 Write	         0          0          0    1308773      10785
   4	 Read	         0          0         10          0          0
   4	 Write	         0          0          0          0          0

Target  Command   16-32KB    32-64KB   64-128KB   128-256KB   256KB+
======  =======  =========  =========  =========  =========  =========
   0	 Read	      2801      40254        221        127          0
   0	 Write	       831       3848      62437        130       1232
   1	 Read	      7713       7058       1907       5740          0
   1	 Write	      7855      16713     623979       1624      53617
   2	 Read	        89       8571          0          0          0
   2	 Write	      7776       9892     142436       1097      23720
   4	 Read	         0          0          0          0          0
   4	 Write	         1      21788          0          0          0


			   ERROR RECOVERY STATISTICS

	  Command Aborts      Bus Device Resets	  Host Adapter Resets
Target	Requested Completed  Requested Completed  Requested Completed
  ID	\\\\ Attempted ////  \\\\ Attempted ////  \\\\ Attempted ////
======	 ===== ===== =====    ===== ===== =====	   ===== ===== =====
   0	     0     0     0        0     0     0	       0     0     0
   1	     0     0     0        0     0     0	       0     0     0
   2	     0     0     0        0     0     0	       0     0     0
   4	     0     0     0        0     0     0	       0     0     0

External Host Adapter Resets: 0
Host Adapter Internal Errors: 0



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


