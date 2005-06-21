Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVFURIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVFURIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVFURGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:06:23 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:23792 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262186AbVFUQ3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:29:22 -0400
Date: Tue, 21 Jun 2005 18:29:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 13/16] s390: external call performance.
Message-ID: <20050621162919.GM6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 13/16] s390: external call performance.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The kernel uses the SIGP external call order code to signal other
CPUs. When running with dedicated CPUs external calls don't get
delivered immediately but within a fixed polling invervall. This
can lead to delays where the system appears to do nothing. Replace
the SIGP external call order with the SIGP emergency call order
since this one gets delivered immediately.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/head.S     |    2 +-
 arch/s390/kernel/head64.S   |    2 +-
 arch/s390/kernel/s390_ext.c |   16 ++++++++++------
 arch/s390/kernel/smp.c      |   10 +++++-----
 4 files changed, 17 insertions(+), 13 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2005-06-21 17:36:54.000000000 +0200
@@ -750,7 +750,7 @@ _stext:	basr  %r13,0                    
 
 # check control registers
         stctg  %c0,%c15,0(%r15)
-	oi     6(%r15),0x20             # enable sigp external interrupts
+	oi     6(%r15),0x40             # enable sigp emergency signal
 	oi     4(%r15),0x10             # switch on low address proctection
         lctlg  %c0,%c15,0(%r15)
 
diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head.S	2005-06-21 17:36:54.000000000 +0200
@@ -750,7 +750,7 @@ _stext:	basr  %r13,0                    
 
 # check control registers
         stctl  %c0,%c15,0(%r15)
-	oi     2(%r15),0x20             # enable sigp external interrupts
+	oi     2(%r15),0x40             # enable sigp emergency signal
 	oi     0(%r15),0x10             # switch on low address protection
         lctl   %c0,%c15,0(%r15)
 
diff -urpN linux-2.6/arch/s390/kernel/s390_ext.c linux-2.6-patched/arch/s390/kernel/s390_ext.c
--- linux-2.6/arch/s390/kernel/s390_ext.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/s390_ext.c	2005-06-21 17:36:54.000000000 +0200
@@ -19,7 +19,6 @@
 #include <asm/irq.h>
 
 /*
- * Simple hash strategy: index = code & 0xff;
  * ext_int_hash[index] is the start of the list for all external interrupts
  * that hash to this index. With the current set of external interrupts 
  * (0x1202 external call, 0x1004 cpu timer, 0x2401 hwc console, 0x4000
@@ -27,6 +26,11 @@
  */
 ext_int_info_t *ext_int_hash[256] = { 0, };
 
+static inline int ext_hash(__u16 code)
+{
+	return (code + (code >> 9)) & 0xff;
+}
+
 int register_external_interrupt(__u16 code, ext_int_handler_t handler)
 {
         ext_int_info_t *p;
@@ -37,7 +41,7 @@ int register_external_interrupt(__u16 co
                 return -ENOMEM;
         p->code = code;
         p->handler = handler;
-        index = code & 0xff;
+	index = ext_hash(code);
         p->next = ext_int_hash[index];
         ext_int_hash[index] = p;
         return 0;
@@ -52,7 +56,7 @@ int register_early_external_interrupt(__
                 return -EINVAL;
         p->code = code;
         p->handler = handler;
-        index = code & 0xff;
+	index = ext_hash(code);
         p->next = ext_int_hash[index];
         ext_int_hash[index] = p;
         return 0;
@@ -63,7 +67,7 @@ int unregister_external_interrupt(__u16 
         ext_int_info_t *p, *q;
         int index;
 
-        index = code & 0xff;
+	index = ext_hash(code);
         q = NULL;
         p = ext_int_hash[index];
         while (p != NULL) {
@@ -90,7 +94,7 @@ int unregister_early_external_interrupt(
 
 	if (p == NULL || p->code != code || p->handler != handler)
 		return -EINVAL;
-	index = code & 0xff;
+	index = ext_hash(code);
 	q = ext_int_hash[index];
 	if (p != q) {
 		while (q != NULL) {
@@ -120,7 +124,7 @@ void do_extint(struct pt_regs *regs, uns
 		 */
 		account_ticks(regs);
 	kstat_cpu(smp_processor_id()).irqs[EXTERNAL_INTERRUPT]++;
-        index = code & 0xff;
+        index = ext_hash(code);
 	for (p = ext_int_hash[index]; p; p = p->next) {
 		if (likely(p->code == code)) {
 			if (likely(p->handler))
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2005-06-21 17:36:54.000000000 +0200
@@ -375,7 +375,7 @@ static void smp_ext_bitcall(int cpu, ec_
          * Set signaling bit in lowcore of target cpu and kick it
          */
 	set_bit(sig, (unsigned long *) &lowcore_ptr[cpu]->ext_call_fast);
-	while(signal_processor(cpu, sigp_external_call) == sigp_busy)
+	while(signal_processor(cpu, sigp_emergency_signal) == sigp_busy)
 		udelay(10);
 }
 
@@ -394,7 +394,7 @@ static void smp_ext_bitcall_others(ec_bi
                  * Set signaling bit in lowcore of target cpu and kick it
                  */
 		set_bit(sig, (unsigned long *) &lowcore_ptr[cpu]->ext_call_fast);
-		while (signal_processor(cpu, sigp_external_call) == sigp_busy)
+		while (signal_processor(cpu, sigp_emergency_signal) == sigp_busy)
 			udelay(10);
         }
 }
@@ -749,9 +749,9 @@ void __init smp_prepare_cpus(unsigned in
 	unsigned int cpu;
         int i;
 
-        /* request the 0x1202 external interrupt */
-        if (register_external_interrupt(0x1202, do_ext_call_interrupt) != 0)
-                panic("Couldn't request external interrupt 0x1202");
+        /* request the 0x1201 emergency signal external interrupt */
+        if (register_external_interrupt(0x1201, do_ext_call_interrupt) != 0)
+                panic("Couldn't request external interrupt 0x1201");
         smp_check_cpus(max_cpus);
         memset(lowcore_ptr,0,sizeof(lowcore_ptr));  
         /*
