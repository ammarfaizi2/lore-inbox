Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273966AbRIRXaN>; Tue, 18 Sep 2001 19:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273965AbRIRXaD>; Tue, 18 Sep 2001 19:30:03 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:54313 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272552AbRIRX3w>; Tue, 18 Sep 2001 19:29:52 -0400
Subject: [PATCH] (Resend) AGP GART support for AMD 761
From: Robert Love <rml@tech9.net>
To: laughing@shared-source.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.18.07.08 (Preview Release)
Date: 18 Sep 2001 19:31:16 -0400
Message-Id: <1000855879.19834.47.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, the following is a resend of my patch to add AMD 761 support to
the AGP GART code, originally for 2.4.9-ac10.  If the patch is pending
for a future -ac, I apologize -- although this applies cleaner.


diff -urN linux-2.4.9-ac12/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.9-ac12/Documentation/Configure.help	Tue Sep 18 17:43:45 2001
+++ linux/Documentation/Configure.help	Tue Sep 18 18:54:17 2001
@@ -3091,10 +3091,10 @@
   the GLX component for XFree86 3.3.6, which can be downloaded from
   <http://utah-glx.sourceforge.net/>.
 
-AMD Irongate support
+AMD Irongate and 761 support
 CONFIG_AGP_AMD
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on AMD Irongate chipset.
+  XFree86 4.x on AMD Irongate (750), 761, and 762 chipsets.
 
   For the moment, you should probably say N, unless you want to test
   the GLX component for XFree86 3.3.6, which can be downloaded from
diff -urN linux-2.4.9-ac12/drivers/char/Config.in linux/drivers/char/Config.in
--- linux-2.4.9-ac12/drivers/char/Config.in	Tue Sep 18 17:43:10 2001
+++ linux/drivers/char/Config.in	Tue Sep 18 18:53:28 2001
@@ -208,7 +208,7 @@
    bool '  Intel 440LX/BX/GX and I815/I840/I850 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815 (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
-   bool '  AMD Irongate support' CONFIG_AGP_AMD
+   bool '  AMD Irongate and 761 support' CONFIG_AGP_AMD
    bool '  Generic SiS support' CONFIG_AGP_SIS
    bool '  ALI chipset support' CONFIG_AGP_ALI
    bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
diff -urN linux-2.4.9-ac12/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux-2.4.9-ac12/drivers/char/agp/agp.h	Tue Sep 18 17:43:10 2001
+++ linux/drivers/char/agp/agp.h	Tue Sep 18 18:53:28 2001
@@ -205,6 +205,9 @@
 #ifndef PCI_DEVICE_ID_AMD_762_0
 #define PCI_DEVICE_ID_AMD_762_0		0x700C
 #endif
+#ifndef PCI_DEVICE_ID_AMD_761_0
+#define PCI_DEVICE_ID_AMD_761_0         0x700e
+#endif
 #ifndef PCI_VENDOR_ID_AL
 #define PCI_VENDOR_ID_AL		0x10b9
 #endif
diff -urN linux-2.4.9-ac12/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux-2.4.9-ac12/drivers/char/agp/agpgart_be.c	Tue Sep 18 17:43:10 2001
+++ linux/drivers/char/agp/agpgart_be.c	Tue Sep 18 18:53:28 2001
@@ -387,9 +387,9 @@
 /* 
  * Driver routines - start
  * Currently this module supports the following chipsets:
- * i810, 440lx, 440bx, 440gx, i840, i850, via vp3, via mvp3, via kx133, 
- * via kt133, amd irongate, ALi M1541, and generic support for the SiS 
- * chipsets.
+ * i810, i815, 440lx, 440bx, 440gx, i840, i850, via vp3, via mvp3,
+ * via kx133, via kt133, amd irongate, amd 761, ALi M1541, and generic
+ * support for the SiS chipsets.
  */
 
 /* Generic Agp routines - Start */
@@ -2937,6 +2937,12 @@
 		"AMD",
 		"AMD 760MP",
 		amd_irongate_setup },
+	{ PCI_DEVICE_ID_AMD_761_0,
+		PCI_VENDOR_ID_AMD,
+		AMD_761,
+		"AMD",
+		"761",
+		amd_irongate_setup },
 	{ 0,
 		PCI_VENDOR_ID_AMD,
 		AMD_GENERIC,
@@ -2964,7 +2970,6 @@
 		"Intel",
 		"440GX",
 		intel_generic_setup },
-	/* could we add support for PCI_DEVICE_ID_INTEL_815_1 too ? */
 	{ PCI_DEVICE_ID_INTEL_815_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I815,
diff -urN linux-2.4.9-ac12/include/linux/agp_backend.h linux/include/linux/agp_backend.h
--- linux-2.4.9-ac12/include/linux/agp_backend.h	Tue Sep 18 17:42:55 2001
+++ linux/include/linux/agp_backend.h	Tue Sep 18 18:53:28 2001
@@ -58,6 +58,7 @@
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,
+	AMD_761,
 	ALI_M1541,
 	ALI_M1621,
 	ALI_M1631,


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

