Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVCORqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVCORqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVCORpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:45:15 -0500
Received: from fmr14.intel.com ([192.55.52.68]:39605 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261688AbVCORnh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:43:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Mprotect needs arch hook for updated PTE settings
Date: Tue, 15 Mar 2005 09:43:31 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB75064943032C6020@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mprotect needs arch hook for updated PTE settings
Thread-Index: AcUphoDRdJF1bICmQzGcWR3G0rJPGQ==
From: "Seth, Rohit" <rohit.seth@intel.com>
To: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <davidm@hpl.hp.com>
X-OriginalArrivalTime: 15 Mar 2005 17:43:33.0985 (UTC) FILETIME=[82639D10:01C52986]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently on IA-64, we have found an issue where old data could be used
by apps.  The sequence of operations includes few mprotects from user
space (glibc) goes like this:

1- The text region of an executable is mmaped using PROT_READ|PROT_EXEC.
As a result, a shared page is allocated to user.

2- User then requests the text region to be mprotected with
PROT_READ|PROT_WRITE.   Kernel removes the execute permission and leave
the read permission on the text region.

3- Subsequent write operation by user results in page fault and
eventually resulting in COW break. User gets a new private copy of the
page.  At this point kernel marks the new page for defered flush. 

4- User then request the text region to be mprotected back with
PROT_READ|PROT_EXEC.  mprotect suppport code in kernel, flushes the
caches, updates the PTEs and then flushes the TLBs.  Though after
updating the PTEs  with new permissions,  we don't let the arch specific
code know about the new mappings (through update_mmu_cache like
routine).  IA-64 typically uses update_mmu_cache to check for the
defered flush flag (that got set in step 3) to maintain cache coherency
lazily (The local I and D caches on IA-64 are incoherent).  

DavidM suggeested that we would need to add a hook in the function
change_pte_range in mm/mprotect.c  This would let the architecture
specific code to look at the new ptes to decide if it needs to update
any other architectual/kernel state based on the updated (new
permissions) PTE values.

Please let me know your comments.

A prototype patch including the support for IA-64 goes as follows:

--- linux-2.6.10/mm/mprotect.c  2004-12-24 13:35:50.000000000 -0800
+++ linux-2.6.10.work/mm/mprotect.c     2005-03-14 23:51:01.511553704
-0800
@@ -46,14 +46,16 @@
                end = PMD_SIZE;
        do {
                if (pte_present(*pte)) {
-                       pte_t entry;
+                       pte_t entry, nentry;

                        /* Avoid an SMP race with hardware updated
dirty/clean
                         * bits by wiping the pte and then setting the
new pte
                         * into place.
                         */
                        entry = ptep_get_and_clear(pte);
-                       set_pte(pte, pte_modify(entry, newprot));
+                       nentry = pte_modify(entry, newprot);
+                       set_pte(pte, nentry);
+                       lazy_mmu_update(pte, entry, nentry);
                }
                address += PAGE_SIZE;
                pte++;
--- linux-2.6.10/arch/ia64/mm/init.c    2004-12-24 13:34:32.000000000
-0800
+++ linux-2.6.10.work/arch/ia64/mm/init.c       2005-03-15
00:16:21.880422504 -0800
@@ -95,6 +95,11 @@
        set_bit(PG_arch_1, &page->flags);       /* mark page as clean */
 }

+void
+lazy_mmu_update(pte_t *pte, pte_t opte, pte_t npte)
+{
+       update_mmu_cache(NULL, 0, npte);
+}
 inline void
 ia64_set_rbs_bot (void)
 {
