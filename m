Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318232AbSGWWyR>; Tue, 23 Jul 2002 18:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318234AbSGWWyR>; Tue, 23 Jul 2002 18:54:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15778 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318232AbSGWWyP>;
	Tue, 23 Jul 2002 18:54:15 -0400
Message-ID: <3D3DDEEC.4050005@us.ibm.com>
Date: Tue, 23 Jul 2002 15:55:40 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mjbligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [patch] config option for irq_balance()
Content-Type: multipart/mixed;
 boundary="------------080308060407080708020400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080308060407080708020400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

IRQ Balancing doesn't work on some hardware platforms or systems with > 8 CPUs. 
  Some benchmarks have also showed that the irq_balancing code is actually a 
performance hit in many cases.  For these reasons, I've created a config option 
to turn of IRQ Balancing if desired.  Attatched is the patch...

Cheers!

-Matt


--------------080308060407080708020400
Content-Type: text/plain;
 name="00-irq_balance-2527.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="00-irq_balance-2527.patch"

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

--------------080308060407080708020400--

