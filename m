Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbRALQyT>; Fri, 12 Jan 2001 11:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRALQyJ>; Fri, 12 Jan 2001 11:54:09 -0500
Received: from colorfullife.com ([216.156.138.34]:22789 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129655AbRALQx4>;
	Fri, 12 Jan 2001 11:53:56 -0500
Message-ID: <3A5F3697.38DEA1FE@colorfullife.com>
Date: Fri, 12 Jan 2001 17:53:43 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: frank@unternet.org, linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware 
 related?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's decode it:

> IO APIC #2...... 
> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect: 
> 12 0FF 0F 0 1 0 1 0 1 1 91 
> 13 0FF 0F 0 1 1 1 0 1 1 99 

IRR for interrupt 19 is set, that means the IO APIC has sent the
interrupt to a cpu but not yet received the corresponding EOI.

That bit is read only, so we can't set it to 0 to kick the io apic.

The Vector is 99, we must check that bit in the ISR, TMR and IRR of both
cpus.

cpu1:
> ISR: all bits 0
> TMR: only bit 0x99 is set
> IRR: all bits 0

cpu0:
> ISR: all bits 0
> TMR: only bit 0x89 is set
> IRR: bit 0xfc and bit 0xef are set.

ISR is the in-server register, 0 means that the cpu is not processing an
interrupt right now.

TMR is the trigger mode registers, 1 means that the local apic should
send an EOI to the io apic when the cpu signals the EOI to the local
apic.


IRR is the list of pending interrupts:
0xef is the local timer interrupt,
0xfc is the reschedule interrupt
(see include/asm-i386/hw_irq.h)

These bits are also read only.

If you search the IO APIC documentation: number 29056601 - just search
with google. The local APIC is documented in the main cpu handbook (PPro
or later), in the chapter about multiple processor management 

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
