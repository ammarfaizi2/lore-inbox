Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbVKHEUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbVKHEUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVKHEUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:20:12 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:10258 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750877AbVKHEUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:20:10 -0500
Date: Mon, 7 Nov 2005 20:20:08 -0800
Message-Id: <200511080420.jA84K8Zt009846@zach-dev.vmware.com>
Subject: [PATCH 2/21] i386 Always relax segments
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
X-OriginalArrivalTime: 08 Nov 2005 04:20:08.0386 (UTC) FILETIME=[B3ED7220:01C5E41B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

APM BIOSes have many bugs regarding proper representation of the
appropriate segment limits for calling the BIOS.  By default,
APM_RELAX_SEGMENTS is always turned on to support running the APM
BIOS on these buggy machines.  Keeping 64k limits poses very little
danger to the kernel, because the pages where the APM BIOS is
located will always be in low physical memory BIOS areas, which
should already be marked reserved, and only buggy BIOSes would
possibly overstep the segment bounds with writes to data anyway.

Since forcing stricter limits breaks many machines and is not
default behavior, it seems reasonable to deprecate the older code
which may cause APM BIOS to fault. 

If you really have a badly enough broken APM BIOS that you have to
turn off APM_RELAX_SEGMENTS, seems like the best recourse here would
be to disable the APM BIOS and / or not compile it into your kernel
to begin with, and / or add your system to the known bad list.

The reason I want to deprecate this code is there is underlying
brokenness with the set_limit macros, and getting rid of many of
the call sites rather than rewriting them seems to be the simplest
and most correct course of action.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/apm.c	2005-11-04 15:46:12.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/apm.c	2005-11-05 00:28:14.000000000 -0800
@@ -302,17 +302,6 @@ extern int (*console_blank_hook)(int);
 #include "apm.h"
 
 /*
- * Define to make all _set_limit calls use 64k limits.  The APM 1.1 BIOS is
- * supposed to provide limit information that it recognizes.  Many machines
- * do this correctly, but many others do not restrict themselves to their
- * claimed limit.  When this happens, they will cause a segmentation
- * violation in the kernel at boot time.  Most BIOS's, however, will
- * respect a 64k limit, so we use that.  If you want to be pedantic and
- * hold your BIOS to its claims, then undefine this.
- */
-#define APM_RELAX_SEGMENTS
-
-/*
  * Define to re-initialize the interrupt 0 timer to 100 Hz after a suspend.
  * This patched by Chad Miller <cmiller@surfsouth.com>, original code by
  * David Chen <chen@ctpa04.mit.edu>
@@ -2294,9 +2283,20 @@ static int __init apm_init(void)
 	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
 	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
 
+	/*
+	 * Set up the long jump entry point to the APM BIOS, which is called
+	 * from inline assembly.
+	 */
 	apm_bios_entry.offset = apm_info.bios.offset;
 	apm_bios_entry.segment = APM_CS;
 
+	/*
+	 * The APM 1.1 BIOS is supposed to provide limit information that it
+	 * recognizes.  Many machines do this correctly, but many others do
+	 * not restrict themselves to their claimed limit.  When this happens,
+	 * they will cause a segmentation violation in the kernel at boot time.
+	 * Most BIOS's, however, will respect a 64k limit, so we use that.
+	 */
 	for (i = 0; i < NR_CPUS; i++) {
 		struct desc_struct *gdt = get_cpu_gdt_table(i);
 		set_base(gdt[APM_CS >> 3],
@@ -2305,33 +2305,12 @@ static int __init apm_init(void)
 			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
 		set_base(gdt[APM_DS >> 3],
 			 __va((unsigned long)apm_info.bios.dseg << 4));
-#ifndef APM_RELAX_SEGMENTS
-		if (apm_info.bios.version == 0x100) {
-#endif
-			/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
-			_set_limit((char *)&gdt[APM_CS >> 3], 64 * 1024 - 1);
-			/* For some unknown machine. */
-			_set_limit((char *)&gdt[APM_CS_16 >> 3], 64 * 1024 - 1);
-			/* For the DEC Hinote Ultra CT475 (and others?) */
-			_set_limit((char *)&gdt[APM_DS >> 3], 64 * 1024 - 1);
-#ifndef APM_RELAX_SEGMENTS
-		} else {
-			_set_limit((char *)&gdt[APM_CS >> 3],
-				(apm_info.bios.cseg_len - 1) & 0xffff);
-			_set_limit((char *)&gdt[APM_CS_16 >> 3],
-				(apm_info.bios.cseg_16_len - 1) & 0xffff);
-			_set_limit((char *)&gdt[APM_DS >> 3],
-				(apm_info.bios.dseg_len - 1) & 0xffff);
-		      /* workaround for broken BIOSes */
-	                if (apm_info.bios.cseg_len <= apm_info.bios.offset)
-        	                _set_limit((char *)&gdt[APM_CS >> 3], 64 * 1024 -1);
-                       if (apm_info.bios.dseg_len <= 0x40) { /* 0x40 * 4kB == 64kB */
-                        	/* for the BIOS that assumes granularity = 1 */
-                        	gdt[APM_DS >> 3].b |= 0x800000;
-                        	printk(KERN_NOTICE "apm: we set the granularity of dseg.\n");
-        	        }
-		}
-#endif
+		/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
+		_set_limit((char *)&gdt[APM_CS >> 3], 64 * 1024 - 1);
+		/* For some unknown machine. */
+		_set_limit((char *)&gdt[APM_CS_16 >> 3], 64 * 1024 - 1);
+		/* For the DEC Hinote Ultra CT475 (and others?) */
+		_set_limit((char *)&gdt[APM_DS >> 3], 64 * 1024 - 1);
 	}
 
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
