Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbVIBGNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVIBGNz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVIBGNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:13:55 -0400
Received: from mgate03.necel.com ([203.180.232.83]:26047 "EHLO
	mgate03.necel.com") by vger.kernel.org with ESMTP id S1030326AbVIBGNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:13:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Round up length passed to slram driver to a multiple of SLRAM_BLK_SZ
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
From: Miles Bader <miles@gnu.org>
Message-Id: <20050902061330.BEF2B4DC@dhapc248.dev.necel.com>
Date: Fri,  2 Sep 2005 15:13:30 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/setup.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff -ruN -X../cludes linux-2.6.13-uc0/arch/v850/kernel/setup.c linux-2.6.13-uc0-v850-20050902/arch/v850/kernel/setup.c
--- linux-2.6.13-uc0/arch/v850/kernel/setup.c	2005-06-21 16:07:27.095352000 +0900
+++ linux-2.6.13-uc0-v850-20050902/arch/v850/kernel/setup.c	2005-09-02 11:10:57.162581000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/setup.c -- Arch-dependent initialization functions
  *
- *  Copyright (C) 2001,02,03  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,05  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,05  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -98,10 +98,20 @@
 }
 
 #ifdef CONFIG_MTD
+
+/* From drivers/mtd/devices/slram.c */
+#define SLRAM_BLK_SZ 0x4000
+
 /* Set the root filesystem to be the given memory region.
    Some parameter may be appended to CMD_LINE.  */
 void set_mem_root (void *addr, size_t len, char *cmd_line)
 {
+	/* Some sort of idiocy in MTD means we must supply a length that's
+	   a multiple of SLRAM_BLK_SZ.  We just round up the real length,
+	   as the file system shouldn't attempt to access anything beyond
+	   the end of the image anyway.  */
+	len = (((len - 1) + SLRAM_BLK_SZ) / SLRAM_BLK_SZ) * SLRAM_BLK_SZ;
+
 	/* The only way to pass info to the MTD slram driver is via
 	   the command line.  */
 	if (*cmd_line) {
