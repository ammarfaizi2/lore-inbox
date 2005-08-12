Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVHLSxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVHLSxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVHLStS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:18 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:29607 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S1751018AbVHLStE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:49:04 -0400
Subject: [patch 34/39] remap_file_pages protection support: restrict permission testing
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:25 +0200
Message-Id: <20050812183625.B1A1B24E7E6@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Yet to test. Currently we install a PTE when one is missing
irrispective of the fault type, and if the access type is prohibited we'll
get another fault and kill the process only then. With this, we check the
access type on the 1st fault.

We could also use this code for testing present PTE's, if the current
assumption (fault on present PTE's in VM_NONUNIFORM vma's means access violation)
proves problematic for architectures other than UML (which I already fixed),
but I hope it's not needed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/memory.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)

diff -puN mm/memory.c~rfp-fault-sigsegv-3 mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-fault-sigsegv-3	2005-08-12 17:19:17.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-12 17:19:17.000000000 +0200
@@ -1963,6 +1963,7 @@ static int do_file_page(struct mm_struct
 	unsigned long pgoff;
 	pgprot_t pgprot;
 	int err;
+	pte_t test_entry;
 
 	BUG_ON(!vma->vm_ops || !vma->vm_ops->nopage);
 	/*
@@ -1983,6 +1984,21 @@ static int do_file_page(struct mm_struct
 	pgoff = pte_to_pgoff(*pte);
 	pgprot = vma->vm_flags & VM_NONUNIFORM ? pte_to_pgprot(*pte): vma->vm_page_prot;
 
+	/* If this is not enabled, we'll get another fault after return next
+	 * time, check we handle that one, and that this code works. */
+#if 1
+	/* We just want to test pte_{read,write,exec} */
+	test_entry = mk_pte(0, pgprot);
+	if (unlikely(vma->vm_flags & VM_NONUNIFORM) && !pte_file(*pte)) {
+		if ((access_mask & VM_WRITE) && !pte_write(test_entry))
+			goto out_segv;
+		if ((access_mask & VM_READ) && !pte_read(test_entry))
+			goto out_segv;
+		if ((access_mask & VM_EXEC) && !pte_exec(test_entry))
+			goto out_segv;
+	}
+#endif
+
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
 
_
