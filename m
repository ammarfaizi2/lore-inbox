Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281458AbRLVRQ7>; Sat, 22 Dec 2001 12:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281739AbRLVRQt>; Sat, 22 Dec 2001 12:16:49 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:47807 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S281458AbRLVRQg>; Sat, 22 Dec 2001 12:16:36 -0500
From: "Ashok Raj" <ashokr2@attbi.com>
To: <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: affinity and tasklets...
Date: Sat, 22 Dec 2001 09:16:24 -0800
Message-ID: <PPENJLMFIMGBGDDHEPBBIEKFCAAA.ashokr2@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0112221222020.4780-100000@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the response Ingo.

The natual affinity of tasklet execution is really the one iam trying to get
away from.

i.e in our devices, a single interrupt from our device indicates several
device virtual interrupts, so even if i have several tasklets for each
virtual device interrupts, the code that runs the real intr and schedules
tasklets will end up queueing all of them on a single cpu.

for e.g if i have 3 virtual device interrupts happen and they are all
indicated by a single real intr to the device. All 3 tasklets would be
queued to the same CPU.

cpu 0
-----
intr()
  queue tasklet_1
  queue tasklet_2
  queue tasklet_3

since tasklet 1,2 & 3 are totally independent virtual interrupts, we would
just kick 1,2,3 on different cpu's queues. even better, if there is any load
balencing, so each tasklet code running on a separate cpu's could pickup one
when they are done processing the current work.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ingo Molnar
Sent: Saturday, December 22, 2001 3:26 AM
To: Ashok Raj
Cc: linux-kernel@vger.kernel.org
Subject: Re: affinity and tasklets...



On Mon, 17 Dec 2001, Ashok Raj wrote:

> In a MP case, we would like 2 separate processors taking the
> completion processing. But running tasklets dont seem to suit this
> since it basically queues on the same CPU that is currently running,
> and this means both get queued to the same tasklet_vec[cpu]. But i
> want each to run on a separate CPU. is using softirq the right method?
> or could i have cpu affinity for tasklets? (i know there is afficinity
> for interrupts, but iam not aware of this for tasklets.)

you'll get a natural affinity of tasklets: they will run on the processor
where the tasklet got activated. Tasklets are just a special form of
softirqs, they have no context in the classic task sense, the only
difference they have to softirqs is that the tasklet code guarantees
single-threadedness of the function executed.

if you are going to rely on tasklets for good SMP scalability then i'd
suggest using a separate tasklet for every device IRQ. Then bind hardirqs
to a particular CPU - thus both the hardirq, the softirq/tasklet will run
on the same processor.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

