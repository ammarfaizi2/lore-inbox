Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVKQNhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVKQNhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVKQNhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:37:04 -0500
Received: from spirit.analogic.com ([204.178.40.4]:47118 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750823AbVKQNhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:37:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <437BAA0E.2020602@eyal.emu.id.au>
References: <437B3C62.2090803@eyal.emu.id.au> <Pine.LNX.4.61.0511161037130.12055@chaos.analogic.com> <437BAA0E.2020602@eyal.emu.id.au>
X-OriginalArrivalTime: 17 Nov 2005 13:37:01.0227 (UTC) FILETIME=[FD401FB0:01C5EB7B]
Content-class: urn:content-classes:message
Subject: Re: hware clock left bad after a system failure
Date: Thu, 17 Nov 2005 08:37:00 -0500
Message-ID: <Pine.LNX.4.61.0511170822590.7964@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: hware clock left bad after a system failure
Thread-Index: AcXre/1HtbklmcvkQkWe9FtqkAbE9Q==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Eyal Lebedinsky" <eyal@eyal.emu.id.au>
Cc: "list linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2005, Eyal Lebedinsky wrote:

> linux-os (Dick Johnson) wrote:
>> On Wed, 16 Nov 2005, Eyal Lebedinsky wrote:
>>
>>
>>> I recently had two cases where my machine locked up and needed
>>> a hard reset. The last time magic SysRq did not respond at all.
>>>
>>> In these cases I found that the hware clock was set incorrectly
>>> and the machine comes up with a bad date. It seems that the clock
>>> is ahead by as much as my TZ (+10 in my case). I may be able
>>> to understand if it was set 10h behind (kernel set it to UTC)
>>> but this is the other way. The machine comes up with UTC+20.
>>>
>>> Now this is just trouble. The machine comes up and spends 15m
>>> fscking. I then reset the clock and reboot and it does the whole
>>> fsck again because it thinks the fs was not checked for eons. It
>>> does not understand time in the future.
>>>
>>> So the points are
>>>
>>> - why is the clock mangled in this way?
>>
>>
>> I am assuming that you have an ix86 kind of machine.
>>
>> It's probably mangled because you had a hardware-crash.
>>
>> If you have a driver that accesses the RTC, it needs to leave
>> the index register at offset 0 so that a hardware crash can
>> only upset the seconds. Otherwise, even the RTC checksum
>> can get screwed up, forcing manual reconfiguration of the
>> BIOS.
>>
>> During a hardware-crash, the chip enables may go TRUE. This
>> means that an RTC write can occur with junk that's on the
>> data-bus.
>>
>> Now, you need to find out why you had a hardware-crash which
>> is quite unlike a software-crash. A hardware crash occurs when
>> you turn OFF the power or the power-good line from the
>> power-supply goes FALSE. You do not get a hardware-crash from
>> hitting the reset button. You may have induced the RTC failure
>> if you hit the power switch instead of the reset button.
>
> I hit the reset. In one case I managed to reboot using magic SysRq.
>
> The crashes are related to disk problems. In one case the hda/b
> controller went down (last message said DMA disabled on both)
> and in another case the system was doing a proper shutdown
> when it failed to complete and a reset was necessary. I suspect
> a problem with the SATA card which I know has some driver issues
> (promise SATA II 150 TX4).
>
> The point of the post was the fact that the clock was not randomly
> set but clearly at +20h after the reboot. This was the case in the
> last two crashes. This is too coincidental and I suspect that some
> logic does play with the RTC and if a proper shutdown does not
> complete it may not be restored correctly.

Red Hat distributions set the RTC during the shutdown sequence.
That sequence is in /etc/rc.d/init.d/halt line 232. If you just
comment out that line, your problem may go away while you search
for the underlying cause.

The only way the time could have been set to something sane
would be by something like this setting it. It's likely
that you have some memory corruption that screwed up your
environment and therefore the time-zone. When the shutdown
sequence occurred, the RTC was set to the wrong time because
of this time-zone corruption.

If your machine was being heavily swapped when the disk problems
occurred, this __might__ explain the corruption. However, I would
first check RAM, do not overclock, etc. It might be that bad
RAM, in fact, is the reason for all your problems and you don't
really have disk or driver problems at all.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
