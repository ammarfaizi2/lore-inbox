Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265622AbUFDFj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUFDFj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbUFDFjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:39:55 -0400
Received: from ozlabs.org ([203.10.76.45]:7620 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265622AbUFDFjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:39:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16576.2887.362473.586007@cargo.ozlabs.ibm.com>
Date: Fri, 4 Jun 2004 15:40:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Don't clear MSR.RI in do_hash_page_DSI
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some code that is used on iSeries (do_hash_page_DSI in head.S) was
clearing the RI (recoverable interrupt) bit in the MSR when it
shouldn't.  We were getting SLB miss interrupts following that which
were panicking because they appeared to have occurred at a bad place.
This patch fixes the problem.  In fact it isn't necessary for
do_hash_page_DSI to do anything to RI, so the patch changes the code
to not set or clear it.

Signed-off-by: Paul Mackerras <paulus@samba.org>

Please apply.

Thanks,
Paul.
diff -urN linux-2.5/arch/ppc64/kernel/head.S test25/arch/ppc64/kernel/head.S
--- linux-2.5/arch/ppc64/kernel/head.S	2004-06-04 07:19:00.000000000 +1000
+++ test25/arch/ppc64/kernel/head.S	2004-06-04 15:31:30.744946352 +1000
@@ -926,8 +926,8 @@
 	stb	r0,PACAPROCENABLED(r20)	/* Soft Disabled */
 
 	mfmsr	r0
-	ori	r0,r0,MSR_EE+MSR_RI
-	mtmsrd	r0			/* Hard Enable, RI on */
+	ori	r0,r0,MSR_EE
+	mtmsrd	r0,1			/* Hard Enable */
 #endif
 
 	/*
@@ -946,9 +946,9 @@
 	 */
 	mfmsr	r0
 	li	r4,0
-	ori	r4,r4,MSR_EE+MSR_RI
+	ori	r4,r4,MSR_EE
 	andc	r0,r0,r4
-	mtmsrd	r0			/* Hard Disable, RI off */
+	mtmsrd	r0,1			/* Hard Disable */
 
 	ld	r0,SOFTE(r1)
 	cmpdi	0,r0,0			/* See if we will soft enable in */

