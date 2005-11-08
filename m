Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVKHEeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVKHEeA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVKHEeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:34:00 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:28179 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030288AbVKHEd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:33:59 -0500
Date: Mon, 7 Nov 2005 20:33:58 -0800
Message-Id: <200511080433.jA84Xwm7009921@zach-dev.vmware.com>
Subject: [PATCH 14/21] i386 Apm is on cpu zero only
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
X-OriginalArrivalTime: 08 Nov 2005 04:33:58.0360 (UTC) FILETIME=[A2A16D80:01C5E41D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

APM BIOS code has a protective wrapper that runs it only on CPU zero.  Thus,
no need to set APM BIOS segments in the GDT for other CPUs.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/apm.c	2005-11-07 10:17:45.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/apm.c	2005-11-07 13:36:05.000000000 -0800
@@ -2170,8 +2170,8 @@ static struct dmi_system_id __initdata a
 static int __init apm_init(void)
 {
 	struct proc_dir_entry *apm_proc;
+	struct desc_struct *gdt;
 	int ret;
-	int i;
 
 	dmi_check_system(apm_dmi_table);
 
@@ -2253,18 +2253,17 @@ static int __init apm_init(void)
 	 * not restrict themselves to their claimed limit.  When this happens,
 	 * they will cause a segmentation violation in the kernel at boot time.
 	 * Most BIOS's, however, will respect a 64k limit, so we use that.
+	 * 
+	 * Note we only set APM segments on CPU zero, since we pin the APM
+	 * code to that CPU.
 	 */
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
+	gdt = get_cpu_gdt_table(0);
+	set_base(&gdt[APM_CS >> 3],
+		 __va((unsigned long)apm_info.bios.cseg << 4));
+	set_base(&gdt[APM_CS_16 >> 3],
+		 __va((unsigned long)apm_info.bios.cseg_16 << 4));
+	set_base(&gdt[APM_DS >> 3],
+		 __va((unsigned long)apm_info.bios.dseg << 4));
 
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
 	if (apm_proc)
