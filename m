Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281487AbRKZHTt>; Mon, 26 Nov 2001 02:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281483AbRKZHTj>; Mon, 26 Nov 2001 02:19:39 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:60177 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S281492AbRKZHTT>;
	Mon, 26 Nov 2001 02:19:19 -0500
Message-ID: <3C01ECF4.3000500@epfl.ch>
Date: Mon, 26 Nov 2001 08:19:16 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: marcelo@conectiva.com.br, torvalds <torvalds@transmeta.com>
Subject: [PATCH] agpgart fixes (Intel chipsets)
Content-Type: multipart/mixed;
 boundary="------------080401040009070008050103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080401040009070008050103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

Here is a patch that fixes several issues in the agpgart driver :
- The 'cleanup' function for i820 chipsets was incorrectly set to the 
generic function (that writes over 16 bits instead of 8)
- Fix incorrect PCI id for the i860 chipset
- Add support for the UP version of i820 chipset
- Config.in update

The patch is against 2.4.15

Best regards
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)
Office:  ELE 237
Phone:   +41 - 21 - 693 36 32 (Office) or 46 21 (LTS lab)
Fax:     +41 - 21 - 693 76 00     Web: http://ltswww.epfl.ch/~aspert

--------------080401040009070008050103
Content-Type: text/plain;
 name="patch-agp_i8xx-2.4.15_fix_pci_ids"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-agp_i8xx-2.4.15_fix_pci_ids"

diff -Nru linux-2.4.15.clean/drivers/char/Config.in linux-2.4.15.dirty/drivers/char/Config.in
--- linux-2.4.15.clean/drivers/char/Config.in	Mon Nov 12 18:34:16 2001
+++ linux-2.4.15.dirty/drivers/char/Config.in	Fri Nov 23 15:03:02 2001
@@ -210,7 +210,7 @@
 
 dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
 if [ "$CONFIG_AGP" != "n" ]; then
-   bool '  Intel 440LX/BX/GX and I815/I830M/I840/I850 support' CONFIG_AGP_INTEL
+   bool '  Intel 440LX/BX/GX and I815/I820/I830M/I840/I845/I850/I860 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815/I830M (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
diff -Nru linux-2.4.15.clean/drivers/char/agp/agp.h linux-2.4.15.dirty/drivers/char/agp/agp.h
--- linux-2.4.15.clean/drivers/char/agp/agp.h	Fri Nov  9 23:01:21 2001
+++ linux-2.4.15.dirty/drivers/char/agp/agp.h	Fri Nov 23 15:03:02 2001
@@ -179,6 +179,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_820_0
 #define PCI_DEVICE_ID_INTEL_820_0       0x2500
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_820_UP_0
+#define PCI_DEVICE_ID_INTEL_820_UP_0    0x2501
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_840_0
 #define PCI_DEVICE_ID_INTEL_840_0		0x1a21
 #endif
@@ -189,7 +192,7 @@
 #define PCI_DEVICE_ID_INTEL_850_0     0x2530
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_860_0
-#define PCI_DEVICE_ID_INTEL_860_0	0x2532
+#define PCI_DEVICE_ID_INTEL_860_0	0x2531
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_810_DC100_0
 #define PCI_DEVICE_ID_INTEL_810_DC100_0 0x7122
diff -Nru linux-2.4.15.clean/drivers/char/agp/agpgart_be.c linux-2.4.15.dirty/drivers/char/agp/agpgart_be.c
--- linux-2.4.15.clean/drivers/char/agp/agpgart_be.c	Fri Nov 16 19:11:22 2001
+++ linux-2.4.15.dirty/drivers/char/agp/agpgart_be.c	Fri Nov 23 15:54:31 2001
@@ -1790,7 +1790,7 @@
        agp_bridge.needs_scratch_page = FALSE;
        agp_bridge.configure = intel_820_configure;
        agp_bridge.fetch_size = intel_8xx_fetch_size;
-       agp_bridge.cleanup = intel_cleanup;
+       agp_bridge.cleanup = intel_820_cleanup;
        agp_bridge.tlb_flush = intel_820_tlbflush;
        agp_bridge.mask_memory = intel_mask_memory;
        agp_bridge.agp_enable = agp_generic_agp_enable;
@@ -3550,6 +3550,12 @@
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I820,
 		"Intel",
+		"i820",
+		intel_820_setup },
+	{ PCI_DEVICE_ID_INTEL_820_UP_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I820,
+		"Intel",
 		"i820",
 		intel_820_setup },
 	{ PCI_DEVICE_ID_INTEL_830_M_0,

--------------080401040009070008050103--

