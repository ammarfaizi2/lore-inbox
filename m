Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTAYVxw>; Sat, 25 Jan 2003 16:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbTAYVxw>; Sat, 25 Jan 2003 16:53:52 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:56277 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262394AbTAYVxv>;
	Sat, 25 Jan 2003 16:53:51 -0500
Subject: [RFC][PATCH] linux-2.5.59_smp-summit_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: text/plain
Organization: 
Message-Id: <1043531681.1028.16.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 25 Jan 2003 13:54:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 
	This patch simply fixes the summit subarch so that a summit kernel will
boot normally on regular SMP systems. 

Comments, flames, etc. welcome.

thanks
-john


diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	Sat Jan 25 13:51:34 2003
+++ b/include/asm-i386/mach-summit/mach_apic.h	Sat Jan 25 13:51:34 2003
@@ -3,7 +3,7 @@
 
 extern int x86_summit;
 
-#define esr_disable (1)
+#define esr_disable (x86_summit ? 1 : 0)
 #define no_balance_irq (0)
 
 #define XAPIC_DEST_CPUS_MASK    0x0Fu
@@ -15,14 +15,14 @@
 #define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
 #define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
 
-#define INT_DELIVERY_MODE dest_Fixed
+#define INT_DELIVERY_MODE (x86_summit ? dest_Fixed : dest_LowestPrio)
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
 #define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
-#define check_apicid_used(bitmap, apicid) (0)
+#define check_apicid_used(bitmap, apicid) (x86_summit ? 0 : (bitmap & (1 << apicid)))
 
 /* we don't use the phys_cpu_present_map to indicate apicid presence */
-#define check_apicid_present(bit) (1) 
+#define check_apicid_present(bit) (x86_summit ? 1 : (phys_cpu_present_map & (1 << bit))) 
 
 extern u8 bios_cpu_apicid[];
 
@@ -106,7 +106,10 @@
 
 static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
 {
-	return (1);
+	if (x86_summit)
+		return (1);
+	else
+		return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
 #endif /* __ASM_MACH_APIC_H */





