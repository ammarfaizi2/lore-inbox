Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbTAEPiQ>; Sun, 5 Jan 2003 10:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbTAEPiQ>; Sun, 5 Jan 2003 10:38:16 -0500
Received: from tag.witbe.net ([81.88.96.48]:20751 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S264853AbTAEPiN>;
	Sun, 5 Jan 2003 10:38:13 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: [Patch - 2.5] OSS/Emu10k1
Date: Sun, 5 Jan 2003 16:46:47 +0100
Organization: Witbe.net
Message-ID: <013301c2b4d1$a7d872e0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are two patches to avoid compilation warnings for Emu10K1 OSS.

Mainly related to set_bit and al. now requiring a void * parameter.
This patch is just doing type cast.

3 [16:45] rol@donald:/usr/src/linux/sound/oss/emu10k1> diff -urN
efxmgr.c.orig efxmgr.c
--- efxmgr.c.orig       2003-01-05 16:42:37.000000000 +0100
+++ efxmgr.c    2003-01-05 16:41:46.000000000 +0100
@@ -64,7 +64,7 @@
   match:
        for (i = 0; i < NUM_GPRS; i++)
         if (mgr->gpr[i].type == GPR_TYPE_CONTROL &&
-            test_bit(i, gpr_used) &&
+            test_bit(i, (void *)gpr_used) &&
             !strcmp(mgr->gpr[i].name, gpr_name))
                return i;
 

and

7 [16:46] rol@donald:/usr/src/linux/sound/oss/emu10k1> diff -urN
efxmgr.h.orig efxmgr.h
--- efxmgr.h.orig       2003-01-05 16:38:25.000000000 +0100
+++ efxmgr.h    2003-01-05 16:39:53.000000000 +0100
@@ -196,9 +196,9 @@
        patch->code_size = pc * 2 - patch->code_start;      \
 } while(0)
 
-#define CONNECT(input, output) set_bit(input, &rpatch->route[(output) -
OUTPUT_BASE]);
+#define CONNECT(input, output) set_bit(input, (void
*)(&rpatch->route[(output) - OUTPUT_BASE]));
 
-#define CONNECT_V(input, output) set_bit(input,
&rpatch->route_v[(output) - OUTPUT_BASE]);
+#define CONNECT_V(input, output) set_bit(input, (void
*)(&rpatch->route_v[(output) - OUTPUT_BASE]));
 
 #define OUTPUT_PATCH_START(patch, nm, ln, i)    \
 do {                           \
@@ -221,7 +221,7 @@
        mgr->gpr[(g) - GPR_BASE].type = GPR_TYPE_IO;    \
        mgr->gpr[(g) - GPR_BASE].usage++;        \
        mgr->gpr[(g) - GPR_BASE].line = ln;      \
-       set_bit((g) - GPR_BASE, patch->gpr_used);       \
+       set_bit((g) - GPR_BASE, (void *)(patch->gpr_used));     \
 } while(0)
 
 #define GET_INPUT_GPR(patch, g, ln)            \
@@ -229,15 +229,15 @@
        mgr->gpr[(g) - GPR_BASE].type = GPR_TYPE_IO;    \
        mgr->gpr[(g) - GPR_BASE].usage++;        \
        mgr->gpr[(g) - GPR_BASE].line = ln;      \
-       set_bit((g) - GPR_BASE, patch->gpr_used);       \
-       set_bit((g) - GPR_BASE, patch->gpr_input);      \
+       set_bit((g) - GPR_BASE, (void *)(patch->gpr_used));     \
+       set_bit((g) - GPR_BASE, (void *)(patch->gpr_input));    \
 } while(0)
 
 #define GET_DYNAMIC_GPR(patch, g)               \
 do {                            \
        mgr->gpr[(g) - GPR_BASE].type = GPR_TYPE_DYNAMIC;       \
        mgr->gpr[(g) - GPR_BASE].usage++;               \
-       set_bit((g) - GPR_BASE, patch->gpr_used);               \
+       set_bit((g) - GPR_BASE, (void *)(patch->gpr_used));     \
 } while(0)
 
 #define GET_CONTROL_GPR(patch, g, nm, a, b)            \
@@ -248,7 +248,7 @@
        mgr->gpr[(g) - GPR_BASE].min = a;               \
        mgr->gpr[(g) - GPR_BASE].max = b;               \
        sblive_writeptr(card, g, 0, b);          \
-       set_bit((g) - GPR_BASE, patch->gpr_used);        \
+       set_bit((g) - GPR_BASE, (void *)(patch->gpr_used));     \
 } while(0)
 
 #endif /* _EFXMGR_H */

