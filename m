Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVKHEZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVKHEZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965321AbVKHEZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:25:33 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:50450 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965050AbVKHEZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:25:31 -0500
Date: Mon, 7 Nov 2005 20:24:44 -0800
Message-Id: <200511080424.jA84OicA009872@zach-dev.vmware.com>
Subject: [PATCH 6/21] i386 Fixed pnp bios limits
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
X-OriginalArrivalTime: 08 Nov 2005 04:24:44.0849 (UTC) FILETIME=[58B65A10:01C5E41C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PnP BIOS data, code, and 32-bit entry segments all have fixed limits
as well; set them in the GDT rather than adding more code.  It would
be nice to add these fixups to the boot GDT rather than setting the
GDT for each CPU; perhaps I can wiggle this in later, but getting
it in before the subsys init looks tricky.

Also, make some progress on deprecating the ugly Q_SET_SEL macros.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/head.S	2005-11-04 17:18:05.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/head.S	2005-11-05 00:28:07.000000000 -0800
@@ -504,10 +504,14 @@ ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* 0x80 TSS descriptor */
 	.quad 0x0000000000000000	/* 0x88 LDT descriptor */
 
-	/* Segments used for calling PnP BIOS have byte granularity */
-	.quad 0x00409a0000000000	/* 0x90 32-bit code */
-	.quad 0x00009a0000000000	/* 0x98 16-bit code */
-	.quad 0x0000920000000000	/* 0xa0 16-bit data */
+	/*
+	 * Segments used for calling PnP BIOS have byte granularity.
+	 * They code segments and data segments have fixed 64k limits,
+	 * the transfer segment sizes are set at run time.
+	 */
+	.quad 0x00409a000000ffff	/* 0x90 32-bit code */
+	.quad 0x00009a000000ffff	/* 0x98 16-bit code */
+	.quad 0x000092000000ffff	/* 0xa0 16-bit data */
 	.quad 0x0000920000000000	/* 0xa8 16-bit data */
 	.quad 0x0000920000000000	/* 0xb0 16-bit data */
 
Index: linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-zach-work.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-04 16:54:56.000000000 -0800
+++ linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c	2005-11-05 00:28:11.000000000 -0800
@@ -58,12 +58,6 @@ __asm__(
 	".previous		\n"
 );
 
-#define Q_SET_SEL(cpu, selname, address, size) \
-do { \
-set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], __va((u32)(address))); \
-set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \
-} while(0)
-
 #define Q2_SET_SEL(cpu, selname, address, size) \
 do { \
 set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], (u32)(address)); \
@@ -523,10 +517,10 @@ void pnpbios_calls_init(union pnp_bios_i
 	pnp_bios_callpoint.offset = header->fields.pm16offset;
 	pnp_bios_callpoint.segment = PNP_CS16;
 
-	for(i=0; i < NR_CPUS; i++)
-	{
-		Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
-		Q_SET_SEL(i, PNP_CS16, header->fields.pm16cseg, 64 * 1024);
-		Q_SET_SEL(i, PNP_DS, header->fields.pm16dseg, 64 * 1024);
+	for(i=0; i < NR_CPUS; i++) {
+		struct desc_struct *gdt = get_cpu_gdt_table(i);
+		set_base(gdt[GDT_ENTRY_PNPBIOS_CS32], &pnp_bios_callfunc);
+		set_base(gdt[GDT_ENTRY_PNPBIOS_CS16], __va(header->fields.pm16cseg));
+		set_base(gdt[GDT_ENTRY_PNPBIOS_DS], __va(header->fields.pm16dseg));
 	}
 }
