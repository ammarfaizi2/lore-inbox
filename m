Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbQJ3VcB>; Mon, 30 Oct 2000 16:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQJ3Vbv>; Mon, 30 Oct 2000 16:31:51 -0500
Received: from e24.nc.us.ibm.com ([32.97.136.230]:48800 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129078AbQJ3Vbd>; Mon, 30 Oct 2000 16:31:33 -0500
Importance: Normal
Subject: [PATCH] 2.4.0-test10-pre6  TLB flush race in establish_pte
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, linux-mm@kvack.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFB4731A18.0D8D8BC1-ON85256988.0074562B@raleigh.ibm.com>
From: "Steve Pratt/Austin/IBM" <slpratt@us.ibm.com>
Date: Mon, 30 Oct 2000 15:31:22 -0600
X-MIMETrack: Serialize by Router on D04NM107/04/M/IBM(Release 5.0.3 (Intl)|21 March 2000) at
 10/30/2000 04:31:23 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in April there were discussions about the race in establish_pte with
the flush_tlb before the set_pte.  Many options were discussed, but due in
part to a concern about S/390 having introduced the code, no patch ever
appeared.  I talked with Martin Schwidefsky of the S/390 Linux development
team and he said that:

>the establish_pte was in fact introduced because of Linux/390. We wanted
to use the special S/390 instruction ipte (invalidate page >table entry).
In the meantime we found out that we need a lot more changes to be able to
use this instruction, so we disabled it again. >Until we have a proper
patch you should revoke the establish_pte change if you found it to be
faulty. I too think there is a race >condition.

So while there may be a more elegant solution down the road, I would like
to see the simple fix put back into 2.4.  Here is the patch to essential
put the code back to the way it was before the S/390 merge.  Patch is
against 2.4.0-test10pre6.

--- linux/mm/memory.c    Fri Oct 27 15:26:14 2000
+++ linux-2.4.0-test10patch/mm/memory.c  Fri Oct 27 15:45:54 2000
@@ -781,8 +781,8 @@
  */
 static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
 {
-    flush_tlb_page(vma, address);
     set_pte(page_table, entry);
+    flush_tlb_page(vma, address);
     update_mmu_cache(vma, address, entry);
 }




Linux Technology Center - IBM Corporation
11400 Burnet Road
Austin, TX  78758
(512) 838-9763  EMAIL: SLPratt@US.IBM.COM

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
