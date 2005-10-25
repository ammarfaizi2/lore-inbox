Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVJYWII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVJYWII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVJYWFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:05:37 -0400
Received: from [151.97.230.9] ([151.97.230.9]:57061 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932431AbVJYWFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:05:32 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 06/11] uml: remove bogus WARN_ON, triggerable harmlessly on a page fault race
Date: Wed, 26 Oct 2005 00:01:41 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025220140.20010.78363.stgit@zion.home.lan>
In-Reply-To: <20051025220053.20010.56979.stgit@zion.home.lan>
References: <20051025220053.20010.56979.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The below warning was added in place of pte_mkyoung(); if (is_write)
pte_mkdirty();

In fact, if the PTE is not marked young/dirty, our dirty/accessed bit emulation
would cause the TLB permission not to be changed, and so we'd loop, and given we
don't support preemption yet, we'd busy-hang here.

However, I've seen this warning trigger without crashes during a loop of
concurrent kernel builds, at random times (i.e. like a race condition), and I
realized that two concurrent faults on the same page, one on read and one on
write, can trigger it. The read fault gets serviced and the PTE gets marked
writable but clean (it's possible on a shared-writable mapping), while the
generic code sees the PTE was already installed and returns without action. In
this case, we'll see another fault and service it normally.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/trap_kern.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -95,7 +95,16 @@ survive:
 		pte = pte_offset_kernel(pmd, address);
 	} while(!pte_present(*pte));
 	err = 0;
+	/* The below warning was added in place of
+	 *	pte_mkyoung(); if (is_write) pte_mkdirty();
+	 * If it's triggered, we'd see normally a hang here (a clean pte is
+	 * marked read-only to emulate the dirty bit).
+	 * However, the generic code can mark a PTE writable but clean on a
+	 * concurrent read fault, triggering this harmlessly. So comment it out.
+	 */
+#if 0
 	WARN_ON(!pte_young(*pte) || (is_write && !pte_dirty(*pte)));
+#endif
 	flush_tlb_page(vma, address);
 out:
 	up_read(&mm->mmap_sem);

