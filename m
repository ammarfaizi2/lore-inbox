Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUIVNTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUIVNTe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 09:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUIVNTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 09:19:34 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57032 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265144AbUIVNTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 09:19:24 -0400
Date: Wed, 22 Sep 2004 22:15:38 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[3/6]-Mapping lsapic to cpu
In-reply-to: <20040920093819.E14208@unix-os.sc.intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: tokunaga.keiich@jp.fujitsu.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <20040922221538.650986f2.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920093819.E14208@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004 09:38:19 -0700 Keshavamurthy Anil S wrote:
> ---
> Name:acpi_hotplug_arch.patch
> Status: Tested on 2.6.9-rc2
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Depends:	
> Version: applies on 2.6.9-rc2	
> Description: 
> This patch provides the architecture specifice support for mapping lsapic to cpu array.
> Currently this supports just IA64. Support for IA32 and x86_64 is in progress
> ---

I would like to suggest introducing a new function 'acpi_get_pxm()'
since other drivers might need it in the future.  Acutally, ACPI container
hotplug will be use it soon.

Here is a patch creating the function.

Thanks,
Keiichiro Tokunaga

Name: acpi_pxm_support.patch
Status: 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokuanga.keiich@jp.fujitsu.com>
Description:
Introduce acpi_get_pxm().


---

 linux-2.6.9-rc2-fix-kei/drivers/acpi/numa.c  |   22 +++++++++++++++++++++-
 linux-2.6.9-rc2-fix-kei/include/linux/acpi.h |    8 ++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/numa.c~acpi_pxm_support drivers/acpi/numa.c
--- linux-2.6.9-rc2-fix/drivers/acpi/numa.c~acpi_pxm_support	2004-09-22 21:53:53.490202242 +0900
+++ linux-2.6.9-rc2-fix-kei/drivers/acpi/numa.c	2004-09-22 21:53:53.495085087 +0900
@@ -22,7 +22,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
-
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -195,3 +195,23 @@ acpi_numa_init()
 	acpi_numa_arch_fixup();
 	return 0;
 }
+
+int
+acpi_get_pxm(acpi_handle h)
+{
+	unsigned long pxm=-1;
+	acpi_status status;
+	acpi_handle handle ;
+	acpi_handle phandle = h;
+
+	do {
+		handle = phandle;
+		status = acpi_evaluate_integer(handle,"_PXM",NULL,&pxm);
+		if (ACPI_SUCCESS(status))  {
+			return (int)pxm;
+		}
+		status = acpi_get_parent(handle,&phandle);
+	} while( ACPI_SUCCESS(status) );
+	return -1;
+}
+EXPORT_SYMBOL(acpi_get_pxm);
diff -puN include/linux/acpi.h~acpi_pxm_support include/linux/acpi.h
--- linux-2.6.9-rc2-fix/include/linux/acpi.h~acpi_pxm_support	2004-09-22 18:53:53.492155380 +0900
+++ linux-2.6.9-rc2-fix-kei/include/linux/acpi.h	2004-09-22 18:53:53.495085087 +0900
@@ -477,4 +477,12 @@ static inline int acpi_blacklisted(void)
 
 #endif /*!CONFIG_ACPI_INTERPRETER*/
 
+#ifdef CONFIG_ACPI_NUMA
+int acpi_get_pxm(acpi_handle handle);
+#else
+static inline int acpi_get_pxm(acpi_handle hanle)
+{
+	return 0;
+}
+#endif
 #endif /*_LINUX_ACPI_H*/

_
