Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130617AbRCLUte>; Mon, 12 Mar 2001 15:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130621AbRCLUtY>; Mon, 12 Mar 2001 15:49:24 -0500
Received: from pc30.tromso2.avidi.online.no ([148.122.16.30]:18446 "EHLO
	shogun.thule.no") by vger.kernel.org with ESMTP id <S130617AbRCLUtH>;
	Mon, 12 Mar 2001 15:49:07 -0500
Message-ID: <3AAD35F4.61F47450@thule.no>
Date: Mon, 12 Mar 2001 21:47:48 +0100
From: Troels Walsted Hansen <troels@thule.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-10mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, davej@suse.de
Subject: [PATCH] Fix MTRR support for AMD Athlon
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello world,

Dave Jones' recent 2.4.2ac17 patch to mtrr.c to support the Cyrix III
unfortunately broke the AMD Athlon support. Here's a patch to correct
the problem (Dave must have overlooked the fall-through logic of the
switch statement).

Enjoy...

-- 
Troels Walsted Hansen

--- mtrr.c1.38  Sun Mar 11 13:42:30 2001
+++ mtrr.c      Mon Mar 12 21:02:15 2001
@@ -235,6 +235,12 @@
   v1.38
     20010309   Dave Jones <davej@suse.de>
               Add support for Cyrix III.
+
+  v1.39
+    20010312   Troels Walsted Hansen <troels@thule.no>
+              Fixed the AMD Athlon support that Dave Jones' patch
broke.
+              Also updated the version number to match this changelog.
+
 */
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -274,7 +280,7 @@
 #include <asm/hardirq.h>
 #include <linux/irq.h>
 
-#define MTRR_VERSION            "1.37 (20001109)"
+#define MTRR_VERSION            "1.39 (20010312)"
 
 #define TRUE  1
 #define FALSE 0
@@ -1964,6 +1970,14 @@
        get_mtrr = intel_get_mtrr;
        set_mtrr_up = intel_set_mtrr_up;
        switch (boot_cpu_data.x86_vendor) {
+       case X86_VENDOR_CENTAUR:
+               /* Cyrix III has Intel style MTRRs, but doesn't support
PAE */
+               if (boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model ==
6) {
+                       size_or_mask  = 0xfff00000; /* 32 bits */
+                       size_and_mask = 0;
+               }
+               break;
+
        case X86_VENDOR_AMD:
                /* The original Athlon docs said that
                   total addressable memory is 44 bits wide.
@@ -1982,13 +1996,7 @@
                        size_and_mask = ~size_or_mask & 0xfff00000;
                        break;
                }
-       case X86_VENDOR_CENTAUR:
-               /* Cyrix III has Intel style MTRRs, but doesn't support
PAE */
-               if (boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model ==
6) {
-                       size_or_mask  = 0xfff00000; /* 32 bits */
-                       size_and_mask = 0;
-               }
-               break;
+               /* NOTE: fallthrough to default here! */
 
        default:
                /* Intel, etc. */
