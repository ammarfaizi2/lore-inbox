Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283204AbRLWQvp>; Sun, 23 Dec 2001 11:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283269AbRLWQvg>; Sun, 23 Dec 2001 11:51:36 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:10672 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S283204AbRLWQvW>; Sun, 23 Dec 2001 11:51:22 -0500
From: "Ashok Raj" <ashokr2@attbi.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: RE: affinity and tasklets...
Date: Sun, 23 Dec 2001 08:51:06 -0800
Message-ID: <PPENJLMFIMGBGDDHEPBBMELNCAAA.ashokr2@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E16HvBD-0005af-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
Sent: Saturday, December 22, 2001 3:04 PM
To: Ashok Raj
Cc: mingo@elte.hu; linux-kernel@vger.kernel.org
Subject: Re: affinity and tasklets...


> i.e in our devices, a single interrupt from our device indicates several
> device virtual interrupts, so even if i have several tasklets for each
> virtual device interrupts, the code that runs the real intr and schedules
> tasklets will end up queueing all of them on a single cpu.

>> Why do you care. Unless your interrupt event handling code is seriously
slow
>> surely you want to run the things serially, efficiently and while the
cache
>> is hot ?

This is based on our observation with existing hw, when we run several
protocols through this single device, (storage SCSI traffic, LAN, IPC with
lots of short and very large messages) we see even in a 8 way system, just
one CPU pegged. All the handling are totally independent, storage traffic
has no needs to be serialized with LAN traffic and vice versa.

The reasons are the following why we are looking beyond what is available.

1. More protocols on a single fibre via same device.
2. Device does not stop transferring data when the interrupts are generated.
Because it puts additional interrupt conditions in the event queue and
generates intr only when all existing events are processed. So assume the
following case.

 - Network Completion happened (Signalled in Event queue) (Real intr gets
asserted)
 - IPC Completion happened (Signalled in event queue)
 - Real interrupt gets serviced

 - Now we queue a tasklet for Network, then for the IPC

 - Lets say network has about 100 receives ready to process. Because they
are before the IPC tasklet, IPC processing is completely held until the
network processing is complete, while the system has 7 more CPUs doing
nothing.

ashokr


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

