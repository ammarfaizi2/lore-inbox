Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbULNQev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbULNQev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULNQev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:34:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46801 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261544AbULNQer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:34:47 -0500
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV accidental TLB entry write-protect fix
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Tue, 14 Dec 2004 16:34:34 +0000
Message-ID: <9816.1103042074@redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch stops the FRV kernel-instruction-TLB-miss handler from
setting the write-protect bit on a mapping entry when punting an entry from
the mapping fast cache registers (DAMR1/IAMR1) to the TLB.

This patch derives the WP value from the DAMPR1 register (which actually has
a WP bit) rather than the IAMPR1 register (which does not).

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-nowp-2610rc3.diff 
 tlb-miss.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -uNr linux-2.6.10-rc3-mm1-mmcleanup/arch/frv/mm/tlb-miss.S linux-2.6.10-rc3-mm1-misc/arch/frv/mm/tlb-miss.S
--- linux-2.6.10-rc3-mm1-mmcleanup/arch/frv/mm/tlb-miss.S	2004-12-13 17:33:50.000000000 +0000
+++ linux-2.6.10-rc3-mm1-misc/arch/frv/mm/tlb-miss.S	2004-12-13 19:28:21.000000000 +0000
@@ -184,8 +184,8 @@
 	movgs		gr31,tplr			/* set TPLR.CXN */
 	tlbpr		gr31,gr0,#4,#0			/* delete matches from TLB, IAMR1, DAMR1 */
 
-	movsg		iampr1,gr31
-	ori		gr31,#xAMPRx_V|DAMPRx_WP,gr31	/* entry was invalidated by tlbpr #4 */
+	movsg		dampr1,gr31
+	ori		gr31,#xAMPRx_V,gr31		/* entry was invalidated by tlbpr #4 */
 	movgs		gr31,tppr
 	movsg		iamlr1,gr31			/* set TPLR.CXN */
 	movgs		gr31,tplr
