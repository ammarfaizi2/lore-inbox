Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946764AbWKAKbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946764AbWKAKbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946766AbWKAKbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:31:36 -0500
Received: from ozlabs.org ([203.10.76.45]:60098 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946764AbWKAKbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:31:35 -0500
Subject: [PATCH 5/7] paravirtualization: Allow disabling legacy power
	management modes with paravirt kernels
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162377043.23462.12.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
	 <1162376894.23462.7.camel@localhost.localdomain>
	 <1162376981.23462.10.camel@localhost.localdomain>
	 <1162377043.23462.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 21:31:33 +1100
Message-Id: <1162377093.23462.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
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

===================================================================
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
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
===================================================================
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
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


