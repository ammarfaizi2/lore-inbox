Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273012AbRIOTse>; Sat, 15 Sep 2001 15:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273013AbRIOTsZ>; Sat, 15 Sep 2001 15:48:25 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:8505 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S273012AbRIOTsN>; Sat, 15 Sep 2001 15:48:13 -0400
Subject: Re: [PATCH] AGP GART for AMD 761
From: Robert Love <rml@tech9.net>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA228EA.FCD61CA1@eisenstein.dk>
In-Reply-To: <1000577021.32706.29.camel@phantasy> 
	<3BA22537.94D4EA28@eisenstein.dk> <1000582067.32708.51.camel@phantasy> 
	<3BA228EA.FCD61CA1@eisenstein.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 15:49:15 -0400
Message-Id: <1000583357.32707.54.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-14 at 11:57, Jesper Juhl wrote:
> bash-2.05# /sbin/lspci -n -v -s 0:0
> 00:00.0 Class 0600: 1022:700e (rev 13)

Thanks.  Ca you try the attached patch? It should fall back on
try_unsupported if it can't find the 761.  Please send the relevant
dmesg in reply.  Thank you.


diff -urN linux-2.4.10-pre9/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.10-pre9/Documentation/Configure.help	Thu Sep 13 21:03:36 2001
+++ linux/Documentation/Configure.help	Fri Sep 14 22:28:37 2001
@@ -2581,7 +2581,7 @@
 AMD Irongate support
 CONFIG_AGP_AMD
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on AMD Irongate chipset.
+  XFree86 4.x on AMD Irongate and 761 chipsets.
 
   For the moment, you should probably say N, unless you want to test
   the GLX component for XFree86 3.3.6, which can be downloaded from
diff -urN linux-2.4.10-pre9/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux-2.4.10-pre9/drivers/char/agp/agp.h	Thu Sep 13 21:03:40 2001
+++ linux/drivers/char/agp/agp.h	Sat Sep 15 15:33:06 2001
@@ -196,6 +196,9 @@
 #ifndef PCI_DEVICE_ID_AMD_IRONGATE_0
 #define PCI_DEVICE_ID_AMD_IRONGATE_0    0x7006
 #endif
+#ifndef PCI_DEVICE_ID_AMD_761_0
+#define PCI_DEVICE_ID_AMD_761_0		0x700e
+#endif
 #ifndef PCI_VENDOR_ID_AL
 #define PCI_VENDOR_ID_AL		0x10b9
 #endif
diff -urN linux-2.4.10-pre9/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux-2.4.10-pre9/drivers/char/agp/agpgart_be.c	Thu Sep 13 21:03:40 2001
+++ linux/drivers/char/agp/agpgart_be.c	Sat Sep 15 15:36:26 2001
@@ -60,7 +60,7 @@
 static void flush_cache(void);
 
 static struct agp_bridge_data agp_bridge;
-static int agp_try_unsupported __initdata = 0;
+static int agp_try_unsupported __initdata = 1;
 
 
 static inline void flush_cache(void)
@@ -2895,6 +2895,12 @@
 		"AMD",
 		"Irongate",
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
@@ -2922,7 +2928,6 @@
 		"Intel",
 		"440GX",
 		intel_generic_setup },
-	/* could we add support for PCI_DEVICE_ID_INTEL_815_1 too ? */
 	{ PCI_DEVICE_ID_INTEL_815_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I815,
diff -urN linux-2.4.10-pre9/include/linux/agp_backend.h linux/include/linux/agp_backend.h
--- linux-2.4.10-pre9/include/linux/agp_backend.h	Thu Sep 13 21:03:50 2001
+++ linux/include/linux/agp_backend.h	Fri Sep 14 22:27:34 2001
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

