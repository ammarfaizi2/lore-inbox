Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTAKEVY>; Fri, 10 Jan 2003 23:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbTAKEVY>; Fri, 10 Jan 2003 23:21:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:5548 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267043AbTAKEVU>;
	Fri, 10 Jan 2003 23:21:20 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Andrew Theurer <habanero@us.ibm.com>, nitin.a.kamble@intel.com
Subject: Re: [PATCH][2.4] generic cluster APIC support for systems with more than 8 CPUs
Date: Fri, 10 Jan 2003 20:28:13 -0800
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>
References: <200301071642.39321.habanero@us.ibm.com>
In-Reply-To: <200301071642.39321.habanero@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1F8J1RQOV2L5ROCP3ORZ"
Message-Id: <200301102028.13461.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_1F8J1RQOV2L5ROCP3ORZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 January 2003 02:42 pm, Andrew Theurer wrote:
[ Snip! ]

>
> I am bringing this up, because I recall James Cleverdon having some cod=
e
> which allows interrupts to be dynamically routed to two CPU destination=
s, a
> pair of CPUs with consecutive CPU ID's.  Interrupts are dynamically rou=
ted
> to the least loaded CPU, and if both are idle, to the CPU with the lowe=
r
> CPUID.  I like this idea, because when in HT, if consecutive logical CP=
U
> ID's map to one physical core, we get to use "whole" processor, and bot=
h
> destinations share the cache.  Anyway, just a thought.
>
> -Andrew Theurer

Here's a quick respin of my old TPR patch for 2.5.55.

--=20
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

--------------Boundary-00=_1F8J1RQOV2L5ROCP3ORZ
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

--------------Boundary-00=_1F8J1RQOV2L5ROCP3ORZ--

