Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTAFTeQ>; Mon, 6 Jan 2003 14:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbTAFTeQ>; Mon, 6 Jan 2003 14:34:16 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:34232 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267131AbTAFTeN>; Mon, 6 Jan 2003 14:34:13 -0500
Message-ID: <159801c2b5bb$da27fa00$0201a8c0@w2kstore>
From: "Jon Fraser" <j_fraser@bit-net.com>
To: <linux-kernel@vger.kernel.org>, "Avery Fay" <avery_fay@symantec.com>
References: <OFC4D9AF0E.DA93F4D7-ON85256CA3.0058C567-85256CA3.00592873@symantec.com>
Subject: Re: Gigabit/SMP performance problem
Date: Mon, 6 Jan 2003 14:43:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



What is your packet size?  How many packets/second are you  forwarding?

I did a lot of testing on 2.4.18 and 2.4.20 kernels with a couple of
different
hardware platforms, using 82543 and 82544 chipsets.  cache
contention/invalidates
due to locks, counters, and ring buffer access becomes the bottleneck.  I
actually verified the
the stats using the cpu performance counters.  As traffic goes up, cache
invalidate increase
and usefull cpu cycles decrease.

I found I was best off to bind the interrupts for each gig-e chip to a
different processor.
That way, only one cpu is accessing the data structures for that interface.
You also not
suffer from packet reordering if you bind the interrupts.

Also, be sure that you have the latest e1000 driver.   If the driver is
refilling the ring buffer
from a tasklet, find a later driver.

Play with the rx interrupt delay until you minimize the interrupts, if
you're not using NAPI.
Be aware that earlier intel chipsets have some problems.  I believe 82543
and earlier
have unreliable rx interrupt delay and can't use more that 256 ring buffers.

I don't have my numbers handy, but I believe I was able to achieve around
400 kpps, 64 byte size,
with a dual cpu dell box with I believe, 1ghz cpus.

By the way, your performance won't scale linearly with cpu speed.  We had a
2.4 ghz dual HT cpu
box from intel for a bit, and it didn't run that much faster.

You may want to search the archives for netdef@oss.sgi.com for some work
being done
on skbuff recycling.   I did some work along those lines, avoiding
constantly allocing
and freeing memory, and it made quite a difference.  It's been a month since
I last looked,
so there may be more progress.

If you happen to turn on vlans, I be curious about your results.  Our
chipsets produced
cisco ISL frames instead of 802.1q frames.  Intel admitted the chipset would
do it,
but 'shouldn't be doing that...'

    Jon

----- Original Message -----
From: "Avery Fay" <avery_fay@symantec.com>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, January 03, 2003 11:12 AM
Subject: Gigabit/SMP performance problem


> Hello,
>
> I'm working with a dual xeon platform with 4 dual e1000 cards on different
> pci-x buses. I'm having trouble getting better performance with the second
> cpu enabled (ht disabled). With a UP kernel (redhat's 2.4.18), I can route
> about 2.9 gigabits/s at around 90% cpu utilization. With a SMP kernel
> (redhat's 2.4.18), I can route about 2.8 gigabits/s with both cpus at
> around 90% utilization. This suggests to me that the network code is
> serialized. I would expect one of two things from my understanding of the
> 2.4.x networking improvements (softirqs allowing execution on more than
> one cpu):
>
> 1.) with smp I would get ~2.9 gb/s but the combined cpu utilization would
> be that of one cpu at 90%.
> 2.) or with smp I would get more than ~2.9 gb/s.
>
> Has anyone been able to utilize more than one cpu with pure forwarding?
>
> Note: I realize that I am not using a stock kernel. I was in the past, but
> I ran into the same problem (smp not improving performance), just at lower
> speeds (redhat's kernel was faster). Therefore, this problem is neither
> introduced nor solved by redhat's kernel. If anyone has suggestions for
> improvements, I can move back to a stock kernel.
>
> Note #2: I've tried tweaking a lot of different things including binding
> irq's to specific cpus, playing around with e1000 modules settings, etc.
>
> Thanks in advance and please CC me with any suggestions as I'm not
> subscribed to the list.
>
> Avery Fay
>
> P.S. Only got one response on the linux-net list so I'm posting here. One
> thing I did learn from that response is that redhat's kernel is faster
> because they use a napi version of the e1000 driver.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

