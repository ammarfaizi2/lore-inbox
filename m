Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318941AbSHEXuK>; Mon, 5 Aug 2002 19:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318942AbSHEXuJ>; Mon, 5 Aug 2002 19:50:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35305 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318941AbSHEXt5>;
	Mon, 5 Aug 2002 19:49:57 -0400
Date: Mon, 05 Aug 2002 16:51:34 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NUMA-Q disable irqbalance
Message-ID: <349030000.1028591494@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Matt Dobson. It disables irq_balance for the NUMA-Q
and makes it a config option for everyone else. This is needed for NUMA-Q
to work, since the irq_balance code assumes a logical flat apic addressing
mode that's not true in all cases. We created a config option since 
irq_balance makes performance significantly worse for some workloads.

Please apply,

Martin.

diff -Nur linux-2.5.25-vanilla/arch/i386/Config.help linux-2.5.25-patched/arch/i386/Config.help
--- linux-2.5.25-vanilla/arch/i386/Config.help	Fri Jul  5 16:42:04 2002
+++ linux-2.5.25-patched/arch/i386/Config.help	Thu Jul 11 17:27:01 2002
@@ -41,6 +41,12 @@
   486, 586, Pentiums, and various instruction-set-compatible chips by
   AMD, Cyrix, and others.
 
+CONFIG_IRQ_BALANCE
+  This option is used to turn IRQ Balancing on machines with multiple
+  APIC's (ie: SMP, NUMA, etc) on or off.  This behavior has been seen 
+  under some conditions to reduce performance, and on some platorms causes
+  interesting hangs, particularly those with more than 8 CPUs.
+
 CONFIG_MULTIQUAD
   This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
   multiquad box. This changes the way that processors are bootstrapped,
diff -Nur linux-2.5.25-vanilla/arch/i386/config.in linux-2.5.25-patched/arch/i386/config.in
--- linux-2.5.25-vanilla/arch/i386/config.in	Fri Jul  5 16:42:20 2002
+++ linux-2.5.25-patched/arch/i386/config.in	Thu Jul 11 17:16:52 2002
@@ -164,8 +164,19 @@
    if [ "$CONFIG_X86_UP_IOAPIC" = "y" ]; then
       define_bool CONFIG_X86_IO_APIC y
    fi
+   define_bool CONFIG_IRQBALANCE n
 else
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   if [ "$CONFIG_MULTIQUAD" = "y" ]; then
+      define_bool CONFIG_IRQBALANCE_DISABLE y
+   else
+      bool 'Turn Off IRQ Balancing' CONFIG_IRQBALANCE_DISABLE
+   fi
+   if [ "$CONFIG_IRQBALANCE_DISABLE" = "y" ]; then
+      define_bool CONFIG_IRQBALANCE n
+   else
+      define_bool CONFIG_IRQBALANCE y
+   fi
 fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
diff -Nur linux-2.5.25-vanilla/arch/i386/kernel/io_apic.c linux-2.5.25-patched/arch/i386/kernel/io_apic.c
--- linux-2.5.25-vanilla/arch/i386/kernel/io_apic.c	Fri Jul  5 16:42:20 2002
+++ linux-2.5.25-patched/arch/i386/kernel/io_apic.c	Thu Jul 11 16:12:28 2002
@@ -199,7 +199,7 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-#if CONFIG_SMP
+#if CONFIG_IRQBALANCE
 
 typedef struct {
 	unsigned int cpu;
@@ -211,15 +211,12 @@
 
 extern unsigned long irq_affinity [NR_IRQS];
 
-#endif
-
 #define IDLE_ENOUGH(cpu,now) \
 		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
 
 #define IRQ_ALLOWED(cpu,allowed_mask) \
 		((1 << cpu) & (allowed_mask))
 
-#if CONFIG_SMP
 static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
 {
 	int search_idle = 1;
@@ -264,9 +261,9 @@
 		set_ioapic_affinity(irq, 1 << entry->cpu);
 	}
 }
-#else /* !SMP */
+#else /* !CONFIG_IRQBALANCE */
 static inline void balance_irq(int irq) { }
-#endif
+#endif /* CONFIG_IRQBALANCE */
 
 /*
  * support for broken MP BIOSs, enables hand-redirection of PIRQ0-7 to

