Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUIKU41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUIKU41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268321AbUIKUyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:54:45 -0400
Received: from hcc022004.bai.ne.jp ([210.171.22.4]:44169 "HELO
	tigger.internet.email.ne.jp") by vger.kernel.org with SMTP
	id S268315AbUIKUvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:51:24 -0400
Date: Sun, 12 Sep 2004 05:51:23 +0900 (JST)
Message-Id: <20040912.055123.719890756.takata@linux-m32r.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm4 6/6] [m32r] Update CF/PCMCIA drivers
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
In-Reply-To: <20040912.052403.730551818.takata@linux-m32r.org>
References: <20040912.052403.730551818.takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.9-rc1-mm4 6/6] [m32r] Update CF/PCMCIA drivers
  This patch updates m32r-specific CF/PCMCIA drivers and 
  fixes compile errors.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/drivers/m32r_cfc.c |   14 +++++++-------
 arch/m32r/drivers/m32r_pcc.c |   25 ++++++++++++++-----------
 2 files changed, 21 insertions(+), 18 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/drivers/m32r_cfc.c linux-2.6.9-rc1-mm4/arch/m32r/drivers/m32r_cfc.c
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/drivers/m32r_cfc.c	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/drivers/m32r_cfc.c	2004-09-12 01:53:40.000000000 +0900
@@ -4,7 +4,7 @@
  *  Device driver for the CFC functionality of M32R.
  *
  *  Copyright (c) 2001, 2002, 2003, 2004
- *   Hiroyuki Kondo, Sugai Naotom, Hayato Fujiwara
+ *    Hiroyuki Kondo, Naoto Sugai, Hayato Fujiwara
  */
 
 #include <linux/module.h>
@@ -592,15 +592,15 @@ static int _pcc_set_mem_map(u_short sock
 	u_long addr;
 	pcc_socket_t *t = &socket[sock];
 
-	DEBUG(3, "m32r_cfc: SetMemMap(%d, %d, %#2.2x, %d ns, %#5.5lx-%#5.5"
-		  "lx, %#5.5x)\n", sock, map, mem->flags, mem->speed,
-		  mem->sys_start, mem->sys_stop, mem->card_start);
+	DEBUG(3, "m32r_cfc: SetMemMap(%d, %d, %#2.2x, %d ns, "
+		 "%#5.5lx-%#5.5lx, %#5.5x)\n", sock, map, mem->flags,
+		 mem->speed, mem->res->start, mem->res->end, mem->card_start);
 
 	/*
 	 * sanity check
 	 */
 	if ((map > MAX_WIN) || (mem->card_start > 0x3ffffff) ||
-		(mem->sys_start > mem->sys_stop)) {
+		(mem->res->start > mem->res->end)) {
 		return -EINVAL;
 	}
 
@@ -635,8 +635,8 @@ static int _pcc_set_mem_map(u_short sock
 	addr = t->mapaddr + (mem->card_start & M32R_PCC_MAPMASK);
 //	pcc_set(sock, PCADR, addr);
 
-	mem->sys_start = addr + mem->card_start;
-	mem->sys_stop = mem->sys_start + (M32R_PCC_MAPSIZE - 1);
+	mem->res->start = addr + mem->card_start;
+	mem->res->end = mem->res->start + (M32R_PCC_MAPSIZE - 1);
 
 	/*
 	 * Set timing
diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/drivers/m32r_pcc.c linux-2.6.9-rc1-mm4/arch/m32r/drivers/m32r_pcc.c
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/drivers/m32r_pcc.c	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/drivers/m32r_pcc.c	2004-09-12 01:53:54.000000000 +0900
@@ -1,8 +1,11 @@
-/*======================================================================
-
-	Device driver for the PCMCIA functionality of M32R.
-
-======================================================================*/
+/*
+ *  linux/arch/m32r/drivers/m32r_pcc.c
+ *
+ *  Device driver for the PCMCIA functionality of M32R.
+ *
+ *  Copyright (c) 2001, 2002, 2003, 2004
+ *    Hiroyuki Kondo, Naoto Sugai, Hayato Fujiwara
+ */
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -524,15 +527,15 @@ static int _pcc_set_mem_map(u_short sock
 #endif
 #endif
 
-	DEBUG(3, "m32r-pcc: SetMemMap(%d, %d, %#2.2x, %d ns, %#5.5lx-%#5.5"
-		  "lx, %#5.5x)\n", sock, map, mem->flags, mem->speed,
-		  mem->sys_start, mem->sys_stop, mem->card_start);
+	DEBUG(3, "m32r-pcc: SetMemMap(%d, %d, %#2.2x, %d ns, "
+		 "%#5.5lx-%#5.5lx, %#5.5x)\n", sock, map, mem->flags,
+		 mem->speed, mem->res->start,  mem->res->end, mem->card_start);
 
 	/*
 	 * sanity check
 	 */
 	if ((map > MAX_WIN) || (mem->card_start > 0x3ffffff) ||
-		(mem->sys_start > mem->sys_stop)) {
+		(mem->res->start > mem->res->end)) {
 		return -EINVAL;
 	}
 
@@ -567,8 +570,8 @@ static int _pcc_set_mem_map(u_short sock
 	addr = t->mapaddr + (mem->card_start & M32R_PCC_MAPMASK);
 	pcc_set(sock, PCADR, addr);
 
-	mem->sys_start = addr + mem->card_start;
-	mem->sys_stop = mem->sys_start + (M32R_PCC_MAPSIZE - 1);
+	mem->res->start = addr + mem->card_start;
+	mem->res->end = mem->res->start + (M32R_PCC_MAPSIZE - 1);
 
 	/*
 	 * Enable again

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
