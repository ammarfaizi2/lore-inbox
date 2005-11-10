Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVKJApm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVKJApm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVKJApm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:45:42 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:12548 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751137AbVKJApl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:45:41 -0500
Date: Wed, 9 Nov 2005 16:45:40 -0800
Message-Id: <200511100045.jAA0je3B028402@zach-dev.vmware.com>
Subject: [PATCH 9/10] Apm is on cpu zero only
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 10 Nov 2005 00:45:40.0778 (UTC) FILETIME=[130FC8A0:01C5E590]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

APM BIOS code has a protective wrapper that runs it only on CPU zero.  Thus,
no need to set APM BIOS segments in the GDT for other CPUs.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/apm.c	2005-11-09 06:37:47.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/apm.c	2005-11-09 06:38:29.000000000 -0800
@@ -2203,8 +2203,8 @@
 static int __init apm_init(void)
 {
 	struct proc_dir_entry *apm_proc;
+	struct desc_struct *gdt;
 	int ret;
-	int i;
 
 	dmi_check_system(apm_dmi_table);
 
@@ -2295,18 +2295,17 @@
 	 * not restrict themselves to their claimed limit.  When this happens,
 	 * they will cause a segmentation violation in the kernel at boot time.
 	 * Most BIOS's, however, will respect a 64k limit, so we use that.
-  	 */
-	for (i = 0; i < NR_CPUS; i++) {
-		struct desc_struct *gdt = get_cpu_gdt_table(i);
- 		if (!gdt)
- 			continue;
-		set_base(&gdt[APM_CS >> 3],
-			 __va((unsigned long)apm_info.bios.cseg << 4));
-		set_base(&gdt[APM_CS_16 >> 3],
-			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
-		set_base(&gdt[APM_DS >> 3],
-			 __va((unsigned long)apm_info.bios.dseg << 4));
-	}
+	 * 
+	 * Note we only set APM segments on CPU zero, since we pin the APM
+	 * code to that CPU.
+	 */
+	gdt = get_cpu_gdt_table(0);
+	set_base(&gdt[APM_CS >> 3],
+		 __va((unsigned long)apm_info.bios.cseg << 4));
+	set_base(&gdt[APM_CS_16 >> 3],
+		 __va((unsigned long)apm_info.bios.cseg_16 << 4));
+	set_base(&gdt[APM_DS >> 3],
+		 __va((unsigned long)apm_info.bios.dseg << 4));
   
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
 	if (apm_proc)
