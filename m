Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbWFMAie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbWFMAie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWFMAeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:34:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62187 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932696AbWFMAeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:34:18 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 08/16] 64bit resource: fix up printks for resources in pcmcia drivers
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 12 Jun 2006 17:31:10 -0700
Message-Id: <11501587043722-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11501587011194-git-send-email-greg@kroah.com>
References: <20060613003033.GA10717@kroah.com> <11501586781628-git-send-email-greg@kroah.com> <1150158683636-git-send-email-greg@kroah.com> <11501586871870-git-send-email-greg@kroah.com> <11501586902008-git-send-email-greg@kroah.com> <11501586942938-git-send-email-greg@kroah.com> <11501586982289-git-send-email-greg@kroah.com> <11501587011194-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pcmcia/i82365.c         |    5 +++--
 drivers/pcmcia/pd6729.c         |    3 ++-
 drivers/pcmcia/rsrc_nonstatic.c |   12 ++++++++----
 drivers/pcmcia/tcic.c           |    5 +++--
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
index a2f05f4..ff51a65 100644
--- a/drivers/pcmcia/i82365.c
+++ b/drivers/pcmcia/i82365.c
@@ -1084,9 +1084,10 @@ static int i365_set_mem_map(u_short sock
     u_short base, i;
     u_char map;
     
-    debug(1, "SetMemMap(%d, %d, %#2.2x, %d ns, %#lx-%#lx, "
+    debug(1, "SetMemMap(%d, %d, %#2.2x, %d ns, %#llx-%#llx, "
 	  "%#x)\n", sock, mem->map, mem->flags, mem->speed,
-	  mem->res->start, mem->res->end, mem->card_start);
+	  (unsigned long long)mem->res->start,
+	  (unsigned long long)mem->res->end, mem->card_start);
 
     map = mem->map;
     if ((map > 4) || (mem->card_start > 0x3ffffff) ||
diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
index 247ab83..9ee26c1 100644
--- a/drivers/pcmcia/pd6729.c
+++ b/drivers/pcmcia/pd6729.c
@@ -642,7 +642,8 @@ static int __devinit pd6729_pci_probe(st
 		goto err_out_free_mem;
 
 	printk(KERN_INFO "pd6729: Cirrus PD6729 PCI to PCMCIA Bridge "
-		"at 0x%lx on irq %d\n",	pci_resource_start(dev, 0), dev->irq);
+		"at 0x%llx on irq %d\n",
+		(unsigned long long)pci_resource_start(dev, 0), dev->irq);
  	/*
 	 * Since we have no memory BARs some firmware may not
 	 * have had PCI_COMMAND_MEMORY enabled, yet the device needs it.
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 0f8b157..cc03130 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -808,8 +808,10 @@ #endif
 		if (res->flags & IORESOURCE_IO) {
 			if (res == &ioport_resource)
 				continue;
-			printk(KERN_INFO "pcmcia: parent PCI bridge I/O window: 0x%lx - 0x%lx\n",
-			       res->start, res->end);
+			printk(KERN_INFO "pcmcia: parent PCI bridge I/O "
+				"window: 0x%llx - 0x%llx\n",
+				(unsigned long long)res->start,
+				(unsigned long long)res->end);
 			if (!adjust_io(s, ADD_MANAGED_RESOURCE, res->start, res->end))
 				done |= IORESOURCE_IO;
 
@@ -818,8 +820,10 @@ #endif
 		if (res->flags & IORESOURCE_MEM) {
 			if (res == &iomem_resource)
 				continue;
-			printk(KERN_INFO "pcmcia: parent PCI bridge Memory window: 0x%lx - 0x%lx\n",
-			       res->start, res->end);
+			printk(KERN_INFO "pcmcia: parent PCI bridge Memory "
+				"window: 0x%llx - 0x%llx\n",
+				(unsigned long long)res->start,
+				(unsigned long long)res->end);
 			if (!adjust_memory(s, ADD_MANAGED_RESOURCE, res->start, res->end))
 				done |= IORESOURCE_MEM;
 		}
diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
index 73bad1d..65a6067 100644
--- a/drivers/pcmcia/tcic.c
+++ b/drivers/pcmcia/tcic.c
@@ -756,8 +756,9 @@ static int tcic_set_mem_map(struct pcmci
     u_long base, len, mmap;
 
     debug(1, "SetMemMap(%d, %d, %#2.2x, %d ns, "
-	  "%#lx-%#lx, %#x)\n", psock, mem->map, mem->flags,
-	  mem->speed, mem->res->start, mem->res->end, mem->card_start);
+	  "%#llx-%#llx, %#x)\n", psock, mem->map, mem->flags,
+	  mem->speed, (unsigned long long)mem->res->start,
+	  (unsigned long long)mem->res->end, mem->card_start);
     if ((mem->map > 3) || (mem->card_start > 0x3ffffff) ||
 	(mem->res->start > 0xffffff) || (mem->res->end > 0xffffff) ||
 	(mem->res->start > mem->res->end) || (mem->speed > 1000))
-- 
1.4.0

