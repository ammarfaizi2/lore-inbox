Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315235AbSELQfh>; Sun, 12 May 2002 12:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315251AbSELQfg>; Sun, 12 May 2002 12:35:36 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:718 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S315235AbSELQff>;
	Sun, 12 May 2002 12:35:35 -0400
Message-ID: <3CDE9CAD.7314B9D5@2d3d.co.za>
Date: Sun, 12 May 2002 18:47:41 +0200
From: graeme fisher <graeme@2d3d.co.za>
Organization: 2d3d
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo@plucky.distro.conectiva, alan@lxorguk.ukuu.org.uk
Subject: Agpgart for 845G
Content-Type: multipart/mixed;
 boundary="------------397E9AD68128217492CDAE50"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------397E9AD68128217492CDAE50
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Patch for Intel 845G agpgart support

Cheers
Graeme

--------------397E9AD68128217492CDAE50
Content-Type: text/plain; charset=us-ascii;
 name="agp_845G.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="agp_845G.diff"

diff -ruNp linux/drivers/char/agp/agp.h my_linux/drivers/char/agp/agp.h
--- linux/drivers/char/agp/agp.h	Wed Apr 10 00:11:46 2002
+++ my_linux/drivers/char/agp/agp.h	Tue Apr  9 05:15:07 2002
@@ -170,6 +170,12 @@ struct agp_bridge_data {
 #ifndef PCI_DEVICE_ID_INTEL_810_0
 #define PCI_DEVICE_ID_INTEL_810_0       0x7120
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_845_G_0
+#define PCI_DEVICE_ID_INTEL_845_G_0	0x2560
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_845_G_1
+#define PCI_DEVICE_ID_INTEL_845_G_1     0x2562
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_830_M_0
 #define PCI_DEVICE_ID_INTEL_830_M_0	0x3575
 #endif
diff -ruNp linux/drivers/char/agp/agpgart_be.c my_linux/drivers/char/agp/agpgart_be.c
--- linux/drivers/char/agp/agpgart_be.c	Wed Apr 10 00:11:46 2002
+++ my_linux/drivers/char/agp/agpgart_be.c	Tue Apr  9 05:13:23 2002
@@ -3662,6 +3662,12 @@ static struct {
 		"Intel",
 		"i830M",
 		intel_830mp_setup },
+    { PCI_DEVICE_ID_INTEL_845_G_0,
+		 PCI_VENDOR_ID_INTEL,
+		 INTEL_I845_G,
+		 "Intel",
+		 "i845G",
+		 intel_830mp_setup },
 	{ PCI_DEVICE_ID_INTEL_840_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I840,
@@ -3979,6 +3985,28 @@ static int __init agp_find_supported_dev
 			agp_bridge.type = INTEL_I810;
 			return intel_i810_setup(i810_dev);
 
+		case PCI_DEVICE_ID_INTEL_845_G_0:
+			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+					PCI_DEVICE_ID_INTEL_845_G_1, NULL);
+			if(i810_dev && PCI_FUNC(i810_dev->devfn) != 0) {
+				i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+					PCI_DEVICE_ID_INTEL_845_G_1, i810_dev);
+			}
+
+			if (i810_dev == NULL) {
+                                /* 
+                                 * We probably have a I830MP chipset
+                                 * with an external graphics
+                                 * card. It will be initialized later 
+                                 */
+				agp_bridge.type = INTEL_I845_G;
+				break;
+			}
+			printk(KERN_INFO PFX "Detected an Intel "
+				   "845G Chipset.\n");
+			agp_bridge.type = INTEL_I810;
+			return intel_i830_setup(i810_dev);
+		   
 		case PCI_DEVICE_ID_INTEL_830_M_0:
 			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
 					PCI_DEVICE_ID_INTEL_830_M_1, NULL);
--- linux/include/linux/agp_backend.h	Sat Nov 10 00:11:15 2001
+++ my_linux/include/linux/agp_backend.h	Tue Apr  9 05:17:56 2002
@@ -48,6 +48,7 @@ enum chipset_type {
 	INTEL_I815,
 	INTEL_I820,
 	INTEL_I830_M,
+	INTEL_I845_G,
 	INTEL_I840,
 	INTEL_I845,
 	INTEL_I850,

--------------397E9AD68128217492CDAE50--

