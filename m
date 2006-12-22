Return-Path: <linux-kernel-owner+w=401wt.eu-S1751633AbWLVRuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWLVRuK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWLVRuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:50:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34823 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751627AbWLVRuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:50:08 -0500
From: John Keller <jpk@sgi.com>
To: linux-acpi@vger.kernel.org
Cc: ayoung@agi.com, jes@sgi.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, John Keller <jpk@sgi.com>
Date: Fri, 22 Dec 2006 11:50:04 -0600
Message-Id: <20061222175004.1603.74655.sendpatchset@attica.americas.sgi.com>
Subject: [PATCH 1/1] - Altix: ACPI _PRT support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide ACPI _PRT support for SN Altix systems.

The SN Altix platform does not conform to the 
IOSAPIC IRQ routing model, so a new acpi_irq_model
(ACPI_IRQ_MODEL_PLATFORM) has been defined. The SN
platform specific code sets acpi_irq_model to
this new value, and keys off of it in acpi_register_gsi()
to avoid the iosapic code path.

Signed-off-by: John Keller <jpk@sgi.com>
---

To avoid future regression/backward compatibilty issues
when _PRT support is added to our PROM, we'd like to
see this pushed into 2.6.20, if at all possible.


 arch/ia64/kernel/acpi.c            |    3 +++
 arch/ia64/sn/kernel/io_acpi_init.c |    3 +++
 drivers/acpi/bus.c                 |    3 +++
 include/linux/acpi.h               |    1 +
 4 files changed, 10 insertions(+)


Index: linux/arch/ia64/kernel/acpi.c
===================================================================
--- linux.orig/arch/ia64/kernel/acpi.c	2006-10-24 02:38:54.000000000 -0500
+++ linux/arch/ia64/kernel/acpi.c	2006-12-22 10:54:36.930343639 -0600
@@ -590,6 +590,9 @@ void __init acpi_numa_arch_fixup(void)
  */
 int acpi_register_gsi(u32 gsi, int triggering, int polarity)
 {
+	if (acpi_irq_model == ACPI_IRQ_MODEL_PLATFORM)
+		return gsi;
+
 	if (has_8259 && gsi < 16)
 		return isa_irq_to_vector(gsi);
 
Index: linux/arch/ia64/sn/kernel/io_acpi_init.c
===================================================================
--- linux.orig/arch/ia64/sn/kernel/io_acpi_init.c	2006-12-21 00:51:59.000000000 -0600
+++ linux/arch/ia64/sn/kernel/io_acpi_init.c	2006-12-22 10:53:45.504213484 -0600
@@ -223,6 +223,9 @@ sn_io_acpi_init(void)
 	u64 result;
 	s64 status;
 
+	/* SN Altix does not follow the IOSAPIC IRQ routing model */
+	acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
+
 	acpi_bus_register_driver(&acpi_sn_hubdev_driver);
 	status = sal_ioif_init(&result);
 	if (status || result)
Index: linux/drivers/acpi/bus.c
===================================================================
--- linux.orig/drivers/acpi/bus.c	2006-08-28 20:40:10.000000000 -0500
+++ linux/drivers/acpi/bus.c	2006-12-22 10:52:32.155474439 -0600
@@ -561,6 +561,9 @@ static int __init acpi_bus_init_irq(void
 	case ACPI_IRQ_MODEL_IOSAPIC:
 		message = "IOSAPIC";
 		break;
+	case ACPI_IRQ_MODEL_PLATFORM:
+		message = "platform specific model";
+		break;
 	default:
 		printk(KERN_WARNING PREFIX "Unknown interrupt routing model\n");
 		return -ENODEV;
Index: linux/include/linux/acpi.h
===================================================================
--- linux.orig/include/linux/acpi.h	2006-10-24 02:38:54.000000000 -0500
+++ linux/include/linux/acpi.h	2006-12-22 10:52:53.337997675 -0600
@@ -47,6 +47,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,
 	ACPI_IRQ_MODEL_IOAPIC,
 	ACPI_IRQ_MODEL_IOSAPIC,
+	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_COUNT
 };
 
