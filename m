Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTLQODS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 09:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTLQODR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 09:03:17 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:61569 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264398AbTLQODO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 09:03:14 -0500
Date: Wed, 17 Dec 2003 15:03:04 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <3FDF7ED3.5020802@mvista.com>
Message-ID: <Pine.LNX.4.55.0312171410190.7484@jurand.ds.pg.gda.pl>
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
 <brcoob$a02$1@gatekeeper.tmr.com> <3FDA40DA.20409@mvista.com>
 <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl> <3FDE2AC6.30902@mvista.com>
 <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl> <3FDF4060.30303@mvista.com>
 <Pine.LNX.4.55.0312162141070.8262@jurand.ds.pg.gda.pl> <3FDF7ED3.5020802@mvista.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, George Anzinger wrote:

> How confusing :(  Could you give me some idea how this works?  I have tried 
> disable_irq(0) and, as best as I can tell, it does not do the trick.  The 
> confusion I have is understanding where in the chain of hardware each of these 
> thing is taking place.

 Well, strange -- it should mask the timer interrupt.  But I've never 
tried that and have proposed based on a source study only -- perhaps it 
needs to be further investigated.

> For example, it would be "nice" if I could just turn off the PIT interrupt line 
> so that both the NMI (PIT generated) and the PIT interrupt would be put on hold. 

 The counter gate of the 8254 chip is designed to do just that -- it's a
pity it's hardwired, but I can understand another SSI TTL latch of a
dubious utility was just too costly for the original PC in 1981.

>   Your answer seems to indicate that disable_irq() is working down stream from 
> where the NMI signal is connected to the PIT interrupt line, so we need to turn 
> of the NMI as well.  A picture would be nice here :)

 I'll try my best:

 +------+ OUT0                                INTIN2 +--------+
 | 8254 +--+-----------------------------------------+        |
 +------+  |                                         |  I/O   |
           | IR0 +------+ INT +------+        INTIN0 |  APIC  |
           +-----+ 8259 +-----+ glue +-+-------------+        |
                 +------+     +------+ |             +---++---+
                                       |                 ||
                                       |                 ||
                                       |                 ||
                           +-----------+---------+-...   ||
                           |                     |       ||
        +--------+         |  +--------+         |       ||
        | CPU #0 |         |  | CPU #1 |         |       ||
        +--------+         |  +--------+         |       ||
        |        | LINT0   |  |        | LINT0   | ...   ||
        | local  +---------+  | local  +---------+       ||
        | APIC   |            | APIC   |                 ||
        |        |            |        |                 ||
        +---++---+            +---++---+                 ||
            ||                    ||                     ||
            || inter-APIC bus     ||                     ||
            ++====================++===============...===++

The system is a traditional i82489DX/Pentium/P6-style virtual-wire setup
with a serial inter-APIC bus and a full MP-spec feature set.  More limited
systems may miss the OUT0->INTIN2 line and/or one or more of the
INT->INTIN0 or INT->LINT0 -- there needs to be only one.  If any INT->sth
connections are missing then either the INT->LINT0 one for the bootstrap
processor (BSP) or the INT->LINT0 has to exist; other are optional.

 For the system above the path for the 8254 timer interrupt is via INTIN2
and the inter-APIC bus as a LoPri APIC interrupt.  The path for the NMI
watchdog is via the 8259 reconfigured to pass IR0 transparently to INT and
then LINT0 inputs of all processors, reconfigured for a NMI APIC
interrupt.  Some glue at the INT output may prevent the NMI watchdog from
working -- the LINT0 inputs may not toggle back and forth.

 If the OUT0->INTIN2 line is missing, the path for the 8254 timer
interrupt is via the 8259 reconfigured to pass IR0 transparently to INT,
then INTIN0 and the inter-APIC bus as a LoPri APIC interrupt.  The path
for the NMI watchdog is also via the 8259 and then LINT0 inputs of all
processors, reconfigured for a NMI APIC interrupt.  Again, some glue at
the INT output may prevent this set up from working, but if it does work,
then both the timer interrupt and the NMI watchdog do -- I've not heard of
a system having different glue logic for INTIN0 and LINT0.

 If the above variant does not work, as a last resort, the path for the
8254 timer interrupt is via the 8259 reconfigured back into its usual mode
and then LINT0 of the BSP reconfigured for an ExtINTA APIC interrupt.  
Additionally, since at this point the glue logic has probably already
locked up due to the messing done above, a few artiffical sets of double
INTA cycles are sent to the system bus using the RTC chip and INTIN8
reconfigured temporarily to send ExtINTA APIC interrupts via the
inter-APIC bus.

 I do hope a thorough read of the description will make the available
variants clear.  The I/O APIC input numbers may differ but so far they are
almost always as noted above.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
