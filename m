Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbSLWGlI>; Mon, 23 Dec 2002 01:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbSLWGlI>; Mon, 23 Dec 2002 01:41:08 -0500
Received: from franka.aracnet.com ([216.99.193.44]:52123 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266615AbSLWGlG>; Mon, 23 Dec 2002 01:41:06 -0500
Date: Sun, 22 Dec 2002 22:49:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 4/8 Move NUMA-Q support into subarch
Message-ID: <52060000.1040626149@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of code originally by James Cleverdon. 
Abstracts out code from the mpparse stuff into:

mpc_apic_id()
apicid_to_cpu_present()

instead of using clustered_apic_mode switching.

diff -urpN -X /home/fletch/.diff.exclude 12-numaq2/arch/i386/kernel/mpparse.c 13-numaq3/arch/i386/kernel/mpparse.c
--- 12-numaq2/arch/i386/kernel/mpparse.c	Sun Dec 22 12:08:42 2002
+++ 13-numaq3/arch/i386/kernel/mpparse.c	Sun Dec 22 12:10:10 2002
@@ -104,28 +104,12 @@ static struct mpc_config_translation *tr
 
 void __init MP_processor_info (struct mpc_config_processor *m)
 {
- 	int ver, quad, logical_apicid;
+ 	int ver, apicid;
  	
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;
 
-	logical_apicid = m->mpc_apicid;
-	if (clustered_apic_mode) {
-		quad = translation_table[mpc_record]->trans_quad;
-		logical_apicid = (quad << 4) + 
-			(m->mpc_apicid ? m->mpc_apicid << 1 : 1);
-		printk("Processor #%d %ld:%ld APIC version %d (quad %d, apic %d)\n",
-			m->mpc_apicid,
-		        (m->mpc_cpufeature & CPU_FAMILY_MASK)>>8,
-			(m->mpc_cpufeature & CPU_MODEL_MASK)>>4,
-			m->mpc_apicver, quad, logical_apicid);
-	} else {
-		printk("Processor #%d %ld:%ld APIC version %d\n",
-			m->mpc_apicid,
-			(m->mpc_cpufeature & CPU_FAMILY_MASK)>>8,
-			(m->mpc_cpufeature & CPU_MODEL_MASK)>>4,
-			m->mpc_apicver);
-	}
+	apicid = mpc_apic_id(m, translation_table[mpc_record]->trans_quad);
 
 	if (m->mpc_featureflag&(1<<0))
 		Dprintk("    Floating point unit present.\n");
@@ -178,7 +162,7 @@ void __init MP_processor_info (struct mp
 	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
 		Dprintk("    Bootup CPU\n");
 		boot_cpu_physical_apicid = m->mpc_apicid;
-		boot_cpu_logical_apicid = logical_apicid;
+		boot_cpu_logical_apicid = apicid;
 	}
 
 	num_processors++;
@@ -191,11 +175,8 @@ void __init MP_processor_info (struct mp
 	}
 	ver = m->mpc_apicver;
 
-	if (clustered_apic_mode) {
-		phys_cpu_present_map |= (logical_apicid&0xf) << (4*quad);
-	} else {
-		phys_cpu_present_map |= apicid_to_cpu_present(m->mpc_apicid);
-	}
+	phys_cpu_present_map |= apicid_to_cpu_present(apicid);
+	
 	/*
 	 * Validate version
 	 */
diff -urpN -X /home/fletch/.diff.exclude 12-numaq2/include/asm-i386/mach-default/mach_apic.h 13-numaq3/include/asm-i386/mach-default/mach_apic.h
--- 12-numaq2/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:09:41 2002
+++ 13-numaq3/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:10:10 2002
@@ -57,9 +57,19 @@ static inline int cpu_present_to_apicid(
 	return  mps_cpu;
 }
 
-static inline unsigned long apicid_to_cpu_present(int apicid)
+static inline unsigned long apicid_to_cpu_present(int phys_apicid)
 {
-	return (1ul << apicid);
+	return (1ul << phys_apicid);
+}
+
+static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
+{
+	printk("Processor #%d %ld:%ld APIC version %d\n",
+			m->mpc_apicid,
+			(m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
+			(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
+			m->mpc_apicver);
+	return (m->mpc_apicid);
 }
 
 #endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude 12-numaq2/include/asm-i386/mach-numaq/mach_apic.h 13-numaq3/include/asm-i386/mach-numaq/mach_apic.h
--- 12-numaq2/include/asm-i386/mach-numaq/mach_apic.h	Sun Dec 22 12:09:41 2002
+++ 13-numaq3/include/asm-i386/mach-numaq/mach_apic.h	Sun Dec 22 12:10:10 2002
@@ -40,9 +40,31 @@ static inline int cpu_present_to_apicid(
 	return ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) );
 }
 
-static inline unsigned long apicid_to_cpu_present(int apicid)
+static inline int generate_logical_apicid(int quad, int phys_apicid)
 {
-	return (1ul << apicid);
+	return ( (quad << 4) + (phys_apicid ? phys_apicid << 1 : 1) );
+}
+
+static inline int apicid_to_quad(int logical_apicid) 
+{
+	return (logical_apicid >> 4);
+}
+
+static inline unsigned long apicid_to_cpu_present(int logical_apicid)
+{
+	return ( (logical_apicid&0xf) << (4*apicid_to_quad(logical_apicid)) );
+}
+
+static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
+{
+	int logical_apicid = generate_logical_apicid(quad, m->mpc_apicid);
+
+	printk("Processor #%d %ld:%ld APIC version %d (quad %d, apic %d)\n",
+			m->mpc_apicid,
+			(m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
+			(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
+			m->mpc_apicver, quad, logical_apicid);
+	return logical_apicid;
 }
 
 #endif /* __ASM_MACH_APIC_H */

