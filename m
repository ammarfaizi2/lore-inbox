Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRCBSfu>; Fri, 2 Mar 2001 13:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRCBSfk>; Fri, 2 Mar 2001 13:35:40 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:27911 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129399AbRCBSf1>;
	Fri, 2 Mar 2001 13:35:27 -0500
Date: Fri, 2 Mar 2001 19:34:44 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: mj@suse.cz
Cc: linux-kernel@vger.kernel.org, hulinsky@fel.cvut.cz
Subject: [PATCH] 2.4.2-acX does not recognize any bus on Intel Serverworks based motherboard
Message-ID: <20010302193444.A2154@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
  what's idea behind 'pcibios_last_bus >= 0xff' ? On friend's STL2 Intel
motherboard Serverworks bridge contains 0x01 in reg. 0x44 (first bus behind
bridge) and 0xFF in reg. 0x45 (last bus behind bridge).
  This sets pcibios_last_bus to 0xFF in serverworks fixup code. After this
pcibios_fixup_peer_bridges() refuses to do anything, so devices connected
to secondary bus are not visible to system.
  With patch below system sees all devices again - patch is for 2.4.2-ac9.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/arch/i386/kernel/pci-pc.c linux/arch/i386/kernel/pci-pc.c
--- linux/arch/i386/kernel/pci-pc.c	Fri Mar  2 17:55:05 2001
+++ linux/arch/i386/kernel/pci-pc.c	Fri Mar  2 17:56:50 2001
@@ -784,7 +784,7 @@
 	struct pci_dev dev;
 	u16 l;
 
-	if (pcibios_last_bus <= 0 || pcibios_last_bus >= 0xff)
+	if (pcibios_last_bus <= 0 || pcibios_last_bus > 0xff)
 		return;
 	DBG("PCI: Peer bridge fixup\n");
 	for (n=0; n <= pcibios_last_bus; n++) {
