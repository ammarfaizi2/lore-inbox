Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbTBKXRg>; Tue, 11 Feb 2003 18:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbTBKXRg>; Tue, 11 Feb 2003 18:17:36 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:51453 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267743AbTBKXRf>; Tue, 11 Feb 2003 18:17:35 -0500
Subject: [PATCH] linux-2.5.60_smp-summit_A0
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1045005886.985.10.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Feb 2003 15:24:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All, 

	This patch simply fixes the summit subarch to allow summit kernels to
boot on normal systems. 

Please apply.

thanks
-john


diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	Tue Feb 11 15:20:32 2003
+++ b/include/asm-i386/mach-summit/mach_apic.h	Tue Feb 11 15:20:32 2003
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



