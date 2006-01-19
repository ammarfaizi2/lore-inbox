Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422629AbWASUNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422629AbWASUNg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161403AbWASUNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:13:32 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:38625 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1161397AbWASUNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:13:21 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: [PATCH 3/5] DMI: only ioremap stuff we actually need
Date: Thu, 19 Jan 2006 13:13:17 -0700
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <20060118181116.GA5537@lists.us.dell.com> <200601191310.57303.bjorn.helgaas@hp.com>
In-Reply-To: <200601191310.57303.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601191313.18036.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmi_scan_machine() tries to ioremap 0x10000 (64K) bytes, even though
it only looks at the first 32 bytes or so.  If the SMBIOS table is
near the end of a memory region, the ioremap() may fail when it
shouldn't.

This is in the efi_enabled path, so it really only affects ia64 at
the moment.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm3/arch/i386/kernel/dmi_scan.c
===================================================================
--- work-mm3.orig/arch/i386/kernel/dmi_scan.c	2006-01-19 11:26:17.000000000 -0700
+++ work-mm3/arch/i386/kernel/dmi_scan.c	2006-01-19 11:30:21.000000000 -0700
@@ -223,7 +223,7 @@
                 * needed during early boot.  This also means we can
                 * iounmap the space when we're done with it.
 		*/
-		p = ioremap((unsigned long)efi.smbios, 0x10000);
+		p = ioremap((unsigned long)efi.smbios, 32);
 		if (p == NULL)
 			goto out;
 
