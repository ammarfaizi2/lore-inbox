Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWHRPfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWHRPfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWHRPfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:35:05 -0400
Received: from spirit.analogic.com ([204.178.40.4]:54801 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751402AbWHRPfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:35:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 18 Aug 2006 15:34:51.0981 (UTC) FILETIME=[D8EF0FD0:01C6C2DB]
Content-class: urn:content-classes:message
Subject: Re: R: R: How to avoid serial port buffer overruns?
Date: Fri, 18 Aug 2006 11:34:51 -0400
Message-ID: <Pine.LNX.4.61.0608181116320.19105@chaos.analogic.com>
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDIEKFFNAA.g.tomassoni@libero.it>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: R: R: How to avoid serial port buffer overruns?
thread-index: AcbC29j4JzgT29ZTQ4W2QQWH8xdrSQ==
References: <NBBBIHMOBLOHKCGIMJMDIEKFFNAA.g.tomassoni@libero.it>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
Cc: "Robert Hancock" <hancockr@shaw.ca>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Aug 2006, Giampaolo Tomassoni wrote:

>> -----Messaggio originale-----
>> Da: Robert Hancock [mailto:hancockr@shaw.ca]
>> Inviato: venerdì 18 agosto 2006 16.31
>> A: Giampaolo Tomassoni
>> Cc: Linux Kernel ML
>> Oggetto: Re: R: How to avoid serial port buffer overruns?
>>
>> IRQ_HANDLED vs. IRQ_NONE has no effect on what interrupt handlers are
>> called, etc. It is only used to detect if an interrupt is firing without
>> being handled by any driver, in this case the kernel can detect this and
>> disable the interrupt.
>>
>> I'm not sure exactly why the driver is returning IRQ_HANDLED all the
>> time, but edge-triggered interrupts are always tricky and there may be a
>> case where it can't reliably detect this. Returning IRQ_HANDLED is the
>> safe thing to do if you cannot be sure if your device raised an
>> interrupt or not.
>
> Oh, I see. This in handle_IRQ_event in /kernel/irq/handle.c confirms what you said:
>
>        do {
>                ret = action->handler(irq, action->dev_id, regs);
>                if (ret == IRQ_HANDLED)
>                        status |= action->flags;
>                retval |= ret;
>                action = action->next;
>        } while (action);
>
> There is no escape from the loop when the handler returns IRQ_HANDLED.
>
> Thanks,
>
> 	giampaolo
>
>>
>> --
>> Robert Hancock      Saskatoon, SK, Canada
>> To email, remove "nospam" from hancockr@nospamshaw.ca
>> Home Page: http://www.roberthancock.com/
>>

Hardware designed for shared interrupts use what's called
open-collector or open-drain outputs. This allows all devices
to be connected as a "wired-OR".

           Vcc
            |
            R
            |--------------|--------IRQ...
           /              /
1 ------||        -----||
           \       |      \
           |       |      |
           Ve      |      Ve
2 ----------------|

In this case, any device can pull down on the IRQ line.
The wire will remain active LOW until all the hardware
interrupt demands are satisfied. This is used for "level"
interrupts.

Hardware designed for edge interrupts use active devices
to pull a normally-low line up. This produces an edge
which is latched by the interrupt controller. Since
the interrupt controller has only one latch per input
any subsequent edges that occur before the first instance
of an interrupt is serviced (which clears the latch),
will be lost.

This is why devices that produce edges upon interrupt
request can't be shared. However, some people who claim
to know more than the designers of the devices, reason
that if upon any interrupt all of the devices sharing
the edge-type line, are checked for an interrupt request,
then the devices will eventually all get serviced without
losing any interrupts. The reasoning is faulty because
the only way to accomplish this logic is, if you have
N devices sharing an interrupt, then all N interrupt
service routines need to be called N times to handle
all the possibilities of hardware interrupt requests
happening before the latch is reset.

Apparently to handle these kinds of kludges, the kernel
interrupt code was modified so that the device-driver
code needs to returna value to the kernel core code.
If the value is not IRQ_HANDLED, then the ISR will be
called again. If your ISR never returns IRQ_HANDLED,
then the kernel core code will shut you off when it
detects a loop of (last I checked) 10,000 spins.

Any device that uses an edge-type interrupt intended
to be shared is broken by design. There are kludges
that allow for lost interrupt recovery, such as
kicking the device ISR off a timer-queue, but they
are kludges, something to get bad hardware out the
door. The 8250 UART and its modern counterparts
use edge-type interrupt requests. If you have a special
clone (there are some) that can programmed to use
level interrupts, then you need to select an IRQ that
can be programmed for level operation without screwing
up the rest of the computer. This generally means
that you can't use the default IRQ3 or IRQ4.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
