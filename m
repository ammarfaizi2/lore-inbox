Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVK1X1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVK1X1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVK1X1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:27:45 -0500
Received: from fmr13.intel.com ([192.55.52.67]:15320 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932281AbVK1X1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:27:44 -0500
Subject: trival patch: disable interrupt in play_dead
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, akpm <akpm@osdl.org>, ak <ak@muc.de>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 22:48:16 -0800
Message-Id: <1133246896.8076.4.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's physical CPU hotplug now, so disable interrupt in play_dead.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.14-root/arch/x86_64/kernel/process.c |    5 +++--
 linux-2.6.14-root/include/asm-x86_64/system.h  |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff -puN arch/x86_64/kernel/process.c~cpuhp-disable-interrupt arch/x86_64/kernel/process.c
--- linux-2.6.14/arch/x86_64/kernel/process.c~cpuhp-disable-interrupt	2005-11-28 22:20:28.000000000 -0800
+++ linux-2.6.14-root/arch/x86_64/kernel/process.c	2005-11-28 22:20:28.000000000 -0800
@@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
 DECLARE_PER_CPU(int, cpu_state);
 
 #include <asm/nmi.h>
-/* We don't actually take CPU down, just spin without interrupts. */
+/* We halt the CPU with physical CPU hotplug */
 static inline void play_dead(void)
 {
 	idle_task_exit();
@@ -166,8 +166,9 @@ static inline void play_dead(void)
 	/* Ack it */
 	__get_cpu_var(cpu_state) = CPU_DEAD;
 
+	local_irq_disable();
 	while (1)
-		safe_halt();
+		halt();
 }
 #else
 static inline void play_dead(void)
diff -puN include/asm-x86_64/system.h~cpuhp-disable-interrupt include/asm-x86_64/system.h
--- linux-2.6.14/include/asm-x86_64/system.h~cpuhp-disable-interrupt	2005-11-28 22:20:28.000000000 -0800
+++ linux-2.6.14-root/include/asm-x86_64/system.h	2005-11-28 22:20:28.000000000 -0800
@@ -315,6 +315,8 @@ static inline unsigned long __cmpxchg(vo
 #define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
+/* used when interrupts are already enabled or to shutdown the processor */
+#define halt()			__asm__ __volatile__("hlt": : :"memory")
 
 #define irqs_disabled()			\
 ({					\
_


