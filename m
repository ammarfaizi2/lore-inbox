Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbSKFTnX>; Wed, 6 Nov 2002 14:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266045AbSKFTnW>; Wed, 6 Nov 2002 14:43:22 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55288 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S266041AbSKFTnU>;
	Wed, 6 Nov 2002 14:43:20 -0500
Message-ID: <3DC97233.2BBD511@mvista.com>
Date: Wed, 06 Nov 2002 11:49:07 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Mikael Pettersson <mikpe@csd.uu.se>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NMI watchdog question.
References: <Pine.GSO.3.96.1021106192840.2684L-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> On Wed, 6 Nov 2002, george anzinger wrote:
> 
> > So then the NMI checks for timer interrupts being serviced
> > in this case?  But, still, why the turn off if the timer
> > does not go thru the APIC?  The case this came up in is an
> > SMP machine, but the test in apic.c shows that the PIT
> > interrupt does not go thru the APIC.  Leaving NMI on seems
> > to work, so I am wondering if this is just old code.
> 
>  For the I/O APIC NMI watchdog the PIT timer is used as a source of NMI
> interrupts as well as a source of timer interrupts.  For this to work you
> need to have two APIC interrupt inputs to receive timer ticks, one
> programmed as an ordinary LoPri interrupt and the other one as an NMI one.

So the performance counters are only used on UP machines?

Also, what is the point of turning off the nmi in this way
(i.e. nmi_watchdog = 0;)?  If the interrupts are not
generated the test of the flag will not be done in traps.c. 
Is it tested else where?

> 
>  Our implementation supports two common variants:
> 
> 1. The PIT timer is directly connected to an I/O APIC input (typically
> INTIN2 of the first I/O APIC) *and* to the master i8259A PIC (hereafter
> referred to as PIC).  The output of the PIC is connected both to an I/O
> APIC input (typically INTIN0 of the first I/O APIC) *and* to all LINT0
> inputs of local APICs.  For such a setup, the I/O APIC input INTIN2 is
> programmed to send LoPri timer interrupts and the LINT0 inputs are
> programmed to send NMIs -- for the latter to work the PIC is programmed to
> behave transparently.  Intel chipsets usually behave this way -- an
> exception is the ancient EISA-only i82350.
> 
> 2. The PIT timer is directly connected to the PIC only.  The output of the
> PIC is connected both to an I/O APIC input (typically INTIN0 of the first
> I/O APIC) *and* to all LINT0 inputs of local APICs.  For such a setup, the
> I/O APIC input INTIN0 is programmed to send LoPri timer interrupts and the
> LINT0 inputs are programmed to send NMIs -- for both interrupts to work
> the PIC is programmed to behave transparently.  The Intel i82350 chipset
> and ServerWorks ones behave this way.
> 
>  If neither of the variants works, which is rare, but happens in real life
> -- for example some glue logic prevents the PIC from working transparently
> -- then the case you are asking about happens.  At this moment we only
> have a single input for timer interrupts available (be it INTIN0 or LINT0)
> and it has to be programmed for the ExtINTA PC/AT compatibility mode and
> no input remains for the NMI.  We choose LINT0 of the bootstrap CPU as it
> offloads the inter-APIC bus a little and provides a slightly lower
> latency.  We could use INTIN0 as well, but LINT0 never failed so far
> (there is also a safeguard in the MP-table parser).
> 
>   Maciej
> 
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
