Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266025AbSKFSwS>; Wed, 6 Nov 2002 13:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266026AbSKFSwS>; Wed, 6 Nov 2002 13:52:18 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:16015 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S266025AbSKFSwQ>; Wed, 6 Nov 2002 13:52:16 -0500
Date: Wed, 6 Nov 2002 19:55:33 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: george anzinger <george@mvista.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NMI watchdog question.
In-Reply-To: <3DC9588D.C3574CB5@mvista.com>
Message-ID: <Pine.GSO.3.96.1021106192840.2684L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, george anzinger wrote:

> So then the NMI checks for timer interrupts being serviced
> in this case?  But, still, why the turn off if the timer
> does not go thru the APIC?  The case this came up in is an
> SMP machine, but the test in apic.c shows that the PIT
> interrupt does not go thru the APIC.  Leaving NMI on seems
> to work, so I am wondering if this is just old code.

 For the I/O APIC NMI watchdog the PIT timer is used as a source of NMI
interrupts as well as a source of timer interrupts.  For this to work you
need to have two APIC interrupt inputs to receive timer ticks, one
programmed as an ordinary LoPri interrupt and the other one as an NMI one.

 Our implementation supports two common variants:

1. The PIT timer is directly connected to an I/O APIC input (typically
INTIN2 of the first I/O APIC) *and* to the master i8259A PIC (hereafter
referred to as PIC).  The output of the PIC is connected both to an I/O
APIC input (typically INTIN0 of the first I/O APIC) *and* to all LINT0
inputs of local APICs.  For such a setup, the I/O APIC input INTIN2 is
programmed to send LoPri timer interrupts and the LINT0 inputs are
programmed to send NMIs -- for the latter to work the PIC is programmed to
behave transparently.  Intel chipsets usually behave this way -- an
exception is the ancient EISA-only i82350. 

2. The PIT timer is directly connected to the PIC only.  The output of the
PIC is connected both to an I/O APIC input (typically INTIN0 of the first
I/O APIC) *and* to all LINT0 inputs of local APICs.  For such a setup, the
I/O APIC input INTIN0 is programmed to send LoPri timer interrupts and the
LINT0 inputs are programmed to send NMIs -- for both interrupts to work
the PIC is programmed to behave transparently.  The Intel i82350 chipset
and ServerWorks ones behave this way.

 If neither of the variants works, which is rare, but happens in real life
-- for example some glue logic prevents the PIC from working transparently
-- then the case you are asking about happens.  At this moment we only
have a single input for timer interrupts available (be it INTIN0 or LINT0) 
and it has to be programmed for the ExtINTA PC/AT compatibility mode and
no input remains for the NMI.  We choose LINT0 of the bootstrap CPU as it
offloads the inter-APIC bus a little and provides a slightly lower
latency.  We could use INTIN0 as well, but LINT0 never failed so far
(there is also a safeguard in the MP-table parser).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

