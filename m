Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270650AbUJUK4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270650AbUJUK4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270664AbUJUKym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:54:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54452 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S270676AbUJUKxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:53:07 -0400
Message-ID: <4177950A.6090404@in.ibm.com>
Date: Thu, 21 Oct 2004 16:22:58 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vara Prasad <varap@us.ibm.com>
Subject: Re: [PATCH][4/4] kexec based dump: Minor cleanups
References: <417792BA.8090205@in.ibm.com> <41779345.8080009@in.ibm.com> <41779431.5090104@in.ibm.com> <417794AC.8060604@in.ibm.com>
In-Reply-To: <417794AC.8060604@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090503060505020803090909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090503060505020803090909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch moves some crashdump related calls out of 
machine_kexec so that we leave the core kexec code untouched.

Regards, Hari

--------------090503060505020803090909
Content-Type: text/plain;
 name="kd-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kd-cleanup.patch"


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.9-rc4-hari/arch/i386/kernel/machine_kexec.c |   10 ----------
 linux-2.6.9-rc4-hari/kernel/crash.c                   |    9 +++++++++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff -puN arch/i386/kernel/machine_kexec.c~kd-cleanup arch/i386/kernel/machine_kexec.c
--- linux-2.6.9-rc4/arch/i386/kernel/machine_kexec.c~kd-cleanup	2004-10-21 15:11:05.000000000 +0530
+++ linux-2.6.9-rc4-hari/arch/i386/kernel/machine_kexec.c	2004-10-21 15:11:05.000000000 +0530
@@ -195,9 +195,6 @@ void machine_kexec(struct kimage *image)
 	unsigned long reboot_code_buffer;
 	relocate_new_kernel_t rnk;
 
-	crash_dump_stop_cpus();
-	crash_dump_save_registers();
-
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 
@@ -208,13 +205,6 @@ void machine_kexec(struct kimage *image)
 	/* Set up an identity mapping for the reboot_code_buffer */
 	identity_map_page(reboot_code_buffer);
 
-	/*
-	 * If we are here to do a crash dump, save the memory from
-	 * 0-640k before we copy over the kexec kernel image.  Otherwise
-	 * our dump will show the wrong kernel entirely.
-	 */
-	crash_relocate_mem();
-
 	/* copy it out */
 	memcpy((void *)reboot_code_buffer, relocate_new_kernel, relocate_new_kernel_size);
 
diff -puN kernel/crash.c~kd-cleanup kernel/crash.c
--- linux-2.6.9-rc4/kernel/crash.c~kd-cleanup	2004-10-21 15:11:05.000000000 +0530
+++ linux-2.6.9-rc4-hari/kernel/crash.c	2004-10-21 15:11:05.000000000 +0530
@@ -71,6 +71,15 @@ void __crash_machine_kexec(void)
 	if (image) {
 		crashed = 1;
 		printk(KERN_EMERG "kexec: opening parachute\n");
+		crash_dump_stop_cpus();
+		crash_dump_save_registers();
+
+         /* If we are here to do a crash dump, save the memory from
+          * 0-640k before we copy over the kexec kernel image.  Otherwise
+          * our dump will show the wrong kernel entirely.
+          */
+        	crash_relocate_mem();
+
 		machine_kexec(image);
 	} else {
 		printk(KERN_EMERG "kexec: No kernel image loaded!\n");
_

--------------090503060505020803090909--
