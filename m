Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269375AbRGaRKK>; Tue, 31 Jul 2001 13:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269373AbRGaRKB>; Tue, 31 Jul 2001 13:10:01 -0400
Received: from [64.7.140.42] ([64.7.140.42]:63940 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S269371AbRGaRJz>;
	Tue, 31 Jul 2001 13:09:55 -0400
Message-ID: <00c001c119e4$31418560$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: "Khalid Aziz" <khalid@fc.hp.com>,
        "Linux kernel development list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200107302332.f6UNWbxg001791@webber.adilger.int> <3B65F1A2.30708CC1@fc.hp.com> <000701c119cd$ebf0c720$294b82ce@connecttech.com> <20010731174247.A21802@flint.arm.linux.org.uk>
Subject: Re: Support for serial console on legacy free machines
Date: Tue, 31 Jul 2001 13:14:01 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

From: "Russell King" <rmk@arm.linux.org.uk>
> No.  Console initialisation is done early, before PCI is setup.  This

I figured that out eventually. :-)

> means that the serial driver is relying on a static array of IO port
> addresses.  At this time, the serial driver hasn't probed any ports at
> all, so it doesn't really know what does and doesn't exist.

Correct.

> If, for example, you specify your console on ttyS25, (and you have
> support for >=32 ports compiled in) I wonder what happens?  I can
> see one of two things happening:
>
> 1. Kernel locks up waiting for the non-existent "transmitter" to become
>    ready.
> 2. Kernel continues blindly writing to a non-existent port without
>    locking up and you get no messages at all.

Well, the io address would be... <checks asm/serial.h>
 { 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS }, /* ttyS25 */
on i386 builds. I guess it would depend on what is actually at
0x148. Nothing good would come of it if you didn't have a uart
there, I'm sure.

> Now, this static table is updated after PCI and PNP initialisation, when
> the ports are actually probed.  Your ttyS25 may now change port address
> under the serial console!  I wonder what baud rate the messages come out
> at?  75 baud? ;(

Correct. That entry would be overwritten by whatever dynamic ports
were discovered. Of course, if you only had one 8 port card, it'd
remain the same. But if you had enough 8 port cards, you'd get a serial
port. I think the effect would be that that serial port suddenly becomes
the console, at 9600 8n1. Hm.

> The more I think about this, the more that I think we need to get rid
> of this early console initialisation.  I think Linus really wants early
> console initialisation though, and to be honest, its an extremely useful
> debugging tool for those pesky non-boots with blank displays.

There seems to be a serial console interface; perhaps we need
a general console interface that other code can make use of.
That might pave the way for an ethernet console, or a usb console,
etc.

..Stu


