Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWCDSAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWCDSAd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 13:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWCDSAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 13:00:33 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:43711 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932274AbWCDSAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 13:00:33 -0500
Date: Sat, 4 Mar 2006 18:00:18 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: mactel-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] /sys/firmware/efi/systab giving incorrect value for smbios
Message-ID: <20060304180018.GA3695@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my Intel imac, /sys/firmware/efi/systab is the following:

ACPI20=0x1fefd014
ACPI=0x1fefd000
SMBIOS=0x9fec9000

if I have a kernel with a 2:2 user/kernel split, and

SMBIOS=0x5fec9000

if I have a kernel with a 3:1 split. The correct value is 0x1fec9000, 
which is what the kernel prints at boot time. The following trivial 
patch seems to fix things.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/arch/i386/kernel/efi.c b/arch/i386/kernel/efi.c
index ecad519..6be705e 100644
--- a/arch/i386/kernel/efi.c
+++ b/arch/i386/kernel/efi.c
@@ -391,7 +391,7 @@ void __init efi_init(void)
 			printk(KERN_INFO " ACPI=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
-			efi.smbios = (void *) config_tables[i].table;
+			efi.smbios = __va(config_tables[i].table);
 			printk(KERN_INFO " SMBIOS=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, HCDP_TABLE_GUID) == 0) {

-- 
Matthew Garrett | mjg59@srcf.ucam.org
