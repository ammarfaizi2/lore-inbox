Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbTDDRor (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbTDDRoe (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:44:34 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:21569 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263808AbTDDQ2V (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 11:28:21 -0500
Date: Fri, 4 Apr 2003 17:41:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Dave McCracken <dmccr@us.ibm.com>, Pete Zaitcev <zaitcev@redhat.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH] tweaks for page_convert_anon
Message-ID: <Pine.LNX.4.44.0304041735150.1980-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of small additions on top of Dave's objfix-2.5.66-mm3-3:

To maintain an accurate nr_mapped, page_remove_rmap must check
page_mapped with pte_chain_lock held, both at end and at start:
particularly now it's being called speculatively (in ignorance
of whether this pte is already listed or not).

Coincidentally, Pete Zaitcev's "gcc 3.2 breaks rmap on s390x" problem
reported yesterday would also be corrected by this, though it doesn't
fix the root of the problem (no barrier in pte_chain_lock on s390x).

Also, page_convert_anon remember pte_unmap after successful find_pte.

Hugh

--- 2.5.66-mm3-3/mm/rmap.c	Fri Apr  4 12:20:40 2003
+++ linux/mm/rmap.c	Fri Apr  4 16:13:42 2003
@@ -398,10 +398,10 @@
 		BUG();
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
-	if (!page_mapped(page))
-		return;		/* remap_page_range() from a driver? */
 
 	pte_chain_lock(page);
+	if (!page_mapped(page))
+		goto outer;
 
 	/*
 	 * If this is an object-based page, just uncount it.  We can
@@ -461,10 +461,10 @@
 		}
 	}
 out:
-	pte_chain_unlock(page);
 	if (!page_mapped(page))
 		dec_page_state(nr_mapped);
-	return;
+outer:
+	pte_chain_unlock(page);
 }
 
 /**
@@ -831,6 +831,7 @@
 			/* Make sure this isn't a duplicate */
 			page_remove_rmap(page, pte);
 			pte_chain = page_add_rmap(page, pte, pte_chain);
+			pte_unmap(pte);
 		}
 		spin_unlock(&vma->vm_mm->page_table_lock);
 	}
@@ -850,6 +851,7 @@
 			/* Make sure this isn't a duplicate */
 			page_remove_rmap(page, pte);
 			pte_chain = page_add_rmap(page, pte, pte_chain);
+			pte_unmap(pte);
 		}
 		spin_unlock(&vma->vm_mm->page_table_lock);
 	}

