Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316487AbSEUCFI>; Mon, 20 May 2002 22:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316488AbSEUCFI>; Mon, 20 May 2002 22:05:08 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:17051 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S316487AbSEUCFH>; Mon, 20 May 2002 22:05:07 -0400
Message-ID: <3CE9AA73.9080108@didntduck.org>
Date: Mon, 20 May 2002 22:01:23 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpu_has_mmx
Content-Type: multipart/mixed;
 boundary="------------040807060109060702090600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040807060109060702090600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch takes the cpu_has_mmx macro introduced in the xor.h header 
and puts it in the proper place.  It also converts the ov511 driver to 
use the new macro.

-- 

						Brian Gerst

--------------040807060109060702090600
Content-Type: text/plain;
 name="cpu_has_mmx-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu_has_mmx-1"

diff -urN linux-bk/drivers/usb/media/ov511.c linux/drivers/usb/media/ov511.c
--- linux-bk/drivers/usb/media/ov511.c	Wed May 15 10:27:23 2002
+++ linux/drivers/usb/media/ov511.c	Mon May 20 21:24:03 2002
@@ -227,7 +227,11 @@
 static int i2c_detect_tries = 5;
 
 /* MMX support is present in kernel and CPU. Checked upon decomp module load. */
-static int ov51x_mmx_available;
+#if defined(__i386__) || defined(__x86_64__)
+#define ov51x_mmx_available (cpu_has_mmx)
+#else
+#define ov51x_mmx_available (0)
+#endif
 
 static __devinitdata struct usb_device_id device_table [] = {
 	{ USB_DEVICE(VEND_OMNIVISION, PROD_OV511) },
@@ -6473,11 +6477,6 @@
 	if (usb_register(&ov511_driver) < 0)
 		return -1;
 
-#if defined (__i386__)
-	if (test_bit(X86_FEATURE_MMX, boot_cpu_data.x86_capability))
-		ov51x_mmx_available = 1;
-#endif
-
 	info(DRIVER_VERSION " : " DRIVER_DESC);
 
 	return 0;
diff -urN linux-bk/include/asm-i386/processor.h linux/include/asm-i386/processor.h
--- linux-bk/include/asm-i386/processor.h	Wed May 15 10:27:24 2002
+++ linux/include/asm-i386/processor.h	Mon May 20 21:37:42 2002
@@ -84,6 +84,7 @@
 #define cpu_has_de	(test_bit(X86_FEATURE_DE,   boot_cpu_data.x86_capability))
 #define cpu_has_vme	(test_bit(X86_FEATURE_VME,  boot_cpu_data.x86_capability))
 #define cpu_has_fxsr	(test_bit(X86_FEATURE_FXSR, boot_cpu_data.x86_capability))
+#define cpu_has_mmx	(test_bit(X86_FEATURE_MMX,  boot_cpu_data.x86_capability))
 #define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  boot_cpu_data.x86_capability))
 #define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  boot_cpu_data.x86_capability))
 #define cpu_has_apic	(test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
diff -urN linux-bk/include/asm-i386/xor.h linux/include/asm-i386/xor.h
--- linux-bk/include/asm-i386/xor.h	Mon May 20 19:55:09 2002
+++ linux/include/asm-i386/xor.h	Mon May 20 21:25:19 2002
@@ -839,8 +839,6 @@
 /* Also try the generic routines.  */
 #include <asm-generic/xor.h>
 
-#define cpu_has_mmx	(test_bit(X86_FEATURE_MMX,  boot_cpu_data.x86_capability))
-
 #undef XOR_TRY_TEMPLATES
 #define XOR_TRY_TEMPLATES				\
 	do {						\
diff -urN linux-bk/include/asm-x86_64/processor.h linux/include/asm-x86_64/processor.h
--- linux-bk/include/asm-x86_64/processor.h	Wed May 15 10:27:22 2002
+++ linux/include/asm-x86_64/processor.h	Mon May 20 21:26:22 2002
@@ -91,6 +91,7 @@
 #define cpu_has_de 1
 #define cpu_has_vme 1
 #define cpu_has_fxsr 1
+#define cpu_has_mmx 1
 #define cpu_has_xmm 1
 #define cpu_has_apic 1
 

--------------040807060109060702090600--

