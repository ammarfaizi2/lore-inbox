Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUIVKBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUIVKBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 06:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUIVKBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 06:01:46 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47073 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263626AbUIVKBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 06:01:38 -0400
Date: Wed, 22 Sep 2004 18:57:53 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[5/6]-ACPI processor driver
 extension
In-reply-to: <20040920094352.G14208@unix-os.sc.intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: tokunaga.keiich@jp.fujitsu.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <20040922185753.4f57d124.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920094352.G14208@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004 09:43:52 -0700 Keshavamurthy Anil S wrote:
> Changes form previous version
> 1) Added depends on EXPERIMENTAL in kconfig file
> 
> ---
> Name:processor_drv.patch
> Status:Tested on 2.6.9-rc2
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Depends:	
> Version: applies on 2.6.9-rc2	
> Description:
> Extends the processor driver to support ACPI based Physical CPU hotplug.

> +static int
> +is_processor_present(
> +	acpi_handle handle)
> +{
> +	acpi_status 		status;
> +	unsigned long		sta = 0;
> +
> +	ACPI_FUNCTION_TRACE("is_processor_present");
> +
> +	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
> +	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_PRESENT)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +			"Processor Device is not present\n"));
> +		return_VALUE(0);
> +	}
> +	return_VALUE(1);
> +}

This assumes that a device is not present if acpi_evaluate_integer()
returns failure.  But, from the ACPI spec, I think we should assume
the device is present if the function fails due to a failure in finding
_STA method.

I am attaching a patch to fix this.  Please see it below.

Thanks,
Keiichiro Tokunaga


Name: cpu_hp_sta_fix.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Description:
Fix the evaluation method of _STA in drivers/acpi/processor.c.  If a processor
object does not have _STA, we should consider it as present.


---

 linux-2.6.9-rc2-fix-kei/drivers/acpi/processor.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/processor.c~cpu_hp_sta_fix drivers/acpi/processor.c
--- linux-2.6.9-rc2-fix/drivers/acpi/processor.c~cpu_hp_sta_fix	2004-09-22 11:56:58.000000000 +0900
+++ linux-2.6.9-rc2-fix-kei/drivers/acpi/processor.c	2004-09-22 18:36:34.000000000 +0900
@@ -2551,7 +2551,17 @@ is_processor_present(
 	ACPI_FUNCTION_TRACE("is_processor_present");
 
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_PRESENT)) {
+	if (ACPI_FAILURE(status)) {
+		/* Assume device is present if it does not have _STA. */
+		if (status == AE_NOT_FOUND)
+			return_VALUE(1);
+		else {
+			printk(KERN_WARNING "Failed to evaluate _STA.\n");
+			return_VALUE(0);
+		}
+	}
+
+	if (!(sta & ACPI_STA_PRESENT)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 			"Processor Device is not present\n"));
 		return_VALUE(0);

_
