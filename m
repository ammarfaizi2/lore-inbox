Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTEVOFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 10:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTEVOFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 10:05:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58304 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261876AbTEVOFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 10:05:40 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: William Lee Irwin III <wli@holomorphy.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: userspace irq balancer
Date: Thu, 22 May 2003 07:18:06 -0700
User-Agent: KMail/1.4.3
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, haveblue@us.ibm.com,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       mannthey@us.ibm.com
References: <3014AAAC8E0930438FD38EBF6DCEB5640204334F@fmsmsx407.fm.intel.com> <E19Idxq-0001LD-00@w-gerrit2> <20030522020443.GN2444@holomorphy.com>
In-Reply-To: <20030522020443.GN2444@holomorphy.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_62LAVOEG5TXEIZ8JW4F8"
Message-Id: <200305220718.06982.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_62LAVOEG5TXEIZ8JW4F8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 21 May 2003 07:04 pm, William Lee Irwin III wrote:
[ Snip! ]
> ...
> IMHO Linux on Pentium IV should use the TPR in conjunction with _very_
> simplistic interrupt load accounting by default and all more
> sophisticated logic should be punted straight to userspace as an
> administrative API.
>
[ Snip! ]
>
> i.e. frob the fscking TPR as recommended by the APIC docs every once in
> a while by default, punt anything (and everything) fancier up to
> userspace, and get the code that doesn't even understand what the fsck
> DESTMOD means the Hell out of the kernel and the Hell away from my
> IO-APIC RTE's.
>
>
> -- wli

Here's my old very stupid TPR patch .  It lacks TPRing soft ints for kern=
el=20
preemption, etc.  Because the xTPR logic only compares the top nibble of =
the=20
TPR and I don't want to mask out IRQs unnecessarily, it only tracks busy/=
idle=20
and IRQ/no-IRQ.

Simple enough for you, Bill?   8^)

--=20
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

--------------Boundary-00=_62LAVOEG5TXEIZ8JW4F8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="tpr_dyn-2003-01-10_2.5.55"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="tpr_dyn-2003-01-10_2.5.55"

diff -pru j55/arch/i386/kernel/irq.c t55/arch/i386/kernel/irq.c
--- j55/arch/i386/kernel/irq.c	Wed Jan  8 20:03:51 2003
+++ t55/arch/i386/kernel/irq.c	Fri Jan 10 18:01:03 2003
@@ -329,6 +329,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 	struct irqaction * action;
 	unsigned int status;
 
+	apic_adj_tpr(TPR_IRQ);
 	irq_enter();
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
@@ -406,6 +407,7 @@ out:
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+	apic_adj_tpr(-TPR_IRQ);
 
 	return 1;
 }
diff -pru j55/arch/i386/kernel/process.c t55/arch/i386/kernel/process.c
--- j55/arch/i386/kernel/process.c	Wed Jan  8 20:03:48 2003
+++ t55/arch/i386/kernel/process.c	Fri Jan 10 17:59:13 2003
@@ -143,7 +143,9 @@ void cpu_idle (void)
 		irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 		while (!need_resched())
 			idle();
+		apic_set_tpr(TPR_TASK);
 		schedule();
+		apic_set_tpr(TPR_IDLE);
 	}
 }
 
diff -pru j55/include/asm-i386/apic.h t55/include/asm-i386/apic.h
--- j55/include/asm-i386/apic.h	Wed Jan  8 20:04:27 2003
+++ t55/include/asm-i386/apic.h	Fri Jan 10 17:59:13 2003
@@ -64,6 +64,22 @@ static inline void ack_APIC_irq(void)
 	apic_write_around(APIC_EOI, 0);
 }
 
+static inline void apic_set_tpr(unsigned long val)
+{
+	unsigned long value;
+
+	value = apic_read(APIC_TASKPRI);
+	apic_write_around(APIC_TASKPRI, (value & ~APIC_TPRI_MASK) + val);
+}
+
+static inline void apic_adj_tpr(long adj)
+{
+	unsigned long value;
+
+	value = apic_read(APIC_TASKPRI);
+	apic_write_around(APIC_TASKPRI, value + adj);
+}
+
 extern int get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void connect_bsp_APIC (void);
@@ -96,6 +112,15 @@ extern unsigned int nmi_watchdog;
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
 
+#else /* CONFIG_X86_LOCAL_APIC */
+#define apic_set_tpr(val)
+#define apic_adj_tpr(adj)
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+/* Priority values for apic_adj_tpr() and apic_set_tpr() */
+/* xAPICs only do priority comparisons on the upper nibble. */
+#define TPR_IDLE	(0x00L)
+#define TPR_TASK	(0x10L)
+#define TPR_IRQ		(0x10L)
+
 #endif /* __ASM_APIC_H */
diff -pru j55/include/asm-i386/mach-summit/mach_apic.h t55/include/asm-i386/mach-summit/mach_apic.h
--- j55/include/asm-i386/mach-summit/mach_apic.h	Fri Jan 10 16:16:44 2003
+++ t55/include/asm-i386/mach-summit/mach_apic.h	Fri Jan 10 19:24:52 2003
@@ -4,7 +4,7 @@
 extern int x86_summit;
 
 #define esr_disable (1)
-#define no_balance_irq (0)
+#define no_balance_irq (1)
 
 #define XAPIC_DEST_CPUS_MASK    0x0Fu
 #define XAPIC_DEST_CLUSTER_MASK 0xF0u
@@ -13,7 +13,7 @@ extern int x86_summit;
 		((phys_apic) & XAPIC_DEST_CLUSTER_MASK) )
 
 #define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
-#define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
+#define TARGET_CPUS	(x86_summit ? xapic_round_robin_cpu_apic_id() : cpu_online_map)
 
 #define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
 #define check_apicid_used(bitmap, apicid) (0)
@@ -106,4 +106,20 @@ static inline int check_phys_apicid_pres
 	return (1);
 }
 
+/*
+ * xapic_round_robin_cpu_apic_id --  Distribute the interrupts using a simple
+ *					round robin scheme.
+ */
+static inline int xapic_round_robin_cpu_apic_id(void)
+{
+	int val;
+	static unsigned	next_cpu = 0;
+
+	if (next_cpu >= NR_CPUS || cpu_2_logical_apicid[next_cpu] == BAD_APICID)
+		next_cpu = 0;
+	val = cpu_to_logical_apicid(next_cpu) | XAPIC_DEST_CPUS_MASK;
+	++next_cpu;
+	return (val);
+}
+
 #endif /* __ASM_MACH_APIC_H */

--------------Boundary-00=_62LAVOEG5TXEIZ8JW4F8--

