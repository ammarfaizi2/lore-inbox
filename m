Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280813AbRKBUEE>; Fri, 2 Nov 2001 15:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280814AbRKBUDz>; Fri, 2 Nov 2001 15:03:55 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:27402 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S280813AbRKBUDg>; Fri, 2 Nov 2001 15:03:36 -0500
Message-Id: <200111022003.fA2K3WY50622@aslan.scsiguy.com>
To: Jason Lunz <j@falooley.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx bug, 2.4.13/6.2.4 
In-Reply-To: Your message of "Fri, 02 Nov 2001 14:35:45 EST."
             <20011102143545.A30381@trellisinc.com> 
Date: Fri, 02 Nov 2001 13:03:32 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In mlist.linux-kernel, you wrote:
>>>VFS: Disk change detected on device sr(11,1)
>>>scsi0:0:3:0: Attempting to queue an ABORT message
>>>scsi0: Dumping Card State while idle, at SEQADDR 0x7
>> 
>> Upper layer has timed out a command while the SCSI bus
>> is idle.
>
>I don't understand this. The error is in the middle of a CD rip
>(actually the pre-rip of cdrdao where it looks at sub-channel info for
>pre-gaps and such). The only way to get a timeout while the scsi bus
>is idle would be if the drive just stopped cold, with the mid-layer
>expecting it to go on, right?

A quick discussion about "disconnection" on a SCSI bus may be helpful
here.  Since the SCSI bus is shared, devices often tell the initiator
(of the command, in this case your Adaptec controller), "I'm dropping
off the bus for a while to do more work on this command, but I'll
get back to you".  This "disconnection" allows other devices that are
ready to accept or send additional data to use the bus.  In the message
above, the aic7xxx driver says that the adapter is currently idle.  This
means that it is not currently talking to any device on the bus.  Another
initiator may be talking to someone but this will only occur if you
happen to be in a multi-initiator environment (e.g. clustering).

So why might the bus be idle?  Well, your Pioneer could be trying
"really hard" to read a sector of data that is hard to read.  If
the application setting the timeout for this particular command
has set it too short, we may timeout the command before the drive
has given up on its attempts to recover this sector.

>>>ACCUM = 0x16, SINDEX = 0x37, DINDEX = 0x24, ARG_2 = 0x0
>>>HCNT = 0x0
>>>SCSISEQ = 0x12, SBLKCTL = 0x0
>> 
>> We have reselection on

Meaning that a device can engage us to pick up where we
left off on a disconnected transaction.

>>>(scsi0:A:3:0): SCB 3 - Abort Completed.
>>>Recovery SCB completes
>>>Recovery code awake
>>>aic7xxx_abort returns 0x2002
>> 
>> We successfully selected the target and aborted the command.
>
>The command that timed out, I'm assuming...

Yup.

>>>(scsi0:A:3:0): Unexpected busfree in Command phase
>>>SEQADDR == 0x15c
>> 
>> This, I can't really explain unless the target is somewhat
>> unstable just after an abort occurs.  I'd need to see a
>> bus trace.
>
>Possibly, but I hope not. This is otherwise the best optical drive I've
>ever worked with, a new "Vendor: PIONEER  Model: DVD-ROM DVD-305".

Well, I can't say for sure without a bus analyzer.  I don't happen
to have access to one of these drives to test it out here.  I'd
probably need your particular disc to replicate this too.

>>>scsi0:0:3:0: Attempting to queue a TARGET RESET message
>>>scsi0:0:3:0: Command not found
>> 
>> The upper layer tells us to perform a target reset for
>> a command that doesn't exist.  It was likely aborted
>> by the unexpected bus free above, but the mid-layer ignores
>> completions during error recovery.
>
>ok, I think this is where the kernel starts to go wrong. The mid-layer
>wants to reset the command that resulted in an "unexpected busfree",
>which the driver and drive are already done with.

Yeah, but we told the upper layer that we successfully killed it,
so it should go on.  The real killer is below.

>>>aic7xxx_dev_reset returns 0x2002
>>>scsi0:0:3:0: Attempting to queue an ABORT message
>>>scsi0: Dumping Card State while idle, at SEQADDR 0x7
>>>ACCUM = 0xf7, SINDEX = 0x37, DINDEX = 0x24, ARG_2 = 0x0
>> 
>> Target decideds not to return our command again, so we
>> are told to perform recovery.
>
>It makes sense that the target wouldn't return the command if that
>command already died. In that case, shouldn't we avoid trying to reset
>it? Should the mid-layer not be requesting a reset at this point? Is
>this part of the rumored 2.5 scsi rewrite?

I should have been more clear.  The upper layer performed its recovery
and then reissued the command.  Again that command timed out.  After
a certain number of these cycles, the mid-layer will call the device
dead.

As to the 2.5 scsi rewrite... well there are lots of things in
the SCSI layer to fix for 2.5. 8-)

>>>(scsi0:A:3:0): Abort Message Sent
>>>(scsi0:A:3:0): SCB 3 - Abort Completed.
>>>Recovery SCB completes
>>>Recovery code awake
>>>aic7xxx_abort returns 0x2002
>> 
>> And we were successful.
>
>we successfully aborted, but did we have to?

The command was still outstanding and it timed-out.  So, yes and no.
See below.

>>>scsi: device set offline - not ready or command retry failed after bus reset
>: 
>>>host 0 channel 0 id 3 lun 0
>> 
>> But the mid-layer has already decided that it can't recover this device,
>> so it calls it dead and refuses to allow I/O to it anymore.
>
>This is definitely wrong. The drive won't do anything now without a
>reboot (or maybe removing and reinserting all scsi modules; I could do
>that but I haven't tried it).

There may be some way to recover the device via /proc/scsi, but I haven't
looked into it.

What this boils down to is that the mid-layer's error recovery makes one,
big, invalid, assumption.  Any command that is issued to a device should
complete successfully (i.e. return a status prior to timing out).  If
you send a command that violates that assumption (timeout too short, 
device wigs out on a non-vital command, etc.) the device *will* be set
offline.

In my opinion, the mid-layer simply doesn't have enough information to
perform so bold of an action.  The client (disk, tape, cdrom, or userland
driver using SG) issuing the command may well have the information to call
a device dead, but generic code can't make generic assumptions that will
work in all cases.

>If the DVD-ROM can't handle that CD then that's fine, but it would be
>nice if such a broken CD didn't result in not being able to use that
>drive at all anymore.

If you bump the timeout on all of the commands in cdrdao, you might
get better results.  The drive should return status for a failed read
*eventually*.  *Eventually* is not part of the SCSI spec, so it could
be seconds or hours before the drive gives up.

--
Justin
