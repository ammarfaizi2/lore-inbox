Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422940AbWHZRnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422940AbWHZRnb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422949AbWHZRnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:43:15 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:13437 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1422943AbWHZRmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=fbj42HDgmm6AxfjWAcNP2D/+cgBbOfQAt7uTpi7EeyvTHKzLrgnd8mWyWJejajz1icNa4ayffGMUCn5aDtsVu6Cfxt6zHiouyj1/RQ35Gq7UYSlxtlPKTSGT9hnkaQpUU1LMfKT1dNZJ2mYwmTTpm3UmZhTzkHlMTkOJ+gz67K0=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 10/13] RFP prot support: fix race condition with concurrent faults on same address space
Date: Sat, 26 Aug 2006 19:42:43 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174243.14790.48692.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The one noted by Hugh Dickins. A thread may get a fault because a PTE is absent,
then the PTE could be mapped by another thread, so we'd get a stale
pte_present(); we must check the permissions ourselves.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 mm/memory.c |   47 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e86f6ab..992d877 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2215,24 +2215,33 @@ oom:
 	return VM_FAULT_OOM;
 }
 
-static inline int check_perms(struct vm_area_struct * vma, int access_mask) {
+/* Are the permissions of this PTE insufficient to satisfy the fault described
+ * in access_mask? */
+static inline int insufficient_perms(pte_t pte, int access_mask) {
+	if ((access_mask & VM_WRITE) && !pte_write(pte))
+		goto err;
+	if ((access_mask & VM_READ)  && !pte_read(pte))
+		goto err;
+	if ((access_mask & VM_EXEC)  && !pte_exec(pte))
+		goto err;
+	return 0;
+err:
+	return 1;
+}
+
+static inline int insufficient_vma_perms(struct vm_area_struct * vma, int access_mask) {
 	if (unlikely(vma->vm_flags & VM_MANYPROTS)) {
-		/* we used to check protections in arch handler, but with
-		 * VM_MANYPROTS the check is skipped. */
-		/* access_mask contains the type of the access, vm_flags are the
+		/*
+		 * we used to check protections in arch handler, but with
+		 * VM_MANYPROTS, and only with it, the check is skipped.
+		 * access_mask contains the type of the access, vm_flags are the
 		 * declared protections, pte has the protection which will be
-		 * given to the PTE's in that area. */
+		 * given to the PTE's in that area.
+		 */
 		pte_t pte = pfn_pte(0UL, vma->vm_page_prot);
-		if ((access_mask & VM_WRITE) && !pte_write(pte))
-			goto err;
-		if ((access_mask & VM_READ)  && !pte_read(pte))
-			goto err;
-		if ((access_mask & VM_EXEC)  && !pte_exec(pte))
-			goto err;
+		return insufficient_perms(pte, access_mask);
 	}
 	return 0;
-err:
-	return -EPERM;
 }
 /*
  * Fault of a previously existing named mapping. Repopulate the pte
@@ -2303,7 +2312,7 @@ static inline int handle_pte_fault(struc
 		/* when pte_file(), the VMA protections are useless.  Otherwise,
 		 * we need to check VM_MANYPROTS, because in that case the arch
 		 * fault handler skips the VMA protection check. */
-		if (!pte_file(entry) && check_perms(vma, access_mask))
+		if (!pte_file(entry) && unlikely(insufficient_vma_perms(vma, access_mask)))
 			goto out_segv;
 
 		if (pte_none(entry)) {
@@ -2326,9 +2335,13 @@ static inline int handle_pte_fault(struc
 		goto unlock;
 
 	/* VM_MANYPROTS vma's have PTE's always installed with the correct
-	 * protection. So, generate a SIGSEGV if a fault is caught there. */
-	if (unlikely(vma->vm_flags & VM_MANYPROTS))
-		goto out_segv;
+	 * protection, so if we got a fault on a present PTE we're in trouble.
+	 * However, the pte_present() may simply be the result of a race
+	 * condition with another thread having already fixed the fault. So go
+	 * the slow way. */
+	if (unlikely(vma->vm_flags & VM_MANYPROTS) &&
+ 		unlikely(insufficient_perms(entry, access_mask)))
+			goto out_segv;
 
 	if (write_access) {
 		if (!pte_write(entry))
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
