Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbULNPYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbULNPYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 10:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbULNPYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 10:24:43 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:26566 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261526AbULNPYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 10:24:36 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Anticipatory prefaulting in the page fault handler V1
Date: Wed, 15 Dec 2004 00:25:34 +0900
User-Agent: KMail/1.5.4
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, nickpiggin@yahoo.com.au,
       Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, hugh@veritas.com,
       benh@kernel.crashing.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0412130905140.360@schroedinger.engr.sgi.com> <200412142124.11685.amgta@yacht.ocn.ne.jp>
In-Reply-To: <200412142124.11685.amgta@yacht.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412150025.34368.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 December 2004 21:24, Akinobu Mita wrote:

> But there is not any guarantee that the page_tables for addr+PAGE_SIZE,
> addr+2*PAGE_SIZE, ...  have not been mapped yet.
>
> Anyway, I will try your V2 patch.
>

Below patch fixes V2 patch, and adds debug printk. 
The output coincides with segfaulted processes.

# dmesg | grep ^comm:

comm: xscreensaver, addr_orig: ccdc40, addr: cce000, pid: 2995
comm: rhn-applet-gui, addr_orig: b6fd8020, addr: b6fd9000, pid: 3029
comm: rhn-applet-gui, addr_orig: b6e95020, addr: b6e96000, pid: 3029
comm: rhn-applet-gui, addr_orig: b6fd8020, addr: b6fd9000, pid: 3029
comm: rhn-applet-gui, addr_orig: b6e95020, addr: b6e96000, pid: 3029
comm: rhn-applet-gui, addr_orig: b6fd8020, addr: b6fd9000, pid: 3029
comm: X, addr_orig: 87e8000, addr: 87e9000, pid: 2874
comm: X, addr_orig: 87ea000, addr: 87eb000, pid: 2874

---
The read access prefaulting may override the page_table which has been
already mapped. this patch fixes it. and it shows which process might
suffer this problem.


--- 2.6-rc/mm/memory.c.orig	2004-12-14 22:06:08.000000000 +0900
+++ 2.6-rc/mm/memory.c	2004-12-14 23:42:34.000000000 +0900
@@ -1434,6 +1434,7 @@ do_anonymous_page(struct mm_struct *mm, 
 {
 	pte_t entry;
  	unsigned long end_addr;
+ 	unsigned long addr_orig = addr;
 
 	addr &= PAGE_MASK;
 
@@ -1517,9 +1518,15 @@ do_anonymous_page(struct mm_struct *mm, 
  		/* Read */
 		entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
 nextread:
-		set_pte(page_table, entry);
-		pte_unmap(page_table);
-		update_mmu_cache(vma, addr, entry);
+		if (!pte_none(*page_table)) {
+			printk("comm: %s, addr_orig: %lx, addr: %lx, pid: %d\n",
+				current->comm, addr_orig, addr, current->pid);
+			pte_unmap(page_table);
+		} else {
+			set_pte(page_table, entry);
+			pte_unmap(page_table);
+			update_mmu_cache(vma, addr, entry);
+		}
 		addr += PAGE_SIZE;
 		if (unlikely(addr < end_addr)) {
 			pte_offset_map(pmd, addr);


