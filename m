Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276720AbRJKTPH>; Thu, 11 Oct 2001 15:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276716AbRJKTO5>; Thu, 11 Oct 2001 15:14:57 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:12295 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S276702AbRJKTOz>; Thu, 11 Oct 2001 15:14:55 -0400
Message-Id: <200110111915.f9BJFLY97700@aslan.scsiguy.com>
To: Alexander Feigl <Alexander.Feigl@gmx.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: aic7xxx SCSI system hangs 
In-Reply-To: Your message of "11 Oct 2001 14:58:13 +0200."
             <1002805093.3593.9.camel@PowerBox.MysticWorld.de> 
Date: Thu, 11 Oct 2001 13:15:21 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi
>
>Sorry for my incomplete console output yesterday.

Not a problem.

Here's the interesting part...

>scsi0:0:2:0: Attempting to queue an ABORT message
>scsi0: Dumping Card State in Command phase, at SEQADDR 0xbf

The sequencer believes that the last, REQ qualified, phase was
the command phase.

>ACCUM = 0x80, SINDEX = 0xa0, DINDEX = 0xe4, ARG_2 = 0x0
>HCNT = 0xa

We're setup to send a 10byte cdb(command) to the target.  No bytes of
the cdb have yet been transfered.

>SCSISEQ = 0x12, SBLKCTL = 0xa
> DFCNTRL = 0x24, DFSTATUS = 0x80

The data fifo is all set to send data...

>LASTPHASE = 0x80, SCSISIGI = 0x44, SXFRCTL0 = 0x80
			      ^^^^
But what's this?  The target has us in data-in phase.

>SSTAT0 = 0x0, SSTAT1 = 0x3

But this phase, according to the hardware, was never qualified by
a REQ, so we never see this change and fall out of the loop that is
trying to process the command phase.

To sum up, from time to time, the controller sees the first REQ for
the data-in phase that follows the command phase, prior to seeing the
phase lines change to data-in.  This is either caused by the plextor
not allowing the proper bus-settle time for the phase change to be
seen prior to asserting REQ *OR* your cabling is poor (too long,
marginal/bent pin, incorrect termination, etc.) giving a similar
result.

As for why you cannot talk to the device after a while, the device
has been set offline.  The controller was unable to talk to it
successfully, so the SCSI layer decided to ignore it.

--
Justin
