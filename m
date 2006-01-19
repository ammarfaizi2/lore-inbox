Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbWASSVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWASSVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWASSVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:21:06 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:12767 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1161147AbWASSVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:21:05 -0500
Subject: [patch 1/1] selinux: fix and cleanup mprotect checks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 19 Jan 2006 13:26:25 -0500
Message-Id: <1137695185.3648.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the SELinux mprotect checks on executable mappings so
that they are not re-applied when the mapping is already executable as
well as cleaning up the code.  This avoids a situation where e.g. an
application is prevented from removing PROT_WRITE on an already
executable mapping previously authorized via execmem permission due to
an execmod denial.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: James Morris <jmorris@namei.org>

---

 security/selinux/hooks.c |   50 +++++++++++++++++++----------------------------
 1 files changed, 21 insertions(+), 29 deletions(-)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.175
diff -u -p -r1.175 hooks.c
--- linux-2.6/security/selinux/hooks.c	3 Jan 2006 16:36:59 -0000	1.175
+++ linux-2.6/security/selinux/hooks.c	18 Jan 2006 18:27:18 -0000
@@ -2453,35 +2453,27 @@ static int selinux_file_mprotect(struct 
 		prot = reqprot;
 
 #ifndef CONFIG_PPC32
-	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXECUTABLE) &&
-	   (vma->vm_start >= vma->vm_mm->start_brk &&
-	    vma->vm_end <= vma->vm_mm->brk)) {
-	    	/*
-		 * We are making an executable mapping in the brk region.
-		 * This has an additional execheap check.
-		 */
-		rc = task_has_perm(current, current, PROCESS__EXECHEAP);
-		if (rc)
-			return rc;
-	}
-	if (vma->vm_file != NULL && vma->anon_vma != NULL && (prot & PROT_EXEC)) {
-		/*
-		 * We are making executable a file mapping that has
-		 * had some COW done. Since pages might have been written,
-		 * check ability to execute the possibly modified content.
-		 * This typically should only occur for text relocations.
-		 */
-		int rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
-		if (rc)
-			return rc;
-	}
-	if (!vma->vm_file && (prot & PROT_EXEC) &&
-		vma->vm_start <= vma->vm_mm->start_stack &&
-		vma->vm_end >= vma->vm_mm->start_stack) {
-		/* Attempt to make the process stack executable.
-		 * This has an additional execstack check.
-		 */
-		rc = task_has_perm(current, current, PROCESS__EXECSTACK);
+	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
+		rc = 0;
+		if (vma->vm_start >= vma->vm_mm->start_brk &&
+		    vma->vm_end <= vma->vm_mm->brk) {
+			rc = task_has_perm(current, current,
+					   PROCESS__EXECHEAP);
+		} else if (!vma->vm_file &&
+			   vma->vm_start <= vma->vm_mm->start_stack &&
+			   vma->vm_end >= vma->vm_mm->start_stack) {
+			rc = task_has_perm(current, current, PROCESS__EXECSTACK);
+		} else if (vma->vm_file && vma->anon_vma) {
+			/*
+			 * We are making executable a file mapping that has
+			 * had some COW done. Since pages might have been
+			 * written, check ability to execute the possibly
+			 * modified content.  This typically should only
+			 * occur for text relocations.
+			 */
+			rc = file_has_perm(current, vma->vm_file,
+					   FILE__EXECMOD);
+		}
 		if (rc)
 			return rc;
 	}





-- 
Stephen Smalley
National Security Agency

