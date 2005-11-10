Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVKJAm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVKJAm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVKJAm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:42:28 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:13316 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751139AbVKJAm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:42:27 -0500
Date: Wed, 9 Nov 2005 16:42:26 -0800
Message-Id: <200511100042.jAA0gQIu028372@zach-dev.vmware.com>
Subject: [PATCH 7/10] Fixed pnp bios limits
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 10 Nov 2005 00:42:26.0344 (UTC) FILETIME=[9F2B8280:01C5E58F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PnP BIOS data, code, and 32-bit entry segments all have fixed limits
as well; set them in the GDT rather than adding more code.  It would
be nice to add these fixups to the boot GDT rather than setting the
GDT for each CPU; perhaps I can wiggle this in later, but getting
it in before the subsys init looks tricky.

Also, make some progress on deprecating the ugly Q_SET_SEL macros.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/head.S	2005-11-09 01:46:48.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/head.S	2005-11-09 06:11:35.000000000 -0800
@@ -504,10 +504,14 @@
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
 
Index: linux-2.6.14/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-09 05:30:24.000000000 -0800
+++ linux-2.6.14/drivers/pnp/pnpbios/bioscalls.c	2005-11-09 06:12:53.000000000 -0800
@@ -58,13 +58,6 @@
 	".previous		\n"
 );
 
-#define Q_SET_SEL(cpu, selname, address, size) \
-do { \
-struct desc_struct *gdt = get_cpu_gdt_table((cpu)); \
-set_base(gdt[(selname) >> 3], __va((u32)(address))); \
-set_limit(gdt[(selname) >> 3], size); \
-} while(0)
-
 #define Q2_SET_SEL(cpu, selname, address, size) \
 do { \
 struct desc_struct *gdt = get_cpu_gdt_table((cpu)); \
@@ -534,8 +527,8 @@
   		struct desc_struct *gdt = get_cpu_gdt_table(i);
   		if (!gdt)
   			continue;
-		Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
-		Q_SET_SEL(i, PNP_CS16, header->fields.pm16cseg, 64 * 1024);
-		Q_SET_SEL(i, PNP_DS, header->fields.pm16dseg, 64 * 1024);
-	}
+ 		set_base(gdt[GDT_ENTRY_PNPBIOS_CS32], &pnp_bios_callfunc);
+ 		set_base(gdt[GDT_ENTRY_PNPBIOS_CS16], __va(header->fields.pm16cseg));
+ 		set_base(gdt[GDT_ENTRY_PNPBIOS_DS], __va(header->fields.pm16dseg));
+  	}
 }
