Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262205AbTCYWEA>; Tue, 25 Mar 2003 17:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbTCYWDX>; Tue, 25 Mar 2003 17:03:23 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:1678 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261625AbTCYWBx>; Tue, 25 Mar 2003 17:01:53 -0500
Date: Tue, 25 Mar 2003 22:14:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 05/13 page_convert_anon unlocking
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252214090.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

objrmap page_convert_anon was missing an unlock and an upsem.

--- swap04/mm/rmap.c	Tue Mar 25 20:43:29 2003
+++ swap05/mm/rmap.c	Tue Mar 25 20:43:40 2003
@@ -818,6 +818,7 @@
 	 */
 	if (mapcount < page->pte.mapcount) {
 		pte_chain_unlock(page);
+		up(&mapping->i_shared_sem);
 		goto retry;
 	} else if ((mapcount > page->pte.mapcount) && (mapcount > 1)) {
 		mapcount = page->pte.mapcount;
@@ -833,7 +834,7 @@
 	SetPageAnon(page);
 
 	if (mapcount == 0)
-		goto out;
+		goto out_unlock;
 	else if (mapcount == 1) {
 		SetPageDirect(page);
 		page->pte.direct = 0;

