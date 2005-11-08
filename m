Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVKHEZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVKHEZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbVKHEZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:25:28 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:42770 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964921AbVKHEZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:25:27 -0500
Date: Mon, 7 Nov 2005 20:22:26 -0800
Message-Id: <200511080422.jA84MQxK009859@zach-dev.vmware.com>
Subject: [PATCH 4/21] i386 Broken bios common
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:22:26.0688 (UTC) FILETIME=[065CA800:01C5E41C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both the APM BIOS and PnP BIOS code use a segment hack to simulate real
mode selector 0x40 (which points to the BIOS data area at 0x00400 in
real mode).  Several broken BIOSen use selector 0x40 as if they were
running in real mode, which we make work by faking up selector 0x40 in
the GDT to point to physical memory starting at 0x400.  We limit the
access to the remainder of this physical page using a byte granular
limit.  Rather than have this tricky code in multiple places, it makes
sense to define it in one place, and the GDT makes a very convenient
place for it.  Use GDT entry 4 as the BAD_BIOS_CACHE segment.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/include/asm-i386/segment.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/segment.h	2005-11-04 15:46:10.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/segment.h	2005-11-05 00:28:05.000000000 -0800
@@ -91,6 +91,15 @@
 #define GDT_ENTRY_BOOT_DS		(GDT_ENTRY_BOOT_CS + 1)
 #define __BOOT_DS	(GDT_ENTRY_BOOT_DS * 8)
 
+/*
+ * Turns out the BIOS data area at 0x400 is commonly accessed from broken
+ * BIOS using real mode selector 0x40.  We cached the bogus BIOS segment
+ * descriptor in a spare entry and fix it up at boot.
+ */
+#define GDT_ENTRY_BAD_BIOS_CACHE       4
+#define GDT_ENTRY_BAD_BIOS             (0x40 >> 3)
+#define BAD_BIOS_AREA                  (0x400)
+
 /* The PnP BIOS entries in the GDT */
 #define GDT_ENTRY_PNPBIOS_CS32		(GDT_ENTRY_PNPBIOS_BASE + 0)
 #define GDT_ENTRY_PNPBIOS_CS16		(GDT_ENTRY_PNPBIOS_BASE + 1)
Index: linux-2.6.14-zach-work/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/head.S	2005-11-04 15:46:50.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/head.S	2005-11-05 00:28:12.000000000 -0800
@@ -487,7 +487,7 @@ ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* 0x0b reserved */
 	.quad 0x0000000000000000	/* 0x13 reserved */
 	.quad 0x0000000000000000	/* 0x1b reserved */
-	.quad 0x0000000000000000	/* 0x20 unused */
+	.quad 0x0040920004000bff        /* 0x20 bad bios 3072 bytes at 0x400 */
 	.quad 0x0000000000000000	/* 0x28 unused */
 	.quad 0x0000000000000000	/* 0x33 TLS entry 1 */
 	.quad 0x0000000000000000	/* 0x3b TLS entry 2 */
Index: linux-2.6.14-zach-work/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/apm.c	2005-11-04 15:46:50.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/apm.c	2005-11-05 00:28:11.000000000 -0800
@@ -414,7 +414,6 @@ static DECLARE_WAIT_QUEUE_HEAD(apm_waitq
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *	user_list;
 static DEFINE_SPINLOCK(user_list_lock);
-static struct desc_struct	bad_bios_desc = { 0, 0x00409200 };
 
 static char			driver_version[] = "1.16ac";	/* no spaces */
 
@@ -593,7 +592,7 @@ static u8 apm_bios_call(u32 func, u32 eb
 	cpu = get_cpu();
 	gdt = get_cpu_gdt_table(cpu);
 	save_desc_40 = gdt[0x40 / 8];
-	gdt[0x40 / 8] = bad_bios_desc;
+	gdt[0x40 / 8] = gdt[GDT_ENTRY_BAD_BIOS_CACHE];
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -637,7 +636,7 @@ static u8 apm_bios_call_simple(u32 func,
 	cpu = get_cpu();
 	gdt = get_cpu_gdt_table(cpu);
 	save_desc_40 = gdt[0x40 / 8];
-	gdt[0x40 / 8] = bad_bios_desc;
+	gdt[0x40 / 8] = gdt[GDT_ENTRY_BAD_BIOS_CACHE];
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -2275,15 +2274,6 @@ static int __init apm_init(void)
 	pm_active = 1;
 
 	/*
-	 * Set up a segment that references the real mode segment 0x40
-	 * that extends up to the end of page zero (that we have reserved).
-	 * This is for buggy BIOS's that refer to (real mode) segment 0x40
-	 * even though they are called in protected mode.
-	 */
-	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
-	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
-
-	/*
 	 * Set up the long jump entry point to the APM BIOS, which is called
 	 * from inline assembly.
 	 */
Index: linux-2.6.14-zach-work/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/cpu/common.c	2005-11-04 15:46:10.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/cpu/common.c	2005-11-05 00:28:09.000000000 -0800
@@ -596,6 +596,15 @@ void __devinit cpu_init(void)
 	 * and set up the GDT descriptor:
 	 */
  	memcpy(gdt, cpu_gdt_table, GDT_SIZE);
+ 
+	/*
+	 * Set up a segment that references the real mode segment 0x40
+	 * that extends up to the end of page zero (that we have reserved).
+	 * This is for buggy BIOS's that refer to (real mode) segment 0x40
+	 * even though they are called in protected mode.  The limit is
+	 * preset, we hardwire the base here.
+	 */
+	set_base(gdt[GDT_ENTRY_BAD_BIOS_CACHE], __va(BAD_BIOS_AREA));
 
 	/* Set up GDT entry for 16bit stack */
  	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
Index: linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-zach-work.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-04 15:46:10.000000000 -0800
+++ linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c	2005-11-05 00:28:12.000000000 -0800
@@ -70,8 +70,6 @@ set_base(per_cpu(cpu_gdt_table,cpu)[(sel
 set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \
 } while(0)
 
-static struct desc_struct bad_bios_desc = { 0, 0x00409200 };
-
 /*
  * At some point we want to use this stack frame pointer to unwind
  * after PnP BIOS oopses.
@@ -107,7 +105,8 @@ static inline u16 call_pnp_bios(u16 func
 
 	cpu = get_cpu();
 	save_desc_40 = per_cpu(cpu_gdt_table,cpu)[0x40 / 8];
-	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] = bad_bios_desc;
+	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] = 
+		per_cpu(cpu_gdt_table,cpu)[GDT_ENTRY_BAD_BIOS_CACHE];
 
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
@@ -524,8 +523,6 @@ void pnpbios_calls_init(union pnp_bios_i
 	pnp_bios_callpoint.offset = header->fields.pm16offset;
 	pnp_bios_callpoint.segment = PNP_CS16;
 
-	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
-	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
 	for(i=0; i < NR_CPUS; i++)
 	{
 		Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
