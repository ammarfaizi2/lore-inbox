Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUIVRP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUIVRP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUIVRP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:15:27 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:10965 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266465AbUIVROr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:14:47 -0400
Date: Thu, 23 Sep 2004 02:10:31 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: anil.s.keshavamurthy@intel.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[3/6]-Mapping lsapic to cpu
Message-Id: <20040923021031.00007001.tokunaga.keiich@jp.fujitsu.com>
In-Reply-To: <1095864779.6105.3.camel@tdi>
References: <20040920092520.A14208@unix-os.sc.intel.com>
	<20040920093819.E14208@unix-os.sc.intel.com>
	<20040922221538.650986f2.tokunaga.keiich@jp.fujitsu.com>
	<1095864779.6105.3.camel@tdi>
Organization: FUJITSU LIMITED
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.3.0; Win32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 08:52:59 -0600, Alex Williamson wrote:
> On Wed, 2004-09-22 at 22:15 +0900, Keiichiro Tokunaga wrote:
> > 
> > I would like to suggest introducing a new function 'acpi_get_pxm()'
> > since other drivers might need it in the future.  Acutally, ACPI container
> > hotplug will be using it soon.
> > 
> > Here is a patch creating the function.
> > 
> 
>    Nice, I have a couple I/O locality patches that could be simplified
> with this function.
> 
> > +#ifdef CONFIG_ACPI_NUMA
> > +int acpi_get_pxm(acpi_handle handle);
> > +#else
> > +static inline int acpi_get_pxm(acpi_handle hanle)
> Trivial typo here --->                        ^^^^^ handle

Oh, good catch:)

Thanks!
Keiichiro Tokunaga


Name: acpi_pxm_support.patch
Status: 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokuanga.keiich@jp.fujitsu.com>
Description:
Introduce acpi_get_pxm().  The code has been refreshed a little bit
from the first version.

---

 linux-2.6.9-rc2-fix-kei/drivers/acpi/numa.c  |   21 ++++++++++++++++++++-
 linux-2.6.9-rc2-fix-kei/include/linux/acpi.h |    8 ++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/numa.c~acpi_pxm_support drivers/acpi/numa.c
--- linux-2.6.9-rc2-fix/drivers/acpi/numa.c~acpi_pxm_support	2004-09-22 18:53:53.000000000 +0900
+++ linux-2.6.9-rc2-fix-kei/drivers/acpi/numa.c	2004-09-23 02:07:50.948628719 +0900
@@ -22,7 +22,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
-
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -195,3 +195,22 @@ acpi_numa_init()
 	acpi_numa_arch_fixup();
 	return 0;
 }
+
+int
+acpi_get_pxm(acpi_handle h)
+{
+	unsigned long pxm = -1;
+	acpi_status status;
+	acpi_handle handle ;
+	acpi_handle phandle = h;
+
+	do {
+		handle = phandle;
+		status = acpi_evaluate_integer(handle, "_PXM", NULL, &pxm);
+		if (ACPI_SUCCESS(status))
+			return (int)pxm;
+		status = acpi_get_parent(handle, &phandle);
+	} while(ACPI_SUCCESS(status));
+	return -1;
+}
+EXPORT_SYMBOL(acpi_get_pxm);
diff -puN include/linux/acpi.h~acpi_pxm_support include/linux/acpi.h
--- linux-2.6.9-rc2-fix/include/linux/acpi.h~acpi_pxm_support	2004-09-22 18:53:53.000000000 +0900
+++ linux-2.6.9-rc2-fix-kei/include/linux/acpi.h	2004-09-23 02:08:18.792537695 +0900
@@ -477,4 +477,12 @@ static inline int acpi_blacklisted(void)
 
 #endif /*!CONFIG_ACPI_INTERPRETER*/
 
+#ifdef CONFIG_ACPI_NUMA
+int acpi_get_pxm(acpi_handle handle);
+#else
+static inline int acpi_get_pxm(acpi_handle handle)
+{
+	return 0;
+}
+#endif
 #endif /*_LINUX_ACPI_H*/

_
