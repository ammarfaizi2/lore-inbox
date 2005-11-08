Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbVKHEVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVKHEVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVKHEVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:21:20 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:4356 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750880AbVKHEVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:21:19 -0500
Date: Mon, 7 Nov 2005 20:21:17 -0800
Message-Id: <200511080421.jA84LHbS009853@zach-dev.vmware.com>
Subject: [PATCH 3/21] i386 Apm seg in gdt
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
X-OriginalArrivalTime: 08 Nov 2005 04:21:17.0490 (UTC) FILETIME=[DD1DE120:01C5E41B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since APM BIOS segment limits are now fixed, set them in head.S GDT and
don't use the complicated _set_limit() macro expansion.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/head.S	2005-11-04 15:46:11.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/head.S	2005-11-05 00:28:13.000000000 -0800
@@ -510,13 +510,14 @@ ENTRY(cpu_gdt_table)
 	.quad 0x0080920000000000	/* 0xa0 16-bit data */
 	.quad 0x0080920000000000	/* 0xa8 16-bit data */
 	.quad 0x0080920000000000	/* 0xb0 16-bit data */
+
 	/*
 	 * The APM segments have byte granularity and their bases
-	 * and limits are set at run time.
+	 * are set at run time.  All have 64k limits.
 	 */
-	.quad 0x00409a0000000000	/* 0xb8 APM CS    code */
-	.quad 0x00009a0000000000	/* 0xc0 APM CS 16 code (16 bit) */
-	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
+	.quad 0x00409a000000ffff	/* 0xb8 APM CS    code */
+	.quad 0x00009a000000ffff	/* 0xc0 APM CS 16 code (16 bit) */
+	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
 
 	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
 	.quad 0x0000000000000000	/* 0xd8 - unused */
Index: linux-2.6.14-zach-work/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/apm.c	2005-11-04 15:46:50.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/apm.c	2005-11-05 00:28:13.000000000 -0800
@@ -2305,12 +2305,6 @@ static int __init apm_init(void)
 			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
 		set_base(gdt[APM_DS >> 3],
 			 __va((unsigned long)apm_info.bios.dseg << 4));
-		/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
-		_set_limit((char *)&gdt[APM_CS >> 3], 64 * 1024 - 1);
-		/* For some unknown machine. */
-		_set_limit((char *)&gdt[APM_CS_16 >> 3], 64 * 1024 - 1);
-		/* For the DEC Hinote Ultra CT475 (and others?) */
-		_set_limit((char *)&gdt[APM_DS >> 3], 64 * 1024 - 1);
 	}
 
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
