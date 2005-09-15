Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbVIOBE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVIOBE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVIOBEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:04:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030307AbVIOBEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:04:37 -0400
Message-Id: <20050915010412.142093000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 10/11] Fix up more strange byte writes to the PCI_ROM_ADDRESS config word
Content-Disposition: inline; filename=fix-more-byte-to-dword-writes-to-PCI_ROM_ADDRESS-config-word.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

It's a dword thing, and the value we write is a dword.  Doing a byte
write to it is nonsensical, and writes only the low byte, which only
contains the enable bit.  So we enable a nonsensical address (usually
zero), which causes the controller no end of problems.

Trivial fix, but nasty to find.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/ide/pci/cmd64x.c |    2 +-
 drivers/ide/pci/hpt34x.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.13.y/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.13.y.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6.13.y/drivers/ide/pci/cmd64x.c
@@ -608,7 +608,7 @@ static unsigned int __devinit init_chips
 
 #ifdef __i386__
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
-		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
+		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 #endif
Index: linux-2.6.13.y/drivers/ide/pci/hpt34x.c
===================================================================
--- linux-2.6.13.y.orig/drivers/ide/pci/hpt34x.c
+++ linux-2.6.13.y/drivers/ide/pci/hpt34x.c
@@ -173,7 +173,7 @@ static unsigned int __devinit init_chips
 
 	if (cmd & PCI_COMMAND_MEMORY) {
 		if (pci_resource_start(dev, PCI_ROM_RESOURCE)) {
-			pci_write_config_byte(dev, PCI_ROM_ADDRESS,
+			pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 				dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 			printk(KERN_INFO "HPT345: ROM enabled at 0x%08lx\n",
 				dev->resource[PCI_ROM_RESOURCE].start);

--
