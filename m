Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTDCR7f 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S262577AbTDCR7f 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:59:35 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:49463 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262291AbTDCR70 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:59:26 -0500
Date: Thu, 3 Apr 2003 13:10:54 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: riel@redhat.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, linux390@de.ibm.com
Subject: gcc-3.2 breaks rmap on s390x
Message-ID: <20030403131054.B25676@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rik:

the following patch seems to fix my rmap problems on s390x.

--- linux-2.4.20-2.1.24.z1/include/linux/mm.h	2003-03-27 21:30:09.000000000 -0500
+++ linux-2.4.20-2.1.24.z2/include/linux/mm.h	2003-04-02 20:26:11.000000000 -0500
@@ -376,8 +376,10 @@
 	 */
 #ifdef CONFIG_SMP
 	while (test_and_set_bit(PG_chainlock, &page->flags)) {
-		while (test_bit(PG_chainlock, &page->flags))
+		while (test_bit(PG_chainlock, &page->flags)) {
 			cpu_relax();
+			barrier();
+		}
 	}
 #endif
 }

The failure happens in page_remove_rmap. It runs like so:

        if (!page_mapped(page))    // (page->pte.direct!=0)
                return;         /* remap_page_range() from a driver? */
        pte_chain_lock(page);
        if (PageDirect(page)) {
                if (page->pte.direct == pte_paddr) {

The pte_chain_lock loop is in the patch above.
The compiler loads page->pte.direct into a register when
page_mapped() is tested, and uses it in if statement
across pte_chain_lock().

Andrew Morton observed that bitops on s390(x) do not clobber
memory. I saw it too, but I thought it was legal. A bitop
changes a word in a specific location. I think it just does
not sound right to trash an optimization because of that.

As an example, sparc(32) has a mix of bitops implemented in C
and bitops implemented in assembly. C bitops do not clobber
memory wholesale. Of asm bitops, only test_and_set_bit
clobbers memory (I have to ask Dave why).

Cheers,
-- Pete
