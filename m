Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVHLSFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVHLSFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVHLSFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:05:15 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:57256 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S1750713AbVHLSEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:04:53 -0400
Subject: [patch 1/1] uml: fixes performance regression in activate_mm and thus exec()
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       bcrl@kvack.org
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:59:13 +0200
Message-Id: <20050812175914.2946A24EA14@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Benjamin LaHaise <bcrl@kvack.org>

Normally, activate_mm() is called from exec(), and thus it used to be a no-op
because we use a completely new "MM context" on the host (for instance, a new
process), and so we didn't need to flush any "TLB entries" (which for us are
the set of memory mappings for the host process from the virtual "RAM" file).

Kernel threads, instead, are usually handled in a different way. So, when for
AIO we call use_mm(), things used to break and so Benjamin implemented
activate_mm(). However, that is only needed for AIO, and could slow down
exec() inside UML, so be smart: detect being called for AIO (via PF_BORROWED_MM)
and do the full flush only in that situation.

Comment also the caller so that people won't go breaking UML without noticing.
I also rely on the caller's locks for testing current->flags.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/fs/aio.c                     |    2 ++
 linux-2.6.git-paolo/include/asm-um/mmu_context.h |    8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff -puN include/asm-um/mmu_context.h~uml-optimize-activate-mm include/asm-um/mmu_context.h
--- linux-2.6.git/include/asm-um/mmu_context.h~uml-optimize-activate-mm	2005-08-06 12:53:30.141344264 +0200
+++ linux-2.6.git-paolo/include/asm-um/mmu_context.h	2005-08-06 12:58:49.682766584 +0200
@@ -20,7 +20,13 @@ extern void force_flush_all(void);
 
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 {
-	if (old != new)
+	/* This is called by fs/exec.c and fs/aio.c. In the first case, for an
+	 * exec, we don't need to do anything as we're called from userspace
+	 * and thus going to use a new host PID. In the second, we're called
+	 * from a kernel thread, and thus need to go doing the mmap's on the
+	 * host. Since they're very expensive, we want to avoid that as far as
+	 * possible. */
+	if (old != new && (current->flags & PF_BORROWED_MM))
 		force_flush_all();
 }
 
diff -puN fs/aio.c~uml-optimize-activate-mm fs/aio.c
--- linux-2.6.git/fs/aio.c~uml-optimize-activate-mm	2005-08-06 12:59:14.393010056 +0200
+++ linux-2.6.git-paolo/fs/aio.c	2005-08-06 13:03:07.163623544 +0200
@@ -567,6 +567,8 @@ static void use_mm(struct mm_struct *mm)
 	atomic_inc(&mm->mm_count);
 	tsk->mm = mm;
 	tsk->active_mm = mm;
+	/* Note that on UML this *requires* PF_BORROWED_MM to be set, otherwise
+	 * it won't work. Update it accordingly if you change it here. */
 	activate_mm(active_mm, mm);
 	task_unlock(tsk);
 
_
