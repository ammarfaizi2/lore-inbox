Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSHMO1R>; Tue, 13 Aug 2002 10:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSHMO1R>; Tue, 13 Aug 2002 10:27:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61636 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315414AbSHMO1Q>;
	Tue, 13 Aug 2002 10:27:16 -0400
Date: Tue, 13 Aug 2002 16:31:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] APM TLS fix, 2.5.31-BK
Message-ID: <Pine.LNX.4.44.0208131629030.30473-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached (tested) patch fixes APM support on 2.5.31-BK. The patch is
based on Stephen Rothwell's patch.

	Ingo


--- linux/arch/i386/kernel/apm.c.orig	Tue Aug 13 16:24:41 2002
+++ linux/arch/i386/kernel/apm.c	Tue Aug 13 16:26:59 2002
@@ -214,6 +214,7 @@
 #include <linux/sched.h>
 #include <linux/pm.h>
 #include <linux/kernel.h>
+#include <linux/smp.h>
 #include <linux/smp_lock.h>
 
 #include <asm/system.h>
@@ -419,6 +420,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *	user_list;
 static spinlock_t		user_list_lock = SPIN_LOCK_UNLOCKED;
+static struct desc_struct	bad_bios_desc = { 0, 0x00409200 };
 
 static char			driver_version[] = "1.16";	/* no spaces */
 
@@ -568,7 +570,12 @@
 	u32 *eax, u32 *ebx, u32 *ecx, u32 *edx, u32 *esi)
 {
 	APM_DECL_SEGS
-	unsigned long	flags;
+	unsigned long		flags;
+	int			cpu = smp_processor_id();
+	struct desc_struct	save_desc_40;
+
+	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
+	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -591,6 +598,7 @@
 		: "memory", "cc");
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
+	cpu_gdt_table[cpu][0x40 / 8] = save_desc_40;
 	return *eax & 0xff;
 }
 
@@ -613,6 +621,11 @@
 	u8		error;
 	APM_DECL_SEGS
 	unsigned long	flags;
+	int			cpu = smp_processor_id();
+	struct desc_struct	save_desc_40;
+
+	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
+	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -639,6 +652,7 @@
 	}
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
+	cpu_gdt_table[smp_processor_id()][0x40 / 8] = save_desc_40;
 	return error;
 }
 
@@ -1927,13 +1941,13 @@
 	 * NOTE: on SMP we call into the APM BIOS only on CPU#0, so it's
 	 * enough to modify CPU#0's GDT.
 	 */
-	for (i = 0; i < NR_CPUS; i++) {
-		set_base(cpu_gdt_table[i][APM_40 >> 3],
-			 __va((unsigned long)0x40 << 4));
-		_set_limit((char *)&cpu_gdt_table[i][APM_40 >> 3], 4095 - (0x40 << 4));
+	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
+	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
+
+	apm_bios_entry.offset = apm_info.bios.offset;
+	apm_bios_entry.segment = APM_CS;
 
-		apm_bios_entry.offset = apm_info.bios.offset;
-		apm_bios_entry.segment = APM_CS;
+	for (i = 0; i < NR_CPUS; i++) {
 		set_base(cpu_gdt_table[i][APM_CS >> 3],
 			 __va((unsigned long)apm_info.bios.cseg << 4));
 		set_base(cpu_gdt_table[i][APM_CS_16 >> 3],
--- linux/include/linux/apm_bios.h.orig	Tue Aug 13 16:24:59 2002
+++ linux/include/linux/apm_bios.h	Tue Aug 13 16:26:05 2002
@@ -21,8 +21,7 @@
 
 #ifdef __KERNEL__
 
-#define APM_40		(GDT_ENTRY_APMBIOS_BASE * 8)
-#define APM_CS		(APM_BASE + 8)
+#define APM_CS		(GDT_ENTRY_APMBIOS_BASE * 8)
 #define APM_CS_16	(APM_CS + 8)
 #define APM_DS		(APM_CS_16 + 8)
 

