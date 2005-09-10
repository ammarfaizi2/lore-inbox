Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVIJSEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVIJSEU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVIJSEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:04:20 -0400
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]:29864 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932216AbVIJSES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:04:18 -0400
Message-Id: <20050910174629.706033000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
Date: Sat, 10 Sep 2005 19:44:58 +0200
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: [patch 6/7] uml: avoid already done dirtying
Content-Disposition: inline; filename=uml-avoid-already-done-dirtying
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PTE returned from handle_mm_fault is already marked as dirty and accessed
if needed.
Also, since this is not set with set_pte() (which sets NEWPAGE and NEWPROT as
needed), this wouldn't work anyway.

This version has been updated and fixed, thanks to some feedback from Jeff Dike.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/trap_kern.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -85,8 +85,7 @@ survive:
 		pte = pte_offset_kernel(pmd, address);
 	} while(!pte_present(*pte));
 	err = 0;
-	*pte = pte_mkyoung(*pte);
-	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
+	WARN_ON(!pte_young(*pte) || (is_write && !pte_dirty(*pte)));
 	flush_tlb_page(vma, address);
 out:
 	up_read(&mm->mmap_sem);

--
