Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266179AbSLSV3g>; Thu, 19 Dec 2002 16:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbSLSV3g>; Thu, 19 Dec 2002 16:29:36 -0500
Received: from palrel12.hp.com ([156.153.255.237]:430 "HELO palrel12.hp.com")
	by vger.kernel.org with SMTP id <S266179AbSLSV3f>;
	Thu, 19 Dec 2002 16:29:35 -0500
To: mj@ucw.cz
Subject: PATCH 2.5.x disable BAR when sizing
Cc: linux-kernel@vger.kernel.org, turukawa@icc.melco.co.jp
Message-Id: <20021219213712.0518B12CB2@debian.cup.hp.com>
Date: Thu, 19 Dec 2002 13:37:12 -0800 (PST)
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,
In April 2002, turukawa@icc.melco.co.jp sent a 2.4.x patch to disable
BARs while the BARs were being sized.  I've "forward ported" this patch
to 2.5.x (appended).  turukawa's excellent problem description and
original posting are here:
	https://lists.linuxia64.org/archives//linux-ia64/2002-April/003302.html

David Mosberger agrees this is an "obvious fix".
We've been using this in the ia64 2.4 code stream since about August.

thanks,
grant


Index: drivers/pci/probe.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/pci/probe.c,v
retrieving revision 1.2
diff -u -p -r1.2 probe.c
--- drivers/pci/probe.c	9 Oct 2002 20:42:57 -0000	1.2
+++ drivers/pci/probe.c	17 Dec 2002 21:53:14 -0000
@@ -48,6 +48,12 @@ static void pci_read_bases(struct pci_de
 	unsigned int pos, reg, next;
 	u32 l, sz;
 	struct resource *res;
+	u16 cmd;
+
+	/* Disable I/O & memory decoding while we size the BARs. */
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	pci_write_config_word(dev, PCI_COMMAND,
+		cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY));
 
 	for(pos=0; pos<howmany; pos = next) {
 		next = pos+1;
@@ -114,6 +120,8 @@ static void pci_read_bases(struct pci_de
 		}
 		res->name = dev->name;
 	}
+
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
 }
 
 void __devinit pci_read_bridge_bases(struct pci_bus *child)
