Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUFFVIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUFFVIO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 17:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUFFVIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 17:08:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:35202 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264153AbUFFVIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 17:08:11 -0400
Subject: Re: [BUG] asm-ppc/pgtable.h breakage from 2.6.7-rc1-bk4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <1086554881.1858.3.camel@gaston>
References: <200406061117.i56BH14D025405@harpo.it.uu.se>
	 <1086554881.1858.3.camel@gaston>
Content-Type: text/plain
Message-Id: <1086555953.1873.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 06 Jun 2004 16:05:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 15:48, Benjamin Herrenschmidt wrote:
> Ok, please  tell me if this patch works, I don't have a machine
> to test here. If it's ok, I'll send it to andrew/linus.

Ok, here's one that builds and deals with 4xx and 8xx.

===== include/asm-ppc/pgtable.h 1.33 vs edited =====
--- 1.33/include/asm-ppc/pgtable.h	2004-05-26 09:56:17 -05:00
+++ edited/include/asm-ppc/pgtable.h	2004-06-06 16:02:27 -05:00
@@ -555,8 +555,12 @@
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
 	pte_update(ptep, 0, bits);
 }
+
 #define  ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
-        __ptep_set_access_flags(__ptep, __entry, __dirty)
+	do {								   \
+		__ptep_set_access_flags(__ptep, __entry, __dirty);	   \
+		flush_tlb_page_nohash(__vma, __address);	       	   \
+	} while(0)
 
 /*
  * Macro to mark a page protection value as "uncacheable".
===== arch/ppc/mm/tlb.c 1.10 vs edited =====
--- 1.10/arch/ppc/mm/tlb.c	2004-02-04 23:00:14 -06:00
+++ edited/arch/ppc/mm/tlb.c	2004-06-06 16:01:05 -05:00
@@ -67,6 +67,17 @@
 }
 
 /*
+ * Called by ptep_set_access_flags, must flush on CPUs for which the
+ * DSI handler can't just "fixup" the TLB on a write fault
+ */
+void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr)
+{
+	if (Hash != 0)
+		return;
+	_tlbie(addr);
+}
+
+/*
  * Called at the end of a mmu_gather operation to make sure the
  * TLB flush is completely done.
  */


