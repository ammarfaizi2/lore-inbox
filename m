Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVKWWHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVKWWHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVKWWHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:07:55 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:45577 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932568AbVKWWHy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:07:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200511232039.PAA03184@bellona.cnchost.com>
X-OriginalArrivalTime: 23 Nov 2005 22:07:52.0451 (UTC) FILETIME=[59483D30:01C5F07A]
Content-class: urn:content-classes:message
Subject: Re: Sub jiffy delay?
Date: Wed, 23 Nov 2005 17:07:51 -0500
Message-ID: <Pine.LNX.4.61.0511231646100.20759@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Sub jiffy delay?
Thread-Index: AcXwellPk61/EGMYQIKUtdiLXEfWyg==
References: <200511232039.PAA03184@bellona.cnchost.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Rick Niles" <niles@rickniles.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2005, Rick Niles wrote:

> I need to service a piece of hardware about every 400-500
> microseconds, but I really don't want to change the value of HZ, which
> in my version of the 2.6 kernel is 1000.  The hardware doesn't have an
> interrupt so the nasty hack I've been doing is to service the hardware
> repeatedly in a loop for about 600 microseconds by watching the
> do_gettimeofday(), set a timer for the next jiffy and repeat.  This leaves less than 400 microseconds / millisecond for the kernel and anything else on the system to run.
>
> Obviously, this sucks, but it does work. I am working with the
> hardware guy to add an interrupt to the hardware.  However, I don't
> want every user of the hardware without the interrupt to have to
> rebuild the kernel with a different value of HZ.  So does anyone have
> any better ideas on what I can do?
>
> Thanks,
> Rick Niles.

Use the RTC if you have an ix86-type machine. It interrupts on
IRQ8 and works fine. It can be programmed at 2048, 1020, 512, etc.,
ticks/per second. I have used it to create a precision state-machine
for handling a 24-bit ADC where it is important to grab stuff at
at repeatable times so that IIR filtering works.... basically:

 	interrupt
 	switch(state++)
         {
         case 0:
             set_mux();
             break;
         case 1:
             settle();
             break;
         case 2:
             convert();
             break;
         case 3:
            settle();
             break;
         case 4:
             get_result()
             do_iir_filter()
             state = 0;
             break;
         }

Note that there is a global spin_lock called 'rtc_lock' that you should
use to prevent anybody from mucking with the chip behind your back.

Since you need to sample your hardware at fixed intervals, the RTC
interrupt is ideal. Just remember to put everything back when you
unload your module! Also, leave the index register (0x70) at 0 before
you release the spin-lock. That keeps a power-failure from trashing
the contents of CMOS (it could only trash seconds).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
