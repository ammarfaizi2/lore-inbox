Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbVCXF7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbVCXF7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbVCXF6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:58:15 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:3727 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263055AbVCXFzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:55:54 -0500
Message-ID: <4242567A.5060104@in.ibm.com>
Date: Thu, 24 Mar 2005 11:26:10 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 4/7] x86_64 code for the physmem map
References: <424254E0.6060003@in.ibm.com> <42425582.7040508@in.ibm.com> <424255EA.9010905@in.ibm.com> <42425635.30808@in.ibm.com>
In-Reply-To: <42425635.30808@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060909070003090805030403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060909070003090805030403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards, Hari

--------------060909070003090805030403
Content-Type: text/plain;
 name="physmem-x8664.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="physmem-x8664.patch"


---

This patch contains the x86_64 specific code to generate
the /proc/physmem view.
---

Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.12-rc1-hari/arch/x86_64/kernel/e820.c |   55 +++++++++++++++++-------
 1 files changed, 39 insertions(+), 16 deletions(-)

diff -puN arch/x86_64/kernel/e820.c~physmem-x8664 arch/x86_64/kernel/e820.c
--- linux-2.6.12-rc1/arch/x86_64/kernel/e820.c~physmem-x8664	2005-03-23 17:48:09.000000000 +0530
+++ linux-2.6.12-rc1-hari/arch/x86_64/kernel/e820.c	2005-03-23 17:48:09.000000000 +0530
@@ -178,25 +178,30 @@ unsigned long __init e820_end_of_ram(voi
 	return end_pfn;	
 }
 
-/* 
- * Mark e820 reserved areas as busy for the resource manager.
- */
-void __init e820_reserve_resources(void)
+static struct resource * __init alloc_e820_resource(struct resource *resource, int i)
+{
+	struct resource *res;
+
+	res = alloc_bootmem_low(sizeof(struct resource));
+	switch (e820.map[i].type) {
+	case E820_RAM:	res->name = "System RAM"; break;
+	case E820_ACPI:	res->name = "ACPI Tables"; break;
+	case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
+	default:	res->name = "reserved";
+	}
+	res->start = e820.map[i].addr;
+	res->end = res->start + e820.map[i].size - 1;
+	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	request_resource(resource, res);
+	return res;
+}
+
+static void __init e820_reserve_iomem_resources(void)
 {
 	int i;
+	struct resource *res;
 	for (i = 0; i < e820.nr_map; i++) {
-		struct resource *res;
-		res = alloc_bootmem_low(sizeof(struct resource));
-		switch (e820.map[i].type) {
-		case E820_RAM:	res->name = "System RAM"; break;
-		case E820_ACPI:	res->name = "ACPI Tables"; break;
-		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
-		default:	res->name = "reserved";
-		}
-		res->start = e820.map[i].addr;
-		res->end = res->start + e820.map[i].size - 1;
-		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		request_resource(&iomem_resource, res);
+		res = alloc_e820_resource(&iomem_resource, i);
 		if (e820.map[i].type == E820_RAM) {
 			/*
 			 *  We don't know which RAM region contains kernel data,
@@ -212,6 +217,24 @@ void __init e820_reserve_resources(void)
 	}
 }
 
+static void __init e820_reserve_physmem_resources(void)
+{
+	int i;
+	struct resource *res;
+	for (i = 0; i < e820.nr_map; i++) {
+		res = alloc_e820_resource(&physmem_resource, i);
+	}
+}
+
+/*
+ * Mark e820 reserved areas as busy for the resource manager.
+ */
+void __init e820_reserve_resources(void)
+{
+	e820_reserve_iomem_resources();
+	e820_reserve_physmem_resources();
+}
+
 /* 
  * Add a memory region to the kernel e820 map.
  */ 
_

--------------060909070003090805030403--
