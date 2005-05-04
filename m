Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVEDENz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVEDENz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 00:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVEDENz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 00:13:55 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:20707 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262007AbVEDENv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 00:13:51 -0400
Date: Tue, 3 May 2005 21:52:19 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: Simplified PPC core revision report
Message-ID: <Pine.LNX.4.61.0505032150260.19926@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can identify new Freescale PPC cores by the fact that the MSB of the PVR is
set.  If we are a new Freescale core the decode of major/minor revision numbers
is simplified so we dont have to add new case checks for a every new Freescale
core.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 1ecd8eef1f05b100f3933a7de25f88a3314b0a97
tree 739c8916a8f4edd214007de1dd8610d0e1c49235
parent cc75b79f8142eb8a50432cf612bb1ab189136cd0
author Kumar K. Gala <kumar.gala@freescale.com> 1115174649 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> 1115174649 -0500

Index: arch/ppc/kernel/setup.c
===================================================================
--- 79fd2184cd5cfee440f3ca2952f7c9f834ece443/arch/ppc/kernel/setup.c  (mode:100644 sha1:e97ce635b99e6d84640457c775c77d7eb49f4efb)
+++ 739c8916a8f4edd214007de1dd8610d0e1c49235/arch/ppc/kernel/setup.c  (mode:100644 sha1:5dfb42f1a1529d561bf73b5b5c1411a3e51f6402)
@@ -221,27 +221,26 @@
 			return err;
 	}
 
-	switch (PVR_VER(pvr)) {
-	case 0x0020:	/* 403 family */
-		maj = PVR_MAJ(pvr) + 1;
-		min = PVR_MIN(pvr);
-		break;
-	case 0x1008:	/* 740P/750P ?? */
-		maj = ((pvr >> 8) & 0xFF) - 1;
-		min = pvr & 0xFF;
-		break;
-	case 0x8083:	/* e300 */
-		maj = PVR_MAJ(pvr);
-		min = PVR_MIN(pvr);
-		break;
-	case 0x8020:	/* e500 */
+	/* If we are a Freescale core do a simple check so
+	 * we dont have to keep adding cases in the future */
+	if ((PVR_VER(pvr) & 0x8000) == 0x8000) {
 		maj = PVR_MAJ(pvr);
 		min = PVR_MIN(pvr);
-		break;
-	default:
-		maj = (pvr >> 8) & 0xFF;
-		min = pvr & 0xFF;
-		break;
+	} else {
+		switch (PVR_VER(pvr)) {
+			case 0x0020:	/* 403 family */
+				maj = PVR_MAJ(pvr) + 1;
+				min = PVR_MIN(pvr);
+				break;
+			case 0x1008:	/* 740P/750P ?? */
+				maj = ((pvr >> 8) & 0xFF) - 1;
+				min = pvr & 0xFF;
+				break;
+			default:
+				maj = (pvr >> 8) & 0xFF;
+				min = pvr & 0xFF;
+				break;
+		}
 	}
 
 	seq_printf(m, "revision\t: %hd.%hd (pvr %04x %04x)\n",
