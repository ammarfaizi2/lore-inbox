Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbUDTGHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUDTGHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 02:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUDTGHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 02:07:14 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:17631 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262133AbUDTGG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 02:06:57 -0400
Date: Tue, 20 Apr 2004 15:07:33 +0900
From: Fumihiro Tersawa <terasawa@pst.fujitsu.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
Subject: [patch 2/2] memory hotplug prototype for ia64
Message-Id: <20040420150539.0FC0.TERASAWA@pst.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to emulate NUMA node to test the memory hotplug on
ia64 non NUMA machines.
As an example, it use the Dummy SRAT table(dummysrat.h) to emulate 
2 Nodes for 1 Node machine of the following compositions:
- 2CPUs
- 8GB memory

It is necessary to correct Dummy SRAT table according to your 
machine's compositions(CPU number, Memory size).

NOTICE:
- APIC ID(in Processor Local APIC/SAPIC Affinity Structure)
  It is necessary to make to match with lsapic_id of ACPI.

- Memory range(in Memory Affinity Structure)
  It is necessary to establish to contain all the physical addresses 
  of EFI memory map. 




diff -duprN linux-2.6.5/drivers/acpi/dummysrat.h linux-2.6.5-dummysrat/drivers/acpi/dummysrat.h
--- linux-2.6.5/drivers/acpi/dummysrat.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.5-dummysrat/drivers/acpi/dummysrat.h	2004-04-20 12:00:55.647851364 +0900
@@ -0,0 +1,39 @@
+/*
+ * Dummy SRAT table
+ *
+ * Copyright (C) 2004 Fumitake Abe <fabe@us.fujitsu.com>
+ *
+ */
+unsigned char SratTable[] =
+{
+	0x53,0x52,0x41,0x54,0xf0,0x00,0x00,0x00,  /* 00000000  "SRAT...." */
+	0x01,0x00,0x4f,0x45,0x4d,0x49,0x44,0x00,  /* 00000008  "..OEMID." */
+	0x4f,0x45,0x4d,0x54,0x42,0x4c,0x00,0x00,  /* 00000010  "OEMTBL.." */
+	0x00,0x00,0x00,0x00,0x61,0x73,0x6c,0x00,  /* 00000018  "....asl." */
+	0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000020  "........" */
+	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000028  "........" */
+	0x00,0x10,0x00,0xc2,0x01,0x00,0x00,0x00,  /* 00000030  "........" */
+	0x18,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000038  "........" */
+	0x00,0x10,0x01,0xc0,0x01,0x00,0x00,0x00,  /* 00000040  "........" */
+	0x18,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000048  "........" */
+	0x01,0x28,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000050  ".(......" */
+	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000058  "........" */
+	0x00,0x00,0x00,0x80,0x00,0x00,0x00,0x00,  /* 00000060  "........" */
+	0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x00,  /* 00000068  "........" */
+	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000070  "........" */
+	0x01,0x28,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000078  ".(......" */
+	0x00,0x00,0x00,0x80,0x00,0x00,0x00,0x00,  /* 00000080  "........" */
+	0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,  /* 00000088  "........" */
+	0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x00,  /* 00000090  "........" */
+	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000098  "........" */
+	0x01,0x28,0x01,0x00,0x00,0x00,0x00,0x00,  /* 000000a0  ".(......" */
+	0x00,0x00,0x00,0x80,0x01,0x00,0x00,0x00,  /* 000000a8  "........" */
+	0x00,0x00,0x00,0x80,0x00,0x00,0x00,0x00,  /* 000000b0  "........" */
+	0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x00,  /* 000000b8  "........" */
+	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000000c0  "........" */
+	0x01,0x28,0x01,0x00,0x00,0x00,0x00,0x00,  /* 000000c8  ".(......" */
+	0x00,0x00,0x00,0x00,0x02,0x00,0x00,0x00,  /* 000000d0  "........" */
+	0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,  /* 000000d8  "........" */
+	0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x00,  /* 000000e0  "........" */
+	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000000e8  "........" */
+};
diff -duprN linux-2.6.5/drivers/acpi/numa.c linux-2.6.5-dummysrat/drivers/acpi/numa.c
--- linux-2.6.5/drivers/acpi/numa.c	2004-04-04 12:37:40.000000000 +0900
+++ linux-2.6.5-dummysrat/drivers/acpi/numa.c	2004-04-20 11:57:59.491603522 +0900
@@ -48,6 +48,7 @@ acpi_table_print_srat_entry (
 	if (!header)
 		return;
 
+#ifndef CONFIG_MEMHOTPLUG
 	switch (header->type) {
 
 	case ACPI_SRAT_PROCESSOR_AFFINITY:
@@ -77,6 +78,7 @@ acpi_table_print_srat_entry (
 			header->type);
 		break;
 	}
+#endif
 }
 
 
diff -duprN linux-2.6.5/drivers/acpi/tables.c linux-2.6.5-dummysrat/drivers/acpi/tables.c
--- linux-2.6.5/drivers/acpi/tables.c	2004-04-04 12:36:56.000000000 +0900
+++ linux-2.6.5-dummysrat/drivers/acpi/tables.c	2004-04-20 11:57:59.492580085 +0900
@@ -34,6 +34,9 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
+#ifdef CONFIG_MEMHOTPLUG
+#include "dummysrat.h"
+#endif
 
 #define PREFIX			"ACPI: "
 
@@ -315,6 +318,14 @@ acpi_table_parse_madt_family (
 	if (!handler)
 		return -EINVAL;
 
+#ifdef CONFIG_MEMHOTPLUG
+	if (id == ACPI_SRAT) {
+		madt = (void *)SratTable;
+		madt_end = (unsigned long)madt + sizeof(SratTable);
+		goto do_parse;
+	}
+#endif
+
 	/* Locate the MADT (if exists). There should only be one. */
 
 	for (i = 0; i < sdt_count; i++) {
@@ -338,6 +349,9 @@ acpi_table_parse_madt_family (
 
 	madt_end = (unsigned long) madt + sdt_entry[i].size;
 
+#ifdef CONFIG_MEMHOTPLUG
+do_parse:
+#endif
 	/* Parse all entries looking for a match. */
 
 	entry = (acpi_table_entry_header *)
@@ -383,6 +397,13 @@ acpi_table_parse (
 	if (!handler)
 		return -EINVAL;
 
+#ifdef CONFIG_MEMHOTPLUG
+	if (id == ACPI_SRAT) {
+		handler(ia64_tpa((unsigned long)SratTable), sizeof(SratTable));
+		return 1;
+	}
+#endif
+
 	for (i = 0; i < sdt_count; i++) {
 		if (sdt_entry[i].id != id)
 			continue;

