Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWD3ReU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWD3ReU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWD3RdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:33:20 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:45266 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751198AbWD3Rck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:40 -0400
Message-Id: <20060430173024.959341000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:30:02 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 09/14] remap_file_pages protection support: fix race condition with concurrent faults on same address space
Content-Disposition: inline; filename=rfp/10-rfp-fix-concurrent-faults.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The one noted by Hugh Dickins. A thread may get a fault because a PTE is absent,
then the PTE could be mapped by another thread, so we'd get a stale
pte_present(); we must check the permissions ourselves.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/mm/memory.c
===================================================================
--- linux-2.6.git.orig/mm/memory.c
+++ linux-2.6.git/mm/memory.c
@@ -2261,9 +2261,21 @@ static inline int handle_pte_fault(struc
 		goto unlock;
 
 	/* VM_MANYPROTS vma's have PTE's always installed with the correct
-	 * protection. So, generate a SIGSEGV if a fault is caught there. */
-	if (unlikely(vma->vm_flags & VM_MANYPROTS))
-		goto out_segv;
+	 * protection, so if we got a fault on a present PTE we're in trouble.
+	 * However, the pte_present() may simply be the result of a race
+	 * condition with another thread having already fixed the fault. So go
+	 * the slow way. */
+	if (unlikely(vma->vm_flags & VM_MANYPROTS)) {
+		pgprot_t pgprot = pte_to_pgprot(*pte);
+		pte_t test_entry = pfn_pte(0, pgprot);
+
+		if (unlikely((access_mask & VM_WRITE) && !pte_write(test_entry)))
+			goto out_segv;
+		if (unlikely((access_mask & VM_READ) && !pte_read(test_entry)))
+			goto out_segv;
+		if (unlikely((access_mask & VM_EXEC) && !pte_exec(test_entry)))
+			goto out_segv;
+	}
 
 	if (write_access) {
 		if (!pte_write(entry))

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
