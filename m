Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbULMOaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbULMOaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbULMO3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:29:50 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:61680 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261160AbULMO3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:29:32 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Christoph Lameter <clameter@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Anticipatory prefaulting in the page fault handler V1
Date: Mon, 13 Dec 2004 23:30:23 +0900
User-Agent: KMail/1.5.4
Cc: nickpiggin@yahoo.com.au, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <156610000.1102546207@flay> <Pine.LNX.4.58.0412091130160.796@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0412091130160.796@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412132330.23893.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 December 2004 04:32, Christoph Lameter wrote:
> On Wed, 8 Dec 2004, Martin J. Bligh wrote:
> > I tried benchmarking it ... but processes just segfault all the time.
> > Any chance you could try it out on SMP ia32 system?
>
> I tried it on my i386 system and it works fine. Sorry about the puny
> memory sizes (the system is a PIII-450 with 384k memory)
>

I also encountered processes segfault.
Below patch fix several problems.

1) if no pages could allocated, returns VM_FAULT_OOM
2) fix duplicated pte_offset_map() call
3) don't set_pte() for the entry which already have been set

Acutually, 3) fixes my segfault problem.

--- 2.6-rc/mm/memory.c.orig	2004-12-13 22:17:04.000000000 +0900
+++ 2.6-rc/mm/memory.c	2004-12-13 22:22:14.000000000 +0900
@@ -1483,6 +1483,8 @@ do_anonymous_page(struct mm_struct *mm, 
 				} else
 					break;
 			}
+			if (a == addr)
+				goto no_mem;
 			end_addr = a;
 
 			spin_lock(&mm->page_table_lock);
@@ -1514,8 +1516,17 @@ do_anonymous_page(struct mm_struct *mm, 
 			}
  		} else {
  			/* Read */
+			int first = 1;
+
  			for(;addr < end_addr; addr += PAGE_SIZE) {
-				page_table = pte_offset_map(pmd, addr);
+				if (!first)
+					page_table = pte_offset_map(pmd, addr);
+				first = 0;
+				if (!pte_none(*page_table)) {
+					/* Someone else got there first */
+					pte_unmap(page_table);
+					continue;
+				}
  				entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
 				set_pte(page_table, entry);
 				pte_unmap(page_table);


