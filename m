Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280815AbRKBUR4>; Fri, 2 Nov 2001 15:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280818AbRKBURr>; Fri, 2 Nov 2001 15:17:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280815AbRKBURf> convert rfc822-to-8bit; Fri, 2 Nov 2001 15:17:35 -0500
Date: Fri, 2 Nov 2001 15:17:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jason Lunz <j@falooley.org>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx bug, 2.4.13/6.2.4
In-Reply-To: <20011102143545.A30381@trellisinc.com>
Message-ID: <Pine.LNX.3.95.1011102145315.257B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Jason Lunz wrote:

> 
> In mlist.linux-kernel, you wrote:
> >>VFS: Disk change detected on device sr(11,1)
> >>scsi0:0:3:0: Attempting to queue an ABORT message
> >>scsi0: Dumping Card State while idle, at SEQADDR 0x7
> > 
> > Upper layer has timed out a command while the SCSI bus
> > is idle.
> 
> I don't understand this. The error is in the middle of a CD rip
> (actually the pre-rip of cdrdao where it looks at sub-channel info for
> pre-gaps and such). The only way to get a timeout while the scsi bus
> is idle would be if the drive just stopped cold, with the mid-layer
> expecting it to go on, right?
> 
> >>ACCUM = 0x16, SINDEX = 0x37, DINDEX = 0x24, ARG_2 = 0x0
> >>HCNT = 0x0
> >>SCSISEQ = 0x12, SBLKCTL = 0x0
> > 
> > We have reselection on
> > 
> >>Kernel NEXTQSCB = 2
> >>Card NEXTQSCB = 2
> >>QINFIFO entries: 
> > 
> > No new commands to run.
> > 
> >>Disconnected Queue entries: 0:3 
> > 
> > At least one command is disconnected on a target.
> 
> I don't know what it means for a command to be disconnected. Can you
> clarify that?
> 
> >>QOUTFIFO entries: 
> >>Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
> >>Pending list: 3
> >>Kernel Free SCB list: 1 0 
> >>Untagged Q(3): 3 
> > 
> > The disconnected command is for target 3.
> 
> Right, the DVD-ROM we're ripping from.
> 
> >>(scsi0:A:3:0): Queuing a recovery SCB
> >>scsi0:0:3:0: Device is disconnected, re-queuing SCB
> >>Recovery code sleeping
> >>(scsi0:A:3:0): Abort Message Sent
> >>(scsi0:A:3:0): SCB 3 - Abort Completed.
> >>Recovery SCB completes
> >>Recovery code awake
> >>aic7xxx_abort returns 0x2002
> > 
> > We successfully selected the target and aborted the command.
> 
> The command that timed out, I'm assuming...
> 
> >>(scsi0:A:3:0): Unexpected busfree in Command phase
> >>SEQADDR == 0x15c
> > 
> > This, I can't really explain unless the target is somewhat
> > unstable just after an abort occurs.  I'd need to see a
> > bus trace.
> 
> Possibly, but I hope not. This is otherwise the best optical drive I've
> ever worked with, a new "Vendor: PIONEER  Model: DVD-ROM DVD-305".
> 
> >>scsi0:0:3:0: Attempting to queue a TARGET RESET message
> >>scsi0:0:3:0: Command not found
> > 
> > The upper layer tells us to perform a target reset for
> > a command that doesn't exist.  It was likely aborted
> > by the unexpected bus free above, but the mid-layer ignores
> > completions during error recovery.
> 
> ok, I think this is where the kernel starts to go wrong. The mid-layer
> wants to reset the command that resulted in an "unexpected busfree",
> which the driver and drive are already done with.
> 
> >>aic7xxx_dev_reset returns 0x2002
> >>scsi0:0:3:0: Attempting to queue an ABORT message
> >>scsi0: Dumping Card State while idle, at SEQADDR 0x7
> >>ACCUM = 0xf7, SINDEX = 0x37, DINDEX = 0x24, ARG_2 = 0x0
> > 
> > Target decideds not to return our command again, so we
> > are told to perform recovery.
> 
> It makes sense that the target wouldn't return the command if that
> command already died. In that case, shouldn't we avoid trying to reset
> it? Should the mid-layer not be requesting a reset at this point? Is
> this part of the rumored 2.5 scsi rewrite?
> 
> >>(scsi0:A:3:0): Abort Message Sent
> >>(scsi0:A:3:0): SCB 3 - Abort Completed.
> >>Recovery SCB completes
> >>Recovery code awake
> >>aic7xxx_abort returns 0x2002
> > 
> > And we were successful.
> 
> we successfully aborted, but did we have to?
> 
> >>scsi: device set offline - not ready or command retry failed after bus reset: 
> >>host 0 channel 0 id 3 lun 0
> > 
> > But the mid-layer has already decided that it can't recover this device,
> > so it calls it dead and refuses to allow I/O to it anymore.
> 
> This is definitely wrong. The drive won't do anything now without a
> reboot (or maybe removing and reinserting all scsi modules; I could do
> that but I haven't tried it).
> 
> > Have you recently changed your version of cdrdao?  Perhaps that program
> > is issuing a command that this particular drive simply will not accept?
> 
> This is the same drive and version of cdrdao that have ripped more than
> 100 CDs. It's just this particular CD that breaks in this way at the
> same spot every time.
> 
> If the DVD-ROM can't handle that CD then that's fine, but it would be
> nice if such a broken CD didn't result in not being able to use that
> drive at all anymore.
> 
> thanks for your help,
> 
> Jason
> -

I don't think it's a NEW bug. The BusLogic also shows the same
problem on 2.4.1

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST32171W         Rev: 0484
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST318233LWV      Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST39102LW        Rev: 0005
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0b
  Type:   CD-ROM                           ANSI SCSI revision: 02

***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
  Firmware Version: 5.06J, I/O Address: 0xB400, IRQ Channel: 11/Level
  PCI Bus: 0, Device: 12, Address: 0xDE800000, Host Adapter SCSI ID: 7
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
   0	    Active	     28         0           71	       71
   1	    Active	     28         0         2279	     2279
   2	  Permitted	     28         0           23	       23
   4	Not Supported	      3         0            1	        1

Target  Read Commands  Write Commands   Total Bytes Read    Total Bytes Written
======  =============  ==============  ===================  ===================
   0	         68	         0		    36864	             0
   1	       1123	      1153		 19695616	       5369856
   2	         18	         2		    58368	          8192
   4	          0	         0		        0	             0

Target  Command    0-1KB      1-2KB      2-4KB      4-8KB     8-16KB
======  =======  =========  =========  =========  =========  =========
   0	 Read	        64          4          0          0          0
   0	 Write	         0          0          0          0          0
   1	 Read	         0          2          0        581         35
   1	 Write	         0          0          0       1018        129
   2	 Read	         0          5          0         13          0
   2	 Write	         0          0          0          2          0
   4	 Read	         0          0          0          0          0
   4	 Write	         0          0          0          0          0

Target  Command   16-32KB    32-64KB   64-128KB   128-256KB   256KB+
======  =======  =========  =========  =========  =========  =========
   0	 Read	         0          0          0          0          0
   0	 Write	         0          0          0          0          0
   1	 Read	       277        124        104          0          0
   1	 Write	         6          0          0          0          0
   2	 Read	         0          0          0          0          0
   2	 Write	         0          0          0          0          0
   4	 Read	         0          0          0          0          0
   4	 Write	         0          0          0          0          0


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

If I put a deliberate scratch in a Write-once CD, and attempt to
burn it with this:

  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0b

cdrecord -scanbus

Cdrecord release 1.8a35 Copyright (C) 1995-1999 Jörg Schilling
scsibus0:
	0,0,0	  0) 'SEAGATE ' 'ST32171W        ' '0484' Disk
	0,1,0	  1) 'SEAGATE ' 'ST318233LWV     ' '0002' Disk
	0,2,0	  2) 'SEAGATE ' 'ST39102LW       ' '0005' Disk
	0,3,0	  3) *
	0,4,0	  4) 'YAMAHA  ' 'CRW6416S        ' '1.0b' Removable CD-ROM
	0,5,0	  5) *
	0,6,0	  6) *
	0,7,0	  7) *


The result is a permanent SCSI bus error that requires the reset
or power switch to clear.

This, even though the BusLogic driver attempts to reset the bus
forever. There seems to be something that is detected as a SCSI
bus error, but isn't one. This makes the driver(s) think that
it has to reset the bus. However, whatever it finds isn't cleared
by the bus reset so it does it forever.

I think that the driver has to issue a 'TEST UNIT READY' command
and not reset the SCSI bus if the device responds. Since all the
devices on the SCSI bus will 'reboot' to their power-on state
when the SCSI bus is reset, the driver(s) have to reload all the
SCBs and queued commands after such a reset. The last time I looked,
they aborted queued commands, even though the bus reset had aborted
them anyway (if the device impliments a "hard" reset), or completed
any commands that were fully identified ("soft" reset). Note that
the driver "knows" what commands have completed. It can always
re-write or re-read anything to completely recover after a bus
reset. For hot-swap, the SCSI driver has got to be fairly robust
and be able to re-do anything without any fuss anyway.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


