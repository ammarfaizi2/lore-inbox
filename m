Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbULIOdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbULIOdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbULIOdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:33:51 -0500
Received: from ozlabs.org ([203.10.76.45]:12001 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261470AbULIOds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:33:48 -0500
Date: Fri, 10 Dec 2004 01:34:28 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: willschm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: Correct alignment for lppaca in paca_struct
Message-ID: <20041209143428.GA24640@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

I think this is 2.6.10 material, as well as lparcfg it fixes a nasty 
bug in our shared processor support (some cpus fail to recognise they
are in shared processor mode).

Anton

--

From: Will Schmidt <willschm@us.ibm.com>

We found that we were failing register_vpa calls in cases where the lppaca
structure (part of the PACA) crosses a page boundary.

This was causing us (lparcfg specifically) some grief as the xSharedProc bit 
was not being set.

The attached patch changes the alignment of the lppaca structure, and a few 
comments so we understand why.

Signed-off-by: Will Schmidt <willschm@us.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>

--- a/include/asm-ppc64/paca.h	2004-12-03 13:03:09.048520608 -0600
+++ b/include/asm-ppc64/paca.h	2004-12-03 13:18:17.433655752 -0600
@@ -99,11 +99,13 @@
 	u64 exdsi[8];		/* used for linear mapping hash table misses 
 	*/

 	/*
-	 * iSeries structues which the hypervisor knows about - Not
-	 * sure if these particularly need to be cacheline aligned.
+	 * iSeries structues which the hypervisor knows about -
+	 * This structure should not cross a page boundary.
+	 * The vpa_init/register_vpa call is now known to fail if the lppaca
+	 * structure crosses a page boundary.
 	 * The lppaca is also used on POWER5 pSeries boxes.
 	 */
-	struct ItLpPaca lppaca __attribute__((aligned(0x80)));
+	struct ItLpPaca lppaca __attribute__((aligned(0x400)));
 #ifdef CONFIG_PPC_ISERIES
 	struct ItLpRegSave reg_save;
 #endif

