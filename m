Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVCOUNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVCOUNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVCOUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:09:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:27348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261837AbVCOTzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:55:11 -0500
Date: Tue, 15 Mar 2005 11:54:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64 kernel fails to link because of PCI MSI quirk
Message-Id: <20050315115451.50dbf001.akpm@osdl.org>
In-Reply-To: <1110905410.5685.15.camel@mulgrave>
References: <1110905410.5685.15.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> The problem is that the MSI code has an unconditional dependency on
>  pci_msi_quirk.  However, the quirk and the variable are only defined if
>  CONFIG_X86_IO_APIC is defined, which it never is on ia64.

Yes, I hit that as well.

>  The solution is to make the variable global and unconditional.

I fixed it differently:

--- 25/drivers/pci/pci.h~ia64-msi-build-fix	Sat Mar 12 18:13:37 2005
+++ 25-akpm/drivers/pci/pci.h	Sat Mar 12 18:14:23 2005
@@ -64,8 +64,13 @@ extern void pci_remove_legacy_files(stru
 /* Lock for read/write access to pci device and bus lists */
 extern spinlock_t pci_bus_lock;
 
-extern int pcie_mch_quirk;
+#ifdef CONFIG_X86_IO_APIC
 extern int pci_msi_quirk;
+#else
+#define pci_msi_quirk 0
+#endif
+
+extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
 extern struct class_device_attribute class_device_attr_cpuaffinity;
 
_

