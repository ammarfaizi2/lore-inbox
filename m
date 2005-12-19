Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVLSNv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVLSNv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 08:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVLSNv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 08:51:56 -0500
Received: from spirit.analogic.com ([204.178.40.4]:7692 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750737AbVLSNvz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 08:51:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B223248@mail.esn.co.in>
X-OriginalArrivalTime: 19 Dec 2005 13:51:48.0065 (UTC) FILETIME=[5B10DD10:01C604A3]
Content-class: urn:content-classes:message
Subject: Re: Kernel interrupts disable at user level - RIGHT/ WRONG - Help
Date: Mon, 19 Dec 2005 08:51:31 -0500
Message-ID: <Pine.LNX.4.61.0512190841120.11055@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel interrupts disable at user level - RIGHT/ WRONG - Help
Thread-Index: AcYEo1sa6SGjv4rZQSqB6cKKptgOFg==
References: <3AEC1E10243A314391FE9C01CD65429B223248@mail.esn.co.in>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Dec 2005, Mukund JB. wrote:

>
> Dear Kernel Developers,
>
> I have a requirement of getting the CMOS details at the user level.
> I have identified the interfaces as /dev/nvram & /dev/rtc.
> But, the complete CMOS details are available to the user Applications
> as the driver does not provide the suitable interface to get the
> complete CMOS details.
>
> I found an application that reads directly form the port 70, 71
> and gets the complete details about the CMOS. It does not use any Device
> Interface and at the same disables all the interruptson the HOST system.
>
> I would like to hear from you whether this kind of Applications can be
> used or NOT? Please see the attached source code I am planning to use to
> access the CMOS contents.
>
> Please give me ur valuable suggestions.
>
> Regards,
> Mukund Jampala
>

First, only root can disable interrupts in user-mode and read/write
to ports. One must prepare for this with iopl(3).

Second, the RTC is a shared resource. It must be protected with
a lock.

If you want to make your own rtc driver, then feel free. However,
you can't just poke at the ports from user-mode and get away with
it for any period of time. You will find that the CMOS checksum
gets screwed up and/or the time gets changed to a previous epoch.

This is because the kernel may change the index register in between
the time that you set it and when you wrote to the data register.

You need to use the provided spin-lock, rtc_lock. This needs
to be accessed from within the kernel, in your driver.

>
>
> <<dmpCmos.c>>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
