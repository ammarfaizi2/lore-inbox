Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263487AbTCNUWT>; Fri, 14 Mar 2003 15:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263490AbTCNUWT>; Fri, 14 Mar 2003 15:22:19 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:22656 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S263487AbTCNUWS>;
	Fri, 14 Mar 2003 15:22:18 -0500
Date: Fri, 14 Mar 2003 21:33:01 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Support for matroxfb on HP Vectra
Message-ID: <20030314203301.GA19437@vana.vc.cvut.cz>
References: <12BA303E51D2@vcnet.vc.cvut.cz> <3E71B8AE.4060903@mersin.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E71B8AE.4060903@mersin.edu.tr>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
  please apply this patch...

Matrox chips soldered to the HP Vectra's mainboard do not have EEPROM connected to
them, instead of that system BIOS contains VGA BIOS image which is extracted only 
to the legacy VGA BIOS region at 0xC0000, and nowhere else. And in addition to this 
they decided to use 14.318MHz XTAL instead of recommended 27.000MHz. These two events
together made matroxfb a bit unhappy on such motherboard, as all frequencies were
only 53% of expected value :-(

With this patch matroxfb tries to use legacy BIOS if there is no EEPROM and it
is ia32 architecture (and it was confirmed to fix a problem).

Patch applies to both 2.4 and 2.5, but in 2.5 it is a bit useless...

						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz
				

--- a/drivers/video/matrox/matroxfb_misc.c	2003-02-13 03:57:39.000000000 +0100
+++ b/drivers/video/matrox/matroxfb_misc.c	2003-03-14 14:33:01.000000000 +0100
@@ -994,6 +994,27 @@
 	parse_bios(vaddr_va(ACCESS_FBINFO(video).vbase), &ACCESS_FBINFO(bios));
 	pci_write_config_dword(pdev, PCI_ROM_ADDRESS, biosbase);
 	pci_write_config_dword(pdev, PCI_OPTION_REG, opt);
+#ifdef CONFIG_X86
+	if (!ACCESS_FBINFO(bios).bios_valid) {
+		unsigned char* b;
+		
+		b = ioremap(0x000C0000, 65536);
+		if (!b) {
+			printk(KERN_INFO "matroxfb: Unable to map legacy BIOS\n");
+		} else {
+			unsigned int ven = readb(b+0x64+0) | (readb(b+0x64+1) << 8);
+			unsigned int dev = readb(b+0x64+2) | (readb(b+0x64+3) << 8);
+			
+			if (ven != pdev->vendor || dev != pdev->device) {
+				printk(KERN_INFO "matroxfb: Legacy BIOS is for %04X:%04X, while this device is %04X:%04X\n",
+					ven, dev, pdev->vendor, pdev->device);
+			} else {
+				parse_bios(b, &ACCESS_FBINFO(bios));
+			}
+			iounmap(b);
+		}
+	}
+#endif
 	matroxfb_set_limits(PMINFO &ACCESS_FBINFO(bios));
 }
 
