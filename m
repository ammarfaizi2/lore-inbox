Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVKJAhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVKJAhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVKJAhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:37:36 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:34825 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751124AbVKJAhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:37:35 -0500
Date: Wed, 9 Nov 2005 16:37:34 -0800
Message-Id: <200511100037.jAA0bY4U027733@zach-dev.vmware.com>
Subject: [PATCH 4/10] Apm seg in gdt
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 10 Nov 2005 00:37:34.0988 (UTC) FILETIME=[F1821CC0:01C5E58E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since APM BIOS segment limits are now fixed, set them in head.S GDT and
don't use the complicated _set_limit() macro expansion.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/head.S	2005-11-08 05:41:06.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/head.S	2005-11-08 05:41:19.000000000 -0800
@@ -510,13 +510,14 @@
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
Index: linux-2.6.14/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/apm.c	2005-11-08 05:41:14.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/apm.c	2005-11-08 05:41:19.000000000 -0800
@@ -2306,12 +2306,6 @@
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
