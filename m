Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbTAOTNE>; Wed, 15 Jan 2003 14:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267021AbTAOTNE>; Wed, 15 Jan 2003 14:13:04 -0500
Received: from franka.aracnet.com ([216.99.193.44]:25229 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267005AbTAOTM7>; Wed, 15 Jan 2003 14:12:59 -0500
Date: Wed, 15 Jan 2003 11:21:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (4/5) Fix APIC header defines for Summit
Message-ID: <15250000.1042658510@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from James Cleverdon & John Stultz

Changes IO_APIC_MAX_ID to depend on the APIC type we're using.
The Summit machines have to use a larger set of bits in the apic registers,
we enlarge under ifdef for Summit only. We enlarge MAX_APICS for summit
as well as NUMA-Q (it would be nice to move this to subarch, but it creates
circular dependency problems ... I'll fix this up later).

Adds a check for the newer Summit boxes with a different name.


diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Tue Jan 14 11:02:28 2003
+++ b/arch/i386/kernel/io_apic.c	Tue Jan 14 11:02:28 2003
@@ -1763,7 +1763,7 @@
 
 #ifdef CONFIG_ACPI_BOOT
 
-#define IO_APIC_MAX_ID		15
+#define IO_APIC_MAX_ID APIC_BROADCAST_ID
 
 int __init io_apic_get_unique_id (int ioapic, int apic_id)
 {
diff -Nru a/include/asm-i386/apicdef.h b/include/asm-i386/apicdef.h
--- a/include/asm-i386/apicdef.h	Tue Jan 14 11:02:28 2003
+++ b/include/asm-i386/apicdef.h	Tue Jan 14 11:02:28 2003
@@ -11,8 +11,13 @@
 #define		APIC_DEFAULT_PHYS_BASE	0xfee00000
  
 #define		APIC_ID		0x20
-#define			APIC_ID_MASK		(0x0F<<24)
-#define			GET_APIC_ID(x)		(((x)>>24)&0x0F)
+#ifdef CONFIG_X86_SUMMIT
+ #define		APIC_ID_MASK		(0xFF<<24)
+ #define		GET_APIC_ID(x)		(((x)>>24)&0xFF)
+#else
+ #define		APIC_ID_MASK		(0x0F<<24)
+ #define		GET_APIC_ID(x)		(((x)>>24)&0x0F)
+#endif
 #define		APIC_LVR	0x30
 #define			APIC_LVR_MASK		0xFF00FF
 #define			GET_APIC_VERSION(x)	((x)&0xFF)
diff -Nru a/include/asm-i386/mach-summit/mach_mpparse.h b/include/asm-i386/mach-summit/mach_mpparse.h
--- a/include/asm-i386/mach-summit/mach_mpparse.h	Tue Jan 14 11:02:28 2003
+++ b/include/asm-i386/mach-summit/mach_mpparse.h	Tue Jan 14 11:02:28 2003
@@ -15,7 +15,9 @@
 static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
 		char *productid)
 {
-	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(str, "VIGIL SMP", 9))
+	if (!strncmp(oem, "IBM ENSW", 8) && 
+			(!strncmp(productid, "VIGIL SMP", 9) 
+			 || !strncmp(productid, "RUTHLESS SMP", 12)))
 		x86_summit = 1;
 }
 
diff -Nru a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
--- a/include/asm-i386/mpspec.h	Tue Jan 14 11:02:28 2003
+++ b/include/asm-i386/mpspec.h	Tue Jan 14 11:02:28 2003
@@ -16,11 +16,11 @@
 /*
  * a maximum of 16 APICs with the current APIC ID architecture.
  */
-#ifdef CONFIG_X86_NUMA
+#if defined(CONFIG_X86_NUMAQ) || defined (CONFIG_X86_SUMMIT)
 #define MAX_APICS 256
-#else /* !CONFIG_X86_NUMA */
+#else
 #define MAX_APICS 16
-#endif /* CONFIG_X86_NUMA */
+#endif
 
 #define MAX_MPC_ENTRY 1024
 

