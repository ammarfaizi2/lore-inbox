Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbSLWGsi>; Mon, 23 Dec 2002 01:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSLWGsi>; Mon, 23 Dec 2002 01:48:38 -0500
Received: from franka.aracnet.com ([216.99.193.44]:19107 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266638AbSLWGsf>; Mon, 23 Dec 2002 01:48:35 -0500
Date: Sun, 22 Dec 2002 22:56:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 6/8 Move NUMA-Q support into subarch
Message-ID: <61840000.1040626597@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat the IPI stuff, specifically send_IPI_mask,
send_IPI_allbutself, and send_IPI_all. Though the way they
work is pretty silly for NUMA-Q, I do an equivalent transform
here, and fix the code in a seperate patch (next one).
Goes into mach_ipi.h


diff -urpN -X /home/fletch/.diff.exclude 14-numaq4/arch/i386/kernel/smp.c 15-numaq5/arch/i386/kernel/smp.c
--- 14-numaq4/arch/i386/kernel/smp.c	Sun Nov 17 20:29:22 2002
+++ 15-numaq5/arch/i386/kernel/smp.c	Sun Dec 22 12:11:09 2002
@@ -24,6 +24,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/smpboot.h>
+#include <mach_ipi.h>
 
 /*
  *	Some notes on x86 processor bugs affecting SMP operation:
@@ -225,54 +226,6 @@ static inline void send_IPI_mask_sequenc
 		}
 	}
 	local_irq_restore(flags);
-}
-
-static inline void send_IPI_mask(int mask, int vector)
-{
-	if (clustered_apic_mode) 
-		send_IPI_mask_sequence(mask, vector);
-	else
-		send_IPI_mask_bitmask(mask, vector);
-}
-
-static inline void send_IPI_allbutself(int vector)
-{
-	/*
-	 * if there are no other CPUs in the system then
-	 * we get an APIC send error if we try to broadcast.
-	 * thus we have to avoid sending IPIs in this case.
-	 */
-	if (!(num_online_cpus() > 1))
-		return;
-
-	if (clustered_apic_mode) {
-		// Pointless. Use send_IPI_mask to do this instead
-		int cpu;
-
-		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
-			if (cpu_online(cpu) && cpu != smp_processor_id())
-				send_IPI_mask(1 << cpu, vector);
-		}
-	} else {
-		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-		return;
-	}
-}
-
-static inline void send_IPI_all(int vector)
-{
-	if (clustered_apic_mode) {
-		// Pointless. Use send_IPI_mask to do this instead
-		int cpu;
-
-		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
-			if (!cpu_online(cpu))
-				continue;
-			send_IPI_mask(1 << cpu, vector);
-		}
-	} else {
-		__send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-	}
 }
 
 /*
diff -urpN -X /home/fletch/.diff.exclude 14-numaq4/include/asm-i386/mach-default/mach_ipi.h 15-numaq5/include/asm-i386/mach-default/mach_ipi.h
--- 14-numaq4/include/asm-i386/mach-default/mach_ipi.h	Wed Dec 31 16:00:00 1969
+++ 15-numaq5/include/asm-i386/mach-default/mach_ipi.h	Sun Dec 22 12:11:09 2002
@@ -0,0 +1,30 @@
+#ifndef __ASM_MACH_IPI_H
+#define __ASM_MACH_IPI_H
+
+static inline void send_IPI_mask_bitmask(int mask, int vector);
+static inline void __send_IPI_shortcut(unsigned int shortcut, int vector);
+
+static inline void send_IPI_mask(int mask, int vector)
+{
+	send_IPI_mask_bitmask(mask, vector);
+}
+
+static inline void send_IPI_allbutself(int vector)
+{
+	/*
+	 * if there are no other CPUs in the system then we get an APIC send 
+	 * error if we try to broadcast, thus avoid sending IPIs in this case.
+	 */
+	if (!(num_online_cpus() > 1))
+		return;
+
+	__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+	return;
+}
+
+static inline void send_IPI_all(int vector)
+{
+	__send_IPI_shortcut(APIC_DEST_ALLINC, vector);
+}
+
+#endif /* __ASM_MACH_IPI_H */
diff -urpN -X /home/fletch/.diff.exclude 14-numaq4/include/asm-i386/mach-numaq/mach_ipi.h 15-numaq5/include/asm-i386/mach-numaq/mach_ipi.h
--- 14-numaq4/include/asm-i386/mach-numaq/mach_ipi.h	Wed Dec 31 16:00:00 1969
+++ 15-numaq5/include/asm-i386/mach-numaq/mach_ipi.h	Sun Dec 22 12:11:09 2002
@@ -0,0 +1,39 @@
+#ifndef __ASM_MACH_IPI_H
+#define __ASM_MACH_IPI_H
+
+static inline void send_IPI_mask_sequence(int mask, int vector);
+
+static inline void send_IPI_mask(int mask, int vector)
+{
+	send_IPI_mask_sequence(mask, vector);
+}
+
+static inline void send_IPI_allbutself(int vector)
+{
+	int cpu;
+	/*
+	 * if there are no other CPUs in the system then we get an APIC send 
+	 * error if we try to broadcast, thus avoid sending IPIs in this case.
+	 */
+	if (!(num_online_cpus() > 1))
+		return;
+
+	/* Pointless. Use send_IPI_mask to do this instead */
+	for (cpu = 0; cpu < NR_CPUS; ++cpu)
+		if (cpu_online(cpu) && cpu != smp_processor_id())
+			send_IPI_mask(1 << cpu, vector);
+
+	return;
+}
+
+static inline void send_IPI_all(int vector)
+{
+	int cpu;
+
+	/* Pointless. Use send_IPI_mask to do this instead */
+	for (cpu = 0; cpu < NR_CPUS; ++cpu)
+		if (cpu_online(cpu))
+			send_IPI_mask(1 << cpu, vector);
+}
+
+#endif /* __ASM_MACH_IPI_H */
diff -urpN -X /home/fletch/.diff.exclude 14-numaq4/include/asm-i386/mach-summit/mach_ipi.h 15-numaq5/include/asm-i386/mach-summit/mach_ipi.h
--- 14-numaq4/include/asm-i386/mach-summit/mach_ipi.h	Wed Dec 31 16:00:00 1969
+++ 15-numaq5/include/asm-i386/mach-summit/mach_ipi.h	Sun Dec 22 12:11:09 2002
@@ -0,0 +1,39 @@
+#ifndef __ASM_MACH_IPI_H
+#define __ASM_MACH_IPI_H
+
+static inline void send_IPI_mask_sequence(int mask, int vector);
+
+static inline void send_IPI_mask(int mask, int vector)
+{
+	send_IPI_mask_sequence(mask, vector);
+}
+
+static inline void send_IPI_allbutself(int vector)
+{
+	int cpu;
+	/*
+	 * if there are no other CPUs in the system then we get an APIC send 
+	 * error if we try to broadcast, thus avoid sending IPIs in this case.
+	 */
+	if (!(num_online_cpus() > 1))
+		return;
+
+	/* Pointless. Use send_IPI_mask to do this instead */
+	for (cpu = 0; cpu < NR_CPUS; ++cpu)
+		if (cpu_online(cpu) && cpu != smp_processor_id())
+			send_IPI_mask(1 << cpu, vector);
+
+	return;
+}
+
+static inline void send_IPI_all(int vector)
+{
+	int cpu;
+
+	/* Pointless. Use send_IPI_mask to do this instead */
+	for (cpu = 0; cpu < NR_CPUS; ++cpu)
+		if (cpu_online(cpu))
+			send_IPI_mask(1 << cpu, vector);
+}
+
+#endif /* __ASM_MACH_IPI_H */

