Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVCJEjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVCJEjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVCJEdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:33:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22236 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262554AbVCIXxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:53:42 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 15:52:03 -0800
User-Agent: KMail/1.7.2
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       axboe@suse.de
References: <200503092218.j29MICg26503@unix-os.sc.intel.com> <m1r7iov1ya.fsf@muc.de>
In-Reply-To: <m1r7iov1ya.fsf@muc.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jw4LCJHYNXMA8Uq"
Message-Id: <200503091552.04007.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_jw4LCJHYNXMA8Uq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday, March 9, 2005 3:23 pm, Andi Kleen wrote:
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:
> > Just to clarify here, these data need to be taken at grain of salt. A
> > high count in _spin_unlock_* functions do not automatically points to
> > lock contention.  It's one of the blind spot syndrome with timer based
> > profile on ia64.  There are some lock contentions in 2.6 kernel that
> > we are staring at.  Please do not misinterpret the number here.
>
> Why don't you use oprofile=C2>? It uses NMIs and can profile "inside"
> interrupt disabled sections.

That was oprofile output, but on ia64, 'NMI's are maskable due to the way i=
rq=20
disabling works.  Here's a very hackish patch that changes the kernel to us=
e=20
cr.tpr instead of psr.i for interrupt control.  Making oprofile use real ia=
64=20
NMIs is left as an exercise for the reader :)

Jesse

--Boundary-00=_jw4LCJHYNXMA8Uq
Content-Type: text/plain;
  charset="iso-8859-1";
  name="nmi-enable-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nmi-enable-5.patch"

===== arch/ia64/Kconfig.debug 1.2 vs edited =====
--- 1.2/arch/ia64/Kconfig.debug	2005-01-07 16:15:52 -08:00
+++ edited/arch/ia64/Kconfig.debug	2005-02-28 10:07:27 -08:00
@@ -56,6 +56,15 @@
 	  and restore instructions.  It's useful for tracking down spinlock
 	  problems, but slow!  If you're unsure, select N.
 
+config IA64_ALLOW_NMI
+	bool "Allow non-maskable interrupts"
+	help
+	  The normal ia64 irq enable/disable code prevents even non-maskable
+	  interrupts from occuring, which can be a problem for kernel
+	  debuggers, watchdogs, and profilers.  Say Y here if you're interested
+	  in NMIs and don't mind the small performance penalty this option
+	  imposes.
+
 config SYSVIPC_COMPAT
 	bool
 	depends on COMPAT && SYSVIPC
===== arch/ia64/kernel/head.S 1.31 vs edited =====
--- 1.31/arch/ia64/kernel/head.S	2005-01-28 15:50:13 -08:00
+++ edited/arch/ia64/kernel/head.S	2005-03-01 13:17:51 -08:00
@@ -59,6 +59,14 @@
 	.save rp, r0		// terminate unwind chain with a NULL rp
 	.body
 
+#ifdef CONFIG_IA64_ALLOW_NMI	// disable interrupts initially (re-enabled in start_kernel())
+	mov r16=1<<16
+	;;
+	mov cr.tpr=r16
+	;;
+	srlz.d
+	;;
+#endif
 	rsm psr.i | psr.ic
 	;;
 	srlz.i
@@ -129,8 +137,8 @@
 	/*
 	 * Switch into virtual mode:
 	 */
-	movl r16=(IA64_PSR_IT|IA64_PSR_IC|IA64_PSR_DT|IA64_PSR_RT|IA64_PSR_DFH|IA64_PSR_BN \
-		  |IA64_PSR_DI)
+	movl r16=(IA64_PSR_IT|IA64_PSR_IC|IA64_PSR_I|IA64_PSR_DT|IA64_PSR_RT|IA64_PSR_DFH|\
+		  IA64_PSR_BN|IA64_PSR_DI)
 	;;
 	mov cr.ipsr=r16
 	movl r17=1f
===== arch/ia64/kernel/irq_ia64.c 1.25 vs edited =====
--- 1.25/arch/ia64/kernel/irq_ia64.c	2005-01-22 15:54:49 -08:00
+++ edited/arch/ia64/kernel/irq_ia64.c	2005-03-01 12:50:18 -08:00
@@ -103,8 +103,6 @@
 void
 ia64_handle_irq (ia64_vector vector, struct pt_regs *regs)
 {
-	unsigned long saved_tpr;
-
 #if IRQ_DEBUG
 	{
 		unsigned long bsp, sp;
@@ -135,17 +133,9 @@
 	}
 #endif /* IRQ_DEBUG */
 
-	/*
-	 * Always set TPR to limit maximum interrupt nesting depth to
-	 * 16 (without this, it would be ~240, which could easily lead
-	 * to kernel stack overflows).
-	 */
 	irq_enter();
-	saved_tpr = ia64_getreg(_IA64_REG_CR_TPR);
-	ia64_srlz_d();
 	while (vector != IA64_SPURIOUS_INT_VECTOR) {
 		if (!IS_RESCHEDULE(vector)) {
-			ia64_setreg(_IA64_REG_CR_TPR, vector);
 			ia64_srlz_d();
 
 			__do_IRQ(local_vector_to_irq(vector), regs);
@@ -154,7 +144,6 @@
 			 * Disable interrupts and send EOI:
 			 */
 			local_irq_disable();
-			ia64_setreg(_IA64_REG_CR_TPR, saved_tpr);
 		}
 		ia64_eoi();
 		vector = ia64_get_ivr();
@@ -165,6 +154,7 @@
 	 * come through until ia64_eoi() has been done.
 	 */
 	irq_exit();
+	local_irq_enable();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
===== include/asm-ia64/hw_irq.h 1.15 vs edited =====
--- 1.15/include/asm-ia64/hw_irq.h	2005-01-22 15:54:52 -08:00
+++ edited/include/asm-ia64/hw_irq.h	2005-03-01 13:01:03 -08:00
@@ -36,6 +36,10 @@
 
 #define AUTO_ASSIGN			-1
 
+#define IA64_NMI_VECTOR			0x02	/* NMI (note that this can be
+						   masked if psr.i or psr.ic
+						   are cleared) */
+
 #define IA64_SPURIOUS_INT_VECTOR	0x0f
 
 /*
===== include/asm-ia64/system.h 1.48 vs edited =====
--- 1.48/include/asm-ia64/system.h	2005-01-04 18:48:18 -08:00
+++ edited/include/asm-ia64/system.h	2005-03-01 15:28:23 -08:00
@@ -107,12 +107,61 @@
 
 #define safe_halt()         ia64_pal_halt_light()    /* PAL_HALT_LIGHT */
 
+/* For spinlocks etc */
+#ifdef CONFIG_IA64_ALLOW_NMI
+
+#define IA64_TPR_MMI_BIT (1<<16)
+
+#define __local_irq_save(x)			\
+do {						\
+	(x) = ia64_getreg(_IA64_REG_CR_TPR);	\
+	ia64_stop();				\
+	ia64_setreg(_IA64_REG_CR_TPR, IA64_TPR_MMI_BIT);	\
+	ia64_stop();				\
+	ia64_srlz_d();				\
+} while (0)
+
+static inline void __local_irq_disable(void)
+{
+	u64 __tpr;
+
+	__tpr = ia64_getreg(_IA64_REG_CR_TPR);
+	ia64_stop();
+	ia64_setreg(_IA64_REG_CR_TPR, IA64_TPR_MMI_BIT);
+	ia64_stop();
+	ia64_srlz_d();
+}
+
+static inline void __local_irq_restore(unsigned long flags)
+{
+	ia64_setreg(_IA64_REG_CR_TPR, flags);
+	ia64_stop();
+	ia64_srlz_d();
+}
+
+static inline void local_irq_enable(void)
+{
+	ia64_setreg(_IA64_REG_CR_TPR, 0);
+ 	ia64_srlz_d();
+	ia64_ssm(IA64_PSR_I); ia64_srlz_d();
+}
+
+#define local_save_flags(flags)	((flags) = ia64_getreg(_IA64_REG_CR_TPR))
+
+static inline int irqs_disabled(void)
+{
+	unsigned long __ia64_id_flags;
+	local_save_flags(__ia64_id_flags);
+	return __ia64_id_flags & IA64_TPR_MMI_BIT;
+}
+
+#else /* !CONFIG_IA64_ALLOW_NMI */
+
 /*
  * The group barrier in front of the rsm & ssm are necessary to ensure
  * that none of the previous instructions in the same group are
  * affected by the rsm/ssm.
  */
-/* For spinlocks etc */
 
 /*
  * - clearing psr.i is implicitly serialized (visible by next insn)
@@ -137,6 +186,19 @@
 
 #define __local_irq_restore(x)	ia64_intrin_local_irq_restore((x) & IA64_PSR_I)
 
+#define local_irq_enable()	({ ia64_ssm(IA64_PSR_I); ia64_srlz_d(); })
+#define local_save_flags(flags)	((flags) = ia64_getreg(_IA64_REG_PSR))
+
+#define irqs_disabled()				\
+({						\
+	unsigned long __ia64_id_flags;		\
+	local_save_flags(__ia64_id_flags);	\
+	(__ia64_id_flags & IA64_PSR_I) == 0;	\
+})
+
+#endif /* CONFIG_IA64_ALLOW_NMI */
+
+/* FIXME: need to change for ALLOW_NMI */
 #ifdef CONFIG_IA64_DEBUG_IRQ
 
   extern unsigned long last_cli_ip;
@@ -170,16 +232,6 @@
 # define local_irq_disable()	__local_irq_disable()
 # define local_irq_restore(x)	__local_irq_restore(x)
 #endif /* !CONFIG_IA64_DEBUG_IRQ */
-
-#define local_irq_enable()	({ ia64_stop(); ia64_ssm(IA64_PSR_I); ia64_srlz_d(); })
-#define local_save_flags(flags)	({ ia64_stop(); (flags) = ia64_getreg(_IA64_REG_PSR); })
-
-#define irqs_disabled()				\
-({						\
-	unsigned long __ia64_id_flags;		\
-	local_save_flags(__ia64_id_flags);	\
-	(__ia64_id_flags & IA64_PSR_I) == 0;	\
-})
 
 #ifdef __KERNEL__
 

--Boundary-00=_jw4LCJHYNXMA8Uq--
