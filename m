Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWDZNpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWDZNpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWDZNpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:45:51 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:17972
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932437AbWDZNpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:45:50 -0400
Message-Id: <444F95D8.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 26 Apr 2006 15:46:32 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Keir Fraser" <Keir.Fraser@cl.cam.ac.uk>
Subject: [PATCH] i386: PAE entries must have their low word cleared
	first
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During Xen development we noticed that writes to 64-bit variables may get
coded as high-word-before-low-word writes by gcc. Consequently, when
invalidating a PAE page table entry, the low word must be explicitly written
first, as otherwise, as pointed out by Keir, speculative execution may result
in a partially modified (and still valid) translation to be used, which has,
according to the specification, the potential of dead-locking the machine.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/include/asm-i386/pgtable.h
2.6.17-rc2-i386-pae-ptep_get_and_clear_full/include/asm-i386/pgtable.h
--- /home/jbeulich/tmp/linux-2.6.17-rc2/include/asm-i386/pgtable.h	2006-04-26 10:56:03.000000000 +0200
+++ 2.6.17-rc2-i386-pae-ptep_get_and_clear_full/include/asm-i386/pgtable.h	2006-04-24 12:28:37.000000000 +0200
@@ -268,7 +268,15 @@ static inline pte_t ptep_get_and_clear_f
 	pte_t pte;
 	if (full) {
 		pte = *ptep;
+#ifdef CONFIG_X86_PAE
+		/* Cannot do this in a single step, as the compiler
+		   may issue the two stores in either order. */
+		ptep->pte_low = 0;
+		barrier();
+		ptep->pte_high = 0;
+#else
 		*ptep = __pte(0);
+#endif
 	} else {
 		pte = ptep_get_and_clear(mm, addr, ptep);
 	}


