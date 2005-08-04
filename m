Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVHDBvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVHDBvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 21:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVHDBv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 21:51:27 -0400
Received: from lixom.net ([66.141.50.11]:3487 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S261690AbVHDBvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 21:51:25 -0400
Date: Wed, 3 Aug 2005 20:30:10 -0500
To: linux-kernel@vger.kernel.org
Cc: linuxppc64-dev@ozlabs.org, akpm@osdl.org, paulus@samba.org,
       anton@samba.org, miltonm@bga.com
Subject: [PATCH] PPC64: Fix UP kernel build
Message-ID: <20050804013010.GA10556@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

CONFIG_KEXEC breaks UP builds because of a misspelled smp_release_cpus().
Also, the function isn't defined unless built with CONFIG_SMP but it is
needed if we are to go from a UP to SMP kernel. Enable it and document it.

Thanks to Steven Winiecki for reporting this and to Milton for remembering
how it's supposed to work and why.

-Olof

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/arch/ppc64/kernel/machine_kexec.c
===================================================================
--- 2.6.orig/arch/ppc64/kernel/machine_kexec.c	2005-08-03 19:53:16.000000000 -0500
+++ 2.6/arch/ppc64/kernel/machine_kexec.c	2005-08-03 20:39:49.000000000 -0500
@@ -243,13 +243,17 @@ static void kexec_prepare_cpus(void)
 
 static void kexec_prepare_cpus(void)
 {
+	extern void smp_release_cpus(void);
 	/*
 	 * move the secondarys to us so that we can copy
 	 * the new kernel 0-0x100 safely
 	 *
 	 * do this if kexec in setup.c ?
+	 *
+	 * We need to release the cpus if we are ever going from an
+	 * UP to an SMP kernel.
 	 */
-	smp_relase_cpus();
+	smp_release_cpus();
 	if (ppc_md.cpu_irq_down)
 		ppc_md.cpu_irq_down();
 	local_irq_disable();
Index: 2.6/arch/ppc64/kernel/head.S
===================================================================
--- 2.6.orig/arch/ppc64/kernel/head.S	2005-08-03 19:53:16.000000000 -0500
+++ 2.6/arch/ppc64/kernel/head.S	2005-08-03 20:37:22.000000000 -0500
@@ -2071,7 +2071,7 @@ _GLOBAL(hmt_start_secondary)
 	blr
 #endif
 
-#if defined(CONFIG_SMP) && !defined(CONFIG_PPC_ISERIES)
+#if defined(CONFIG_KEXEC) || (defined(CONFIG_SMP) && !defined(CONFIG_PPC_ISERIES))
 _GLOBAL(smp_release_cpus)
 	/* All secondary cpus are spinning on a common
 	 * spinloop, release them all now so they can start
