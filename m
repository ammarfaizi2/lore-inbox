Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWE1WR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWE1WR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 18:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWE1WR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 18:17:58 -0400
Received: from mx1.suse.de ([195.135.220.2]:10933 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751004AbWE1WR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 18:17:58 -0400
Date: Mon, 29 May 2006 00:17:56 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
Subject: [PATCH] [3/7] i386: apic= command line option should always be
Message-ID: <447A2194.mailYI1VMCPV@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Jan Beulich" <jbeulich@novell.com>

When using apic= on the kernel command line, this had no effect for machines
matched by either the ACPI MADT or the MPS OEM table scan. However, when such
option is specified, it should also take effect for this set of systems.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/mach-generic/probe.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6.17-rc5/arch/i386/mach-generic/probe.c
===================================================================
--- linux-2.6.17-rc5.orig/arch/i386/mach-generic/probe.c
+++ linux-2.6.17-rc5/arch/i386/mach-generic/probe.c
@@ -93,9 +93,11 @@ int __init mps_oem_check(struct mp_confi
 	int i;
 	for (i = 0; apic_probe[i]; ++i) { 
 		if (apic_probe[i]->mps_oem_check(mpc,oem,productid)) { 
-			genapic = apic_probe[i];
-			printk(KERN_INFO "Switched to APIC driver `%s'.\n", 
-			       genapic->name);
+			if (!cmdline_apic) {
+				genapic = apic_probe[i];
+				printk(KERN_INFO "Switched to APIC driver `%s'.\n",
+				       genapic->name);
+			}
 			return 1;
 		} 
 	} 
@@ -107,9 +109,11 @@ int __init acpi_madt_oem_check(char *oem
 	int i;
 	for (i = 0; apic_probe[i]; ++i) { 
 		if (apic_probe[i]->acpi_madt_oem_check(oem_id, oem_table_id)) { 
-			genapic = apic_probe[i];
-			printk(KERN_INFO "Switched to APIC driver `%s'.\n", 
-			       genapic->name);
+			if (!cmdline_apic) {
+				genapic = apic_probe[i];
+				printk(KERN_INFO "Switched to APIC driver `%s'.\n",
+				       genapic->name);
+			}
 			return 1;
 		} 
 	} 
