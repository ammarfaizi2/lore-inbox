Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVBQHVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVBQHVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 02:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVBQHVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 02:21:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:59551 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262251AbVBQHVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 02:21:09 -0500
Subject: [PATCH] Check for wraps in copy_page_range
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 17 Feb 2005 18:20:40 +1100
Message-Id: <1108624841.5382.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

While browsing the 4 level page table changes (looking for a bug), I
noticed that copy_page_range, unlike others, do not check for
wraparound, which I suppose could be a problem with 4G/4G architectures
or that sort of thing.

This patch fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/mm/memory.c
===================================================================
--- linux-work.orig/mm/memory.c	2005-02-03 15:48:17.000000000 +1100
+++ linux-work/mm/memory.c	2005-02-16 14:51:37.000000000 +1100
@@ -358,7 +358,7 @@
 
 	for (; addr < end; addr = next, src_pmd++, dst_pmd++) {
 		next = (addr + PMD_SIZE) & PMD_MASK;
-		if (next > end)
+		if (next > end || next <= addr)
 			next = end;
 		if (pmd_none(*src_pmd))
 			continue;
@@ -390,7 +390,7 @@
 
 	for (; addr < end; addr = next, src_pud++, dst_pud++) {
 		next = (addr + PUD_SIZE) & PUD_MASK;
-		if (next > end)
+		if (next > end || next <= addr)
 			next = end;
 		if (pud_none(*src_pud))
 			continue;



