Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266900AbRGZKqf>; Thu, 26 Jul 2001 06:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbRGZKqZ>; Thu, 26 Jul 2001 06:46:25 -0400
Received: from smtp2.wp.pl ([212.77.101.159]:34312 "HELO smtp.wp.pl")
	by vger.kernel.org with SMTP id <S266698AbRGZKqL>;
	Thu, 26 Jul 2001 06:46:11 -0400
Date: Thu, 26 Jul 2001 12:44:29 +0200
To: linux-kernel@vger.kernel.org
Subject: Patch to agpgart for VIA Apollo Pro 133A - VIA694X chipset 
From: "maciek n" <maciek_now@wp.pl>
X-Mailer: Interfejs WWW poczty Wirtualnej Polski
X-IP: 213.77.64.3 (kafe.age.pl)
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Message-Id: <20010726104622Z266698-720+6508@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Please find small patch to linux-2.4.7 agpgart/drm for very popular 
and powerfull VIA VT82C694X chipset ( Intel PIII/CII ). 

Until now it was not directly supported by agpgart/drm in kernel
and for operation need ugly agp_try_unsupported=1 into modules.conf

If you interested there is also the second patch ( or you can put it
manually ) to XFree-4.1.0 drm/kernel

Is it possible to include it to in future kernels ?


Maciek

If you have any questions to me please add cc: to 
maciek_now@wp.pl because I'am not subscribed to this list




--- linux-2.4.7-VIA694X-patch -------------------------

diff -u --recursive --new-file linux-2.4.7-
orig/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux-2.4.7-orig/drivers/char/agp/agp.h	Tue Jul  3 00:27:56 
2001
+++ linux/drivers/char/agp/agp.h	Wed Jul 25 21:49:03 2001
@@ -160,6 +160,9 @@
 #ifndef PCI_DEVICE_ID_VIA_8363_0
 #define PCI_DEVICE_ID_VIA_8363_0      0x0305
 #endif
+#ifndef PCI_DEVICE_ID_VIA_82C694X_0
+#define PCI_DEVICE_ID_VIA_82C694X_0      0x0605
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_810_0
 #define PCI_DEVICE_ID_INTEL_810_0       0x7120
 #endif
diff -u --recursive --new-file linux-2.4.7-
orig/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux-2.4.7-orig/drivers/char/agp/agpgart_be.c	Tue Jul  3 
00:27:56 2001
+++ linux/drivers/char/agp/agpgart_be.c	Wed Jul 25 22:07:49 2001
@@ -507,6 +507,7 @@
 		if (cap_ptr != 0x00)
 			pci_write_config_dword(device, cap_ptr + 8, 
command);
 	}
+	printk (KERN_INFO PFX "AGP mode is %ldx\n", command & 7);
 }
 
 static int agp_generic_create_gatt_table(void)
@@ -3022,6 +3023,12 @@
 		VIA_APOLLO_KT133,
 		"Via",
 		"Apollo Pro KT133",
+		via_generic_setup },
+	{ PCI_DEVICE_ID_VIA_82C694X_0,
+		PCI_VENDOR_ID_VIA,
+		VIA_APOLLO_PRO133A,
+		"Via",
+		"Apollo Pro 133A",
 		via_generic_setup },
 	{ 0,
 		PCI_VENDOR_ID_VIA,
diff -u --recursive --new-file linux-2.4.7-
orig/drivers/char/drm/agpsupport.c linux/drivers/char/drm/agpsupport.c
--- linux-2.4.7-orig/drivers/char/drm/agpsupport.c	Tue Jul  3 
00:27:56 2001
+++ linux/drivers/char/drm/agpsupport.c	Wed Jul 25 22:19:21 2001
@@ -275,6 +275,8 @@
 			break;
 		case VIA_APOLLO_KT133:	head->chipset = "VIA Apollo 
KT133"; 
 			break;
+		case VIA_APOLLO_PRO133A:head->chipset = "VIA Apollo 
Pro 133A";
+			break;
 #endif
 
 		case VIA_APOLLO_PRO: 	head->chipset = "VIA Apollo 
Pro";
diff -u --recursive --new-file linux-2.4.7-
orig/include/linux/agp_backend.h linux/include/linux/agp_backend.h
--- linux-2.4.7-orig/include/linux/agp_backend.h	Tue Jul  3 
00:27:56 2001
+++ linux/include/linux/agp_backend.h	Wed Jul 25 22:15:01 2001
@@ -55,6 +55,7 @@
 	VIA_APOLLO_PRO,
 	VIA_APOLLO_KX133,
 	VIA_APOLLO_KT133,
+	VIA_APOLLO_PRO133A,
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,


--- XFree86-4.1.0-DRM-VIA694X-patch --------------------------------


diff -u /tmp/dri/xc/programs/Xserver/hw/xfree86/os-
support/linux/drm/kernel/drm_agpsupport.h 
xc/programs/Xserver/hw/xfree86/os-
support/linux/drm/kernel/drm_agpsupport.h
--- /tmp/dri/xc/programs/Xserver/hw/xfree86/os-
support/linux/drm/kernel/drm_agpsupport.h	Tue Apr 10 18:08:04 
2001
+++ xc/programs/Xserver/hw/xfree86/os-
support/linux/drm/kernel/drm_agpsupport.h	Tue Jul 24 23:15:13 
2001
@@ -285,6 +285,8 @@
 			break;
 		case VIA_APOLLO_KT133:	head->chipset = "VIA Apollo 
KT133";
 			break;
+		case VIA_APOLLO_PRO133A:head->chipset = "VIA Apollo 
Pro133A";
+			break;
 #endif
 
 		case VIA_APOLLO_PRO: 	head->chipset = "VIA Apollo 
Pro";



-----------------------------------------------------------------------
Najtañsze ksi±¿ki, p³yty, filmy. Kliknij! < http://www.ws.pl/Reklama/m.html?s=5 >

