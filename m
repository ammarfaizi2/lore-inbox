Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbUJYUYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbUJYUYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbUJYUXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:23:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261278AbUJYUL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:11:57 -0400
Date: Mon, 25 Oct 2004 16:11:17 -0400 (EDT)
From: linux-os <root@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Andi Kleen <ak@suse.de>
cc: Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels
In-Reply-To: <p73u0sik2fa.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.61.0410251553400.3949@chaos.analogic.com>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel>
 <p73u0sik2fa.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Andi Kleen wrote:

> Corey Minyard <minyard@acm.org> writes:
>
>> I had a customer on x86 notice that sometimes offset 0xf in the CMOS
>> RAM was getting set to invalid values.  Their BIOS used this for
>> information about how to boot, and this caused the BIOS to lock up.
>>
>> They traced it down to the following code in arch/kernel/traps.c (now
>> in include/asm-i386/mach-default/mach_traps.c):
>>
>>     outb(0x8f, 0x70);
>>     inb(0x71);              /* dummy */
>>     outb(0x0f, 0x70);
>>     inb(0x71);              /* dummy */
>
> Just use a different dummy register, like 0x80 which is normally used
> for delaying IO (I think that is what the dummy access does)
>
> But I'm pretty sure this NMI handling is incorrect anyways, its
> use of bits doesn't match what the datasheets say of modern x86
> chipsets say. Perhaps it would be best to just get rid of
> that legacy register twiddling completely.
>
> I will also remove it from x86-64.
>
> -Andi

Normally the offset of the CMOS RAM is left an an unused
offset so that the bus-crash that occurs at power-down
doesn't corrupt the CMOS register contents. After CMOS
access, the offset should be left at either 0 (the seconds-
tick) or at 0x7f. In the case of 0x00, the seconds can
get corrupted at shutdown (it still ticks, but it could
glitch to a maximum of 59 seconds off). In the case
of 0x7f, there shouldn't be anything there. Higher offsets
could alias with some board decodes.

Offset 0x0f is really bad because it stores the reason
for a shutdown.

One should never use the write-offset-address/read-value
sequence of the CMOS as some kind of timer. You don't
even know the bus that accesses it! I could be inside
a super-I/O chip (fast) or external on the "local" bus
running at 18 MHz (slow), you just don't know and you
would need to use the "rtc_lock" spin-lock so that somebody
doesn't access the chip between the time you set the
offset and read or write the result.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
