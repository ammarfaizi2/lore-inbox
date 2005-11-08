Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVKHETB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVKHETB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVKHETB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:19:01 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:6162 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750809AbVKHETA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:19:00 -0500
Date: Mon, 7 Nov 2005 20:18:59 -0800
Message-Id: <200511080418.jA84Ix8G009840@zach-dev.vmware.com>
Subject: [PATCH 1/21] i386 Pnp segments in segment h
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
X-OriginalArrivalTime: 08 Nov 2005 04:18:59.0309 (UTC) FILETIME=[8AC121D0:01C5E41B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move PnP BIOS segment definitions into segment.h; the segments are reserved
here, so they might as well be defined here as well.

Note I didn't do this for APM BIOS, as Macintosh and other systems use those
values to emulate APM in some scary way I don't want to understand.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/include/asm-i386/segment.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/segment.h	2005-11-04 12:13:31.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/segment.h	2005-11-05 00:28:13.000000000 -0800
@@ -91,6 +91,20 @@
 #define GDT_ENTRY_BOOT_DS		(GDT_ENTRY_BOOT_CS + 1)
 #define __BOOT_DS	(GDT_ENTRY_BOOT_DS * 8)
 
+/* The PnP BIOS entries in the GDT */
+#define GDT_ENTRY_PNPBIOS_CS32		(GDT_ENTRY_PNPBIOS_BASE + 0)
+#define GDT_ENTRY_PNPBIOS_CS16		(GDT_ENTRY_PNPBIOS_BASE + 1)
+#define GDT_ENTRY_PNPBIOS_DS		(GDT_ENTRY_PNPBIOS_BASE + 2)
+#define GDT_ENTRY_PNPBIOS_TS1		(GDT_ENTRY_PNPBIOS_BASE + 3)
+#define GDT_ENTRY_PNPBIOS_TS2		(GDT_ENTRY_PNPBIOS_BASE + 4)
+
+/* The PnP BIOS selectors */
+#define PNP_CS32   (GDT_ENTRY_PNPBIOS_CS32 * 8)	/* segment for calling fn */
+#define PNP_CS16   (GDT_ENTRY_PNPBIOS_CS16 * 8)	/* code segment for BIOS */
+#define PNP_DS     (GDT_ENTRY_PNPBIOS_DS * 8)	/* data segment for BIOS */
+#define PNP_TS1    (GDT_ENTRY_PNPBIOS_TS1 * 8)	/* transfer data segment */
+#define PNP_TS2    (GDT_ENTRY_PNPBIOS_TS2 * 8)	/* another data segment */
+
 /*
  * The interrupt descriptor table has room for 256 idt's,
  * the global descriptor table is dependent on the number
Index: linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-zach-work.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-04 12:13:31.000000000 -0800
+++ linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c	2005-11-05 00:28:13.000000000 -0800
@@ -31,15 +31,6 @@ static struct {
 } pnp_bios_callpoint;
 
 
-/* The PnP BIOS entries in the GDT */
-#define PNP_GDT    (GDT_ENTRY_PNPBIOS_BASE * 8)
-
-#define PNP_CS32   (PNP_GDT+0x00)	/* segment for calling fn */
-#define PNP_CS16   (PNP_GDT+0x08)	/* code segment for BIOS */
-#define PNP_DS     (PNP_GDT+0x10)	/* data segment for BIOS */
-#define PNP_TS1    (PNP_GDT+0x18)	/* transfer data segment */
-#define PNP_TS2    (PNP_GDT+0x20)	/* another data segment */
-
 /*
  * These are some opcodes for a "static asmlinkage"
  * As this code is *not* executed inside the linux kernel segment, but in a
