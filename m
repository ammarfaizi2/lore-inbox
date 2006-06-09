Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWFIS2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWFIS2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWFIS2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:28:31 -0400
Received: from 63-207-7-10.ded.pacbell.net ([63.207.7.10]:19687 "EHLO
	cassini.c2micro.com") by vger.kernel.org with ESMTP
	id S1030343AbWFIS2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:28:30 -0400
Message-ID: <4489BDCD.4000400@c2micro.com>
Date: Fri, 09 Jun 2006 11:28:29 -0700
From: "H. Peter Anvin" <hpa@c2micro.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, mchan@broadcom.com
Subject: [PATCH] fix to pci ignore pre-set 64-bit bars on 32-bit platforms
References: <200606071711.06774.bjorn.helgaas@hp.com> <200606082249.14475.bjorn.helgaas@hp.com> <44890117.1000403@c2micro.com> <200606091005.21165.bjorn.helgaas@hp.com>
In-Reply-To: <200606091005.21165.bjorn.helgaas@hp.com>
Content-Type: multipart/mixed;
 boundary="------------040003050500020507060208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040003050500020507060208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040003050500020507060208
Content-Type: text/plain;
 name="pci-fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-fix.txt"

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

When we detect a 64-bit pre-set address in a BAR on a 32-bit platform,
we disable it and treat it as if it had been unset, thus allowing the
general address assignment code to assign a new address to it when the
device is enabled.  This can happen either if the firmware assigns
64-bit addresses; additionally, some cards have been found "in the
wild" which do not come out of reset with all the BAR registers set to
zero.

Unfortunately, the patch that implemented this tested the low part of
the address instead of the high part of the address.  This patch fixes
that.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: H. Peter Anvin <hpa@zytor.com>

Index: rc5-mm3/drivers/pci/probe.c
===================================================================
--- rc5-mm3.orig/drivers/pci/probe.c	2006-06-09 09:40:51.000000000 -0600
+++ rc5-mm3/drivers/pci/probe.c	2006-06-09 09:42:35.000000000 -0600
@@ -199,7 +199,7 @@
 				printk(KERN_ERR "PCI: Unable to handle 64-bit BAR for device %s\n", pci_name(dev));
 				res->start = 0;
 				res->flags = 0;
-			} else if (l) {
+			} else if (lhi) {
 				/* 64-bit wide address, treat as disabled */
 				pci_write_config_dword(dev, reg, l & ~(u32)PCI_BASE_ADDRESS_MEM_MASK);
 				pci_write_config_dword(dev, reg+4, 0);

--------------040003050500020507060208--
