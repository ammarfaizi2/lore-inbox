Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264271AbUEXMgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUEXMgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 08:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUEXMgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 08:36:06 -0400
Received: from ozlabs.org ([203.10.76.45]:50599 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264271AbUEXMgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 08:36:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16561.60519.989823.14745@cargo.ozlabs.ibm.com>
Date: Mon, 24 May 2004 22:36:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Don't clear MSR.RI in do_hash_page_DSI
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some code that is used on iSeries (do_hash_page_DSI in head.S) was
clearing the RI (recoverable interrupt) bit in the MSR when it
shouldn't.  We were getting SLB miss interrupts following that which
were panicking because they appeared to have occurred at a bad place.
This patch fixes the problem.

Please apply.

Thanks,
Paul.

diff -puN arch/ppc64/kernel/head.S~ibm-ppc64-hash-page-ri arch/ppc64/kernel/head.S
--- forakpm/arch/ppc64/kernel/head.S~ibm-ppc64-hash-page-ri	2004-05-24 15:14:13.809492931 +1000
+++ forakpm-anton/arch/ppc64/kernel/head.S	2004-05-24 15:14:13.816492844 +1000
@@ -946,7 +946,7 @@ _GLOBAL(do_hash_page_DSI)
 	 */
 	mfmsr	r0
 	li	r4,0
-	ori	r4,r4,MSR_EE+MSR_RI
+	ori	r4,r4,MSR_EE
 	andc	r0,r0,r4
 	mtmsrd	r0			/* Hard Disable, RI off */
 
Signed-off-by: Paul Mackerras <paulus@samba.org>
