Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVEQRB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVEQRB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVEQRB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:01:26 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:22006 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261866AbVEQQ74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:59:56 -0400
Date: Tue, 17 May 2005 11:59:33 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Fix some minor issues related to FSL Book-E KGDB
 support
Message-ID: <Pine.LNX.4.61.0505171158460.26903@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some debug registers needed to be initialized early on to allow
proper support for KGDB.  Additionally, we need to setup the
ppc.md_early_serial_map function pointer on boards that have
serial support for KGDB.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 704da4a5c793087584fa5d0ed73440dd4ac44294
tree 1702b9dd418707a930969079b460df0ace2f1c1a
parent f772a90e948f019c3111a94394b3a649874417c7
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 16 May 2005 11:12:35 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 16 May 2005 11:12:35 -0500

 ppc/kernel/head_fsl_booke.S             |   15 ++++++++++++++-
 ppc/platforms/85xx/mpc8540_ads.c        |    3 +++
 ppc/platforms/85xx/mpc85xx_cds_common.c |    3 +++
 ppc/platforms/85xx/sbc8560.c            |    3 +++
 4 files changed, 23 insertions(+), 1 deletion(-)

Index: arch/ppc/kernel/head_fsl_booke.S
===================================================================
--- c9d59c269792db4933039da49b3b3836ac5b01f5/arch/ppc/kernel/head_fsl_booke.S  (mode:100644)
+++ 1702b9dd418707a930969079b460df0ace2f1c1a/arch/ppc/kernel/head_fsl_booke.S  (mode:100644)
@@ -232,7 +232,8 @@
 	tlbwe
 
 /* 7. Jump to KERNELBASE mapping */
-	li	r7,0
+	lis	r7,MSR_KERNEL@h
+	ori	r7,r7,MSR_KERNEL@l
 	bl	1f			/* Find our address */
 1:	mflr	r9
 	rlwimi	r6,r9,0,20,31
@@ -291,6 +292,18 @@
 	mfspr	r2,SPRN_HID0
 	oris	r2,r2,HID0_DOZE@h
 	mtspr	SPRN_HID0, r2
+#endif
+
+#if !defined(CONFIG_BDI_SWITCH)
+	/*
+	 * The Abatron BDI JTAG debugger does not tolerate others
+	 * mucking with the debug registers.
+	 */
+	lis	r2,DBCR0_IDM@h
+	mtspr	SPRN_DBCR0,r2
+	/* clear any residual debug events */
+	li	r2,-1
+	mtspr	SPRN_DBSR,r2
 #endif
 
 	/*
Index: arch/ppc/platforms/85xx/mpc8540_ads.c
===================================================================
--- c9d59c269792db4933039da49b3b3836ac5b01f5/arch/ppc/platforms/85xx/mpc8540_ads.c  (mode:100644)
+++ 1702b9dd418707a930969079b460df0ace2f1c1a/arch/ppc/platforms/85xx/mpc8540_ads.c  (mode:100644)
@@ -210,6 +210,9 @@
 #if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
 	ppc_md.progress = gen550_progress;
 #endif	/* CONFIG_SERIAL_8250 && CONFIG_SERIAL_TEXT_DEBUG */
+#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_KGDB)
+	ppc_md.early_serial_map = mpc85xx_early_serial_map;
+#endif	/* CONFIG_SERIAL_8250 && CONFIG_KGDB */
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8540ads_init(): exit", 0);
Index: arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- c9d59c269792db4933039da49b3b3836ac5b01f5/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
+++ 1702b9dd418707a930969079b460df0ace2f1c1a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
@@ -459,6 +459,9 @@
 #if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
 	ppc_md.progress = gen550_progress;
 #endif /* CONFIG_SERIAL_8250 && CONFIG_SERIAL_TEXT_DEBUG */
+#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_KGDB)
+	ppc_md.early_serial_map = mpc85xx_early_serial_map;
+#endif	/* CONFIG_SERIAL_8250 && CONFIG_KGDB */
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_cds_init(): exit", 0);
Index: arch/ppc/platforms/85xx/sbc8560.c
===================================================================
--- c9d59c269792db4933039da49b3b3836ac5b01f5/arch/ppc/platforms/85xx/sbc8560.c  (mode:100644)
+++ 1702b9dd418707a930969079b460df0ace2f1c1a/arch/ppc/platforms/85xx/sbc8560.c  (mode:100644)
@@ -221,6 +221,9 @@
 #if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
 	ppc_md.progress = gen550_progress;
 #endif	/* CONFIG_SERIAL_8250 && CONFIG_SERIAL_TEXT_DEBUG */
+#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_KGDB)
+	ppc_md.early_serial_map = sbc8560_early_serial_map;
+#endif	/* CONFIG_SERIAL_8250 && CONFIG_KGDB */
 
 	if (ppc_md.progress)
 		ppc_md.progress("sbc8560_init(): exit", 0);
