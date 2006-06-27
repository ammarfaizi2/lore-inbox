Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161168AbWF0Qlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWF0Qlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161183AbWF0Qht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:37:49 -0400
Received: from ns1.suse.de ([195.135.220.2]:28118 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161179AbWF0Qha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:30 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 8/17] [PATCH] 64bit resource: fix up printks for resources in pcmcia drivers
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:44 -0700
Message-Id: <11514260583661-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260543854-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com> <11514260483754-git-send-email-greg@kroah.com> <11514260513485-git-send-email-greg@kroah.com> <11514260543854-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
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

