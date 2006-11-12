Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932934AbWKLPpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbWKLPpW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 10:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWKLPpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 10:45:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:60960 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S932934AbWKLPpU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 10:45:20 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,414,1157353200"; 
   d="scan'208"; a="162403786:sNHT19730620"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.18.2] EFI: calling efi_get_time during suspend
Date: Sun, 12 Nov 2006 17:45:13 +0200
Message-ID: <C1467C8B168BCF40ACEC2324C1A2B074016C5DE8@hasmsx411.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.18.2] EFI: calling efi_get_time during suspend
thread-index: AccGcYsnix7HFjv0Rk2Ft8CjZAD/cA==
From: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
To: <davej@codemonkey.org.uk>, <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Narayanan, Chandramouli" <chandramouli.narayanan@intel.com>,
       "Jiossy, Rami" <rami.jiossy@intel.com>,
       "Satt, Shai" <shai.satt@intel.com>
X-OriginalArrivalTime: 12 Nov 2006 15:45:15.0237 (UTC) FILETIME=[8BF2E150:01C70671]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>

Function efi_get_time called not only during init kernel phase but also
during suspend (from get_cmos_time). 
When it is called from get_cmos_time the corresponding runtime service
should be called in virtual and not in physical mode.

Signed-off-by: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
---

diff -uprN linux-2.6.18.2.orig/include/linux/efi.h
linux-2.6.18.2/include/linux/efi.h
--- linux-2.6.18.2.orig/include/linux/efi.h	2006-11-12
11:22:28.000000000 +0200
+++ linux-2.6.18.2/include/linux/efi.h	2006-11-12 16:31:23.000000000
+0200
@@ -300,7 +300,7 @@ extern int efi_mem_attribute_range (unsi
 extern int __init efi_uart_console_only (void);
 extern void efi_initialize_iomem_resources(struct resource
*code_resource,
 					struct resource *data_resource);
-extern unsigned long __init efi_get_time(void);
+extern unsigned long efi_get_time(void);
 extern int __init efi_set_rtc_mmss(unsigned long nowtime);
 extern struct efi_memory_map memmap;
 
diff -uprN linux-2.6.18.2.orig/arch/i386/kernel/efi.c
linux-2.6.18.2/arch/i386/kernel/efi.c
--- linux-2.6.18.2.orig/arch/i386/kernel/efi.c	2006-11-12
11:22:22.000000000 +0200
+++ linux-2.6.18.2/arch/i386/kernel/efi.c	2006-11-12
16:31:23.000000000 +0200
@@ -194,17 +194,25 @@ inline int efi_set_rtc_mmss(unsigned lon
 	return 0;
 }
 /*
- * This should only be used during kernel init and before runtime
- * services have been remapped, therefore, we'll need to call in
physical
- * mode.  Note, this call isn't used later, so mark it __init.
+ * This is used during kernel init before runtime
+ * services have been remapped and also during suspend, therefore, 
+ * we'll need to call both in physical and virtual modes. 
  */
-inline unsigned long __init efi_get_time(void)
+inline unsigned long efi_get_time(void)
 {
 	efi_status_t status;
 	efi_time_t eft;
 	efi_time_cap_t cap;
 
-	status = phys_efi_get_time(&eft, &cap);
+	if (efi.get_time) {
+		/* if we are in virtual mode use remapped function */ 
+ 		status = efi.get_time(&eft, &cap);
+        }
+        else {
+	    /* we are in physical mode */
+            status = phys_efi_get_time(&eft, &cap);
+        }
+
 	if (status != EFI_SUCCESS)
 		printk("Oops: efitime: can't read time status:
0x%lx\n",status);
 
