Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280713AbRKBO4R>; Fri, 2 Nov 2001 09:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280709AbRKBO4I>; Fri, 2 Nov 2001 09:56:08 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:8457 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S280712AbRKBOzw>;
	Fri, 2 Nov 2001 09:55:52 -0500
Message-Id: <200111021455.fA2EtVY46425@aslan.scsiguy.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx bug, 2.4.13/6.2.4 
In-Reply-To: Your message of "02 Nov 2001 15:03:09 +0100."
             <m3n1259so2.fsf@defiant.pm.waw.pl> 
Date: Fri, 02 Nov 2001 07:55:30 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jason Lunz <j@falooley.org> writes:
>
>> I'm having troubles with the last few revisions of the new Gibbs aic7xxx
>> driver that until now has served me well. This is kernel
>> 2.4.13-preempt-lvmrc4 with the 6.2.4 scsi driver, but I saw it happen on
>> 2.4.12 with 6.2.1. I haven't tried older versions with this CD.
>
>Something similar here, but I have disks on this SCSI :-(

Actually not that similar.

>scsi0:A:0: parity error detected in Message-in phase. SEQADDR(0x1b6) SCSIRATE(
>0x0) 

Here's your first clue.  Parity errors occur on "broken" SCSI busses.
Your cabling or terminator is bad, you have a bent pin, or just too
much noise in and around your cabling.

>scsi0: Unexpected busfree in Message-out phase 
>SEQADDR == 0x166 

When we tried to tell the target about the parity error during message-in
phase, the target was unable to see our message without parity errors.
So, it had to go bus free to terminate the transaction.  It is a bug
here that we didn't properly identify the active transaction and abort
it here due to some overly protective code, but that can be readily
fixed.

>scsi0:0:0:0: Attempting to queue an ABORT message 

Because we failed to abort the command above, the mid-layer
timesout the command and we start recovery.

>scsi0: Dumping Card State while idle, at SEQADDR 0x7 
>ACCUM = 0x33, SINDEX = 0x7, DINDEX = 0x8c, ARG_2 = 0x0 
>HCNT = 0x0 
>SCSISEQ = 0x12, SBLKCTL = 0x2 
> DFCNTRL = 0x0, DFSTATUS = 0x29 
>LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80 
>SSTAT0 = 0x5, SSTAT1 = 0xa 
>STACK == 0x3, 0x105, 0x160, 0xe4 
>SCB count = 20 
>Kernel NEXTQSCB = 19 
>Card NEXTQSCB = 19 
>QINFIFO entries:  
>Waiting Queue entries:  
>Disconnected Queue entries: 7:5  
>QOUTFIFO entries:  
>Sequencer Free SCB List: 8 11 4 5 10 15 2 3 1 0 9 13 14 6 12  
>Pending list: 5 
>Kernel Free SCB list: 7 12 0 4 10 6 9 14 3 1 8 11 15 13 2 18 17 16  
>DevQ(0:0:0): 0 waiting 
>DevQ(0:1:0): 0 waiting 
>(scsi0:A:0:0): Queuing a recovery SCB 
>scsi0:0:0:0: Device is disconnected, re-queuing SCB 
>Recovery code sleeping 
>(scsi0:A:0:0): Abort Tag Message Sent 
>(scsi0:A:0:0): SCB 5 - Abort Tag Completed. 
>Recovery SCB completes 
>Recovery code awake 
>aic7xxx_abort returns 0x2002 

And we abort the transaction successfully.

>scsi0:A:0: parity error detected in Message-in phase. SEQADDR(0x1b6) SCSIRATE(
>0x0) 
>Kernel panic: HOST_MSG_LOOP with invalid SCB ff 

We get another parity error in a state without a proper connection (probably
on the identify message after a reselection) and some more defensive
programming prevents us from handling it correctly. 8-(

The end result is that you need to fix your SCSI bus to be more reliable.
I will fix the issues you've discovered in parity error and unexpected
busfree handling in the next driver release.  If your bus is working
properly, you shouldn't see these errors.

--
Justin
