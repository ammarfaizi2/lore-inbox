Return-Path: <linux-kernel-owner+w=401wt.eu-S932485AbWLLWfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWLLWfL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWLLWev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:34:51 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:1614 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507AbWLLWeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:34:37 -0500
Date: Tue, 12 Dec 2006 14:34:35 -0800
Message-Id: <200612122234.kBCMYZuU023327@zach-dev.vmware.com>
Subject: [PATCH 3/5] Paravirt smp.patch
From: Zachary Amsden <zach@vmware.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 12 Dec 2006 22:34:36.0199 (UTC) FILETIME=[B3D0C370:01C71E3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add VMI SMP boot hooks.  This is a bit unclean (the #ifdef's), but I
wanted a quick and dirty hack to get SMP up and working.

Signed-off-by: Zachary Amsden <zach@vmware.com>


===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -698,5 +698,7 @@ struct paravirt_ops paravirt_ops = {
 
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
+
+	.startup_ipi_hook = (void *)native_nop,
 };
 EXPORT_SYMBOL(paravirt_ops);
===================================================================
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -820,6 +823,11 @@ wakeup_secondary_cpu(int phys_apicid, un
 		num_starts = 2;
 	else
 		num_starts = 0;
+
+#ifdef CONFIG_PARAVIRT
+	paravirt_ops.startup_ipi_hook(phys_apicid, (unsigned long) start_secondary,
+		                 (unsigned long) stack_start.esp);
+#endif
 
 	/*
 	 * Run STARTUP IPI loop.
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -148,6 +148,8 @@ struct paravirt_ops
 	/* These two are jmp to, not actually called. */
 	void (fastcall *irq_enable_sysexit)(void);
 	void (fastcall *iret)(void);
+
+	void (fastcall *startup_ipi_hook)(int phys_apicid, unsigned long start_eip, unsigned long start_esp);
 };
 
 /* Mark a paravirt probe function. */

