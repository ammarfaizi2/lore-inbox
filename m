Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129068AbRBHXlk>; Thu, 8 Feb 2001 18:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129141AbRBHXla>; Thu, 8 Feb 2001 18:41:30 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:54546 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129068AbRBHXlR>;
	Thu, 8 Feb 2001 18:41:17 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Mikael Pettersson <mikpe@csd.uu.se>
Date: Fri, 9 Feb 2001 00:37:40 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Re: UP APIC reenabling vs. cpu type detection o
CC: linux-kernel@vger.kernel.org, marco@ds2.pg.gda.pl, mingo@redhat.com
X-mailer: Pegasus Mail v3.40
Message-ID: <14EFD2E43005@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Feb 01 at 0:06, Mikael Pettersson wrote:
> On Thu, 8 Feb 2001 12:32:01 MET-1, Petr Vandrovec wrote:
> 
> >I have another question for UP APIC NMI: As I reported some time ago,
> >if performance counters overflow when LVTPC has 'disabled' bit set,
> >NMI is lost forever. This causes problems with VMware - it has to
> >disable NMI deliveries during CR3 (memory mapping) switching, and if 
> >performance counter overflows at that time, you'll not receive another 
> >NMI for couple of days on K7 (4.1 * 65536 seconds on fully loaded 1GHz 
> >Athlon. And 410 * 65536 seconds on idle Athlon)...
> 
> How long do you need to keep NMIs blocked?

Under some circumstances until `real' (usually timer) interrupt happens :-(
It is up to 10ms (on ia32).
 
> The watchdog (re-)initialises the perfctr to a negative value, but
> after overflow the counter will read as positive. (You'll have to
> use rdpmc() and sign-extend the low bits of the high word.)
> So if, after your critical section, the counter reads as positive
> you know that you missed an NMI. In that case, just write the restart
> value to the counter.
> 
> Alternatively, if you block the NMI watchdog for a long time, say a
> couple of thousand cycles or more, you can unconditionally restart it.

Unfortunately both these ways needs intimate knowledge of how UP NMI
watchdog works in each kernel, and it is incompatible with other
perfctr uses. Probably I'll switch perfctr delivery to some real
maskable interrupt while VMware VM owns CPU - if it is possible.
Then interrupt should be still pending after VM does __sti().
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
