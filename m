Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312576AbSCVAUX>; Thu, 21 Mar 2002 19:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312574AbSCVAUG>; Thu, 21 Mar 2002 19:20:06 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:62161 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S312573AbSCVATD>; Thu, 21 Mar 2002 19:19:03 -0500
Date: Fri, 22 Mar 2002 01:18:28 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <20020321233533.GB785@holomorphy.com>
Message-ID: <Pine.GSO.3.96.1020322005115.1646E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, William Lee Irwin III wrote:

> Polling mode on the PIC wasn't there, true, so it did trigger a
> simulator bug -- but the PIC should never have been touched. It was
> using the local APIC timer etc. Or at least it certainly seems
> counterintuitive to me that the PIC is set into polling mode and EOI'd
> when the local APIC is whose timer is used and is where the interrupt
> came from. We're using the APIC... why are we touching the PIC?

 That's the trick to let the NMI watchdog work.  And also to let timer
interrupts be delivered in the APIC's native mode for broken setups.  8254
interrupts are split and delivered via two ways:

1a. A normal LoPri delivery for the timer interrupt.  Typically pin #2 of
I/O APIC #0 is used, which is directly connected to the output of timer #0
of the 8254.

1b. Alternatively for broken setups that do not connect the timer to an
I/O APIC the so called through-8259A mode is used.  The 8259A is
programmed to pass its IRQ 0 transparently, typically to pin #0 of I/O
APIC #0.  Again the LoPri delivery mode is used.  But code in
do_slow_gettimeoffset() depends in the 8259A's IRR register to be set
appropriately, so we need to ack timer interrupts to the 8259A manually
(the LoPri mode doesn't permit processor's INTA cycles to appear beyond
the local APIC). 

2. The through-8259A mode is also used for broadcasting interrupts at the
same time to LINT0 local interrupt inputs of all processors (they are
typically tied together and connected to the INT output of the master
8259A).  Local APICs are programmed to deliver LINT0 interrupts as NMIs. 
But NMIs are level-triggered in the i82489DX APIC, so they need to be
deasserted ASAP to let system error NMIs (passed via LINT1) to be
recognized.  Again they get deasserted by sending an ack the 8259A
manually.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

