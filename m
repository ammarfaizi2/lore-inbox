Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316847AbSGUQoV>; Sun, 21 Jul 2002 12:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSGUQoV>; Sun, 21 Jul 2002 12:44:21 -0400
Received: from mail.coastside.net ([207.213.212.6]:33527 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S316847AbSGUQoO>; Sun, 21 Jul 2002 12:44:14 -0400
Mime-Version: 1.0
Message-Id: <p05111a19b9608eec09b1@[207.213.214.37]>
Date: Sun, 21 Jul 2002 09:46:39 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: spurious smp_spurious_interrupt()?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the source of the "never happen" comment in 
arch/i386/kernel/apic.c (repeated in the printk)? It plainly *does* 
happen (as Google and my own experience attest--look for 
call_spurious_interrupt, though), and there's nothing in Intel's 
documentation to suggest that it shouldn't, or that it's anything but 
a routine (though presumably rare) occurrence.

(Note also that the documentation reference is no longer correct. In 
the 2001 edition it was 7.6.13.5; in the latest edition the APIC gets 
its own chapter.)

>8.9. SPURIOUS INTERRUPT
>A special situation may occur when a processor raises its task 
>priority to be greater than or equal to the level of the interrupt 
>for which the processor INTR signal is currently being asserted. If 
>at the time the INTA cycle is issued, the interrupt that was to be 
>dispensed has become masked (programmed by software), the local APIC 
>will deliver a spurious-interrupt vector. Dispensing the 
>spurious-interrupt vector does not affect the ISR, so the handler 
>for this vector should return without an EOI.


>/*
>  * This interrupt should _never_ happen with our APIC/SMP architecture
>  */
>asmlinkage void smp_spurious_interrupt(void)
>{
>         unsigned long v;
>
>         /*
>          * Check if this really is a spurious interrupt and ACK it
>          * if it is a vectored one.  Just in case...
>          * Spurious interrupts should not be ACKed.
>          */ 
>         v = apic_read(APIC_ISR + ((SPURIOUS_APIC_VECTOR & ~0x1f) >> 1));
>         if (v & (1 << (SPURIOUS_APIC_VECTOR & 0x1f)))
>                 ack_APIC_irq();
>
>         /* see sw-dev-man vol 3, chapter 7.4.13.5 */
>         printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should 
>never happen
>.\n",
>                         smp_processor_id());
>}


-- 
/Jonathan Lundell.
