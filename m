Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265541AbUF2Ify@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265541AbUF2Ify (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 04:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUF2Ify
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 04:35:54 -0400
Received: from ozlabs.org ([203.10.76.45]:47531 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265541AbUF2Ifw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 04:35:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16609.10732.623109.866800@cargo.ozlabs.ibm.com>
Date: Tue, 29 Jun 2004 18:35:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Fix memset
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in the ppc64 memset where the code that gets
the destination address aligned (or is supposed to) was looking at the
bottom 3 bits of the count rather than the destination address.  The
result of this was that the kernel wouldn't boot on POWER3 machines.
The patch also removes an unnecessary duplicate instruction.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/lib/string.S ppc64-2.5-pseries/arch/ppc64/lib/string.S
--- linux-2.5/arch/ppc64/lib/string.S	2004-06-25 07:03:03.000000000 +1000
+++ ppc64-2.5-pseries/arch/ppc64/lib/string.S	2004-06-29 16:26:13.000000000 +1000
@@ -66,13 +66,12 @@
 	blr
 
 _GLOBAL(memset)
-	neg	r0,r5
+	neg	r0,r3
 	rlwimi	r4,r4,8,16,23
 	andi.	r0,r0,7			/* # bytes to be 8-byte aligned */
 	rlwimi	r4,r4,16,0,15
 	cmplw	cr1,r5,r0		/* do we get that far? */
 	rldimi	r4,r4,32,0
-	mr	r6,r3
 	mtcrf	1,r0
 	mr	r6,r3
 	blt	cr1,8f
