Return-Path: <linux-kernel-owner+w=401wt.eu-S932131AbXAQJK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbXAQJK2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbXAQJKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:10:22 -0500
Received: from hera.kernel.org ([140.211.167.34]:43504 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbXAQJKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:10:19 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: Re: BUG: linux 2.6.19 unable to enable acpi
Date: Wed, 17 Jan 2007 04:08:54 -0500
User-Agent: KMail/1.9.5
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Luming Yu" <luming.yu@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <305c16960701162001j5ec23332hcd398cbe944916e1@mail.gmail.com> <305c16960701162335x3a84bbe5y87ee8c0608b2eea6@mail.gmail.com> <305c16960701162342u69526f5dn208c6531f6b9fc8e@mail.gmail.com>
In-Reply-To: <305c16960701162342u69526f5dn208c6531f6b9fc8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701170408.54220.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code that enables ACPI mode hasn't really changed since before 2.6.12 -- 
unless udelay() has changed beneath us...
So if you are going to test an old version of Linux, you should start before then.

Perhaps you can try this debug patch on top of 2.6.19 and send along the dmesg?
(also, please include CONFIG_ACPI_DEBUG=y)

thanks,
-Len



diff --git a/drivers/acpi/hardware/hwacpi.c b/drivers/acpi/hardware/hwacpi.c
index de50fab..c782da3 100644
--- a/drivers/acpi/hardware/hwacpi.c
+++ b/drivers/acpi/hardware/hwacpi.c
@@ -119,6 +119,9 @@ acpi_status acpi_hw_set_mode(u32 mode)
 	 * we make sure both the numbers are zero to determine these
 	 * transitions are not supported.
 	 */
+printk("ACPI: FADT.acpi_enable %d\n", acpi_gbl_FADT->acpi_enable);
+printk("ACPI: FADT.acpi_disable %d\n", acpi_gbl_FADT->acpi_disable);
+
 	if (!acpi_gbl_FADT->acpi_enable && !acpi_gbl_FADT->acpi_disable) {
 		ACPI_ERROR((AE_INFO,
 			    "No ACPI mode transition supported in this system (enable/disable both zero)"));
@@ -130,6 +133,9 @@ acpi_status acpi_hw_set_mode(u32 mode)
 
 		/* BIOS should have disabled ALL fixed and GP events */
 
+printk("ACPI: smi_cmd 0x%x, acpi_enable 0x%x\n",
+	acpi_gbl_FADT->smi_cmd, (u32) acpi_gbl_FADT->acpi_enable);
+
 		status = acpi_os_write_port(acpi_gbl_FADT->smi_cmd,
 					    (u32) acpi_gbl_FADT->acpi_enable,
 					    8);
@@ -164,7 +170,7 @@ acpi_status acpi_hw_set_mode(u32 mode)
 	 * Some hardware takes a LONG time to switch modes. Give them 3 sec to
 	 * do so, but allow faster systems to proceed more quickly.
 	 */
-	retry = 3000;
+	retry = 3000 * 100;
 	while (retry) {
 		if (acpi_hw_get_mode() == mode) {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -175,6 +181,7 @@ acpi_status acpi_hw_set_mode(u32 mode)
 		acpi_os_stall(1000);
 		retry--;
 	}
+printk("ACPI: retry %d\n");
 
 	ACPI_ERROR((AE_INFO, "Hardware did not change modes"));
 	return_ACPI_STATUS(AE_NO_HARDWARE_RESPONSE);

