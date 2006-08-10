Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWHJUOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWHJUOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWHJTgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:12688 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932329AbWHJTfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:32 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [18/145] x86_64: x86 nmi fix 2
Message-Id: <20060810193531.090D013B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:30 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Don Zickus <dzickus@redhat.com>

Makes the start/stop paths of nmi watchdog more robust to handle the
suspend/resume cases more gracefully.

Signed-off-by: Don Zickus <dzickus@redhat.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Shaohua Li <shaohua.li@intel.com>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/nmi.c   |   19 +++++++++++++++++--
 arch/x86_64/kernel/nmi.c |   19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 4 deletions(-)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -630,11 +630,21 @@ static void stop_p4_watchdog(void)
 
 void setup_apic_nmi_watchdog (void *unused)
 {
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
 	    (nmi_watchdog != NMI_IO_APIC))
 	    	return;
 
+	if (wd->enabled == 1)
+		return;
+
+	/* cheap hack to support suspend/resume */
+	/* if cpu0 is not active neither should the other cpus */
+	if ((smp_processor_id() != 0) && (atomic_read(&nmi_active) <= 0))
+		return;
+
 	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
@@ -667,17 +677,22 @@ void setup_apic_nmi_watchdog (void *unus
 			return;
 		}
 	}
-	__get_cpu_var(nmi_watchdog_ctlblk.enabled) = 1;
+	wd->enabled = 1;
 	atomic_inc(&nmi_active);
 }
 
 void stop_apic_nmi_watchdog(void *unused)
 {
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
 	    (nmi_watchdog != NMI_IO_APIC))
 	    	return;
 
+	if (wd->enabled == 0)
+		return;
+
 	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
@@ -701,7 +716,7 @@ void stop_apic_nmi_watchdog(void *unused
 			return;
 		}
 	}
-	__get_cpu_var(nmi_watchdog_ctlblk.enabled) = 0;
+	wd->enabled = 0;
 	atomic_dec(&nmi_active);
 }
 
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -565,11 +565,21 @@ static void stop_p4_watchdog(void)
 
 void setup_apic_nmi_watchdog(void *unused)
 {
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
 	    (nmi_watchdog != NMI_IO_APIC))
 	    	return;
 
+	if (wd->enabled == 1)
+		return;
+
+	/* cheap hack to support suspend/resume */
+	/* if cpu0 is not active neither should the other cpus */
+	if ((smp_processor_id() != 0) && (atomic_read(&nmi_active) <= 0))
+		return;
+
 	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
@@ -586,17 +596,22 @@ void setup_apic_nmi_watchdog(void *unuse
 			return;
 		}
 	}
-	__get_cpu_var(nmi_watchdog_ctlblk.enabled) = 1;
+	wd->enabled = 1;
 	atomic_inc(&nmi_active);
 }
 
 void stop_apic_nmi_watchdog(void *unused)
 {
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
 	    (nmi_watchdog != NMI_IO_APIC))
 	    	return;
 
+	if (wd->enabled == 0)
+		return;
+
 	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
@@ -611,7 +626,7 @@ void stop_apic_nmi_watchdog(void *unused
 			return;
 		}
 	}
-	__get_cpu_var(nmi_watchdog_ctlblk.enabled) = 0;
+	wd->enabled = 0;
 	atomic_dec(&nmi_active);
 }
 
