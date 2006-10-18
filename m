Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWJROVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWJROVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWJROVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:21:04 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:24539 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932195AbWJROVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:21:01 -0400
Date: Wed, 18 Oct 2006 23:20:42 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: [PATCH](acpi:memory hotplug) Remove strange add_memory fail message
Cc: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20061018224852.2ADE.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.27 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I wrote a patch to avoid redundant memory hot-add call at boot time.
This was cause of strange fail message of memory hotplug
like "ACPI: add_memory failed".
Memory is recognized by early boot code with EFI/E820.
But, if DSDT describes memory devices for them, then hot-add
code is called for already recognized memory, and it shows fail messages
with -EEXIST.
So, sys admin will misunderstand this message as something wrong by
it.

This patch avoids them by preventing redundant hot-add call until
completion of driver initialization. 

This patch is for 2.6.19-rc2.
I tested this patch on Tiger4 with my hot-add emulation.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

---
 drivers/acpi/acpi_memhotplug.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

---

Index: linux-2.6.18/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/acpi_memhotplug.c	2006-10-18 21:12:33.000000000 +0900
+++ linux-2.6.18/drivers/acpi/acpi_memhotplug.c	2006-10-18 22:50:44.000000000 +0900
@@ -85,6 +85,8 @@
 	struct list_head res_list;
 };
 
+int acpi_hotmem_initialized = 0;
+
 static acpi_status
 acpi_memory_get_resource(struct acpi_resource *resource, void *context)
 {
@@ -438,6 +440,15 @@
 	struct acpi_memory_device *mem_device;
 	int result = 0;
 
+	/*
+	 * Early boot code has recognized memory area by EFI/E820.
+	 * If DSDT shows these memory devices on boot, hotplug is not necessary
+	 * for them. So, it just returns until completion of this driver's
+	 * start up.
+	 */
+	if (!acpi_hotmem_initialized)
+		return 0;
+
 	mem_device = acpi_driver_data(device);
 
 	if (!acpi_memory_check_device(mem_device)) {
@@ -537,6 +548,7 @@
 		return -ENODEV;
 	}
 
+	acpi_hotmem_initialized = 1;
 	return 0;
 }
 


-- 
Yasunori Goto 


