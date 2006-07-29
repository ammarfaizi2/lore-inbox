Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWG2Tni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWG2Tni (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbWG2TnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:43:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:57820 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752074AbWG2Tmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:42:39 -0400
Date: Sat, 29 Jul 2006 21:42:37 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.18] [2/8] x86_64: On Intel systems when CPU has C3 don't use TSC
Message-ID: <44cbba2d.ejpOKfo7QfGElmoT%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Intel systems generally the TSC stops in C3 or deeper, 
so don't use it there. Follows similar logic on i386.

This should fix problems on Meroms.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/time.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

Index: linux-2.6.18-rc2-git7/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.18-rc2-git7.orig/arch/x86_64/kernel/time.c
+++ linux-2.6.18-rc2-git7/arch/x86_64/kernel/time.c
@@ -28,6 +28,7 @@
 #include <linux/acpi.h>
 #ifdef CONFIG_ACPI
 #include <acpi/achware.h>	/* for PM timer frequency */
+#include <acpi/acpi_bus.h>
 #endif
 #include <asm/8253pit.h>
 #include <asm/pgtable.h>
@@ -953,11 +954,18 @@ __cpuinit int unsynchronized_tsc(void)
 #ifdef CONFIG_SMP
 	if (apic_is_clustered_box())
 		return 1;
- 	/* Intel systems are normally all synchronized. Exceptions
- 	   are handled in the check above. */
- 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
- 		return 0;
 #endif
+	/* Most intel systems have synchronized TSCs except for
+	   multi node systems */
+ 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+#ifdef CONFIG_ACPI
+		/* But TSC doesn't tick in C3 so don't use it there */
+		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 100)
+			return 1;
+#endif
+ 		return 0;
+	}
+
  	/* Assume multi socket systems are not synchronized */
  	return num_present_cpus() > 1;
 }
