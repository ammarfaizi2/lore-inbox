Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280705AbRKBOnq>; Fri, 2 Nov 2001 09:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280708AbRKBOng>; Fri, 2 Nov 2001 09:43:36 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:1801 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S280705AbRKBOnc>;
	Fri, 2 Nov 2001 09:43:32 -0500
Message-Id: <200111021443.fA2EhRY46335@aslan.scsiguy.com>
To: Jason Lunz <j@falooley.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx bug, 2.4.13/6.2.4 
In-Reply-To: Your message of "Thu, 01 Nov 2001 22:24:55 EST."
             <20011101222455.A5885@orr.falooley.org> 
Date: Fri, 02 Nov 2001 07:43:27 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I'm having troubles with the last few revisions of the new Gibbs aic7xxx
>driver that until now has served me well. This is kernel
>2.4.13-preempt-lvmrc4 with the 6.2.4 scsi driver, but I saw it happen on
>2.4.12 with 6.2.1. I haven't tried older versions with this CD.

Its not clear to me that this is the driver's fault.  Let's look at
the abort log.

>And this appears in the kernel output:
>
>VFS: Disk change detected on device sr(11,1)
>scsi0:0:3:0: Attempting to queue an ABORT message
>scsi0: Dumping Card State while idle, at SEQADDR 0x7

Upper layer has timed out a command while the SCSI bus
is idle.

>ACCUM = 0x16, SINDEX = 0x37, DINDEX = 0x24, ARG_2 = 0x0
>HCNT = 0x0
>SCSISEQ = 0x12, SBLKCTL = 0x0

We have reselection on

>Kernel NEXTQSCB = 2
>Card NEXTQSCB = 2
>QINFIFO entries: 

No new commands to run.

>Disconnected Queue entries: 0:3 

At least one command is disconnected on a target.

>QOUTFIFO entries: 
>Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
>Pending list: 3
>Kernel Free SCB list: 1 0 
>Untagged Q(3): 3 

The disconnected command is for target 3.

>DevQ(0:2:0): 0 waiting
>DevQ(0:3:0): 0 waiting

All of the rest of the state is normal.

>(scsi0:A:3:0): Queuing a recovery SCB
>scsi0:0:3:0: Device is disconnected, re-queuing SCB
>Recovery code sleeping
>(scsi0:A:3:0): Abort Message Sent
>(scsi0:A:3:0): SCB 3 - Abort Completed.
>Recovery SCB completes
>Recovery code awake
>aic7xxx_abort returns 0x2002

We successfully selected the target and aborted the command.

>(scsi0:A:3:0): Unexpected busfree in Command phase
>SEQADDR == 0x15c

This, I can't really explain unless the target is somewhat
unstable just after an abort occurs.  I'd need to see a
bus trace.

>scsi0:0:3:0: Attempting to queue a TARGET RESET message
>scsi0:0:3:0: Command not found

The upper layer tells us to perform a target reset for
a command that doesn't exist.  It was likely aborted
by the unexpected bus free above, but the mid-layer ignores
completions during error recovery.

>aic7xxx_dev_reset returns 0x2002
>scsi0:0:3:0: Attempting to queue an ABORT message
>scsi0: Dumping Card State while idle, at SEQADDR 0x7
>ACCUM = 0xf7, SINDEX = 0x37, DINDEX = 0x24, ARG_2 = 0x0

Target decideds not to return our command again, so we
are told to perform recovery.

>(scsi0:A:3:0): Abort Message Sent
>(scsi0:A:3:0): SCB 3 - Abort Completed.
>Recovery SCB completes
>Recovery code awake
>aic7xxx_abort returns 0x2002

And we were successful.

>scsi: device set offline - not ready or command retry failed after bus reset: 
>host 0 channel 0 id 3 lun 0

But the mid-layer has already decided that it can't recover this device,
so it calls it dead and refuses to allow I/O to it anymore.

>I'm happy to help investigate further if there's anything you want to
>try. Let me know if you need any other output or have a patch I can try
>out.

Have you recently changed your version of cdrdao?  Perhaps that program
is issuing a command that this particular drive simply will not accept?

--
Justin
