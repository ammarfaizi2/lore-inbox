Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWHGVNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWHGVNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWHGVLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:11:45 -0400
Received: from xenotime.net ([66.160.160.81]:24795 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932384AbWHGVLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:11:18 -0400
Date: Mon, 7 Aug 2006 14:11:09 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>, paulus@samba.org,
       schwidefsky@de.ibm.com
Subject: [PATCH 2/9] Replace __ARCH_HAS_DO_SOFTIRQ with
 CONFIG_ARCH_DO_SOFTIRQ
Message-Id: <20060807141109.7e4d912d.rdunlap@xenotime.net>
In-Reply-To: <20060807120928.c0fe7045.rdunlap@xenotime.net>
References: <20060807120928.c0fe7045.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Replace __ARCH_HAS_DO_SOFTIRQ with CONFIG_ARCH_DO_SOFTIRQ.
Move it from header files to Kconfig space.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/Kconfig          |    4 ++++
 arch/powerpc/Kconfig       |    3 +++
 arch/s390/Kconfig          |    3 +++
 arch/x86_64/Kconfig        |    3 +++
 include/asm-i386/irq.h     |    1 -
 include/asm-powerpc/irq.h  |    2 --
 include/asm-s390/hardirq.h |    1 -
 include/asm-x86_64/irq.h   |    2 --
 kernel/softirq.c           |    2 +-
 9 files changed, 14 insertions(+), 7 deletions(-)

--- linux-2618-rc4-arch.orig/kernel/softirq.c
+++ linux-2618-rc4-arch/kernel/softirq.c
@@ -249,7 +249,7 @@ restart:
 	_local_bh_enable();
 }
 
-#ifndef __ARCH_HAS_DO_SOFTIRQ
+#ifndef CONFIG_ARCH_DO_SOFTIRQ
 
 asmlinkage void do_softirq(void)
 {
--- linux-2618-rc4-arch.orig/include/asm-i386/irq.h
+++ linux-2618-rc4-arch/include/asm-i386/irq.h
@@ -27,7 +27,6 @@ static __inline__ int irq_canonicalize(i
 #ifdef CONFIG_4KSTACKS
   extern void irq_ctx_init(int cpu);
   extern void irq_ctx_exit(int cpu);
-# define __ARCH_HAS_DO_SOFTIRQ
 #else
 # define irq_ctx_init(cpu) do { } while (0)
 # define irq_ctx_exit(cpu) do { } while (0)
--- linux-2618-rc4-arch.orig/include/asm-powerpc/irq.h
+++ linux-2618-rc4-arch/include/asm-powerpc/irq.h
@@ -813,8 +813,6 @@ extern int distribute_irqs;
 struct irqaction;
 struct pt_regs;
 
-#define __ARCH_HAS_DO_SOFTIRQ
-
 extern void __do_softirq(void);
 
 #ifdef CONFIG_IRQSTACKS
--- linux-2618-rc4-arch.orig/include/asm-s390/hardirq.h
+++ linux-2618-rc4-arch/include/asm-s390/hardirq.h
@@ -28,7 +28,6 @@ typedef struct {
 #define local_softirq_pending() (S390_lowcore.softirq_pending)
 
 #define __ARCH_IRQ_STAT
-#define __ARCH_HAS_DO_SOFTIRQ
 
 #define HARDIRQ_BITS	8
 
--- linux-2618-rc4-arch.orig/include/asm-x86_64/irq.h
+++ linux-2618-rc4-arch/include/asm-x86_64/irq.h
@@ -53,6 +53,4 @@ static __inline__ int irq_canonicalize(i
 extern void fixup_irqs(cpumask_t map);
 #endif
 
-#define __ARCH_HAS_DO_SOFTIRQ 1
-
 #endif /* _ASM_IRQ_H */
--- linux-2618-rc4-arch.orig/arch/i386/Kconfig
+++ linux-2618-rc4-arch/arch/i386/Kconfig
@@ -1162,6 +1162,10 @@ config GENERIC_PENDING_IRQ
 	depends on GENERIC_HARDIRQS && SMP
 	default y
 
+config ARCH_DO_SOFTIRQ
+	def_bool y
+	depends on 4KSTACKS
+
 config X86_SMP
 	bool
 	depends on SMP && !X86_VOYAGER
--- linux-2618-rc4-arch.orig/arch/powerpc/Kconfig
+++ linux-2618-rc4-arch/arch/powerpc/Kconfig
@@ -34,6 +34,9 @@ config IRQ_PER_CPU
 	bool
 	default y
 
+config ARCH_DO_SOFTIRQ
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
--- linux-2618-rc4-arch.orig/arch/s390/Kconfig
+++ linux-2618-rc4-arch/arch/s390/Kconfig
@@ -33,6 +33,9 @@ config GENERIC_CALIBRATE_DELAY
 config GENERIC_BUST_SPINLOCK
 	bool
 
+config ARCH_DO_SOFTIRQ
+	def_bool y
+
 mainmenu "Linux Kernel Configuration"
 
 config S390
--- linux-2618-rc4-arch.orig/arch/x86_64/Kconfig
+++ linux-2618-rc4-arch/arch/x86_64/Kconfig
@@ -549,6 +549,9 @@ config GENERIC_IRQ_PROBE
 	bool
 	default y
 
+config ARCH_DO_SOFTIRQ
+	def_bool y
+
 # we have no ISA slots, but we do have ISA-style DMA.
 config ISA_DMA_API
 	bool


---
