Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269589AbRHABOE>; Tue, 31 Jul 2001 21:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269588AbRHABNy>; Tue, 31 Jul 2001 21:13:54 -0400
Received: from [63.209.4.196] ([63.209.4.196]:11529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269586AbRHABNu>; Tue, 31 Jul 2001 21:13:50 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 31 Jul 2001 10:57:32 -0700
Message-Id: <200107311757.f6VHvWH01678@penguin.transmeta.com>
To: tigran@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: booting SMP P6 kernel on P4 hangs.
Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.21.0107310705580.1374-100000@penguin.homenet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <Pine.LNX.4.21.0107310705580.1374-100000@penguin.homenet> you write:
>
>Isn't SMP P6 kernel supposed to boot fine on a P4? Btw, booting with
>"nosmp" works but booting with "noapic" hangs just the same.

It should boot, and it looks like the problem may be a bad MP table.

The fact that it gets to the point of saying "only one processor found"
definitely means that it found a MP table.  However, that MP table
doesn't seem to actually describe the (single) CPU in a way that Linux
likes:

>> CPU0: Intel(R) Pentium(R) 4 CPU 1300 Mhz stepping 0a
>> per-CPU timeslice cutoff: 731.49 usecs
>> weird, boot CPU (#0) not listed by the BIOS

Notice? 

It looks like your MP table does list a CPU, but it doesn't match the
CPU that is the boot CPU. So first Linux is unhappy about not finding
the boot CPU, but once it has added it it gets to the point of trying to
use the "other" CPU (the one described in the MP table):

>> CPU#0 NMI appears to be stuck
>> testing the IO APIC.............
>> ..........................done
>> calibrating APIC timer...
>> .....CPU clock speed is 1285.2614 Mhz
>> ....host bus clock speed is 0.0000 Mhz
>> cpu:0, clocks:0, slice:0

And yeah, that's not going anywhere.

The way Linux gets the boot CPU ID is by reading the APIC ID. It's
supposed to match the one in the MP table.

The reason "nosmp" works for you is that then we just ignore the MP
table, and just use the boot CPU without worrying about anything else. 

		Linus
