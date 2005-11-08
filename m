Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbVKHEZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbVKHEZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965321AbVKHEZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:25:31 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:48146 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965205AbVKHEZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:25:30 -0500
Date: Mon, 7 Nov 2005 20:23:35 -0800
Message-Id: <200511080423.jA84NZdb009865@zach-dev.vmware.com>
Subject: [PATCH 5/21] i386 Pnp byte granularity
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
X-OriginalArrivalTime: 08 Nov 2005 04:23:35.0714 (UTC) FILETIME=[2F813020:01C5E41C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The one remaining caller of set_limit, the PnP BIOS code, calls into the PnP
BIOS, passing kernel parameters in and out.  These parameteres may be passed
from arbitrary kernel virtual memory, so they deserve strict protection to
stop a bad BIOS from smashing beyond the object size.

Unfortunately, the use of set_limit was badly botching this by setting
the limit in terms of pages, when it really should have byte granularity.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/head.S	2005-11-04 16:55:01.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/head.S	2005-11-05 00:28:12.000000000 -0800
@@ -504,12 +504,12 @@ ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* 0x80 TSS descriptor */
 	.quad 0x0000000000000000	/* 0x88 LDT descriptor */
 
-	/* Segments used for calling PnP BIOS */
-	.quad 0x00c09a0000000000	/* 0x90 32-bit code */
-	.quad 0x00809a0000000000	/* 0x98 16-bit code */
-	.quad 0x0080920000000000	/* 0xa0 16-bit data */
-	.quad 0x0080920000000000	/* 0xa8 16-bit data */
-	.quad 0x0080920000000000	/* 0xb0 16-bit data */
+	/* Segments used for calling PnP BIOS have byte granularity */
+	.quad 0x00409a0000000000	/* 0x90 32-bit code */
+	.quad 0x00009a0000000000	/* 0x98 16-bit code */
+	.quad 0x0000920000000000	/* 0xa0 16-bit data */
+	.quad 0x0000920000000000	/* 0xa8 16-bit data */
+	.quad 0x0000920000000000	/* 0xb0 16-bit data */
 
 	/*
 	 * The APM segments have byte granularity and their bases
Index: linux-2.6.14-zach-work/include/asm-i386/desc.h
===================================================================
Index: linux-2.6.14-zach-work/include/asm-i386/system.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/system.h	2005-11-04 16:55:01.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/system.h	2005-11-05 00:28:10.000000000 -0800
@@ -54,7 +54,7 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
         ); } while(0)
 
 #define set_base(ldt,base) _set_base( ((char *)&(ldt)) , (base) )
-#define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , ((limit)-1)>>12 )
+#define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , ((limit)-1) )
 
 static inline unsigned long _get_base(char * addr)
 {
