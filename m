Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVKJAkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVKJAkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVKJAku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:40:50 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:50441 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751136AbVKJAku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:40:50 -0500
Date: Wed, 9 Nov 2005 16:40:48 -0800
Message-Id: <200511100040.jAA0emVb028347@zach-dev.vmware.com>
Subject: [PATCH 6/10] Pnp byte granularity
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 10 Nov 2005 00:40:49.0200 (UTC) FILETIME=[65448300:01C5E58F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The one remaining caller of set_limit, the PnP BIOS code, calls into the PnP
BIOS, passing kernel parameters in and out.  These parameteres may be passed
from arbitrary kernel virtual memory, so they deserve strict protection to
stop a bad BIOS from smashing beyond the object size.

Unfortunately, the use of set_limit was badly botching this by setting
the limit in terms of pages, when it really should have byte granularity.

When doing this, I discovered my BIOS had the buggy code during the 
"get system device node" call:

 mov ax, es:[bx]

Which is harmless, but has a trivial workaround.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/head.S	2005-11-09 01:46:47.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/head.S	2005-11-09 01:46:48.000000000 -0800
@@ -504,12 +504,12 @@
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
Index: linux-2.6.14/include/asm-i386/system.h
===================================================================
--- linux-2.6.14.orig/include/asm-i386/system.h	2005-11-09 01:46:48.000000000 -0800
+++ linux-2.6.14/include/asm-i386/system.h	2005-11-09 01:46:48.000000000 -0800
@@ -54,7 +54,7 @@
         ); } while(0)
 
 #define set_base(ldt,base) _set_base( ((char *)&(ldt)) , (base) )
-#define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , ((limit)-1)>>12 )
+#define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , ((limit)-1) )
 
 /*
  * Load a segment. Fall back on loading the zero
Index: linux-2.6.14/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-09 05:29:12.000000000 -0800
+++ linux-2.6.14/drivers/pnp/pnpbios/bioscalls.c	2005-11-09 05:30:24.000000000 -0800
@@ -282,12 +282,15 @@
 static int __pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
+	u16 tmp_nodenum;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	if ( !boot && pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	tmp_nodenum = *nodenum;
 	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0,
-			       nodenum, sizeof(char), data, 65536);
+			       &tmp_nodenum, sizeof(tmp_nodenum), data, 65536);
+	*nodenum = tmp_nodenum;
 	return status;
 }
 
