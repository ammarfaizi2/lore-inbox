Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVIURur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVIURur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVIURuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:50:00 -0400
Received: from [151.97.230.9] ([151.97.230.9]:12739 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751345AbVIURs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:48:56 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 07/10] uml: avoid fixing faults while atomic
Date: Wed, 21 Sep 2005 19:29:08 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921172908.10219.57644.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Following i386, we should maybe refuse trying to fault in pages when we're
doing atomic operations, because to handle the fault we could need to take
already taken spinlocks.

Also, if we're doing an atomic operation (in the sense of in_atomic()) we're
surely in kernel mode and we're surely going to handle adequately the failed
fault, so it's safe to behave this way.

Currently, on UML SMP is rarely used, and we don't support PREEMPT, so this is
unlikely to create problems right now, but it might in the future.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/trap_kern.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -40,6 +40,12 @@ int handle_page_fault(unsigned long addr
 	int err = -EFAULT;
 
 	*code_out = SEGV_MAPERR;
+
+	/* If the fault was during atomic operation, don't take the fault, just
+	 * fail. */
+	if (in_atomic())
+		goto out_nosemaphore;
+
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if(!vma) 
@@ -90,6 +96,7 @@ survive:
 	flush_tlb_page(vma, address);
 out:
 	up_read(&mm->mmap_sem);
+out_nosemaphore:
 	return(err);
 
 /*

