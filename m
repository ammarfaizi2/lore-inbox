Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVDZT6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVDZT6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 15:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVDZT6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 15:58:44 -0400
Received: from aun.it.uu.se ([130.238.12.36]:46830 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261763AbVDZT6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 15:58:41 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17006.40286.664503.252615@alkaid.it.uu.se>
Date: Tue, 26 Apr 2005 21:58:22 +0200
To: ak@suse.de, marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31-pre1] x86_64 breakage on UP_IOAPIC
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The

  o x86_64: Resend lost APIC IRQs on Uniprocessor too

change in 2.4.31-pre1 causes linkage errors: on UP_IOAPIC systems it
creates references to send_IPI_self() which is only defined on SMP.

The patch below reverts this change.

Alternatively, x86_64 could implement a send_IPI_self() fallback for !SMP,
just like i386 does.

/Mikael

--- linux-2.4.31-pre1/include/asm-x86_64/hw_irq.h.~1~	2005-04-26 20:57:43.000000000 +0200
+++ linux-2.4.31-pre1/include/asm-x86_64/hw_irq.h	2005-04-26 21:09:31.000000000 +0200
@@ -156,7 +156,7 @@ static inline void x86_do_profile (unsig
 	atomic_inc((atomic_t *)&prof_buffer[eip]);
 }
 
-#ifdef CONFIG_X86_IO_APIC
+#ifdef CONFIG_SMP /*more of this file should probably be ifdefed SMP */
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
 	if (IO_APIC_IRQ(i))
 		send_IPI_self(IO_APIC_VECTOR(i));
