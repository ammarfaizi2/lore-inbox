Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287359AbSAUQhm>; Mon, 21 Jan 2002 11:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSAUQhX>; Mon, 21 Jan 2002 11:37:23 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:27306 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287359AbSAUQhR>; Mon, 21 Jan 2002 11:37:17 -0500
Message-Id: <200201211637.g0LGbCq07602@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: Peter Monta <pmonta@pmonta.com>, linux-kernel@vger.kernel.org
Subject: Re: APIC errors, Asus A7M266-D (760MPX chipset)
Date: Mon, 21 Jan 2002 08:37:09 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020121104204.971231C5@www.pmonta.com>
In-Reply-To: <20020121104204.971231C5@www.pmonta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 January 2002 02:42 am, Peter Monta wrote:
> I'm getting a storm of APIC errors with an Asus A7M266-D motherboard
> at the beginning of boot (and no further boot progress is made).
> The console message is "APIC error on CPU0: 04(04)".  A single
> Athlon MP 1200 is installed; the kernel is compiled with SMP=n
> but both "local APIC" and "use IO-APIC" are enabled.  I'm using
> 2.5.2pre10.

ESR == 04 means Send Accept Error.  The P6 manual says:

  Set when the local APIC detects that a message it sent was not
  accepted by any APIC on the bus.

Now, I wonder why it was sending anything at all.  Maybe that CPU was the one 
that does the PIC emulation and has one of the LVT{0,1} entries set to ExtInt.

BTW, be aware that Intel has changed the way the ESR works.  The P6 manual 
says that software must do two back-to-back writes to clear ESR bits.  The 
most recent P4s say that a read clears bits and writes are ignored, save for 
the requirement of a write before the read to get the ESR up to date.  AFAIK, 
Intel's Linux gang hasn't posted any patches to fix smp_error_interrupt() for 
P4s.  I've been meaning to do that myself....

> Oddly, booting this same kernel with the "noapic" option results in
> the same problem, but recompiling with all APIC options disabled
> gives a successful boot.

Sounds like the APIC was up to something anyway....

> While running in this legacy interrupt mode there seem to be a lot
> of ERR: interrupts in /proc/interrupts, in fact about five times as
> many as "real" ones listed above.  Does this affect performance?  How
> much is interrupt latency increased when the APIC bus must reissue
> commands like this (if I understand the documentation correctly)?

As you would expect performance takes a nosedive from the printks, if nothing 
else, and keeping the APIC bus busy with retransmits increases latency.  They 
use a round robin fairness algorithm so no interrupt source gets starved, but 
because the APIC bus is a serial bus (relatively slow) waiting for a turn can 
take a while.  How long?  Beats me.  The HW guys are no longer leasing an 
APIC bus analyzer pod, so your guess is as good as mine.

> Cheers,
> Peter Monta

-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com

