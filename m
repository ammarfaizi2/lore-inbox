Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVEMIeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVEMIeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVEMIeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:34:20 -0400
Received: from aun.it.uu.se ([130.238.12.36]:57244 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262304AbVEMIeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:34:15 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17028.26204.8545.584415@alkaid.it.uu.se>
Date: Fri, 13 May 2005 10:33:31 +0200
To: marcelo.tosatti@cyclades.com, ak@suse.de
Subject: [PATCH 2.4.31-pre2] x86_64 linkage error on UP_IOAPIC
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When 2.4.31-pre2 is configured for X86_64 && !SMP && UP_IOAPIC
it fails to link:

arch/x86_64/kernel/kernel.o(.text+0x4591): In function `enable_irq':
: undefined reference to `send_IPI_self'
make: *** [vmlinux] Error 1

A broken change in 2.4.31-pre{1,2} made the UP kernel reference
a symbol which is only defined in the SMP kernel.

The patch below fixes this by reverting that change.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -rupN linux-2.4.31-pre2/include/asm-x86_64/hw_irq.h linux-2.4.31-pre2.x86_64-fix/include/asm-x86_64/hw_irq.h
--- linux-2.4.31-pre2/include/asm-x86_64/hw_irq.h	2005-05-13 00:05:51.000000000 +0200
+++ linux-2.4.31-pre2.x86_64-fix/include/asm-x86_64/hw_irq.h	2005-05-13 00:35:59.000000000 +0200
@@ -156,7 +156,7 @@ static inline void x86_do_profile (unsig
 	atomic_inc((atomic_t *)&prof_buffer[eip]);
 }
 
-#ifdef CONFIG_X86_IO_APIC
+#ifdef CONFIG_SMP /*more of this file should probably be ifdefed SMP */
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
 	if (IO_APIC_IRQ(i))
 		send_IPI_self(IO_APIC_VECTOR(i));
