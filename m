Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbVCXGBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbVCXGBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbVCXGAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:00:30 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:43193 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263055AbVCXF6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:58:33 -0500
Message-ID: <4242571A.4020608@in.ibm.com>
Date: Thu, 24 Mar 2005 11:28:50 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 6/7] i386 code for the activemem map
References: <424254E0.6060003@in.ibm.com> <42425582.7040508@in.ibm.com> <424255EA.9010905@in.ibm.com> <42425635.30808@in.ibm.com> <4242567A.5060104@in.ibm.com> <424256BA.2060901@in.ibm.com>
In-Reply-To: <424256BA.2060901@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------070304090703090208050701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070304090703090208050701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards, Hari

--------------070304090703090208050701
Content-Type: text/plain;
 name="activemem-i386.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="activemem-i386.patch"


---

This patch contains the i386 specific code to generate the
/proc/activemem view.
---

Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.12-rc1-hari/arch/i386/kernel/efi.c   |   31 +++++++++++++++
 linux-2.6.12-rc1-hari/arch/i386/kernel/setup.c |   50 +++++++++++++++++++++++++
 linux-2.6.12-rc1-hari/include/linux/efi.h      |    2 +
 linux-2.6.12-rc1-hari/include/linux/ioport.h   |    1 
 4 files changed, 84 insertions(+)

diff -puN arch/i386/kernel/efi.c~activemem-i386 arch/i386/kernel/efi.c
--- linux-2.6.12-rc1/arch/i386/kernel/efi.c~activemem-i386	2005-03-23 17:48:22.000000000 +0530
+++ linux-2.6.12-rc1-hari/arch/i386/kernel/efi.c	2005-03-23 17:48:22.000000000 +0530
@@ -630,6 +630,37 @@ void __init efi_initialize_physmem_resou
 	}
 }
 
+void __init efi_initialize_activemem_resources(struct resource *code_resource,
+					       struct resource *data_resource)
+{
+	struct resource *res, *code_resource_copy, *data_resource_copy;
+	efi_memory_desc_t *md;
+	int i;
+#ifdef CONFIG_KEXEC
+	struct resource *crashk_res_copy;
+
+	crashk_res_copy = alloc_bootmem_low(sizeof(struct resource));
+	memcpy(crashk_res_copy, &crashk_res, sizeof(struct resource));
+#endif
+
+	code_resource_copy = alloc_bootmem_low(2*sizeof(struct resource));
+	data_resource_copy = code_resource_copy + sizeof(struct resource);
+	memcpy(code_resource_copy, code_resource, sizeof(struct resource));
+	memcpy(data_resource_copy, data_resource, sizeof(struct resource));
+
+	for (i = 0; i < memmap.nr_map; i++) {
+		md = &memmap.map[i];
+		res = alloc_efi_resource(md, &activemem_resource, i);
+		if (md->type == EFI_CONVENTIONAL_MEMORY) {
+			request_resource(res, code_resource_copy);
+			request_resource(res, data_resource_copy);
+#ifdef CONFIG_KEXEC
+			request_resource(res, crashk_res_copy);
+#endif
+		}
+	}
+}
+
 /*
  * Make a copy of memmap for creating the physmem resources later.
  */
diff -puN arch/i386/kernel/setup.c~activemem-i386 arch/i386/kernel/setup.c
--- linux-2.6.12-rc1/arch/i386/kernel/setup.c~activemem-i386	2005-03-23 17:48:22.000000000 +0530
+++ linux-2.6.12-rc1-hari/arch/i386/kernel/setup.c	2005-03-23 17:48:22.000000000 +0530
@@ -1303,6 +1303,39 @@ static void __init legacy_init_physmem_r
 }
 
 /*
+ * Request address space for standard ROM and RAM resources. In i386, this is
+ * similar to the entries in iomem_resources. But we still do this so we have
+ * consistent views across architectures.
+ */
+static void __init legacy_init_activemem_resources(void)
+{
+	int i;
+	struct resource *res, *code_resource_copy, *data_resource_copy;
+#ifdef CONFIG_KEXEC
+	struct resource *crashk_res_copy;
+
+	crashk_res_copy = alloc_bootmem_low(sizeof(struct resource));
+	memcpy(crashk_res_copy, &crashk_res, sizeof(struct resource));
+#endif
+
+	code_resource_copy = alloc_bootmem_low(2*sizeof(struct resource));
+	data_resource_copy = code_resource_copy + sizeof(struct resource);
+	memcpy(code_resource_copy, &code_resource, sizeof(struct resource));
+	memcpy(data_resource_copy, &data_resource, sizeof(struct resource));
+
+	for (i = 0; i < e820.nr_map; i++) {
+		res = alloc_e820_resource(&e820, &activemem_resource, i);
+		if (e820.map[i].type == E820_RAM) {
+			request_resource(res, code_resource_copy);
+			request_resource(res, data_resource_copy);
+#ifdef CONFIG_KEXEC
+			request_resource(res, crashk_res_copy);
+#endif
+		}
+	}
+}
+
+/*
  * Request address space for all standard resources
  */
 static void __init register_memory(void)
@@ -1491,6 +1524,21 @@ static void __init register_physmem_reso
 		legacy_init_physmem_resources();
 }
 
+/*
+ * This is similar to the entries in iomem. But we create this
+ * to ensure consistency across archs. activemem contains a list
+ * RAM resources that are used by the current kernel. Is different
+ * from physmem when the kernel is booted with mem= or memmap=
+ * options.
+ */
+static void __init register_activemem_resources(void)
+{
+	if (efi_enabled)
+		efi_initialize_activemem_resources(&code_resource, &data_resource);
+	else
+		legacy_init_activemem_resources();
+}
+
 
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
@@ -1590,6 +1638,8 @@ void __init setup_arch(char **cmdline_p)
 
 	register_physmem_resources();
 
+	register_activemem_resources();
+
 #ifdef CONFIG_EARLY_PRINTK
 	{
 		char *s = strstr(*cmdline_p, "earlyprintk=");
diff -puN include/linux/efi.h~activemem-i386 include/linux/efi.h
--- linux-2.6.12-rc1/include/linux/efi.h~activemem-i386	2005-03-23 17:48:22.000000000 +0530
+++ linux-2.6.12-rc1-hari/include/linux/efi.h	2005-03-23 17:48:22.000000000 +0530
@@ -302,6 +302,8 @@ extern int __init efi_uart_console_only 
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 					struct resource *data_resource);
 extern void efi_initialize_physmem_resources(void);
+extern void efi_initialize_activemem_resources(struct resource *code_resource,
+					struct resource *data_resource);
 extern void preserve_memmap(void);
 extern unsigned long __init efi_get_time(void);
 extern int __init efi_set_rtc_mmss(unsigned long nowtime);
diff -puN include/linux/ioport.h~activemem-i386 include/linux/ioport.h
--- linux-2.6.12-rc1/include/linux/ioport.h~activemem-i386	2005-03-23 17:48:22.000000000 +0530
+++ linux-2.6.12-rc1-hari/include/linux/ioport.h	2005-03-23 17:48:22.000000000 +0530
@@ -92,6 +92,7 @@ struct resource_list {
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
 extern struct resource physmem_resource;
+extern struct resource activemem_resource;
 
 extern int request_resource(struct resource *root, struct resource *new);
 extern struct resource * ____request_resource(struct resource *root, struct resource *new);
_

--------------070304090703090208050701--
