Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVBQH06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVBQH06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 02:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVBQH06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 02:26:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:64415 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262249AbVBQH04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 02:26:56 -0500
Subject: [PATCH] Fix buf in zeromap_pud_range() losing virtual address
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 17 Feb 2005 18:26:31 +1100
Message-Id: <1108625191.5425.61.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes a nasty bug that took us almost a week to track down on
ppc64, introduced by the 4L page table changes, and resulting in random
memory corruption. All archs that rely on a PTE page's struct page to
contain the mm & address (in mapping/index) will be affected.

zeromap_pud_range() is one of these page tables walking functions that
split the address into a base and an offset. It forgets to add back the
"base" when calling the lower level zeromap_pmd_range(), thus passing a
bogus virtual address. Most archs won't care, unless they do the above,
since the lower level can allocate a PTE page.

Kudo's to Michael Ellerman too who spent that week running tests after
tests to track it down, since the only way we managed to get it to show
up was after about 1 to 2h of LTP runs ...

(Note: We are in _urgent_ need to consolidate all those page table
walking functions, they all do things in a subtely different way, with
different checks (sometimes redudant) and inconsitent with each other,
even within a given set of them. Hopefully, Nick has some work in
progress there).
 
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/mm/memory.c
===================================================================
--- linux-work.orig/mm/memory.c	2005-02-16 14:51:37.000000000 +1100
+++ linux-work/mm/memory.c	2005-02-17 18:11:15.000000000 +1100
@@ -1041,7 +1041,8 @@
 		error = -ENOMEM;
 		if (!pmd)
 			break;
-		error = zeromap_pmd_range(mm, pmd, address, end - address, prot);
+		error = zeromap_pmd_range(mm, pmd, base + address,
+					  end - address, prot);
 		if (error)
 			break;
 		address = (address + PUD_SIZE) & PUD_MASK;


