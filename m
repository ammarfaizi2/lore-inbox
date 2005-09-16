Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbVIPGuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbVIPGuK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 02:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbVIPGuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 02:50:09 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:39572 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1161062AbVIPGuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 02:50:09 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20050916064919.18414.70560.sendpatchset@cherry.local>
Subject: [PATCH] i386: CONFIG_ACPI_SRAT on non-acpi hw
Date: Fri, 16 Sep 2005 15:50:08 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.6.14-rc1 adds code to check the return value of 
acpi_find_root_pointer(). Without this patch systems without ACPI support
such as QEMU crashes when booting a NUMA kernel with CONFIG_ACPI_SRAT=y.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
----

--- from-0002/arch/i386/kernel/srat.c
+++ to-0003/arch/i386/kernel/srat.c	2005-09-16 15:22:48.000000000 +0900
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
