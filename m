Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280805AbRKBTgJ>; Fri, 2 Nov 2001 14:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280806AbRKBTf7>; Fri, 2 Nov 2001 14:35:59 -0500
Received: from user-119a3cr.biz.mindspring.com ([66.149.13.155]:31499 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S280805AbRKBTft>; Fri, 2 Nov 2001 14:35:49 -0500
Date: Fri, 2 Nov 2001 14:35:45 -0500
From: Jason Lunz <j@falooley.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx bug, 2.4.13/6.2.4
Message-ID: <20011102143545.A30381@trellisinc.com>
In-Reply-To: <20011101222455.A5885@orr.falooley.org> <200111021443.fA2EhRY46335@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111021443.fA2EhRY46335@aslan.scsiguy.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In mlist.linux-kernel, you wrote:
>>VFS: Disk change detected on device sr(11,1)
>>scsi0:0:3:0: Attempting to queue an ABORT message
>>scsi0: Dumping Card State while idle, at SEQADDR 0x7
> 
> Upper layer has timed out a command while the SCSI bus
> is idle.

I don't understand this. The error is in the middle of a CD rip
(actually the pre-rip of cdrdao where it looks at sub-channel info for
pre-gaps and such). The only way to get a timeout while the scsi bus
is idle would be if the drive just stopped cold, with the mid-layer
expecting it to go on, right?

>>ACCUM = 0x16, SINDEX = 0x37, DINDEX = 0x24, ARG_2 = 0x0
>>HCNT = 0x0
>>SCSISEQ = 0x12, SBLKCTL = 0x0
> 
> We have reselection on
> 
>>Kernel NEXTQSCB = 2
>>Card NEXTQSCB = 2
>>QINFIFO entries: 
> 
> No new commands to run.
> 
>>Disconnected Queue entries: 0:3 
> 
> At least one command is disconnected on a target.

I don't know what it means for a command to be disconnected. Can you
clarify that?

>>QOUTFIFO entries: 
>>Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
>>Pending list: 3
>>Kernel Free SCB list: 1 0 
>>Untagged Q(3): 3 
> 
> The disconnected command is for target 3.

Right, the DVD-ROM we're ripping from.

>>(scsi0:A:3:0): Queuing a recovery SCB
>>scsi0:0:3:0: Device is disconnected, re-queuing SCB
>>Recovery code sleeping
>>(scsi0:A:3:0): Abort Message Sent
>>(scsi0:A:3:0): SCB 3 - Abort Completed.
>>Recovery SCB completes
>>Recovery code awake
>>aic7xxx_abort returns 0x2002
> 
> We successfully selected the target and aborted the command.

The command that timed out, I'm assuming...

>>(scsi0:A:3:0): Unexpected busfree in Command phase
>>SEQADDR == 0x15c
> 
> This, I can't really explain unless the target is somewhat
> unstable just after an abort occurs.  I'd need to see a
> bus trace.

Possibly, but I hope not. This is otherwise the best optical drive I've
ever worked with, a new "Vendor: PIONEER  Model: DVD-ROM DVD-305".

>>scsi0:0:3:0: Attempting to queue a TARGET RESET message
>>scsi0:0:3:0: Command not found
> 
> The upper layer tells us to perform a target reset for
> a command that doesn't exist.  It was likely aborted
> by the unexpected bus free above, but the mid-layer ignores
> completions during error recovery.

ok, I think this is where the kernel starts to go wrong. The mid-layer
wants to reset the command that resulted in an "unexpected busfree",
which the driver and drive are already done with.

>>aic7xxx_dev_reset returns 0x2002
>>scsi0:0:3:0: Attempting to queue an ABORT message
>>scsi0: Dumping Card State while idle, at SEQADDR 0x7
>>ACCUM = 0xf7, SINDEX = 0x37, DINDEX = 0x24, ARG_2 = 0x0
> 
> Target decideds not to return our command again, so we
> are told to perform recovery.

It makes sense that the target wouldn't return the command if that
command already died. In that case, shouldn't we avoid trying to reset
it? Should the mid-layer not be requesting a reset at this point? Is
this part of the rumored 2.5 scsi rewrite?

>>(scsi0:A:3:0): Abort Message Sent
>>(scsi0:A:3:0): SCB 3 - Abort Completed.
>>Recovery SCB completes
>>Recovery code awake
>>aic7xxx_abort returns 0x2002
> 
> And we were successful.

we successfully aborted, but did we have to?

>>scsi: device set offline - not ready or command retry failed after bus reset: 
>>host 0 channel 0 id 3 lun 0
> 
> But the mid-layer has already decided that it can't recover this device,
> so it calls it dead and refuses to allow I/O to it anymore.

This is definitely wrong. The drive won't do anything now without a
reboot (or maybe removing and reinserting all scsi modules; I could do
that but I haven't tried it).

> Have you recently changed your version of cdrdao?  Perhaps that program
> is issuing a command that this particular drive simply will not accept?

This is the same drive and version of cdrdao that have ripped more than
100 CDs. It's just this particular CD that breaks in this way at the
same spot every time.

If the DVD-ROM can't handle that CD then that's fine, but it would be
nice if such a broken CD didn't result in not being able to use that
drive at all anymore.

thanks for your help,

Jason
