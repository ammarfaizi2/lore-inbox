Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVKABwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVKABwV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 20:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVKABwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 20:52:21 -0500
Received: from fmr20.intel.com ([134.134.136.19]:24963 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S964944AbVKABwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 20:52:20 -0500
Subject: [PATCH] workaround for pnp device interrupt
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Krzysztof Oledzki <olel@ans.pl>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 10:03:12 +0800
Message-Id: <1130810592.3837.6.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Workaround for Krzysztof's system, which makes RTC interrupt level
triggered. Andrew, please give it a try in -mm tree, let's see if it
breaks other systems.

http://bugzilla.kernel.org/show_bug.cgi?id=5243

Thanks,
Shaohua

--- a/drivers/pnp/pnpacpi/rsparser.c	2005-10-10 09:25:31.000000000 +0800
+++ b/drivers/pnp/pnpacpi/rsparser.c	2005-10-10 09:22:13.000000000 +0800
@@ -89,6 +89,12 @@ pnpacpi_parse_allocated_irqresource(stru
 		return;
 
 	res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+#ifdef CONFIG_X86
+	if (gsi < 16 && edge_level != ACPI_EDGE_SENSITIVE) {
+		pnp_err("Legacy PNP IRQ %d should be edge trigger", gsi);
+		edge_level = ACPI_EDGE_SENSITIVE;
+	}
+#endif
 	irq = acpi_register_gsi(gsi, edge_level, active_high_low);
 	if (irq < 0) {
 		res->irq_resource[i].flags |= IORESOURCE_DISABLED;


