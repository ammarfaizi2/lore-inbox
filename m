Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVCXGDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVCXGDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVCXGCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:02:55 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:35825 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262410AbVCXGAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 01:00:30 -0500
Message-ID: <4242578D.7030504@in.ibm.com>
Date: Thu, 24 Mar 2005 11:30:45 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 7/7] x86_64 code for the activemem map
References: <424254E0.6060003@in.ibm.com> <42425582.7040508@in.ibm.com> <424255EA.9010905@in.ibm.com> <42425635.30808@in.ibm.com> <4242567A.5060104@in.ibm.com> <424256BA.2060901@in.ibm.com> <4242571A.4020608@in.ibm.com>
In-Reply-To: <4242571A.4020608@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090107060905020202040900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090107060905020202040900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards, Hari

--------------090107060905020202040900
Content-Type: text/plain;
 name="activemem-x8664.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="activemem-x8664.patch"


---

This patch contains the x86_64 specific code to generate
the /proc/activemem view.
---

Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.12-rc1-hari/arch/x86_64/kernel/e820.c |   37 ++++++++++++++++++++++++
 1 files changed, 37 insertions(+)

diff -puN arch/x86_64/kernel/e820.c~activemem-x8664 arch/x86_64/kernel/e820.c
--- linux-2.6.12-rc1/arch/x86_64/kernel/e820.c~activemem-x8664	2005-03-23 17:48:25.000000000 +0530
+++ linux-2.6.12-rc1-hari/arch/x86_64/kernel/e820.c	2005-03-23 17:48:25.000000000 +0530
@@ -226,6 +226,42 @@ static void __init e820_reserve_physmem_
 	}
 }
 
+static void __init e820_reserve_activemem_resources(void)
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
+		res = alloc_e820_resource(&activemem_resource, i);
+		if (e820.map[i].type == E820_RAM) {
+			request_resource(res, code_resource_copy);
+			request_resource(res, data_resource_copy);
+#ifdef CONFIG_KEXEC
+			request_resource(res, crashk_res_copy);
+#endif
+		}
+		/* If the system has booted with less memory, reflect
+		 * only those entries
+		 */
+		if ((e820.map[i].addr + e820.map[i].size) > (end_user_pfn << PAGE_SHIFT)) {
+			/* Trim the last entry to reflect the actual pfn allowed */
+			res->end = (end_user_pfn << PAGE_SHIFT) - 1;
+			break;
+		}
+	}
+}
+
 /*
  * Mark e820 reserved areas as busy for the resource manager.
  */
@@ -233,6 +269,7 @@ void __init e820_reserve_resources(void)
 {
 	e820_reserve_iomem_resources();
 	e820_reserve_physmem_resources();
+	e820_reserve_activemem_resources();
 }
 
 /* 
_

--------------090107060905020202040900--
