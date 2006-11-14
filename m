Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966149AbWKNQKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966149AbWKNQKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966143AbWKNQJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:09:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:25997 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933451AbWKNQJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:09:01 -0500
From: Andi Kleen <ak@suse.de>
References: <20061114508.445749000@suse.de>
In-Reply-To: <20061114508.445749000@suse.de>
To: patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.19] [9/9] x86_64: Fix race in exit_idle
Message-Id: <20061114160900.0838F13C98@wotan.suse.de>
Date: Tue, 14 Nov 2006 17:08:59 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When another interrupt happens in exit_idle the exit idle notifier
could be called an incorrect number of times.

Add a test_and_clear_bit_pda and use it handle the bit
atomically against interrupts to avoid this.

Pointed out by Stephane Eranian

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/process.c |    3 +--
 include/asm-x86_64/pda.h     |    9 +++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

Index: linux/include/asm-x86_64/pda.h
===================================================================
--- linux.orig/include/asm-x86_64/pda.h
+++ linux/include/asm-x86_64/pda.h
@@ -109,6 +109,15 @@ extern struct x8664_pda _proxy_pda;
 #define sub_pda(field,val) pda_to_op("sub",field,val)
 #define or_pda(field,val) pda_to_op("or",field,val)
 
+/* This is not atomic against other CPUs -- CPU preemption needs to be off */
+#define test_and_clear_bit_pda(bit,field) ({		\
+	int old__;						\
+	asm volatile("btr %2,%%gs:%c3\n\tsbbl %0,%0"		\
+	    : "=r" (old__), "+m" (_proxy_pda.field) 		\
+	    : "dIr" (bit), "i" (pda_offset(field)) : "memory");	\
+	old__;							\
+})
+
 #endif
 
 #define PDA_STACKOFFSET (5*8)
Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -88,9 +88,8 @@ void enter_idle(void)
 
 static void __exit_idle(void)
 {
-	if (read_pda(isidle) == 0)
+	if (test_and_clear_bit_pda(0, isidle) == 0)
 		return;
-	write_pda(isidle, 0);
 	atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
 }
 
