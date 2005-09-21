Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVIURsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVIURsy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVIURsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:48:54 -0400
Received: from [151.97.230.9] ([151.97.230.9]:10691 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751332AbVIURsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:48:53 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 05/10] uml: fix condition in tlb flush
Date: Wed, 21 Sep 2005 19:28:49 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921172849.10219.44320.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Avoid setting w = 0 twice. Spotted this (trivial) thing which is needed for
another patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/tlb.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -193,12 +193,12 @@ void fix_range_common(struct mm_struct *
                 r = pte_read(*npte);
                 w = pte_write(*npte);
                 x = pte_exec(*npte);
-                if(!pte_dirty(*npte))
-                        w = 0;
-                if(!pte_young(*npte)){
-                        r = 0;
-                        w = 0;
-                }
+		if (!pte_young(*npte)) {
+			r = 0;
+			w = 0;
+		} else if (!pte_dirty(*npte)) {
+			w = 0;
+		}
                 if(force || pte_newpage(*npte)){
                         if(pte_present(*npte))
 			  ret = add_mmap(addr,

