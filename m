Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317006AbSEWUvG>; Thu, 23 May 2002 16:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317007AbSEWUvF>; Thu, 23 May 2002 16:51:05 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:65267 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317006AbSEWUvF>; Thu, 23 May 2002 16:51:05 -0400
Date: Thu, 23 May 2002 16:51:05 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@redhat.com
Subject: [PATCH] 2.4.19-pre8 vm86 smp locking fix
Message-ID: <20020523165105.A27881@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/vm86.c performs page table operations without obtaining 
any locks.  This patch obtains page_table_lock around the the table walk 
and modification.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."


diff -urN v2.4.19-pre8/arch/i386/kernel/vm86.c work/arch/i386/kernel/vm86.c
--- v2.4.19-pre8/arch/i386/kernel/vm86.c	Thu Mar  7 16:39:56 2002
+++ work/arch/i386/kernel/vm86.c	Thu May 23 16:21:38 2002
@@ -97,21 +97,22 @@
 	pte_t *pte;
 	int i;
 
+	spin_lock(&tsk->mm->page_table_lock);
 	pgd = pgd_offset(tsk->mm, 0xA0000);
 	if (pgd_none(*pgd))
-		return;
+		goto out;
 	if (pgd_bad(*pgd)) {
 		pgd_ERROR(*pgd);
 		pgd_clear(pgd);
-		return;
+		goto out;
 	}
 	pmd = pmd_offset(pgd, 0xA0000);
 	if (pmd_none(*pmd))
-		return;
+		goto out;
 	if (pmd_bad(*pmd)) {
 		pmd_ERROR(*pmd);
 		pmd_clear(pmd);
-		return;
+		goto out;
 	}
 	pte = pte_offset(pmd, 0xA0000);
 	for (i = 0; i < 32; i++) {
@@ -119,6 +120,8 @@
 			set_pte(pte, pte_wrprotect(*pte));
 		pte++;
 	}
+out:
+	spin_unlock(&tsk->mm->page_table_lock);
 	flush_tlb();
 }
 
