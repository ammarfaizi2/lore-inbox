Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136554AbREIPqR>; Wed, 9 May 2001 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136563AbREIPqH>; Wed, 9 May 2001 11:46:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52234 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136554AbREIPps>; Wed, 9 May 2001 11:45:48 -0400
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
To: dledford@redhat.com (Doug Ledford)
Date: Wed, 9 May 2001 16:49:25 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        bennyb@ntplx.net (Benedict Bridgwater),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <3AF96164.40F73A9@redhat.com> from "Doug Ledford" at May 09, 2001 11:25:24 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xWDP-0002dE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> EXTREMELY unlikely.  Under a 2.2 no-apic kernel, the aic7xxx card uses IRQ 11
> and works.  Under a 2.2 ioapic kernel, it uses high interrupts and works. 

non SMP that is clueless ignorance mode, SMP that is MP table mode

> situation.  Specifically, if the eepro100 or e100 drivers are not loaded, then
> IRQ 10 is not enabled by any device driver and loading the aic7xxx driver
> simply results in infinite SCSI bus timeouts with nary a single interrupt on
> pin 11.  However, if the eepro100 or e100 driver is loaded, then IRQ 10 will
> have an active interrupt handler on it (which implies the interrupt is enabled
> in the PIC) and loading the aic7xxx driver will hard lock the machine (which

Which is exactly why I think it is an  IRQ routing table bug. It is wired
to IRQ 10 and claims to be on IRQ 11.

There are two things at work here

	PCI_INTERRUPT_LINE - random gunge for the OS
	PCI_INTERRUPT_PIN - INTA/INTB/INTC/INTD wiring

The tables are then described by the $PIRQ table in the BIOS. We use that to
load the mapping registers in the PCI bridge (and also to read them). If the
tables are wrong then we will mismap interrupt INTA-D lines to IRQ lines.

IRQ11 appearing on IRQ10 sounds exactly like the INTA-D line setting for IRQ
11 is wrong and we connected it to IRQ 10

Alan


