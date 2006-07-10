Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWGJFQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWGJFQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 01:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWGJFQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 01:16:49 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:10399 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751336AbWGJFQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 01:16:48 -0400
Date: Mon, 10 Jul 2006 14:19:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] remove empty node at boot time
Message-Id: <20060710141903.424ba3db.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200607092038.41053.bjorn.helgaas@hp.com>
References: <20060601200436.6bf7c4e5.kamezawa.hiroyu@jp.fujitsu.com>
	<200607071726.31646.bjorn.helgaas@hp.com>
	<20060710093418.be084931.kamezawa.hiroyu@jp.fujitsu.com>
	<200607092038.41053.bjorn.helgaas@hp.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 20:38:40 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> setup_arch
>   acpi_numa_init
>     acpi_numa_arch_fixup
>       acpi_online_node_fixup (test available_cpus)
>   ... 
>   acpi_boot_init
>     acpi_table_parse_madt(..., acpi_parse_lsapic, ...)
>       acpi_parse_lsapic (increment available_cpus)
> 
> Note that we test available_cpus in acpi_online_node_fixup()
> before we increment it in acpi_parse_lsapic(), so the inner
> loop is never executed.
> 

Could you try this patch ? (against 2.6.18-rc1)

I think this is very straightforward fix. booted well with my box and NUMA
emulation environment.

if SRAT had "present" bit, I'm happy ;(

Thanks,
-Kame
 
empty-node-fix-fix.patch

empty-node-fix.patch uses lsapic information to detect cpu. But it has a
problem with cpu-only-node because lsapic information is not parsed before SRAT.

This patch moves parsing lsapic information before SRAT. By this, we can get
information of avilable cpus in early time.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


 arch/ia64/kernel/acpi.c  |   21 +++++++++++++++------
 arch/ia64/kernel/setup.c |    3 +++
 2 files changed, 18 insertions(+), 6 deletions(-)

Index: linux-2.6.18-rc1/arch/ia64/kernel/acpi.c
===================================================================
--- linux-2.6.18-rc1.orig/arch/ia64/kernel/acpi.c	2006-07-10 14:00:16.000000000 +0900
+++ linux-2.6.18-rc1/arch/ia64/kernel/acpi.c	2006-07-10 14:00:38.000000000 +0900
@@ -650,9 +650,12 @@
 	return rsdp_phys;
 }
 
-int __init acpi_boot_init(void)
+static int madt_is_available __initdata;
+/*
+ * check LSAPIC in early phase, to detect available cpus.
+ */
+void __init ia64_acpi_madt_early_init(void)
 {
-
 	/*
 	 * MADT
 	 * ----
@@ -663,9 +666,9 @@
 
 	if (acpi_table_parse(ACPI_APIC, acpi_parse_madt) < 1) {
 		printk(KERN_ERR PREFIX "Can't find MADT\n");
-		goto skip_madt;
+		return;
 	}
-
+	madt_is_available = 1;
 	/* Local APIC */
 
 	if (acpi_table_parse_madt
@@ -682,8 +685,14 @@
 	    < 0)
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 
-	/* I/O APIC */
+	return;
+}
 
+int __init acpi_boot_init(void)
+{
+	if (!madt_is_available)
+		goto skip_madt;
+	/* IO-APIC */
 	if (acpi_table_parse_madt
 	    (ACPI_MADT_IOSAPIC, acpi_parse_iosapic, NR_IOSAPICS) < 1)
 		printk(KERN_ERR PREFIX
@@ -704,8 +713,8 @@
 
 	if (acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src, 0) < 0)
 		printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
-      skip_madt:
 
+skip_madt:
 	/*
 	 * FADT says whether a legacy keyboard controller is present.
 	 * The FADT also contains an SCI_INT line, by which the system
Index: linux-2.6.18-rc1/arch/ia64/kernel/setup.c
===================================================================
--- linux-2.6.18-rc1.orig/arch/ia64/kernel/setup.c	2006-07-10 14:00:16.000000000 +0900
+++ linux-2.6.18-rc1/arch/ia64/kernel/setup.c	2006-07-10 14:00:38.000000000 +0900
@@ -71,6 +71,7 @@
 #endif
 
 extern void ia64_setup_printk_clock(void);
+extern int ia64_acpi_madt_early_init(void);
 
 DEFINE_PER_CPU(struct cpuinfo_ia64, cpu_info);
 DEFINE_PER_CPU(unsigned long, local_per_cpu_offset);
@@ -422,6 +423,8 @@
 #ifdef CONFIG_ACPI
 	/* Initialize the ACPI boot-time table parser */
 	acpi_table_init();
+	/* read ACPI table */
+	ia64_acpi_madt_early_init();
 # ifdef CONFIG_ACPI_NUMA
 	acpi_numa_init();
 # endif

