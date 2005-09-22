Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVIVHy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVIVHy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbVIVHtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:49:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:1203 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751443AbVIVHs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:56 -0400
Date: Thu, 22 Sep 2005 00:48:19 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 07/18] fix drivers/pci/probe.c warning
Message-ID: <20050922074818.GH15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-fix-probe-warning.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amos Waterland <apw@us.ibm.com>

This function expects an unsigned 32-bit type as its third argument:

 static u32 pci_size(u32 base, u32 maxbase, u32 mask)

However, given these definitions:

 #define PCI_BASE_ADDRESS_MEM_MASK (~0x0fUL)
 #define PCI_ROM_ADDRESS_MASK (~0x7ffUL)

these two calls in drivers/pci/probe.c are problematic for architectures
for which a UL is not equivalent to a u32:
 
 sz = pci_size(l, sz, PCI_BASE_ADDRESS_MEM_MASK);
 sz = pci_size(l, sz, PCI_ROM_ADDRESS_MASK);

Hence the below compile warning when building for ARCH=ppc64:

 drivers/pci/probe.c: In function `pci_read_bases':
 /.../probe.c:168: warning: large integer implicitly truncated to unsigned type
 /.../probe.c:218: warning: large integer implicitly truncated to unsigned type

Here is a simple fix.

Signed-off-by: Amos Waterland <apw@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/pci/probe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- scsi-2.6.orig/drivers/pci/probe.c	2005-09-20 05:59:55.000000000 -0700
+++ scsi-2.6/drivers/pci/probe.c	2005-09-21 17:29:32.000000000 -0700
@@ -165,7 +165,7 @@
 		if (l == 0xffffffff)
 			l = 0;
 		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
-			sz = pci_size(l, sz, PCI_BASE_ADDRESS_MEM_MASK);
+			sz = pci_size(l, sz, (u32)PCI_BASE_ADDRESS_MEM_MASK);
 			if (!sz)
 				continue;
 			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
@@ -215,7 +215,7 @@
 		if (l == 0xffffffff)
 			l = 0;
 		if (sz && sz != 0xffffffff) {
-			sz = pci_size(l, sz, PCI_ROM_ADDRESS_MASK);
+			sz = pci_size(l, sz, (u32)PCI_ROM_ADDRESS_MASK);
 			if (sz) {
 				res->flags = (l & IORESOURCE_ROM_ENABLE) |
 				  IORESOURCE_MEM | IORESOURCE_PREFETCH |

--
