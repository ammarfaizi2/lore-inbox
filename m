Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSLII4M>; Mon, 9 Dec 2002 03:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSLII4M>; Mon, 9 Dec 2002 03:56:12 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:40687 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264743AbSLIIzF>; Mon, 9 Dec 2002 03:55:05 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Make sure the size of a wait-queue hashtable isn't 1
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021209090211.7B8063705@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  9 Dec 2002 18:02:11 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hash_long function in <linux/hash.h> returns bogus results for size
1 hashtables, and wait-queue hashtables can reach that limit for
small-memory systems, so this patch makes the minimum size 4.

This fix was suggested by Andrew Morton.

diff -ruN -X../cludes ../orig/linux-2.5.50-uc0/mm/page_alloc.c mm/page_alloc.c
--- ../orig/linux-2.5.50-uc0/mm/page_alloc.c	2002-11-25 10:30:10.000000000 +0900
+++ mm/page_alloc.c	2002-12-09 11:33:33.000000000 +0900
@@ -961,7 +961,9 @@
 	 */
 	size = min(size, 4096UL);
 
-	return size;
+	/* The `hash_long' function can't handle tables of size 1, so make
+	   sure we don't create one.  */
+	return max(size, 4UL);
 }
 
 /*
