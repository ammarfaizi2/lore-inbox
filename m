Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129109AbRBHXGj>; Thu, 8 Feb 2001 18:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBHXGT>; Thu, 8 Feb 2001 18:06:19 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:18069 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129123AbRBHXGQ>;
	Thu, 8 Feb 2001 18:06:16 -0500
Date: Fri, 9 Feb 2001 00:06:12 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200102082306.AAA13110@harpo.it.uu.se>
To: VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] Re: UP APIC reenabling vs. cpu type detection o
Cc: linux-kernel@vger.kernel.org, marco@ds2.pg.gda.pl, mingo@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001 12:32:01 MET-1, Petr Vandrovec wrote:

>I have another question for UP APIC NMI: As I reported some time ago,
>if performance counters overflow when LVTPC has 'disabled' bit set,
>NMI is lost forever. This causes problems with VMware - it has to
>disable NMI deliveries during CR3 (memory mapping) switching, and if 
>performance counter overflows at that time, you'll not receive another 
>NMI for couple of days on K7 (4.1 * 65536 seconds on fully loaded 1GHz 
>Athlon. And 410 * 65536 seconds on idle Athlon)...

How long do you need to keep NMIs blocked?

The watchdog (re-)initialises the perfctr to a negative value, but
after overflow the counter will read as positive. (You'll have to
use rdpmc() and sign-extend the low bits of the high word.)
So if, after your critical section, the counter reads as positive
you know that you missed an NMI. In that case, just write the restart
value to the counter.

Alternatively, if you block the NMI watchdog for a long time, say a
couple of thousand cycles or more, you can unconditionally restart it.

(I had a theory about inspecting the APIC_LVTPC "Delivery Status"
field, but unfortunately it doesn't seem to get set if a counter
overflowed while LVTPC was masked. Perhaps it's because NMIs are
edge-triggered.)

>So it came to my mind - why (on K7 we easy can, as counter has 48 bits)
>we do not reload NMI watchdog in each timer interrupt with 5sec timeout,
>and if we receive even one NMI, we are locked up? It should increase
>performance, as we'll do same number of MSR writes anyway (100/s), but
>we will not receive any NMI during normal operation, so we save time
>spent in processing this. Or do I miss something?

The 100 NMI/s rate was just to match the original IO-APIC driven watchdog;
it's certainly not a design goal to have the rate this high. In fact,
we'll probably reduce it to 1Hz soon. (I'm running it in that mode now.)

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
