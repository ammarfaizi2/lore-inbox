Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318064AbSHLOos>; Mon, 12 Aug 2002 10:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318071AbSHLOoh>; Mon, 12 Aug 2002 10:44:37 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:50922 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S318064AbSHLOn1>;
	Mon, 12 Aug 2002 10:43:27 -0400
Date: Tue, 13 Aug 2002 00:46:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] tls-2.5.31-C3
Message-Id: <20020813004634.026db357.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0208121205170.2561-100000@localhost.localdomain>
References: <20020812173404.39d3abab.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0208121205170.2561-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002 12:07:19 +0200 (CEST) Ingo Molnar <mingo@elte.hu> wrote:
> 
> you can save/restore 0x40 in kernel-space if you need to no problem.

How about the following (untested, not even compiled):

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.31/arch/i386/kernel/apm.c 2.5.31-apm.1/arch/i386/kernel/apm.c
--- 2.5.31/arch/i386/kernel/apm.c	2002-08-02 11:11:34.000000000 +1000
+++ 2.5.31-apm.1/arch/i386/kernel/apm.c	2002-08-13 00:20:56.000000000 +1000
@@ -215,6 +215,7 @@
 #include <linux/pm.h>
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/smp.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -419,6 +420,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *	user_list;
 static spinlock_t		user_list_lock = SPIN_LOCK_UNLOCKED;
+static struct desc_struct	bad_bios_desc = { 0, 0x00409200 };
 
 static char			driver_version[] = "1.16";	/* no spaces */
 
@@ -569,7 +571,12 @@
 {
 	APM_DECL_SEGS
 	unsigned long	flags;
+	int			cpu;
+	struct desc_struct	save_desc_40;
 
+	cpu = get_cpu();
+	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
+	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
 	local_save_flags(flags);
 	APM_DO_CLI;
 	APM_DO_SAVE_SEGS;
@@ -591,6 +598,8 @@
 		: "memory", "cc");
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
+	cpu_gdt_table[cpu][0x40 / 8] = save_desc_40;
+	put_cpu();
 	return *eax & 0xff;
 }
 
@@ -613,7 +622,12 @@
 	u8		error;
 	APM_DECL_SEGS
 	unsigned long	flags;
+	int			cpu;
+	struct desc_struct	save_desc_40;
 
+	cpu = get_cpu();
+	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
+	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
 	local_save_flags(flags);
 	APM_DO_CLI;
 	APM_DO_SAVE_SEGS;
@@ -639,6 +653,8 @@
 	}
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
+	cpu_gdt_table[smp_processor_id()][0x40 / 8] = save_desc_40;
+	put_cpu();
 	return error;
 }
 
@@ -1923,17 +1939,14 @@
 	 * that extends up to the end of page zero (that we have reserved).
 	 * This is for buggy BIOS's that refer to (real mode) segment 0x40
 	 * even though they are called in protected mode.
-	 *
-	 * NOTE: on SMP we call into the APM BIOS only on CPU#0, so it's
-	 * enough to modify CPU#0's GDT.
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
diff -ruN 2.5.31/arch/i386/kernel/head.S 2.5.31-apm.1/arch/i386/kernel/head.S
--- 2.5.31/arch/i386/kernel/head.S	2002-07-28 21:11:25.000000000 +1000
+++ 2.5.31-apm.1/arch/i386/kernel/head.S	2002-08-13 00:29:38.000000000 +1000
@@ -427,7 +427,10 @@
 	 * The APM segments have byte granularity and their bases
 	 * and limits are set at run time.
 	 */
-	.quad 0x0040920000000000	/* 0x40 APM set up for bad BIOS's */
+	.quad 0x0000000000000000	/* 0x40 APM will be used for bad BIOS's
+					 * Will be saved and restored
+					 * across BIOS calls. MUST NOT BE ONE
+					 * OF THE FOLLOWING THREE! */
 	.quad 0x00409a0000000000	/* 0x48 APM CS    code */
 	.quad 0x00009a0000000000	/* 0x50 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0x58 APM DS    data */
diff -ruN 2.5.31/include/linux/apm_bios.h 2.5.31-apm.1/include/linux/apm_bios.h
--- 2.5.31/include/linux/apm_bios.h	2001-08-14 09:39:28.000000000 +1000
+++ 2.5.31-apm.1/include/linux/apm_bios.h	2002-08-13 00:38:52.000000000 +1000
@@ -21,8 +21,7 @@
 
 #ifdef __KERNEL__
 
-#define APM_40		0x40
-#define APM_CS		(APM_40 + 8)
+#define APM_CS		0x48
 #define APM_CS_16	(APM_CS + 8)
 #define APM_DS		(APM_CS_16 + 8)
 
