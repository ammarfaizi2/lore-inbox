Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUC2I41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUC2I4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:56:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:54162 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262768AbUC2I4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:56:17 -0500
Subject: [PATCH] ppc64: syscall error test incorrect for 64 bits results
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080550559.1385.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 18:56:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The syscall return path on ppc64 checks if the error is between
-LAST_ERRNO and 0, if it is, does the usual inversion along with
setting a CR bit indicating to glibc that an error occured.

However, we had an interesting bug where we used a 32 bits logica
(unsigned) comparison, thus possibly doing false positives for
valid 64 bits unsigned values whose low 32 bits happen to be in
the error range.

This patch fixes that.

===== arch/ppc64/kernel/entry.S 1.32 vs edited =====
--- 1.32/arch/ppc64/kernel/entry.S	Fri Mar 19 16:59:29 2004
+++ edited/arch/ppc64/kernel/entry.S	Fri Mar 26 17:56:07 2004
@@ -139,7 +139,7 @@
 91:
 #endif
 	li	r10,-_LAST_ERRNO
-	cmpl	0,r3,r10
+	cmpld	0,r3,r10
 	blt	30f
 	neg	r3,r3
 22:	ld	r10,_CCR(r1)	/* Set SO bit in CR */


