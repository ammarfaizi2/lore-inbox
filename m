Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBNNJE>; Wed, 14 Feb 2001 08:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129681AbRBNNIy>; Wed, 14 Feb 2001 08:08:54 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:4058 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129055AbRBNNIt>; Wed, 14 Feb 2001 08:08:49 -0500
Date: Wed, 14 Feb 2001 12:57:00 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] vmalloc fault race
Message-ID: <Pine.LNX.4.21.0102141232550.11260-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  If two processes, sharing the same page tables, hit an unloaded vmalloc
address in the kernel at the same time, one of the processes is killed
(with the message "Unable to handle kernel paging request").

  This occurs because the test on a vmalloc fault is too tight.  On x86,
it contains;
	if (pmd_present(*pmd) || !pmd_present(*pmd_k))
		goto bad_area_nosemaphore;

  If two processes are racing, chances are that "pmd_present(*pmd)" will
be true for one of them.

  It appears that; alpha, x86, arm, cris and sparc all have the
same/similar test.
  I've included a patch for all the above archs, but have only tested on
the x86 (so no guarantee it is correct for other archs).

  Note: Even though this race can only occur on SMP (assuming cannot
context switch on entering a page-fault), I've unconditionally remove the
test against pmd.  It could be argued that it should be left in for UP...

  Patch is againt 2.4.2pre3.

Mark


diff -urN -X dontdiff vxfs-2.4.2pre3/arch/alpha/mm/fault.c markhe-2.4.2pre3/arch/alpha/mm/fault.c
--- vxfs-2.4.2pre3/arch/alpha/mm/fault.c	Fri Dec 29 22:07:19 2000
+++ markhe-2.4.2pre3/arch/alpha/mm/fault.c	Wed Feb 14 12:10:21 2001
@@ -223,7 +223,7 @@
 
 		pgd = current->active_mm->pgd + offset;
 		pgd_k = swapper_pg_dir + offset;
-		if (!pgd_present(*pgd) && pgd_present(*pgd_k)) {
+		if (pgd_present(*pgd_k)) {
 			pgd_val(*pgd) = pgd_val(*pgd_k);
 			return;
 		}
diff -urN -X dontdiff vxfs-2.4.2pre3/arch/arm/mm/fault-common.c markhe-2.4.2pre3/arch/arm/mm/fault-common.c
--- vxfs-2.4.2pre3/arch/arm/mm/fault-common.c	Mon Feb 12 10:10:27 2001
+++ markhe-2.4.2pre3/arch/arm/mm/fault-common.c	Wed Feb 14 12:12:13 2001
@@ -185,8 +185,6 @@
 		goto bad_area;
 
 	pmd = pmd_offset(pgd, addr);
-	if (!pmd_none(*pmd))
-		goto bad_area;
 	set_pmd(pmd, *pmd_k);
 	return 1;
 
diff -urN -X dontdiff vxfs-2.4.2pre3/arch/cris/mm/fault.c markhe-2.4.2pre3/arch/cris/mm/fault.c
--- vxfs-2.4.2pre3/arch/cris/mm/fault.c	Mon Feb 12 10:10:27 2001
+++ markhe-2.4.2pre3/arch/cris/mm/fault.c	Wed Feb 14 12:13:10 2001
@@ -381,7 +381,7 @@
                 pmd = pmd_offset(pgd, address);
                 pmd_k = pmd_offset(pgd_k, address);
 
-                if (pmd_present(*pmd) || !pmd_present(*pmd_k))
+                if (!pmd_present(*pmd_k))
                         goto bad_area_nosemaphore;
                 set_pmd(pmd, *pmd_k);
                 return;
diff -urN -X dontdiff vxfs-2.4.2pre3/arch/i386/mm/fault.c markhe-2.4.2pre3/arch/i386/mm/fault.c
--- vxfs-2.4.2pre3/arch/i386/mm/fault.c	Sun Nov 12 03:01:11 2000
+++ markhe-2.4.2pre3/arch/i386/mm/fault.c	Wed Feb 14 12:14:13 2001
@@ -340,7 +340,7 @@
 		pmd = pmd_offset(pgd, address);
 		pmd_k = pmd_offset(pgd_k, address);
 
-		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
+		if (!pmd_present(*pmd_k))
 			goto bad_area_nosemaphore;
 		set_pmd(pmd, *pmd_k);
 		return;
diff -urN -X dontdiff vxfs-2.4.2pre3/arch/sparc/mm/fault.c markhe-2.4.2pre3/arch/sparc/mm/fault.c
--- vxfs-2.4.2pre3/arch/sparc/mm/fault.c	Mon Jan  1 18:37:41 2001
+++ markhe-2.4.2pre3/arch/sparc/mm/fault.c	Wed Feb 14 12:17:36 2001
@@ -378,7 +378,7 @@
 		pmd = pmd_offset(pgd, address);
 		pmd_k = pmd_offset(pgd_k, address);
 
-		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
+		if (!pmd_present(*pmd_k))
 			goto bad_area_nosemaphore;
 		pmd_val(*pmd) = pmd_val(*pmd_k);
 		return;

