Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbTAGUkM>; Tue, 7 Jan 2003 15:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTAGUbm>; Tue, 7 Jan 2003 15:31:42 -0500
Received: from franka.aracnet.com ([216.99.193.44]:27085 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267495AbTAGUbR>; Tue, 7 Jan 2003 15:31:17 -0500
Date: Tue, 07 Jan 2003 12:21:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (3/7) changes do_boot_cpu to return an error code
Message-ID: <595690000.1041970914@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes do_boot_cpu to return an error code, instead of trying to
work it out later by magic and voodoo. Removes the other usage
of apicid->cpu which is hard to maintain cleanly.


diff -urpN -X /home/fletch/.diff.exclude 02-i386_caching_topo/arch/i386/kernel/smpboot.c 03-boot_error/arch/i386/kernel/smpboot.c
--- 02-i386_caching_topo/arch/i386/kernel/smpboot.c	Tue Jan  7 09:24:51 2003
+++ 03-boot_error/arch/i386/kernel/smpboot.c	Tue Jan  7 09:25:53 2003
@@ -810,14 +810,15 @@ wakeup_secondary_cpu(int phys_apicid, un

 extern unsigned long cpu_initialized;

-static void __init do_boot_cpu (int apicid)
+static int __init do_boot_cpu(int apicid)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
+ * Returns zero if CPU booted OK, else error code from wakeup_secondary_cpu.
  */
 {
 	struct task_struct *idle;
-	unsigned long boot_error = 0;
+	unsigned long boot_error;
 	int timeout, cpu;
 	unsigned long start_eip;
 	unsigned short nmi_high, nmi_low;
@@ -883,14 +884,9 @@ static void __init do_boot_cpu (int apic
 	}

 	/*
-	 * Status is now clean
-	 */
-	boot_error = 0;
-
-	/*
 	 * Starting actual IPI sequence...
 	 */
-	wakeup_secondary_cpu(apicid, start_eip);
+	boot_error = wakeup_secondary_cpu(apicid, start_eip);

 	if (!boot_error) {
 		/*
@@ -946,6 +942,7 @@ static void __init do_boot_cpu (int apic
 		*((volatile unsigned short *) TRAMPOLINE_HIGH) = nmi_high;
 		*((volatile unsigned short *) TRAMPOLINE_LOW) = nmi_low;
 	}
+	return boot_error;
 }

 cycles_t cacheflush_time;
@@ -1117,13 +1114,7 @@ static void __init smp_boot_cpus(unsigne
 		if (max_cpus <= cpucount+1)
 			continue;

-		do_boot_cpu(apicid);
-
-		/*
-		 * Make sure we unmap all failed CPUs
-		 */
-		if ((boot_apicid_to_cpu(apicid) == -1) &&
-				(phys_cpu_present_map & (1 << bit)))
+		if (do_boot_cpu(apicid))
 			printk("CPU #%d not responding - cannot use it.\n",
 								apicid);
 	}

