Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130616AbRBGVCy>; Wed, 7 Feb 2001 16:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130753AbRBGVCo>; Wed, 7 Feb 2001 16:02:44 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:4875 "HELO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S129608AbRBGVCi>; Wed, 7 Feb 2001 16:02:38 -0500
Message-ID: <8C91B010B3B7994C88A266E1A72184D315D1F2@cceexc19.americas.cpqcorp.net>
From: "Schmitz, Christoph" <Christoph.Schmitz@COMPAQ.com>
To: "'linux-smp@vger.kernel.org'" <linux-smp@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'mingo@redhat.com'" <mingo@redhat.com>
Subject: [BUG] 2.4.x SMP kernel  breaks legacy PIC interrupts 13/2
Date: Wed, 7 Feb 2001 15:06:57 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. Molnar, 
Could you please take a look at this issue ? Also, if you could cc: me on a
possible reply, since I am not subscribed to the mailing list...
Thanks in advance, 

Christoph Schmitz

----------------------------------------------------------------------------
---

The symptom:
Compaq leverages IRQ 13, usually used to raise a floating point exception on
Intel pre-Pentium systems, to trigger management interrupts (i.e. on fan
failure, etc.). This interrupt level is usually NOT shareable, but through
some magic, we managed to register an ISR for our management driver on IRQ
13. In the kernel 2.2.x, this worked fine for both SMP and UP kernels.  On
the 2.4.x SMP kernels, we do NOT get any interrupts when using request_irq()
for IRQ 13.

Debugging:
If you boot the SMP kernel with the 'noapic' parameter, the interrupt works
fine.
We are aware that IRQ 2 and IRQ 13 will be always routed through the legacy
8259A PIC as opposed to the IO-APIC.  If we change the kernel to route IRQ
13 through the APIC, everything works fine.  Furthermore, if we route any
other working interrupt through the PIC, it does not work.  It appears to be
related to putting the PIC into auto-EOI mode.  The 2.4 SMP kernel puts the
PIC in auto-EOI mode while setting up the timer interrupt.  See
init_8259A(1) in the check_timer routine in arch/i386/kernel/io_apic.c.

Conclusion:
PIC and APIC routed interrupts do not coexist peacefully in the 2.4.x SMP
kernel.  We need to figure out why PIC interrupts don't work with the APIC
interrupts enabled, or stop forcing IRQ 2 and 13 to the PIC when APIC
interrupts are enabled.  As it is right now, you will never see an IRQ 2 or
13 while in APIC mode on the 2.4.x SMP kernel, which makes the code
carefully preserving PIC interrupts superfluous. If fixing this kernel flaw
turns out to be too involved, at the very least, we would like to suggest
the code forcing IRQ's 2 and 13 onto the PIC be removed from the 2.4 kernel.
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
