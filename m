Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUJWHup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUJWHup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 03:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUJWHup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 03:50:45 -0400
Received: from ozlabs.org ([203.10.76.45]:37828 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265161AbUJWHun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 03:50:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16762.3100.466586.570562@cargo.ozlabs.ibm.com>
Date: Sat, 23 Oct 2004 17:45:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: John Rose <johnrose@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64 __ioremap_explicit() criterion change
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from John Rose <johnrose@austin.ibm.com>.

The function __ioremap_explicit() misses a possible (obscure) case when
reserving the imalloc area for the new region.	This can result in the
unexpected DLPAR-add failure for an I/O slot.  The failure will be
characterized by a kernel message resembling "could not obtain imalloc area for
ea 0x..." Here's an explanation:

At boot time, imalloc regions are created for the ranges of all PHBs.  Upon 
removal of a child slot for one of these PHBs, the imalloc region is split
so that the region for the child slot can be removed.

A GFW testcase revealed the following scenario.  A PHB is remapped at boot for
virtual address range A through C.  At boot, the partition owns a slot that
spans from A to B.  This slot is DLPAR-removed, leaving an imalloc region from
B to C.  At this point, the user DLPAR adds an EADS slot that was not present
at boot, but is a child of the PHB.  The new slot happens to have a range that
directly matches the leftover PHB range, from B to C.  The existing code does
not expect this, so the operation fails.  

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/mm/init.c test/arch/ppc64/mm/init.c
--- linux-2.5/arch/ppc64/mm/init.c	2004-10-23 10:11:40.000000000 +1000
+++ test/arch/ppc64/mm/init.c	2004-10-23 16:49:48.102068672 +1000
@@ -263,7 +263,8 @@
 		 */
 		;
 	} else {
-		area = im_get_area(ea, size, IM_REGION_UNUSED|IM_REGION_SUBSET);
+		area = im_get_area(ea, size,
+			IM_REGION_UNUSED|IM_REGION_SUBSET|IM_REGION_EXISTS);
 		if (area == NULL) {
 			/* Expected when PHB-dlpar is in play */
 			return 1;
