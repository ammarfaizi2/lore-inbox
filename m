Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbVJLTmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVJLTmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVJLTmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:42:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50157 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751314AbVJLTmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:42:04 -0400
Date: Wed, 12 Oct 2005 14:41:41 -0500
From: Robin Holt <holt@sgi.com>
To: linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, jgarzik@pobox.com,
       wli@holomorphy.com
Subject: [Patch 1/2] Add a NOPAGE_FAULTED flag.
Message-ID: <20051012194141.GF17458@lnx-holt.americas.sgi.com>
References: <20051012194022.GE17458@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051012194022.GE17458@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce a NOPAGE_FAULTED flag.  This flag is returned from a drivers
nopage handler to indicate the desired pte has been inserted and should
be handled as a minor fault.

Signed-off-by: holt@sgi.com


Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h	2005-10-11 21:15:45.147011169 -0500
+++ linux-2.6/include/linux/mm.h	2005-10-11 21:17:15.814561844 -0500
@@ -619,6 +619,7 @@ static inline int page_mapped(struct pag
  */
 #define NOPAGE_SIGBUS	(NULL)
 #define NOPAGE_OOM	((struct page *) (-1))
+#define NOPAGE_FAULTED	((struct page *) (-2))
 
 /*
  * Different kinds of faults, as returned by handle_mm_fault().
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2005-10-11 21:15:45.162634582 -0500
+++ linux-2.6/mm/memory.c	2005-10-11 21:17:15.849714525 -0500
@@ -1862,6 +1862,14 @@ retry:
 		return VM_FAULT_SIGBUS;
 	if (new_page == NOPAGE_OOM)
 		return VM_FAULT_OOM;
+	if (new_page == NOPAGE_FAULTED) {
+		spin_lock(&mm->page_table_lock);
+		page_table = pte_offset_map(pmd, address);
+		pte_unmap(page_table);
+		spin_unlock(&mm->page_table_lock);
+
+		return VM_FAULT_MINOR;
+	}
 
 	/*
 	 * Should we do an early C-O-W break?
