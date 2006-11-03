Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752669AbWKCAGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbWKCAGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 19:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbWKCAGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 19:06:34 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:11153 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S1752669AbWKCAGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 19:06:33 -0500
Date: Fri, 3 Nov 2006 01:06:31 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061103000631.GA23182@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <1162417916.15900.271.camel@localhost.localdomain> <20061102001838.GA911@rhlx01.hs-esslingen.de> <1162452676.15900.287.camel@localhost.localdomain> <1162455263.15900.320.camel@localhost.localdomain> <1162488129.15900.396.camel@localhost.localdomain> <20061102192812.GA11815@rhlx01.hs-esslingen.de> <20061102203430.GA27729@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102203430.GA27729@rhlx01.hs-esslingen.de>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[CC'd Len since he might want/be able to help despite this being VIA issue ;)]

On Thu, Nov 02, 2006 at 09:34:30PM +0100, Andreas Mohr wrote:
> This time with apic=debug (attached), and now we have messages such as:
> 
> lapic timer verify: delta 10754906 pmtimer 11935676 (2557644) lapic 1180770(0 1180770 1180807) on cpu 0
> 
> which means that the timer *is* unstable.
> 
> I'm starting to wonder what I could debug here...

OK, I debugged it some more, and I noticed some very strange ACPI status
again...

$ cat /proc/acpi/processor/CPU0/*
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no
<not supported>
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000 usec
states:
<not supported>

HOWEVER (dmesg.log.gz):

ACPI: CPU0 (power states: C1[C1] C2[C2])

and

ACPI: lapic on CPU 0 stops in C2[C2]

So according to /proc/acpi/ I don't even *have* C1/C2, however
it's still being used.

Oh, wait, I just realized that of course I'm in 2.6.19-rc1-mm1 currently,
however booting into 2.6.19-rc4-mm1 *does* list C1/C2 states in /proc/acpi/,
in contrast to -rc1-mm1.
That would explain why 2.6.19-rc1-mm1 has no issues whatsoever with dynticks
- since it never even enters C1/C2!

OK, so dynticks in Linux > 2.6.19-rc1-mm1 broke because ACPI C1/C2
suddenly became available which killed my VIA APIC timer in C2.

How probable is it that the APIC timer got killed due to mis-programming
in Linux versus VIA chipset design garbage probability? I.e. do you think
there's a chance to fix C2 malfunction by going into the innards of
VIA chipsets operation?
How useful would it be to simply disable C2 operation (but not C1)
in CONFIG_NO_HZ mode after's been determined to kill APIC timer?:

lapic timer verify: delta 3435285 pmtimer 3469523 (743469) lapic 34238(0 34238 3
4338) on cpu 0
lapic timer verify: delta 6022 pmtimer 46853 (10040) lapic 40831(0 40831 40914)
on cpu 0
lapic timer verify: delta 66814 pmtimer 136000 (29143) lapic 69186(0 69186 69284
) on cpu 0
lapic timer verify: delta 19658 pmtimer 22092 (4734) lapic 2434(0 2434 2469) on
cpu 0
lapic timer verify: delta 9967 pmtimer 22624 (4848) lapic 12657(0 12657 12693) o
n cpu 0
lapic timer verify: delta 9681 pmtimer 21429 (4592) lapic 11748(0 11748 11945) o
n cpu 0
lapic timer verify: delta 59879 pmtimer 94822 (20319) lapic 34943(0 34943 35029)
 on cpu 0
lapic timer verify: delta 34878 pmtimer 52668 (11286) lapic 17790(0 17790 17876)
 on cpu 0
lapic timer verify: delta 32436 pmtimer 78992 (16927) lapic 46556(0 46556 46641)
 on cpu 0
lapic timer verify: delta 10450 pmtimer 75002 (16072) lapic 64552(0 64552 64590)
 on cpu 0
ACPI: lapic on CPU 0 stops in C2[C2]

Hmm, processor_idle.c in current -dynticks4 seems to contain code to do just
that: disable C states after they've been found harmful to timer operation?
But somehow it doesn't seem to work for me here, obviously.
If I don't get any further input on that I'll try to debug it myself soon.

http://www.linuxsymposium.org/proceedings/reprints/Reprint-Brown-OLS2004.pdf
is quite informative about APIC timer issues etc., BTW.

Andreas Mohr
