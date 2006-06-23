Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751937AbWFWSmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWFWSmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWFWSlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:41:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17103 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751915AbWFWSlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:50 -0400
Message-Id: <20060623183909.915517000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:30:59 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/21] fix __iounmap for 030
Content-Disposition: inline; filename=0003-M68K-fix-__iounmap-for-030.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore empty pmd entry during iomap (these are the holes between the
mappings).

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/mm/kmap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

2a02d299d6158fb1cba1a2e7f0a446619db91648
diff --git a/arch/m68k/mm/kmap.c b/arch/m68k/mm/kmap.c
index 85ad19a..43ffab0 100644
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -259,13 +259,15 @@ void __iounmap(void *addr, unsigned long
 
 		if (CPU_IS_020_OR_030) {
 			int pmd_off = (virtaddr/PTRTREESIZE) & 15;
+			int pmd_type = pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK;
 
-			if ((pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK) == _PAGE_PRESENT) {
+			if (pmd_type == _PAGE_PRESENT) {
 				pmd_dir->pmd[pmd_off] = 0;
 				virtaddr += PTRTREESIZE;
 				size -= PTRTREESIZE;
 				continue;
-			}
+			} else if (pmd_type == 0)
+				continue;
 		}
 
 		if (pmd_bad(*pmd_dir)) {
-- 
1.3.3

--

