Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbSLWGwn>; Mon, 23 Dec 2002 01:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbSLWGwn>; Mon, 23 Dec 2002 01:52:43 -0500
Received: from franka.aracnet.com ([216.99.193.44]:43687 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266643AbSLWGwm>; Mon, 23 Dec 2002 01:52:42 -0500
Date: Sun, 22 Dec 2002 23:00:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 7/8 Move NUMA-Q support into subarch
Message-ID: <66950000.1040626845@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one fixes up the IPI code to do something more sensible. 
Sorry, was just too ugly to leave it alone ... but I did keep
it seperated out ;-) Though this is not an equivalent transform
it will only affect NUMA-Q & summit  - same op twice because some
twit just split it out in the last patch for both NUMA-Q & Summit.

Because clustered apic logical mode can't do arbitrary broadcasts
of addressing (it's not just a bitmap), I have to do send IPI 
instructions as a sequence of unicasts. However, there's already
a loop in the generic send_IPI_mask code to do that ... there's
no need to call send_IPI_mask once for each CPU. The comment I
wrote at the time even noted that this was silly.

diff -urpN -X /home/fletch/.diff.exclude 15-numaq5/include/asm-i386/mach-numaq/mach_ipi.h 16-numaq6/include/asm-i386/mach-numaq/mach_ipi.h
--- 15-numaq5/include/asm-i386/mach-numaq/mach_ipi.h	Sun Dec 22 12:11:09 2002
+++ 16-numaq6/include/asm-i386/mach-numaq/mach_ipi.h	Sun Dec 22 12:11:34 2002
@@ -10,30 +10,15 @@ static inline void send_IPI_mask(int mas
 
 static inline void send_IPI_allbutself(int vector)
 {
-	int cpu;
-	/*
-	 * if there are no other CPUs in the system then we get an APIC send 
-	 * error if we try to broadcast, thus avoid sending IPIs in this case.
-	 */
-	if (!(num_online_cpus() > 1))
-		return;
+	unsigned long mask = cpu_online_map & ~(1 << smp_processor_id());
 
-	/* Pointless. Use send_IPI_mask to do this instead */
-	for (cpu = 0; cpu < NR_CPUS; ++cpu)
-		if (cpu_online(cpu) && cpu != smp_processor_id())
-			send_IPI_mask(1 << cpu, vector);
-
-	return;
+	if (mask)
+		send_IPI_mask(mask, vector);
 }
 
 static inline void send_IPI_all(int vector)
 {
-	int cpu;
-
-	/* Pointless. Use send_IPI_mask to do this instead */
-	for (cpu = 0; cpu < NR_CPUS; ++cpu)
-		if (cpu_online(cpu))
-			send_IPI_mask(1 << cpu, vector);
+	send_IPI_mask(cpu_online_map, vector);
 }
 
 #endif /* __ASM_MACH_IPI_H */
diff -urpN -X /home/fletch/.diff.exclude 15-numaq5/include/asm-i386/mach-summit/mach_ipi.h 16-numaq6/include/asm-i386/mach-summit/mach_ipi.h
--- 15-numaq5/include/asm-i386/mach-summit/mach_ipi.h	Sun Dec 22 12:11:09 2002
+++ 16-numaq6/include/asm-i386/mach-summit/mach_ipi.h	Sun Dec 22 12:11:34 2002
@@ -10,30 +10,15 @@ static inline void send_IPI_mask(int mas
 
 static inline void send_IPI_allbutself(int vector)
 {
-	int cpu;
-	/*
-	 * if there are no other CPUs in the system then we get an APIC send 
-	 * error if we try to broadcast, thus avoid sending IPIs in this case.
-	 */
-	if (!(num_online_cpus() > 1))
-		return;
+	unsigned long mask = cpu_online_map & ~(1 << smp_processor_id());
 
-	/* Pointless. Use send_IPI_mask to do this instead */
-	for (cpu = 0; cpu < NR_CPUS; ++cpu)
-		if (cpu_online(cpu) && cpu != smp_processor_id())
-			send_IPI_mask(1 << cpu, vector);
-
-	return;
+	if (mask)
+		send_IPI_mask(mask, vector);
 }
 
 static inline void send_IPI_all(int vector)
 {
-	int cpu;
-
-	/* Pointless. Use send_IPI_mask to do this instead */
-	for (cpu = 0; cpu < NR_CPUS; ++cpu)
-		if (cpu_online(cpu))
-			send_IPI_mask(1 << cpu, vector);
+	send_IPI_mask(cpu_online_map, vector);
 }
 
 #endif /* __ASM_MACH_IPI_H */

