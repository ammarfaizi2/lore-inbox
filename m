Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273888AbRJJCER>; Tue, 9 Oct 2001 22:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRJJCEI>; Tue, 9 Oct 2001 22:04:08 -0400
Received: from mail.courier-mta.com ([66.92.103.29]:31422 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S273818AbRJJCD5>; Tue, 9 Oct 2001 22:03:57 -0400
From: "Sam Varshavchik" <mrsam@courier-mta.com>
To: linux-kernel@vger.kernel.org
Cc: linux-smp@vger.kernel.org
Subject: [BUG] [PATCH] Infinite loop in arch/i386/kernel/io_apic.c
Date: Wed, 10 Oct 2001 02:04:26 GMT
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_0_2220_1002679466"; charset="iso-8859-1"
Message-ID: <courier.3BC3ACAA.000008AE@ny.email-scan.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
mail software cannot handle MIME-formatted messages.

--=_0_2220_1002679466
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Good morning/afternoon/evening/night, 

I see that there was some debug code added to io_apic.c in kernel 2.4.6, 
that's compiled by default. 

It looks to me like there's a typo in the APIC_LOCKUP_DEBUG code that 
results in certain hardware setups potentially triggering an infinite loop, 
while holding the ioapic spinlock: namely when the irq_2_pin list contains 
more than one list member: the loop pointer gets reinitialized each time at 
the top of the loop - kablooey. 

After upgrading from 2.4.3 to 2.4.7, my 440GX motherboard (with a couple of 
PCI devices) keels over fast enough that even the NMI watchdog doesn't help, 
and the following patch fixes it. 

-- 
Sam 


--=_0_2220_1002679466
Content-Disposition: inline; filename="linux-2.4.6-ioapicdebugfix.patch"
Content-Type: text/plain; charset="iso-8859-1"; name="linux-2.4.6-ioapicdebugfix.patch"
Content-Transfer-Encoding: 7bit

*** linux/arch/i386/kernel/io_apic.c.orig	Tue Oct  9 21:11:10 2001
--- linux/arch/i386/kernel/io_apic.c	Tue Oct  9 21:13:03 2001
***************
*** 1248,1261 ****
  	ack_APIC_irq();
  
  	if (!(v & (1 << (i & 0x1f)))) {
  #ifdef APIC_MISMATCH_DEBUG
  		atomic_inc(&irq_mis_count);
  #endif
  		spin_lock(&ioapic_lock);
  		__mask_and_edge_IO_APIC_irq(irq);
  #ifdef APIC_LOCKUP_DEBUG
! 		for (;;) {
! 			struct irq_pin_list *entry = irq_2_pin + irq;
  			unsigned int reg;
  
  			if (entry->pin == -1)
--- 1248,1264 ----
  	ack_APIC_irq();
  
  	if (!(v & (1 << (i & 0x1f)))) {
+ #ifdef APIC_LOCKUP_DEBUG
+ 		struct irq_pin_list *entry;
+ #endif
+ 
  #ifdef APIC_MISMATCH_DEBUG
  		atomic_inc(&irq_mis_count);
  #endif
  		spin_lock(&ioapic_lock);
  		__mask_and_edge_IO_APIC_irq(irq);
  #ifdef APIC_LOCKUP_DEBUG
! 		for (entry = irq_2_pin + irq;;) {
  			unsigned int reg;
  
  			if (entry->pin == -1)

--=_0_2220_1002679466--
