Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264086AbTEaAWR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 20:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTEaAWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 20:22:17 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:49379 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264086AbTEaAWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 20:22:16 -0400
Date: Fri, 30 May 2003 16:34:15 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, hch@infradead.org
Subject: [PATCH] vm_operation to avoid pagefault/inval race
Message-ID: <20030530163415.A26729@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rediffed to 2.5.70-mm2.

This patch provides one way for a distributed filesystem to avoid
the pagefault/cross-node-invalidation race described in:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=105286345316249&w=2

The advantage of this patch is that it is quite small and quite well
tested.  A different approach follows in a separate message.

						Thanx, Paul

diff -urN -X dontdiff linux-2.5.70-mm2/include/linux/mm.h linux-2.5.70-mm2.nopagedone/include/linux/mm.h
--- linux-2.5.70-mm2/include/linux/mm.h	Fri May 30 14:51:05 2003
+++ linux-2.5.70-mm2.nopagedone/include/linux/mm.h	Fri May 30 15:11:24 2003
@@ -143,6 +143,7 @@
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int unused);
+	void (*nopagedone)(struct vm_area_struct * area, unsigned long address, int status);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 };
 
diff -urN -X dontdiff linux-2.5.70-mm2/mm/memory.c linux-2.5.70-mm2.nopagedone/mm/memory.c
--- linux-2.5.70-mm2/mm/memory.c	Fri May 30 14:51:06 2003
+++ linux-2.5.70-mm2.nopagedone/mm/memory.c	Fri May 30 15:11:24 2003
@@ -1468,6 +1468,9 @@
 	ret = VM_FAULT_OOM;
 out:
 	pte_chain_free(pte_chain);
+	if (vma->vm_ops && vma->vm_ops->nopagedone) {
+		vma->vm_ops->nopagedone(vma, address & PAGE_MASK, ret);
+	}
 	return ret;
 }
 
