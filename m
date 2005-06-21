Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVFUMhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVFUMhs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFUMfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:35:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:1444 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261178AbVFUMZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:25:56 -0400
Subject: PATCH: IDE - sensible probing for PCI systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119356601.3279.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 13:23:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Old ISA/VESA systems sometimes put tertiary IDE controllers at addresses
0x1e8, 0x168, 0x1e0 or 0x160. Linux thus probes these addresses on x86
systems. Unfortunately some PCI systems now use these addresses for
other purposes which leads to users seeing minute plus hangs during boot
or even crashes.

The following patch (again has been in Fedora for a while) only probes
the obscure legacy ISA ports on machinea that are pre-PCI. This seems to
keep everyone happy and if there is someone with that utterly weird
corner case the ide= command line still provides a get out of jail card.
Unsurprisingly we've not found anyone so affected.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12rc5/include/asm-i386/ide.h linux-2.6.12-rc5/include/asm-i386/ide.h
--- linux.vanilla-2.6.12rc5/include/asm-i386/ide.h	2005-05-27 15:15:42.000000000 +0100
+++ linux-2.6.12-rc5/include/asm-i386/ide.h	2005-05-27 15:43:28.000000000 +0100
@@ -41,16 +41,20 @@
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
+	if(pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
+		switch(index) {
+			case 2: return 0x1e8;
+			case 3: return 0x168;
+			case 4: return 0x1e0;
+			case 5: return 0x160;
+			}
+	}
 	switch (index) {
 		case 0:	return 0x1f0;
 		case 1:	return 0x170;
-		case 2: return 0x1e8;
-		case 3: return 0x168;
-		case 4: return 0x1e0;
-		case 5: return 0x160;
 		default:
 			return 0;
-	}
+	}		
 }
 
 #define IDE_ARCH_OBSOLETE_INIT

