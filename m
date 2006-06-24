Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWFXATb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWFXATb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWFXATb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:19:31 -0400
Received: from mx1.suse.de ([195.135.220.2]:18575 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932287AbWFXATa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:19:30 -0400
Date: Sat, 24 Jun 2006 02:19:28 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [20/82] i386: Panic the system when a NUMA kernel doesn't run on IBM NUMA
Message-ID: <449C8510.mailCWD11E44E@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It has been broken forever anywhere else and is not too useful
anyways so best to disable it.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/Kconfig       |    3 +++
 arch/i386/kernel/srat.c |    8 ++++++++
 2 files changed, 11 insertions(+)

Index: linux/arch/i386/kernel/srat.c
===================================================================
--- linux.orig/arch/i386/kernel/srat.c
+++ linux/arch/i386/kernel/srat.c
@@ -312,6 +312,14 @@ int __init get_memcfg_from_srat(void)
 	int tables = 0;
 	int i = 0;
 
+	extern int use_cyclone;
+	if (use_cyclone == 0) {
+		/* Make sure user sees something */
+		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else.";
+		early_printk(s);
+		panic(s);
+	}
+
 	if (ACPI_FAILURE(acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING,
 						rsdp_address))) {
 		printk("%s: System description tables not found\n",
Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -523,6 +523,9 @@ config NUMA
 	depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI))
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT)
+	help
+		NUMA support. Note this only works on IBM x440 or IBM NUMAQ.
+		Don't try to use it anywhere else.
 
 comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
 	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)
