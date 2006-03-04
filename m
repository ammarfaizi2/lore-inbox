Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751895AbWCDTAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWCDTAc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 14:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWCDTAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 14:00:32 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:33467 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751895AbWCDTAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 14:00:31 -0500
Date: Sat, 4 Mar 2006 19:00:26 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: mactel-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /sys/firmware/efi/systab giving incorrect value for smbios
Message-ID: <20060304190026.GA4041@srcf.ucam.org>
References: <20060304180018.GA3695@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304180018.GA3695@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or, as an alternative, remove the virtual to physical mapping that 
efivars does. This requires fixing up IA64 to match. I've no idea which 
approach is right.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
index bda5bce..ba598af 100644
--- a/drivers/firmware/efivars.c
+++ b/drivers/firmware/efivars.c
@@ -575,7 +575,7 @@ systab_read(struct subsystem *entry, cha
 	if (efi.acpi)
 		str += sprintf(str, "ACPI=0x%lx\n", __pa(efi.acpi));
 	if (efi.smbios)
-		str += sprintf(str, "SMBIOS=0x%lx\n", __pa(efi.smbios));
+		str += sprintf(str, "SMBIOS=0x%lx\n", efi.smbios);
 	if (efi.hcdp)
 		str += sprintf(str, "HCDP=0x%lx\n", __pa(efi.hcdp));
 	if (efi.boot_info)
diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index a3aa45c..ff3795b 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -451,7 +451,7 @@ efi_init (void)
 			efi.acpi = __va(config_tables[i].table);
 			printk(" ACPI=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
-			efi.smbios = __va(config_tables[i].table);
+			efi.smbios = config_tables[i].table;
 			printk(" SMBIOS=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, SAL_SYSTEM_TABLE_GUID) == 0) {
 			efi.sal_systab = __va(config_tables[i].table);

-- 
Matthew Garrett | mjg59@srcf.ucam.org
