Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUHBAgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUHBAgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 20:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbUHBAgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 20:36:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:3474 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266209AbUHBAgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 20:36:33 -0400
Subject: [PATCH] ppc32: Workaround new MPC745x CPU erratas
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1091406817.7394.60.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 10:33:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The latest versions of Motorola erratas for the MPC745x CPUs (and 744x)
adds a couple of nasty ones for which we really want workarounds in the
kernel. One is to disable the BTIC branch target cache on some revs
(too bad for performances...) and the other one is to force cacheable
memory pages to always be marked as SMP coherent even on UP systems (I
didn't measure significant perfs impact with this one).

Please apply,
Ben.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc/kernel/cpu_setup_6xx.S 1.4 vs edited =====
--- 1.4/arch/ppc/kernel/cpu_setup_6xx.S	2004-02-05 15:24:33 +11:00
+++ edited/arch/ppc/kernel/cpu_setup_6xx.S	2004-07-16 02:16:53 +10:00
@@ -218,7 +218,10 @@
 
 	/* All of the bits we have to set.....
 	 */
-	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE | HID0_BTIC | HID0_LRSTK
+	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE | HID0_LRSTK
+BEGIN_FTR_SECTION
+	ori	r11,r11,HID0_BTIC
+END_FTR_SECTION_IFCLR(CPU_FTR_NO_BTIC)
 BEGIN_FTR_SECTION
 	oris	r11,r11,HID0_DPM@h	/* enable dynamic power mgmt */
 END_FTR_SECTION_IFCLR(CPU_FTR_NO_DPM)
===== arch/ppc/kernel/cputable.c 1.23 vs edited =====
--- 1.23/arch/ppc/kernel/cputable.c	2004-06-18 16:41:08 +10:00
+++ edited/arch/ppc/kernel/cputable.c	2004-08-02 10:30:29 +10:00
@@ -55,7 +55,8 @@
 #endif
 
 /* We need to mark all pages as being coherent if we're SMP or we
- * have a 754x and an MPC107 host bridge. */
+ * have a 754x and an MPC107 host bridge.
+ */
 #if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
 #define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
 #else
@@ -263,7 +264,7 @@
 	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -274,7 +275,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP,
+	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -284,7 +285,8 @@
 	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+	CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -294,7 +296,8 @@
 	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS |
+	CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -305,7 +308,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -316,18 +319,40 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
+	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+	32, 32,
+	__setup_cpu_745x
+    },
+    {	/* 7447/7457 Rev 1.0 */
+    	0xffffffff, 0x80020100, "7447/7457",
+	CPU_FTR_COMMON |
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
+	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
+	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+	32, 32,
+	__setup_cpu_745x
+    },
+    {	/* 7447/7457 Rev 1.1 */
+    	0xffffffff, 0x80020101, "7447/7457",
+	CPU_FTR_COMMON |
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
+	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
     },
-    {	/* 7457 */
-    	0xffff0000, 0x80020000, "7457",
+    {	/* 7447/7457 Rev 1.2 and later */
+    	0xffff0000, 0x80020000, "7447/7457",
 	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -338,7 +363,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
===== include/asm-ppc/cputable.h 1.8 vs edited =====
--- 1.8/include/asm-ppc/cputable.h	2004-04-02 01:16:57 +10:00
+++ edited/include/asm-ppc/cputable.h	2004-07-16 02:15:03 +10:00
@@ -76,6 +76,7 @@
 #define CPU_FTR_NO_DPM			0x00008000
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
 #define CPU_FTR_NEED_COHERENT           0x00020000
+#define CPU_FTR_NO_BTIC			0x00040000
 
 #ifdef __ASSEMBLY__
 


