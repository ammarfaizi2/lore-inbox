Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266927AbTAOTHx>; Wed, 15 Jan 2003 14:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbTAOTHx>; Wed, 15 Jan 2003 14:07:53 -0500
Received: from franka.aracnet.com ([216.99.193.44]:37768 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266927AbTAOTHk>; Wed, 15 Jan 2003 14:07:40 -0500
Date: Wed, 15 Jan 2003 11:16:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (1/5) Fix interrupt dest mode / delivery mode confusion
Message-ID: <10160000.1042658188@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from James Cleverdon & John Stultz

Currently the naming for the IO-APIC fields is very confused, we assign
dest_LowestPrio to delivery_mode, and INT_DELIVERY_MODE to dest_mode.
The values are correct, but the naming is wrong - this patch corrects
that confusion. It also moves the definitions of those settings into
subarch, where they belong (we have to use fixed delivery mode for Summit 
due to what seems to be an Intel IO-APIC bug with P4 clustered mode).

diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Tue Jan 14 00:39:19 2003
+++ b/arch/i386/kernel/io_apic.c	Tue Jan 14 00:39:19 2003
@@ -719,8 +719,8 @@
 		 */
 		memset(&entry,0,sizeof(entry));
 
-		entry.delivery_mode = dest_LowestPrio;
-		entry.dest_mode = INT_DELIVERY_MODE;
+		entry.delivery_mode = INT_DELIVERY_MODE;
+		entry.dest_mode = INT_DEST_MODE;
 		entry.mask = 0;				/* enable IRQ */
 		entry.dest.logical.logical_dest = TARGET_CPUS;
 
@@ -799,10 +799,10 @@
 	 * We use logical delivery to get the timer IRQ
 	 * to the first CPU.
 	 */
-	entry.dest_mode = INT_DELIVERY_MODE;
+	entry.dest_mode = INT_DEST_MODE;
 	entry.mask = 0;					/* unmask IRQ now */
 	entry.dest.logical.logical_dest = TARGET_CPUS;
-	entry.delivery_mode = dest_LowestPrio;
+	entry.delivery_mode = INT_DELIVERY_MODE;
 	entry.polarity = 0;
 	entry.trigger = 0;
 	entry.vector = vector;
@@ -1880,8 +1880,8 @@
 
 	memset(&entry,0,sizeof(entry));
 
-	entry.delivery_mode = dest_LowestPrio;
-	entry.dest_mode = INT_DELIVERY_MODE;
+	entry.delivery_mode = INT_DELIVERY_MODE;
+	entry.dest_mode = INT_DEST_MODE;
 	entry.dest.logical.logical_dest = TARGET_CPUS;
 	entry.mask = 1;					 /* Disabled (masked) */
 	entry.trigger = 1;				   /* Level sensitive */
diff -Nru a/include/asm-i386/mach-bigsmp/mach_apic.h b/include/asm-i386/mach-bigsmp/mach_apic.h
--- a/include/asm-i386/mach-bigsmp/mach_apic.h	Tue Jan 14 00:39:19 2003
+++ b/include/asm-i386/mach-bigsmp/mach_apic.h	Tue Jan 14 00:39:19 2003
@@ -21,6 +21,9 @@
 #define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)
 #define TARGET_CPUS	((cpu_online_map < 0xf)?cpu_online_map:0xf)
 
+#define INT_DELIVERY_MODE dest_LowestPrio
+#define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
+
 #define APIC_BROADCAST_ID     (0x0f)
 #define check_apicid_used(bitmap, apicid) (0)
 
diff -Nru a/include/asm-i386/mach-default/mach_apic.h b/include/asm-i386/mach-default/mach_apic.h
--- a/include/asm-i386/mach-default/mach_apic.h	Tue Jan 14 00:39:19 2003
+++ b/include/asm-i386/mach-default/mach_apic.h	Tue Jan 14 00:39:19 2003
@@ -12,6 +12,9 @@
 #define no_balance_irq (0)
 #define esr_disable (0)
 
+#define INT_DELIVERY_MODE dest_LowestPrio
+#define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
+
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
 
diff -Nru a/include/asm-i386/mach-numaq/mach_apic.h b/include/asm-i386/mach-numaq/mach_apic.h
--- a/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan 14 00:39:19 2003
+++ b/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan 14 00:39:19 2003
@@ -8,6 +8,9 @@
 #define no_balance_irq (1)
 #define esr_disable (1)
 
+#define INT_DELIVERY_MODE dest_LowestPrio
+#define INT_DEST_MODE 0     /* physical delivery on LOCAL quad */
+ 
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) ((bitmap) & (1 << (apicid)))
 
diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	Tue Jan 14 00:39:19 2003
+++ b/include/asm-i386/mach-summit/mach_apic.h	Tue Jan 14 00:39:19 2003
@@ -25,6 +25,9 @@
 #define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
 #define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
 
+#define INT_DELIVERY_MODE dest_Fixed
+#define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
+
 #define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
 #define check_apicid_used(bitmap, apicid) (0)
 
diff -Nru a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Tue Jan 14 00:39:19 2003
+++ b/include/asm-i386/smp.h	Tue Jan 14 00:39:19 2003
@@ -22,12 +22,6 @@
 #endif
 #endif
 
-#ifdef CONFIG_X86_NUMAQ
- #define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
-#else
- #define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
-#endif
-
 #define BAD_APICID 0xFFu
 #ifdef CONFIG_SMP
 #ifndef __ASSEMBLY__

