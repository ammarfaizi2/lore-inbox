Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVCWAJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVCWAJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVCWAJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:09:13 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:34001
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261384AbVCWAFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:05:53 -0500
Date: Tue, 22 Mar 2005 16:03:57 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: hugh@veritas.com, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322160357.32e830c5.davem@davemloft.net>
In-Reply-To: <4240AAFA.1040206@yahoo.com.au>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050322034053.311b10e6.akpm@osdl.org>
	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
	<20050322110144.3a3002d9.davem@davemloft.net>
	<20050322112125.0330c4ee.davem@davemloft.net>
	<20050322112329.70bde057.davem@davemloft.net>
	<Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
	<20050322123301.090cbfa6.davem@davemloft.net>
	<Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>
	<4240AAFA.1040206@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this patch, on top of Hugh's original freepgt patch, gets
me a working system.  It includes Hugh's bug fix, plus the
ceiling masking roll-over fix of mine.

It should get ppc working too, I bet.

--- mm/memory.c.hugh	2005-03-22 16:01:07.000000000 -0800
+++ mm/memory.c	2005-03-22 16:00:08.000000000 -0800
@@ -127,11 +127,6 @@
 	unsigned long next;
 	unsigned long start;
 
-	if (end - 1 > ceiling - 1)
-		end -= PMD_SIZE;
-	if (addr > end - 1)
-		return;
-
 	start = addr;
 	pmd = pmd_offset(pud, addr);
 	do {
@@ -144,7 +139,11 @@
 	start &= PUD_MASK;
 	if (start < floor)
 		return;
-	ceiling &= PUD_MASK;
+	if (ceiling) {
+		ceiling &= PUD_MASK;
+		if (!ceiling)
+			return;
+	}
 	if (end - 1 > ceiling - 1)
 		return;
 
@@ -173,7 +172,11 @@
 	start &= PGDIR_MASK;
 	if (start < floor)
 		return;
-	ceiling &= PGDIR_MASK;
+	if (ceiling) {
+		ceiling &= PGDIR_MASK;
+		if (!ceiling)
+			return;
+	}
 	if (end - 1 > ceiling - 1)
 		return;
 
@@ -201,8 +204,14 @@
 		if (!addr)
 			return;
 	}
-	ceiling &= PMD_MASK;
-	if (addr > ceiling - 1)
+	if (ceiling) {
+		ceiling &= PMD_MASK;
+		if (!ceiling)
+			return;
+	}
+	if (end - 1 > ceiling - 1)
+		end -= PMD_SIZE;
+	if (addr > end - 1)
 		return;
 
 	start = addr;
@@ -214,7 +223,7 @@
 		free_pud_range(tlb, pgd, addr, next, floor, ceiling);
 	} while (pgd++, addr = next, addr != end);
 
-	if (!tlb_is_full_mm(tlb) && start < end)
+	if (!tlb_is_full_mm(tlb))
 		flush_tlb_pgtables(tlb->mm, start, end);
 }
 
