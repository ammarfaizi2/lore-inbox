Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbVJZIEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVJZIEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 04:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVJZIEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 04:04:25 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:39913 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932584AbVJZIEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 04:04:24 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20051026080446.21674.14309.sendpatchset@cherry.local>
Subject: [PATCH] i386: srat on non-acpi hw fix
Date: Wed, 26 Oct 2005 17:04:23 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a check for the return value of acpi_find_root_pointer().
Without this patch systems without ACPI support such as QEMU crashes when
booting a NUMA kernel with CONFIG_ACPI_SRAT=y.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

diff -urNp linux-2.6.14-rc5-mm1/arch/i386/kernel/srat.c linux-2.6.14-rc5-mm1-i386_srat_non_acpi/arch/i386/kernel/srat.c
--- linux-2.6.14-rc5-mm1/arch/i386/kernel/srat.c	2005-10-24 18:18:12.000000000 +0900
+++ linux-2.6.14-rc5-mm1-i386_srat_non_acpi/arch/i386/kernel/srat.c	2005-10-24 18:24:05.000000000 +0900
@@ -327,7 +327,12 @@ int __init get_memcfg_from_srat(void)
 	int tables = 0;
 	int i = 0;
 
-	acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING, rsdp_address);
+	if (ACPI_FAILURE(acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING, 
+						rsdp_address))) {
+		printk("%s: System description tables not found\n",
+		       __FUNCTION__);
+		goto out_err;
+	}
 
 	if (rsdp_address->pointer_type == ACPI_PHYSICAL_POINTER) {
 		printk("%s: assigning address to rsdp\n", __FUNCTION__);
