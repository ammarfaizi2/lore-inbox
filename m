Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWJ2Cqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWJ2Cqw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 22:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWJ2Cq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 22:46:27 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:4777 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964958AbWJ2CqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 22:46:23 -0400
Message-Id: <20061029024606.930028000@sous-sol.org>
References: <20061029024504.760769000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Sat, 28 Oct 2006 00:00:05 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org, ak@muc.de
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Subject: [PATCH 5/7] Allow disabling legacy power management modes with paravirt kernels
Content-Disposition: inline; filename=016-power-management-bypass.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two legacy power management modes are much easier to just explicitly disable
when running in paravirtualized mode - neither APM nor PnP is still relevant.
The status of ACPI is still debatable, and noacpi is still a common enough
boot parameter that it is not necessary to explicitly disable ACPI.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>

---
 arch/i386/kernel/apm.c     |    3 ++-
 drivers/pnp/pnpbios/core.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6-pv.orig/arch/i386/kernel/apm.c
+++ linux-2.6-pv/arch/i386/kernel/apm.c
@@ -231,6 +231,7 @@
 #include <asm/uaccess.h>
 #include <asm/desc.h>
 #include <asm/i8253.h>
+#include <asm/paravirt.h>
 
 #include "io_ports.h"
 
@@ -2191,7 +2192,7 @@ static int __init apm_init(void)
 
 	dmi_check_system(apm_dmi_table);
 
-	if (apm_info.bios.version == 0) {
+	if (apm_info.bios.version == 0 || paravirt_enabled()) {
 		printk(KERN_INFO "apm: BIOS not found.\n");
 		return -ENODEV;
 	}
--- linux-2.6-pv.orig/drivers/pnp/pnpbios/core.c
+++ linux-2.6-pv/drivers/pnp/pnpbios/core.c
@@ -530,7 +530,8 @@ static int __init pnpbios_init(void)
 	if (check_legacy_ioport(PNPBIOS_BASE))
 		return -ENODEV;
 #endif
-	if (pnpbios_disabled || dmi_check_system(pnpbios_dmi_table)) {
+	if (pnpbios_disabled || dmi_check_system(pnpbios_dmi_table) ||
+	    paravirt_enabled()) {
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
 	}

--
