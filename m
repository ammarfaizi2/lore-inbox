Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265964AbUGEJeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbUGEJeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 05:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUGEJds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 05:33:48 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:11689 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265964AbUGEJcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 05:32:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Get rid of lvalue-casts in memset.c to make gcc happy
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040705093210.C27E5492@mctpc71>
Date: Mon,  5 Jul 2004 18:32:10 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/lib/memset.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff -ruN -X../cludes linux-2.6.7-uc0/arch/v850/lib/memset.c linux-2.6.7-uc0-v850-20040705/arch/v850/lib/memset.c
--- linux-2.6.7-uc0/arch/v850/lib/memset.c	2002-11-05 11:25:22.000000000 +0900
+++ linux-2.6.7-uc0-v850-20040705/arch/v850/lib/memset.c	2004-07-05 18:20:43.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/lib/memset.c -- Memory initialization
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,04  NEC Corporation
+ *  Copyright (C) 2001,02,04  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -26,11 +26,13 @@
 
 		/* copy initial unaligned bytes.  */
 		if ((long)ptr & 1) {
-			*((char *)ptr)++ = val;
+			*(char *)ptr = val;
+			ptr = (void *)((char *)ptr + 1);
 			count--;
 		}
 		if (count > 2 && ((long)ptr & 2)) {
-			*((short *)ptr)++ = val;
+			*(short *)ptr = val;
+			ptr = (void *)((short *)ptr + 1);
 			count -= 2;
 		}
 
@@ -46,15 +48,20 @@
 		count %= 32;
 
 		/* long copying loop.  */
-		for (loop = count / 4; loop; loop--)
-			*((long *)ptr)++ = val;
+		for (loop = count / 4; loop; loop--) {
+			*(long *)ptr = val;
+			ptr = (void *)((long *)ptr + 1);
+		}
 		count %= 4;
 
 		/* finish up with any trailing bytes.  */
-		if (count & 2)
-			*((short *)ptr)++ = val;
-		if (count & 1)
+		if (count & 2) {
+			*(short *)ptr = val;
+			ptr = (void *)((short *)ptr + 1);
+		}
+		if (count & 1) {
 			*(char *)ptr = val;
+		}
 	}
 
 	return dst;
