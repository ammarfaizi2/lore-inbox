Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268213AbTB1VeE>; Fri, 28 Feb 2003 16:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268191AbTB1VdG>; Fri, 28 Feb 2003 16:33:06 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:9428 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268184AbTB1Vcu>;
	Fri, 28 Feb 2003 16:32:50 -0500
Date: Fri, 28 Feb 2003 13:33:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2/7 Fix potential NULL pointer
Message-ID: <361220000.1046468032@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

translation_table could be unintialised on machines other than NUMA-Q.
You never see this, as the compiler happens to optimise it away, but
it's still a Really Bad Idea (tm). Thanks to someone whose name I have
unfortunately forgotten for pointing this out.

Has been tested in my tree for over two weeks on UP, SMP, and NUMA and 
compile tested against a variety of different configs.


diff -urpN -X /home/fletch/.diff.exclude 010-local_pgdat/arch/i386/kernel/mpparse.c 011-mpc_apic_id/arch/i386/kernel/mpparse.c
--- 010-local_pgdat/arch/i386/kernel/mpparse.c	Tue Feb 25 23:03:43 2003
+++ 011-mpc_apic_id/arch/i386/kernel/mpparse.c	Fri Feb 28 08:05:34 2003
@@ -110,7 +110,7 @@ void __init MP_processor_info (struct mp
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;
 
-	apicid = mpc_apic_id(m, translation_table[mpc_record]->trans_quad);
+	apicid = mpc_apic_id(m, translation_table[mpc_record]);
 
 	if (m->mpc_featureflag&(1<<0))
 		Dprintk("    Floating point unit present.\n");
diff -urpN -X /home/fletch/.diff.exclude 010-local_pgdat/include/asm-i386/mach-bigsmp/mach_apic.h 011-mpc_apic_id/include/asm-i386/mach-bigsmp/mach_apic.h
--- 010-local_pgdat/include/asm-i386/mach-bigsmp/mach_apic.h	Fri Jan 17 09:18:31 2003
+++ 011-mpc_apic_id/include/asm-i386/mach-bigsmp/mach_apic.h	Fri Feb 28 08:05:34 2003
@@ -87,7 +87,8 @@ static inline int cpu_to_logical_apicid(
        return (int)cpu_2_logical_apicid[cpu];
  }
 
-static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
+static inline int mpc_apic_id(struct mpc_config_processor *m,
+			struct mpc_config_translation *translation_record)
 {
 	printk("Processor #%d %ld:%ld APIC version %d\n",
 	        m->mpc_apicid,
diff -urpN -X /home/fletch/.diff.exclude 010-local_pgdat/include/asm-i386/mach-default/mach_apic.h 011-mpc_apic_id/include/asm-i386/mach-default/mach_apic.h
--- 010-local_pgdat/include/asm-i386/mach-default/mach_apic.h	Fri Jan 17 09:18:31 2003
+++ 011-mpc_apic_id/include/asm-i386/mach-default/mach_apic.h	Fri Feb 28 08:05:34 2003
@@ -79,7 +79,8 @@ static inline unsigned long apicid_to_cp
 	return (1ul << phys_apicid);
 }
 
-static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
+static inline int mpc_apic_id(struct mpc_config_processor *m, 
+			struct mpc_config_translation *translation_record)
 {
 	printk("Processor #%d %ld:%ld APIC version %d\n",
 			m->mpc_apicid,
diff -urpN -X /home/fletch/.diff.exclude 010-local_pgdat/include/asm-i386/mach-numaq/mach_apic.h 011-mpc_apic_id/include/asm-i386/mach-numaq/mach_apic.h
--- 010-local_pgdat/include/asm-i386/mach-numaq/mach_apic.h	Fri Jan 17 09:18:31 2003
+++ 011-mpc_apic_id/include/asm-i386/mach-numaq/mach_apic.h	Fri Feb 28 08:05:34 2003
@@ -73,8 +73,10 @@ static inline unsigned long apicid_to_cp
 	return ( (logical_apicid&0xf) << (4*apicid_to_node(logical_apicid)) );
 }
 
-static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
+static inline int mpc_apic_id(struct mpc_config_processor *m, 
+			struct mpc_config_translation *translation_record)
 {
+	int quad = translation_record->trans_quad;
 	int logical_apicid = generate_logical_apicid(quad, m->mpc_apicid);
 
 	printk("Processor #%d %ld:%ld APIC version %d (quad %d, apic %d)\n",
diff -urpN -X /home/fletch/.diff.exclude 010-local_pgdat/include/asm-i386/mach-summit/mach_apic.h 011-mpc_apic_id/include/asm-i386/mach-summit/mach_apic.h
--- 010-local_pgdat/include/asm-i386/mach-summit/mach_apic.h	Sat Feb 15 16:11:45 2003
+++ 011-mpc_apic_id/include/asm-i386/mach-summit/mach_apic.h	Fri Feb 28 08:05:34 2003
@@ -90,7 +90,8 @@ static inline unsigned long apicid_to_cp
 		return (1ul << apicid);
 }
 
-static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
+static inline int mpc_apic_id(struct mpc_config_processor *m, 
+			struct mpc_config_translation *translation_record)
 {
 	printk("Processor #%d %ld:%ld APIC version %d\n",
 			m->mpc_apicid,

