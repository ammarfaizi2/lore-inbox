Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311613AbSCTNx1>; Wed, 20 Mar 2002 08:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311611AbSCTNxK>; Wed, 20 Mar 2002 08:53:10 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:11704 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S311638AbSCTNwT>; Wed, 20 Mar 2002 08:52:19 -0500
Date: Wed, 20 Mar 2002 14:52:27 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.4.33.0203191711070.9609-100000@biker.pdb.fsc.net>
Message-ID: <Pine.GSO.3.96.1020320142929.13532B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Martin Wilck wrote:

> - The SMI handler in the BIOS masks the PIC interrupts. It reads the
>   current mask (this is where the wrong value is obtained).
>   At exit from SMI, it restores this wrong value to register 0x21.
>   The SMI handler simply does not account for the fact that
>   the PIC may be in polling mode when it reads register 0x21.
>   We are right now trying a patched BIOS that does a dummy read
>   on the PIC, before trying to obtain the mask from 0x21.
>   This is an (almost) standard Phoenix BIOS, the IRQ masking code
>   was definitely not changed by anyone at our company.

 Why do you need to fiddle with the 8259A's IMR at all?  What's wrong with
cli?

> Thus yes, the timer_ack code is actually (partly) responsible for
> our hang. I propose a patch for this below.

 The current code is correct, written to 8259A's specs.  I used original
ones ("8259A Programmable Interrupt Controller (8259A/8259A-2)", Intel's
order number 231468) as a reference to assure whatever happens is
well-specified and not an implementation-specific quirk.  The SMI code is
broken for not being transparent (or for existing at all, but that's
another matter).

> We use normal ExtInt operation:
> 
> Mar 12 16:51:30 pdb0374c kernel: ENABLING IO-APIC IRQs
> Mar 12 16:51:30 pdb0374c kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
> Mar 12 16:51:30 pdb0374c kernel: ...changing IO-APIC physical APIC ID to 3 ... ok.
> Mar 12 16:51:30 pdb0374c kernel: ..TIMER: vector=0x31 pin1=-1 pin2=0
> Mar 12 16:51:30 pdb0374c kernel: ...trying to set up timer (IRQ0) through the 8259A ...
> Mar 12 16:51:30 pdb0374c kernel: ..... (found pin 0) ...works.

 That's not the normal mode -- that's the through-8259A mode workaround
designed originally for i82357 (ISP) based EISA systems.  The chip
predates the APIC and does not make IRQ 0 from its internal 8254 core
available externally.  I am actually very surprised to see new systems not
connecting IRQ 0 to the I/O APIC.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

